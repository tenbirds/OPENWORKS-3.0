/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bidSttus;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
import zes.openworks.web.bid.BidService;
import zes.openworks.web.bid.BidSuplerListVO;
import zes.openworks.web.bidSttus.vo.BidSttusListVO;
import zes.openworks.web.bidSttus.vo.BidSttusNotifySplyVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.myCeart.MyCeartService;
import zes.openworks.web.myCeart.vo.MyCeartTenderVO;
import zes.openworks.web.suplerCeart.SuplerCeartService;
import zes.openworks.web.suplerCeart.vo.SuplerCeartBidNotifyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDdVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasDsVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartIaasIVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartNotifySplyVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartPaasVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasDVO;
import zes.openworks.web.suplerCeart.vo.SuplerCeartSaasIVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 12.    이슬버미       신규
 *</pre>
 * @see
 */
/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 17.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = {"/**/bidSttus"})
public class BidSttusController extends WebController{

    /** 입찰공고 서비스 */
    @Autowired
    BidSttusService service;

    /** 공급자씨앗 관련 서비스 */
    @Autowired
    SuplerCeartService suplerCeartService;

    /** 마이씨앗 관련 서비스 */
    @Autowired
    MyCeartService myCeartService;

    /** 공통 관련 서비스 */
    @Autowired
    CommonDutyService commonService;
    
    /** 공통코드 관련 서비스 */
    @Autowired
    CodeService codeService;

    /** 공고/견적 등록 관련 서비스 */
    @Autowired
    BidService bidService;

    /** 알람 관련 서비스 */
    @Autowired
    AlarmService alarmService;

    @Autowired
    private AutoMailService amservice;
    
    @Autowired
    private SmsTransHistService smsService;
    
    /** 파일 저장 경로 */
    public static final String SUPLER_FILE_PATH = "supler" + File.separator;

    /**
     * 접속 사용자 도메인 값 불러와서 가져오기
     * */
    public String Language(HttpServletRequest request) {
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }

