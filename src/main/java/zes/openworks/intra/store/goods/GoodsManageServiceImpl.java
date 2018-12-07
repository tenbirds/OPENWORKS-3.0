/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.goods;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.user.UserVO;
import zes.openworks.web.myGoods.MyGoodsVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 10. 21.   김병욱       신규
 * </pre>
 * @see
 */
@Service("GoodsManageService")
public class GoodsManageServiceImpl extends AbstractServiceImpl implements GoodsManageService {

    @Resource
    private GoodsManageDAO dao;

    @Resource
    private FileDAO fileDao;

    @Override
    public Pager<GoodsManageVO> goodsList(GoodsManageVO vo) {
        return dao.goodsList(vo);
    }

    @Override
    public Pager<GoodsManageVO> goodsExmntList(GoodsManageVO vo) {
        return dao.goodsExmntList(vo);
    }
    
    
    @Override
    public Pager<GoodsManageVO> goodsRequestList(GoodsManageVO vo) {
        return dao.goodsRequestList(vo);
    }

    @Override
    public Pager<GoodsManageVO> goodsConfnList(GoodsManageVO vo) {
        return dao.goodsConfnList(vo);
    }

    @Override
    public Pager<GoodsManageVO> goodsDeleteList(GoodsManageVO vo) {
        return dao.goodsDeleteList(vo);
    }

