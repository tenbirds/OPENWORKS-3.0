/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.webevent;

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
 * 2014. 10. 27.    이슬버미       신규
 *</pre>
 * @see
 */
public interface WebEventService {

    /**
     * webEventList (이벤트 목록)
     * @param vo
     * @return
     */
    Pager<WebEventVO> webEventList(WebEventVO vo);    
    
    
    /**
     * eventEntryList (이벤트 응모 목록)
     * @param vo
     * @return
     */
    Pager<WebEventVO> eventEntryList(WebEventVO vo);
    
    /**
     * eventRdcntUpdateAction (이벤트 조회 카운트)
     * @param vo
     * @return
     */
    int eventRdcntUpdateAction(WebEventVO vo);
    
    /**
     * eventView (상세)
     * @param vo
     * @return
     */
    WebEventVO eventView(WebEventVO vo);
    
    /**
     * eventAnswerList (댓글 목록)
     * @param vo
     * @return
     */
    Pager<WebEventVO> eventAnswerList(WebEventVO vo);    
    
    /**
     * answerCheck (댓글 중복 확인)
     * @param vo
     * @return
     */
    int answerCheck(WebEventVO vo);

    /**
     * passwordCheck (댓글 비회원 비밀번호 확인)
     * @param vo
     * @return
     */
    int passwordCheck(WebEventVO vo);

    /**
     * answerInsertAction (댓글 등록)
     * @param vo
     * @return
     */
    int answerInsertAction(WebEventVO vo);
    
    /**
     * answerUpdateAction (댓글 수정)
     * @param vo
     * @return
     */
    int answerUpdateAction(WebEventVO vo);
    
    /**
     * answerDeleteAction (댓글 삭제)
     * @param vo
     * @return
     */
    int answerDeleteAction(WebEventVO vo);
    
}
