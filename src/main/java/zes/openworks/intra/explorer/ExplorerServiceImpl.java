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

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2015. 1. 15.    김영상       신규
 * </pre>
 * @see
 */
@Service("explorerService")
public class ExplorerServiceImpl extends AbstractServiceImpl implements ExplorerService {

    @Resource
    private ExplorerDAO dao;

    @Override
    public List<ExplorerVO> typeOfUserList(ExplorerVO vo) {
        return dao.typeOfUserList(vo);
    }

    @Override
    public List<GoodsManageVO> goodsEsState(GoodsManageVO vo) {
        return dao.goodsEsState(vo);
    }

    @Override
    public List<GoodsManageVO> goodsCsState(GoodsManageVO vo) {
        return dao.goodsCsState(vo);
    }

    @Override
    public List<GoodsManageVO> itExpertEsState(GoodsManageVO vo) {
        return dao.itExpertEsState(vo);
    }

    @Override
    public List<GoodsManageVO> itExpertCsState(GoodsManageVO vo) {
        return dao.itExpertCsState(vo);
    }
    
    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */
    @Override
    public List<GoodsManageVO> psEsState(GoodsManageVO vo) {
        return dao.psEsState(vo);
    }

    @Override
    public List<GoodsManageVO> psCsState(GoodsManageVO vo) {
        return dao.psCsState(vo);
    }
    /* }} */
    
    @Override
    public List<ExplorerVO> cmmntyEsthState(ExplorerVO vo) {
        return dao.cmmntyEsthState(vo);
    }

    @Override
    public List<ExplorerVO> recentQnAState(ExplorerVO vo) {
        return dao.recentQnAState(vo);
    }

    @Override
    public Integer typeOfUserCount(ExplorerVO vo) {

        return dao.typeOfUserCount(vo);
    }

    @Override
    public Integer goodsEsCnt(GoodsManageVO gvo) {
        return dao.goodsEsCnt(gvo);
    }

    @Override
    public Integer goodsEsDelayCnt(GoodsManageVO gvo) {
        return dao.goodsEsDelayCnt(gvo);
    }

    @Override
    public Integer itExpertEsCnt(GoodsManageVO gvo) {
        return dao.itExpertEsCnt(gvo);
    }

    @Override
    public Integer itExpertEsDelayCnt(GoodsManageVO gvo) {
        return dao.itExpertEsDelayCnt(gvo);
    }
    
    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */
    @Override
    public Integer psEsCnt(GoodsManageVO gvo) {
        return dao.psEsCnt(gvo);
    }

    @Override
    public Integer psEsDelayCnt(GoodsManageVO gvo) {
        return dao.psEsDelayCnt(gvo);
    }
    /* }} */
    
    @Override
    public Integer goodsCsCnt(GoodsManageVO gvo) {
        return dao.goodsCsCnt(gvo);
    }

    @Override
    public Integer goodsCsDelayCnt(GoodsManageVO gvo) {
        return dao.goodsCsDelayCnt(gvo);
    }

    @Override
    public Integer itExpertCsCnt(GoodsManageVO gvo) {
        return dao.itExpertCsCnt(gvo);
    }

    @Override
    public Integer itExpertCsDelayCnt(GoodsManageVO gvo) {
        return dao.itExpertCsDelayCnt(gvo);
    }

    @Override
    public Integer cmmntyEsthCnt(ExplorerVO vo) {
        return dao.cmmntyEsthCnt(vo);
    }
    
    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */ 
    @Override
    public Integer psCsCnt(GoodsManageVO gvo) {
        return dao.psCsCnt(gvo);
    }

    @Override
    public Integer psCsDelayCnt(GoodsManageVO gvo) {
        return dao.psCsDelayCnt(gvo);
    }
    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */

    @Override
    public Integer recentQnACnt(ExplorerVO vo) {
        return dao.recentQnACnt(vo);
    }

    @Override
    public List<GoodsManageVO> goodsRcCsState(GoodsManageVO gvo) {

        return dao.goodsRcCsState(gvo);
    }

    @Override
    public List<GoodsManageVO> itExpertRcCsState(GoodsManageVO gvo) {

        return dao.itExpertRcCsState(gvo);
    }

