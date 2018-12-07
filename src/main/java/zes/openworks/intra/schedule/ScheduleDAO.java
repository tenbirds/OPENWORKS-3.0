/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.schedule;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 22.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class ScheduleDAO extends EgovAbstractMapper {

    /**
     * scheduleList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<ScheduleVO> scheduleList(ScheduleVO vo) {
        List<ScheduleVO> dataList = list("_schedule.list", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_schedule.listCount", vo.getDataMap()));

        return new Pager<ScheduleVO>(dataList, vo);
    }

    /**
     * scheduleInsert 설명
     * 
     * @param vo
     * @return
     */
    public int scheduleInsert(ScheduleVO vo) {

        return update("_schedule.scheduleInsert", vo);
    }

    /**
     * holidayInsert 설명
     * 
     * @param vo
     * @return
     */
    public int holidayInsert(ScheduleVO vo) {
        return update("_schedule.holidayInsert", vo);
    }

    /**
     * scheduleCalList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ScheduleVO> scheduleCalList(ScheduleVO vo) {
        return list("_schedule.scheduleCalList", vo);
    }

    /**
     * scheduleUpdatePop 설명
     * 
     * @param vo
     * @return
     */
    public ScheduleVO scheduleUpdatePop(ScheduleVO vo) {
        if(vo.getGbn().equals("A")) {
            return (ScheduleVO) selectByPk("_schedule.updateFormA", vo);
        } else {
            return (ScheduleVO) selectByPk("_schedule.updateFormB", vo);
        }
    }

    /**
     * holidayUpdate 설명
     * 
     * @param vo
     * @return
     */
    public int holidayUpdate(ScheduleVO vo) {
        return update("_schedule.holidayUpdate", vo);
    }

    /**
     * scheduleUpdaate 설명
     * 
     * @param vo
     * @return
     */
    public int scheduleUpdaate(ScheduleVO vo) {
        return update("_schedule.scheduleUpdaate", vo);
    }

    /**
     * scheduleDelete 설명
     * 
     * @param vo
     * @return
     */
    public int scheduleDelete(ScheduleVO vo) {

        return delete("_schedule.scheduleDelete", vo);
    }

    /**
     * holidayDelete 설명
     * 
     * @param vo
     * @return
     */
    public int holidayDelete(ScheduleVO vo) {

        return delete("_schedule.holidayDelete", vo);
    }

}
