/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.tagext.IterationTag;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.alarm.AlarmService;
import zes.openworks.web.alarm.AlarmVO;
import zes.openworks.web.before.BeforeService;
import zes.openworks.web.before.BeforeSuplerListVO;
import zes.openworks.web.bid.BidService;
import zes.openworks.web.bid.BidSuplerListVO;
import zes.openworks.web.bidSttus.BidSttusService;
import zes.openworks.web.bidSttus.vo.BidSttusListVO;
import zes.openworks.web.bidSttus.vo.BidSttusNotifySplyVO;
import zes.openworks.web.bidSttus.vo.SuplerServiceVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.myCeart.vo.MyCeartIaas2DsVO;
import zes.openworks.web.myCeart.vo.MyCeartSaas2DnVO;
import zes.openworks.web.myCeart.vo.MyCeartTenderVO;
import zes.openworks.web.register.RegisterService;
import zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartBidPartcptnVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartExcelVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2DdVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2DsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaas2IVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDdVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaas2VO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2DnVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2DoVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaas2IVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartScs2VO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSuplySttusVO;
import zes.openworks.web.suplerCeart.vo.SuplerCntrctVO;
import zes.openworks.web.suplerCeart.vo.SuplySttusEndsUserVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2016. 12. 26.    방기배       신규
 * 2017. 12. 12.    SKYOU  수정    공급현황>계약수기등록
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = {"/**/suplerCeart"})
public class SuplerCeartController extends WebController{

    /** 공급자씨앗 관련 서비스 */
    @Autowired
    SuplerCeartService service;
    
    @Autowired
    private RegisterService registerService;

    /** 마이씨앗 관련 서비스 */
    @Autowired
    MyCeartService myCeartService;

    /** 입찰공고 서비스 */
    @Autowired
    BidSttusService bidSttusService;

    /** 공통코드 관련 서비스 */
    @Autowired
    CodeService codeService;
    
    /** 공통 관련 서비스 */
    @Autowired
    CommonDutyService commonService;

    /** 공고/견적 등록 관련 서비스 */
    @Autowired
    BidService bidService;
    
    /** 사견적 등록 관련 서비스 */
    @Autowired
    BeforeService beforeService;

    /** 알람 관련 서비스 */
    @Autowired
    AlarmService alarmService;
    
    @Autowired
    private AutoMailService amservice;
    
    @Autowired
    private SmsTransHistService smsService;
    
    /** 파일 저장 경로 */
    public static final String SUPLER_FILE_PATH = "supler" + File.separator;

    // 접속 사용자 도메인 값 불러와서 가져오기
    public String Language(HttpServletRequest request) {
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }

    /**
     * 공급자 씨앗 - 상세정보(견적)요청 답변관리
     * */
    @RequestMapping(value = "/BD_buyingRequestList.do")
    public String BD_buyingRequestList(HttpServletRequest request, ModelMap model, SuplerCeartVO vo) {

        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_buyingRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

        /*공통코드 설정 - 답변여부*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2043);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_askApplyCd", codeService.codeList(codeVO));

        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.buyingRequestList(vo));

        return "/korean/pt/suplerCeart/BD_buyingRequestList";
    }
    
    /**
     * 공급자씨앗 - 상세정보(견적)요청서 관리 - 엑셀다운로드
     * */
    @RequestMapping(value="INC_EXCEL.do")
    public String excel(HttpServletRequest request, ModelMap model, SuplerCeartVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setSuplerId(userLoginVO.getUserId());

        OpHelper.bindSearchMap(vo, request);
        //vo.getDataMap().put("q_userId", userLoginVO.getUserId());

        model.put("q_excel", "01"); // 목록별 구분값
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", service.buyingRequestListExcel(vo));
        model.put("q_excelFileName", "견적요청서 목록");

        SuplerCeartExcelVO suplerCeartExcel = new SuplerCeartExcelVO();
        suplerCeartExcel.setModel(model);
        suplerCeartExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, suplerCeartExcel);
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
    public String BD_requestDetailView(HttpServletRequest request, ModelMap model, SuplerCeartBidNotifyVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_buyingRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 조회글의 Key값 바인딩
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));

        // 입찰공고 공급자 확인정보의 확인여부 update
        service.updateSplyConfmGbn(vo);

