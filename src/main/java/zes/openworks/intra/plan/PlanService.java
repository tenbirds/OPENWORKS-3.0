/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.plan;

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
 *  2013. 3. 14.    구선모   셍성
 * </pre>
 * @see
 */
public interface PlanService {

    /**
     * planList 설명
     * 
     * @param vo
     * @return
     */
    Pager<PlanVO> planList(PlanVO vo);

    /**
     * planInsertAction 설명
     * 
     * @param vo
     * @return
     */
    int planInsertAction(PlanVO vo);

    /**
     * planUpdateAction 설명
     * 
     * @param vo
     * @return
     */
    int planUpdateAction(PlanVO vo);

    /**
     * planDeleteAction 설명
     * 
     * @param vo
     * @return
     */
    int planDeleteAction(PlanVO vo);

    /**
     * planDeleteChoose 설명
     * 
     * @param request
     * @return
     */
    int planDeleteChoose(HttpServletRequest request);

    /**
     * updatePop 설명
     * 
     * @param vo
     * @return
     */
    PlanVO planUpdatePop(PlanVO vo);

    /**
     * planCalList 설명
     * 
     * @param vo
     * @return
     */
    List<PlanVO> planCalList(PlanVO vo);

    /**
     * planDayList 설명
     * 
     * @param vo
     * @return
     */
    List<PlanVO> planDayList(PlanVO vo);

    /**
     * planWeekList 설명
     * 
     * @param vo
     * @return
     */
    List<PlanVO> planWeekList(PlanVO vo);

    /**
     * planWeekList 설명
     * 
     * @param vo
     * @return
     */
    List<PlanVO> planSearchDay(PlanVO vo);

}
