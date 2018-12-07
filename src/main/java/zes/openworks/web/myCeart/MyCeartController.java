package zes.openworks.web.myCeart;

import java.io.File;
import java.util.ArrayList;
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

import zes.base.pager.Pager;
import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.alarm.AlarmService;
import zes.openworks.web.alarm.AlarmVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNofyVO;
import zes.openworks.web.myCeart.vo.MyCeartBeforeNotifySplyVO;
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.myCeart.vo.MyCeartExcelVO;
import zes.openworks.web.myCeart.vo.MyCeartGoodsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaas2IVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDdVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasDsVO;
import zes.openworks.web.myCeart.vo.MyCeartIaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartNotifySplyVO;
import zes.openworks.web.myCeart.vo.MyCeartPaas2VO;
import zes.openworks.web.myCeart.vo.MyCeartPaasVO;
import zes.openworks.web.myCeart.vo.MyCeartPurchsDtlsVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DnVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DoVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2IVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasDVO;
import zes.openworks.web.myCeart.vo.MyCeartSaasIVO;
import zes.openworks.web.myCeart.vo.MyCeartTenderVO;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.suplerCeart.SuplerCeartService;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;
import zes.openworks.web.wish.myWish.MyWishService;
/**
 *
 * @Class Name : MyCeartController
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 * @Description : 마이씨앗 위키 공통 Controller
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       	      수정자   	         수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = {"/**/myCeart"})
public class MyCeartController extends GeneralController {
    @Autowired
    private RegisterService registerService;
    
    @Autowired
    MyCeartService myCeartService;

    @Autowired
    CommonDutyService commonService;
    
    @Autowired
    AlarmService alarmService;

    @Autowired
    MyWishService myWishService;

    @Autowired
    SuplerCeartService suplerCeartService;
    
    /** 파일 저장 경로 */
    public static final String BID_NOTIFY_PATH = "bid" + File.separator;

    /** 파일 저장 경로 - 계약서 */
    public static final String CNTRCT_FILE_PATH = "cntrct" + File.separator;

    // 접속 사용자 도메인 값 불러와서 가져오기
    public String Language(HttpServletRequest request) {
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }
    
    /*
     * 마이씨앗 - 상세정보(견적)요청서 관리
     * */
    @RequestMapping(value = "/BD_buyingRequestList.do")
    public String BD_buyingRequestList(HttpServletRequest request, ModelMap model, MyCeartVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_buyingRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        model.addAttribute("askApplyCdCodeList", registerService.prvCodeList(vo.getLangCode(), 2043)); // 공통코드의 답변여부

        OpHelper.bindSearchMap(vo, request);
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.buyingRequestList(vo));

        vo.setLangCode(Language(request));
        
