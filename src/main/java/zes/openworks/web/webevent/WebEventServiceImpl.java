/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.webevent;

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
 * 2014. 10. 27.    이슬버미       신규
 *</pre>
 * @see
 */
@Service
public class WebEventServiceImpl  extends AbstractServiceImpl implements WebEventService {

    @Resource
    private WebEventDAO dao;
    
    /* (이벤트 목록)
     * @see zes.openworks.web.webevent.WebEventService#webEventList(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public Pager<WebEventVO> webEventList(WebEventVO vo) {
        return dao.webEventList(vo);
    }
    
    /* (이벤트 응모 목록)
     * @see zes.openworks.web.webevent.WebEventService#eventEntryList(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public Pager<WebEventVO> eventEntryList(WebEventVO vo) {
        return dao.eventEntryList(vo);
    }

    /* (이벤트 조회 카운트)
     * @see zes.openworks.web.webevent.WebEventService#eventRdcntUpdateAction(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public int eventRdcntUpdateAction(WebEventVO vo) {
        return dao.eventRdcntUpdateAction(vo);
    }

    /* (상세)
     * @see zes.openworks.web.webevent.WebEventService#eventView(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public WebEventVO eventView(WebEventVO vo) {
        return dao.eventView(vo);
    }

    /* (댓글 목록)
     * @see zes.openworks.web.webevent.WebEventService#eventAnswerList(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public Pager<WebEventVO> eventAnswerList(WebEventVO vo) {
        return dao.eventAnswerList(vo);
    }

    /* (댓글 중복 확인)
     * @see zes.openworks.web.webevent.WebEventService#answerCheck(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public int answerCheck(WebEventVO vo) {
        return dao.answerCheck(vo);
    }

    /* (댓글 비회원 비밀번호 확인)
     * @see zes.openworks.web.webevent.WebEventService#passwordCheck(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public int passwordCheck(WebEventVO vo) {
        return dao.passwordCheck(vo);
    }

    /* (댓글 등록)
     * @see zes.openworks.web.webevent.WebEventService#answerInsertAction(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public int answerInsertAction(WebEventVO vo) {
        return dao.answerInsertAction(vo);
    }
    
    /* (댓글 수정)
     * @see zes.openworks.web.webevent.WebEventService#answerUpdateAction(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public int answerUpdateAction(WebEventVO vo) {
        return dao.answerUpdateAction(vo);
    }
    
    /* (댓글 삭제)
     * @see zes.openworks.web.webevent.WebEventService#answerDeleteAction(zes.openworks.web.webevent.WebEventVO)
     */
    @Override
    public int answerDeleteAction(WebEventVO vo) {
        return dao.answerDeleteAction(vo);
    }
    
}
