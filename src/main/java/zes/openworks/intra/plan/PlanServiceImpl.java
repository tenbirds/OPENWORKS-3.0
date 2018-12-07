/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.plan;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
@Service("PlanService")
public class PlanServiceImpl extends AbstractServiceImpl implements PlanService {

    @Resource
    private PlanDAO dao;

    @Override
    public Pager<PlanVO> planList(PlanVO vo) {
        return dao.planList(vo);
    }

    @Override
    public int planInsertAction(PlanVO vo) {
        return dao.planInsert(vo);
    }

    @Override
    public int planUpdateAction(PlanVO vo) {
        return dao.planUpdaate(vo);
    }

    @Override
    public int planDeleteAction(PlanVO vo) {
        return dao.planDelete(vo);
    }

    @Override
    public int planDeleteChoose(HttpServletRequest request) {

        int cnt = 0;
        String[] seq = request.getParameter("plan_seq").split(",");

        if(seq.length > 0) {
            PlanVO vo = new PlanVO();
            for(String i : seq) {

                vo.setPlan_seq(i);
                dao.planDelete(vo);
                cnt++;
            }
        }
        return cnt;
    }

    @Override
    public PlanVO planUpdatePop(PlanVO vo) {
        return dao.planUpdatePop(vo);
    }

    @Override
    public List<PlanVO> planCalList(PlanVO vo) {
        return dao.planCalList(vo);
    }

    @Override
    public List<PlanVO> planDayList(PlanVO vo) {

        List<PlanVO> tempVo1 = dao.planDayList(vo);
        List<PlanVO> tempVo2 = new ArrayList<PlanVO>();

        // 시간저장 할 임시변수
        String start_t1 = "";
        String start_t2 = "";

        for(int i = 0 ; i < tempVo1.size() ; i++)
        {
            PlanVO vo1 = new PlanVO();
            PlanVO vo2 = new PlanVO();

            List<PlanVO> list_S = new ArrayList<PlanVO>();

            start_t1 = tempVo1.get(i).getStart_time();

            // start_t1.equals(start_t2) : 동일한 시간대에 여러일정이 있는지 판단
            if(start_t1.equals(start_t2))
            {
                // 기존의 Dw_Plan 리스트에 같은 시간대의 일정을 더해준다.
                vo1 = tempVo2.get(tempVo2.size() - 1);
                list_S = vo1.getDw_Plan();

                vo2.setPlan_seq(tempVo1.get(i).getPlan_seq());
                vo2.setTitle(tempVo1.get(i).getTitle());

                list_S.add(vo2);
                vo1.setDw_Plan(list_S);
            }
            else
            {
                vo1.setStart_time(start_t1);
                vo1.setS_time_gb(tempVo1.get(i).getS_time_gb());

                vo2.setPlan_seq(tempVo1.get(i).getPlan_seq());
                vo2.setTitle(tempVo1.get(i).getTitle());

                list_S.add(vo2);
                vo1.setDw_Plan(list_S);

                tempVo2.add(vo1);
            }

            start_t2 = start_t1;
        }

        return tempVo2;
    }

    @Override
    public List<PlanVO> planWeekList(PlanVO vo) {

        List<PlanVO> tempVo1 = dao.planWeekList(vo);
        List<PlanVO> tempVo2 = new ArrayList<PlanVO>();

        // 일자를 저장 할 임시변수
        String start_dt1 = "";
        String start_dt2 = "";

        for(int i = 0 ; i < tempVo1.size() ; i++)
        {
            PlanVO vo1 = new PlanVO();
            PlanVO vo2 = new PlanVO();

            List<PlanVO> list_S = new ArrayList<PlanVO>();

            start_dt1 = tempVo1.get(i).getStart_dt();

            // start_t1.equals(start_t2) : 동일한 일자에 여러일정이 있는지 판단
            if(start_dt1.equals(start_dt2))
            {
                // 기존의 Dw_Plan 리스트에 같은 일자에 일정을 더해준다.
                vo1 = tempVo2.get(tempVo2.size() - 1);
                list_S = vo1.getDw_Plan();

                vo2.setPlan_seq(tempVo1.get(i).getPlan_seq());
                vo2.setTitle(tempVo1.get(i).getTitle());

                list_S.add(vo2);
                vo1.setDw_Plan(list_S);
            }
            else
            {
                vo1.setStart_dt(start_dt1);
                vo1.setsY(tempVo1.get(i).getsY());

                vo2.setPlan_seq(tempVo1.get(i).getPlan_seq());
                vo2.setTitle(tempVo1.get(i).getTitle());

                list_S.add(vo2);
                vo1.setDw_Plan(list_S);

                tempVo2.add(vo1);
            }

            start_dt2 = start_dt1;
        }

        return tempVo2;
    }

    @Override
    public List<PlanVO> planSearchDay(PlanVO vo) {
        return dao.planSearchDay(vo);
    }

}
