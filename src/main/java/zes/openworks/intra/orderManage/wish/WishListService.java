/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.wish;

import java.util.List;

import zes.base.pager.Pager;


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
public interface WishListService {
    
    /**
     * wishList (구매/신청관리 목록)
     * @param vo
     * @return
     */
    Pager<WishListVO> wishList(WishListVO vo);

    
    /**
     * wishList (구매/신청관리 목록)
     * @param vo
     * @return
     */
    Pager<WishListVO> wishDetailList(WishListVO vo);
   
    /**
     * wishListExcel (엑셀 다운로드)
     * @param vo
     * @return
     */
    List<WishListVO> wishListExcel(WishListVO vo);
  
}
