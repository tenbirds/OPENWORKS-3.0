/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.purchs;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
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
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */
@Service("purchsOrderService")
public class PurchsOrderServiceImpl extends AbstractServiceImpl implements PurchsOrderService {

    @Resource PurchsOrderDAO dao;

    /* (구매/신청관리 목록)
     * @see zes.openworks.intra.orderManage.purchs.PurchsOrderService#purchsList(zes.openworks.intra.orderManage.purchs.PurchsOrderVO)
     */
    @Override
    public Pager<PurchsOrderVO> purchsList(PurchsOrderVO vo) {    
        return dao.purchsList(vo);
    }
    
    
    /* (서비스언어 목록)
     * @see zes.openworks.intra.orderManage.purchs.PurchsOrderService#langList(zes.openworks.intra.orderManage.purchs.PurchsOrderVO)
     */
    @Override
    public  List<PurchsOrderVO> langList(PurchsOrderVO vo){
        return dao.langList(vo);
    }

    /* (카테고리 항목)
     * @see zes.openworks.intra.orderManage.purchs.PurchsOrderService#ctgryList(zes.openworks.intra.orderManage.purchs.PurchsOrderVO)
     */
    @Override
    public  List<PurchsOrderVO> ctgryList(PurchsOrderVO vo){
        return dao.ctgryList(vo);
    }
 
    /* (엑셀다우로드)
     * @see zes.openworks.intra.orderManage.purchs.PurchsOrderService#purchsListExcel(zes.openworks.intra.orderManage.purchs.PurchsOrderVO)
     */
    public  List<PurchsOrderVO> purchsListExcel(PurchsOrderVO vo){
        return dao.purchsListExcel(vo);
    }
    
}
