/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.explorer;

import java.util.HashMap;
import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsManageVO;

/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 15.    김영상       신규
 *</pre>
 * @see
 */
public interface ExplorerService {

    /**
     * typeOfUserList 설명
     * @param vo
     * @return
     */
    List<ExplorerVO> typeOfUserList(ExplorerVO vo);

    /**
     * goodsEsState 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> goodsEsState(GoodsManageVO vo);

    /**
     * goodsCsState 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> goodsCsState(GoodsManageVO vo);

    /**
     * itExpertEsState 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> itExpertEsState(GoodsManageVO vo);

    /**
     * itExpertCsState 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> itExpertCsState(GoodsManageVO vo);

    /**
     * cmmntyEsthState 설명
     * @param vo
     * @return
     */
    List<ExplorerVO> cmmntyEsthState(ExplorerVO vo);

    /**
     * recentQnAState 설명
     * @param vo
     * @return
     */
    List<ExplorerVO> recentQnAState(ExplorerVO vo);

    /**
     * typeOfUserCount 설명
     * @param vo
     * @return
     */
    Integer typeOfUserCount(ExplorerVO vo);

    /**
     * goodsEsCnt 설명
     * @param gvo
     * @return
     */
    Integer goodsEsCnt(GoodsManageVO gvo);

    /**
     * goodsEsDelayCnt 설명
     * @param gvo
     * @return
     */
    Integer goodsEsDelayCnt(GoodsManageVO gvo);

    /**
     * itExpertEsCnt 설명
     * @param gvo
     * @return
     */
    Integer itExpertEsCnt(GoodsManageVO gvo);

    /**
     * itExpertEsDelayCnt 설명
     * @param gvo
     * @return
     */
    Integer itExpertEsDelayCnt(GoodsManageVO gvo);

    /**
     * goodsCsCnt 설명
     * @param gvo
     * @return
     */
    Integer goodsCsCnt(GoodsManageVO gvo);

    /**
     * goodsCsDelayCnt 설명
     * @param gvo
     * @return
     */
    Integer goodsCsDelayCnt(GoodsManageVO gvo);

    /**
     * itExpertCsCnt 설명
     * @param gvo
     * @return
     */
    Integer itExpertCsCnt(GoodsManageVO gvo);

    /**
     * itExpertCsDelayCnt 설명
     * @param gvo
     * @return
     */
    Integer itExpertCsDelayCnt(GoodsManageVO gvo);

    /**
     * cmmntyEsthCnt 설명
     * @param vo
     * @return
     */
    Integer cmmntyEsthCnt(ExplorerVO vo);

    /**
     * recentQnACnt 설명
     * @param vo
     * @return
     */
    Integer recentQnACnt(ExplorerVO vo);

    /**
     * goodsRcCsState 설명
     * @param gvo
     * @return
     */
    List<GoodsManageVO> goodsRcCsState(GoodsManageVO gvo);

    /**
     * itExpertRcCsState 설명
     * @param gvo
     * @return
     */
    List<GoodsManageVO> itExpertRcCsState(GoodsManageVO gvo);

    /**
     * typeOfGoodsList 설명
     * @param vo
     * @return
     */
    List<ExplorerVO> typeOfGoodsList(ExplorerVO vo);

    /**
     * bizMatchCnt 설명
     * @param vo
     * @return
     */
    Integer bizMatchCnt(ExplorerVO vo);

    /**
     * svcLangCount 설명
     * @param vo
     * @return
     */
    Integer svcLangCount(ExplorerVO vo);

    
    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */ 
    /**
     * psEsState 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> psEsState(GoodsManageVO vo);

    /**
     * psCsState 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> psCsState(GoodsManageVO vo);

    /**
     * psEsCnt 설명
     * @param gvo
     * @return
     */
    Integer psEsCnt(GoodsManageVO gvo);

    /**
     * psEsDelayCnt 설명
     * @param gvo
     * @return
     */
    Integer psEsDelayCnt(GoodsManageVO gvo);

    /**
     * psCsCnt 설명
     * @param gvo
     * @return
     */
    Integer psCsCnt(GoodsManageVO gvo);

    /**
     * psCsDelayCnt 설명
     * @param gvo
     * @return
     */
    Integer psCsDelayCnt(GoodsManageVO gvo);
    /**
     * currentStateTotal 설명
     * @param vo
     * @return
     */
    Integer currentStateTotal(ExplorerVO vo);
    /* }} */


    /**
     * todayWorkList (오늘의 할 일[2017.01.18 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> todayWorkList(ExplorerVO vo);

    /**
     * serviceProvsChangeList (오늘의 서비스변동(전일대비) [2017.01.20 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> serviceProvsChangeList(ExplorerVO vo);

    /**
     * userSttusByDayList (회원현황[2017.01.18 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> userSttusByDayList(ExplorerVO vo);

    /**
     * cntrTotAmountList (계약 일 동향 총 합계[2017.01.18 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> cntrTotAmountList(ExplorerVO vo);
    
    /**
     * buyActTrendByDayList (구매활동 일동향[2017.01.18 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> buyActTrendByDayList(ExplorerVO vo);

    /**
     * serviceDispTrendList (서비스전시 총동향[2017.01.20 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> serviceDispTrendList(ExplorerVO vo);

    /**
     * cntrAmountList (계약 일 동향[2017.01.18 추가])
     * @param vo
     * @return
     */
    List<ExplorerVO> cntrAmountList(ExplorerVO vo);

    /**
     * ceartPresentCondition 설명
     * @param vo
     * @return
     */
    ExplorerVO ceartPresentCondition(ExplorerVO vo);

    /**
     * goodsList 설명
     * @param gvo
     * @return
     */
    List<ExplorerVO> goodsList(ExplorerVO vo);

    /**
     * ceartWorkCondition 설명
     * @param vo
     * @return
     */
    ExplorerVO ceartWorkCondition(ExplorerVO vo);

    /**
     * totalCntrAmount 설명
     * @param vo
     * @return
     */
    ExplorerVO totalCntrAmount(ExplorerVO vo);

    /**
     * totalCntrTopListJson 설명
     * @param vo
     * @return
     */
    List totalCntrTopList(HashMap<String, String> map);

    /**
     * totalCntrCntTopList 설명
     * @param map
     * @return
     */
    List totalCntrCountTopList(HashMap<String, String> map);
    
    /**
     * cntrctAmountViewList 설명
     * @param map
     * @return
     */
    List cntrctAmountViewList(HashMap<String, String> map);

    /**
     * cntrctRatio 설명
     * @param vo
     * @return
     */
    ExplorerVO cntrctRatio(ExplorerVO vo);

    /**
     * cntrctCountRatio 설명
     * @param vo
     * @return
     */
    ExplorerVO cntrctCountRatio(ExplorerVO vo);

    /**
     * cntrctCountViewList 설명
     * @param map
     * @return
     */
    List cntrctCountViewList(HashMap<String, String> map);
}