    /**
     * 입찰공고 - 공고현황 목록
     * */
    @RequestMapping(value = "/BD_bidSttusList.do",  method = RequestMethod.GET)
    public String BD_bidSttusList(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {
/*
        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_bidSttusList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }
*/
        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 최초 인입시 정렬조건이 없을경우 첫번째 조건으로 셋팅
        if(vo.getSearchDiv03() == null){
            vo.setSearchDiv03("1001");
        }

        // 본공고만 조회 가능하도록
        vo.setBidKndCd(1001);

        // 공고현황 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.bidSttusList(vo));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_bidSttusList";
    }

    /**
     * 
     * BD_bidSttusDetailView (입찰공고 - 공고현황 상세조회)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_bidSttusDetailView.do")
    public String BD_bidSttusDetailView(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {
/*
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_bidSttusList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }
*/
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
        List<SuplerCeartBidNotifyVO> requestMstInfo = suplerCeartService.suplerCeartBidNotifyInfo(bidNotifyVO);
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

            model.addAttribute("pass", suplerCeartService.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", suplerCeartService.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", suplerCeartService.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

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
            model.addAttribute("iassI", suplerCeartService.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", suplerCeartService.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", suplerCeartService.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_bidSttusDetail.view";
    }

    /**
     * 
     * BD_bidExtendView (입찰공고 - 공고 응찰 페이지 호출)
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
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_bidSttusList.do";
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
        List<SuplerCeartBidNotifyVO> requestMstInfo = suplerCeartService.suplerCeartBidNotifyInfo(bidNotifyVO);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자의 확인정보 조회
        SuplerCeartNotifySplyVO notifySplyVO = new SuplerCeartNotifySplyVO();
        notifySplyVO.setNotifyNum(vo.getNotifyNum());
        notifySplyVO.setNotifySeq(vo.getNotifySeq());
        notifySplyVO.setSuplerId(vo.getSuplerId());
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.suplerBidSttusInfo(notifySplyVO).get(0));

        // 해당 견적의 서비스 구분
        String goodKndCd  =  Integer.toString( requestMstInfo.get(0).getGoodKndCd() );
        String endsUserId =  requestMstInfo.get(0).getEndsUserId() ;  // 견적의 수요자ID

        if(goodKndCd.equals("1001")){
            SuplerCeartPaasVO paasVO = new SuplerCeartPaasVO();
            paasVO.setNotifyNum(vo.getNotifyNum());
            paasVO.setNotifySeq(vo.getNotifySeq());
            paasVO.setEndsUserId(endsUserId);         // 수요자 ID
            paasVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("pass", suplerCeartService.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", suplerCeartService.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", suplerCeartService.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

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
            model.addAttribute("iassI", suplerCeartService.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", suplerCeartService.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", suplerCeartService.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_bidExtend.view";
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
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_requestDetailView.do";
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
        int rtnVal = service.updateNotifySplyAction(vo);

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
                    autoMap.put("automailId", AutoMailTemplate.KOR_BID_05REQ);
                    HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
                    oneToOneInfoMap.put("title",suplerList.get(i).getBidNotifyNm());                
                    autoMap.put("oneToOneInfo", oneToOneInfoMap);
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
            rtnVal = service.insertNotifySplyAction(vo);
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
                int paasVal = suplerCeartService.updatePaasAnswerAction(paasVO);
                if(paasVal == 0 ){
                    suplerCeartService.insertPaasAnswerAction(paasVO);    
                }
            }else if(goodKndCd.equals("1002")){
                SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
                saasIVO.setNotifyNum(vo.getNotifyNum());                                       // 공고번호
                saasIVO.setNotifySeq(vo.getNotifySeq());                                       // 공고차수
                saasIVO.setSuplerId(vo.getSuplerId());                                         // 공급자ID
                saasIVO.setApplyGbn("Y");                                                      // 답변여부

                if(request.getParameter("unitSys")!=null && !request.getParameter("unitSys").equals("")){
                    saasIVO.setUnitSys(request.getParameter("unitSys"));         // 전체단위    
                }
                
                saasIVO.setEtcUnitSys(request.getParameter("etcUnitSys"));                     // 기타단위내용
                saasIVO.setCaptySys(request.getParameter("captySys"));                         // 전체제공용량
                
                if(request.getParameter("amountSys")!=null && !request.getParameter("amountSys").equals("")){
                    saasIVO.setAmountSys(request.getParameter("amountSys"));     // 전체단가    
                }

                if(request.getParameter("splyMothSys")!=null && !request.getParameter("splyMothSys").equals("")){
                    saasIVO.setSplyMothSys(request.getParameter("splyMothSys")); // 제공방법    
                }
                
                // 입찰공고 SaaS 마스터 답변 등록(Update 처리건이 없을경우 신규건으로 간주)
                int saasVal = suplerCeartService.updateSaasIAnswerAction(saasIVO);
                if(saasVal == 0 ){
                    suplerCeartService.insertSaasIAnswerAction(saasIVO);    
                }

                // 입찰공고 SaaS 상세 답변 등록
                String[] optionNm   = request.getParameterValues("optionNm");
                String[] unitItem   = request.getParameterValues("unitItem");
                String[] captyItem  = request.getParameterValues("captyItem");
                String[] amountItem = request.getParameterValues("amountItem");
                String[] cmntItem   = request.getParameterValues("cmntItem");

                // 입찰공고 SaaS 상세정보 삭제(상세정보는 삭제 후 재등록)
                suplerCeartService.deleteSaasDAnswerAction(saasIVO);

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
                            suplerCeartService.insertSaasDAnswerAction(saasDVO);
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
                int iaasVal = suplerCeartService.updateIaasIAnswerAction(iaasIVO);
                if(iaasVal == 0 ){
                    suplerCeartService.insertIaasIAnswerAction(iaasIVO);    
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
                suplerCeartService.deleteIaasDsAnswerAction(iaasIVO);
                
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
                            suplerCeartService.insertIaasDsAnswerAction(iaasDsVO);
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
                suplerCeartService.deleteIaasDdAnswerAction(iaasIVO);

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
                            suplerCeartService.insertIaasDdAnswerAction(iaasDdVO);
                        }                
                    }
                }
            }

        }
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        if(rtnVal > 0){
            // 목록으로 이동
            return alertAndRedirect(model, "응찰이 완료 되었습니다.", "/korean/pt/bidSttus/BD_bidSttusList.do");            
        }

        // 목록으로 이동
        String rtnUrl = "/korean/pt/bidSttus/BD_bidExtendView.do?p_notifyNum="+request.getParameter("notifyNum") + "&p_notifySeq=" + request.getParameter("notifySeq");
        return alertAndRedirect(model, "응찰처리중 오류가 발생되었습니다.", rtnUrl);
    }

    /**
     * 입찰공고 - 예비공고 목록
     * */
    @RequestMapping(value = "/BD_preparBidList.do",  method = RequestMethod.GET)
    public String BD_preparBidList(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {
/*
        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_preparBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }
*/
        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 최초 인입시 정렬조건이 없을경우 첫번째 조건으로 셋팅
        if(vo.getSearchDiv03() == null){
            vo.setSearchDiv03("1001");
        }

        // 예비공고만 조회 가능하도록
        vo.setBidKndCd(1002);

        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.bidSttusList(vo));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_preparBidList";
    }


    /**
     * 
     * BD_preparBidView (입찰공고 - 예비공고 상세조회)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_preparBidView.do",  method = RequestMethod.GET)
    public String BD_preparBidView(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {
/*
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_preparBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }
*/
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
        List<SuplerCeartBidNotifyVO> requestMstInfo = suplerCeartService.suplerCeartBidNotifyInfo(bidNotifyVO);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자 응찰현황 조회
        MyCeartTenderVO myCeartTenderVO = new MyCeartTenderVO();
        myCeartTenderVO.setNotifyNum(vo.getNotifyNum());
        myCeartTenderVO.setNotifySeq(vo.getNotifySeq());
        myCeartTenderVO.setAskApplyCd( Integer.parseInt("1003") );  // 답변상태(1003:답변)
        myCeartTenderVO.setBidPgesStat( Integer.parseInt(requestMstInfo.get(0).getBidPgesStat()) ); // 입찰진행상태(1002:응찰)
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

            model.addAttribute("pass", suplerCeartService.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", suplerCeartService.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", suplerCeartService.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

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
            model.addAttribute("iassI", suplerCeartService.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", suplerCeartService.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", suplerCeartService.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_preparBid.view";
    }


    /**
     * 입찰공고 - 마감공고 목록
     * */
    @RequestMapping(value = "/BD_closBidList.do")
    public String BD_closBidList(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {
/*
        // 로그인 회원 체크(로그인 OK -> 공급자 ID 바인딩)
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_closBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());
        }
*/
        // parameter 바인딩
        OpHelper.bindSearchMap(vo, request);
        // 언어코드 바인딩
        vo.setLangCode(Language(request));

        // 최초 인입시 정렬조건이 없을경우 첫번째 조건으로 셋팅
        if(vo.getSearchDiv03() == null){
            vo.setSearchDiv03("1001");
        }

        /*
         * 마감된 공고만 조회 가능하도록
         * -> 공고 접수마감일이 초과하였거나 개찰(1004), 유찰(1005), 낙찰완료(1006), 낙찰취소(1007), 공고취소(1011) 건만 조회
         * */
        vo.setCloseYn("Y");
        
        //상세정보(견적)요청서 목록 조회
        model.addAttribute(GlobalConfig.KEY_PAGER, service.bidSttusList(vo));
        
        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_closBidList";
    }

    /**
     * 
     * BD_closBidView (입찰공고 - 마감공고 상세조회)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_closBidView.do")
    public String BD_closBidView(HttpServletRequest request, ModelMap model, BidSttusListVO vo) {
/*
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/pt/bidSttus/BD_closBidList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setSuplerId(userLoginVO.getUserId());  // 공급자 ID 바인딩
        }
*/
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
        List<SuplerCeartBidNotifyVO> requestMstInfo = suplerCeartService.suplerCeartBidNotifyInfo(bidNotifyVO);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, requestMstInfo.get(0));

        // 공급자 응찰현황 조회
        MyCeartTenderVO myCeartTenderVO = new MyCeartTenderVO();
        myCeartTenderVO.setNotifyNum(vo.getNotifyNum());
        myCeartTenderVO.setNotifySeq(vo.getNotifySeq());
        myCeartTenderVO.setAskApplyCd( Integer.parseInt("1003") );  // 답변상태(1003:답변)
        myCeartTenderVO.setBidPgesStat( Integer.parseInt(requestMstInfo.get(0).getBidPgesStat()) ); // 입찰진행상태(1002:응찰)
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

            model.addAttribute("pass", suplerCeartService.suplerCeartInfoByPass(paasVO)); // PaaS 정보 조회

        }else if(goodKndCd.equals("1002")){
            SuplerCeartSaasIVO saasIVO = new SuplerCeartSaasIVO();
            saasIVO.setNotifyNum(vo.getNotifyNum());
            saasIVO.setNotifySeq(vo.getNotifySeq());
            saasIVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasIVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassI", suplerCeartService.suplerCeartInfoBySassI(saasIVO)); // SaaS 정보 조회
            
            SuplerCeartSaasDVO saasDVO = new SuplerCeartSaasDVO();
            saasDVO.setNotifyNum(vo.getNotifyNum());
            saasDVO.setNotifySeq(vo.getNotifySeq());
            saasDVO.setEndsUserId(endsUserId);         // 수요자 ID
            saasDVO.setSuplerId(vo.getSuplerId());     // 공급자 ID

            model.addAttribute("sassD", suplerCeartService.suplerCeartInfoBySassD(saasDVO)); // SaaS 상세정보 조회

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
            model.addAttribute("iassI", suplerCeartService.suplerCeartInfoByIassI(iaasIVO));   // IaaS 마스터 정보 조회
            
            SuplerCeartIaasDsVO iaasDsVO = new SuplerCeartIaasDsVO();
            iaasDsVO.setNotifyNum(vo.getNotifyNum());
            iaasDsVO.setNotifySeq(vo.getNotifySeq());
            iaasDsVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDsVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDs", suplerCeartService.suplerCeartInfoByIassDs(iaasDsVO)); // IaaS 서버문의 조회

            SuplerCeartIaasDdVO iaasDdVO = new SuplerCeartIaasDdVO();
            iaasDdVO.setNotifyNum(vo.getNotifyNum());
            iaasDdVO.setNotifySeq(vo.getNotifySeq());
            iaasDdVO.setEndsUserId(endsUserId);         // 수요자 ID
            iaasDdVO.setSuplerId(vo.getSuplerId());     // 공급자 ID
            model.addAttribute("iassDd", suplerCeartService.suplerCeartInfoByIassDd(iaasDdVO)); // IaaS DB문의 조회
        }

        // 조회조건 반환
        model.addAttribute("searchDiv01",     vo.getSearchDiv01());     // 공고명/공고번호 구분
        model.addAttribute("searchKeyWord01", vo.getSearchKeyWord01()); // 공고명/공고번호 입력
        model.addAttribute("searchDiv02",     vo.getSearchDiv02());     // 공고일/개찰일 구분
        model.addAttribute("searchStartDt",   vo.getSearchStartDt());   // 검색 시작일
        model.addAttribute("searchEndDt",     vo.getSearchEndDt());     // 검색 종료일
        model.addAttribute("searchKeyWord02", vo.getSearchKeyWord02()); // 수요기관명
        model.addAttribute("searchDiv03",     vo.getSearchDiv03());     // 정렬구분
        model.addAttribute("currPage",        vo.getQ_currPage());      // 페이지 번호

        return "/korean/pt/bidSttus/BD_closBid.view";
    }
}
