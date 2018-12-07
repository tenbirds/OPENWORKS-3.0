/*
\ * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.main;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.popup.PopupService;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
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
public class MainController extends GeneralController {

    @Autowired 
    private MainService service;
    
    @Autowired 
    private CommonDutyService codtservice;
    
    @Autowired
    private PopupService popupService;
    /**
     * 사용자 메인 화면 - 게시판 최근 목록, 팝업존, 퀵, 배너 목록 등
     */
    @RequestMapping(value = {"/**/pt/index.do"})
    public String indexPtMain(HttpServletRequest request, ModelMap model, HttpSession session) {

        String hostNm = "";
        String domainCd = "";
        hostNm = "korean";

        if(!"".equals(hostNm)){
            domainCd = new MainConstant().getDomainCode(hostNm);
            if(domainCd == null){
                domainCd = "2";
            }
        } else {
            domainCd = "2"; //기본 한국어로 세팅
        }
        String langCd = codtservice.getLangCd(Integer.parseInt(domainCd));

        // 공지사항 최근 목록
        model.addAttribute(MainConstant.KEY_NOTICE_LIST, service.boardList(MainConstant.NOTICE_BBS_CD, new Integer(domainCd)));

        // 행사정보 최근 목록
        model.addAttribute(MainConstant.KEY_EVENT_LIST, service.boardList(MainConstant.EVENT_BBS_CD, new Integer(domainCd)));

        String currDate1001 = service.boardList1(1001, new Integer(domainCd));   
        String currDate1007 = service.boardList1(1007, new Integer(domainCd));        
       
        double intCurrDate1001 = Double.parseDouble(currDate1001);
        double intCurrDate1007 = Double.parseDouble(currDate1007);        

        if(intCurrDate1001 > intCurrDate1007 ){
            model.addAttribute("currDate1001", "borR0 selectab");
            model.addAttribute("currDate1007", "");            
        } else if(intCurrDate1001 < intCurrDate1007 ){
            model.addAttribute("currDate1001", "");
            model.addAttribute("currDate1007", "borR0 selectab");            
        }        
        

        // 정책동향
        model.addAttribute("list1023", service.boardList(1023, new Integer(domainCd)));

        
        // 시장동향 
        model.addAttribute("list1024", service.boardList(1024, new Integer(domainCd)));
        
        String currDate1023 = service.boardList1(1023, new Integer(domainCd));   
        String currDate1024 = service.boardList1(1024, new Integer(domainCd));        

        double intCurrDate1023 = Double.parseDouble(currDate1023);
        double intCurrDate1024 = Double.parseDouble(currDate1024);        
        
        
        if(intCurrDate1023 > intCurrDate1024){
            model.addAttribute("currDate1023", "borR0 selectab");
            model.addAttribute("currDate1024", "");            
        } else if(intCurrDate1023 < intCurrDate1024){
            model.addAttribute("currDate1023", "");
            model.addAttribute("currDate1024", "borR0 selectab");            
        }
        
        // 씨앗블러그
        model.addAttribute("list1029", service.boardList(1029, new Integer(domainCd)));
        
        // 뉴스레터
        model.addAttribute("list1012", service.boardList(1012, new Integer(domainCd)));
        
        String currDate1029 = service.boardList1(1029, new Integer(domainCd));   
        String currDate1012 = service.boardList1(1012, new Integer(domainCd));        
        
        double intCurrDate1029 = Double.parseDouble(currDate1029);
        double intCurrDate1012 = Double.parseDouble(currDate1012);        

        
        if(intCurrDate1029 > intCurrDate1012){
            model.addAttribute("currDate1029", "borR0 selectab");
            model.addAttribute("currDate1012", "");            
        } else if(intCurrDate1029 < intCurrDate1012){
            model.addAttribute("currDate1029", "");
            model.addAttribute("currDate1012", "borR0 selectab");            
        }        

        
        // 자료실
        model.addAttribute("list1030", service.boardList(1030, new Integer(domainCd)));
        
        // 비즈매칭
        model.addAttribute("list1010", service.boardList(1010, new Integer(domainCd)));
        
        // 지식허브 최근 목록
        //model.addAttribute(MainConstant.KEY_KNWLDG_HUB_LIST, service.knwldgHubList(new Integer(domainCd)));

        // 씨앗통계
        model.addAttribute("staticInfo", service.boardList(1026, new Integer(domainCd)).get(0).getBbscttSeq());

       
        // 성공스토리 목록
        //model.addAttribute(MainConstant.KEY_SUCCESS_STORY_LIST, service.boardList(MainConstant.SUCCESS_STORY_BBS_CD, new Integer(domainCd)));

        
        //팝업존 목록
        List<BannerVO> PopupZoneList = new ArrayList<BannerVO>();
        BannerVO bannerVO = new BannerVO();
        bannerVO.setDomainCd(new Integer(domainCd));    //도메인코드 세팅
        PopupZoneList = service.PopupZoneListToday(bannerVO);
        model.addAttribute("PopupZoneCount", PopupZoneList.size());
        model.addAttribute("PopupZoneList", PopupZoneList);
        //광고_배너
        List<BannerVO> banner = new ArrayList<BannerVO>();
        banner = service.bannerListToday(bannerVO);
        model.addAttribute("banner", banner);
        //프리미엄추천서비스 리스트
        /*
        List<PremiumVO> recomPgdList = new ArrayList<PremiumVO>();
        PremiumVO rpvo = new PremiumVO();
        rpvo.setLangCode(langCd);
        rpvo.setGoodsTyCd(1001);
        recomPgdList = service.rcmdList(rpvo);
        model.addAttribute(MainConstant.KEY_RECOMP_LIST, recomPgdList);
        */
        //솔루션추천서비스 리스트
        /*
        List<PremiumVO> recomSgdList = new ArrayList<PremiumVO>();
        PremiumVO rsvo = new PremiumVO();
        rsvo.setLangCode(langCd);
        rsvo.setGoodsTyCd(1002);
        recomSgdList = service.rcmdList(rsvo);
        model.addAttribute(MainConstant.KEY_RECOMS_LIST, recomSgdList);
        */
        //컨설팅추천서비스 리스트
        /*
        List<PremiumVO> recomCgdList = new ArrayList<PremiumVO>();
        PremiumVO rcvo = new PremiumVO();
        rcvo.setLangCode(langCd);
        rcvo.setGoodsTyCd(1003);
        recomCgdList = service.rcmdList(rcvo);
        model.addAttribute(MainConstant.KEY_RECOMC_LIST, recomCgdList);
        */
        //신청수 리스트
        /*
        List<PremiumVO> reqTop10List = new ArrayList<PremiumVO>();
        PremiumVO reqvo = new PremiumVO();
        reqvo.setLangCode(langCd);
        reqTop10List = service.mainGoodsList(reqvo, "R");
        model.addAttribute(MainConstant.KEY_RTOP_LIST, reqTop10List);
        */
        //판매자 TOP10 리스트
        /*
        List<PremiumVO> selTop10List = new ArrayList<PremiumVO>();
        PremiumVO stvo = new PremiumVO();
        stvo.setLangCode(langCd);
        selTop10List = service.bestSellList(stvo);
        model.addAttribute(MainConstant.KEY_STOP_LIST, selTop10List);
        */
        //평가 TOP10 리스트
        /*
        List<PremiumVO> evlTop10List = new ArrayList<PremiumVO>();
        PremiumVO evo = new PremiumVO();
        evo.setLangCode(langCd);
        evlTop10List = service.mainGoodsList(evo, "E");
        model.addAttribute(MainConstant.KEY_ETOP_LIST, evlTop10List);
        */
        //신규 서비스 리스트
        List<PremiumVO> newGoodsList = new ArrayList<PremiumVO>();
        PremiumVO nvo = new PremiumVO();
        nvo.setLangCode(langCd);
        newGoodsList = service.mainGoodsList(nvo, "N");
        model.addAttribute(MainConstant.KEY_NGOODS_LIST, newGoodsList);

        //체험 서비스 리스트
       /* List<PremiumVO> exprnGoodsList = new ArrayList<PremiumVO>();
        PremiumVO eprvo = new PremiumVO();
        eprvo.setLangCode(langCd);
        exprnGoodsList = service.mainGoodsList(eprvo, "EPR");
        model.addAttribute(MainConstant.KEY_EGOODS_LIST, exprnGoodsList);*/

        //신규 입찰정보 TOP3 리스트
        BidInfoVO bidvo = new BidInfoVO();
        model.addAttribute(MainConstant.KEY_BID_LIST, service.bidInfoMainList(bidvo));
        /*
        MyCeartBidNotifyVO bidnotvo = new MyCeartBidNotifyVO();
        bidnotvo.setClseDt("ing");
        model.addAttribute(MainConstant.KEY_BIDNOTIFY_INGLIST, service.bidNofiyMainList(bidnotvo));
        
        bidnotvo.setClseDt("end");
        model.addAttribute(MainConstant.KEY_BIDNOTIFY_ENDLIST, service.bidNofiyMainList(bidnotvo));
        */
        
       // Map<String, Object> resultMap = service.mainCntInfo();
        //비즈매칭
        //BizMatchVO bizvo = new BizMatchVO();
        //model.addAttribute(MainConstant.KEY_BIZ_LIST, service.bizMatchMainList(bizvo));
        
        
        model.addAttribute("cntInfo", service.mainCntInfo());
        
        model.addAttribute("frontInfo", popupService.selectFrontInfo() );
        
        String rtnIndex = "";
        if("".equals(hostNm)) {
            hostNm = "korean";
        } else if("www".equals(hostNm)) {
            hostNm = "korean";
        }
        rtnIndex = hostNm + "/pt/index";

        return rtnIndex;
    }
}