        return "/korean/pt/myCeart/BD_buyingRequestList";
    }

    /**
     * 
     * jsFinishRequest (계약체결 완료요청)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_finishRequest.do",  method = RequestMethod.POST)
    public String ND_finishRequest(HttpServletRequest request, ModelMap model, MyCeartVO vo) {
       
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }       
        
        vo.setUserId(userLoginVo.getUserId());

        String[] dataArray = request.getParameter("requestData").split("#");
        int totalDataCnt = dataArray.length;
        int processDataCnt = 0;
        for(int i=0; i<totalDataCnt; i++){
            String[] arrayData = dataArray[i].split("\\|");
            String notifyNum   = arrayData[0];
            String notifySeq   = arrayData[1];
            String langStoreId = arrayData[2];
            
            HashMap<String, String> dataMap = new HashMap<String, String>();
            dataMap.put("notifyNum", notifyNum);
            dataMap.put("notifySeq", notifySeq);
            dataMap.put("langStoreId", langStoreId);
            
            processDataCnt += myCeartService.updateFinishRequest(dataMap);
        }

        if(totalDataCnt == processDataCnt) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "finishRequestOk"));
        }
        return responseJson(model, Messages.FALSE, "finishRequestFail");
    }

    /**
     * 
     * BD_requestDetailView (마이씨앗 - 상세정보(견적)요청서 서비스 상세조회)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_requestDetailView.do")
    public String BD_requestDetailView(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_buyingRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        
        // 입찰공고 마스터 조회
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));
        
        // 공급자의 확인정보 조회
        MyCeartNotifySplyVO notifySplyVO = new MyCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());
        notifySplyVO.setUserId(vo.getLangStoreId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, myCeartService.myCeartNotifySplyInfo(notifySplyVO).get(0));
        
        // 해당 견적의 서비스 구분
        String goodKndCd =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );

        if(goodKndCd.equals("1001"))
        {
            /*
            MyCeartPaasVO paasVO = new MyCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setUserId(vo.getUserId());
            paasVO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("pass", myCeartService.myCeartInfoByPass(paasVO)); // PaaS 정보 조회
            */
            MyCeartPaas2VO paas2VO = new MyCeartPaas2VO();
            paas2VO.setNotifyNum(vo.getNotifyNum());
            paas2VO.setNotifySeq(vo.getNotifySeq());
            paas2VO.setUserId(vo.getUserId());
            paas2VO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("pass2", myCeartService.myCeartInfoByPass2(paas2VO)); // PaaS2 정보 조회
        }
        else if(goodKndCd.equals("1002"))
        {
            /*
            MyCeartSaasIVO saasIVO = new MyCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setUserId(vo.getUserId());
            saasIVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassI", myCeartService.myCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            MyCeartSaasDVO saasDVO = new MyCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setUserId(vo.getUserId());
            saasDVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassD", myCeartService.myCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회
            */
            
            MyCeartSaas2IVO saas2IVO = new MyCeartSaas2IVO();
            saas2IVO.setNotifyNum(vo.getNotifyNum());
            saas2IVO.setNotifySeq(vo.getNotifySeq());
            saas2IVO.setUserId(vo.getUserId());
            saas2IVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sass2I", myCeartService.myCeartInfoBySass2I(saas2IVO)); // SaaS2 정보 조회
            
            MyCeartSaas2DnVO saas2DnVO = new MyCeartSaas2DnVO();
            saas2DnVO.setNotifyNum(vo.getNotifyNum());
            saas2DnVO.setNotifySeq(vo.getNotifySeq());
            saas2DnVO.setUserId(vo.getUserId());
            saas2DnVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sass2Dn", myCeartService.myCeartInfoBySass2Dn(saas2DnVO)); // SaaS2Dn 상세Need 정보 조회
            
            MyCeartSaas2DoVO saas2DoVO = new MyCeartSaas2DoVO();
            saas2DoVO.setNotifyNum(vo.getNotifyNum());
            saas2DoVO.setNotifySeq(vo.getNotifySeq());
            saas2DoVO.setUserId(vo.getUserId());
            saas2DoVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sass2Do", myCeartService.myCeartInfoBySass2Do(saas2DoVO)); // SaaS2Do 상세Option 정보 조회
        }
        else if(goodKndCd.equals("1003"))
        {
            /*
            MyCeartIaasIVO iaasIVO   = new MyCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setUserId(vo.getUserId());
            iaasIVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassI",  myCeartService.myCeartInfoByIassI(iaasIVO));   // IaaS 정보 조회
            
            MyCeartIaasDsVO iaasDsVO = new MyCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setUserId(vo.getUserId());
            iaasDsVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassDs", myCeartService.myCeartInfoByIassDs(iaasDsVO)); // IaaS Server 정보 조회
            
            MyCeartIaasDdVO iaasDdVO = new MyCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setUserId(vo.getUserId());
            iaasDdVO.setLangStoreId(vo.getLangStoreId());            
            model.addAttribute("iassDd", myCeartService.myCeartInfoByIassDd(iaasDdVO)); // IaaS DB 정보 조회
            */
            
            MyCeartIaas2IVO iaas2IVO   = new MyCeartIaas2IVO();
            iaas2IVO.setNotifyNum(vo.getNotifyNum());
            iaas2IVO.setNotifySeq(vo.getNotifySeq());
            iaas2IVO.setUserId(vo.getUserId());
            iaas2IVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iass2I",  myCeartService.myCeartInfoByIass2I(iaas2IVO));   // IaaS22 정보 조회
            
            MyCeartIaas2DsVO iaas2DsVO = new MyCeartIaas2DsVO();
            iaas2DsVO.setNotifyNum(vo.getNotifyNum());
            iaas2DsVO.setNotifySeq(vo.getNotifySeq());
            iaas2DsVO.setUserId(vo.getUserId());
            iaas2DsVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iass2Ds", myCeartService.myCeartInfoByIass2Ds(iaas2DsVO)); // IaaS2 Server 정보 조회
            
            MyCeartIaas2DdVO iaas2DdVO = new MyCeartIaas2DdVO();
            iaas2DdVO.setNotifyNum(vo.getNotifyNum());
            iaas2DdVO.setNotifySeq(vo.getNotifySeq());
            iaas2DdVO.setUserId(vo.getUserId());
            iaas2DdVO.setLangStoreId(vo.getLangStoreId());            
            model.addAttribute("iass2Dd", myCeartService.myCeartInfoByIass2Dd(iaas2DdVO)); // IaaS2 DB 정보 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/myCeart/BD_requestDetail.view";
        /*
        // /korean/pt/myCeart/BD_requestDetail.view
        // /korean/pt/myCeart/goods/BD_Paas2.view.jsp
        // /korean/pt/myCeart/goods/BD_Saas2.view.jsp
        // /korean/pt/myCeart/goods/BD_Iaas2.view.jsp
        */
    }
    
    /**
     * 상세정보(견적)요청서 서비스 상세 정보 조회(비교 서비스)
     */
    @RequestMapping(value = "BD_goodsCompareList.do")
    public String goodsCompareList(HttpServletRequest request, ModelMap model, MyCeartGoodsVO vo){

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);

        Map<String, Object> goodsMap = new HashMap<String, Object>();        
        goodsMap.put("goodsList", myCeartService.myCeartGoodsList(vo));

        return responseJson(model, goodsMap);

    }

    /**
     * 상세정보(견적)요청서 서비스 상세 정보 조회(비교 팝업 호출)
     */
    @RequestMapping(value = "PD_compareDetail.do")
    public void compareDetail(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo){
        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        
        // 입찰공고 마스터 조회
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자의 확인정보 조회
        MyCeartNotifySplyVO notifySplyVO = new MyCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());

        // 선택된 서비스만 비교 팝업에 조회
        String compGoodsCode = request.getParameter("q_compGoodsCode");
        String[] goodsCodeList = compGoodsCode.split("\\|");
        if(!goodsCodeList.equals("")){
            List<String> goodsList = new ArrayList<String>();
            for(int i=0; i<goodsCodeList.length; i++){
                goodsList.add(i, goodsCodeList[i]);
            }
            notifySplyVO.setGoodsCodeList(goodsList);    
        }

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, myCeartService.myCeartNotifySplyInfo(notifySplyVO));

        // 해당 견적의 서비스 구분
        String goodKndCd =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );
        String userId    =  requestMstInfo.get(0).getUserId();

        if(goodKndCd.equals("1001")){
            MyCeartPaasVO paasVO = new MyCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setUserId(userId);
            
            model.addAttribute("pass", myCeartService.compareMyCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            MyCeartSaasIVO saasIVO = new MyCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setUserId(userId);

            model.addAttribute("sassI", myCeartService.compareMyCeartInfoBySassI(saasIVO)); // 상세정보(견적)요청서 SaaS 조회(비교 팝업용)
            
            MyCeartSaasDVO saasDVO = new MyCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setUserId(userId);

            model.addAttribute("sassD", myCeartService.compareMyCeartInfoBySassD(saasDVO)); // 상세정보(견적)요청서 SaaS 상세 조회(비교 팝업용)

        }else if(goodKndCd.equals("1003")){
            MyCeartIaasIVO iaasIVO   = new MyCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setUserId(userId);
            model.addAttribute("iassI",  myCeartService.compareMyCeartInfoByIassI(iaasIVO));   // IaaS 정보 조회
            
            MyCeartIaasDsVO iaasDsVO = new MyCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setUserId(userId);
            model.addAttribute("iassDs", myCeartService.compareMyCeartInfoByIassDs(iaasDsVO)); // IaaS Server 정보 조회
            
            MyCeartIaasDdVO iaasDdVO = new MyCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setUserId(userId);    
            model.addAttribute("iassDd", myCeartService.compareMyCeartInfoByIassDd(iaasDdVO)); // IaaS DB 정보 조회
        }
        // 레포트호출을 위한 조회조건 반환
        model.addAttribute("p_notifyNum", request.getParameter("p_notifyNum"));
        model.addAttribute("p_notifySeq", request.getParameter("p_notifySeq"));
        model.addAttribute("q_compGoodsCode", request.getParameter("q_compGoodsCode"));
    }

    /*
     * 마이씨앗 - 상세정보(견적)요청서 관리 - 엑셀다운로드
     * */
    @RequestMapping(value="INC_EXCEL.do")
    public String excel(HttpServletRequest request, ModelMap model, MyCeartVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setUserId(userLoginVO.getUserId());

        OpHelper.bindSearchMap(vo, request);
        vo.getDataMap().put("q_userId",userLoginVO.getUserId());

        model.put("q_excel", "01"); // 목록별 구분값
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", myCeartService.buyingRequestListExcel(vo));
        model.put("q_excelFileName", "견적요청서 목록");

        MyCeartExcelVO myCeartExcel = new MyCeartExcelVO();
        myCeartExcel.setModel(model);
        myCeartExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, myCeartExcel);
    }


    /*
     * 마이씨앗 - 입찰공고 관리
     * */
    @RequestMapping(value = "/BD_myCeartBidList.do")
    public String BD_myCeartBidList(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        //myCeartService.myPgesStatCheck(vo);
        OpHelper.bindSearchMap(vo, request);

        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        
        Pager<MyCeartBidNotifyVO> myPager = myCeartService.myCeartBidList(vo);
            
        /*boolean refush = false;
        int myCheck = 0;
        
        for(int i = 0; i < myPager.getList().size(); i++){
            vo.setBidPgesStat(myPager.getList().get(i).getBidPgesStat());
            vo.setNotifyNum(myPager.getList().get(i).getNotifyNum()); 
            vo.setNotifySeq(myPager.getList().get(i).getNotifySeq());
            
            //입찰공고 관리 진행상태
            if(Integer.valueOf(vo.getBidPgesStat()) <= 1002){
                //myCheck = myCeartService.myPgesStatCheck(vo);
            }
            //업데이트가 됬을 경우 refush를 true
            if(myCheck != 0 && !refush){
                refush = true;
            }
        }
        
        //refush가  true일 경우 메소드 다시 시작하여 최신화
        if(refush){
            BD_myCeartBidList(request,model,vo);
        }else{
            //false 일 경우 업데이트 할 것이 없음 으로 최신으로 판별하여 pager에 데이터 전송
            model.addAttribute(GlobalConfig.KEY_PAGER, myPager);
        }*/
        
        model.addAttribute(GlobalConfig.KEY_PAGER, myPager);
        return "/korean/pt/myCeart/BD_myCeartBidList";
    }

    /**
     * 
     * BD_bidDetailView (마이씨앗 - 입찰공고 관리 공고내역 상세보기)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_bidDetailView.do")
    public String BD_bidDetailView(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);

        // 입찰공고 마스터 조회
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자의 확인정보 조회
/*
        MyCeartNotifySplyVO myCeartNotifySplyVO = new MyCeartNotifySplyVO();
        myCeartNotifySplyVO.setNotifyNum(vo.getNotifyNum());
        myCeartNotifySplyVO.setNotifySeq(vo.getNotifySeq());
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.myCeartNotifySplyInfo(myCeartNotifySplyVO));
*/
        // 공급자 응찰현황 조회
        MyCeartTenderVO myCeartTenderVO = new MyCeartTenderVO();
        myCeartTenderVO.setNotifyNum(vo.getNotifyNum());
        myCeartTenderVO.setNotifySeq(vo.getNotifySeq());

        String cntrMothod =  requestMstInfo.get(0).getCntrMothod();
        // 지명경쟁일 경우 답변상태와 상관없이 회사 목록을 출력하기 위해
        if(!cntrMothod.equals("1004")){
            myCeartTenderVO.setAskApplyCd( Integer.parseInt("1003") );  // 답변상태(1003:답변)
            myCeartTenderVO.setBidPgesStat( Integer.parseInt(requestMstInfo.get(0).getBidPgesStat()) ); // 입찰진행상태(1002:응찰)            
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.myCeartTenderList(myCeartTenderVO));
        
        //requestMstInfo.get(0).getBid
        // 해당 견적의 서비스 구분
        String goodKndCd =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );

        if(goodKndCd.equals("1001")){
            MyCeartPaasVO paasVO = new MyCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setUserId(vo.getUserId());
            paasVO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("pass", myCeartService.myCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            MyCeartSaasIVO saasIVO = new MyCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setUserId(vo.getUserId());
            saasIVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassI", myCeartService.myCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            MyCeartSaasDVO saasDVO = new MyCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setUserId(vo.getUserId());
            saasDVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassD", myCeartService.myCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

        }else if(goodKndCd.equals("1003")){
            MyCeartIaasIVO iaasIVO   = new MyCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setUserId(vo.getUserId());
            iaasIVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassI",  myCeartService.myCeartInfoByIassI(iaasIVO));   // IaaS 정보 조회
            
            MyCeartIaasDsVO iaasDsVO = new MyCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setUserId(vo.getUserId());
            iaasDsVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassDs", myCeartService.myCeartInfoByIassDs(iaasDsVO)); // IaaS Server 정보 조회
            
            MyCeartIaasDdVO iaasDdVO = new MyCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setUserId(vo.getUserId());
            iaasDdVO.setLangStoreId(vo.getLangStoreId());            
            model.addAttribute("iassDd", myCeartService.myCeartInfoByIassDd(iaasDdVO)); // IaaS DB 정보 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/myCeart/BD_bidDetail.view";
    }

    /**
     * 
     * BD_bidDetailView (마이씨앗 - 입찰공고 관리 공고 변경/취소 화면 호출)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_myCeartBidCancleView.do")
    public String BD_myCeartBidCancleView(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);

        // 입찰공고 마스터 조회
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자 응찰현황 조회
        MyCeartTenderVO myCeartTenderVO = new MyCeartTenderVO();
        myCeartTenderVO.setNotifyNum(vo.getNotifyNum());
        myCeartTenderVO.setNotifySeq(vo.getNotifySeq());

        String cntrMothod =  requestMstInfo.get(0).getCntrMothod();
        // 지명경쟁일 경우 답변상태와 상관없이 회사 목록을 출력하기 위해
        if(!cntrMothod.equals("1004")){
            myCeartTenderVO.setAskApplyCd( Integer.parseInt("1003") );  // 답변상태(1003:답변)
            myCeartTenderVO.setBidPgesStat( Integer.parseInt(requestMstInfo.get(0).getBidPgesStat()) ); // 입찰진행상태(1002:응찰)            
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.myCeartTenderList(myCeartTenderVO));
               
        // code list parameter
        model.addAttribute("bidKndCdCodeList",   registerService.prvCodeList("00", 2038)); // 공고종류(2038)
        model.addAttribute("bidClassCdCodeList", registerService.prvCodeList("00", 2039)); // 공고분류(2039)
        model.addAttribute("cntrMothodCodeList", registerService.prvCodeList("00", 2040)); // 계약방법(2040)
        model.addAttribute("areaLimitCodeList",  registerService.prvCodeList("00", 2036)); // 지역코드(2036)
        model.addAttribute("goodsKndCdCodeList", registerService.prvCodeList("00", 1005)); // 서비스종류(1005)
        
        // Saas 시스템 요구 입력항목에 대한 code list
        model.addAttribute("totUnitCodeList",      registerService.prvCodeList("00", 2041)); // 공통코드의 전체단위코드(2041)
        model.addAttribute("supplyMethodCodeList", registerService.prvCodeList("00", 2042)); // 공통코드의 제공방법코드(2042)

        model.addAttribute("p_bidPgesStat", "1009"); // 입찰진행상태(공고 변경/취소는 공고연기(1009)가 디폴트)
        model.addAttribute("p_cntrMothod", requestMstInfo.get(0).getCntrMothod());
        model.addAttribute("p_bidKndCd",   requestMstInfo.get(0).getBidKndCd());   // 공고종류    

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/myCeart/BD_myCeartBidCancle.view";
    }

    /**
     * 
     * ND_myCeartBidCancelAction (공고 수정/취소 처리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_myCeartBidCancelAction.do",  method = RequestMethod.POST)
    public String ND_myCeartBidCancelAction(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        String bidPgesStat = vo.getBidPgesStat();

        int result = 0;
 
        if(bidPgesStat.equals("1011")){
            // 입찰공고 취소
            result = myCeartService.cancleMyCeartBid(vo);
        }else{
            // 공고종류에 대한 접수일/마감일/개찰일 셋팅
            
            if(vo.getBidKndCd().equals("1001")){
                // 본공고
                vo.setStrtDt( request.getParameter("strtDtExec") );
                vo.setStrtTime( request.getParameter("strtTimeExec") );
                vo.setClseDt( request.getParameter("clseDtExec") );
                vo.setClseTime( request.getParameter("clseTimeExec") );
                vo.setOpenDt( request.getParameter("openDtExec") );
                vo.setOpenTime( request.getParameter("openTimeExec") );
            }else{
                // 예비공고
                vo.setStrtDt( request.getParameter("strtDtResv") );
                vo.setStrtTime( request.getParameter("strtTimeResv") );
                vo.setClseDt( request.getParameter("clseDtResv") );
                vo.setClseTime( request.getParameter("clseTimeResv") );
                vo.setOpenDt( "" );
                vo.setOpenTime( "" );
            }

            if(bidPgesStat.equals("1009")){
                // 공고연기
                result = myCeartService.updateMyCeartBidTerm(vo);

            }else if(bidPgesStat.equals("1010")){
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
                vo.setGoodsChargerCttpc(goodsChargerCttpc);

                // 계약방법에 따른 지역/자격 제한 셋팅
                if(vo.getCntrMothod().equals("1001")||vo.getCntrMothod().equals("1003")){
                    vo.setAreaLimit1( "" );
                    vo.setAreaLimit2( "" );
                    vo.setAreaLimit3( "" );
                    vo.setCatyLimitEntr( "" );
                    vo.setCatyLimitVntr( "" );
                    vo.setCatyLimitSoc( "" );
                    vo.setCatyLimitWomn( "" );
                    vo.setCatyLimitDiad( "" );
                    vo.setCatyLimitEtc( "" );
                    vo.setCatyLimitEtcComt( "" );
                }
                // 공고 변경
                result = myCeartService.updateMyCeartBidInfo(vo);
            }
        }
        
        String rtnMsg = "";
        if(bidPgesStat.equals("1011")){
            rtnMsg = "취소";
        }else{
            rtnMsg = "등록";
        }

        if(result > 0){
            return alertAndRedirect(model, "정상적으로 " + rtnMsg + " 되었습니다.", "/korean/pt/myCeart/BD_myCeartBidList.do");    
        }else{
            return alertAndRedirect(model, rtnMsg + "에 실패하였습니다.", "/korean/pt/myCeart/BD_myCeartBidCancleView.do");
        }
    }

    /**
     * 
     * BD_myCeartBidExecute (마이씨앗 - 입찰공고 관리 - 입찰집행화면 호출)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_myCeartBidExecute.do")
    public String BD_myCeartBidExecute(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);

        // 입찰공고 마스터 조회
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));
        
        // 공급자 응찰현황 조회
        MyCeartTenderVO myCeartTenderVO = new MyCeartTenderVO();
        myCeartTenderVO.setNotifyNum(vo.getNotifyNum());
        myCeartTenderVO.setNotifySeq(vo.getNotifySeq());
        myCeartTenderVO.setAskApplyCd( Integer.parseInt("1003") );  // 답변상태(1003:답변)
        myCeartTenderVO.setBidPgesStat( Integer.parseInt(requestMstInfo.get(0).getBidPgesStat()) ); // 입찰진행상태(1002:응찰)
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.myCeartTenderList(myCeartTenderVO));
        
        // code list parameter
        //model.addAttribute("p_bidPgesStat", "1004"); // 입찰진행상태

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        String rtnPage = "";
        if(requestMstInfo.get(0).getBidPgesStat().equals("1002")){
            rtnPage = "/korean/pt/myCeart/BD_myCeartBidExecute.view";
        }else{
            rtnPage = "/korean/pt/myCeart/BD_myCeartBidSuccess.view";
        }
        return rtnPage;
    }


    /*
     * 입찰공고 관리 - 개찰처리
     * */
    @RequestMapping(value = "/ND_myCeartBidExecuteAction.do", method = RequestMethod.POST)
    public String ND_myCeartBidExecuteAction(ModelMap model, HttpServletRequest request, MyCeartTenderVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));

        /*
         * 개찰/유찰일 경우 유찰사유란을 참조
         * 기타(낙찰선언의 사유)는 낙찰선언사유를 참조
         * */
        if(vo.getBidPgesStat() == 1004 || vo.getBidPgesStat() == 1005){
            vo.setBidChngCause(request.getParameter("noBidCause"));
        }else{
            vo.setBidChngCause(request.getParameter("successCause"));
        }
        
        /*
         * 입찰공고 개찰처리
         *     STEP1) 낙찰여부 정보에 insert
         *     STEP2) 입찰공고 공급자 정보의 상태 변경
         *     STEP3) 입찰공고 정보에 상태값 변경
         * */
        int result = myCeartService.updateMyCeartOpenAction(vo);

        if(result > 0){
            return responseText(model, Messages.TRUE);    
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 
     * ND_myCeartBidSuccessAction (공고 낙찰 처리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_myCeartBidSuccessAction.do",  method = RequestMethod.POST)
    public String ND_myCeartBidSuccessAction(HttpServletRequest request, ModelMap model, MyCeartTenderVO vo) {
        int rtnVal = 0;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, BID_NOTIFY_PATH);
        List<FileVO> evalSheetFile = new ArrayList<FileVO>();
        for(int j = 0 ; j < uploadFile.size() ; j++) {
            String inputNm = uploadFile.get(j).getInputNm();

            if(inputNm.startsWith("evalSheetFile")) {
                evalSheetFile.add(uploadFile.get(j));
            }
        }
        vo.setEvalSheetFileList(evalSheetFile);

        int fileSeq = 0;
        if(vo.getEvalSheetFile() != 0){
            fileSeq = vo.getEvalSheetFile();
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);

        // 낙찰자 ID
        String succBidder = request.getParameter("succBidder");
        String evalCause  = request.getParameter("evalCause");
        
        int bidRankCnt = request.getParameterValues("bidRankVal").length;
        String userId = "";
        int bidRank;
        if(bidRankCnt > 1){
            String[] paramBidRank = request.getParameterValues("bidRankVal");
            for(int i=0; i<bidRankCnt; i++){
                String[] bidRankInfo = paramBidRank[i].split("\\|");
                userId  = bidRankInfo[0];
                bidRank = Integer.parseInt(bidRankInfo[1]);
                
                // 낙찰 처리
                if(userId.equals(succBidder)){
                    vo.setUserId(userId);         // user id 바인딩
                    vo.setEvalCause(evalCause);   // 낙찰근거 바인딩
                    vo.setBidRank(bidRank);       // 순위 바인딩
                    vo.setBidSussGbn("Y");        // 낙찰/선정여부 바인딩
                    vo.setEvalSheetFile(fileSeq); // 기등록 평가서의 변경이 없을 경우 낙찰자에 정보로 처리
                    
                    // 선택된 순위가 낙찰자일 경우
                    rtnVal = myCeartService.updateMyCeartSuccBidder(vo);
                }else{
                    vo.setUserId(userId);    // user id 바인딩
                    vo.setEvalCause("");     // 낙찰근거 바인딩
                    vo.setBidRank(bidRank);  // 순위 바인딩
                    vo.setBidSussGbn("N");   // 낙찰/선정여부 바인딩
                    
                    // 선택된 순위가 낙찰자가 아닐경우
                    rtnVal = myCeartService.updateMyCeartSuccBidder(vo);
                }
            }
        }else{
            String paramBidRank = request.getParameter("bidRankVal");
            String[] bidRankInfo = paramBidRank.split("\\|");
            userId  = bidRankInfo[0];
            bidRank = Integer.parseInt(bidRankInfo[1]);

            // 순위가 1개일 경우 낙찰자는 해당 ID
            vo.setUserId(userId);       // user id 바인딩
            vo.setEvalCause(evalCause); // 낙찰근거 바인딩
            vo.setBidRank(bidRank);     // 순위 바인딩
            vo.setBidSussGbn("Y");      // 낙찰/선정여부 바인딩
            
            rtnVal = myCeartService.updateMyCeartSuccBidder(vo);
        }
        MyCeartBidNotifyVO bidvo = new MyCeartBidNotifyVO();
        // 입찰공고 마스터 조회
        bidvo.setNotifyNum(vo.getNotifyNum());
        bidvo.setNotifySeq(vo.getNotifySeq());
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(bidvo);
        
        // 낙찰자 선택 완료 알림                
        AlarmVO alarmVO = new AlarmVO();
        alarmVO.setAlarmBizGbn("06");
        alarmVO.setUserId(userLoginVO.getUserId());
        alarmVO.setAlarmTitle("'" + requestMstInfo.get(0).getBidNotifyNm() +"'의 우선협상자로 선정되었습니다.");
        alarmVO.setConfrmId(succBidder);
        alarmVO.setConfrmGbn("N");
        
        /**20181023 신규추가**/
        alarmVO.setBuseoCode(userLoginVO.getBuseoCode());
        alarmVO.setUserTyCd(userLoginVO.getUserTyCd());
        
        // 입찰공고 관리 낙찰자 선택 완료 알람 처리
        alarmService.alarmInsert(alarmVO);
        
        // 낙찰자 정보 수정에 성공할 경우 공고 마스터에 상태 변경
        if(rtnVal > 0){
            if(vo.getBidPgesStat() == 1006 || vo.getBidPgesStat() == 1008){
                rtnVal = myCeartService.updateMyCeartSuccBidMst(vo);    
            }
        }
        
        return alertAndRedirect(model, "낙찰이 완료 되었습니다.", "/korean/pt/myCeart/BD_purchsDtlsList.do");    
    }
    
    /**
     * 
     * ND_myCeartBidCancle (공고 낙찰취소 처리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_myCeartBidCancle.do",  method = RequestMethod.POST)
    public String ND_myCeartBidderChangeAction(HttpServletRequest request, ModelMap model, MyCeartTenderVO vo) {
        int rtnVal = 0;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);

        // 낙찰 취소처리
        rtnVal = myCeartService.updateMyCeartBidCancel(vo);

        // 낙찰자 취소처리에 성공할 경우 공고 마스터에 상태 변경
        if(rtnVal > 0){
            rtnVal = myCeartService.updateMyCeartCancelBidMst(vo);
        }

        return alertAndRedirect(model, "낙찰취소 되었습니다.", "/korean/pt/myCeart/BD_myCeartBidList.do");    
    }

    
    /*
     * 마이씨앗 - 구매내역 관리
     * */
    @RequestMapping(value = "/BD_purchsDtlsList.do")
    public String BD_purchsDtlsList(HttpServletRequest request, ModelMap model, MyCeartPurchsDtlsVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_purchsDtlsList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setEndsUserId(userLoginVO.getUserId());
            vo.setBuseoCode(userLoginVO.getBuseoCode());
            vo.setUserTyCd(userLoginVO.getUserTyCd());
        }
        
        OpHelper.bindSearchMap(vo, request);
        vo.setLangCode(Language(request));
        
        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.purchsDtlsList(vo));
        
        // 로그인 회원 타입코드 
        model.addAttribute("UserTyCd",   myCeartService.purchsDtlsUserTyCd(vo));
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        
        return "/korean/pt/myCeart/BD_purchsDtlsList";
    }

    /*
     * 마이씨앗 - 상세정보(견적)요청서 관리 - 엑셀다운로드
     * */
    @RequestMapping(value="/purchsDtlsListExcel.do")
    public String purchsDtlsListExcel(HttpServletRequest request, ModelMap model, MyCeartPurchsDtlsVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setEndsUserId(userLoginVO.getUserId());

        OpHelper.bindSearchMap(vo, request);
        vo.getDataMap().put("q_userId",userLoginVO.getUserId());

        model.put("q_excel", "02"); // 목록별 구분값(01:상세정보(견적)요청서 / 02:구매내역관리 목록)
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", myCeartService.purchsDtlsList(vo));
        model.put("q_excelFileName", "구매내역관리 목록");

        MyCeartExcelVO myCeartExcel = new MyCeartExcelVO();
        myCeartExcel.setModel(model);
        myCeartExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, myCeartExcel);
    }
    
    /**
     * 
     * ND_acmsltCrtfRequst (구매(실적)증명서 발급요청)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_acmsltCrtfRequst.do",  method = RequestMethod.POST)
    public String ND_acmsltCrtfRequst(HttpServletRequest request, ModelMap model, MyCeartVO vo) {
       
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }       
        
        vo.setUserId(userLoginVo.getUserId());

        String[] dataArray = request.getParameter("requestData").split("#");
        int totalDataCnt = dataArray.length;
        int processDataCnt = 0;
        for(int i=0; i<totalDataCnt; i++){
            String[] arrayData = dataArray[i].split("\\|");
            String cntrctSn   = arrayData[0];
            
            HashMap<String, String> dataMap = new HashMap<String, String>();
            dataMap.put("cntrctSn", cntrctSn);
            
            processDataCnt += myCeartService.updateAcmsltCrtfRequst(dataMap);
        }

        if(totalDataCnt == processDataCnt) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "acmsltCrtfRequstOk"));
        }
        return responseJson(model, Messages.FALSE, "acmsltCrtfRequstFail");
    }

    /**
     * 
     * BD_requestDetailView2 (마이씨앗 - 구매내역관리 서비스 상세조회)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_requestDetailView2.do")
    public String BD_requestDetailView2(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_purchsDtlsList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        
        // 입찰공고 마스터 조회
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        List<MyCeartBidNotifyVO> requestMstInfo = myCeartService.myCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));
        
        // 공급자의 확인정보 조회
        MyCeartNotifySplyVO notifySplyVO = new MyCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());
        notifySplyVO.setUserId(vo.getLangStoreId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, myCeartService.myCeartNotifySplyInfo(notifySplyVO).get(0));
        
        // 해당 견적의 서비스 구분
        String goodKndCd =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );

        if(goodKndCd.equals("1001"))
        {
            MyCeartPaasVO paasVO = new MyCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setUserId(vo.getUserId());
            paasVO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("pass", myCeartService.myCeartInfoByPass(paasVO)); // PaaS 정보 조회
        }
        else if(goodKndCd.equals("1002"))
        {
            MyCeartSaas2IVO saas2IVO = new MyCeartSaas2IVO();
            saas2IVO.setNotifyNum(vo.getNotifyNum());
            saas2IVO.setNotifySeq(vo.getNotifySeq());
            saas2IVO.setUserId(vo.getUserId());
            saas2IVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassI", myCeartService.myCeartInfoBySass2I(saas2IVO)); // SaaS 정보 조회
            
            /**********************************
            MyCeartSaasDVO saasDVO = new MyCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setUserId(vo.getUserId());
            saasDVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassD", myCeartService.myCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회
            ****************/
        }
        else if(goodKndCd.equals("1003"))
        {
            MyCeartIaasIVO iaasIVO   = new MyCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setUserId(vo.getUserId());
            iaasIVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassI",  myCeartService.myCeartInfoByIassI(iaasIVO));   // IaaS 정보 조회
            
            MyCeartIaasDsVO iaasDsVO = new MyCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setUserId(vo.getUserId());
            iaasDsVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassDs", myCeartService.myCeartInfoByIassDs(iaasDsVO)); // IaaS Server 정보 조회
            
            MyCeartIaasDdVO iaasDdVO = new MyCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setUserId(vo.getUserId());
            iaasDdVO.setLangStoreId(vo.getLangStoreId());            
            model.addAttribute("iassDd", myCeartService.myCeartInfoByIassDd(iaasDdVO)); // IaaS DB 정보 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/myCeart/BD_requestDetail2.view";
    }

    /**
     * 
     * BD_myCntrctForm (계약서 등록 화면 호출)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_myCntrctForm.do")
    public String BD_myCntrctForm(HttpServletRequest request, ModelMap model, SuplerCntrctVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setCommUserId(userLoginVO.getUserId());
        
        String rlCntrctInsttAt = request.getParameter("rlCntrctInsttAt");
        if(request.getParameter("p_cntrctSn") != null && !request.getParameter("p_cntrctSn").equals("")){
            vo.setCntrctSn(Integer.parseInt(request.getParameter("p_cntrctSn")));
            // 계약서 정보 및 실제이용자정보조회
            SuplerCntrctVO pvo = (SuplerCntrctVO)suplerCeartService.cntrctDetail(vo);
            if(pvo.getRealOrgNm() != null && !pvo.getRealOrgNm().equals("")) 
              {   rlCntrctInsttAt = "Y"; pvo.setRlCntrctInsttAt("Y"); }
            
            model.addAttribute(GlobalConfig.KEY_BASE_VO, pvo);
            // 계약체결서비스
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, suplerCeartService.cntrctDtlGoodsList(vo));
        }
        /*
        if(request.getParameter("p_cntrctSn") != null && !request.getParameter("p_cntrctSn").equals("")){
            vo.setCntrctSn(Integer.parseInt(request.getParameter("p_cntrctSn")));
            // 계약서 등록 데이터 조회
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, myCeartService.cntrctDtlInfo(vo).get(0));
        }else{
            //등록폼 default
            List<SuplerCntrctVO> lv= myCeartService.cntrctInitInfo(vo);
            if (lv.size() > 0)
                model.addAttribute(GlobalConfig.KEY_BASE_LIST, lv.get(0));
            
        }*/

        // 조회조건 반환
        model.addAttribute("rlCntrctInsttAt", rlCntrctInsttAt );
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      vo.getQ_currPage());

        return "/korean/pt/myCeart/BD_myCntrct.form";
    }

    /**
     * 
     * ND_myCntrctRegistAction (계약서 등록)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_myCntrctRegistAction.do", method = RequestMethod.POST)
    public String ND_myCntrctRegistAction(ModelMap model, HttpServletRequest request, SuplerCntrctVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId("ceart");
            vo.setPurchsInsttNm("구매자정보");
            vo.setSleInsttNm("판매자정보");
            vo.setCommUserId(userLoginVO.getUserId());
            vo.setRegistId(userLoginVO.getUserId());
            vo.setBuseoCode(userLoginVO.getBuseoCode());
            vo.setSbscrbTyCd(userLoginVO.getUserTyCd());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, CNTRCT_FILE_PATH);
        List<FileVO> ctrtcSn = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("ctrtcSn")) {
                ctrtcSn.add(uploadFile.get(i));
            }
        }
        vo.setCtrtcSnList(ctrtcSn);

        // 계약관리정보 저장용 바인딩
        OpHelper.bindSearchMap(vo, request);

        int confirmCnt = 0;
        if(vo.getCntrctSn()!=0){  // || vo.getRegistMthdCode() == 1002
            confirmCnt = myCeartService.updateCntrctCmpl(vo);
        }else{
            /*_suplerCeart.insertSuplerCntrctCmpl"*/
            confirmCnt = myCeartService.insertCntrctCmpl(vo);    
        }
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      vo.getQ_currPage());

        if(confirmCnt <= 0){
            return alertAndRedirect(model, "저장에 실패하였습니다.", "/korean/pt/myCeart/BD_myCntrctForm.do");
        }
      
        String rlCntrctInsttAt = request.getParameter("p_rlCntrctInsttAt");        
        if(rlCntrctInsttAt != null && rlCntrctInsttAt.equals("Y"))
            return alertAndRedirect(model, "계약번호가 생성 저장이 완료 되었습니다. 실제이용자정보를 등록하시 바랍니다.", "/korean/pt/myCeart/BD_myCntrctForm.do?cntrctSn="+vo.getCntrctSn()+"&p_cntrctSn="+vo.getCntrctSn()+"&rlCntrctInsttAt=Y");
        else 
            return alertAndRedirect(model, "저장이 완료 되었습니다.", "/korean/pt/myCeart/BD_purchsDtlsList.do");

    }
    
    
    

    /**
     * 
     * ND_myCntrctRegistAction (계약서 등록)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_myCntrctRegistDel.do", method = RequestMethod.POST)
    public String ND_myCntrctRegistDel(ModelMap model, HttpServletRequest request, SuplerCntrctVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setCommUserId(userLoginVO.getUserId());
        }

        OpHelper.bindSearchMap(vo, request);

        int confirmCnt = 0;
            confirmCnt = myCeartService.deleteCntrctCmpl(vo);
        if(confirmCnt <= 0){
            return alertAndRedirect(model, "삭제에 실패하였습니다.", "/korean/pt/myCeart/BD_purchsDtlsList.do");
        }
        
        return alertAndRedirect(model, "삭제가 완료되었습니다.", "/korean/pt/myCeart/BD_purchsDtlsList.do");

    }
    /**
     * BD_myCeartBeforeRequestList
     * BD_mybeffatEstmtAction (사전견적관리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_myCeartBeforeRequestList.do")
    public String BD_myCeartBeforeRequestList(HttpServletRequest request, ModelMap model, MyCeartBeforeNofyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/BD_myCeartBeforeRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
            vo.setBuseoCode(userLoginVO.getBuseoCode());
            vo.setUserTyCd(userLoginVO.getUserTyCd());
        }

        System.out.println("UserTyCd: " + userLoginVO.getUserTyCd());
        model.addAttribute("askApplyCdCodeList", registerService.prvCodeList(vo.getLangCode(), 2043)); // 공통코드의 답변여부

        OpHelper.bindSearchMap(vo, request);
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.myCeartBeforeRequestList(vo));

        vo.setLangCode(Language(request));
        
        return "/korean/pt/myCeart/BD_myCeartBeforeRequestList";
                                   
    }

    /**
     * 
     * BD_requestDetailView (마이씨앗 - 사전견적관리 > 상세화면)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_beforeRequestDetailView.do")
    public String BD_beforeRequestDetailView2(HttpServletRequest request, ModelMap model, MyCeartBidNotifyVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/myCeart/myCeartBeforeRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));
        
        // 입찰공고 마스터 조회
        MyCeartBeforeNofyVO beforeNofyVO = new MyCeartBeforeNofyVO();
        beforeNofyVO.setNotifyNum(vo.getNotifyNum());
        beforeNofyVO.setNotifySeq(vo.getNotifySeq());
        List<MyCeartBeforeNofyVO> requestMstInfo = myCeartService.myCeartBeforeNotifyInfo(beforeNofyVO);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));
        
        // 공급자의 확인정보 조회
        MyCeartBeforeNotifySplyVO beforeNotifySplyVO = new MyCeartBeforeNotifySplyVO();
        beforeNotifySplyVO.setNotifyNum(vo.getNotifyNum());
        beforeNotifySplyVO.setNotifySeq(vo.getNotifySeq());
        beforeNotifySplyVO.setUserId(vo.getLangStoreId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, myCeartService.myCeartBeforeNotifySplyInfo(beforeNotifySplyVO).get(0));
        
        // 해당 견적의 서비스 구분
        String goodKndCd =  requestMstInfo.get(0).getGoodKndCd();

        if(goodKndCd.equals("1001")) // PaaS2
        {
            /*
            MyCeartPaasVO paasVO = new MyCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setUserId(vo.getUserId());
            paasVO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("pass", myCeartService.myCeartBeforeInfoByPass(paasVO)); // PaaS 정보 조회 
             * */
            MyCeartPaas2VO paas2VO = new MyCeartPaas2VO();
            paas2VO.setNotifyNum(vo.getNotifyNum());
            paas2VO.setNotifySeq(vo.getNotifySeq());
            paas2VO.setUserId(vo.getUserId());
            paas2VO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("pass2", myCeartService.myCeartBeforeInfoByPass2(paas2VO)); // PaaS 정보 조회
        }
        else if(goodKndCd.equals("1002")) // SaaS2
        {
            /*
            MyCeartSaasIVO saasIVO = new MyCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setUserId(vo.getUserId());
            saasIVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassI", myCeartService.myCeartBeforeInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            MyCeartSaasDVO saasDVO = new MyCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setUserId(vo.getUserId());
            saasDVO.setLangStoreId(vo.getLangStoreId());

            model.addAttribute("sassD", myCeartService.myCeartBeforeInfoBySassD(saasDVO)); // SaaS 상세정보 조회 
             * */
            MyCeartSaas2IVO saas2IVO = new MyCeartSaas2IVO();
            saas2IVO.setNotifyNum(vo.getNotifyNum());
            saas2IVO.setNotifySeq(vo.getNotifySeq());
            saas2IVO.setUserId(vo.getUserId());
            saas2IVO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("sass2I", myCeartService.myCeartBeforeInfoBySass2I(saas2IVO)); // SaaS2 정보 조회
            
            

            MyCeartSaas2DnVO saas2DnVO = new MyCeartSaas2DnVO();
            saas2DnVO.setNotifyNum(vo.getNotifyNum());
            saas2DnVO.setNotifySeq(vo.getNotifySeq());
            saas2DnVO.setUserId(vo.getUserId());
            saas2DnVO.setLangStoreId(vo.getLangStoreId());

            List<MyCeartSaas2DnVO> myCeartSaas2DnVO = myCeartService.myCeartBeforeInfoBySass2Dn(saas2DnVO) ;
            List<MyCeartSaas2DnVO> myCeartSaas2DnVO_h = new  ArrayList<MyCeartSaas2DnVO>();
            
            Iterator<MyCeartSaas2DnVO> iterator2Dn = myCeartSaas2DnVO.iterator();
            while (iterator2Dn.hasNext())
            {
                MyCeartSaas2DnVO tmp = iterator2Dn.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartSaas2DnVO_h.add(tmp);
            }
            model.addAttribute("sass2Dn_h", myCeartSaas2DnVO_h); // SaaS2 상세Need정보 조회
            model.addAttribute("sass2Dn",   myCeartSaas2DnVO);   // SaaS2 상세Need정보 조회

            MyCeartSaas2DoVO saas2DoVO = new MyCeartSaas2DoVO();
            saas2DoVO.setNotifyNum(vo.getNotifyNum());
            saas2DoVO.setNotifySeq(vo.getNotifySeq());
            saas2DoVO.setUserId(vo.getUserId());
            saas2DoVO.setLangStoreId(vo.getLangStoreId());

            List<MyCeartSaas2DoVO> myCeartSaas2DoVO = myCeartService.myCeartBeforeInfoBySass2Do(saas2DoVO) ;
            List<MyCeartSaas2DoVO> myCeartSaas2DoVO_h = new  ArrayList<MyCeartSaas2DoVO>();
            
            Iterator<MyCeartSaas2DoVO> iterator2Do = myCeartSaas2DoVO.iterator();
            while (iterator2Do.hasNext())
            {
                MyCeartSaas2DoVO tmp = iterator2Do.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartSaas2DoVO_h.add(tmp);
            }
            model.addAttribute("sass2Do_h", myCeartSaas2DoVO_h); // SaaS2 상세Need정보 조회
            model.addAttribute("sass2Do", myCeartSaas2DoVO); // SaaS2 상세Option정보 조회
        }
        else if(goodKndCd.equals("1003"))  // IaaS2
        {
            /*
            MyCeartIaasIVO iaasIVO   = new MyCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setUserId(vo.getUserId());
            iaasIVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassI",  myCeartService.myCeartBeforeInfoByIassI(iaasIVO));   // IaaS 정보 조회
            
            MyCeartIaasDsVO iaasDsVO = new MyCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setUserId(vo.getUserId());
            iaasDsVO.setLangStoreId(vo.getLangStoreId());
            model.addAttribute("iassDs", myCeartService.myCeartBeforeInfoByIassDs(iaasDsVO)); // IaaS Server 정보 조회
            
            MyCeartIaasDdVO iaasDdVO = new MyCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setUserId(vo.getUserId());
            iaasDdVO.setLangStoreId(vo.getLangStoreId());            
            model.addAttribute("iassDd", myCeartService.myCeartBeforeInfoByIassDd(iaasDdVO)); // IaaS DB 정보 조회
             * */
            MyCeartIaas2IVO iaas2IVO   = new MyCeartIaas2IVO();
            iaas2IVO.setNotifyNum(vo.getNotifyNum());
            iaas2IVO.setNotifySeq(vo.getNotifySeq());
            iaas2IVO.setUserId(vo.getUserId());
            iaas2IVO.setLangStoreId(vo.getLangStoreId());
            
            model.addAttribute("iass2I",  myCeartService.myCeartBeforeInfoByIass2I(iaas2IVO));   // IaaS2 정보 조회
            
            MyCeartIaas2DsVO iaas2DsVO = new MyCeartIaas2DsVO();
            iaas2DsVO.setNotifyNum(vo.getNotifyNum());
            iaas2DsVO.setNotifySeq(vo.getNotifySeq());
            iaas2DsVO.setUserId(vo.getUserId());
            iaas2DsVO.setLangStoreId(vo.getLangStoreId());
            
            List<MyCeartIaas2DsVO> myCeartIaas2DsVO = myCeartService.myCeartBeforeInfoByIass2Ds(iaas2DsVO);
            List<MyCeartIaas2DsVO> myCeartIaas2DsVO_h = new ArrayList<MyCeartIaas2DsVO>();
            
            Iterator<MyCeartIaas2DsVO> Iterator2Ds = myCeartIaas2DsVO.iterator();
            while (Iterator2Ds.hasNext())
            {
                MyCeartIaas2DsVO tmp = Iterator2Ds.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartIaas2DsVO_h.add(tmp);
            }            
            model.addAttribute("iass2Ds_h", myCeartIaas2DsVO_h); // IaaS2 Server 정보 조회
            model.addAttribute("iass2Ds",   myCeartIaas2DsVO);   // IaaS2 Server 정보 조회
            
            MyCeartIaas2DdVO iaas2DdVO = new MyCeartIaas2DdVO();
            iaas2DdVO.setNotifyNum(vo.getNotifyNum());
            iaas2DdVO.setNotifySeq(vo.getNotifySeq());
            iaas2DdVO.setUserId(vo.getUserId());
            iaas2DdVO.setLangStoreId(vo.getLangStoreId());
            
            List<MyCeartIaas2DdVO> myCeartIaas2DdVO = myCeartService.myCeartBeforeInfoByIass2Dd(iaas2DdVO);
            List<MyCeartIaas2DdVO> myCeartIaas2DdVO_h = new ArrayList<MyCeartIaas2DdVO>();
            
            Iterator<MyCeartIaas2DdVO> Iterator2Dd = myCeartIaas2DdVO.iterator();
            while (Iterator2Dd.hasNext())
            {
                MyCeartIaas2DdVO tmp = Iterator2Dd.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) myCeartIaas2DdVO_h.add(tmp);
            }            
            model.addAttribute("iass2Dd_h", myCeartIaas2DdVO_h); // IaaS2 DB 정보 조회
            model.addAttribute("iass2Dd",   myCeartIaas2DdVO);   // IaaS2 DB 정보 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/myCeart/BD_beforeRequestDetail2.view";
        /*
        // /korean/pt/myCeart/BD_beforeRequestDetail2.view
        // /korean/pt/myCeart/goods/BD_Paas2.view.jsp
        // /korean/pt/myCeart/goods/BD_Saas2.view.jsp
        // /korean/pt/myCeart/goods/BD_Iaas2.view.jsp
        */
    }
    
    /*
     * 사전견적관리 리스트 삭제
     * */
    @RequestMapping(value = "ND_myCeartBeforeRequestListDelete.do", method = RequestMethod.POST)
    public String myCeartBeforeRequestListDelete(ModelMap model, HttpServletRequest request, MyCeartVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/wish/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }
        
        HashMap<String, String> dataMap = new HashMap<String, String>();
        String[] dataArray = request.getParameter("requestData").split("#");
        int totalDataCnt = dataArray.length;
        int processDataCnt = 0;
        for(int i=0; i<totalDataCnt; i++){
            String[] arrayData = dataArray[i].split("\\|");
            String notifyNum   = arrayData[0];
            String notifySeq   = arrayData[1];
            String userId      = arrayData[2];

            dataMap.put("notifyNum", notifyNum);
            dataMap.put("notifySeq", notifySeq);
            dataMap.put("userId", userId);
            
            processDataCnt +=  myCeartService.myCeartBeforeRequestListDeleteAction(dataMap);
        }
        if(totalDataCnt == processDataCnt) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "finishRequestOk"));
        }
        return responseJson(model, Messages.FALSE, "finishRequestFail");
    }
    
    //상품비교하기 담기
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/BD_goodsTmp.do", method = RequestMethod.POST)
    public String bdGoodsTmpInsert (HttpServletRequest request, ModelMap model, MyCeartVO vo) {
        
        String[] reqItemMap = request.getParameterValues("item[]");
        String reqSessionId = request.getParameter("sessionId");
        String totalKeyword = request.getParameter("totalKeyword"); // 검색어..
        int reqItemMapCnt = reqItemMap.length;
        String userId = "";//userLoginVO.getUserId();
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isEmpty(userLoginVO)) {
            userId = reqSessionId;
        }else {
            userId = userLoginVO.getUserId();
        }
        
        HashMap<String, String> dataMap = new HashMap<String, String>();  
        if(!Validate.isEmpty(reqSessionId)) 
        {            
            dataMap.put("userId",       userId);
            dataMap.put("sessionId",    reqSessionId);
            dataMap.put("totalKeyword", totalKeyword);            
            
            if (reqItemMapCnt > 0) 
            {                
                for(int i=0; i<reqItemMapCnt; i++)
                {
                    if(!reqItemMap[i].equals(""))
                    {
                        dataMap.put("item", reqItemMap[i]);
                        myCeartService.insertbdGoodsTmp(dataMap);
                    }
                }
            }
            
            List bgGoodsList = myCeartService.selectBgGoodsList(dataMap);
            model.addAttribute("bgGoodsList", bgGoodsList);//.addAllAttributes(bgGoodsList);
            model.addAttribute("bgGoodsCnt",  bgGoodsList.size());            
            
            return responseJson(model, bgGoodsList);
        }else {
            return responseJson(model, Boolean.FALSE);
        }
    }
    
    @RequestMapping(value = "/BD_goodsTmpDelete.do", method = RequestMethod.POST)
    public String dbGoodsTmpDelete (HttpServletRequest request, ModelMap model, MyCeartVO vo) {
        String reqItemMap = request.getParameter("item");
        String reqSessionId = request.getParameter("sessionId");
        String userId = "";//userLoginVO.getUserId();
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
 
        if(Validate.isEmpty(userLoginVO)) {
            userId = reqSessionId;
        }else {
            userId = userLoginVO.getUserId();
        }
        
        HashMap<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("item", reqItemMap);
        dataMap.put("userId", userId);
        dataMap.put("sessionId", reqSessionId);

        myCeartService.deleteBdGoodsTmp(dataMap);
        
        List<String> bgGoodsList = myCeartService.selectBgGoodsList(dataMap);
        
        model.addAttribute("bgGoodsList", bgGoodsList);
        return responseJson(model, bgGoodsList);
    }
    
}
