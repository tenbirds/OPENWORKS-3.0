package zes.openworks.web.before;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibm.icu.util.Calendar;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.alarm.AlarmService;
import zes.openworks.web.alarm.AlarmVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.suplerCeart.SuplerCeartService;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaas2VO;
import zes.openworks.web.wish.myWish.MyWishService;
import zes.openworks.web.wish.myWish.MyWishVO;
/**
 *
 * @Class Name : WikiController
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 * @Description : 씨앗마켓 위키 공통 Controller
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일                 수정자                수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = "/**/before")
public class BeforeController extends GeneralController {
    @Autowired
    private RegisterService registerService;
    
    @Autowired
    BeforeService service;

    @Autowired
    MyWishService myWishService;

    @Autowired
    MyCeartService myCeartService;

    @Autowired
    AlarmService alarmService;
    
    @Autowired
    private AutoMailService amservice;
    
    @Autowired
    private SmsTransHistService smsService;
    
    @Autowired
    private SuplerCeartService suplerCeartService; 

    /** 파일 저장 경로 */
    public static final String BEFORE_NOTIFY_PATH = "before" + File.separator;
    
    
    
    /*************************************************************************************************/    
    

    /*
     * SaaS 상세정보(사전 견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_beforeRequestSaas.do",  method = RequestMethod.POST)
    public String BD_beforeRequestSaas(HttpServletRequest request, ModelMap model, MyWishVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        

        // 선택된 서비스만 사전견적 요청 
        String chkGoodsCode = vo.getGoodsCd2();
        String[] goodsCodeList = chkGoodsCode.split("\\|");
        if(!goodsCodeList.equals("")){
            List<String> goodsList = new ArrayList<String>();
            for(int i=0; i<goodsCodeList.length; i++){
                goodsList.add(i, goodsCodeList[i]);
            }
            vo.setGoodsCodeList(goodsList);    
        }
        
        model.addAttribute("q_userId",    vo.getUserId());
        model.addAttribute("p_grpSeq",    vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd", vo.getGoodsTyCd());
        
        model.addAttribute("supplyMethodCodeList",    registerService.prvCodeList(vo.getLangCode(), 2042)); // 공통코드의 제공방법코드(2042)
        model.addAttribute("totUnitCodeList",         registerService.prvCodeList(vo.getLangCode(), 2041)); // 공통코드의 전체단위코드(2041)
        model.addAttribute("userManagerSeparateList", registerService.prvCodeList(vo.getLangCode(), 2061)); // 공통코드의 사용자/관리자분리코드(2061)
        model.addAttribute("serviceSupplyMethodList", registerService.prvCodeList(vo.getLangCode(), 2062)); // 공통코드의 서비스제공방식코드(2062)
        model.addAttribute("encryptionList",          registerService.prvCodeList(vo.getLangCode(), 2063)); // 공통코드의 암호화코드(2063)
        
        model.addAttribute("p_chkGoodsCode", vo.getGoodsCd2());

        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishStoreList(vo)); //사전견적서비스목록

        return "/korean/pt/before/BD_requestSaas2.form";
    }

    /*
     * 상세정보(사전 견적) 요청서 발송 - SaaS
     * */
    @RequestMapping(value = "/ND_beforeRequestSaasAction.do", method = RequestMethod.POST)
    public String ND_beforeRequestSaasAction(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforeSaasInfoVO beforeSaasInfoVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestIaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();


            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004)
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (SaaS) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals("")){
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (SaaS) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){

                // 알림                
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);
             
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail());      // 수신이메일주소
                    autoMap.put("senderName", "ceartMarket");                       // 발신자명
                    
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
              
             }
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // SaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforeSaasInfoVO, request);
            beforeSaasInfoVO.setNotifyNum(notifyNum); // 공고번호
            beforeSaasInfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 SaaS 정보 등록
            service.insertBeforeSaasAction(beforeSaasInfoVO);

            String[] optionNm   = request.getParameterValues("optionNm");
            String[] unitItem   = request.getParameterValues("unitItem");
            String[] captyItem  = request.getParameterValues("captyItem");
            String[] amountItem = request.getParameterValues("amountItem");
            String[] cmntItem   = request.getParameterValues("cmntItem");
            
            // Saas 상세정보가 없을 경우 skip
            if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                
            }else{
                for(int i=0; i<optionNm.length; i++){
                    
                    HashMap<String, Object> paramMap = new HashMap<String, Object>();
                    paramMap.put("notifyNum",   notifyNum);
                    paramMap.put("notifySeq",   notifySeq);
                    paramMap.put("userId",      userLoginVO.getUserId());
                    paramMap.put("optionNm",    optionNm[i]);
                    paramMap.put("unitItem",    unitItem[i]);
                    paramMap.put("captyItem",   captyItem[i]);
                    paramMap.put("amountItem",  amountItem[i]);
                    paramMap.put("cmntItem",    cmntItem[i]);

                    // 입찰공고 SaaS 상세정보 등록
                    service.insertBeforeSaasDetailAction(paramMap);
                }                
            }

        }else{
            return alertAndRedirect(model, "견적 요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_beforeRequestSaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
       /* HashMap paramMap = new HashMap();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);
       */
        return alertAndRedirect(model, "견적 요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }
    

    /*
     * 상세정보(사전 견적) 요청서 발송 - SaaS2
     * */
    @RequestMapping(value = "/ND_beforeRequestSaas2Action.do", method = RequestMethod.POST)
    public String ND_beforeRequestSaas2Action(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforeSaas2InfoVO beforeSaas2InfoVO) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestIaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
//            tcnBeforeNotifyVO.setRealDmndBuseoCd(userLoginVO.getBuseoCode());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();


            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004)
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (SaaS2) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals("")){
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (SaaS2) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){

                // 알림                
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);
             
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail());      // 수신이메일주소
                    autoMap.put("senderName", "ceartMarket");                       // 발신자명
                    
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
              
             }
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            
            // SaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforeSaas2InfoVO, request);
            beforeSaas2InfoVO.setNotifyNum(notifyNum); // 공고번호
            beforeSaas2InfoVO.setNotifySeq(notifySeq); // 공고차수

            // 입찰공고 SaaS2 정보 등록
            service.insertBeforeSaas2Action(beforeSaas2InfoVO);
            
            String[] functionName1 = request.getParameterValues("functionName1");
            String[] amount1       = request.getParameterValues("amount1");
            String[] unitCode1     = request.getParameterValues("unitCode1");
            String[] hidenOptions1 = request.getParameterValues("hidenOptions1");
            
            if  (functionName1 != null)
            {
                // Saas2 필요정보가 없을 경우 skip
                if (functionName1.length == 1 && "".equals(functionName1[0])) // 1건이 있어도 기능명이 없다면..
                {                
                }
                else
                {
                    for(int i=0; i<functionName1.length; i++)
                    {                    
                        HashMap<String,Object> paramMap1 = new HashMap<String,Object>();
                        paramMap1.put("notifyNum",    notifyNum);
                        paramMap1.put("notifySeq",    notifySeq);
                        paramMap1.put("userId",       userLoginVO.getUserId());
                        paramMap1.put("functionName", functionName1[i]);
                        paramMap1.put("amount",       amount1[i]);
                        paramMap1.put("unitCode",     unitCode1[i]);
    
                        // SaaS2 필요기능정보 등록
                        service.insertBeforeSaas2NeedAction(i,paramMap1);
                        
                        // 필요옵션저장을 위한 일련번호(NEED_SEQ)를 구한다.
                        int needSeq = service.selectBeforeSaas2NeedSeq(paramMap1);  
                        
                        if  (!"".equals(hidenOptions1[i])) // 옵션사항이 비어 있는지 체크한다.
                        {
                            String[] optionList = hidenOptions1[i].split("\\^");
                            
                            for(int j=0; j<optionList.length; j++)
                            {
                                String[] options = optionList[j].split("\\|");
                                
                                HashMap<String,Object> paramMap2 = new HashMap<String,Object>();
                                paramMap2.put("notifyNum",    notifyNum);
                                paramMap2.put("notifySeq",    notifySeq);
                                paramMap2.put("userId",       userLoginVO.getUserId());
                                paramMap2.put("needSeq",      needSeq);
                                
                                for(int k=0; k<options.length; k++)
                                {
                                    if (k==0) paramMap2.put("functionName", options[k]);
                                    if (k==1) paramMap2.put("amount",       options[k]);
                                    if (k==2) paramMap2.put("unitCode",     options[k]);
                                }
                                
                                // SaaS2 필요옵션기능정보 등록
                                service.insertBeforeSaas2OptionAction(i,j,paramMap2);
                            }
                        }
                    }                
                }
            }
        }
        else
        {
            return alertAndRedirect(model, "견적 요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_beforeRequestSaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);
       
        return alertAndRedirect(model, "견적 요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }
    
    
    /*
     * Iaas 상세정보(사전 견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_beforeRequestIaas.do",  method = RequestMethod.POST)
    public String BD_beforeRequestIaas(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        // 선택된 서비스만 사전견적 요청 
        String chkGoodsCode = vo.getGoodsCd2();
        String[] goodsCodeList = chkGoodsCode.split("\\|");
        if(!goodsCodeList.equals(""))
        {
            List<String> goodsList = new ArrayList<String>();
            for(int i=0; i<goodsCodeList.length; i++){
                goodsList.add(i, goodsCodeList[i]);
            }
            vo.setGoodsCodeList(goodsList);    
        }
        
        model.addAttribute("q_userId",       vo.getUserId());
        model.addAttribute("p_grpSeq",       vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd",    vo.getGoodsTyCd());
        model.addAttribute("p_chkGoodsCode", vo.getGoodsCd2()); // 선택된 서비스(제품)코드
        
        model.addAttribute("webGoodsKindList", registerService.prvCodeList(vo.getLangCode(), 2074)); // 공통코드의 웹방화벽 상품유형코드(2074)
        
        
        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishStoreList(vo)); //사전견적서비스목록

        return "/korean/pt/before/BD_requestIaas2.form";
    }

    /*
     * Iaas 상세정보(사전 견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_beforeRequestScs.do",  method = RequestMethod.POST)
    public String BD_beforeRequestScs(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        // 선택된 서비스만 사전견적 요청 
        String chkGoodsCode = vo.getGoodsCd2();
        String[] goodsCodeList = chkGoodsCode.split("\\|");
        if(!goodsCodeList.equals(""))
        {
            List<String> goodsList = new ArrayList<String>();
            for(int i=0; i<goodsCodeList.length; i++){
                goodsList.add(i, goodsCodeList[i]);
            }
            vo.setGoodsCodeList(goodsList);    
        }
        
        model.addAttribute("q_userId",       vo.getUserId());
        model.addAttribute("p_grpSeq",       vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd",    vo.getGoodsTyCd());
        model.addAttribute("p_chkGoodsCode", vo.getGoodsCd2()); // 선택된 서비스(제품)코드
        
        
        model.addAttribute("cnslRelmList",  registerService.prvCodeList(vo.getLangCode(), 2082)); // 공통코드의 컨설팅 영역(2082)
        model.addAttribute("cnslScopeList", registerService.prvCodeList(vo.getLangCode(), 2083)); // 공통코드의 컨설팅 범위(2083)
        model.addAttribute("excAreaList",   registerService.prvCodeList(vo.getLangCode(), 2036)); // 지역코드(2036)
        
        
        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishStoreList(vo)); //사전견적서비스목록

        return "/korean/pt/before/BD_requestScs2.form";
    }

    /*
     * 상세정보(사전 견적) 요청서 발송 - IaaS
     * */
    @RequestMapping(value = "/ND_beforeRequestIaasAction.do", method = RequestMethod.POST)
    public String ND_beforeRequestIaasAction(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforeIaasInfoVO beforeIaasInfoVO, MyWishVO myWishVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestIaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (IaaS) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals("")){
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (IaaS) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){

                // 알림                
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);
             
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
              
             }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            
            // IaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforeIaasInfoVO, request);

            beforeIaasInfoVO.setNotifyNum(notifyNum); // 공고번호
            beforeIaasInfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 IaaS 정보 등록
            service.insertBeforeIaasAction(beforeIaasInfoVO);  

            // IaaS 서버 정보 등록
            String[] serverUse     = request.getParameterValues("serverUse");
            String[] serverOs      = request.getParameterValues("serverOs");
            String[] serverCpu     = request.getParameterValues("serverCpu");
            String[] serverMemory  = request.getParameterValues("serverMemory");
            String[] serverDisk    = request.getParameterValues("serverDisk");
            String[] serverQnty    = request.getParameterValues("serverQnty");
            String[] serverIp      = request.getParameterValues("serverIp");
            String[] serverNetwork = request.getParameterValues("serverNetwork");
            String[] serverGslb    = request.getParameterValues("serverGslb");
            String[] serverLdbl    = request.getParameterValues("serverLdbl");
            String[] serverSnap    = request.getParameterValues("serverSnap");
            String[] serverImg     = request.getParameterValues("serverImg");
            
            // Iaas 서버정보가 없을 경우 skip
            if( serverUse.length == 1 && "".equals(serverUse[0]) && "".equals(serverOs[0]) && "".equals(serverCpu[0]) && 
                                         "".equals(serverMemory[0]) && "".equals(serverDisk[0]) && "".equals(serverQnty[0]) &&
                                         "".equals(serverIp[0]) && "".equals(serverNetwork[0]) && "".equals(serverGslb[0]) && 
                                         "".equals(serverLdbl[0]) && "".equals(serverSnap[0]) && "".equals(serverImg[0]) ){
            }else{
                for(int i=0; i<serverUse.length; i++){
                    
                    HashMap<String, Object> paramMap = new HashMap<String, Object> ();
                    paramMap.put("notifyNum",     notifyNum);
                    paramMap.put("notifySeq",     notifySeq);
                    paramMap.put("userId",        userLoginVO.getUserId());
                    paramMap.put("serverUse",     serverUse[i]);
                    paramMap.put("serverOs",      serverOs[i]);
                    paramMap.put("serverCpu",     serverCpu[i]);
                    paramMap.put("serverMemory",  serverMemory[i]);
                    paramMap.put("serverDisk",    serverDisk[i]);
                    paramMap.put("serverQnty",    serverQnty[i]);
                    paramMap.put("serverIp",      serverIp[i]);
                    paramMap.put("serverNetwork", serverNetwork[i]);
                    paramMap.put("serverGslb",    serverGslb[i]);
                    paramMap.put("serverLdbl",    serverLdbl[i]);
                    paramMap.put("serverSnap",    serverSnap[i]);
                    paramMap.put("serverImg",     serverImg[i]);

                    // 입찰공고 IaaS 상세정보(서버) 등록
                    service.insertBeforeIaasServerAction(paramMap);
                }                
            }

            // IaaS DB 정보 등록
            String[] dbUse        = request.getParameterValues("dbUse");
            String[] dbOs         = request.getParameterValues("dbOs");
            String[] dbCpu        = request.getParameterValues("dbCpu");
            String[] dbMemory     = request.getParameterValues("dbMemory");
            String[] dbDisk       = request.getParameterValues("dbDisk");
            String[] dbQnty       = request.getParameterValues("dbQnty");
            String[] dbIp         = request.getParameterValues("dbIp");
            String[] dbNetwork    = request.getParameterValues("dbNetwork");
            String[] dbAddDisk    = request.getParameterValues("dbAddDisk");
            String[] dbBackStorg  = request.getParameterValues("dbBackStorg");
            String[] dbStorgSpace = request.getParameterValues("dbStorgSpace");
            String[] dbTransVlmn  = request.getParameterValues("dbTransVlmn");

            // Iaas DB정보가 없을 경우 skip
            if( dbUse.length == 1 && "".equals(dbUse[0]) && "".equals(dbOs[0]) && "".equals(dbCpu[0]) && 
                                     "".equals(dbMemory[0]) && "".equals(dbDisk[0]) && "".equals(dbQnty[0]) &&
                                     "".equals(dbIp[0]) && "".equals(dbNetwork[0]) && "".equals(dbAddDisk[0]) && 
                                     "".equals(dbBackStorg[0]) && "".equals(dbStorgSpace[0]) && "".equals(dbTransVlmn[0]) ){
            }else{
                for(int j=0; j<serverUse.length; j++){
                    
                    HashMap<String, Object> paramMap = new HashMap<String, Object> ();
                    paramMap.put("notifyNum",    notifyNum);
                    paramMap.put("notifySeq",    notifySeq);
                    paramMap.put("userId",       userLoginVO.getUserId());
                    paramMap.put("dbUse",        dbUse[j]);
                    paramMap.put("dbOs",         dbOs[j]);
                    paramMap.put("dbCpu",        dbCpu[j]);
                    paramMap.put("dbMemory",     dbMemory[j]);
                    paramMap.put("dbDisk",       dbDisk[j]);
                    paramMap.put("dbQnty",       dbQnty[j]);
                    paramMap.put("dbIp",         dbIp[j]);
                    paramMap.put("dbNetwork",    dbNetwork[j]);
                    paramMap.put("dbAddDisk",    dbAddDisk[j]);
                    paramMap.put("dbBackStorg",  dbBackStorg[j]);
                    paramMap.put("dbStorgSpace", dbStorgSpace[j]);
                    paramMap.put("dbTransVlmn",  dbTransVlmn[j]);

                    // 입찰공고 IaaS 상세정보(DB) 등록
                    service.insertBeforeIaasDbAction(paramMap);
                }                
            }
        }else{
            return alertAndRedirect(model, "사전 견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String, Object> paramMap = new HashMap<String, Object> ();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);
        
        return alertAndRedirect(model, "사전 견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }


    /*
     * 상세정보(사전 견적) 요청서 발송 - IaaS2
     * */
    @RequestMapping(value = "/ND_beforeRequestIaas2Action.do", method = RequestMethod.POST)
    public String ND_beforeRequestIaas2Action(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforeIaas2InfoVO beforeIaas2InfoVO, MyWishVO myWishVO) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestIaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (IaaS2) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals(""))
            {
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (IaaS2) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){

                // 알림                
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);
             
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
              
             }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            
            // IaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforeIaas2InfoVO, request);
            beforeIaas2InfoVO.setNotifyNum(notifyNum); // 공고번호
            beforeIaas2InfoVO.setNotifySeq(notifySeq); // 공고차수
            
            // 입찰공고 IaaS 정보 등록
            service.insertBeforeIaas2Action(beforeIaas2InfoVO);  

            // IaaS2 서버 정보 등록
            String[] serverUse     = request.getParameterValues("serverUse");
            String[] serverOs      = request.getParameterValues("serverOs");
            String[] serverCpu     = request.getParameterValues("serverCpu");
            String[] serverMemory  = request.getParameterValues("serverMemory");
            String[] serverDisk    = request.getParameterValues("serverDisk");
            String[] serverQnty    = request.getParameterValues("serverQnty");            
            
            // Iaas2 서버정보가 없을 경우 skip
            if( serverUse.length == 1 && "".equals(serverUse[0]) && "".equals(serverOs[0]) && "".equals(serverCpu[0]) && 
                                         "".equals(serverMemory[0]) && "".equals(serverDisk[0]) && "".equals(serverQnty[0]) )
            {
            }
            else
            {
                for(int i=0; i<serverUse.length; i++)
                {                    
                    HashMap<String,Object> paramMap = new HashMap<String,Object>();
                    paramMap.put("notifyNum",     notifyNum);
                    paramMap.put("notifySeq",     notifySeq);
                    paramMap.put("userId",        userLoginVO.getUserId());
                    paramMap.put("serverUse",     serverUse[i]);
                    paramMap.put("serverOs",      serverOs[i]);
                    paramMap.put("serverCpu",     serverCpu[i]);
                    paramMap.put("serverMemory",  serverMemory[i]);
                    paramMap.put("serverDisk",    serverDisk[i]);
                    paramMap.put("serverQnty",    serverQnty[i]);                    

                    // 입찰공고 IaaS2 상세정보(서버) 등록
                    service.insertBeforeIaas2ServerAction(i,paramMap);                    
                }                
            }

            // IaaS2 DB 정보 등록
            String[] dbUse        = request.getParameterValues("dbUse");
            String[] dbOs         = request.getParameterValues("dbOs");
            String[] dbCpu        = request.getParameterValues("dbCpu");
            String[] dbMemory     = request.getParameterValues("dbMemory");
            String[] dbDisk       = request.getParameterValues("dbDisk");
            String[] dbQnty       = request.getParameterValues("dbQnty");            

            // Iaas2 DB정보가 없을 경우 skip
            if( dbUse.length == 1 && "".equals(dbUse[0]) && "".equals(dbOs[0]) && "".equals(dbCpu[0]) && 
                                     "".equals(dbMemory[0]) && "".equals(dbDisk[0]) && "".equals(dbQnty[0]) )
            {
            }
            else
            {
                for(int i=0; i<serverUse.length; i++)
                {                    
                    HashMap<String,Object> paramMap = new HashMap<String,Object>();
                    paramMap.put("notifyNum",    notifyNum);
                    paramMap.put("notifySeq",    notifySeq);
                    paramMap.put("userId",       userLoginVO.getUserId());
                    paramMap.put("dbUse",        dbUse[i]);
                    paramMap.put("dbOs",         dbOs[i]);
                    paramMap.put("dbCpu",        dbCpu[i]);
                    paramMap.put("dbMemory",     dbMemory[i]);
                    paramMap.put("dbDisk",       dbDisk[i]);
                    paramMap.put("dbQnty",       dbQnty[i]);

                    // 입찰공고 IaaS2 상세정보(DB) 등록
                    service.insertBeforeIaas2DdAction(i,paramMap);
                }                
            }           
        }
        else
        {
            return alertAndRedirect(model, "사전 견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);
        
        
        return alertAndRedirect(model, "사전 견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }

    /*
     * Paas 상세정보(사전 견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_beforeRequestPaas.do",  method = RequestMethod.POST)
    public String BD_beforeRequestPaas(HttpServletRequest request, ModelMap model, MyWishVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        // 선택된 서비스만 사전견적 요청 
        String chkGoodsCode = vo.getGoodsCd2();
        String[] goodsCodeList = chkGoodsCode.split("\\|");
        if(!goodsCodeList.equals("")){
            List<String> goodsList = new ArrayList<String>();
            for(int i=0; i<goodsCodeList.length; i++){
                goodsList.add(i, goodsCodeList[i]);
            }
            vo.setGoodsCodeList(goodsList);    
        }
        
        model.addAttribute("q_userId",    vo.getUserId());
        model.addAttribute("p_grpSeq",    vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd", vo.getGoodsTyCd());        
        
        model.addAttribute("hostingMethodList", registerService.prvCodeList(vo.getLangCode(), 2064)); // 공통코드의 호스팅방식코드(2064)
        //model.addAttribute("priceList",       registerService.prvCodeList(vo.getLangCode(), 2065)); // 공통코드의 가격코드(2065) // 사용안함..
        model.addAttribute("scalingList",       registerService.prvCodeList(vo.getLangCode(), 2066)); // 공통코드의 스케일링코드(2066)
        model.addAttribute("platformList",      registerService.prvCodeList(vo.getLangCode(), 2067)); // 공통코드의 플랫폼코드(2067)
        model.addAttribute("runtimesList",      registerService.prvCodeList(vo.getLangCode(), 2068)); // 공통코드의 런타임코드(2068)
        model.addAttribute("middlewaresList",   registerService.prvCodeList(vo.getLangCode(), 2069)); // 공통코드의 미들웨어코드(2069)
        model.addAttribute("frameworksList",    registerService.prvCodeList(vo.getLangCode(), 2070)); // 공통코드의 프레임워크코드(2070)
        model.addAttribute("servicesList",      registerService.prvCodeList(vo.getLangCode(), 2071)); // 공통코드의 서비스코드(2071)
        model.addAttribute("addonsList",        registerService.prvCodeList(vo.getLangCode(), 2072)); // 공통코드의 애드온코드(2072)
        model.addAttribute("geolocationsList",  registerService.prvCodeList(vo.getLangCode(), 2073)); // 공통코드의 위치코드(2073)
        
        model.addAttribute("p_chkGoodsCode", vo.getGoodsCd2());

        OpHelper.bindSearchMap(vo, request);
        
        //model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishStoreList(vo)); //사전견적서비스목록        
        
        if (!Validate.isEmpty(vo.getNotifyNum())) // 재요청인경우 NotifyNum,NotifySed,SuplerId 가있다..  
        {
        	SuplerCeartPaas2VO paas2VO = new SuplerCeartPaas2VO();
            paas2VO.setNotifyNum(vo.getNotifyNum());
            paas2VO.setNotifySeq(vo.getNotifySeq());
            paas2VO.setEndsUserId(userLoginVO.getUserId());  // 수요자 ID
            paas2VO.setSuplerId(vo.getSuplerId());           // 공급자 ID
            
            List<SuplerCeartPaas2VO> suplerCeartPaas2VO = suplerCeartService.suplerCeartBeforeInfoByPass2(paas2VO);  
            List<SuplerCeartPaas2VO> suplerCeartPaas2VO_h = new  ArrayList<SuplerCeartPaas2VO>();
            
            Iterator<SuplerCeartPaas2VO> iterator2 = suplerCeartPaas2VO.iterator();
            while (iterator2.hasNext())
            {
                SuplerCeartPaas2VO tmp = iterator2.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) suplerCeartPaas2VO_h.add(tmp);
            }            
            model.addAttribute("pass2_h", suplerCeartPaas2VO_h); // PaaS2 정보 조회
        }

        return "/korean/pt/before/BD_requestPaas2.form";
    }

    /**
     * 상세정보(사전 견적) 요청서 발송 - PaaS
     * */
    @RequestMapping(value = "/ND_beforeRequestPaasAction.do", method = RequestMethod.POST)
    public String ND_beforeRequestPaasAction(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforePaasInfoVO beforePaasInfoVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestPaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (PaaS) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals("")){
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (PaaS) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                
                // 알림
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);     
                
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

            // PaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforePaasInfoVO, request);
            beforePaasInfoVO.setNotifyNum(notifyNum); // 공고번호
            beforePaasInfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 PaaS 정보 등록
            service.insertBeforePaasAction(beforePaasInfoVO);

        }else{
            return alertAndRedirect(model, "견적 요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);

        return alertAndRedirect(model, "견적 요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }
    
    /**
     * 상세정보(사전 견적) 요청서 발송 - PaaS2
     * */
    @RequestMapping(value = "/ND_beforeRequestPaas2Action.do", method = RequestMethod.POST)
    public String ND_beforeRequestPaas2Action(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforePaas2InfoVO beforePaas2InfoVO) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestPaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum); // SELECT NVL(MAX(NOTIFY_SEQ), 0) + 1 FROM TCN_BEFORE_ESTE_NOFY  WHERE NOTIFY_NUM = #{notifyNum}
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (PaaS2) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals("")){
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (PaaS) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                
                // 알림
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);     
                
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

            // PaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforePaas2InfoVO, request);
            beforePaas2InfoVO.setNotifyNum(notifyNum); // 공고번호
            beforePaas2InfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 PaaS 정보 등록
            service.insertBeforePaas2Action(beforePaas2InfoVO);

        }
        else
        {
            return alertAndRedirect(model, "견적 요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);

        return alertAndRedirect(model, "견적 요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }
    
    
    /**
     * 상세정보(사전 견적) 요청서 발송 - Scs2
     * */
    @RequestMapping(value = "/ND_beforeRequestScs2Action.do", method = RequestMethod.POST)
    public String ND_beforeRequestScs2Action(ModelMap model, HttpServletRequest request, TcnBeforeNotifyVO tcnBeforeNotifyVO, BeforeScs2InfoVO beforeScs2InfoVO) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/before/BD_requestPaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBeforeNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BEFORE_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBeforeNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBeforeNotifyVO, request);

        // 서비스구분
        tcnBeforeNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
        // 대표전화 셋팅
        String goodsChargerCttpc = "";
        if(request.getParameter("goodsChargerCttpc1") != null || "".equals(request.getParameter("goodsChargerCttpc1"))){
            if(request.getParameter("goodsChargerCttpc2") != null || "".equals(request.getParameter("goodsChargerCttpc2"))){
                goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
            }
            if(request.getParameter("goodsChargerCttpc3") != null || "".equals(request.getParameter("goodsChargerCttpc3"))){
                goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
            }
        }
        tcnBeforeNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBeforeNotifyVO.setNotifyNum(notifyNum); // SELECT NVL(MAX(NOTIFY_SEQ), 0) + 1 FROM TCN_BEFORE_ESTE_NOFY  WHERE NOTIFY_NUM = #{notifyNum}
        Integer notifySeq = service.selectBeforeEsteNotifySeqAction(tcnBeforeNotifyVO);
        tcnBeforeNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록 (PaaS2) // INSERT INTO TCN_BEFORE_ESTE_NOFY
        int confirmCnt = 0;
        confirmCnt += service.insertBeforeEsteNotifyAction(tcnBeforeNotifyVO);

        if(confirmCnt > 0){
            
            //선택한 상품코드만 넘기기 
            String chkGoodsCode = tcnBeforeNotifyVO.getGoodsCd();
            String[] goodsCodeList = chkGoodsCode.split("\\|");
            if(!goodsCodeList.equals("")){
                List<String> goodsList = new ArrayList<String>();
                for(int i=0; i<goodsCodeList.length; i++){
                    goodsList.add(i, goodsCodeList[i]);
                }
                tcnBeforeNotifyVO.setGoodsCodeList(goodsList);    
            }
            
            // 입찰공고 공급자 확인정보 등록 (PaaS) // INSERT INTO TCN_BEFORE_ESTE_SPLY
            service.insertNotifySplyAction(tcnBeforeNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
            suplerVO.setNotifyNum(tcnBeforeNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBeforeNotifyVO.getNotifySeq());
            List<BeforeSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                
                // 알림
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("08");
                alarmVO.setUserId(tcnBeforeNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);     
                
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBeforeNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

            // PaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(beforeScs2InfoVO, request);
            beforeScs2InfoVO.setNotifyNum(notifyNum); // 공고번호
            beforeScs2InfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 PaaS 정보 등록
            service.insertBeforeScs2Action(beforeScs2InfoVO);

        }
        else
        {
            return alertAndRedirect(model, "견적 요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userId",    tcnBeforeNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBeforeNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y"); // '요청' -> '보기'
        myWishService.updateWishStatusAction(paramMap);

        return alertAndRedirect(model, "견적 요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do");
    }
    
    
   public String requestUrl(HttpServletRequest request) {
       String responseUrl = request.getRequestURI();
       return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
   }
   
}
