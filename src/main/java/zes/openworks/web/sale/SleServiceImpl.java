/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service
public class SleServiceImpl extends AbstractServiceImpl implements SleService {

    @Resource
    SleDAO dao;

    public List<SleVO> goodsOrder(SleVO vo) {
        return dao.goodsOrder(vo);
    }    
    
    public Integer goodsOrderCount(SleVO vo) {
        return dao.goodsOrderCount(vo);
    }
    
    public List<SleVO> goodsWait(SleVO vo) {
        return dao.goodsWait(vo);
    }
    
    public Integer goodsWaitCount(SleVO vo) {
        return dao.goodsWaitCount(vo);
    }
    
    public List<SleVO> goodsInqr(SleVO vo) {
        return dao.goodsInqr(vo);
    }
    
    public Integer goodsInqrCount(SleVO vo) {
        return dao.goodsInqrCount(vo);
    }
    
    public List<SleVO> goodsBiz(SleVO vo) {
        return dao.goodsBiz(vo);
    }

    public Integer goodsBizCount(SleVO vo) {
        return dao.goodsBizCount(vo);
    }

    public List<SleVO> goodsNoti(SleVO vo) {
        return dao.goodsNoti(vo);
    }

    public List<SleVO> goodsSubBoard(SleVO vo) {
        return dao.goodsSubBoard(vo);
    }

    public List<SleVO> buyingRequest(SleVO vo) {
        return dao.buyingRequest(vo);
    }

}
