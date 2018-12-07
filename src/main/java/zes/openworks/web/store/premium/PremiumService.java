/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store.premium;

import java.util.List;
import java.util.Map;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.myGoods.MyGoodsVO;



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
 * 2014. 11. 6.    이슬버미       신규
 *</pre>
 * @see
 */
public interface PremiumService {

    /**
     * ctgryInit 설명
     * @param vo
     * @return
     */
    String ctgryInit(PremiumVO vo);

    /**
     * ctgryPath 설명
     * @param vo
     * @return
     */
    Map<String, String> ctgryPath(PremiumVO vo);

    /**
     * ctgry 설명
     * @param vo
     * @return
     */
    Map<String, Object> ctgry(PremiumVO vo);

    /**
     * ctgryList 설명
     * @param vo
     * @return
     */
    List<Map<String, Object>> ctgryList(PremiumVO vo);

    /**
     * bestList 설명
     * @param vo
     * @return
     */
    List<PremiumVO> bestList(PremiumVO vo);

    /**
     * rcmdList 설명
     * @param vo
     * @return
     */
    List<PremiumVO> rcmdList(PremiumVO vo);

    /**
     * bestSellerList 설명
     * @param vo
     * @return
     */
    List<PremiumVO> bestSellerList(PremiumVO vo);

    /**
     * goodsList 설명
     * @param vo
     * @return
     */
    Pager<PremiumVO> goodsList(PremiumVO vo);

    /**
     * goodsView 설명
     * @param vo
     * @return
     */
    PremiumVO goodsView(PremiumVO vo);

    /**
     * rdcntUpdate 설명
     * @param vo
     */
    int rdcntUpdate(PremiumVO vo);

    /**
     * rcntUpdate 설명
     * @param vo
     */
    int rcntUpdate(PremiumVO vo);

    /**
     * purch 설명
     * @param vo
     */
    int purchInsert(PremiumVO vo);

    /**
     * itstUpdate 설명
     * @param vo
     */
    int itstUpdate(PremiumVO vo);

    /**
     * itstCount 설명
     * @param vo
     */
    int itstCount(PremiumVO vo);

    /**
     * ctgryNull 설명
     * @param vo
     */
    String ctgryNull(PremiumVO vo);

    /**
     * goodsListOfSeller 설명
     * @param vo
     * @return
     */
    Pager<PremiumVO> goodsListOfSeller(PremiumVO vo);

    /**
     * goodsStore 설명
     * @param vo
     * @return
     */
    Map<String, Object> goodsStore(PremiumVO vo);

    /**
     * sellerInfo 설명
     * @param vo
     * @return
     */
    GoodsManageVO sellerInfo(PremiumVO vo);

    /**
     * getPurchsNo 설명
     * @param vo
     * @return
     */
    String getPurchsNo(PremiumVO vo);

    
    
    /**
     * 서비스별 카테고리 목록[등록 서비스의 카테고리 정보]
     * @param Map searchMap
     * @return List
     * @ 2015.12.23 생성
     */
    List goodsCateList(PremiumVO vo);
    
    int suplyCnt(MyGoodsVO vo);

    /**
     * suplyCnt 설명
     * @param vo
     * @return
     */
    int suplyCnt(PremiumVO vo);
}
