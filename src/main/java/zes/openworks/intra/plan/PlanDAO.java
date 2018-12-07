/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.plan;

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
 *  2013. 3. 14.    구선모   생성
 * </pre>
 * @see
 */
@Repository
public class PlanDAO extends EgovAbstractMapper {

    /**
     * planList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public Pager<PlanVO> planList(PlanVO vo) {

        List<PlanVO> dataList = list("_plan.list", vo.getDataMap());
        vo.setTotalNum((Integer) selectByPk("_plan.listCount", vo.getDataMap()));
        return new Pager<PlanVO>(dataList, vo);
    }

    /**
     * planInsert 설명
     * 
     * @param vo
     * @return
     */
    public int planInsert(PlanVO vo) {
        return insert("_plan.planInsert", vo);
    }

    /**
     * planUpdaate 설명
     * 
     * @param vo
     * @return
     */
    public int planUpdaate(PlanVO vo) {
        return update("_plan.planUpdate", vo);
    }

    /**
     * planDelete 설명
     * 
     * @param vo
     * @return
     */
    public int planDelete(PlanVO vo) {
        return delete("_plan.planDelete", vo);
    }

    /**
     * planUpdatePop 설명
     * 
     * @param vo
     * @return
     */
    public PlanVO planUpdatePop(PlanVO vo) {
        return (PlanVO) selectByPk("_plan.updateForm", vo);
    }

    /**
     * planCalList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PlanVO> planCalList(PlanVO vo) {
        return list("_plan.planCalList", vo);
    }

    /**
     * planDayList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PlanVO> planDayList(PlanVO vo) {
        return list("_plan.planDayList", vo);
    }

    /**
     * planWeekList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PlanVO> planWeekList(PlanVO vo) {
        return list("_plan.planWeekList", vo);
    }

    /**
     * planWeekList 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<PlanVO> planSearchDay(PlanVO vo) {
        return list("_plan.planSearchDay", vo);
    }

}