        // 입찰공고 마스터 조회
        List<SuplerCeartBidNotifyVO> requestMstInfo = service.suplerCeartBidNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자의 확인정보 조회
        SuplerCeartNotifySplyVO notifySplyVO = new SuplerCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());
        notifySplyVO.setSuplerId(vo.getSuplerId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.suplerCeartNotifySplyInfo(notifySplyVO).get(0));

        // 해당 견적의 서비스 구분
        String goodKndCd  =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );
        String endsUserId =  requestMstInfo.get(0).getEndsUserId() ;  // 견적의 수요자ID


        if(goodKndCd.equals("1001"))
        {
            /*
            SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setEndsUserId(endsUserId);         // 수요자 ID
            paasVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass", service.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회
            */
            SuplerCeartPaas2VO paas2VO = new SuplerCeartPaas2VO();
            paas2VO.setNotifyNum(vo.getNotifyNum());
            paas2VO.setNotifySeq(vo.getNotifySeq());
            paas2VO.setEndsUserId(endsUserId);         // 수요자 ID
            paas2VO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass", service.suplerCeartInfoByPass2(paas2VO)); // PaaS 정보 조회
        }
        else if(goodKndCd.equals("1002"))
        {
            /*
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", service.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", service.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

            // 공통코드 설정 - SaaS 시스템 요구조건 단위
            CodeVO codeVO = new CodeVO();
            codeVO.setGrpCd(2041);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_unitSys", codeService.codeList(codeVO));
            
            // 공통코드 설정 - SaaS 시스템 요구조건 제공방법
            codeVO.setGrpCd(2042);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_splyMothSys", codeService.codeList(codeVO));
            */
            
            SuplerCeartSaas2IVO saas2IVO = new SuplerCeartSaas2IVO();
            saas2IVO.setNotifyNum(vo.getNotifyNum());
            saas2IVO.setNotifySeq(vo.getNotifySeq());
            saas2IVO.setEndsUserId(endsUserId);         // 수요자 ID
            saas2IVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sass2I", service.suplerCeartInfoBySass2I(saas2IVO)); // SaaS 정보 조회
            
            model.addAttribute("supplyMethodCodeList",    registerService.prvCodeList(vo.getLangCode(), 2042)); // 공통코드의 제공방법코드(2042)
            model.addAttribute("totUnitCodeList",         registerService.prvCodeList(vo.getLangCode(), 2041)); // 공통코드의 전체단위코드(2041)
            model.addAttribute("userManagerSeparateList", registerService.prvCodeList(vo.getLangCode(), 2061)); // 공통코드의 사용자/관리자분리코드(2061)
            model.addAttribute("serviceSupplyMethodList", registerService.prvCodeList(vo.getLangCode(), 2062)); // 공통코드의 서비스제공방식코드(2062)
            model.addAttribute("encryptionList",          registerService.prvCodeList(vo.getLangCode(), 2063)); // 공통코드의 암호화코드(2063)
            
            SuplerCeartSaas2DnVO saas2DnVO = new SuplerCeartSaas2DnVO();
            saas2DnVO.setNotifyNum(vo.getNotifyNum());
            saas2DnVO.setNotifySeq(vo.getNotifySeq());
            saas2DnVO.setEndsUserId(endsUserId);         // 수요자 ID
            saas2DnVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sass2Dn", service.suplerCeartInfoBySass2Dn(saas2DnVO)); // SaaS 상세정보 (필요) 조회
            
            SuplerCeartSaas2DoVO saas2DoVO = new SuplerCeartSaas2DoVO();
            saas2DoVO.setNotifyNum(vo.getNotifyNum());
            saas2DoVO.setNotifySeq(vo.getNotifySeq());
            saas2DoVO.setEndsUserId(endsUserId);         // 수요자 ID
            saas2DoVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sass2Do", service.suplerCeartInfoBySass2Do(saas2DoVO)); // SaaS 상세정보 (옵션) 조회

        }
        else if(goodKndCd.equals("1003"))
        {
            /*
            SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassI", service.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", service.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", service.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
            */
            
            SuplerCeartIaas2IVO iaas2IVO = new SuplerCeartIaas2IVO();
            iaas2IVO.setNotifyNum(vo.getNotifyNum());
            iaas2IVO.setNotifySeq(vo.getNotifySeq());
            iaas2IVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaas2IVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iass2I", service.suplerCeartInfoByIass2I(iaas2IVO));   // IaaS2 마스터 정보 조회
            
            SuplerCeartIaas2DsVO iaas2DsVO = new SuplerCeartIaas2DsVO();
            iaas2DsVO.setNotifyNum(vo.getNotifyNum());
            iaas2DsVO.setNotifySeq(vo.getNotifySeq());
            iaas2DsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaas2DsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iass2Ds", service.suplerCeartInfoByIass2Ds(iaas2DsVO)); // IaaS 서버문의 조회

            SuplerCeartIaas2DdVO iaas2DdVO = new SuplerCeartIaas2DdVO();
            iaas2DdVO.setNotifyNum(vo.getNotifyNum());
            iaas2DdVO.setNotifySeq(vo.getNotifySeq());
            iaas2DdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaas2DdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iass2Dd", service.suplerCeartInfoByIass2Dd(iaas2DdVO)); // IaaS DB문의 조회
            
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/suplerCeart/BD_requestDetail.view";
        /*
        // /korean/pt/suplerCeart/BD_requestDetail.view
        // /korean/pt/suplerCeart/goods/BD_Paas2.view.jsp
        // /korean/pt/suplerCeart/goods/BD_Saas2.view.jsp
        // /korean/pt/suplerCeart/goods/BD_Iaas2.view.jsp 
        */
    }
    
    /**
     * 
     * ND_suplerReturnRequestAction (견적요청 반려처리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_suplerReturnRequestAction.do",  method = RequestMethod.POST)
    public String ND_suplerReturnRequestAction(HttpServletRequest request, ModelMap model, SuplerCeartVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_requestDetailView.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        int rtnVal = service.suplerReturnRequestAction(vo);
        
        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
        // 알람처리
        BidSuplerListVO suplerVO = new BidSuplerListVO();
        suplerVO.setNotifyNum(vo.getNotifyNum());
        suplerVO.setNotifySeq(vo.getNotifySeq());
        suplerVO.setSuplerId(userLoginVO.getUserId());
        
        List<BidSuplerListVO> suplerList = bidService.selectSuplerList(suplerVO);

        for(int i=0; i<suplerList.size(); i++){
            AlarmVO alarmVO = new AlarmVO();
            alarmVO.setAlarmBizGbn("02");
            alarmVO.setUserId(suplerList.get(i).getSuplerId());
            alarmVO.setAlarmTitle("견적요청이 반려되었습니다.");
            alarmVO.setConfrmId(suplerList.get(i).getUserId());
            alarmVO.setConfrmGbn("N");
            
            // 입찰공고 공급자 알람처리
            alarmService.alarmInsert(alarmVO);  

            // 이메일
            if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                Map<String, Object> autoMap = new HashMap<String, Object>();
                HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                autoMap.put("oneToOneInfo", oneToOneInfoMap);
                autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                boolean result = amservice.sendAutoMail(autoMap);
            }
            
            // SMS
            if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                Map<String, Object> smsMap = new HashMap<String, Object>();
                smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                smsMap.put("msg", "견적요청이 반려되었습니다.");
                smsMap.put("dutyCd", "BM");
                boolean smsRst = smsService.smsTransHist(smsMap);
            }
        }
        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

        if(rtnVal > 0){
            // 목록으로 이동
            return alertAndRedirect(model, "반려처리가 완료 되었습니다.", "/korean/pt/suplerCeart/BD_buyingRequestList.do");            
        }

        // 목록으로 이동
        String rtnUrl = "/korean/pt/suplerCeart/BD_requestDetailView.do?p_notifyNum="+request.getParameter("notifyNum") + "&p_notifySeq=" + request.getParameter("notifySeq");
        return alertAndRedirect(model, "반려처리중 오류가 발생되었습니다.", rtnUrl);
    }

    /**
     * 
     * ND_suplerSendRequestAction (견적요청 발송)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_suplerSendRequestAction.do",  method = RequestMethod.POST)
    public String ND_suplerSendRequestAction(HttpServletRequest request, ModelMap model, SuplerCeartNotifySplyVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_requestDetailView.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, SUPLER_FILE_PATH);
        List<FileVO> splyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("splyFile")) {
                splyFile.add(uploadFile.get(i));
            }
        }
        vo.setSplyFileList(splyFile);
        
        // 입찰공고 공급자 확인정보 등록
        int rtnVal = service.updateNotifySplyAction(vo);

        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
        // 알람처리
        BidSuplerListVO suplerVO = new BidSuplerListVO();
        suplerVO.setNotifyNum(vo.getNotifyNum());
        suplerVO.setNotifySeq(vo.getNotifySeq());
        suplerVO.setSuplerId(userLoginVO.getUserId());
        
        List<BidSuplerListVO> suplerList = bidService.selectSuplerList(suplerVO);

        for(int i=0; i<suplerList.size(); i++){
            AlarmVO alarmVO = new AlarmVO();
            alarmVO.setAlarmBizGbn("02");
            alarmVO.setUserId(suplerList.get(i).getSuplerId());
            alarmVO.setAlarmTitle("견적요청 답변이 등록되었습니다.");
            alarmVO.setConfrmId(suplerList.get(i).getUserId());
            alarmVO.setConfrmGbn("N");
            
            // 입찰공고 공급자 알람처리
            alarmService.alarmInsert(alarmVO);     
            
            // 이메일
            if(suplerList.get(i).getSuplerEmail() != null && !suplerList.get(i).getSuplerEmail().trim().equals("")){
                Map<String, Object> autoMap = new HashMap<String, Object>();
                HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                autoMap.put("oneToOneInfo", oneToOneInfoMap);
                autoMap.put("automailId", AutoMailTemplate.KOR_BID_03REQ);
                autoMap.put("receiverName", suplerList.get(i).getSuplerName()); // 수신자명
                autoMap.put("email",  suplerList.get(i).getSuplerEmail()); // 수신이메일주소
                boolean result = amservice.sendAutoMail(autoMap);
            }
            
            // SMS
            if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                Map<String, Object> smsMap = new HashMap<String, Object>();
                smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                smsMap.put("msg", "견적요청 답변이 등록되었습니다.");
                smsMap.put("dutyCd", "BM");
                boolean smsRst = smsService.smsTransHist(smsMap);
            }
        }
        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

        // 입찰 공고 공급자 정보 수정이 완료되었으면 각 서비스에 맞는 답변 등록
        // 해당 견적의 서비스 구분
        String goodKndCd  = request.getParameter("goodKndCd");
        if(rtnVal> 0 ){
            if(goodKndCd.equals("1001")){
                SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
                paasVO.setNotifyNum(vo.getNotifyNum());                         // 공고번호
                paasVO.setNotifySeq(vo.getNotifySeq());                         // 공고차수
                paasVO.setSuplerId(vo.getSuplerId());                           // 공급자ID
                paasVO.setApplyGbn("Y");                                        // 답변여부
                paasVO.setLangSys(request.getParameter("langSys"));             // language
                paasVO.setFrameworkSys(request.getParameter("frameworkSys"));   // framework
                paasVO.setCacheSys(request.getParameter("cacheSys"));           // cache
                paasVO.setDbmsSys(request.getParameter("dbmsSys"));             // dbms
                paasVO.setFastDeploySys(request.getParameter("fastDeploySys")); // fast deploy
                paasVO.setEtcSys(request.getParameter("etcSys"));               // etc

                // 입찰공고 PaaS 답변 등록
                service.insertPaasAnswerAction(paasVO);

            }else if(goodKndCd.equals("1002")){
                SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
                saasIVO.setNotifyNum(vo.getNotifyNum());                     // 공고번호
                saasIVO.setNotifySeq(vo.getNotifySeq());                     // 공고차수
                saasIVO.setSuplerId(vo.getSuplerId());                       // 공급자ID
                saasIVO.setApplyGbn("Y");                                    // 답변여부
                saasIVO.setUnitSys(request.getParameter("unitSys"));         // 전체단위
                saasIVO.setEtcUnitSys(request.getParameter("etcUnitSys"));   // 기타단위내용
                saasIVO.setCaptySys(request.getParameter("captySys"));       // 전체제공용량
                saasIVO.setAmountSys(request.getParameter("amountSys"));     // 전체단가
                saasIVO.setSplyMothSys(request.getParameter("splyMothSys")); // 제공방법

                // 입찰공고 SaaS 마스터 답변 등록
                service.insertSaasIAnswerAction(saasIVO);

                // 입찰공고 SaaS 상세 답변 등록
                String[] optionNm   = request.getParameterValues("optionNm");
                String[] unitItem   = request.getParameterValues("unitItem");
                String[] captyItem  = request.getParameterValues("captyItem");
                String[] amountItem = request.getParameterValues("amountItem");
                String[] cmntItem   = request.getParameterValues("cmntItem");
                
                // Saas 상세정보가 없을 경우 skip
                if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                    
                }else{
                    for(int i=0; i<optionNm.length; i++){
                        SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
                        saasDVO.setNotifyNum(vo.getNotifyNum());                // 공고번호
                        saasDVO.setNotifySeq(vo.getNotifySeq());                // 공고차수
                        saasDVO.setSuplerId(vo.getSuplerId());                  // 공급자ID
                        saasDVO.setApplySeq(i+1);                               // 답변순번
                        saasDVO.setOptionNm(optionNm[i]);                       // 옵션명
                        saasDVO.setUnitItem(unitItem[i]);                       // 개별단위
                        saasDVO.setCaptyItem(captyItem[i]);                     // 개별제공용량
                        saasDVO.setAmountItem(Integer.parseInt(amountItem[i])); // 개별단가
                        saasDVO.setCmntItem(cmntItem[i]);                       // 설명

                        // 입찰공고 SaaS 상세정보 등록
                        service.insertSaasDAnswerAction(saasDVO);
                    }                
                }

            }else if(goodKndCd.equals("1003")){
                SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
                iaasIVO.setNotifyNum(vo.getNotifyNum());                                       // 공고번호
                iaasIVO.setNotifySeq(vo.getNotifySeq());                                       // 공고차수
                iaasIVO.setSuplerId(vo.getSuplerId());                                         // 공급자ID
                iaasIVO.setApplyGbn("Y");                                                      // 답변여부
                iaasIVO.setCdnTransVlmn(request.getParameter("cdnTransVlmn"));
                iaasIVO.setCdnRequCnt(request.getParameter("cdnRequCnt"));
                iaasIVO.setWebGoodsKind(request.getParameter("webGoodsKind"));
                iaasIVO.setWebAccess(request.getParameter("webAccess"));
                iaasIVO.setMntingVm(request.getParameter("mntingVm"));
                iaasIVO.setMntingIdCnt(request.getParameter("mntingIdCnt"));
                iaasIVO.setBakupCnt(request.getParameter("bakupCnt"));
                iaasIVO.setBakupStorg(request.getParameter("bakupStorg"));
                iaasIVO.setMangFunc(request.getParameter("mangFunc"));
                iaasIVO.setSectyVpn(request.getParameter("sectyVpn"));
                iaasIVO.setSectySslvpn(request.getParameter("sectySslvpn"));
                iaasIVO.setTechSupt(request.getParameter("techSupt"));
                iaasIVO.setFuncDmnd1(request.getParameter("funcDmnd1"));
                iaasIVO.setFuncDmnd2(request.getParameter("funcDmnd2"));
                iaasIVO.setFuncDmnd3(request.getParameter("funcDmnd3"));
                iaasIVO.setFuncDmnd4(request.getParameter("funcDmnd4"));
                iaasIVO.setInterfaceDmnd(request.getParameter("interfaceDmnd"));
                iaasIVO.setSectyDmnd1(request.getParameter("sectyDmnd1"));
                iaasIVO.setSectyDmnd2(request.getParameter("sectyDmnd2"));
                iaasIVO.setSectyDmnd3(request.getParameter("sectyDmnd3"));
                iaasIVO.setSectyDmnd4(request.getParameter("sectyDmnd4"));
                iaasIVO.setSectyDmnd5(request.getParameter("sectyDmnd5"));
                iaasIVO.setQutyDmnd1(request.getParameter("qutyDmnd1"));
                iaasIVO.setQutyDmnd2(request.getParameter("qutyDmnd2"));
                iaasIVO.setOptnDmnd1(request.getParameter("optnDmnd1"));
                iaasIVO.setOptnDmnd2(request.getParameter("optnDmnd2"));
                iaasIVO.setPrjtDmnd1(request.getParameter("prjtDmnd1"));
                iaasIVO.setPrjtDmnd2(request.getParameter("prjtDmnd2"));
                iaasIVO.setPrjtDmnd3(request.getParameter("prjtDmnd3"));
                iaasIVO.setEtcDmnd(request.getParameter("etcDmnd"));
                // 입찰공고 IaaS 마스터 답변 등록
                service.insertIaasIAnswerAction(iaasIVO);

                // 입찰공고 IaaS 서버 답변 등록
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
                        SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
                        iaasDsVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                        iaasDsVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                        iaasDsVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                        iaasDsVO.setServerUse(serverUse[i]);         // 서버 용도
                        iaasDsVO.setServerOs(serverOs[i]);           // 서버 OS
                        iaasDsVO.setServerCpu(serverCpu[i]);         // 서버 CPU
                        iaasDsVO.setServerMemory(serverMemory[i]);   // 서버 메모리
                        iaasDsVO.setServerDisk(serverDisk[i]);       // 서버 DISK
                        iaasDsVO.setServerQnty(serverQnty[i]);       // 서버 수량
                        iaasDsVO.setServerIp(serverIp[i]);           // 서버 IP
                        iaasDsVO.setServerNetwork(serverNetwork[i]); // 서버 트래픽
                        iaasDsVO.setServerGslb(serverGslb[i]);       // 서버 GSLB
                        iaasDsVO.setServerLdbl(serverLdbl[i]);       // 서버 로드밸런서
                        iaasDsVO.setServerSnap(serverSnap[i]);       // 서버 스냅샷
                        iaasDsVO.setServerImg(serverImg[i]);         // 서버 이미지

                        // 입찰공고 IaaS 상세정보(서버) 등록
                        service.insertIaasDsAnswerAction(iaasDsVO);
                    }                
                }

                // 입찰공고 IaaS DB 답변 등록
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
                        
                        SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
                        iaasDdVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                        iaasDdVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                        iaasDdVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                        iaasDdVO.setDbUse(dbUse[j]);                 // DB 용도
                        iaasDdVO.setDbOs(dbOs[j]);                   // DB OS
                        iaasDdVO.setDbCpu(dbCpu[j]);                 // DB CPU
                        iaasDdVO.setDbMemory(dbMemory[j]);           // DB 메모리
                        iaasDdVO.setDbDisk(dbDisk[j]);               // DB DISK
                        iaasDdVO.setDbQnty(dbQnty[j]);               // DB 수량
                        iaasDdVO.setDbIp(dbIp[j]);                   // DB IP
                        iaasDdVO.setDbNetwork(dbNetwork[j]);         // DB 네트워크 트레픽
                        iaasDdVO.setDbAddDisk(dbAddDisk[j]);         // DB 추가 디스크
                        iaasDdVO.setDbBackStorg(dbBackStorg[j]);     // DB 백업 스토리지
                        iaasDdVO.setDbStorgSpace(dbStorgSpace[j]);   // DB 저장공간
                        iaasDdVO.setDbTransVlmn(dbTransVlmn[j]);     // DB 전송량

                        // 입찰공고 IaaS 상세정보(서버) 등록
                        service.insertIaasDdAnswerAction(iaasDdVO);
                    }                
                }
            }
        }
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        if(rtnVal > 0){
            // 목록으로 이동
            return alertAndRedirect(model, "견적요청 답변이 등록되었습니다.", "/korean/pt/suplerCeart/BD_buyingRequestList.do");            
        }

        // 목록으로 이동
        String rtnUrl = "/korean/pt/suplerCeart/BD_requestDetailView.do?p_notifyNum="+request.getParameter("notifyNum") + "&p_notifySeq=" + request.getParameter("notifySeq");
        return alertAndRedirect(model, "발송처리중 오류가 발생되었습니다.", rtnUrl);
    }


    /**
     * 공급자 씨앗 - 입찰참여현황
     * */
    @RequestMapping(value = "/BD_bidPartcptnList.do")
    public String BD_bidPartcptnList(HttpServletRequest request, ModelMap model, SuplerCeartBidPartcptnVO vo) {

        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_bidPartcptnList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );          
        }
        
        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

        //입찰 참여현황 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.bidPartcptnList(vo));

        return "/korean/pt/suplerCeart/BD_bidPartcptnList";
    }
    
    /**
     * 
     * BD_bidSttusDetailView (공급자씨앗 - 공고 상세조회)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_bidSttusDetailView.do")
    public String BD_bidSttusDetailView(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_bidPartcptnList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        // 조회글의 Key값 바인딩
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));

        // 입찰공고 마스터 조회
        SuplerCeartBidNotifyVO bidNotifyVO = new SuplerCeartBidNotifyVO();
        // 조회글의 Key값 바인딩
        bidNotifyVO.setNotifyNum(vo.getNotifyNum());
        bidNotifyVO.setNotifySeq(vo.getNotifySeq());
        List<SuplerCeartBidNotifyVO> requestMstInfo = service.suplerCeartBidNotifyInfo(bidNotifyVO);
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
//        myCeartTenderVO.setAskApplyCd( Integer.parseInt("1003") );  // 답변상태(1003:답변)
//        myCeartTenderVO.setBidPgesStat( Integer.parseInt(requestMstInfo.get(0).getBidPgesStat()) ); // 입찰진행상태(1002:응찰)
        model.addAttribute(GlobalConfig.KEY_PAGER, myCeartService.myCeartTenderList(myCeartTenderVO));
        
        // 해당 견적의 서비스 구분
        String goodKndCd  =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );
        String endsUserId =  requestMstInfo.get(0).getEndsUserId() ;  // 견적의 수요자ID

        if(goodKndCd.equals("1001")){
            SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setEndsUserId(endsUserId);         // 수요자 ID
            paasVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass", service.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", service.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", service.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

            /*공통코드 설정 - SaaS 시스템 요구조건 단위*/
            CodeVO codeVO = new CodeVO();
            codeVO.setGrpCd(2041);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_unitSys", codeService.codeList(codeVO));
            /*공통코드 설정 - SaaS 시스템 요구조건 제공방법*/
            codeVO.setGrpCd(2042);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_splyMothSys", codeService.codeList(codeVO));

        }else if(goodKndCd.equals("1003")){
            SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassI", service.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", service.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", service.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

        return "/korean/pt/suplerCeart/BD_bidSttusDetail.view";
        
    }
    

    /**
     * 
     * BD_bidExtendView (공급자씨앗 - 공고 응찰 페이지 호출)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_bidExtendView.do")
    public String BD_bidExtendView(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_bidPartcptnList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        // 조회글의 Key값 바인딩
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));

        // 입찰공고 마스터 조회
        SuplerCeartBidNotifyVO bidNotifyVO = new SuplerCeartBidNotifyVO();
        // 조회글의 Key값 바인딩
        bidNotifyVO.setNotifyNum(vo.getNotifyNum());
        bidNotifyVO.setNotifySeq(vo.getNotifySeq());
        List<SuplerCeartBidNotifyVO> requestMstInfo = service.suplerCeartBidNotifyInfo(bidNotifyVO);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자의 확인정보 조회
        SuplerCeartNotifySplyVO notifySplyVO = new SuplerCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());
        notifySplyVO.setSuplerId(vo.getSuplerId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, bidSttusService.suplerBidSttusInfo(notifySplyVO).get(0));

        // 해당 견적의 서비스 구분
        String goodKndCd  =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );
        String endsUserId =  requestMstInfo.get(0).getEndsUserId() ;  // 견적의 수요자ID

        if(goodKndCd.equals("1001")){
            SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setEndsUserId(endsUserId);         // 수요자 ID
            paasVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass", service.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", service.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", service.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

            /*공통코드 설정 - SaaS 시스템 요구조건 단위*/
            CodeVO codeVO = new CodeVO();
            codeVO.setGrpCd(2041);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_unitSys", codeService.codeList(codeVO));
            /*공통코드 설정 - SaaS 시스템 요구조건 제공방법*/
            codeVO.setGrpCd(2042);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_splyMothSys", codeService.codeList(codeVO));

        }else if(goodKndCd.equals("1003")){
            SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassI", service.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", service.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", service.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());
        
        String entendDiv = request.getParameter("p_entendDiv");
        String rtnPage = "";
        if(entendDiv.equals("A")){
            rtnPage = "/korean/pt/suplerCeart/BD_bidExtend.view";
        }else{
            rtnPage = "/korean/pt/suplerCeart/BD_bidExtend.info";
        }
        return rtnPage;
    }


    /**
     * 
     * ND_bidExtendAction (공고 응찰 처리)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_bidExtendAction.do",  method = RequestMethod.POST)
    public String ND_bidExtendAction(HttpServletRequest request, ModelMap model, BidSttusNotifySplyVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_requestDetailView.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        
        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, SUPLER_FILE_PATH);
        List<FileVO> splyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("splyFile")) {
                splyFile.add(uploadFile.get(i));
            }
        }
        vo.setSplyFileList(splyFile);
        vo.setBidPgesStat( Integer.parseInt("1002") ); // 입찰진행상태는 입찰(1002)

        // 입찰공고 공급자 확인정보 등록
        int rtnVal = bidSttusService.updateNotifySplyAction(vo);

        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
        // 알람처리
        BidSuplerListVO suplerVO = new BidSuplerListVO();
        suplerVO.setNotifyNum(vo.getNotifyNum());
        suplerVO.setNotifySeq(vo.getNotifySeq());
        suplerVO.setSuplerId(userLoginVO.getUserId());
        
        List<BidSuplerListVO> suplerList = bidService.selectSuplerList(suplerVO);

        for(int i=0; i<suplerList.size(); i++){
            // 지명경쟁의 답변 등록일때만 처리
            if(suplerList.get(i).getCntrMothod().equals("1004")){
                AlarmVO alarmVO = new AlarmVO();
                alarmVO.setAlarmBizGbn("04");
                alarmVO.setUserId(suplerList.get(i).getSuplerId());
                alarmVO.setAlarmTitle("입찰 답변이 등록되었습니다.");
                alarmVO.setConfrmId(suplerList.get(i).getUserId());
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
                    smsMap.put("msg", "입찰 답변이 등록되었습니다.");
                    smsMap.put("dutyCd", "BM");
                    boolean smsRst = smsService.smsTransHist(smsMap);
                }
            }
        }
        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

        if(rtnVal == 0){
            rtnVal = bidSttusService.insertNotifySplyAction(vo);
        }

        // 입찰 공고 공급자 정보 등록/수정이 완료되었으면 각 서비스에 맞는 답변 등록
        // 해당 견적의 서비스 구분
        String goodKndCd  = request.getParameter("goodKndCd");

        if(rtnVal> 0 ){
            if(goodKndCd.equals("1001")){
                SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
                paasVO.setNotifyNum(vo.getNotifyNum());                         // 공고번호
                paasVO.setNotifySeq(vo.getNotifySeq());                         // 공고차수
                paasVO.setSuplerId(vo.getSuplerId());                           // 공급자ID
                paasVO.setApplyGbn("Y");                                        // 답변여부
                paasVO.setLangSys(request.getParameter("langSys"));             // language
                paasVO.setFrameworkSys(request.getParameter("frameworkSys"));   // framework
                paasVO.setCacheSys(request.getParameter("cacheSys"));           // cache
                paasVO.setDbmsSys(request.getParameter("dbmsSys"));             // dbms
                paasVO.setFastDeploySys(request.getParameter("fastDeploySys")); // fast deploy
                paasVO.setEtcSys(request.getParameter("etcSys"));               // etc

                // 입찰공고 PaaS 답변 등록(Update 처리건이 없을경우 신규건으로 간주)
                int paasVal = service.updatePaasAnswerAction(paasVO);
                if(paasVal == 0 ){
                    service.insertPaasAnswerAction(paasVO);    
                }
            }else if(goodKndCd.equals("1002")){
                SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
                saasIVO.setNotifyNum(vo.getNotifyNum());                     // 공고번호
                saasIVO.setNotifySeq(vo.getNotifySeq());                     // 공고차수
                saasIVO.setSuplerId(vo.getSuplerId());                       // 공급자ID
                saasIVO.setApplyGbn("Y");                                    // 답변여부
                saasIVO.setUnitSys(request.getParameter("unitSys"));         // 전체단위    
                saasIVO.setEtcUnitSys(request.getParameter("etcUnitSys"));   // 기타단위내용
                saasIVO.setCaptySys(request.getParameter("captySys"));       // 전체제공용량
                saasIVO.setAmountSys(request.getParameter("amountSys"));     // 전체단가    
                saasIVO.setSplyMothSys(request.getParameter("splyMothSys")); // 제공방법    

                // 입찰공고 SaaS 마스터 답변 등록(Update 처리건이 없을경우 신규건으로 간주)
                int saasVal = service.updateSaasIAnswerAction(saasIVO);
                if(saasVal == 0 ){
                    service.insertSaasIAnswerAction(saasIVO);    
                }

                // 입찰공고 SaaS 상세 답변 등록
                String[] optionNm   = request.getParameterValues("optionNm");
                String[] unitItem   = request.getParameterValues("unitItem");
                String[] captyItem  = request.getParameterValues("captyItem");
                String[] amountItem = request.getParameterValues("amountItem");
                String[] cmntItem   = request.getParameterValues("cmntItem");

                // 입찰공고 SaaS 상세정보 삭제(상세정보는 삭제 후 재등록)
                service.deleteSaasDAnswerAction(saasIVO);
                
                if(optionNm != null){
                    // Saas 상세정보가 없을 경우 skip
                    if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                        
                    }else{
                        for(int i=0; i<optionNm.length; i++){
                            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
                            saasDVO.setNotifyNum(vo.getNotifyNum());                // 공고번호
                            saasDVO.setNotifySeq(vo.getNotifySeq());                // 공고차수
                            saasDVO.setSuplerId(vo.getSuplerId());                  // 공급자ID
                            saasDVO.setApplySeq(i+1);                               // 답변순번
                            saasDVO.setOptionNm(optionNm[i]);                       // 옵션명
                            saasDVO.setUnitItem(unitItem[i]);                       // 개별단위
                            saasDVO.setCaptyItem(captyItem[i]);                     // 개별제공용량
                            saasDVO.setAmountItem(Integer.parseInt(amountItem[i])); // 개별단가
                            saasDVO.setCmntItem(cmntItem[i]);                       // 설명

                            // 입찰공고 SaaS 상세정보 등록
                            service.insertSaasDAnswerAction(saasDVO);
                        }                
                    }
                }

            }else if(goodKndCd.equals("1003")){
                SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
                iaasIVO.setNotifyNum(vo.getNotifyNum());                                       // 공고번호
                iaasIVO.setNotifySeq(vo.getNotifySeq());                                       // 공고차수
                iaasIVO.setSuplerId(vo.getSuplerId());                                         // 공급자ID
                iaasIVO.setApplyGbn("Y");                                                      // 답변여부
                iaasIVO.setCdnTransVlmn(request.getParameter("cdnTransVlmn"));
                iaasIVO.setCdnRequCnt(request.getParameter("cdnRequCnt"));
                iaasIVO.setWebGoodsKind(request.getParameter("webGoodsKind"));
                iaasIVO.setWebAccess(request.getParameter("webAccess"));
                iaasIVO.setMntingVm(request.getParameter("mntingVm"));
                iaasIVO.setMntingIdCnt(request.getParameter("mntingIdCnt"));
                iaasIVO.setBakupCnt(request.getParameter("bakupCnt"));
                iaasIVO.setBakupStorg(request.getParameter("bakupStorg"));
                iaasIVO.setMangFunc(request.getParameter("mangFunc"));
                iaasIVO.setSectyVpn(request.getParameter("sectyVpn"));
                iaasIVO.setSectySslvpn(request.getParameter("sectySslvpn"));
                iaasIVO.setTechSupt(request.getParameter("techSupt"));
                iaasIVO.setFuncDmnd1(request.getParameter("funcDmnd1"));
                iaasIVO.setFuncDmnd2(request.getParameter("funcDmnd2"));
                iaasIVO.setFuncDmnd3(request.getParameter("funcDmnd3"));
                iaasIVO.setFuncDmnd4(request.getParameter("funcDmnd4"));
                iaasIVO.setInterfaceDmnd(request.getParameter("interfaceDmnd"));
                iaasIVO.setSectyDmnd1(request.getParameter("sectyDmnd1"));
                iaasIVO.setSectyDmnd2(request.getParameter("sectyDmnd2"));
                iaasIVO.setSectyDmnd3(request.getParameter("sectyDmnd3"));
                iaasIVO.setSectyDmnd4(request.getParameter("sectyDmnd4"));
                iaasIVO.setSectyDmnd5(request.getParameter("sectyDmnd5"));
                iaasIVO.setQutyDmnd1(request.getParameter("qutyDmnd1"));
                iaasIVO.setQutyDmnd2(request.getParameter("qutyDmnd2"));
                iaasIVO.setOptnDmnd1(request.getParameter("optnDmnd1"));
                iaasIVO.setOptnDmnd2(request.getParameter("optnDmnd2"));
                iaasIVO.setPrjtDmnd1(request.getParameter("prjtDmnd1"));
                iaasIVO.setPrjtDmnd2(request.getParameter("prjtDmnd2"));
                iaasIVO.setPrjtDmnd3(request.getParameter("prjtDmnd3"));
                iaasIVO.setEtcDmnd(request.getParameter("etcDmnd"));

                // 입찰공고 IaaS 마스터 답변 등록(Update 처리건이 없을경우 신규건으로 간주)
                int iaasVal = service.updateIaasIAnswerAction(iaasIVO);
                if(iaasVal == 0 ){
                    service.insertIaasIAnswerAction(iaasIVO);    
                }

                // 입찰공고 IaaS 서버 답변 등록
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

                // 입찰공고 IaaS 서버정보 삭제(상세정보는 삭제 후 재등록)
                service.deleteIaasDsAnswerAction(iaasIVO);

                if(serverUse != null){
                    // Iaas 서버정보가 없을 경우 skip
                    if( serverUse.length == 1 && "".equals(serverUse[0]) && "".equals(serverOs[0]) && "".equals(serverCpu[0]) && 
                                                 "".equals(serverMemory[0]) && "".equals(serverDisk[0]) && "".equals(serverQnty[0]) &&
                                                 "".equals(serverIp[0]) && "".equals(serverNetwork[0]) && "".equals(serverGslb[0]) && 
                                                 "".equals(serverLdbl[0]) && "".equals(serverSnap[0]) && "".equals(serverImg[0]) ){
                    }else{
                        for(int i=0; i<serverUse.length; i++){
                            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
                            iaasDsVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                            iaasDsVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                            iaasDsVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                            iaasDsVO.setServerUse(serverUse[i]);         // 서버 용도
                            iaasDsVO.setServerOs(serverOs[i]);           // 서버 OS
                            iaasDsVO.setServerCpu(serverCpu[i]);         // 서버 CPU
                            iaasDsVO.setServerMemory(serverMemory[i]);   // 서버 메모리
                            iaasDsVO.setServerDisk(serverDisk[i]);       // 서버 DISK
                            iaasDsVO.setServerQnty(serverQnty[i]);       // 서버 수량
                            iaasDsVO.setServerIp(serverIp[i]);           // 서버 IP
                            iaasDsVO.setServerNetwork(serverNetwork[i]); // 서버 트래픽
                            iaasDsVO.setServerGslb(serverGslb[i]);       // 서버 GSLB
                            iaasDsVO.setServerLdbl(serverLdbl[i]);       // 서버 로드밸런서
                            iaasDsVO.setServerSnap(serverSnap[i]);       // 서버 스냅샷
                            iaasDsVO.setServerImg(serverImg[i]);         // 서버 이미지

                            // 입찰공고 IaaS 상세정보(서버) 등록
                            service.insertIaasDsAnswerAction(iaasDsVO);
                        }                
                    }
                }

                // 입찰공고 IaaS DB 답변 등록
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

                // 입찰공고 IaaS DB정보 삭제(상세정보는 삭제 후 재등록)
                service.deleteIaasDdAnswerAction(iaasIVO);

                if(dbUse != null){
                    // Iaas DB정보가 없을 경우 skip
                    if( dbUse.length == 1 && "".equals(dbUse[0]) && "".equals(dbOs[0]) && "".equals(dbCpu[0]) && 
                                             "".equals(dbMemory[0]) && "".equals(dbDisk[0]) && "".equals(dbQnty[0]) &&
                                             "".equals(dbIp[0]) && "".equals(dbNetwork[0]) && "".equals(dbAddDisk[0]) && 
                                             "".equals(dbBackStorg[0]) && "".equals(dbStorgSpace[0]) && "".equals(dbTransVlmn[0]) ){
                    }else{
                        for(int j=0; j<serverUse.length; j++){
                            
                            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
                            iaasDdVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                            iaasDdVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                            iaasDdVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                            iaasDdVO.setDbUse(dbUse[j]);                 // DB 용도
                            iaasDdVO.setDbOs(dbOs[j]);                   // DB OS
                            iaasDdVO.setDbCpu(dbCpu[j]);                 // DB CPU
                            iaasDdVO.setDbMemory(dbMemory[j]);           // DB 메모리
                            iaasDdVO.setDbDisk(dbDisk[j]);               // DB DISK
                            iaasDdVO.setDbQnty(dbQnty[j]);               // DB 수량
                            iaasDdVO.setDbIp(dbIp[j]);                   // DB IP
                            iaasDdVO.setDbNetwork(dbNetwork[j]);         // DB 네트워크 트레픽
                            iaasDdVO.setDbAddDisk(dbAddDisk[j]);         // DB 추가 디스크
                            iaasDdVO.setDbBackStorg(dbBackStorg[j]);     // DB 백업 스토리지
                            iaasDdVO.setDbStorgSpace(dbStorgSpace[j]);   // DB 저장공간
                            iaasDdVO.setDbTransVlmn(dbTransVlmn[j]);     // DB 전송량

                            // 입찰공고 IaaS 상세정보(서버) 등록
                            service.insertIaasDdAnswerAction(iaasDdVO);
                        }                
                    }   
                }
            }

        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

        if(rtnVal > 0){
            // 목록으로 이동
            return alertAndRedirect(model, "응찰이 완료 되었습니다.", "/korean/pt/suplerCeart/BD_bidPartcptnList.do");            
        }

        // 목록으로 이동
        String rtnUrl = "/korean/pt/suplerCeart/BD_bidExtendView.do?p_notifyNum="+request.getParameter("notifyNum") + "&p_notifySeq=" + request.getParameter("notifySeq");
        return alertAndRedirect(model, "응찰처리중 오류가 발생되었습니다.", rtnUrl);
    }

    /**
     * 공급자 씨앗 - 공급현황
     * */
    @RequestMapping(value = "/BD_suplySttusList.do")
    public String BD_suplySttusList(HttpServletRequest request, ModelMap model, SuplerCeartSuplySttusVO vo) {

        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_suplySttusList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
           // vo.setSuplerId(userLoginVO.getUserId());
            vo.setSuplerId(userLoginVO.getMasterId()); //서브담당자 등록
        }

        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }
        
        int rpp = 10;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }
        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request, rpp);

        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        
        //입찰 참여현황 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.suplySttusList(vo));

        return "/korean/pt/suplerCeart/BD_suplySttusList";
    }

    /**
     * 공급자씨앗 - 공급현황 - 엑셀다운로드
     * */
    @RequestMapping(value="/suplySttusExcel.do")
    public String suplySttusExcel(HttpServletRequest request, ModelMap model, SuplerCeartSuplySttusVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        vo.setSuplerId(userLoginVO.getUserId());

        OpHelper.bindSearchMap(vo, request);

        model.put("q_excel", "02"); // 목록별 구분값(01:상세정보(견적)요청서 관리 / 02:공급현황)
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_bidList", service.suplySttusListExcel(vo));
        model.put("q_excelFileName", "공급현황 목록");

        SuplerCeartExcelVO suplerCeartExcel = new SuplerCeartExcelVO();
        suplerCeartExcel.setModel(model);
        suplerCeartExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, suplerCeartExcel);
    }

    /**
     * 공급자 씨앗 - 공급현황 - 공급현황 상세보기
     * */
    @RequestMapping(value = "/BD_suplySttusDetailView.do")
    public String BD_suplySttusDetailView(HttpServletRequest request, ModelMap model, SuplerCeartSuplySttusVO vo) {

        SuplySttusEndsUserVO srcVo = new SuplySttusEndsUserVO();
        
        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_suplySttusList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            srcVo.setSuplerId(userLoginVO.getUserId());
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(srcVo, request);
        
        // 언어코드 바인딩
        srcVo.setLangCode(Language(request));
        // 조회글의 Key값 바인딩
        srcVo.setNotifyNum(request.getParameter("p_notifyNum"));
        srcVo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));

        // 구매자 정보 조회
        List<SuplySttusEndsUserVO> endsUserInfo = service.suplySttusEndsUserInfo(srcVo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, endsUserInfo.get(0));

        // 공급 서비스의 공급이력 목록
        SuplerCntrctVO histVo = new SuplerCntrctVO();
        histVo.setSuplerId(userLoginVO.getUserId());                // 공급자
        histVo.setCommUserId(endsUserInfo.get(0).getEndsUserId());  // 수요자
        histVo.setGoodsCode(endsUserInfo.get(0).getGoodsCode());    // 서비스
        
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.suplySttusHistList(histVo));

        // 조회조건 반환
        model.addAttribute("q_goodsTyCd",   vo.getQ_goodsTyCd());
        model.addAttribute("q_ctgryCd1",    vo.getQ_ctgryCd1());
        model.addAttribute("q_ctgryCd2",    vo.getQ_ctgryCd2());
        model.addAttribute("q_ctgryCd3",    vo.getQ_ctgryCd3());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("searchStrtDt",  vo.getSearchStrtDt());
        model.addAttribute("searchEndDt",   vo.getSearchEndDt());
        model.addAttribute("currPage",      vo.getQ_currPage());

        return "/korean/pt/suplerCeart/BD_suplySttusDetail.view";
    }

    /**
     * 공급자 씨앗 - 공급현황 - 공급현황 상세보기 - 총공급이력
     * */
    @RequestMapping(value = "/BD_totSuplySttusHistList.do")
    public String BD_totSuplySttusHistList(HttpServletRequest request, ModelMap model, SuplerCeartSuplySttusVO vo) {

        SuplerCntrctVO histVo = new SuplerCntrctVO();
        
        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_suplySttusList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            histVo.setSuplerId(userLoginVO.getUserId());
        }

        // 공급 서비스의 공급이력 목록
        histVo.setSuplerId(userLoginVO.getUserId());                // 공급자
        histVo.setGoodsCode(request.getParameter("p_goodsCode"));   // 서비스
        model.addAttribute(GlobalConfig.KEY_PAGER, service.totSuplySttusHistList(histVo));

        // 선택된 서비스정보 반환
        model.addAttribute("p_goodsCode",     request.getParameter("p_goodsCode"));       // 서비스명
        model.addAttribute("p_goodsNm",       request.getParameter("p_goodsNm"));       // 서비스명
        model.addAttribute("p_suplerStoreNm", request.getParameter("p_suplerStoreNm")); // 공급자 회사명
        model.addAttribute("p_goodKndCd",     request.getParameter("p_goodKndCd"));     // 서비스구분
        
        // 조회조건 반환
        model.addAttribute("q_goodsTyCd",   vo.getQ_goodsTyCd());
        model.addAttribute("q_ctgryCd1",    vo.getQ_ctgryCd1());
        model.addAttribute("q_ctgryCd2",    vo.getQ_ctgryCd2());
        model.addAttribute("q_ctgryCd3",    vo.getQ_ctgryCd3());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("searchStrtDt",  vo.getSearchStrtDt());
        model.addAttribute("searchEndDt",   vo.getSearchEndDt());
        model.addAttribute("currPage",      vo.getQ_currPage());

        return "/korean/pt/suplerCeart/BD_totSuplySttusHistList";
    }
    /**
     * 공급자씨앗 - 사전견적답변관리
     * */
    @RequestMapping(value = "/BD_beforeRequestList.do")
    public String BD_mybeffatEstmtList(HttpServletRequest request, ModelMap model, SuplerCeartVO vo) {

        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_beforeRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );          
        }

        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchDiv02",   vo.getSearchDiv02());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

        /*공통코드 설정 - 답변여부*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2043);
        codeVO.setLangCode(vo.getLangCode());
        codeVO.setUseYn("Y");
        model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_askApplyCd", codeService.codeList(codeVO));

        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.beforeRequestList(vo));

        return "/korean/pt/suplerCeart/BD_beforeRequestList";
    }
    
    /**
     * 
     * BD_requestDetailView (마이씨앗 - 상세정보(견적)요청서 서비스 상세조회)
     * 
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_beforeRequestDetailView.do")
    public String BD_beforeRequestDetailView(HttpServletRequest request, ModelMap model, SuplerCeartBidNotifyVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_beforeRequestList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 조회글의 Key값 바인딩
        vo.setNotifyNum(request.getParameter("p_notifyNum"));
        vo.setNotifySeq(Integer.parseInt(request.getParameter("p_notifySeq")));

        // 사전견적공고 공급자 확인정보의 확인여부 update
        service.updateBeforeSplyConfmGbn(vo);

        // 입찰공고 마스터 조회
        List<SuplerCeartBidNotifyVO> requestMstInfo = service.suplerCeartBeforeNotifyInfo(vo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자의 확인정보 조회
        SuplerCeartNotifySplyVO notifySplyVO = new SuplerCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());
        notifySplyVO.setSuplerId(vo.getSuplerId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.suplerCeartBeforeNotifySplyInfo(notifySplyVO).get(0));

        // 해당 견적의 서비스 구분
        String goodKndCd  =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );
        String endsUserId =  requestMstInfo.get(0).getEndsUserId() ;  // 견적의 수요자ID


        if(goodKndCd.equals("1001"))
        {
            /*
            SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setEndsUserId(endsUserId);         // 수요자 ID
            paasVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass", service.suplerCeartBeforeInfoByPass(paasVO)); // PaaS 정보 조회
            */
            
            SuplerCeartPaas2VO paas2VO = new SuplerCeartPaas2VO();
            paas2VO.setNotifyNum(vo.getNotifyNum());
            paas2VO.setNotifySeq(vo.getNotifySeq());
            paas2VO.setEndsUserId(endsUserId);         // 수요자 ID
            paas2VO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass2", service.suplerCeartBeforeInfoByPass2(paas2VO)); // PaaS 정보 조회
            
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
        }
        else if(goodKndCd.equals("1002"))
        {
            /*
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", service.suplerCeartBeforeInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", service.suplerCeartBeforeInfoBySassD(saasDVO)); // SaaS 상세정보 조회            
            */
            
            SuplerCeartSaas2IVO saas2IVO = new SuplerCeartSaas2IVO();
            saas2IVO.setNotifyNum(vo.getNotifyNum());
            saas2IVO.setNotifySeq(vo.getNotifySeq());
            saas2IVO.setEndsUserId(endsUserId);         // 수요자 ID
            saas2IVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            
            model.addAttribute("sass2I", service.suplerCeartBeforeInfoBySass2I(saas2IVO)); // SaaS 정보 조회
            
            model.addAttribute("supplyMethodCodeList",    registerService.prvCodeList(vo.getLangCode(), 2042)); // 공통코드의 제공방법코드(2042)
            model.addAttribute("totUnitCodeList",         registerService.prvCodeList(vo.getLangCode(), 2041)); // 공통코드의 전체단위코드(2041)
            model.addAttribute("userManagerSeparateList", registerService.prvCodeList(vo.getLangCode(), 2061)); // 공통코드의 사용자/관리자분리코드(2061)
            model.addAttribute("serviceSupplyMethodList", registerService.prvCodeList(vo.getLangCode(), 2062)); // 공통코드의 서비스제공방식코드(2062)
            model.addAttribute("encryptionList",          registerService.prvCodeList(vo.getLangCode(), 2063)); // 공통코드의 암호화코드(2063)

            SuplerCeartSaas2DnVO saas2DnVO = new SuplerCeartSaas2DnVO();
            saas2DnVO.setNotifyNum(vo.getNotifyNum());
            saas2DnVO.setNotifySeq(vo.getNotifySeq());
            saas2DnVO.setEndsUserId(endsUserId);         // 수요자 ID
            saas2DnVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            List<SuplerCeartSaas2DnVO> suplerCeartSaas2DnVO = service.suplerCeartBeforeInfoBySass2Dn(saas2DnVO);  
            List<SuplerCeartSaas2DnVO> suplerCeartSaas2DnVO_h  = new ArrayList<SuplerCeartSaas2DnVO>();
            
            Iterator<SuplerCeartSaas2DnVO> iterator2Dn = suplerCeartSaas2DnVO.iterator();
            while (iterator2Dn.hasNext())
            {
                SuplerCeartSaas2DnVO tmp = iterator2Dn.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) suplerCeartSaas2DnVO_h.add(tmp);
            }            
            model.addAttribute("sass2Dn_h", suplerCeartSaas2DnVO_h); // SaaS2 상세Need정보 조회
            model.addAttribute("sass2Dn", suplerCeartSaas2DnVO); // SaaS2 상세Need 정보 조회

            SuplerCeartSaas2DoVO saas2DoVO = new SuplerCeartSaas2DoVO();
            saas2DoVO.setNotifyNum(vo.getNotifyNum());
            saas2DoVO.setNotifySeq(vo.getNotifySeq());
            saas2DoVO.setEndsUserId(endsUserId);         // 수요자 ID
            saas2DoVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            
            List<SuplerCeartSaas2DoVO> suplerCeartSaas2DoVO = service.suplerCeartBeforeInfoBySass2Do(saas2DoVO);
            List<SuplerCeartSaas2DoVO> suplerCeartSaas2DoVO_h = new ArrayList<SuplerCeartSaas2DoVO>();
            
            Iterator<SuplerCeartSaas2DoVO> iterator2Do = suplerCeartSaas2DoVO.iterator(); 
            while (iterator2Do.hasNext())
            {
                SuplerCeartSaas2DoVO tmp = iterator2Do.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) suplerCeartSaas2DoVO_h.add(tmp);
            }
            model.addAttribute("sass2Do_h", suplerCeartSaas2DoVO_h); // SaaS2 상세Option 정보 조회           
            model.addAttribute("sass2Do", suplerCeartSaas2DoVO); // SaaS2 상세Option 정보 조회           
            

            /*공통코드 설정 - SaaS 시스템 요구조건 단위*/
            CodeVO codeVO = new CodeVO();
            codeVO.setGrpCd(2041);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_unitSys", codeService.codeList(codeVO));
            
            /*공통코드 설정 - SaaS 시스템 요구조건 제공방법*/
            codeVO.setGrpCd(2042);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_splyMothSys", codeService.codeList(codeVO));
            
            /*공통코드 설정 - SaaS 시스템 요구조건 제공방법*/
            codeVO.setGrpCd(2042);
            codeVO.setLangCode(vo.getLangCode());
            codeVO.setUseYn("Y");
            model.addAttribute(GlobalConfig.KEY_CODE_LIST+"_cmntItem", codeService.codeList(codeVO));

        }
        else if(goodKndCd.equals("1003"))
        {
            /*
            SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
            iaasIVO.setNotifyNum(vo.getNotifyNum());
            iaasIVO.setNotifySeq(vo.getNotifySeq());
            iaasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassI", service.suplerCeartBeforeInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", service.suplerCeartBeforeInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", service.suplerCeartBeforeInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
            */
            
            SuplerCeartIaas2IVO iaas2IVO = new SuplerCeartIaas2IVO();
            iaas2IVO.setNotifyNum(vo.getNotifyNum());
            iaas2IVO.setNotifySeq(vo.getNotifySeq());
            iaas2IVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaas2IVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iass2I", service.suplerCeartBeforeInfoByIass2I(iaas2IVO));   // Iaa2S 마스터 정보 조회
            
            model.addAttribute("webGoodsKindList", registerService.prvCodeList(vo.getLangCode(), 2074)); // 공통코드의 웹방화벽 상품유형코드(2074)
            
            SuplerCeartIaas2DsVO iaas2DsVO = new SuplerCeartIaas2DsVO();
            iaas2DsVO.setNotifyNum(vo.getNotifyNum());
            iaas2DsVO.setNotifySeq(vo.getNotifySeq());
            iaas2DsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaas2DsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            
            List<SuplerCeartIaas2DsVO> suplerCeartIaas2DsVO = service.suplerCeartBeforeInfoByIass2Ds(iaas2DsVO);
            List<SuplerCeartIaas2DsVO> suplerCeartIaas2DsVO_h = new ArrayList<SuplerCeartIaas2DsVO>();
            
            Iterator<SuplerCeartIaas2DsVO> Iterator2Ds = suplerCeartIaas2DsVO.iterator();
            while (Iterator2Ds.hasNext())
            {
                SuplerCeartIaas2DsVO tmp = Iterator2Ds.next() ;
                
                if  ("Y".equals(tmp.getConsumerYn())) suplerCeartIaas2DsVO_h.add(tmp);
            } 
            model.addAttribute("iass2Ds_h", suplerCeartIaas2DsVO_h); // Iaa2S 서버문의 조회
            model.addAttribute("iass2Ds", suplerCeartIaas2DsVO); // Iaa2S 서버문의 조회
            
            SuplerCeartIaas2DdVO iaas2DdVO = new SuplerCeartIaas2DdVO();
            iaas2DdVO.setNotifyNum(vo.getNotifyNum());
            iaas2DdVO.setNotifySeq(vo.getNotifySeq());
            iaas2DdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaas2DdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            
            List<SuplerCeartIaas2DdVO> suplerCeartIaas2DdVO = service.suplerCeartBeforeInfoByIass2Dd(iaas2DdVO);
            List<SuplerCeartIaas2DdVO> suplerCeartIaas2DdVO_h = new ArrayList<SuplerCeartIaas2DdVO>();
            
            Iterator<SuplerCeartIaas2DdVO> Iterator2Dd = suplerCeartIaas2DdVO.iterator();
            while (Iterator2Dd.hasNext())
            {
                SuplerCeartIaas2DdVO tmp = Iterator2Dd.next();
                
                if  ("Y".equals(tmp.getConsumerYn())) suplerCeartIaas2DdVO_h.add(tmp);
            }
            model.addAttribute("iass2Dd_h", suplerCeartIaas2DdVO_h); // Iaa2S DB문의 조회
            model.addAttribute("iass2Dd", suplerCeartIaas2DdVO); // Iaa2S DB문의 조회
        }
        else if(goodKndCd.equals("1004")) // 20170713 SCS
        {
            SuplerCeartScs2VO scs2VO = new SuplerCeartScs2VO();
            scs2VO.setNotifyNum(vo.getNotifyNum());
            scs2VO.setNotifySeq(vo.getNotifySeq());
            scs2VO.setEndsUserId(endsUserId);         // 수요자 ID
            scs2VO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            
            model.addAttribute("scs2", service.suplerCeartBeforeInfoByScs2(scs2VO)); // Scs 정보 조회
            
            model.addAttribute("cnslRelmList",  registerService.prvCodeList(vo.getLangCode(), 2082)); // 공통코드의 컨설팅 영역(2082)
            model.addAttribute("cnslScopeList", registerService.prvCodeList(vo.getLangCode(), 2083)); // 공통코드의 컨설팅 범위(2083)
            model.addAttribute("excAreaList",   registerService.prvCodeList(vo.getLangCode(), 2036)); // 공통코드의 컨설팅 수행 가능 지역(2036)
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        return "/korean/pt/suplerCeart/BD_beforeRequestDetail.view";
        /*
        /korean/pt/suplerCeart/BD_beforeRequestDetail.view.jsp 
        /korean/pt/suplerCeart/goods/BD_Before_Paas2.view.jsp
        /korean/pt/suplerCeart/goods/BD_Before_Saas2.view.jsp
        /korean/pt/suplerCeart/goods/BD_Before_Iaas2.view.jsp
        /korean/pt/suplerCeart/goods/BD_Before_Scs2.view.jsp
          
        저장 _ ND_suplerSendBeforeRequestAction.do
        */
    }
    
    
    /**
     * 
     * ND_suplerSendRequestAction (견적요청 발송)
     * 
     * 데이터초기화
     * 
     * delete tcn_before_saas2_i WHERE notify_num = '20180320' AND user_id = 'iosys9532';
     * delete tcn_before_saas2_dn WHERE notify_num = '20180320' AND user_id = 'iosys9532';
     * delete tcn_before_saas2_do WHERE notify_num = '20180320' AND user_id = 'iosys9532';
     * 
     * delete tcn_before_paas2_i WHERE notify_num = '20180323' AND user_id = 'iosys9532';
     * 
     * UPDATE TCN_BEFORE_ESTE_SPLY SET ask_apply_cd = '1005' WHERE notify_num >= '20180320'; 
     * 
     * COMMIT ;
     * 
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_suplerSendBeforeRequestAction.do",  method = RequestMethod.POST)
    public String ND_suplerSendBeforeRequestAction(HttpServletRequest request, ModelMap model, SuplerCeartNotifySplyVO vo) 
    {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_beforeRequestDetailView.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }

        // 화면 파라미터 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, SUPLER_FILE_PATH);
        List<FileVO> splyFile = new ArrayList<FileVO>();
        for(int i = 0 ; i < uploadFile.size() ; i++) {
            String inputNm = uploadFile.get(i).getInputNm();

            if(inputNm.startsWith("splyFile")) {
                splyFile.add(uploadFile.get(i));
            }
        }
        vo.setSplyFileList(splyFile);
        
        // 입찰공고 공급자 확인정보 등록
        int rtnVal = service.updateBeforeNotifySplyAction(vo); // TCN_BEFORE_ESTE_SPLY . ASK_APPLY_CD = '1004' //  '발송'처리  '1005' -> '1004'  

        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/
        // 알람처리
        BeforeSuplerListVO suplerVO = new BeforeSuplerListVO();
        suplerVO.setNotifyNum(vo.getNotifyNum());
        suplerVO.setNotifySeq(vo.getNotifySeq());
        suplerVO.setSuplerId(userLoginVO.getUserId());
        
        List<BeforeSuplerListVO> suplerList = beforeService.selectSuplerList(suplerVO);

        for(int i=0; i<suplerList.size(); i++){
            AlarmVO alarmVO = new AlarmVO();
            alarmVO.setAlarmBizGbn("07");
            alarmVO.setUserId(suplerList.get(i).getSuplerId());
            alarmVO.setAlarmTitle("사전견적요청 답변이 등록되었습니다.");
            alarmVO.setConfrmId(suplerList.get(i).getUserId());
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
                boolean result = amservice.sendAutoMail(autoMap);
            }
            
            // SMS
            if(suplerList.get(i).getSuplerMbtlnum() != null && !suplerList.get(i).getSuplerMbtlnum().trim().equals("")){
                Map<String, Object> smsMap = new HashMap<String, Object>();
                smsMap.put("rcvNo", suplerList.get(i).getSuplerMbtlnum());
                smsMap.put("msg", "사전견적요청 답변이 등록되었습니다.");
                smsMap.put("dutyCd", "BM");
                boolean smsRst = smsService.smsTransHist(smsMap);
            }
        }
        /**★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★**/

        // 공급자 정보 수정이 완료되었으면 각 서비스에 맞는 답변 등록
        // 해당 견적의 서비스 구분
        String goodKndCd  = request.getParameter("goodKndCd");
        if  (rtnVal> 0 )
        {
            if  (goodKndCd.equals("1001")) // Pass2
            {
                /*
                SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
                paasVO.setNotifyNum(vo.getNotifyNum());                         // 공고번호
                paasVO.setNotifySeq(vo.getNotifySeq());                         // 공고차수
                paasVO.setSuplerId(vo.getSuplerId());                           // 공급자ID
                paasVO.setApplyGbn("Y");                                        // 답변여부
                paasVO.setLangSys(request.getParameter("langSys"));             // language
                paasVO.setFrameworkSys(request.getParameter("frameworkSys"));   // framework
                paasVO.setCacheSys(request.getParameter("cacheSys"));           // cache
                paasVO.setDbmsSys(request.getParameter("dbmsSys"));             // dbms
                paasVO.setFastDeploySys(request.getParameter("fastDeploySys")); // fast deploy
                paasVO.setEtcSys(request.getParameter("etcSys"));               // etc

                // 공고 PaaS 답변 등록
                service.insertBeforePaasAnswerAction(paasVO);
                */
                
                SuplerCeartPaas2VO paasVO = new SuplerCeartPaas2VO();
                paasVO.setNotifyNum(vo.getNotifyNum());                         // 공고번호
                paasVO.setNotifySeq(vo.getNotifySeq());                         // 공고차수
                paasVO.setSuplerId(vo.getSuplerId());                           // 공급자ID
                paasVO.setApplyGbn("Y");                                        // 답변여부
                
                paasVO.setHostingMethod(request.getParameter("hostingMethod"));       // 호스팅방식
                paasVO.setScaling(request.getParameter("scaling"));                   // 스케일링
                paasVO.setPlatform(request.getParameter("platform"));                 // 플랫폼
                paasVO.setRuntimes(request.getParameter("runtimes"));                 // 런타임
                paasVO.setMiddlewares(request.getParameter("middleware"));            // 미들웨어
                paasVO.setFrameworks(request.getParameter("frameworks"));             // 프레임웍
                paasVO.setServices(request.getParameter("services"));                 // 서비스
                paasVO.setAddons(request.getParameter("addons"));                     // 애드온
                paasVO.setextendFunction(request.getParameter("extendFunction"));     // 확장기능여부
                paasVO.setGeolocations(request.getParameter("geolocations"));         // 위치

                // 공고 PaaS 답변 등록
                service.insertBeforePaas2AnswerAction(paasVO);
            }
            else if  (goodKndCd.equals("1002")) // Sass2
            {
                /*
                SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
                saasIVO.setNotifyNum(vo.getNotifyNum());                     // 공고번호
                saasIVO.setNotifySeq(vo.getNotifySeq());                     // 공고차수
                saasIVO.setSuplerId(vo.getSuplerId());                       // 공급자ID
                saasIVO.setApplyGbn("Y");                                    // 답변여부
                saasIVO.setUnitSys(request.getParameter("unitSys"));         // 전체단위
                saasIVO.setEtcUnitSys(request.getParameter("etcUnitSys"));   // 기타단위내용
                saasIVO.setCaptySys(request.getParameter("captySys"));       // 전체제공용량
                saasIVO.setAmountSys(request.getParameter("amountSys"));     // 전체단가
                saasIVO.setSplyMothSys(request.getParameter("splyMothSys")); // 제공방법

                // 공고 SaaS 마스터 답변 등록
                service.insertBeforeSaasIAnswerAction(saasIVO);

                // 입찰공고 SaaS 상세 답변 등록
                String[] optionNm   = request.getParameterValues("optionNm");
                String[] unitItem   = request.getParameterValues("unitItem");
                String[] captyItem  = request.getParameterValues("captyItem");
                String[] amountItem = request.getParameterValues("amountItem");
                String[] cmntItem   = request.getParameterValues("cmntItem");
                
                // Saas 상세정보가 없을 경우 skip
                if(optionNm.length == 1 && "".equals(optionNm[0]) && "".equals(unitItem[0]) && "".equals(captyItem[0]) && "".equals(amountItem[0]) && "".equals(cmntItem[0])){
                    
                }else{
                    for(int i=0; i<optionNm.length; i++){
                        SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
                        saasDVO.setNotifyNum(vo.getNotifyNum());                // 공고번호
                        saasDVO.setNotifySeq(vo.getNotifySeq());                // 공고차수
                        saasDVO.setSuplerId(vo.getSuplerId());                  // 공급자ID
                        saasDVO.setApplySeq(i+1);                               // 답변순번
                        saasDVO.setOptionNm(optionNm[i]);                       // 옵션명
                        saasDVO.setUnitItem(unitItem[i]);                       // 개별단위
                        saasDVO.setCaptyItem(captyItem[i]);                     // 개별제공용량
                        saasDVO.setAmountItem(Integer.parseInt(amountItem[i])); // 개별단가
                        saasDVO.setCmntItem(cmntItem[i]);                       // 설명

                        // 공고 SaaS 상세정보 등록
                        service.insertBeforeSaasDAnswerAction(saasDVO);
                    }                
                }
                */
                
                String notifyNum = vo.getNotifyNum() ;  // 공고번호
                int notifySeq    = vo.getNotifySeq() ;  // 공고차수
                String suplerId  = vo.getSuplerId() ;   // 공급자ID
                 
                SuplerCeartSaas2IVO saas2IVO = new SuplerCeartSaas2IVO();
                saas2IVO.setNotifyNum(notifyNum);                     // 공고번호
                saas2IVO.setNotifySeq(notifySeq);                     // 공고차수
                saas2IVO.setSuplerId(suplerId);                       // 공급자ID
                saas2IVO.setApplyGbn("Y");                            // 답변여부
                saas2IVO.setSupportMethod(request.getParameter("supportMethod"));             // 제공방법
                saas2IVO.setUserManagerSeparate(request.getParameter("userManagerSeparate")); // 사용자/관리자 분리
                saas2IVO.setServiceSupplyMethod(request.getParameter("serviceSupplyMethod")); // 서비스제공방식
                saas2IVO.setEncryption(request.getParameter("encryption"));                   // 암호화  
                saas2IVO.setMultiPlatform(request.getParameter("multiPlatform"));             // 다중플랫폼지원

                // 공고 SaaS 마스터 답변 등록
                service.insertBeforeSaas2IAnswerAction(saas2IVO);
                
                String[] functionName1 = request.getParameterValues("functionName1");
                String[] amount1       = request.getParameterValues("amount1");
                String[] unitCode1     = request.getParameterValues("unitCode1");
                String[] hidenOptions1 = request.getParameterValues("hidenOptions1");
                
                System.out.println("hidenOptions1: " + hidenOptions1.length);
                
                // Saas2 필요정보가 없을 경우가 없다 무조건 답변 저장
                if  (functionName1 != null)
                {
                    for(int i=0; i<functionName1.length; i++)
                    {
                        SuplerCeartSaas2DnVO saas2DnVO = new SuplerCeartSaas2DnVO();
                        saas2DnVO.setNotifyNum(notifyNum);    // 공고번호
                        saas2DnVO.setNotifySeq(notifySeq);    // 공고차수
                        saas2DnVO.setSuplerId(suplerId);      // 공급자ID                        
                        saas2DnVO.setFunctionName(functionName1[i]);  // 기능명
                        saas2DnVO.setAmount(amount1[i]);              // 수량
                        saas2DnVO.setUnitCode(unitCode1[i]);          // 단위
                        
                        // SaaS2 필요기능정보 등록
                        service.insertBeforeSaas2NeedAnswerAction(i,saas2DnVO);
                        
                        // 필요옵션저장을 위한 일련번호(NEED_SEQ)를 구한다.
                        int needSeq = service.selectBeforeSaas2NeedSeq(saas2DnVO);  
                        
                        String[] optionList = hidenOptions1[i].split("\\^");
                        
                        for(int j=0; j<optionList.length; j++)
                        {
                            String[] options = optionList[j].split("\\|");
    
                            SuplerCeartSaas2DoVO saas2DoVO = new SuplerCeartSaas2DoVO();
                            saas2DoVO.setNotifyNum(notifyNum);    // 공고번호
                            saas2DoVO.setNotifySeq(notifySeq);    // 공고차수
                            saas2DoVO.setSuplerId(suplerId);      // 공급자ID
                            saas2DoVO.setNeedSeq(needSeq);        // 필요사항 일련번호
                            
                            if  (options.length==3)
                            {
                                saas2DoVO.setFunctionName(options[0]);  // 기능명
                                saas2DoVO.setAmount(options[1]);        // 수량
                                saas2DoVO.setUnitCode(options[2]);      // 단위
                            }
                            
                            // SaaS2 필요옵션기능정보 등록
                            service.insertBeforeSaas2OptionAnswerAction(i,j,saas2DoVO);
                        }
                    }
                }

            }
            else if  (goodKndCd.equals("1003")) // Iass2
            {
                /*
                SuplerCeartIaasIVO iaasIVO = new SuplerCeartIaasIVO();
                iaasIVO.setNotifyNum(vo.getNotifyNum());                                       // 공고번호
                iaasIVO.setNotifySeq(vo.getNotifySeq());                                       // 공고차수
                iaasIVO.setSuplerId(vo.getSuplerId());                                         // 공급자ID
                iaasIVO.setApplyGbn("Y");                                                      // 답변여부
                iaasIVO.setCdnTransVlmn(request.getParameter("cdnTransVlmn"));
                iaasIVO.setCdnRequCnt(request.getParameter("cdnRequCnt"));
                iaasIVO.setWebGoodsKind(request.getParameter("webGoodsKind"));
                iaasIVO.setWebAccess(request.getParameter("webAccess"));
                iaasIVO.setMntingVm(request.getParameter("mntingVm"));
                iaasIVO.setMntingIdCnt(request.getParameter("mntingIdCnt"));
                iaasIVO.setBakupCnt(request.getParameter("bakupCnt"));
                iaasIVO.setBakupStorg(request.getParameter("bakupStorg"));
                iaasIVO.setMangFunc(request.getParameter("mangFunc"));
                iaasIVO.setSectyVpn(request.getParameter("sectyVpn"));
                iaasIVO.setSectySslvpn(request.getParameter("sectySslvpn"));
                iaasIVO.setTechSupt(request.getParameter("techSupt"));
                iaasIVO.setFuncDmnd1(request.getParameter("funcDmnd1"));
                iaasIVO.setFuncDmnd2(request.getParameter("funcDmnd2"));
                iaasIVO.setFuncDmnd3(request.getParameter("funcDmnd3"));
                iaasIVO.setFuncDmnd4(request.getParameter("funcDmnd4"));
                iaasIVO.setInterfaceDmnd(request.getParameter("interfaceDmnd"));
                iaasIVO.setSectyDmnd1(request.getParameter("sectyDmnd1"));
                iaasIVO.setSectyDmnd2(request.getParameter("sectyDmnd2"));
                iaasIVO.setSectyDmnd3(request.getParameter("sectyDmnd3"));
                iaasIVO.setSectyDmnd4(request.getParameter("sectyDmnd4"));
                iaasIVO.setSectyDmnd5(request.getParameter("sectyDmnd5"));
                iaasIVO.setQutyDmnd1(request.getParameter("qutyDmnd1"));
                iaasIVO.setQutyDmnd2(request.getParameter("qutyDmnd2"));
                iaasIVO.setOptnDmnd1(request.getParameter("optnDmnd1"));
                iaasIVO.setOptnDmnd2(request.getParameter("optnDmnd2"));
                iaasIVO.setPrjtDmnd1(request.getParameter("prjtDmnd1"));
                iaasIVO.setPrjtDmnd2(request.getParameter("prjtDmnd2"));
                iaasIVO.setPrjtDmnd3(request.getParameter("prjtDmnd3"));
                iaasIVO.setEtcDmnd(request.getParameter("etcDmnd"));
                
                // 공고 IaaS 마스터 답변 등록
                service.insertBeforeIaasIAnswerAction(iaasIVO);
                

                // 공고 IaaS [서버] 답변 등록
                String[] serverUse     = request.getParameterValues("serverUse");
                String[] serverOs      = request.getParameterValues("serverOs");
                String[] serverCpu     = request.getParameterValues("serverCpu");
                String[] serverMemory  = request.getParameterValues("serverMemory");
                String[] serverDisk    = request.getParameterValues("serverDisk");
                String[] serverQnty    = request.getParameterValues("serverQnty");
                
                // Iaas 서버정보가 없을 경우 skip
                if( serverUse.length == 1 && "".equals(serverUse[0]) && "".equals(serverOs[0]) && "".equals(serverCpu[0]) && 
                                             "".equals(serverMemory[0]) && "".equals(serverDisk[0]) && "".equals(serverQnty[0]))
                {
                }else{
                    for(int i=0; i<serverUse.length; i++)
                    {
                        SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
                        iaasDsVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                        iaasDsVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                        iaasDsVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                        
                        iaasDsVO.setServerUse(serverUse[i]);         // 서버 용도
                        iaasDsVO.setServerOs(serverOs[i]);           // 서버 OS
                        iaasDsVO.setServerCpu(serverCpu[i]);         // 서버 CPU
                        iaasDsVO.setServerMemory(serverMemory[i]);   // 서버 메모리
                        iaasDsVO.setServerDisk(serverDisk[i]);       // 서버 DISK
                        iaasDsVO.setServerQnty(serverQnty[i]);       // 서버 수량
                
                        // 사전공고 IaaS 상세정보(서버) 등록
                        service.insertBeforeIaasDsAnswerAction(iaasDsVO);
                    }                
                }

                if  (request.getParameterValues("dbUse") != null)  //IaaS [DB] 답변 이 없을 수도 있다.. 
                {
                    // 사전공고 IaaS [DB] 답변 등록
                    String[] dbUse        = request.getParameterValues("dbUse");
                    String[] dbOs         = request.getParameterValues("dbOs");
                    String[] dbCpu        = request.getParameterValues("dbCpu");
                    String[] dbMemory     = request.getParameterValues("dbMemory");
                    String[] dbDisk       = request.getParameterValues("dbDisk");
                    String[] dbQnty       = request.getParameterValues("dbQnty");

                    // Iaas DB정보가 없을 경우 skip
                    if( dbUse.length == 1 && "".equals(dbUse[0]) && "".equals(dbOs[0]) && "".equals(dbCpu[0]) && 
                                             "".equals(dbMemory[0]) && "".equals(dbDisk[0]) && "".equals(dbQnty[0]) )
                    {
                    }
                    else
                    {
                        for(int j=0; j<serverUse.length; j++)
                        {                            
                            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
                            iaasDdVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                            iaasDdVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                            iaasDdVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                            
                            iaasDdVO.setDbUse(dbUse[j]);                 // DB 용도
                            iaasDdVO.setDbOs(dbOs[j]);                   // DB OS
                            iaasDdVO.setDbCpu(dbCpu[j]);                 // DB CPU
                            iaasDdVO.setDbMemory(dbMemory[j]);           // DB 메모리
                            iaasDdVO.setDbDisk(dbDisk[j]);               // DB DISK
                            iaasDdVO.setDbQnty(dbQnty[j]);               // DB 수량
                    
                            // 공고 IaaS 상세정보(서버) 등록
                            service.insertBeforeIaasDdAnswerAction(iaasDdVO);
                        }                
                    }    
                }
                */               
                SuplerCeartIaas2IVO iaasIVO = new SuplerCeartIaas2IVO();
                iaasIVO.setNotifyNum(vo.getNotifyNum());                                       // 공고번호
                iaasIVO.setNotifySeq(vo.getNotifySeq());                                       // 공고차수
                iaasIVO.setSuplerId(vo.getSuplerId());                                         // 공급자ID
                iaasIVO.setApplyGbn("Y");                                                      // 답변여부                
                iaasIVO.setServerIp(request.getParameter("serverIp"));
                iaasIVO.setServerNetwork(request.getParameter("serverNetwork"));
                iaasIVO.setServerGslb(request.getParameter("serverGslb"));
                iaasIVO.setServerLdbl(request.getParameter("serverLdbl"));
                iaasIVO.setServerSnap(request.getParameter("serverSnap"));
                iaasIVO.setServerImg(request.getParameter("serverImg"));
                iaasIVO.setDbIp(request.getParameter("dbIp"));
                iaasIVO.setDbNetwork(request.getParameter("dbNetwork"));
                iaasIVO.setDbAddDisk(request.getParameter("dbAddDisk"));
                iaasIVO.setDbBackStorg(request.getParameter("dbBackStorg"));
                iaasIVO.setDbStorgSpace(request.getParameter("dbStorgSpace"));
                iaasIVO.setDbTransVlmn(request.getParameter("dbTransVlmn"));
                iaasIVO.setCdnTransVlmn(request.getParameter("cdnTransVlmn"));
                iaasIVO.setCdnRequCnt(request.getParameter("cdnRequCnt"));
                iaasIVO.setWebGoodsKind(request.getParameter("webGoodsKind"));
                iaasIVO.setWebAccess(request.getParameter("webAccess"));
                iaasIVO.setMntingVm(request.getParameter("mntingVm"));
                iaasIVO.setMntingIdCnt(request.getParameter("mntingIdCnt"));
                iaasIVO.setBakupCnt(request.getParameter("bakupCnt"));
                iaasIVO.setBakupStorg(request.getParameter("bakupStorg"));
                iaasIVO.setMangFunc(request.getParameter("mangFunc"));
                iaasIVO.setSectyVpn(request.getParameter("sectyVpn"));
                iaasIVO.setSectySslvpn(request.getParameter("sectySslvpn"));
                iaasIVO.setAddedEtc(request.getParameter("addedEtc"));
                
                // 공고 IaaS2 마스터 답변 등록
                service.insertBeforeIaas2IAnswerAction(iaasIVO);
                
                
                // 공고 IaaS [서버] 답변 등록
                String[] serverUse     = request.getParameterValues("serverUse");
                String[] serverOs      = request.getParameterValues("serverOs");
                String[] serverCpu     = request.getParameterValues("serverCpu");
                String[] serverMemory  = request.getParameterValues("serverMemory");
                String[] serverDisk    = request.getParameterValues("serverDisk");
                String[] serverQnty    = request.getParameterValues("serverQnty");
                
                // Iaas 서버정보가 없을 경우 skip
                if( serverUse.length == 1 && "".equals(serverUse[0]) && "".equals(serverOs[0]) && "".equals(serverCpu[0]) && 
                                             "".equals(serverMemory[0]) && "".equals(serverDisk[0]) && "".equals(serverQnty[0]))
                {
                }
                else
                {
                    for(int i=0; i<serverUse.length; i++)
                    {
                        SuplerCeartIaas2DsVO iaas2DsVO = new SuplerCeartIaas2DsVO();
                        iaas2DsVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                        iaas2DsVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                        iaas2DsVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                        
                        iaas2DsVO.setServerUse(serverUse[i]);         // 서버 용도
                        iaas2DsVO.setServerOs(serverOs[i]);           // 서버 OS
                        iaas2DsVO.setServerCpu(serverCpu[i]);         // 서버 CPU
                        iaas2DsVO.setServerMemory(serverMemory[i]);   // 서버 메모리
                        iaas2DsVO.setServerDisk(serverDisk[i]);       // 서버 DISK
                        iaas2DsVO.setServerQnty(serverQnty[i]);       // 서버 수량
                
                        // 사전공고 IaaS 상세정보(서버) 등록
                        service.insertBeforeIaas2DsAnswerAction(i,iaas2DsVO);
                    }                
                }
                
                if  (request.getParameterValues("dbUse") != null)  //IaaS [DB] 답변 이 없을 수도 있다.. 
                {
                    // 사전공고 IaaS [DB] 답변 등록
                    String[] dbUse        = request.getParameterValues("dbUse");
                    String[] dbOs         = request.getParameterValues("dbOs");
                    String[] dbCpu        = request.getParameterValues("dbCpu");
                    String[] dbMemory     = request.getParameterValues("dbMemory");
                    String[] dbDisk       = request.getParameterValues("dbDisk");
                    String[] dbQnty       = request.getParameterValues("dbQnty");

                    // Iaas DB정보가 없을 경우 skip
                    if( dbUse.length == 1 && "".equals(dbUse[0]) && "".equals(dbOs[0]) && "".equals(dbCpu[0]) && 
                                             "".equals(dbMemory[0]) && "".equals(dbDisk[0]) && "".equals(dbQnty[0]) )
                    {
                    }
                    else
                    {
                        for(int i=0; i<serverUse.length; i++)
                        {                            
                            SuplerCeartIaas2DdVO iaas2DdVO = new SuplerCeartIaas2DdVO();
                            iaas2DdVO.setNotifyNum(vo.getNotifyNum());    // 공고번호
                            iaas2DdVO.setNotifySeq(vo.getNotifySeq());    // 공고차수
                            iaas2DdVO.setSuplerId(vo.getSuplerId());      // 공급자ID
                            
                            iaas2DdVO.setDbUse(dbUse[i]);                 // DB 용도
                            iaas2DdVO.setDbOs(dbOs[i]);                   // DB OS
                            iaas2DdVO.setDbCpu(dbCpu[i]);                 // DB CPU
                            iaas2DdVO.setDbMemory(dbMemory[i]);           // DB 메모리
                            iaas2DdVO.setDbDisk(dbDisk[i]);               // DB DISK
                            iaas2DdVO.setDbQnty(dbQnty[i]);               // DB 수량
                    
                            // 공고 IaaS 상세정보(서버) 등록
                            service.insertBeforeIaas2DdAnswerAction(i,iaas2DdVO);
                        }                
                    }    
                }                
            }
            else if  (goodKndCd.equals("1004")) // Scs2
            {
                SuplerCeartScs2VO scsVO = new SuplerCeartScs2VO();
                scsVO.setNotifyNum(vo.getNotifyNum());                         // 공고번호
                scsVO.setNotifySeq(vo.getNotifySeq());                         // 공고차수
                scsVO.setSuplerId(vo.getSuplerId());                           // 공급자ID
                scsVO.setApplyGbn("Y");                                        // 답변여부
                
                scsVO.setCnslRelm(request.getParameter("cnslRelm"));           // 컨설팅 영역
                scsVO.setCnslRelmEtc(request.getParameter("cnslRelmEtc"));     // 컨설팅 영역 _ 기타
                scsVO.setCnslScope(request.getParameter("cnslScope"));         // 컨설팅 범위
                scsVO.setExcArea(request.getParameter("excArea"));             // 컨설팅 수행가능지역
                scsVO.setIndcWhole(request.getParameter("indcWhole"));         // 도입전반(성능/사용랑)
                scsVO.setSetupMgr(request.getParameter("setupMgr"));           // Setup & Migration 
                scsVO.setOper(request.getParameter("oper"));                   // 운영
                scsVO.setQlityTest(request.getParameter("qlityTest"));         // 품질보증/테스트
                scsVO.setScrty(request.getParameter("scrty"));                 // 보안
                scsVO.setEducation(request.getParameter("education"));         // 교육 

                // 공고 PaaS 답변 등록
                service.insertBeforeScs2AnswerAction(scsVO);
            }
        }
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      request.getParameter("q_currPage"));

        if(rtnVal > 0){
            // 목록으로 이동
            return alertAndRedirect(model, "견적서를 발송하였습니다", "/korean/pt/suplerCeart/BD_beforeRequestList.do");            
        }

        // 목록으로 이동
        String rtnUrl = "/korean/pt/suplerCeart/BD_requestDetailView.do?p_notifyNum="+request.getParameter("notifyNum") + "&p_notifySeq=" + request.getParameter("notifySeq");
        return alertAndRedirect(model, "발송처리중 오류가 발생되었습니다.", rtnUrl);
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
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setCommUserId(userLoginVO.getUserId());
        }
        String rlCntrctInsttAt = request.getParameter("rlCntrctInsttAt");
        if(request.getParameter("p_cntrctSn") != null && !request.getParameter("p_cntrctSn").equals("")){
            vo.setCntrctSn(Integer.parseInt(request.getParameter("p_cntrctSn")));
            // 계약서 정보 및 실제이용자정보조회
            SuplerCntrctVO pvo = (SuplerCntrctVO)service.cntrctDetail(vo);
            if((pvo.getRealOrgNm() != null && !pvo.getRealOrgNm().equals("")) || (rlCntrctInsttAt !=null && rlCntrctInsttAt.equals("Y"))) 
              {   rlCntrctInsttAt = "Y"; pvo.setRlCntrctInsttAt("Y"); }
            
            model.addAttribute(GlobalConfig.KEY_BASE_VO, pvo);
            // 계약체결서비스
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.cntrctDtlGoodsList(vo));
        }

        // 조회조건 반환
        model.addAttribute("rlCntrctInsttAt", rlCntrctInsttAt );
        model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      vo.getQ_currPage());
        return "/korean/pt/suplerCeart/BD_myCntrct.form";
    }
    
    /**
     * 
     * ND_suplerCntrctRegistAction (계약서 등록)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/ND_suplerCntrctRegistAction.do", method = RequestMethod.POST)
    public String ND_suplerCntrctRegistAction(ModelMap model, HttpServletRequest request, SuplerCntrctVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/suplerCeart/BD_myCntrctForm.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getMasterId());
            vo.setRegistId(userLoginVO.getUserId());
        }

        // 업로드 파일 설정
        List<FileVO> uploadFile = UploadHelper.upload(request, SUPLER_FILE_PATH);
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
        //계야기관과 동일하지 안음을 체크 안하면 관련 데이타 초기화 
        if(vo.getRlCntrctInsttAt() == null){
            vo.setUserSe("");   //이용자구분
            vo.setSportAt("");  //지원사업여부 
        }else  if(vo.getRlCntrctInsttAt() != null && vo.getRlCntrctInsttAt().equals("Y")){
            if(vo.getUserSe()!= null && vo.getUserSe().equals("2")) //민간기업 선택시 
                vo.setSportAt("");  //지원사업여부
        }

        if(vo.getCntrctSn()!=0 || vo.getRegistMthdCode() == 1002){
            confirmCnt = service.updateCntrctCmpl(vo);
        }else{
            confirmCnt = service.insertCntrctCmpl(vo);
        }
        
        // 조회조건 반환
/*      model.addAttribute("searchDiv01",   request.getParameter("searchDiv01"));
        model.addAttribute("searchDiv02",   request.getParameter("searchDiv02"));
        model.addAttribute("searchKeyWord", request.getParameter("searchKeyWord"));
        model.addAttribute("currPage",      vo.getQ_currPage());*/
       // if(confirmCnt <= 0){
       // return alertAndRedirect(model, "저장에 실패하였습니다.", "/korean/pt/suplerCeart/BD_myCntrctForm.do?");
       // }
       
        String rlCntrctInsttAt = request.getParameter("p_rlCntrctInsttAt");
        if(rlCntrctInsttAt != null && rlCntrctInsttAt.equals("Y"))
            return alertAndRedirect(model, "계약번호가 생성 저장이 완료 되었습니다. 실제이용자정보를 등록하시 바랍니다.", "/korean/pt/suplerCeart/BD_myCntrctForm.do?cntrctSn="+vo.getCntrctSn()+"&p_cntrctSn="+vo.getCntrctSn()+"&rlCntrctInsttAt=Y");
        else 
            return alertAndRedirect(model, "저장이 완료 되었습니다.", "/korean/pt/suplerCeart/BD_suplySttusList.do");
    }
    

    /**
     * 
     * PD_UserSeachPop (구매자검색 팝업)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/PD_BuyUserSearchPop.do") 
    public void PD_BuyUserSearchPop(HttpServletRequest request, ModelMap model, SuplerServiceVO vo, @PathVariable String pathLang) {
        
        
        OpHelper.bindSearchMap(vo, request, 5);// 팝업 이므로 한 페이지에 5개의 서비스만 표기
        vo.setLangCode(Language(request));
        
       
        // 구매자 찾기 팝업 -- 쿼리 18초 걸림 3001번 회사명 가져오는 테이블 데이터가 12만건정도 (조회조건 입력으로 우선 변경처리)
        if(vo.getSearchKeyWord() != null && !vo.getSearchKeyWord().equals("")){
            model.addAttribute(GlobalConfig.KEY_PAGER, service.buyUserList(vo));
        }
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",   vo.getSearchDiv01());
        model.addAttribute("searchKeyWord", vo.getSearchKeyWord());
        model.addAttribute("currPage",      vo.getQ_currPage());

    }
    
}
