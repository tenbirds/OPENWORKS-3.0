package zes.openworks.web.bid;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartPaasVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasDVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasIVO;
import zes.openworks.web.register.RegisterService;
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
 *    수정일       	      수정자   	         수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = "/**/bid")
public class BidController extends GeneralController {
    @Autowired
    private RegisterService registerService;
    
    @Autowired
    BidService service;

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

    /** 파일 저장 경로 */
    public static final String BID_NOTIFY_PATH = "bid" + File.separator;

    /*
     * SaaS 상세정보(견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_requestSaas.do",  method = RequestMethod.POST)
    public String BD_requestSaaS(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        model.addAttribute("q_userId",    vo.getUserId());
        model.addAttribute("p_grpSeq",    vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd", vo.getGoodsTyCd());
        model.addAttribute("p_goodsCd",   vo.getGoodsCd2());
        
        model.addAttribute("supplyMethodCodeList",    registerService.prvCodeList(vo.getLangCode(), 2042)); // 공통코드의 제공방법코드(2042)
        model.addAttribute("totUnitCodeList",         registerService.prvCodeList(vo.getLangCode(), 2041)); // 공통코드의 전체단위코드(2041)
        model.addAttribute("userManagerSeparateList", registerService.prvCodeList(vo.getLangCode(), 2061)); // 공통코드의 사용자/관리자분리코드(2061)
        model.addAttribute("serviceSupplyMethodList", registerService.prvCodeList(vo.getLangCode(), 2062)); // 공통코드의 서비스제공방식코드(2062)
        model.addAttribute("encryptionList",          registerService.prvCodeList(vo.getLangCode(), 2063)); // 공통코드의 암호화코드(2063)

        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishConfirmList(vo)); // 확정 서비스 목록

        return "/korean/pt/bid/BD_requestSaas2.form";
    }

    /*
     * 상세정보(견적) 요청서 발송 - SaaS
     * */
    @RequestMapping(value = "/ND_requestSaasAction.do", method = RequestMethod.POST)
    public String requestSaasAction(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidSaasInfoVO bidSaasInfoVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestSaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();


            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBidNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBidNotifyVO, request);

