/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.event;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
 * 2014. 10. 16.    이슬버미       신규
 *</pre>
 * @see
 */
public interface EventService {

    /**
     * 베너목록
     * eventList 설명
     * 
     * @param vo
     * @return
     */
    Pager<EventVO> eventList(EventVO vo);
    
    
    /**
     * answerList 설명
     * @param vo
     * @return
     */
    Pager<EventVO> answerList(EventVO vo);

    /**
     * eventTypeList 설명
     * 
     * @param vo
     * @return
     */
    List<EventVO> eventTypeList(EventVO vo);

    /**
     * eventInsertAction 설명
     * 
     * @param vo
     * @return
     */
    int eventInsertAction(EventVO vo, HttpServletRequest request);

    /**
     * BannerUpdateForm 설명
     * 
     * @param vo
     * @return
     */
    EventVO eventUpdateForm(EventVO vo);

    /**
     * BannerUpdate 설명
     * 
     * @param vo
     * @return
     */
    int eventUpdate(EventVO vo, HttpServletRequest request);

    /**
     * FileDel 설명
     * 
     * @param vo
     */
    int fileDel(EventVO vo);

    /**
     * domainList 설명
     * 
     * @param vo
     * @return
     */
    List<EventVO> domainList(EventVO vo);
    
    
    /**
     * eventLcSeList 설명
     * @param vo
     * @return
     */
    List<EventVO> eventLcSeList(EventVO vo);
    
    /**
     * eventDomainList 설명
     * 
     * @param vo
     * @return
     */
    List<EventVO> eventDomainList(EventVO vo);

    /**
     * orderList 설명
     * 
     * @param vo
     * @return
     */
    List<EventVO> orderList(EventVO vo);

    /**
     * orderUpdate 설명
     * 
     * @param vo
     * @param request
     * @return
     */
    int orderUpdate(EventVO vo, HttpServletRequest request);

    /**
     * eventInsertAction 설명
     * 
     * @param vo
     */
    int eventInsertAction(EventVO vo);

    /**
     * enfrcClosAtUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    int enfrcClosAtUpdateAction(EventVO vo);
    
    /**
     * eventDeleteAction 설명
     * @param vo
     * @param request
     * @return
     */
    int eventDeleteAction(EventVO vo);
    
  
    /**
     * answerListExcel (댓글 엑셀 출력)
     * @param vo
     * @return
     */
    List<EventVO> answerListExcel(EventVO vo);
    
    
        
}
