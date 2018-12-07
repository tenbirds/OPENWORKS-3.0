/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.consult;

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
public interface ConsultOrderService {

    /**
     * consultList (컨설팅신청관리 목록)
     * @param vo
     * @return
     */
    Pager<ConsultOrderVO> consultList(ConsultOrderVO vo);

    /**
     * langList (서비스언어 목록)
     * @param vo
     * @return
     */
    List<ConsultOrderVO> langList(ConsultOrderVO vo);
    
    /**
     * ctgryList (카테고리 목록)
     * @param vo
     * @return
     */
    List<ConsultOrderVO> ctgryList(ConsultOrderVO vo);
 
    
    /**
     * consultListExcel 엑셀다운로드
     * @param vo
     * @return
     */
    List<ConsultOrderVO> consultListExcel(ConsultOrderVO vo);
    
}
