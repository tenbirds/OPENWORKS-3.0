/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.advertisement;

import zes.base.pager.Pager;

/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 7.    김영상       신규
 *</pre>
 * @see
 */
public interface AdvrtsService {
    /**
     * advrtsList 목록
     * 
     * @param vo
     * @return
     */
    Pager<AdvrtsVO> advrtsList(AdvrtsVO vo);

    /**
     * advrtsInsertAction 설명
     * 
     * @param vo
     * @return
     */
    int advrtsInsertAction(AdvrtsVO vo);
    
    
    /**
     * advrtsUpdateForm 설명
     * 
     * @param vo
     * @return
     */
    AdvrtsVO advrtsUpdateForm(AdvrtsVO vo);
    
    /**
     * advrtsUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    int advrtsUpdateAction(AdvrtsVO vo);
    
    /**
     * advrtsDeleteAction 설명
     * 
     * @param vo
     * @return
     */
    int advrtsDeleteAction(AdvrtsVO vo);
    
}