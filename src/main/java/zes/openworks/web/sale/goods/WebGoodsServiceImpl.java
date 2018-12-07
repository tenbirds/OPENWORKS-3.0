/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.goods;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.intra.store.goods.GoodsSpecDescribeVO;
import zes.openworks.intra.store.goods.GoodsSpecVO;

@Service("WebGoodsService")
public class WebGoodsServiceImpl extends AbstractServiceImpl implements WebGoodsService {

    @Resource
    private WebGoodsDAO dao;

    @Resource
    private FileDAO fileDao;

    @Override
    public Pager<WebGoodsManageVO> goodsList(WebGoodsManageVO vo) {
        return dao.goodsList(vo);
    }

    @Override
    public Pager<WebGoodsManageVO> goodsExmntList(WebGoodsManageVO vo) {
        return dao.goodsExmntList(vo);
    }

    @Override
    public Pager<WebGoodsManageVO> goodsConfnList(WebGoodsManageVO vo) {
        return dao.goodsConfnList(vo);
    }

    @Override
    public Pager<WebGoodsManageVO> goodsDeleteList(WebGoodsManageVO vo) {
        return dao.goodsDeleteList(vo);
    }

    @Override
    public int dspyUpdate(WebGoodsManageVO vo, HttpServletRequest request) {
        return dao.dspyUpdate(vo);
    }
    @Override
    public int goodsStatAction(WebGoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsStatAction(vo);
    }
    
    @Override
    public List<WebGoodsManageVO> langList(WebGoodsManageVO vo) {
        return dao.langList(vo);
    }

    @Override
    public List<WebGoodsManageVO> sttusList(WebGoodsManageVO vo) {
        return dao.sttusList(vo);
    }

    @Override
    public List<WebGoodsManageVO> ctgryList(WebGoodsManageVO vo) {
        return dao.ctgryList(vo);
    }

    @Override
    public WebGoodsManageVO goodsView(WebGoodsManageVO vo) {
        return dao.goodsView(vo);
    }

    @Override
    public int goodsUpdate(WebGoodsManageVO vo, HttpServletRequest request) {
        
/*        System.out.println("setCtgryCodes: " + request.getParameterValues("setCtgryCodes"));
        vo.getDataMap().put("ctgryCds", request.getParameterValues("setCtgryCodes"));*/
        return dao.goodsUpdate(vo, request);
    }

    @Override
    public int goodsInsert(WebGoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsInsert(vo);
    }

    @Override
    public Integer orderCnt(WebGoodsManageVO vo) {
        return dao.orderCnt(vo);
    }
    
    @Override
    public WebGoodsManageVO storeLangNm(String langCode) {
        return dao.storeLangNm(langCode);
    }

    @Override
    public int goodsDelete(WebGoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsDelete(vo);
    }

    @Override
    public int registUpdate(WebGoodsManageVO vo, HttpServletRequest request) {
        return dao.registUpdate(vo);
    }

    @Override
    public int fileDelete(FileVO fileVO) {
        
        int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
        return affected;
    }
    
    @Override
    public int markingInfoDelete(WebGoodsManageVO vo, HttpServletRequest request) {
        int affected = dao.markingInfoDelete(vo);
        return affected;
    }
    
    @Override
    public int deleteTstGoodMarkIInt(WebGoodsManageVO vo, HttpServletRequest request) {
        int affected = dao.deleteTstGoodMarkIInt(vo);
        return affected;
    }
    
    
    
    @Override
    public int fileCount(Integer fileSeq) {
        return dao.fileCount(fileSeq);
    }

    @Override
    public List<WebGoodsManageVO> ctgrySelect(WebGoodsManageVO vo) {
        return dao.ctgrySelect(vo);
    }

    @Override
    public List<Map<String, Object>> goodsMarkCodeList(WebGoodsManageVO vo) {
        return dao.goodsMarkCodeList(vo);
    }
    @Override
    public List<Map<String, Object>> goodsMarkCodeListTmp(WebGoodsManageVO vo) {
        return dao.goodsMarkCodeListTmp(vo);
    }

