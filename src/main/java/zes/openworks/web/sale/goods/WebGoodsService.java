package zes.openworks.web.sale.goods;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.intra.store.goods.GoodsSpecDescribeVO;
import zes.openworks.intra.store.goods.GoodsSpecVO;

public interface WebGoodsService {

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    Pager<WebGoodsManageVO> goodsList(WebGoodsManageVO vo);

    /**
     * 서비스검토대기목록
     * goodsExmntList 설명
     *
     * @param vo
     * @return
     */
    Pager<WebGoodsManageVO> goodsExmntList(WebGoodsManageVO vo);

    /**
     * 서비스승인대기목록
     * goodsConfnList 설명
     *
     * @param vo
     * @return
     */
    Pager<WebGoodsManageVO> goodsConfnList(WebGoodsManageVO vo);

    /**
     * 서비스승인대기목록
     * goodsDeleteList 설명
     *
     * @param vo
     * @return
     */
    Pager<WebGoodsManageVO> goodsDeleteList(WebGoodsManageVO vo);

    /**
     * 전시상태 update
     * goodsList 설명
     *
     * @param vo
     * @return int
     */
    int dspyUpdate(WebGoodsManageVO vo, HttpServletRequest request);
    int goodsStatAction(WebGoodsManageVO vo, HttpServletRequest request);    
    
    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<WebGoodsManageVO> langList(WebGoodsManageVO vo);

    List<WebGoodsManageVO> sttusList(WebGoodsManageVO vo);

    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<WebGoodsManageVO> ctgryList(WebGoodsManageVO vo);

    WebGoodsManageVO goodsView(WebGoodsManageVO vo);

    int goodsUpdate(WebGoodsManageVO vo, HttpServletRequest request);
    

    /**
     * goodsInsert 설명
     *
     * @param vo
     * @param request
     * @return
     */
    int goodsInsert(WebGoodsManageVO vo, HttpServletRequest request);

    int goodsDelete(WebGoodsManageVO vo, HttpServletRequest request);

    int registUpdate(WebGoodsManageVO vo, HttpServletRequest request);

    int fileDelete(FileVO fileVO);
    int markingInfoDelete(WebGoodsManageVO vo, HttpServletRequest request);    

    int deleteTstGoodMarkIInt(WebGoodsManageVO vo, HttpServletRequest request);    
    

    /**
     * fileCount 설명
     *
     * @param fileSeq
     * @return
     */
    int fileCount(Integer fileSeq);

    /**
     * ctgrySelect 설명
     *
     * @param vo
     * @return
     */
    List<WebGoodsManageVO> ctgrySelect(WebGoodsManageVO vo);

    List<Map<String, Object>> goodsMarkCodeList(WebGoodsManageVO vo);
    List<Map<String, Object>> goodsMarkCodeListTmp(WebGoodsManageVO vo);

    

    /**
     * returnReason 설명
     * @param vo
     * @return
     */
    GoodsManageVO returnReason(GoodsManageVO vo);

    /**
     * goodsStoreList 설명
     * @param vo
     * @return
     */
    Map<String, Object> goodsStoreList(WebGoodsManageVO vo);

    List<WebGoodsManageVO> storeLangList(WebGoodsManageVO vo);

    /**
     * goodsCode 설명
     * @param vo
     * @return
     */
    String goodsCode(WebGoodsManageVO vo);

    /**
     * eManagerAuthInfo 설명
     * @param vo
     * @return
     */
    List<WebGoodsManageVO> eManagerAuthInfo(WebGoodsManageVO vo);

    /**
     * goodsMetaLang 설명
     * @return
     */
    List<WebGoodsManageVO> goodsMetaLang(WebGoodsManageVO vo);

    /**
     * goodsMetaLang 설명
     * @return
     */
    List<WebGoodsManageVO> goodsMetaPrice(WebGoodsManageVO vo);

    
    /**
     * orderCnt 설명
     * @param vo
     * @return
     */
    Integer orderCnt(WebGoodsManageVO vo);

    /**
     * storeLangNm 설명
     * @param langCode
     * @return
     */
    WebGoodsManageVO storeLangNm(String langCode);
    
    
    /**
     * 서비스(사품) 규격 엑셀로 등록 
     * @param Map vo
     * @return
     */
    int goodsSpecNum(GoodsSpecVO vo);
    
