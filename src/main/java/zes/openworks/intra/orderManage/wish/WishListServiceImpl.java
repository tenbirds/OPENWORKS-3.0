/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.wish;

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
@Service("WishListService")
public class WishListServiceImpl extends AbstractServiceImpl implements WishListService {

    @Resource WishListDAO dao;

    /* (구매희망 목록)
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<WishListVO> wishList(WishListVO vo) {    
        return dao.wishList(vo);
    }
    
    /* (구매/신청관리 목록)
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsList(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    @Override
    public Pager<WishListVO> wishDetailList(WishListVO vo) {    
        return dao.wishDetailList(vo);
    }


    /* (엑셀다우로드)
     * @see zes.openworks.intra.orderManage.purchs.WishListService#purchsListExcel(zes.openworks.intra.orderManage.purchs.WishListVO)
     */
    public  List<WishListVO> wishListExcel(WishListVO vo){
        return dao.wishListExcel(vo);
    }
    
}