    @Override
    public GoodsManageVO returnReason(GoodsManageVO vo) {
        return dao.returnReason(vo);
    }

    @Override
    public Map<String, Object> goodsStoreList(WebGoodsManageVO vo) {
        return dao.goodsStoreList(vo);
    }

    @Override
    public List<WebGoodsManageVO> storeLangList(WebGoodsManageVO vo) {
        return dao.storeLangList(vo);
    }

    @Override
    public String goodsCode(WebGoodsManageVO vo) {
        return dao.goodsCode(vo);
    }
    
    @Override
    public List<WebGoodsManageVO> eManagerAuthInfo(WebGoodsManageVO vo) {
        return dao.eManagerAuthInfo(vo);
    }

    @Override
    public List<WebGoodsManageVO> goodsMetaLang(WebGoodsManageVO vo) {
        return dao.goodsMetaLang(vo);
    }
    
    @Override
    public List<WebGoodsManageVO> goodsMetaPrice(WebGoodsManageVO vo) {
        return dao.goodsMetaPrice(vo);
    }

    
    
    /*  (서비스(서비스) 규격 엘셀데이터 조회 )
     * @see zes.openworks.web.sale.goods.WebGoodsService#selectGoodsSpecExcel(zes.openworks.intra.store.goods.GoodsSpecVO)
     */
    @Override
    public int goodsSpecNum(GoodsSpecVO vo) {
       
        return dao.goodsSpecNum(vo);
    }
    
    /*  (서비스(서비스) 규격 새 일런번호 )
     * @see zes.openworks.web.sale.goods.WebGoodsService#selectGoodsSpecDescribe(zes.openworks.intra.store.goods.GoodsSpecDescribeVO)
     */
    @Override
    public int goodsSpecDescribeNum(GoodsSpecDescribeVO vo) {
       
        return dao.goodsSpecDescribeNum(vo);
    }

