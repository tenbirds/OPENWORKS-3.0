/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.schedule;

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
 *  2012. 5. 22.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("scheduleService")
public class ScheduleServiceImpl extends AbstractServiceImpl implements ScheduleService {

    @Resource
    private ScheduleDAO dao;

    @Override
    public Pager<ScheduleVO> scheduleList(ScheduleVO vo) {
        return dao.scheduleList(vo);
    }

    @Override
    public int scheduleInsertAction(ScheduleVO vo) {
        if(vo.getHolidayYn().equals("Y")) {
            return dao.holidayInsert(vo);
        } else {
            return dao.scheduleInsert(vo);
        }

    }

    @Override
    public List<ScheduleVO> scheduleCalList(ScheduleVO vo) {
        return dao.scheduleCalList(vo);
    }

    @Override
    public ScheduleVO updatePop(ScheduleVO vo) {
        return dao.scheduleUpdatePop(vo);
    }

    @Override
    public int scheduleUpdateAction(ScheduleVO vo) {
        if(vo.getGbn().equals("A")) {
            return dao.scheduleUpdaate(vo);
        } else if(vo.getGbn().equals("B")) {
            return dao.holidayUpdate(vo);
        } else {
            return 0;
        }
    }

    @Override
    public int scheduleDeleteAction(ScheduleVO vo) {
        if(vo.getGbn().equals("A")) {
            return dao.scheduleDelete(vo);
        } else if(vo.getGbn().equals("B")) {
            return dao.holidayDelete(vo);
        } else {
            return 0;
        }
    }

    @Override
    public int scheduleDeleteChoose(HttpServletRequest request) {

        int cnt = 0;

        String[] seqA = request.getParameter("seqA").split(",");
        if(request.getParameter("seqA").length() > 0) {
            ScheduleVO vo = new ScheduleVO();
            for(String seq : seqA) {
                vo.setSeq(Integer.parseInt(seq));
                dao.scheduleDelete(vo);
                cnt++;
            }
        }

        String[] seqB = request.getParameter("seqB").split(",");
        if(request.getParameter("seqB").length() > 0) {
            ScheduleVO vo2 = new ScheduleVO();
            for(String seq : seqB) {
                vo2.setSeq(Integer.parseInt(seq));
                dao.holidayDelete(vo2);
            }
        }
        return cnt;
    }

}
