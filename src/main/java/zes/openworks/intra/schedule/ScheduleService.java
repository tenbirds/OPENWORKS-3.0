/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.schedule;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;

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
public interface ScheduleService {

    /**
     * scheduleList 설명
     * 
     * @param vo
     * @return
     */
    Pager<ScheduleVO> scheduleList(ScheduleVO vo);

    /**
     * scheduleInsertAction 설명
     * 
     * @param vo
     * @return
     */
    int scheduleInsertAction(ScheduleVO vo);

    /**
     * scheduleCalList 설명
     * 
     * @param vo
     * @return
     */
    List<ScheduleVO> scheduleCalList(ScheduleVO vo);

    /**
     * updatePop 설명
     * 
     * @param vo
     * @return
     */
    ScheduleVO updatePop(ScheduleVO vo);

    /**
     * scheduleUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    int scheduleUpdateAction(ScheduleVO vo);

    /**
     * scheduleDeleteAction 설명
     * 
     * @param vo
     * @return
     */
    int scheduleDeleteAction(ScheduleVO vo);

    /**
     * scheduleDeleteChoose 설명
     * 
     * @param request
     * @return
     */
    int scheduleDeleteChoose(HttpServletRequest request);

}