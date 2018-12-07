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

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.user.UserVO;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.   김병욱     신규
 *</pre>
 * @see
 */
public interface GoodsManageService {

    /**
     * 서비스전체목록
     * goodsList 설명
     *
     * @param vo
     * @return
     */
    Pager<GoodsManageVO> goodsList(GoodsManageVO vo);

    /**
     * 서비스검토대기목록
     * goodsExmntList 설명
     *
     * @param vo
     * @return
     */
    Pager<GoodsManageVO> goodsExmntList(GoodsManageVO vo);

    
    /**
     * 서비스변경 신청
     * goodsChangeList 설명
     *
     * @param vo
     * @return
     */
    Pager<GoodsManageVO> goodsRequestList (GoodsManageVO vo);
    
    
    /**
     * 서비스승인대기목록
     * goodsConfnList 설명
     *
     * @param vo
     * @return
     */
    Pager<GoodsManageVO> goodsConfnList(GoodsManageVO vo);

    /**
     * 서비스승인대기목록
     * goodsDeleteList 설명
     *
     * @param vo
     * @return
     */
    Pager<GoodsManageVO> goodsDeleteList(GoodsManageVO vo);

    /**
     * 전시상태 update
     * goodsList 설명
     *
     * @param vo
     * @return int
     */
    int dspyUpdate(GoodsManageVO vo, HttpServletRequest request);
    int cfmItemContentUpdate(GoodsManageVO vo, HttpServletRequest request);    


    /**
     * 서비스 면경 요청 update
     * goodsList 설명
     *
     * @param vo
     * @return int
     */
    int requestUpdate(GoodsManageVO vo, HttpServletRequest request);
    
    
    /**
     * 서비스 면경 요청 update(검토 승인)
     * goodsList 설명
     *
     * @param vo
     * @return int
     */
    int updateReuestProcessAt(GoodsManageVO vo, HttpServletRequest request);
    
    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<GoodsManageVO> langList(GoodsManageVO vo);

    /**
     * langList 설명
     *
     * @param vo
     * @return
     */
    List<GoodsManageVO> ctgryList(GoodsManageVO vo);

    GoodsManageVO goodsView(GoodsManageVO vo);
    
    GoodsManageVO goodsMailView(GoodsManageVO vo);

    int goodsUpdate(GoodsManageVO vo, HttpServletRequest request);

    /**
     * goodsInsert 설명
     * @param vo
     * @param request
     * @return
     */
    int goodsInsert(GoodsManageVO vo, HttpServletRequest request);

    int g2bGoodsCount(GoodsPPSVO vo);

    int g2bGoodsUpdate(GoodsPPSVO vo);

    int g2bGoodsInsert(GoodsPPSVO vo);

    int goodsDelete(GoodsManageVO vo, HttpServletRequest request);

    int registUpdate(GoodsManageVO vo, HttpServletRequest request);

    int fileDelete(FileVO fileVO);
    
    int fileDeleteManager(FileVO fileVO, GoodsManageVO vo);

    /**
     * fileCount 설명
     * @param fileSeq
     * @return
     */
    int fileCount(Integer fileSeq);

    /**
     * ctgrySelect 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> ctgrySelect(GoodsManageVO vo);

    List<Map<String, Object>> goodsMarkCodeList(GoodsManageVO vo);

    Pager<UserVO> sellerListPop(GoodsManageVO vo);

    /**
     * sellerInfo 설명
     * @param vo
     * @return
     */
    GoodsManageVO sellerInfo(GoodsManageVO vo);

    /**
     * eManagerInfo 설명
     * @param vo
     * @return
     */
    GoodsManageVO eManagerInfo(GoodsManageVO vo);

    /**
     * reasonAction 설명
     * @param vo
     * @return
     */
    Integer reasonAction(GoodsManageVO vo);
    

    /**
     * changeAction 설명
     * @param vo
     * @return
     */
    Integer changeAction(GoodsManageVO vo);

    
    /**
     * confirmAction 설명
     * @param vo
     * @return
     */
    Integer confirmAction(GoodsManageVO vo);
    
    
    /**
     * goodsMetaLang 설명
     * @return
     */
    List<GoodsManageVO> goodsMetaLang(GoodsManageVO vo);

