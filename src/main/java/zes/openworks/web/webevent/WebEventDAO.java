/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.webevent;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
@Repository
public class WebEventDAO extends EgovAbstractMapper{

    /**
     * webEventList (이벤트 목록)
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<WebEventVO> webEventList(WebEventVO vo) {
        
        if(Validate.isEmpty(vo.getDataMap().get("q_flag"))){
            vo.getDataMap().put("q_flag", "N");
        }
        
        List<WebEventVO> dataList = list("_webevent.webEventList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_webevent.webEventCount", vo.getDataMap()));
        return new Pager<WebEventVO>(dataList, vo);
    }
    
    /**
     * eventEntryList (이벤트 응모 목록)
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<WebEventVO> eventEntryList(WebEventVO vo) {
        vo.getDataMap().put("q_registId", vo.getWrterId());
        
        Object eventStatus = vo.getDataMap().get("q_eventStatus");
        if(Validate.isNotEmpty(eventStatus)){
            String[] eventStatu = eventStatus.toString().replaceAll("\\[", "").replaceAll("\\]", "").split(",");
            vo.getDataMap().put("q_eventStatus", eventStatu);
        }else{
            //값이 없으면 기본값 설정 (진행중)
            vo.getDataMap().put("q_eventStatus", new String[] {"1001"});
        }
        
        //날짜 설정 없으면 디폴트 현재 날짜
        if(Validate.isEmpty(vo.getDataMap().get("q_beginDate"))){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            Calendar c2 = Calendar.getInstance();
            c2.add(Calendar.MONTH, -1);
            
            vo.getDataMap().put("q_beginDate",sdf.format(c2.getTime()));
            vo.getDataMap().put("q_endDate", sdf.format(c1.getTime()));
        }
     
        List<WebEventVO> dataList = list("_webevent.webEventEntryList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_webevent.webEventEntryCount", vo.getDataMap()));
        
        //원상복구
        vo.getDataMap().put("q_eventStatus", eventStatus);
        
        return new Pager<WebEventVO>(dataList, vo);
    }
    
    /**
     * eventRdcntInsertAction (이벤트 조회 카운트)
     * @param vo
     * @return
     */
    public int eventRdcntUpdateAction(WebEventVO vo) {
        return update("_webevent.eventRdcntUpdateAction", vo);
    }
    
    /**
     * eventView (상세)
     * @param vo
     * @return
     */
    public WebEventVO eventView(WebEventVO vo) {
        return (WebEventVO) selectByPk("_webevent.eventView",vo);
    }    
    
    /**
     * eventAnswerList (댓글 목록)
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<WebEventVO> eventAnswerList(WebEventVO vo) {
        vo.getDataMap().put("eventSn", vo.getEventSn());
        List<WebEventVO> dataList = list("_webevent.webAnswerList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_webevent.webAnswerCount", vo.getDataMap()));
        return new Pager<WebEventVO>(dataList, vo);
    }
    
    /**
     * answerCheck (댓글 중복 확인)
     * @param vo
     * @return
     */
    public int answerCheck(WebEventVO vo) {
        return (Integer) selectByPk("_webevent.answerCheck",vo);
    }
    
    /**
     * passwordCheck (댓글 비회원 비밀번호 확인)
     * @param vo
     * @return
     */
    public int passwordCheck(WebEventVO vo) {
        return (Integer) selectByPk("_webevent.passwordCheck",vo);
    }

    /**
     * answerInsertAction (댓글 등록)
     * @param vo
     * @return
     */
    public int answerInsertAction(WebEventVO vo) {
        return insert("_webevent.answerInsertAction", vo) ;
    }
    
    
    /**
     * answerUpdateAction (댓글 수정)
     * @param vo
     * @return
     */
    public int answerUpdateAction(WebEventVO vo) {
        return insert("_webevent.answerUpdateAction", vo) ;
    }
    
    /**
     * answerDeleteAction (댓글 삭제)
     * @param vo
     * @return
     */
    public int answerDeleteAction(WebEventVO vo) {
        return insert("_webevent.answerDeleteAction", vo) ;
    }
    
    
}
