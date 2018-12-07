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

import zes.base.pager.Pager;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.web.g2b.bidInfo.BidInfoVO;
import zes.openworks.web.myCeart.vo.MyCeartBidNotifyVO;
import zes.openworks.web.store.premium.PremiumVO;

/**
 * 사용자 메인 화면 서비스
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
public interface MainService {

    /**
     * 게시물 최근 목록 조회
     */
    List<BoardVO> boardList(Integer bbsCd, Integer domainCd);
    String boardList1(Integer bbsCd, Integer domainCd);
    /**
     * 지식허브 최근 목록 조회
     */
    List<BoardVO> knwldgHubList(Integer domainCd);

    /**
     * PopupZoneListToday 설명
     *
     * @param bannerVO
     * @return
     */
    List<BannerVO> PopupZoneListToday(BannerVO bannerVO);

    /**
     * quickMenuListToday 설명
     *
     * @param bannerVO
     * @return
     */
    List<BannerVO> quickMenuListToday(BannerVO bannerVO);

    /**
     * bannerListToday 설명
     *
     * @param bannerVO
     * @return
     */
    List<BannerVO> bannerListToday(BannerVO bannerVO);

    /**
     * rcmdList 설명
     * @param vo
     * @return
     */
    List<PremiumVO> rcmdList(PremiumVO vo);

    /**
     * top10List 설명
     * @param reqvo
     * @return
     */
    List<PremiumVO> top10List(PremiumVO reqvo, String se);

    /**
     * mainGoodsList 설명
     * @param reqvo
     * @return
     */
    List<PremiumVO> mainGoodsList(PremiumVO reqvo, String se);

    /**
     * bestSellList 설명
     * @param stvo
     * @return
     */
    List<PremiumVO> bestSellList(PremiumVO stvo);

    /**
     * bidInfoMainList (나라장터 입찰정보 리스트)
     *
     * @param vo
     * @return
     */
    List<BidInfoVO> bidInfoMainList(BidInfoVO vo);
    
    /**
     * bidInfoMainList (입찰정보 리스트)
     *
     * @param vo
     * @return
     */
    List<MyCeartBidNotifyVO> bidNofiyMainList(MyCeartBidNotifyVO vo);
    
    Map<String, Object> mainCntInfo();
    
    List<BoardVO> boardViewM(BoardVO vo,int type);
    
    Pager<BoardVO> communicationList(BoardVO vo);
    
}