    @Override
    public List<ExplorerVO> typeOfGoodsList(ExplorerVO vo) {

        return dao.typeOfGoodsList(vo);
    }

    @Override
    public Integer bizMatchCnt(ExplorerVO vo) {

        return dao.bizMatchCnt(vo);
    }

    @Override
    public Integer svcLangCount(ExplorerVO vo) {

        return dao.svcLangCount(vo);
    }

    @Override
    public Integer currentStateTotal(ExplorerVO vo) {
        return dao.currentStateTotal(vo);
    }

    /**
     * todayWorkList (오늘의 할 일[2017.01.18 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> todayWorkList(ExplorerVO vo) {
        return dao.todayWorkList(vo);
    }

    /**
     * serviceProvsChangeList (오늘의 서비스변동(전일대비) [2017.01.20 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> serviceProvsChangeList(ExplorerVO vo) {
        return dao.serviceProvsChangeList(vo);
    }

    /**
     * userSttusByDayList (회원현황[2017.01.18 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> userSttusByDayList(ExplorerVO vo) {
        return dao.userSttusByDayList(vo);
    }

    /**
     * cntrTotAmountList (계약 일 동향 총합계[2017.01.18 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> cntrTotAmountList(ExplorerVO vo) {
        return dao.cntrTotAmountList(vo);
    }

    /**
     * buyActTrendByDayList (구매활동 일동향[2017.01.18 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> buyActTrendByDayList(ExplorerVO vo) {
        return dao.buyActTrendByDayList(vo);
    }

    /**
     * serviceDispTrendList (서비스전시 총동향[2017.01.20 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> serviceDispTrendList(ExplorerVO vo) {
        return dao.serviceDispTrendList(vo);
    }

    /**
     * cntrAmountList (계약 일 동향[2017.01.18 추가])
     * @param vo
     * @return
     */
    @Override
    public List<ExplorerVO> cntrAmountList(ExplorerVO vo) {
        return dao.cntrAmountList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#ceartPresentCondition(zes.openworks.intra.explorer.ExplorerVO)
     */
    @Override
    public ExplorerVO ceartPresentCondition(ExplorerVO vo) {
        return dao.ceartPresentCondition(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#goodsList(zes.openworks.intra.store.goods.GoodsManageVO)
     */
    @Override
    public List<ExplorerVO> goodsList(ExplorerVO vo) {
        return dao.goodsList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#ceartWorkCondition(zes.openworks.intra.explorer.ExplorerVO)
     */
    @Override
    public ExplorerVO ceartWorkCondition(ExplorerVO vo) {
        return dao.ceartWorkCondition(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#totalCntrAmount(zes.openworks.intra.explorer.ExplorerVO)
     */
    @Override
    public ExplorerVO totalCntrAmount(ExplorerVO vo) {

        return dao.totalCntrAmount(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#totalCntrTopListJson(zes.openworks.intra.explorer.ExplorerVO)
     */
    @Override
    public List totalCntrTopList(HashMap<String, String> map) {
        return dao.totalCntrTopList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#totalCntrCntTopList(java.util.HashMap)
     */
    @Override
    public List totalCntrCountTopList(HashMap<String, String> map) {
        return dao.totalCntrCountTopList(map);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#cntrctAmountViewList(java.util.HashMap)
     */
    @Override
    public List cntrctAmountViewList(HashMap<String, String> map) {
        return dao.cntrctAmountViewList(map);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#cntrctCountViewList(java.util.HashMap)
     */
    @Override
    public List cntrctCountViewList(HashMap<String, String> map) {
        return dao.cntrctCountViewList(map);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#cntrctRatio(zes.openworks.intra.explorer.ExplorerVO)
     */
    @Override
    public ExplorerVO cntrctRatio(ExplorerVO vo) {
        return dao.cntrctRatio(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.explorer.ExplorerService#cntrctCountRatio(zes.openworks.intra.explorer.ExplorerVO)
     */
    @Override
    public ExplorerVO cntrctCountRatio(ExplorerVO vo) {
        return dao.cntrctCountRatio(vo);
    }

}
