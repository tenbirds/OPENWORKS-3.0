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

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.myGoods.MyGoodsVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


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
@Service
public class PremiumServiceImpl  extends AbstractServiceImpl implements PremiumService {

    @Resource
    private  PremiumDAO dao;

    @Override
    public String ctgryNull(PremiumVO vo) {
        return dao.ctgryNull(vo);
    }

    @Override
    public Map<String, Object> ctgry(PremiumVO vo) {
        return dao.ctgry(vo);
    }

    @Override
    public String ctgryInit(PremiumVO vo) {
        return dao.ctgryInit(vo);
    }

    @Override
    public Map<String, String> ctgryPath(PremiumVO vo) {
        return dao.ctgryPath(vo);
    }

    @Override
    public List<Map<String, Object>> ctgryList(PremiumVO vo) {
        return dao.ctgryList(vo);
    }

    @Override
    public List<PremiumVO> bestList(PremiumVO vo) {
        return dao.bestList(vo);
    }

    @Override
    public List<PremiumVO> rcmdList(PremiumVO vo) {
        return dao.rcmdList(vo);
    }

    @Override
    public List<PremiumVO> bestSellerList(PremiumVO vo) {
        return dao.bestSellerList(vo);
    }

    @Override
    public Pager<PremiumVO> goodsList(PremiumVO vo) {
        return dao.goodsList(vo);
    }

    @Override
    public PremiumVO goodsView(PremiumVO vo) {
        return dao.goodsView(vo);
    }

    @Override
    public int rdcntUpdate(PremiumVO vo) {
        return dao.rdcntUpdate(vo);
    }

    @Override
    public int rcntUpdate(PremiumVO vo) {
        return dao.rcntUpdate(vo);
    }

    @Override
    public int purchInsert(PremiumVO vo) {
        return dao.purchInsert(vo);
    }

    @Override
    public int itstUpdate(PremiumVO vo) {
        return dao.itstUpdate(vo);
    }

    @Override
    public int itstCount(PremiumVO vo) {
        return dao.itstCount(vo);
    }

    @Override
    public Pager<PremiumVO> goodsListOfSeller(PremiumVO vo) {
        return dao.goodsListOfSeller(vo);
    }

    @Override
    public Map<String, Object> goodsStore(PremiumVO vo) {
        return dao.goodsStore(vo);
    }

    public GoodsManageVO sellerInfo(PremiumVO vo) {
        return dao.sellerInfo(vo);
    }

    @Override
    public String getPurchsNo(PremiumVO vo) {
        return dao.getPurchsNo(vo);
    }

    
    /**
     * 서비스별 카테고리 목록[등록 서비스의 카테고리 정보]
     * @param Map searchMap
     * @return List
     * @ 2015.12.23 생성
     */
    @Override
    public List goodsCateList(PremiumVO vo) {
        return dao.goodsCateList(vo);
    }
    
    /**
     * 구매건수 가져오기 
     * @param Map searchMap
     * @return List
     * @ 2016.12.28 생성
     */
    @Override
    public int suplyCnt(MyGoodsVO vo) {
        return dao.suplyCnt(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.store.premium.PremiumService#suplyCnt(zes.openworks.web.store.premium.PremiumVO)
     */
    @Override
    public int suplyCnt(PremiumVO vo) {
        return dao.suplyCnt(vo);
    }
    
}
