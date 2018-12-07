/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.suppost.evl;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.code.CodeVO;


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
 * 2014. 11. 14.    이슬버미       신규
 *</pre>
 * @see
 */
public interface WebGoodsEvlService {

    /**
     * qnaList (서비스평 목록)
     * @param vo
     * @return
     */
    Pager<WebGoodsEvlVO> evlList(WebGoodsEvlVO vo);

    /**
     * langList (언어 목록)
     * @param vo
     * @return
     */
    List<CodeVO> langList();
    
    /**
     * goodsTyList (구분 목록)
     * @param vo
     * @return
     */
    List<CodeVO> goodsTyList(WebGoodsEvlVO vo);
    
}
