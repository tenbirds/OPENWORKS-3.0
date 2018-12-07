/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myGoods;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.store.goods.GoodsPPSVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service
public class MyGoodsServiceImpl extends AbstractServiceImpl implements MyGoodsService {

    @Resource
    MyGoodsDAO dao;

    public Pager<MyGoodsVO> purchsIndex(MyGoodsVO vo) {
        return dao.shoppingIndex(vo, 1);
    }
    
    public Pager<MyGoodsVO> cnsIndex(MyGoodsVO vo) {
        return dao.shoppingIndex(vo, 3);
    }
    
    public Pager<MyGoodsVO> intrstIndex(MyGoodsVO vo) {
        return dao.intrstIndex(vo);
    }
    
    public int intrstCnt(MyGoodsVO vo) {
        return dao.intrstCnt(vo);
    }
    
    public int intrstDelete(MyGoodsVO vo) {
        return dao.intrstDelete(vo);
    }
    
    public Pager<MyGoodsVO> recentIndex(MyGoodsVO vo) {
        return dao.recentIndex(vo);
    }

    /* 나라장터 서비스 리스트
     * @see zes.openworks.web.myGoods.MyGoodsService#selectGoodsPPS(zes.openworks.web.myGoods.MyGoodsVO)
     */
    @Override
    public List<GoodsPPSVO> selectGoodsPPS(MyGoodsVO vo) {
        // TODO Auto-generated method stub
        return dao.selectGoodsPPS(vo);
    }

    
}
