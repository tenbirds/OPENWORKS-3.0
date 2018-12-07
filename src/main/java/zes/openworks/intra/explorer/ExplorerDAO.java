/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.explorer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
@SuppressWarnings("unchecked")
@Repository
public class ExplorerDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;
    
    /**
     * typeOfUserList 설명
     * @param vo
     * @return
     */
    public List<ExplorerVO> typeOfUserList(ExplorerVO vo) {

        return list("_explorer.typeOfUserList", vo);
    }

    /**
     * typeOfUserCount 설명
     * @param vo
     * @return
     */
    public Integer typeOfUserCount(ExplorerVO vo) {

        return (Integer)selectByPk("_explorer.typeOfUserCount", vo);
    }
    
    /**
     * goodsEsState 설명(Sass 서비스검토대기)
     * @param vo
     * @return
     */
    public List<GoodsManageVO> goodsEsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1002");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if(!Validate.isNull(goodsMarkImage)){
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * goodsEsCnt 설명 Sass
     * @param gvo
     * @return
     */
    public Integer goodsEsCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1002");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        return (Integer)selectByPk("_explorer.goodsTotCnt", vo.getDataMap());
    }

    /**
     * goodsEsDelayCnt 설명 Sass
     * @param gvo
     * @return
     */
    public Integer goodsEsDelayCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1002");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        return (Integer)selectByPk("_explorer.goodsDelayCnt", vo.getDataMap());
    }
    
    /**
     * itExpertEsState 설명(Iass)
     * @param vo
     * @return
     */
    public List<GoodsManageVO> itExpertEsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        vo.getDataMap().put("q_goodsRegistSttus","");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if(!Validate.isNull(goodsMarkImage)){
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * itExpertEsCnt 설명 Iass
     * @param gvo
     * @return
     */
    public Integer itExpertEsCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        return (Integer)selectByPk("_explorer.goodsTotCnt", vo.getDataMap());
    }

    /**
     * itExpertEsDelayCnt 설명 Iass
     * @param gvo
     * @return
     */
    public Integer itExpertEsDelayCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        return (Integer)selectByPk("_explorer.goodsDelayCnt", vo.getDataMap());
    }
    
    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */
    
    /**
     * psEsState 설명(Pass 서비스검토대기)
     * @param vo
     * @return
     */
    public List<GoodsManageVO> psEsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1001");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        vo.getDataMap().put("q_goodsRegistSttus","");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if(!Validate.isNull(goodsMarkImage)){
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * psEsCnt 설명 Pass
     * @param gvo
     * @return
     */
    public Integer psEsCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1001");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        return (Integer)selectByPk("_explorer.goodsTotCnt", vo.getDataMap());
    }

    /**
     * psDelayCnt 설명 Pass
     * @param gvo
     * @return
     */
    public Integer psEsDelayCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1001");
        vo.getDataMap().put("q_registSttus", "1002,1005");
        return (Integer)selectByPk("_explorer.goodsDelayCnt", vo.getDataMap());
    }
    
    /* }} */
    
    /**
     * goodsCsState 설명(Sass 서비스승인대기)
     * @param vo
     * @return
     */
    public List<GoodsManageVO> goodsCsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1002");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        vo.getDataMap().put("q_registSttus", "");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }
    
    /**
     * goodsCsCnt 설명 Sass
     * @param gvo
     * @return
     */
    public Integer goodsCsCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1002");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        return (Integer)selectByPk("_explorer.goodsTotCnt", vo.getDataMap());
    }

    /**
     * goodsCsDelayCnt 설명 Sass
     * @param gvo
     * @return
     */
    public Integer goodsCsDelayCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1002");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        return (Integer)selectByPk("_explorer.goodsDelayCnt", vo.getDataMap());
    }
    
    /**
     * itExpertCsState 설명(IT전문가서비스승인대기)
     * @param vo
     * @return
     */
    public List<GoodsManageVO> itExpertCsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        vo.getDataMap().put("q_registSttus", "");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }
    
    /**
     * itExpertCsCnt 설명
     * @param gvo
     * @return
     */
    public Integer itExpertCsCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        return (Integer) selectByPk("_explorer.goodsTotCnt", vo.getDataMap());
    }

    /**
     * itExpertCsDelayCnt 설명
     * @param gvo
     * @return
     */
    public Integer itExpertCsDelayCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        return (Integer) selectByPk("_explorer.goodsDelayCnt", vo.getDataMap());
    }

    /* {{ 2016.05.11 BH.YANG 관리자 사이트 대시보드 서비스유형에 맞게 수정. Pass추가 */

    /**
     * psCsState 설명(Pass 서비스승인대기)
     * @param vo
     * @return
     */
    public List<GoodsManageVO> psCsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1001");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        vo.getDataMap().put("q_registSttus", "");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }
    
    /**
     * psCsCnt 설명 Pass
     * @param gvo
     * @return
     */
    public Integer psCsCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1001");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        return (Integer)selectByPk("_explorer.goodsTotCnt", vo.getDataMap());
    }

    /**
     * psCsDelayCnt 설명 Pass
     * @param gvo
     * @return
     */
    public Integer psCsDelayCnt(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1001");
        vo.getDataMap().put("q_goodsRegistSttus", 1004);
        return (Integer)selectByPk("_explorer.goodsDelayCnt", vo.getDataMap());
    }
    
    /* }} */
    
    /**
     * cmmntyEsthState 설명
     * @param vo
     * @return
     */
    public List<ExplorerVO> cmmntyEsthState(ExplorerVO vo) {
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("cmmntySttusCd", 1001);     //개설신청
        return list("_explorer.openCmManageList", paraMap);
    }

    /**
     * cmmntyEsthCnt 설명
     * @param vo
     * @return
     */
    public Integer cmmntyEsthCnt(ExplorerVO vo) {
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("cmmntySttusCd", 1001);     //개설신청
        return (Integer) selectByPk("_explorer.cmmntyEsthCnt", paraMap);
    }
    
    /**
     * recentQnAState 설명
     * @param vo
     * @return
     */
    public List<ExplorerVO> recentQnAState(ExplorerVO vo) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("bbsCd", 1003);                               //게시판코드
        return list("_explorer.boardRecentList", parameterMap);
    }

    /**
     * recentQnACnt 설명
     * @param vo
     * @return
     */
    public Integer recentQnACnt(ExplorerVO vo) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("bbsCd", 1003);                               //게시판코드
        return (Integer) selectByPk("_explorer.recentQnACnt", parameterMap);
    }

    /**
     * goodsRcCsState 설명
     * @param gvo
     * @return
     */
    public List<GoodsManageVO> goodsRcCsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * itExpertRcCsState 설명
     * @param gvo
     * @return
     */
    public List<GoodsManageVO> itExpertRcCsState(GoodsManageVO vo) {
        vo.getDataMap().put("q_goodsTyCd", "1003");
        List<GoodsManageVO> dataList = list("_explorer.goodsList", vo.getDataMap());

        for(GoodsManageVO data : dataList) {
            List<List<FileVO>> goodsMarkImage = new ArrayList<List<FileVO>>();
            for(int i = 0 ; i < data.getGoodsMarkList().size() ; i++) {
                goodsMarkImage.add(fileDao.getFiles(Integer.parseInt(String.valueOf(data.getGoodsMarkList().get(i).get("MARKIMAGEFILESEQ")))));
            }
            if ( ! Validate.isNull(goodsMarkImage)) {
                data.setMarkFile(goodsMarkImage);
            }
        }
        return dataList;
    }

    /**
     * typeOfGoodsList 설명
     * @param vo
     * @return
     */
    public List<ExplorerVO> typeOfGoodsList(ExplorerVO vo) {

        return list("_explorer.typeOfGoodsList", vo);
    }

    /**
     * bizMatchCnt 설명
     * @param vo
     * @return
     */
    public Integer bizMatchCnt(ExplorerVO vo) {

        return (Integer)selectByPk("_explorer.boardBizMatch", vo);
    }

    /**
     * svcLangCount 설명
     * @param vo
     * @return
     */
    public Integer svcLangCount(ExplorerVO vo) {

        return (Integer)selectByPk("_explorer.svcLangCount", vo);
    }
    /**
     * currentStateTotal
     * @param vo
     * @return
     */
    public Integer currentStateTotal(ExplorerVO vo) {
        
        return (Integer)selectByPk("_explorer.currentStateTotal", vo);
    }

    /**
     * todayWorkList (오늘의 할 일[2017.01.18 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> todayWorkList(ExplorerVO vo) {
        return list("_explorer.todayWorkList", vo);
    }

    /**
     * serviceProvsChangeList (오늘의 서비스변동(전일대비) [2017.01.20 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> serviceProvsChangeList(ExplorerVO vo) {
        return list("_explorer.serviceProvsChangeList", vo);
    }

    /**
     * userSttusByDayList (회원현황[2017.01.18 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> userSttusByDayList(ExplorerVO vo) {
        return list("_explorer.userSttusByDayList", vo);
    }

    /**
     * cntrTotAmountList (계약 일 동향 총 합계[2017.01.18 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> cntrTotAmountList(ExplorerVO vo) {
        return list("_explorer.cntrTotAmountList", vo);
    }

    /**
     * buyActTrendByDayList (구매활동 일동향[2017.01.18 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> buyActTrendByDayList(ExplorerVO vo) {
        return list("_explorer.buyActTrendByDayList", vo);
    }


    /**
     * serviceDispTrendList (서비스전시 총동향[2017.01.20 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> serviceDispTrendList(ExplorerVO vo) {
        return list("_explorer.serviceDispTrendList", vo);
    }

    /**
     * cntrAmountList (계약 일 동향[2017.01.18 추가])
     * @param vo
     * @return
     */
    public List<ExplorerVO> cntrAmountList(ExplorerVO vo) {
        return list("_explorer.cntrAmountList", vo);
    }

    /**
     * ceartPresentCondition 설명
     * @param vo
     * @return
     */
    public ExplorerVO ceartPresentCondition(ExplorerVO vo) {
        return (ExplorerVO) selectByPk("_explorer.ceartPresentCondition", vo);
    }

    /**
     * goodsList 설명
     * @param gvo
     * @return
     */
    public List<ExplorerVO> goodsList(ExplorerVO gvo) {
        return list("_explorer.goodsMonitorList", gvo);
    }

    /**
     * ceartWorkCondition 설명
     * @param vo
     * @return
     */
    public ExplorerVO ceartWorkCondition(ExplorerVO vo) {
        return (ExplorerVO) selectByPk("_explorer.workMonitorList", vo);
    }

    /**
     * totalCntrAmountJson 설명
     * @param vo
     * @return
     */
    public ExplorerVO totalCntrAmount(ExplorerVO vo) {
        return (ExplorerVO) selectByPk("_explorer.totalCntrAmount", vo);
    }

    /**
     * totalCntrTopList 설명
     * @param vo
     * @return
     */
    public List totalCntrTopList(HashMap<String, String> map) {
        return list ("_explorer.totalCntrTopList", map);
    }

    /**
     * totalCntrCntTopList 설명
     * @param map
     * @return
     */
    public List totalCntrCountTopList(HashMap<String, String> map) {
        return list ("_explorer.totalCntrCountTopList", map);
    }
    
    /**
     * cntrctAmountViewList 설명
     * @param map
     * @return
     */
    public List cntrctAmountViewList(HashMap<String, String> map) {
        return list ("_explorer.cntrctAmountView", map);
    }

    /**
     * cntrctCountViewList 설명
     * @param map
     * @return
     */
    public List cntrctCountViewList(HashMap<String, String> map) {
        return list ("_explorer.cntrctCountView", map);
    }
    
    /**
     * cntrctRatio 설명
     * @param vo
     * @return
     */
    public ExplorerVO cntrctRatio(ExplorerVO vo) {
        return (ExplorerVO) selectByPk("_explorer.cntrctRatio", vo);
    }
    
    /**
     * cntrctCountRatio 설명
     * @param vo
     * @return
     */
    public ExplorerVO cntrctCountRatio(ExplorerVO vo) {
        return (ExplorerVO) selectByPk("_explorer.cntrctCountRatio", vo);
    }


}