    /**
     * reasonView 설명
     * @param vo
     * @return
     */
    GoodsManageVO reasonView(GoodsManageVO vo);
    /**
     * changeView 설명
     * @param vo
     * @return
     */
    GoodsManageVO changeView(GoodsManageVO vo);
    /**
     * eManagerAuthInfo 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> eManagerAuthInfo(GoodsManageVO vo);

    /**
     * orderCnt 설명
     * @param vo
     * @return
     */
    Integer orderCnt(GoodsManageVO vo);
    
    /**
     * 
     * goodCodeTmpCount 설명
     * @param vo
     * @return
     */
    Integer goodCodeTmpCount(GoodsManageVO vo);    

    /**
     * goodsChngHist 설명
     * @param vo
     * @return
     */
    List<Map<String, Object>> goodsChngHist(GoodsManageVO vo);

    List<Map<String, Object>> goodsChngRegHist(GoodsManageVO vo); //변경신청이력 
    
    List<GoodsSpecVO> goodsSpecHist(GoodsManageVO vo); //규격서 변경 이력 
    
    /**
     * techCtgryChk 설명
     * @param vo
     * @return
     */
    Integer techCtgryChk(GoodsManageVO vo);

    /**
     * chngHistCodeInsert 설명
     * @param vo
     * @return
     */
    Integer chngHistCodeInsert(GoodsManageVO vo);

    /**
     * 서비스모니터링목록
     * goodsMonitorList 설명
     *
     * @param vo
     * @return List
     */
    List<GoodsManageVO> goodsMonitorList(GoodsManageVO vo);

    /**
     * 모니터링 정보 등록
     * @param vo
     * @return
     */
    Integer goodsMonitorInsertAction(GoodsManageVO vo);

    /**
     * 서비스 모니터링 내역
     * goodsMonitorHistory 설명
     *
     * @param vo
     * @return
     */
    Pager<GoodsManageVO> goodsMonitorHistory(GoodsManageVO vo);


    /**
     * 조달청서비스정보리스트
     * 20161208
     * @param vo
     * @return
     */
    Pager<GoodsPPSVO> goodsPpsList(GoodsPPSVO vo);
    
    /**
     * 조달청서비스정보 서비스코드 UPDATE
     * 20161208
     * @param vo
     * @return int
     */
    int goodsCdUpdate(GoodsPPSVO vo, HttpServletRequest request);  
    
    GoodsSpecVO goodsSpecInfo(GoodsSpecVO vo);
    
    /**
     * 외동양 서비스 가져오기 INSERT or UPDATE
     * 20161208
     * @param map
     * @return void
     */
    void overseasProductsInsertUpdate(Map<String, String> paramMap);
    

    /**
     * requestUserInfo 설명
     * @param vo
     * @return
     */
    GoodsManageVO requestUserInfo(GoodsManageVO vo);

    /**
     * storeLangNm 설명
     * @param langCode
     * @return
     */
    GoodsManageVO storeLangNm(String langCode);

    /**
     * goodsStoreList 설명
     * @param vo
     * @return
     */
    Map<String, Object> goodsStoreList(GoodsManageVO vo);

    /**
     * goodsMetaPrice 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> goodsMetaPrice(GoodsManageVO vo);

    /**
     * goodsMetaList 설명
     * @param vo
     * @return
     */
    List<GoodsManageVO> goodsMetaList(GoodsManageVO vo);

    /**
     * updateTstGoodSpecDescribeI 설명
     * @param specVo
     */
    Integer updateTstGoodSpecDescribeI(GoodsSpecVO specVo);

    /**
     * goodsFormOneUpdate 설명
     * @param vo
     * @param request
     * @return
     */
    Integer goodsFormOneUpdate(GoodsManageVO vo, HttpServletRequest request);

    /**
     * suplyCnt 설명
     * @param vo
     * @return
     */
    int suplyCnt(GoodsManageVO vo);
    
}