        // 서비스구분
        tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
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
        tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBidNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO);
        tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록
        int confirmCnt = 0;
        confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

        if(confirmCnt > 0){
            // 입찰공고 공급자 확인정보 등록
            service.insertNotifySplyAction(tcnBidNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BidSuplerListVO suplerVO = new BidSuplerListVO();
            suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
            List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){

                // 알림                
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("03");
                alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);
             
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    boolean result = amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
              
             }
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // SaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(bidSaasInfoVO, request);
            bidSaasInfoVO.setNotifyNum(notifyNum); // 공고번호
            bidSaasInfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 SaaS 정보 등록
            service.insertBidSaasAction(bidSaasInfoVO);

            String[] optionNm   = request.getParameterValues("optionNm");
            String[] unitItem   = request.getParameterValues("unitItem");
            String[] captyItem  = request.getParameterValues("captyItem");
            String[] amountItem = request.getParameterValues("amountItem");
            String[] cmntItem   = request.getParameterValues("cmntItem");
            
            // Saas 상세정보가 없을 경우 skip
            if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                
            }else{
                for(int i=0; i<optionNm.length; i++){
                    
                    HashMap paramMap = new HashMap();
                    paramMap.put("notifyNum", notifyNum);
                    paramMap.put("notifySeq", notifySeq);
                    paramMap.put("userId", userLoginVO.getUserId());
                    paramMap.put("optionNm",   optionNm[i]);
                    paramMap.put("unitItem",   unitItem[i]);
                    paramMap.put("captyItem",  captyItem[i]);
                    paramMap.put("amountItem", amountItem[i]);
                    paramMap.put("cmntItem",   cmntItem[i]);

                    // 입찰공고 SaaS 상세정보 등록
                    service.insertBidSaasDetailAction(paramMap);
                }                
            }

        }else{
            return alertAndRedirect(model, "견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap paramMap = new HashMap();
        paramMap.put("userId",    tcnBidNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y");
        myWishService.updateWishStatusAction(paramMap);
        
        return alertAndRedirect(model, "견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }

    /*
     * 상세정보(견적) 요청서 발송 - SaaS2
     * */
    @RequestMapping(value = "/ND_requestSaas2Action.do", method = RequestMethod.POST)
    public String requestSaas2Action(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidSaas2InfoVO bidSaas2InfoVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestSaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();


            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBidNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBidNotifyVO, request);

        // 서비스구분
        tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
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
        tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBidNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO);
        tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록
        int confirmCnt = 0;
        confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

        if(confirmCnt > 0){
            // 입찰공고 공급자 확인정보 등록
            service.insertNotifySplyAction(tcnBidNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BidSuplerListVO suplerVO = new BidSuplerListVO();
            suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
            List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){

                // 알림                
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("03");
                alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);
             
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    boolean result = amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
              
             }
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // SaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(bidSaas2InfoVO, request);
            bidSaas2InfoVO.setNotifyNum(notifyNum); // 공고번호
            bidSaas2InfoVO.setNotifySeq(notifySeq); // 공고차수

            // 입찰공고 SaaS2 정보 등록
            service.insertBidSaas2Action(bidSaas2InfoVO);

            String[] functionName1 = request.getParameterValues("functionName1");
            String[] amount1       = request.getParameterValues("amount1");
            String[] unitCode1     = request.getParameterValues("unitCode1");
            String[] hidenOptions1 = request.getParameterValues("hidenOptions1");
            
            if  (functionName1 != null)
            {
                // Saas2 상세정보가 없을 경우 skip
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
                        service.insertBidSaas2NeedAction(paramMap1);
                        
                        // 필요옵션저장을 위한 일련번호(NEED_SEQ)를 구한다.
                        int needSeq = service.selectBidSaas2NeedSeq(paramMap1);  
                        
                        String[] optionList = hidenOptions1[i].split("\\^");
                        
                        for(int j=0; j<optionList.length; j++)
                        {
                            String[] options = optionList[j].split("\\|");
                            
                            HashMap<String,Object> paramMap2 = new HashMap<String,Object>();
                            paramMap2.put("notifyNum",    notifyNum);
                            paramMap2.put("notifySeq",    notifySeq);
                            paramMap2.put("userId",       userLoginVO.getUserId());
                            paramMap2.put("needSeq",      needSeq);
                            paramMap2.put("functionName", options[i]);
                            paramMap2.put("amount",       options[i]);
                            paramMap2.put("unitCode",     options[i]);
                            
                            // SaaS2 필요옵션기능정보 등록
                            service.insertBidSaas2OptionAction(paramMap2);
                        }
                    }                
                }
            }

        }else{
            return alertAndRedirect(model, "견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userId",    tcnBidNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y");
        myWishService.updateWishStatusAction(paramMap);
        
        return alertAndRedirect(model, "견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }
    
    
    /*
     * Iaas 상세정보(견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_requestIaas.do",  method = RequestMethod.POST)
    public String BD_requestIaaS(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        model.addAttribute("q_userId",    vo.getUserId());
        model.addAttribute("p_grpSeq",    vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd", vo.getGoodsTyCd());
        model.addAttribute("p_goodsCd",   vo.getGoodsCd2());
        
        model.addAttribute("webGoodsKindList", registerService.prvCodeList(vo.getLangCode(), 2074)); // 공통코드의 웹방화벽 상품유형코드(2074)

        OpHelper.bindSearchMap(vo, request);
        System.out.println("*********BD_requestIaaS**********"+vo.getGoodsCd());
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishConfirmList(vo)); // 확정 서비스 목록

        return "/korean/pt/bid/BD_requestIaas2.form";
    }

    /*
     * 상세정보(견적) 요청서 발송 - IaaS
     * */
    @RequestMapping(value = "/ND_requestIaasAction.do", method = RequestMethod.POST)
    public String requestIaasAction(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidIaasInfoVO bidIaasInfoVO, MyWishVO myWishVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestIaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBidNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBidNotifyVO, request);

        // 서비스구분
        tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
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
        tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBidNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO);
        tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록
        int confirmCnt = 0;
        confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

        if(confirmCnt > 0){
            // 입찰공고 공급자 확인정보 등록
            service.insertNotifySplyAction(tcnBidNotifyVO);
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BidSuplerListVO suplerVO = new BidSuplerListVO();
            suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
            List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("03");
                alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);         
              
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    boolean result = amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            
            // IaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(bidIaasInfoVO, request);

            bidIaasInfoVO.setNotifyNum(notifyNum); // 공고번호
            bidIaasInfoVO.setNotifySeq(notifySeq); // 공고차수
            // 입찰공고 IaaS 정보 등록
            service.insertBidIaasAction(bidIaasInfoVO);

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
                    
                    HashMap paramMap = new HashMap();
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
                    service.insertBidIaasServerAction(paramMap);
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
                    
                    HashMap paramMap = new HashMap();
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
                    service.insertBidIaasDbAction(paramMap);
                }                
            }
        }else{
            return alertAndRedirect(model, "견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap paramMap = new HashMap();
        paramMap.put("userId",    tcnBidNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y");
        myWishService.updateWishStatusAction(paramMap);
        
        return alertAndRedirect(model, "견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }

    /*
     * 상세정보(견적) 요청서 발송 - IaaS2
     * */
    @RequestMapping(value = "/ND_requestIaas2Action.do", method = RequestMethod.POST)
    public String requestIaas2Action(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidIaas2InfoVO bidIaas2InfoVO, MyWishVO myWishVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestIaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBidNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBidNotifyVO, request);

        // 서비스구분
        tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
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
        tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBidNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO);
        tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록
        int confirmCnt = 0;
        confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

        if(confirmCnt > 0){
            // 입찰공고 공급자 확인정보 등록
            service.insertNotifySplyAction(tcnBidNotifyVO);
            
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BidSuplerListVO suplerVO = new BidSuplerListVO();
            suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
            List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("03");
                alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);         
              
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    boolean result = amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            
            // IaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(bidIaas2InfoVO, request);
            bidIaas2InfoVO.setNotifyNum(notifyNum); // 공고번호
            bidIaas2InfoVO.setNotifySeq(notifySeq); // 공고차수
            
            // 입찰공고 IaaS 정보 등록
            service.insertBidIaas2Action(bidIaas2InfoVO);  

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
                    paramMap.put("notifyNum",     notifyNum);                // 공고번호
                    paramMap.put("notifySeq",     notifySeq);                // 공고차수
                    paramMap.put("userId",        userLoginVO.getUserId());  // 공급자ID
                    
                    paramMap.put("serverUse",     serverUse[i]);             // 서버 용도
                    paramMap.put("serverOs",      serverOs[i]);              // 서버 OS
                    paramMap.put("serverCpu",     serverCpu[i]);             // 서버 CPU
                    paramMap.put("serverMemory",  serverMemory[i]);          // 서버 메모리
                    paramMap.put("serverDisk",    serverDisk[i]);            // 서버 DISK
                    paramMap.put("serverQnty",    serverQnty[i]);            // 서버 수량                    

                    // 입찰공고 IaaS2 상세정보(서버) 등록
                    service.insertBidIaas2ServerAction(paramMap);                    
                }                
            }

            if  (request.getParameterValues("dbUse") != null)  //IaaS [DB] 답변 이 없을 수도 있다..
            {
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
                    for(int j=0; j<serverUse.length; j++)
                    {                    
                        HashMap<String,Object> paramMap = new HashMap<String,Object>();
                        paramMap.put("notifyNum",    notifyNum);                 // 공고번호                
                        paramMap.put("notifySeq",    notifySeq);                 // 공고차수                
                        paramMap.put("userId",       userLoginVO.getUserId());   // 공급자ID
                        
                        paramMap.put("dbUse",        dbUse[j]);                  // DB 용도               
                        paramMap.put("dbOs",         dbOs[j]);                   // DB OS              
                        paramMap.put("dbCpu",        dbCpu[j]);                  // DB CPU               
                        paramMap.put("dbMemory",     dbMemory[j]);               // DB 메모리                  
                        paramMap.put("dbDisk",       dbDisk[j]);                 // DB DISK                
                        paramMap.put("dbQnty",       dbQnty[j]);                 // DB 수량                
    
                        // 입찰공고 IaaS2 상세정보(DB) 등록
                        service.insertBidIaas2DbAction(paramMap);
                    }                
                }
            }
        }else{
            return alertAndRedirect(model, "견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap paramMap = new HashMap();
        paramMap.put("userId",    tcnBidNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y");
        myWishService.updateWishStatusAction(paramMap);
        
        return alertAndRedirect(model, "견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }

    /*
     * Iaas 상세정보(견적) 요청 화면 호출
     * */
    @RequestMapping(value = "/BD_requestPaas.do",  method = RequestMethod.POST)
    public String BD_requestPaaS(HttpServletRequest request, ModelMap model, MyWishVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        model.addAttribute("q_userId",    vo.getUserId());
        model.addAttribute("p_grpSeq",    vo.getGrpSeq());
        model.addAttribute("p_goodsTyCd", vo.getGoodsTyCd());
        model.addAttribute("p_goodsCd",   vo.getGoodsCd2());
        
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

        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishConfirmList(vo)); // 확정 서비스 목록

        return "/korean/pt/bid/BD_requestPaas2.form";
    }

    /**
     * 상세정보(견적) 요청서 발송 - PaaS
     * */
    @RequestMapping(value = "/ND_requestPaasAction.do", method = RequestMethod.POST)
    public String requestPaasAction(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidPaasInfoVO bidPaasInfoVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestPaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBidNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBidNotifyVO, request);

        // 서비스구분
        tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
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
        tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBidNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO);
        tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록
        int confirmCnt = 0;
        confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

        if(confirmCnt > 0){
            // 입찰공고 공급자 확인정보 등록
            service.insertNotifySplyAction(tcnBidNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BidSuplerListVO suplerVO = new BidSuplerListVO();
            suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
            List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("03");
                alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);     
                
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    boolean result = amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

            // PaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(bidPaasInfoVO, request);
            bidPaasInfoVO.setNotifyNum(notifyNum); // 공고번호
            bidPaasInfoVO.setNotifySeq(notifySeq); // 공고차수
            
            // 입찰공고 PaaS 정보 등록
            service.insertBidPaasAction(bidPaasInfoVO);

        }else{
            return alertAndRedirect(model, "견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap paramMap = new HashMap();
        paramMap.put("userId",    tcnBidNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y");
        myWishService.updateWishStatusAction(paramMap);

        return alertAndRedirect(model, "견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }

    /**
     * 상세정보(견적) 요청서 발송 - PaaS2
     * */
    @RequestMapping(value = "/ND_requestPaas2Action.do", method = RequestMethod.POST)
    public String requestPaas2Action(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidPaas2InfoVO bidPaas2InfoVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestPaas.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> delyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("delyFile")) {
                delyFile.add(uploadFile.get(i));
            }
        }
        tcnBidNotifyVO.setDelyFileList(delyFile);

        // 입찰공고 정보 등록용 VO 셋팅
        OpHelper.bindSearchMap(tcnBidNotifyVO, request);

        // 서비스구분
        tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));
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
        tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

        // 공고 차수 채번
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date d = Calendar.getInstance().getTime();
        String notifyNum = sdf.format(d); // 공고번호
        tcnBidNotifyVO.setNotifyNum(notifyNum);
        Integer notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO);
        tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수

        // 입찰공고정보 등록
        int confirmCnt = 0;
        confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

        if(confirmCnt > 0){
            // 입찰공고 공급자 확인정보 등록
            service.insertNotifySplyAction(tcnBidNotifyVO);

            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
            // 알람처리
            BidSuplerListVO suplerVO = new BidSuplerListVO();
            suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
            suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
            List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

            for(int i=0; i<suplerList.size(); i++){
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("03");
                alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                alarmVO.setAlarmTitle("견적 요청서가 수신되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                alarmVO.setConfrmGbn("N");
                
                // 입찰공고 공급자 알람처리
                alarmService.alarmInsert(alarmVO);     
                
                // 이메일
                if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                    Map<String, Object> autoMap = new HashMap<String, Object>();
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_02REQ);
                    autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                    autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                    boolean result = amservice.sendAutoMail(autoMap);
                }
                
                // SMS
                if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                    Map<String, Object> smsMap = new HashMap<String, Object>();
                    smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                    smsMap.put("msg", "견적 요청서가 수신되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
            }
            /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

            // PaaS 정보 등록용 VO 셋팅
            OpHelper.bindSearchMap(bidPaas2InfoVO, request);
            bidPaas2InfoVO.setNotifyNum(notifyNum); // 공고번호
            bidPaas2InfoVO.setNotifySeq(notifySeq); // 공고차수
            
            // 입찰공고 PaaS 정보 등록
            service.insertBidPaas2Action(bidPaas2InfoVO);

        }else{
            return alertAndRedirect(model, "견적요청서 전송에 실패하였습니다.", requestUrl(request) + "/ND_requestPaasAction.do");
        }

        // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
        HashMap<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userId",    tcnBidNotifyVO.getUserId());
        paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
        paramMap.put("confrmChk", "Y");
        myWishService.updateWishStatusAction(paramMap);

        return alertAndRedirect(model, "견적요청서를 발송하였습니다.", "/korean/pt/myCeart/BD_buyingRequestList.do");
    }

    /*
     * 입찰공고 등록 화면 호출
     * */
    @RequestMapping(value = "/BD_requestRegist.do",  method = RequestMethod.POST)
    public String BD_requestRegist(HttpServletRequest request, ModelMap model, MyWishVO vo) 
    {        
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        String notifyNum = request.getParameter("notifyNum");
        String notifySeq = request.getParameter("notifySeq");

        // 입찰공고에 대한 param(notifyNum,notifySeq[공고번호,공고차수])이 존재할 경우
        if  (notifyNum != null && !"".equals(notifyNum) && notifySeq != null && !"".equals(notifySeq))
        {
            MyCeartBidNotifyVO myCeartBidNotifyVO = new MyCeartBidNotifyVO();
            myCeartBidNotifyVO.setNotifyNum(request.getParameter("notifyNum"));
            myCeartBidNotifyVO.setNotifySeq(Integer.parseInt(request.getParameter("notifySeq")));
            List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(myCeartBidNotifyVO);
            model.addAttribute("tcnBidNotifyInfo", requestMstInfo.get(0));

            // 기본 parameter
            model.addAttribute("p_goodsTyCd",  requestMstInfo.get(0).getGoodKndCd());  // 서비스구분
            model.addAttribute("p_bidKndCd",   requestMstInfo.get(0).getBidKndCd());   // 공고종류
            model.addAttribute("p_bidClassCd", requestMstInfo.get(0).getBidClassCd()); // 공고분류
            model.addAttribute("p_cntrMothod", requestMstInfo.get(0).getCntrMothod()); // 계약방법

            // 해당 견적의 서비스 구분
            String goodKndCd =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );

            if(goodKndCd.equals("1001"))
            {
                MyCeartPaasVO paasVO = new MyCeartPaasVO();
                paasVO.setNotifyNum(myCeartBidNotifyVO.getNotifyNum());
                paasVO.setNotifySeq(myCeartBidNotifyVO.getNotifySeq());
                paasVO.setUserId(vo.getUserId());
                paasVO.setLangStoreId("");
                
                model.addAttribute("pass", myCeartService.myCeartInfoByPass(paasVO)); // PaaS 정보 조회
            }
            else if(goodKndCd.equals("1002"))
            {
                MyCeartSaasIVO saasIVO = new MyCeartSaasIVO();
                saasIVO.setNotifyNum(myCeartBidNotifyVO.getNotifyNum());
                saasIVO.setNotifySeq(myCeartBidNotifyVO.getNotifySeq());
                saasIVO.setUserId(vo.getUserId());
                saasIVO.setLangStoreId("");

                model.addAttribute("sassI", myCeartService.myCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
                
                MyCeartSaasDVO saasDVO = new MyCeartSaasDVO();
                saasDVO.setNotifyNum(myCeartBidNotifyVO.getNotifyNum());
                saasDVO.setNotifySeq(myCeartBidNotifyVO.getNotifySeq());
                saasDVO.setUserId(vo.getUserId());
                saasDVO.setLangStoreId("");

                model.addAttribute("sassD", myCeartService.myCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회
            }
            else if(goodKndCd.equals("1003"))
            {
                MyCeartIaasIVO iaasIVO   = new MyCeartIaasIVO();
                iaasIVO.setNotifyNum(myCeartBidNotifyVO.getNotifyNum());
                iaasIVO.setNotifySeq(myCeartBidNotifyVO.getNotifySeq());
                iaasIVO.setUserId(vo.getUserId());
                iaasIVO.setLangStoreId("");
                model.addAttribute("iassI",  myCeartService.myCeartInfoByIassI(iaasIVO));   // IaaS 정보 조회
                
                MyCeartIaasDsVO iaasDsVO = new MyCeartIaasDsVO();
                iaasDsVO.setNotifyNum(myCeartBidNotifyVO.getNotifyNum());
                iaasDsVO.setNotifySeq(myCeartBidNotifyVO.getNotifySeq());
                iaasDsVO.setUserId(vo.getUserId());
                iaasDsVO.setLangStoreId("");
                model.addAttribute("iassDs", myCeartService.myCeartInfoByIassDs(iaasDsVO)); // IaaS Server 정보 조회
                
                MyCeartIaasDdVO iaasDdVO = new MyCeartIaasDdVO();
                iaasDdVO.setNotifyNum(myCeartBidNotifyVO.getNotifyNum());
                iaasDdVO.setNotifySeq(myCeartBidNotifyVO.getNotifySeq());
                iaasDdVO.setUserId(vo.getUserId());
                iaasDdVO.setLangStoreId("");            
                model.addAttribute("iassDd", myCeartService.myCeartInfoByIassDd(iaasDdVO)); // IaaS DB 정보 조회
            }
        }
        else
        {
            // 기본 parameter
            model.addAttribute("q_userId",     vo.getUserId());
            model.addAttribute("p_grpSeq",     vo.getGrpSeq());
            model.addAttribute("p_goodsTyCd",  vo.getGoodsTyCd());
            model.addAttribute("p_bidKndCd",   "1001"); // 공고종류(첫 화면 호출시 공고종류는 항상 본공고(1001))
            model.addAttribute("p_bidClassCd", "1001"); // 공고분류(첫 화면 호출시 공고종류는 항상 일반(1001))
            model.addAttribute("p_cntrMothod", request.getParameter("cntrMothod")); // 계약방법            
        }

        // code list parameter
        model.addAttribute("bidKndCdCodeList",   registerService.prvCodeList(vo.getLangCode(), 2038)); // 공고종류(2038)
        model.addAttribute("bidClassCdCodeList", registerService.prvCodeList(vo.getLangCode(), 2039)); // 공고분류(2039)
        model.addAttribute("cntrMothodCodeList", registerService.prvCodeList(vo.getLangCode(), 2040)); // 계약방법(2040)
        model.addAttribute("areaLimitCodeList",  registerService.prvCodeList(vo.getLangCode(), 2036)); // 지역코드(2036)
        model.addAttribute("goodsKndCdCodeList", registerService.prvCodeList(vo.getLangCode(), 1005)); // 서비스종류(1005)
        
        // Saas 시스템 요구 입력항목에 대한 code list
        model.addAttribute("totUnitCodeList",      registerService.prvCodeList(vo.getLangCode(), 2041)); // 공통코드의 전체단위코드(2041)
        model.addAttribute("supplyMethodCodeList", registerService.prvCodeList(vo.getLangCode(), 2042)); // 공통코드의 제공방법코드(2042)

        // 확정서비스목록 조회
        OpHelper.bindSearchMap(vo, request);        
        model.addAttribute(GlobalConfig.KEY_PAGER, myWishService.myWishConfirmList(vo));

        return "/korean/pt/bid/BD_requestRegist.form";
    }

   /*
    * 입찰공고 등록
    * */
   @RequestMapping(value = "/ND_requestRegistAction.do", method = RequestMethod.POST)
   public String requestRegistAction(ModelMap model, HttpServletRequest request, TcnBidNotifyVO tcnBidNotifyVO, BidSaasInfoVO bidSaasInfoVO, BidPaasInfoVO bidPaasInfoVO, BidIaasInfoVO bidIaasInfoVO) {

       // 로그인 회원 체크
       UserLoginVO userLoginVO = OpHelper.getUserSession(request);
       if(Validate.isEmpty(userLoginVO)) {
           String returnUrl = "?returnUrl=/korean/pt/bid/BD_requestRegist.do";
           return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
       } else {
           tcnBidNotifyVO.setUserId(userLoginVO.getUserId());
       }

       // 업로드 파일 설정
       List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
       List<FileVO> delyFile     = new ArrayList<FileVO>();
       List<FileVO> optlCntrFile = new ArrayList<FileVO>();
       for(int i = 0 ; i < uploadFile.size() ; i++) {

           String inputNm = uploadFile.get(i).getInputNm();

           if(inputNm.startsWith("delyFile")) {
               delyFile.add(uploadFile.get(i));
           }else if(inputNm.startsWith("optlCntrFile")){
               optlCntrFile.add(uploadFile.get(i));
           }
       }
       tcnBidNotifyVO.setDelyFileList(delyFile);
       tcnBidNotifyVO.setOptlCntrFileList(optlCntrFile);

       // 입찰공고 정보 등록용 VO 셋팅
       OpHelper.bindSearchMap(tcnBidNotifyVO, request);

       // 서비스구분
       tcnBidNotifyVO.setGoodKndCd(request.getParameter("goodsTyCd"));

       // 대표전화 셋팅
       String goodsChargerCttpc = "";
       if(request.getParameter("goodsChargerCttpc1") != null || !"".equals(request.getParameter("goodsChargerCttpc1"))){
           if(request.getParameter("goodsChargerCttpc2") != null || !"".equals(request.getParameter("goodsChargerCttpc2"))){
               goodsChargerCttpc = request.getParameter("goodsChargerCttpc1") + "-" + request.getParameter("goodsChargerCttpc2");
           }
           if(request.getParameter("goodsChargerCttpc3") != null || !"".equals(request.getParameter("goodsChargerCttpc3"))){
               goodsChargerCttpc = goodsChargerCttpc + "-" + request.getParameter("goodsChargerCttpc3");
           }
       }
       tcnBidNotifyVO.setGoodsChargerCttpc(goodsChargerCttpc);

       // 공고종류에 대한 접수일/마감일/개찰일 셋팅
       
       if(tcnBidNotifyVO.getBidKndCd().equals("1001")){
           // 본공고
           tcnBidNotifyVO.setStrtDt( request.getParameter("strtDtExec") );
           tcnBidNotifyVO.setStrtTime( request.getParameter("strtTimeExec") );
           
           tcnBidNotifyVO.setClseDt( request.getParameter("clseDtExec") );
           tcnBidNotifyVO.setClseTime( request.getParameter("clseTimeExec") );
           
           tcnBidNotifyVO.setOpenDt( request.getParameter("openDtExec") );
           tcnBidNotifyVO.setOpenTime( request.getParameter("openTimeExec") );
       }else{
           // 예비공고
           tcnBidNotifyVO.setStrtDt( request.getParameter("strtDtResv") );
           tcnBidNotifyVO.setStrtTime( request.getParameter("strtTimeResv") );
           
           tcnBidNotifyVO.setClseDt( request.getParameter("clseDtResv") );
           tcnBidNotifyVO.setClseTime( request.getParameter("clseTimeResv") );
           
           tcnBidNotifyVO.setOpenDt( "" );
           tcnBidNotifyVO.setOpenTime( "" );
       }
       
       // 계약방법에 따른 지역/자격 제한 셋팅
       if(tcnBidNotifyVO.getCntrMothod().equals("1001")||tcnBidNotifyVO.getCntrMothod().equals("1003")){
           tcnBidNotifyVO.setAreaLimit1( "" );
           tcnBidNotifyVO.setAreaLimit2( "" );
           tcnBidNotifyVO.setAreaLimit3( "" );
           tcnBidNotifyVO.setCatyLimitEntr( "" );
           tcnBidNotifyVO.setCatyLimitVntr( "" );
           tcnBidNotifyVO.setCatyLimitSoc( "" );
           tcnBidNotifyVO.setCatyLimitWomn( "" );
           tcnBidNotifyVO.setCatyLimitDiad( "" );
           tcnBidNotifyVO.setCatyLimitEtc( "" );
           tcnBidNotifyVO.setCatyLimitEtcComt( "" );
       }

       // 공고 차수 채번
       String  notifyNum = ""; // 공고번호
       Integer notifySeq;      // 공고차수
       String  insertYn = "Y"; // 신규등록 여부

       if(request.getParameter("p_notifyNum")==null || request.getParameter("p_notifyNum").equals("")){
           SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
           Date d = Calendar.getInstance().getTime();
           notifyNum = sdf.format(d); // 공고번호
           tcnBidNotifyVO.setNotifyNum(notifyNum); // 공고번호
           notifySeq = service.selectBidNotifySeqAction(tcnBidNotifyVO); // 공고차수
           tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수
       }else{
           notifyNum = request.getParameter("p_notifyNum"); // 공고번호
           notifySeq = Integer.parseInt(request.getParameter("p_notifySeq")); // 공고차수
           tcnBidNotifyVO.setNotifyNum(notifyNum); // 공고번호
           tcnBidNotifyVO.setNotifySeq(notifySeq); // 공고차수
           insertYn = "N";
       }

       // 처리 성공 여부
       int confirmCnt = 0;
       
       // 신규등록건일 경우
       if(insertYn.equals("Y")){

           confirmCnt += service.insertBidNotifyAction(tcnBidNotifyVO);

           // 입찰공고정보 등록 성공시
           if(confirmCnt > 0){

               // 지명경쟁일 경우에만 공급자 확인정보 insert
               if(tcnBidNotifyVO.getCntrMothod().equals("1004")){
                   // 입찰공고 공급자 확인정보 등록
                   service.insertNotifySplyAction(tcnBidNotifyVO);

                   /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
                   // 알람처리
                   BidSuplerListVO suplerVO = new BidSuplerListVO();
                   suplerVO.setNotifyNum(tcnBidNotifyVO.getNotifyNum());
                   suplerVO.setNotifySeq(tcnBidNotifyVO.getNotifySeq());
                   List<BidSuplerListVO> suplerList = service.selectSuplerList(suplerVO);

                   for(int i=0; i<suplerList.size(); i++){
                       AlarmVO alarmVO = new AlarmVO();
                       alarmVO.setAlarmBizGbn("05");
                       alarmVO.setUserId(tcnBidNotifyVO.getUserId());
                       alarmVO.setAlarmTitle("입찰참여요청이 수신되었습니다.");
                       alarmVO.setConfrmId(suplerList.get(i).getSuplerId());
                       alarmVO.setConfrmGbn("N");
                       
                       // 입찰공고 공급자 알람처리
                       alarmService.alarmInsert(alarmVO);       
                       // 이메일
                       if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                           Map<String, Object> autoMap = new HashMap<String, Object>();
                           HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                           oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                           autoMap.put("oneToOneInfo", oneToOneInfoMap);
                           autoMap.put("automailId", AutoMailTemplate.KOR_BID_04REQ);
                           autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                           autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                           boolean result = amservice.sendAutoMail(autoMap);
                       }
                       
                       // SMS
                       if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                           Map<String, Object> smsMap = new HashMap<String, Object>();
                           smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                           smsMap.put("msg", "입찰참여요청이 수신되었습니다.");
                           smsMap.put("dutyCd", "BM");
                           boolean smsRst = smsService.smsTransHist(smsMap);
                       }
                   }
                   /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
               }

               // PaaS
               if(tcnBidNotifyVO.getGoodKndCd().equals("1001")){
                   // PaaS 정보 등록용 VO 셋팅
                   OpHelper.bindSearchMap(bidPaasInfoVO, request);
                   bidPaasInfoVO.setNotifyNum(notifyNum); // 공고번호
                   bidPaasInfoVO.setNotifySeq(notifySeq); // 공고차수
                   
                   // 입찰공고 PaaS 정보 등록
                   service.insertBidPaasAction(bidPaasInfoVO);

               // SaaS
               }else if(tcnBidNotifyVO.getGoodKndCd().equals("1002")){
                   // SaaS 정보 등록용 VO 셋팅
                   OpHelper.bindSearchMap(bidSaasInfoVO, request);
                   bidSaasInfoVO.setNotifyNum(notifyNum); // 공고번호
                   bidSaasInfoVO.setNotifySeq(notifySeq); // 공고차수
                   // 입찰공고 SaaS 정보 등록
                   service.insertBidSaasAction(bidSaasInfoVO);

                   String[] optionNm   = request.getParameterValues("optionNm");
                   String[] unitItem   = request.getParameterValues("unitItem");
                   String[] captyItem  = request.getParameterValues("captyItem");
                   String[] amountItem = request.getParameterValues("amountItem");
                   String[] cmntItem   = request.getParameterValues("cmntItem");
                   
                   // Saas 상세정보가 없을 경우 skip
                   if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                       
                   }else{
                       for(int i=0; i<optionNm.length; i++){
                           
                           HashMap paramMap = new HashMap();
                           paramMap.put("notifyNum", notifyNum);
                           paramMap.put("notifySeq", notifySeq);
                           paramMap.put("userId", userLoginVO.getUserId());
                           paramMap.put("optionNm",   optionNm[i]);
                           paramMap.put("unitItem",   unitItem[i]);
                           paramMap.put("captyItem",  captyItem[i]);
                           paramMap.put("amountItem", amountItem[i]);
                           paramMap.put("cmntItem",   cmntItem[i]);

                           // 입찰공고 SaaS 상세정보 등록
                           service.insertBidSaasDetailAction(paramMap);
                       }                
                   }
               // IaaS               
               }else if(tcnBidNotifyVO.getGoodKndCd().equals("1003")){
                   // IaaS 정보 등록용 VO 셋팅
                   OpHelper.bindSearchMap(bidIaasInfoVO, request);

                   bidIaasInfoVO.setNotifyNum(notifyNum); // 공고번호
                   bidIaasInfoVO.setNotifySeq(notifySeq); // 공고차수
                   // 입찰공고 IaaS 정보 등록
                   service.insertBidIaasAction(bidIaasInfoVO);

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
                           
                           HashMap paramMap = new HashMap();
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
                           service.insertBidIaasServerAction(paramMap);
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
                       for(int i=0; i<dbUse.length; i++){
                           
                           HashMap paramMap = new HashMap();
                           paramMap.put("notifyNum",    notifyNum);
                           paramMap.put("notifySeq",    notifySeq);
                           paramMap.put("userId",       userLoginVO.getUserId());
                           paramMap.put("dbUse",        dbUse[i]);
                           paramMap.put("dbOs",         dbOs[i]);
                           paramMap.put("dbCpu",        dbCpu[i]);
                           paramMap.put("dbMemory",     dbMemory[i]);
                           paramMap.put("dbDisk",       dbDisk[i]);
                           paramMap.put("dbQnty",       dbQnty[i]);
                           paramMap.put("dbIp",         dbIp[i]);
                           paramMap.put("dbNetwork",    dbNetwork[i]);
                           paramMap.put("dbAddDisk",    dbAddDisk[i]);
                           paramMap.put("dbBackStorg",  dbBackStorg[i]);
                           paramMap.put("dbStorgSpace", dbStorgSpace[i]);
                           paramMap.put("dbTransVlmn",  dbTransVlmn[i]);

                           // 입찰공고 IaaS 상세정보(DB) 등록
                           service.insertBidIaasDbAction(paramMap);
                       }                
                   }
               }
           }
       }else{
           // 임시등록건 처리

           // 1) 입찰공고 정보 수정
           confirmCnt += service.updateBidNotifyAction(tcnBidNotifyVO);

           if(confirmCnt > 0){
               // PaaS
               if(tcnBidNotifyVO.getGoodKndCd().equals("1001")){
                   // PaaS-1) PaaS 정보 등록용 VO 셋팅
                   OpHelper.bindSearchMap(bidPaasInfoVO, request);
                   bidPaasInfoVO.setNotifyNum(notifyNum);            // 공고번호
                   bidPaasInfoVO.setNotifySeq(notifySeq);            // 공고차수
                   bidPaasInfoVO.setUserId(userLoginVO.getUserId()); // 사용자(수요자)ID

                   // PaaS-2) 입찰공고 PaaS 정보 UPDATE
                   service.updateBidPaasAction(bidPaasInfoVO);

               // SaaS
               }else if(tcnBidNotifyVO.getGoodKndCd().equals("1002")){
                   // SaaS-1) SaaS 정보 등록용 VO 셋팅
                   OpHelper.bindSearchMap(bidSaasInfoVO, request);
                   bidSaasInfoVO.setNotifyNum(notifyNum); // 공고번호
                   bidSaasInfoVO.setNotifySeq(notifySeq); // 공고차수
                   bidSaasInfoVO.setUserId(userLoginVO.getUserId()); // 사용자(수요자)ID

                   // SaaS-2) 입찰공고 SaaS 정보 UPDATE
                   service.updateBidSaasAction(bidSaasInfoVO);

                   // SaaS-3) 입찰 상세정보 삭제(삭제 후 재등록 로직)
                   service.deleteBidSaasDetailAction(bidSaasInfoVO);

                   String[] optionNm   = request.getParameterValues("optionNm");
                   String[] unitItem   = request.getParameterValues("unitItem");
                   String[] captyItem  = request.getParameterValues("captyItem");
                   String[] amountItem = request.getParameterValues("amountItem");
                   String[] cmntItem   = request.getParameterValues("cmntItem");
                   
                   // Saas 상세정보가 없을 경우 skip
                   if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                       
                   }else{
                       for(int i=0; i<optionNm.length; i++){
                           
                           HashMap paramMap = new HashMap();
                           paramMap.put("notifyNum", notifyNum);
                           paramMap.put("notifySeq", notifySeq);
                           paramMap.put("userId", userLoginVO.getUserId());
                           paramMap.put("optionNm",   optionNm[i]);
                           paramMap.put("unitItem",   unitItem[i]);
                           paramMap.put("captyItem",  captyItem[i]);
                           paramMap.put("amountItem", amountItem[i]);
                           paramMap.put("cmntItem",   cmntItem[i]);

                           // SaaS-4) 입찰공고 SaaS 상세정보 등록
                           service.insertBidSaasDetailAction(paramMap);
                       }                
                   }
               // IaaS               
               }else if(tcnBidNotifyVO.getGoodKndCd().equals("1003")){
                   // IaaS-1) IaaS 정보 등록용 VO 셋팅
                   OpHelper.bindSearchMap(bidIaasInfoVO, request);
                   bidIaasInfoVO.setNotifyNum(notifyNum); // 공고번호
                   bidIaasInfoVO.setNotifySeq(notifySeq); // 공고차수
                   bidIaasInfoVO.setUserId(userLoginVO.getUserId()); // 사용자(수요자)ID
                   
                   // IaaS-2) 입찰공고 IaaS 정보 UPDATE
                   service.updateBidIaasAction(bidIaasInfoVO);

                   // IaaS-3) 입찰공고 IaaS 상세정보(서버) 삭제
                   HashMap dSMap = new HashMap();
                   dSMap.put("notifyNum",  notifyNum);
                   dSMap.put("notifySeq",  notifySeq);
                   dSMap.put("userId",     userLoginVO.getUserId());
                   service.deleteBidIaasServerAction(dSMap);

                   // IaaS-4) IaaS 서버 정보 등록
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
                           
                           HashMap paramMap = new HashMap();
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
                           service.insertBidIaasServerAction(paramMap);
                       }                
                   }

                   // IaaS-5) IaaS DB 정보 삭제
                   HashMap dDMap = new HashMap();
                   dDMap.put("notifyNum",  notifyNum);
                   dDMap.put("notifySeq",  notifySeq);
                   dDMap.put("userId",     userLoginVO.getUserId());
                   service.deleteBidIaasDbAction(dDMap);

                   // IaaS-6) IaaS DB 정보 등록
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
                       for(int i=0; i<dbUse.length; i++){
                           
                           HashMap paramMap = new HashMap();
                           paramMap.put("notifyNum",    notifyNum);
                           paramMap.put("notifySeq",    notifySeq);
                           paramMap.put("userId",       userLoginVO.getUserId());
                           paramMap.put("dbUse",        dbUse[i]);
                           paramMap.put("dbOs",         dbOs[i]);
                           paramMap.put("dbCpu",        dbCpu[i]);
                           paramMap.put("dbMemory",     dbMemory[i]);
                           paramMap.put("dbDisk",       dbDisk[i]);
                           paramMap.put("dbQnty",       dbQnty[i]);
                           paramMap.put("dbIp",         dbIp[i]);
                           paramMap.put("dbNetwork",    dbNetwork[i]);
                           paramMap.put("dbAddDisk",    dbAddDisk[i]);
                           paramMap.put("dbBackStorg",  dbBackStorg[i]);
                           paramMap.put("dbStorgSpace", dbStorgSpace[i]);
                           paramMap.put("dbTransVlmn",  dbTransVlmn[i]);

                           // 입찰공고 IaaS 상세정보(DB) 등록
                           service.insertBidIaasDbAction(paramMap);
                       }                
                   }
               }
           }
       }

       // 전체 정보 저장 완료(견적생성 완료) 후 구매희망 사업에 완료 FLAG 처리
       HashMap paramMap = new HashMap();
       paramMap.put("userId",    tcnBidNotifyVO.getUserId());
       paramMap.put("grpSeq",    tcnBidNotifyVO.getGrpSeq());
       paramMap.put("confrmChk", "Y");
       myWishService.updateWishStatusAction(paramMap);

       String url = "";

       String rtnMsg = "";
       if(tcnBidNotifyVO.getBidGbnCd().equals("1001")){
           rtnMsg = "입찰공고 등록";
           url = "/korean/pt/myCeart/BD_myCeartBidList.do";
       }else if(tcnBidNotifyVO.getBidGbnCd().equals("1003")){
           rtnMsg = "임시저장";
           url = "/korean/pt/myCeart/BD_myCeartBidList.do";
       }

       if(confirmCnt <= 0){
           return alertAndRedirect(model, rtnMsg+"에 실패하였습니다.", requestUrl(request) + "/BD_requestRegist.do");
       }
       
       return alertAndRedirect(model, rtnMsg+"이 완료 되었습니다.", url);

   }

   public String requestUrl(HttpServletRequest request) {
       String responseUrl = request.getRequestURI();
       return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
   }
}
