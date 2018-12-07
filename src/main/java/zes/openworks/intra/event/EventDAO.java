/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.event;

import java.util.List;
import java.util.Map;

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
 * 2014. 10. 16.    이슬버미       신규
 *</pre>
 * @see
 */
@Repository
public class EventDAO  extends EgovAbstractMapper{
    
    /**
     * 이벤트목록
     * eventList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<EventVO> eventList(EventVO vo) {
        vo.getDataMap().put("eventTyCd", vo.getEventTyCd());
        
        
        //진행중/마감 상태 최초값은 A 설정해줌
        if(Validate.isEmpty(vo.getDataMap().get("q_enfrcClosAt"))){
            vo.getDataMap().put("q_enfrcClosAt","A");
        }
        
        List<EventVO> dataList = list("_event.eventList", vo.getDataMap());
        
        for(EventVO dataVo : dataList) {
            List<EventVO> domainList = list("_event.eventDomainList", dataVo);
            dataVo.setDomainCdList(domainList);
            
            List<EventVO> lcSeList = list("_event.eventLcSeList", dataVo);
            dataVo.setEventLcSeCdList(lcSeList);
        }
        
        vo.setTotalNum((Integer) selectByPk("_event.eventCount", vo.getDataMap()));

        return new Pager<EventVO>(dataList, vo);
    }
    
    /**
     * answerList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<EventVO> answerList(EventVO vo) {
        
        vo.getDataMap().put("eventSn", vo.getEventSn());
        
        List<EventVO> dataList = list("_event.answerList", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_event.answerCount", vo.getDataMap()));
        return new Pager<EventVO>(dataList, vo);
    }

    
    
    /**
     * eventTypeList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<EventVO> eventTypeList(EventVO vo) {
        return list("_event.eventTypeList", vo);
    }

    /**
     * eventInsertAction 설명
     * 
     * @param vo
     * @return
     */
    public int eventInsertAction(EventVO vo) {
        return insert("_event.eventInsert", vo);
    }

    /**
     * eventUpdateForm 설명
     * 
     * @param vo
     * @return
     */
    public EventVO eventUpdateForm(EventVO vo) {
        return (EventVO) selectByPk("_event.eventUpdateForm", vo);
    }

    /**
     * fileDel 설명
     * 
     * @param vo
     * @return
     */
    public int fileDel(EventVO vo) {

        return update("_event.delfile", vo);
    }

    /**
     * filePath 설명
     * 
     * @param seq
     * @return
     */
    public String filePath(EventVO vo) {
        return (String) selectByPk("_event.filePath", vo);
    }

    /**
     * eventUpdate 설명
     * 
     * @param vo
     * @return
     */
    public int eventUpdate(EventVO vo) {
        return update("_event.eventUpdate", vo);
    }

    /**
     * domainList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<EventVO> domainList(EventVO vo) {

        return list("_event.domainList", vo);
    }

    /**
     * eventLcSeList 설명
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<EventVO> eventLcSeList(EventVO vo) {

        return list("_event.lcSeList", vo);
    }    
    /**
     * popupInsertDomainCd 설명
     * 
     * @param vo
     */
    public int eventInsertDomainCd(EventVO vo) {
        return update("_event.eventInsertDomainCd", vo);
    }
    
    public int eventInsertLsSeCd(EventVO vo) {
        return update("_event.eventInsertLsSeCd", vo);
    }

    /**
     * eventDomainDel 설명
     * 
     * @param vo
     */
    public int eventDomainDel(EventVO vo) {
        return delete("_event.eventDomainDel", vo);
    }
    
    /**
     * eventLcInfoDel 설명
     * @param vo
     * @return
     */
    public int eventLcInfoDel(EventVO vo) {
        return delete("_event.eventLcInfoDel", vo);
    }

    /**
     * eventDomainList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<EventVO> eventDomainList(EventVO vo) {

        return list("_event.eventDomainList", vo);
    }

    /**
     * orderList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<EventVO> orderList(EventVO vo) {

        return list("_event.orderList", vo);
    }

    /**
     * orderUpdate 설명
     * 
     * @param vo
     */
    public int orderUpdate(EventVO vo) {
        return update("_event.orderUpdate", vo);

    }

    /**
     * enfrcClosAtUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    public int enfrcClosAtUpdateAction(EventVO vo) {
        int _result = update("_event.enfrcClosAtUpdate", vo);
        return _result;
    }

    /**
     * orderDelete 설명
     * 
     * @param vo
     */
    public int orderDelete(EventVO vo) {
        return delete("_event.orderDelete", vo);

    }
            
    
    /**
     * eventDeleteAction 설명
     * @param vo
     * @return
     */
    public int eventDeleteAction(EventVO vo){
        int affected = 0;
        if(Validate.isNotEmpty(vo.getEventSns())){
            
            for(String eventSeqs : vo.getEventSns()) {
                EventVO eventVo  = new EventVO();
                eventVo.setEventSn(Integer.valueOf(eventSeqs));
                
                            delete("_event.eventLcInfoDel", eventVo);
                            delete("_event.eventDomainDel", eventVo);
                affected += delete("_event.eventDel", eventVo);
                            
            }
        }

        return affected;        
    }
    
    public int eventAtDeleteAction(EventVO vo){
        int affected = 0;
        
        if(Validate.isNotEmpty(vo.getEventSns())){            
            for(String eventSeqs : vo.getEventSns()) {
                EventVO eventVo  = new EventVO();
                
                eventVo.setEventSn(Integer.valueOf(eventSeqs));                            
                affected += update("_event.eventAtDel", eventVo);
                            
            }
        }

        
        return affected;
    }
    
    /**
     * answerListExcel (댓글 엑셀 출력)
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<EventVO> answerListExcel(EventVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        parameterMap.put("eventSn", vo.getEventSn());
        
        List<EventVO> dataList = list("_event.answerListExcel", parameterMap);
        return dataList;
    }
    
    
}