    /**
     * 서비스(사품) 규격 등록 
     * @param Map vo
     * @return
     */
    int goodsSpecDescribeNum(GoodsSpecDescribeVO vo);
    
    /**
     * 서비스(사품) 규격 엑셀로 등록 
     * @param Map vo
     * @return
     */
    int inserGoodsSpecExcel(Map<String, Object> vo);
    
    /**
     * inserGoodsSpecDescribe 설명
     * @param vo
     */
    int insertGoodsSpecDescribe(GoodsSpecDescribeVO vo);   
    
    
    /**
     * 서비스(사품) 규격 엑셀 첨부 확인  
     * @param GoodsSpecVO vo , int seperator
     * @return
     */
    int excelFileSaveAction(GoodsSpecVO vo) ;    
    
    GoodsSpecVO goodsSpecInfo(GoodsSpecVO vo);
    
    GoodsSpecDescribeVO goodsSpecDescribeInfo(GoodsSpecDescribeVO vo);
    
    
    int goodsUpdateConfirm(WebGoodsManageVO vo, HttpServletRequest request);
    
    /**
     * getGoodsKindCode 설명
     * @param goodsCode
     * @return
     */
    int getGoodsKindCode(String goodsCode);
    int getPassYn(Map<String, Object> parameterMap);
    int getPassYnUpdate(Map<String, Object> parameterMap);    

    /**
     * goodsChngHist 설명
     * @param vo
     * @return
     */
    List<Map<String, Object>> goodsChngHist(GoodsManageVO vo) ;
    
    Integer changeAction(GoodsManageVO vo);
    
    /**
     * 서비스변경요청등록
     * @param GoodsManageVO
     * @return int
     */
    int insertSvcChangeRequstAction(GoodsManageVO vo);

    /**
     * goodsInfo 설명
     * @param parameterMap
     */
    Map<String, Object>  goodsInfo(Map<String, Object> parameterMap);
    Map<String, Object>  goodsInfoTmp(Map<String, Object> parameterMap);
    
    Map<String, Object>  goodsInfo_2(Map<String, Object> parameterMap);    
    Map<String, Object>  goodsInfoTmp_2(Map<String, Object> parameterMap);    


    /**
     * goodsInfoSpecInfo 설명
     * @param parameterMap
     */
    GoodsSpecDescribeVO specInfo(Map<String, Object> parameterMap);
    GoodsSpecDescribeVO specInfoUpdate(Map<String, Object> parameterMap);    

    GoodsSpecDescribeVO specInfo_2(Map<String, Object> parameterMap);
    GoodsSpecDescribeVO specInfoUpdate_2(Map<String, Object> parameterMap);    

    /**
     * margeGoodsInfoSpecInfo 설명
     * @param curStep 
     * @param goodsVo
     * @param specVo
     */
    int mergeGoodsInfoSpecInfo(String curStep, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo);
    
    int mergeGoodsInfoSpecInfoUpdate(String curStep, WebGoodsManageVO goodsVo, GoodsSpecDescribeVO specVo);    


    /**
     * updateGoodsSpecDescribe 설명
     * @param specVo
     */
    int updateGoodsSpecDescribe(GoodsSpecDescribeVO specVo);

    /**
     * goodsCateList 설명
     * @param parameterMap
     * @return
     */
    List<Map<String, Object>> goodsCateList(Map<String, Object> parameterMap);
    List<Map<String, Object>> goodsCateListTmp(Map<String, Object> parameterMap);    


    /**
     * goodsMarkList 설명
     * @param parameterMap
     * @return
     */
    List<Map<String, Object>> goodsMarkList(Map<String, Object> parameterMap);

    /**
     * goodsMetaList 설명
     * @param goodsVo
     * @return
     */
    List<WebGoodsManageVO> goodsMetaList(WebGoodsManageVO goodsVo);
    List<WebGoodsManageVO> goodsMetaListTmp(WebGoodsManageVO goodsVo);

    /**
     * tstCateMgmt 설명
     * @param cDetailSvc
     * @return
     */
    Map<String, Object> tstCateMgmt(Map<String, Object> cDetailSvc);

}
