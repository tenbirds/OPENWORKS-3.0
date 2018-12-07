/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.mobile.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.popup.PopupService;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.main.MainConstant;
import zes.openworks.web.main.MainService;
import zes.openworks.web.store.premium.PremiumVO;

/**
 * 메인화면 게시판 최근목록, 팝업존 목록 등 관리 컨트롤러
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2014. 11. 19.     김영상      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
public class MobMainController extends GeneralController {

    @Autowired
    private MainService service;
    @Autowired
    private CommonDutyService codtservice;

    @Autowired
    private PopupService popupService;

    /**
     * 사용자 메인 화면 - 게시판 최근 목록, 팝업존, 퀵, 배너 목록 등
     */
    @RequestMapping(value = {"/**/m/index.do"})
    public String indexPtMain(HttpServletRequest request, ModelMap model, HttpSession session, BoardVO vo) {
        //도메인별 도메인코드를 설정
        String domainCd = "2";
        String langCd = codtservice.getLangCd(Integer.parseInt(domainCd));
        
        model.addAttribute("cntInfo", service.mainCntInfo()); //서비스 현황
        
        //인기(신청수) TOP10 리스트
        List<PremiumVO> reqTop10List = new ArrayList<PremiumVO>();
        PremiumVO reqvo = new PremiumVO();
        reqvo.setLangCode(langCd);
        reqTop10List = service.top10List(reqvo, "R");
        model.addAttribute(MainConstant.KEY_RTOP_LIST, reqTop10List);
        
        //신규 TOP10 리스트
        List<PremiumVO> newTop10List = new ArrayList<PremiumVO>();
        PremiumVO nvo = new PremiumVO();
        nvo.setLangCode(langCd);
        newTop10List = service.top10List(nvo, "N");
        model.addAttribute(MainConstant.KEY_NTOP_LIST, newTop10List);

        // 성공스토리 목록
       // model.addAttribute(MainConstant.KEY_SUCCESS_STORY_LIST, service.boardList(MainConstant.SUCCESS_STORY_BBS_CD, new Integer(domainCd)));

        // 공지사항 최근 목록
        model.addAttribute(MainConstant.KEY_NOTICE_LIST, service.boardList(MainConstant.NOTICE_BBS_CD, new Integer(domainCd)));
        // 씨앗통계 링크
        model.addAttribute("staticInfo", service.boardList(1026, new Integer(domainCd)).get(0).getBbscttSeq());
        
        //모바일 메인 화면
        model.addAttribute("staticList", service.boardViewM(vo,1026)); // 20180702 추가 
        model.addAttribute("eventList", service.boardViewM(vo,1007));
        model.addAttribute("ceartblogList", service.boardViewM(vo,1029));
        model.addAttribute("newsletterList", service.boardViewM(vo,1012));
        model.addAttribute("policyList", service.boardViewM(vo,1023));
        model.addAttribute("marketList", service.boardViewM(vo,1024));
      
        //신규 입찰정보 TOP3 리스트
        List<BidInfoVO> bidInfoMainList = new ArrayList<BidInfoVO>();
        BidInfoVO bidvo = new BidInfoVO();
        bidInfoMainList = service.bidInfoMainList(bidvo);
        model.addAttribute(MainConstant.KEY_BID_LIST, bidInfoMainList);
        
        
        model.addAttribute("frontInfo", popupService.selectFrontInfo() );

        String rtnIndex = "";
        rtnIndex = "korean/m/index";

        return rtnIndex;
    }
    
    /*
     * 모바일 커뮤니티 리스트화면
     * 
     * 
     * 
     */
    @RequestMapping(value = {"/**/m/communication/BD_index.do"})
    public String communiCation(HttpServletRequest request, ModelMap model, HttpSession session, BoardVO vo) {
        
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=/korean/m/index";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index_m.do" + returnUrl);
        }
        
        String rtnIndex = "";
        
        rtnIndex = "korean/m/communication/BD_index";
        
        OpHelper.bindSearchMap(vo, request, 10);
        
        vo.setUserId(userLoginVO.getUserId());
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());
        
        /* 메인 화면(리스트) 데이터  */
        model.addAttribute(GlobalConfig.KEY_PAGER, service.communicationList(vo));      
        return rtnIndex;
    }
}