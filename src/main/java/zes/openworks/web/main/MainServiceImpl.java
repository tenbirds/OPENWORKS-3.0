/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.main;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.store.premium.PremiumVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 사용자 메인 화면 서비스 객체
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
 *  2014. 11. 20.     김영상      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service
public class MainServiceImpl extends AbstractServiceImpl implements MainService {

    @Resource
    MainDao mainDao;

    /**
     * 게시물 최근 목록 조회
     */
    @Override
    public List<BoardVO> boardList(Integer bbsCd,Integer domainCd) {
        return mainDao.boardList(bbsCd,domainCd);
    }
    @Override
    public String boardList1(Integer bbsCd,Integer domainCd) {
        return mainDao.boardList1(bbsCd,domainCd);
    }

    /**
     * 지식허브 최근 목록 조회
     */
    @Override
    public List<BoardVO> knwldgHubList(Integer domainCd) {
        return mainDao.knwldgHubList(domainCd);
    }

    /**
     * 오늘 날짜 팝업존 리스트
     */
    @Override
    public List<BannerVO> PopupZoneListToday(BannerVO bannerVO) {
        // 배너타입 팝업존
        bannerVO.setBannerTyCd(1001);
        return mainDao.PopupZoneListToday(bannerVO);
    }

    @Override
    public List<BannerVO> bannerListToday(BannerVO bannerVO) {
        // 배너
        bannerVO.setBannerTyCd(1002);
        return mainDao.bannerListToday(bannerVO);
    }

    @Override
    public List<BannerVO> quickMenuListToday(BannerVO bannerVO) {
        // 퀵링크
        bannerVO.setBannerTyCd(1003);
        return mainDao.quickMenuListToday(bannerVO);
    }


    @Override
    public List<PremiumVO> rcmdList(PremiumVO vo) {
        //추천리스트
        return mainDao.rcmdList(vo);
    }

    @Override
    public List<PremiumVO> top10List(PremiumVO vo, String se) {

        return mainDao.top10List(vo, se);
    }

    @Override
    public List<PremiumVO> mainGoodsList(PremiumVO vo, String se) {

        return mainDao.mainGoodsList(vo, se);
    }

    @Override
    public List<PremiumVO> bestSellList(PremiumVO vo) {

        return mainDao.bestSellList(vo);
    }

    @Override
    public List<BidInfoVO> bidInfoMainList(BidInfoVO vo) {

        return mainDao.bidInfoMainList(vo);
    }

    @Override
    public List<MyCeartBidNotifyVO> bidNofiyMainList(MyCeartBidNotifyVO vo) {
        return mainDao.bidNofiyMainList(vo);
    }
    
    @Override
    public Map<String, Object> mainCntInfo(){
        return mainDao.mainCntInfo();
    }
    
    @Override
    public List<BoardVO> boardViewM(BoardVO vo,int type) {
        return mainDao.boardViewM(vo,type);
    }
    @Override
    public Pager<BoardVO> communicationList(BoardVO vo) {
        return mainDao.communicationList(vo);
    }
}
