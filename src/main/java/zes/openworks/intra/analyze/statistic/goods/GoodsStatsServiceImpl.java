/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.goods;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service
public class GoodsStatsServiceImpl extends AbstractServiceImpl implements GoodsStatsService {

    @Resource
    private GoodsStatsDAO dao;

    @Override
    public List<GoodsManageVO> langList(GoodsManageVO vo) {
        return dao.langList(vo);
    }
    @Override
    public List<ResultVO> intrStatList(ResultVO vo) {
        return dao.intrStatList(vo);
    }
    @Override
    public List<ResultVO> purchStatList(ResultVO vo) {
        return dao.purchStatList(vo);
    }
    @Override
    public List<ResultVO> registStatList(ResultVO vo) {
        return dao.registStatList(vo);
    }
    @Override
    public List<ResultVO> goodsPpsStatList(ResultVO vo) {
        return dao.goodsPpsStatList(vo);
    }    

}