    @Override
    public int dspyUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return dao.dspyUpdate(vo);
    }
    @Override
    public int cfmItemContentUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return dao.cfmItemContentUpdate(vo);
    }

    @Override
    public int requestUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return dao.requestUpdate(vo);
    }
    
    @Override
    public int updateReuestProcessAt(GoodsManageVO vo, HttpServletRequest request) {
        return dao.updateReuestProcessAt(vo);
    }
    
    @Override
    public List<GoodsManageVO> langList(GoodsManageVO vo) {
        return dao.langList(vo);
    }

    @Override
    public List<GoodsManageVO> ctgryList(GoodsManageVO vo) {
        return dao.ctgryList(vo);
    }

    @Override
    public GoodsManageVO goodsView(GoodsManageVO vo) {
        return dao.goodsView(vo);
    }
    
    @Override
    public GoodsManageVO goodsMailView(GoodsManageVO vo) {
        return dao.goodsMailView(vo);
    }
    

    @Override
    public int goodsUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsUpdate(vo, request);
    }

    @Override
    public int goodsInsert(GoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsInsert(vo);
    }

    @Override
    public int g2bGoodsCount(GoodsPPSVO vo) {
        return dao.g2bGoodsCount(vo);
    }

    @Override
    public int g2bGoodsUpdate(GoodsPPSVO vo) {
        return dao.g2bGoodsUpdate(vo);
    }

    @Override
    public int g2bGoodsInsert(GoodsPPSVO vo) {
        return dao.g2bGoodsInsert(vo);
    }

    @Override
    public Integer orderCnt(GoodsManageVO vo) {
        return dao.orderCnt(vo);
    }
    @Override
    public Integer goodCodeTmpCount(GoodsManageVO vo) {
        return dao.goodCodeTmpCount(vo);
    }

    @Override
    public int goodsDelete(GoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsDelete(vo);
    }

    @Override
    public int registUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return dao.registUpdate(vo);
    }

    @Override
    public int fileDelete(FileVO fileVO) {
        
        int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
        return affected;
    }
    
    @Override
    public int fileDeleteManager(FileVO fileVO, GoodsManageVO vo) {
        
        int affected = dao.removeFile(fileVO.getFileSeq(), fileVO.getFileId(), vo);
        return affected;
    }

    @Override
    public int fileCount(Integer fileSeq) {
        return dao.fileCount(fileSeq);
    }

    @Override
    public List<GoodsManageVO> ctgrySelect(GoodsManageVO vo) {
        return dao.ctgrySelect(vo);
    }

    @Override
    public List<Map<String, Object>> goodsMarkCodeList(GoodsManageVO vo) {
        return dao.goodsMarkCodeList(vo);
    }

    @Override
    public Pager<UserVO> sellerListPop(GoodsManageVO vo) {
        return dao.sellerListPop(vo);
    }

    @Override
    public List<Map<String, Object>> goodsChngHist(GoodsManageVO vo) {
        return dao.goodsChngHist(vo);
    }
    
    @Override
    public List<Map<String, Object>> goodsChngRegHist(GoodsManageVO vo) {
        return dao.goodsChngRegHist(vo);
    }
    
    @Override
    public List<GoodsSpecVO> goodsSpecHist(GoodsManageVO vo) {
        return dao.goodsSpecHist(vo);
    }

    /**
     * 판매자 정보 조회
     */
    @Override
    public GoodsManageVO sellerInfo(GoodsManageVO vo) {
        return dao.sellerInfo(vo);
    }

    /**
     * 검토관리자 정보 조회
     */
    @Override
    public GoodsManageVO eManagerInfo(GoodsManageVO vo) {
        return dao.eManagerInfo(vo);
    }

    /**
     * 반려사유 등록액션
     */
    @Override
    public Integer reasonAction(GoodsManageVO vo) {
        return dao.reasonAction(vo);
    }

    /**
     * 사유서 파일 등록
     */
    @Override
    public Integer changeAction(GoodsManageVO vo) {
        return dao.changeAction(vo);
    }
    
    /**
     * 등록신청요청
     */
    @Override
    public Integer confirmAction(GoodsManageVO vo) {
        return dao.confirmAction(vo);
    }
    
    
    @Override
    public List<GoodsManageVO> goodsMetaLang(GoodsManageVO vo) {
        return dao.goodsMetaLang(vo);
    }

    /**
     * 반려사유 보기
     */
    @Override
    public GoodsManageVO reasonView(GoodsManageVO vo) {
        return dao.reasonView(vo);
    }

    /**
     * 반려사유 보기
     */
    @Override
    public GoodsManageVO changeView(GoodsManageVO vo) {
        return dao.reasonView(vo);
    }
    
    /**
     * 권한있는 관리자 정보조회
     * @return
     */
    @Override
    public List<GoodsManageVO> eManagerAuthInfo(GoodsManageVO vo) {
        return dao.eManagerAuthInfo(vo);
    }

    @Override
    public Integer techCtgryChk(GoodsManageVO vo) {
        return dao.techCtgryChk(vo);
    }

    @Override
    public Integer chngHistCodeInsert(GoodsManageVO vo) {
        return dao.chngHistCodeInsert(vo);
    }

    /**
     * 모니터링 서비스 목록
     */
    @Override
    public List<GoodsManageVO> goodsMonitorList(GoodsManageVO vo) {
        return dao.goodsMonitorList(vo);
    }

    /**
     * 모니터링 정보 등록액션
     */
    @Override
    public Integer goodsMonitorInsertAction(GoodsManageVO vo) {
        return dao.goodsMonitorInsertAction(vo);
    }

    /**
     * 서비스 모니터링 내역
     */
    @Override
    public Pager<GoodsManageVO> goodsMonitorHistory(GoodsManageVO vo) {
        return dao.goodsMonitorHistory(vo);
    }

    /**
     * 조달청서비스정보리스트
     * 20161208
     */
    @Override
    public Pager<GoodsPPSVO> goodsPpsList(GoodsPPSVO vo) {
        return dao.goodsPpsList(vo);
    }

    /**
     * 조달청서비스정보 서비스코드 UPDATE
     * 20161208
     */
    
    @Override
    public int goodsCdUpdate(GoodsPPSVO vo, HttpServletRequest request) {
        return dao.goodsCdUpdate(vo);
    }

    @Override
    public GoodsSpecVO goodsSpecInfo(GoodsSpecVO vo) {
        return dao.GoodsSpecInfo(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#overseasProductsInsertUpdate(java.util.Map)
     */
    @Override
    public void overseasProductsInsertUpdate(Map<String, String> paramMap) {
        dao.overseasProductsInsertUpdate(paramMap);
    }
   
    /**
     * 신청자 정보 조회
     */
    @Override
    public GoodsManageVO requestUserInfo(GoodsManageVO vo) {
        return dao.requestUserInfo(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#storeLangNm(java.lang.String)
     */
    @Override
    public GoodsManageVO storeLangNm(String langCode) {
        return dao.storeLangNm(langCode);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#goodsStoreList(zes.openworks.intra.store.goods.GoodsManageVO)
     */
    @Override
    public Map<String, Object> goodsStoreList(GoodsManageVO vo) {
        return dao.goodsStoreList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#goodsMetaPrice(zes.openworks.intra.store.goods.GoodsManageVO)
     */
    @Override
    public List<GoodsManageVO> goodsMetaPrice(GoodsManageVO vo) {
        return dao.goodsMetaPrice(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#goodsMetaList(zes.openworks.intra.store.goods.GoodsManageVO)
     */
    @Override
    public List<GoodsManageVO> goodsMetaList(GoodsManageVO vo) {
        return dao.goodsMetaList(vo);
    }


    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#updateTstGoodSpecDescribeI(zes.openworks.intra.store.goods.GoodsSpecVO)
     */
    @Override
    public Integer updateTstGoodSpecDescribeI(GoodsSpecVO specVo) {
        return dao.updateTstGoodSpecDescribeI(specVo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.intra.store.goods.GoodsManageService#goodsFormOneUpdate(zes.openworks.intra.store.goods.GoodsManageVO, javax.servlet.http.HttpServletRequest)
     */
    @Override
    public Integer goodsFormOneUpdate(GoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsFormOneUpdate(vo, request);
    }
    
    /**
     * 구매건수 가져오기 
     * @param Map searchMap
     * @return List
     * @ 2016.12.28 생성
     */
    @Override
    public int suplyCnt(GoodsManageVO vo) {
        return dao.suplyCnt(vo);
    }
}
