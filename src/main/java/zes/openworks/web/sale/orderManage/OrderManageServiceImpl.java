/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.orderManage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
 *  2014. 11. 14.    이슬버미       신규
 * </pre>
 * @see
 */
@Service
public class OrderManageServiceImpl extends AbstractServiceImpl implements OrderManageService {

    @Resource
    OrderManageDAO dao;

    /*
     * (구매/신청 목록)
     * @see
     * zes.openworks.web.sale.orderManage.OrderManageService#orderList(zes.openworks
     * .web.sale.orderManage.OrderManageVO)
     */
    @Override
    public Pager<OrderManageVO> orderList(OrderManageVO vo) {
        return dao.orderList(vo);
    }

    /*
     * (컨설팅 목록)
     * @see
     * zes.openworks.web.sale.orderManage.OrderManageService#cnslList(zes.openworks
     * .web.sale.orderManage.OrderManageVO)
     */
    @Override
    public Pager<OrderManageVO> cnslList(OrderManageVO vo) {
        return dao.cnslList(vo);
    }

    /*
     * (서비스 언어 목록)
     * @see
     * zes.openworks.web.sale.orderManage.OrderManageService#langList(zes.openworks
     * .web.sale.orderManage.OrderManageVO)
     */
    @Override
    public List<OrderManageVO> langList(OrderManageVO vo) {
        return dao.langList(vo);
    }

    /*
     * (카테고리 항목)
     * @see
     * zes.openworks.web.sale.orderManage.OrderManageService#ctgryList(zes.openworks
     * .web.sale.orderManage.OrderManageVO)
     */
    @Override
    public List<OrderManageVO> ctgryList(OrderManageVO vo) {
        return dao.ctgryList(vo);
    }

}