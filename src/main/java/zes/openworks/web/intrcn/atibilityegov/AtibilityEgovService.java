/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.intrcn.atibilityegov;

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
 * 2014. 10. 31.    이슬버미       신규
 *</pre>
 * @see
 */
public interface AtibilityEgovService {

    /**
     * atibilityEgov (호환성 목록)
     * @param vo
     * @return
     */
    Pager<AtibilityEgovVO> atibilityEgovList(AtibilityEgovVO vo);
    
    /**
     * atibilityEgovView (호환성 상세)
     * @param vo
     * @return
     */
    AtibilityEgovVO atibilityEgovView(AtibilityEgovVO vo);
    
    /**
     * atibilityEgovInsertAction (호환성 신청)
     * @param vo
     * @return
     */
    int atibilityEgovInsertAction(AtibilityEgovVO vo);
    
    /**
     * cmptbClCdList (호환성 분류코드)
     * @return
     */
    List<CodeVO> cmptbClCdList(AtibilityEgovVO vo);
    
}