    /* (서비스(서비스) 규격 엘셀데이터 저장 )
     * @see zes.openworks.web.sale.goods.WebGoodsService#inserGoodsSpecExcel(java.util.Map)
     */
    @Override
    public int inserGoodsSpecExcel(Map vo) {
    
        return dao.inserGoodsSpecExcel(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#inserGoodsSpecDescribe(zes.openworks.intra.store.goods.GoodsSpecDescribeVO)
     */
    @Override
    public int insertGoodsSpecDescribe(GoodsSpecDescribeVO vo) {
        
        return dao.insertGoodsSpecDescribe(vo);        
    }

    /* (엑셀파일 첨부)
     * @see zes.openworks.web.sale.goods.WebGoodsService#excelFileSaveAction(zes.openworks.intra.store.goods.GoodsSpecVO, int)
     */
    @Override
    public int excelFileSaveAction(GoodsSpecVO vo) {

        return dao.excelFileSaveAction(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#goodsSpecInfo(zes.openworks.intra.store.goods.GoodsSpecVO)
     */
    @Override
    public GoodsSpecVO goodsSpecInfo(GoodsSpecVO vo) {
        // TODO Auto-generated method stub
        return dao.GoodsSpecInfo(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#goodsSpecDescribeInfo(zes.openworks.intra.store.goods.GoodsSpecDescribeVO)
     */
    @Override
    public GoodsSpecDescribeVO goodsSpecDescribeInfo(GoodsSpecDescribeVO vo) 
    {
        return dao.GoodsSpecDescribeInfo(vo);
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#getGoodsKindCode(java.lang.String)
     */
    @Override
    public int getGoodsKindCode(String goodsCode) {

        return dao.getGoodsKindCode(goodsCode);
    }
    @Override
    public int getPassYn(Map<String, Object> parameterMap) {

        return dao.getPassYn(parameterMap);
    }
    @Override
    public int getPassYnUpdate(Map<String, Object> parameterMap) {

        return dao.getPassYnUpdate(parameterMap);
    }

    @Override
    public int goodsUpdateConfirm(WebGoodsManageVO vo, HttpServletRequest request) {
        return dao.goodsUpdateConfirm(vo);
    }
    

    @Override
    public List<Map<String, Object>> goodsChngHist(GoodsManageVO vo) {
        return dao.goodsChngHist(vo);
    }
    
    /**
     * 사유서 파일 등록
     */
    @Override
    public Integer changeAction(GoodsManageVO vo) {
        return dao.changeAction(vo);
    }
    
    /**
     * 서비스변경요청 등록
     */
    @Override
    public int insertSvcChangeRequstAction(GoodsManageVO vo) {
        return dao.insertSvcChangeRequstAction(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#goodsInfo(java.util.Map)
     */
    @Override
    public Map<String, Object> goodsInfo(Map<String, Object> parameterMap) {
        return dao.goodsInfo(parameterMap);
    }
    @Override
    public Map<String, Object> goodsInfoTmp(Map<String, Object> parameterMap) {
        return dao.goodsInfoTmp(parameterMap);
    }
    @Override
    public Map<String, Object> goodsInfo_2(Map<String, Object> parameterMap) {
        return dao.goodsInfo_2(parameterMap);
    }
    @Override
    public Map<String, Object> goodsInfoTmp_2(Map<String, Object> parameterMap) {
        return dao.goodsInfoTmp_2(parameterMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#specInfo(java.util.Map)
     */
    @Override
    public GoodsSpecDescribeVO specInfo(Map<String, Object> parameterMap) {
        return dao.specInfo(parameterMap);
    }
    @Override
    public GoodsSpecDescribeVO specInfoUpdate(Map<String, Object> parameterMap) {
        return dao.specInfoUpdate(parameterMap);
    }
    @Override
    public GoodsSpecDescribeVO specInfo_2(Map<String, Object> parameterMap) {
        return dao.specInfo_2(parameterMap);
    }
    @Override
    public GoodsSpecDescribeVO specInfoUpdate_2(Map<String, Object> parameterMap) {
        return dao.specInfoUpdate_2(parameterMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#margeGoodsInfoSpecInfo(zes.openworks.web.sale.goods.WebGoodsManageVO, zes.openworks.intra.store.goods.GoodsSpecDescribeVO)
     */
    @Override
    public int mergeGoodsInfoSpecInfo(String curStep, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo) {
        return dao.mergeGoodsInfoSpecInfo(curStep, goodsVo, specVo);        
    }
    @Override
    public int mergeGoodsInfoSpecInfoUpdate(String curStep, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo) {
        return dao.mergeGoodsInfoSpecInfoUpdate(curStep, goodsVo, specVo);        
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#updateGoodsSpecDescribe(zes.openworks.intra.store.goods.GoodsSpecDescribeVO)
     */
    @Override
    public int updateGoodsSpecDescribe(GoodsSpecDescribeVO specVo) {
        
        return dao.updateGoodsSpecDescribe(specVo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#goodsCateList(java.util.Map)
     */
    @Override
    public List<Map<String, Object>> goodsCateList(Map<String, Object> parameterMap) {
        
        return dao.goodsCateList(parameterMap);
    }
    @Override
    public List<Map<String, Object>> goodsCateListTmp(Map<String, Object> parameterMap) {
        
        return dao.goodsCateListTmp(parameterMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#goodsMarkList(java.util.Map)
     */
    @Override
    public List goodsMarkList(Map<String, Object> parameterMap) {
        // TODO Auto-generated method stub
        return dao.goodsMarkList(parameterMap);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#goodsMetaList(zes.openworks.web.sale.goods.WebGoodsManageVO)
     */
    @Override
    public List goodsMetaList(WebGoodsManageVO goodsVo) {
        // TODO Auto-generated method stub
        return dao.goodsMetaList(goodsVo);
    }
    @Override
    public List goodsMetaListTmp(WebGoodsManageVO goodsVo) {
        // TODO Auto-generated method stub
        return dao.goodsMetaListTmp(goodsVo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.sale.goods.WebGoodsService#tstCateMgmt(java.lang.String[])
     */

    @Override
    public Map<String, Object> tstCateMgmt(Map<String, Object>  cDetailSvc) {
        return dao.tstCateMgmt(cDetailSvc);
    }


}
