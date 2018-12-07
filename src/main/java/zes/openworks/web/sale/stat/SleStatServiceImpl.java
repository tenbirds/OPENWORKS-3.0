/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.stat;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service
public class SleStatServiceImpl extends AbstractServiceImpl implements SleStatService {

    @Resource
    SleStatDAO dao;

    @Override
    public List<WebGoodsManageVO> ctgryList(WebGoodsManageVO vo) {
        return dao.ctgryList(vo);
    }

    @Override
    public List<WebGoodsManageVO> langList(WebGoodsManageVO vo) {
        return dao.langList(vo);
    }

    @Override
    public Pager<WebGoodsManageVO> goodsList(WebGoodsManageVO vo) {
        return dao.goodsList(vo);
    }
}
