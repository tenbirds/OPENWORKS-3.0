/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.alarm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.board.BoardCmtVO;
import zes.openworks.intra.board.BoardConvertOptionVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.mgr.MgrVO;
import zes.openworks.intra.orderManage.consult.ConsultOrderVO;
import zes.openworks.web.boardCount.BoardCountDAO;
import zes.openworks.web.register.RegisterUserVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @version 1.0
 * @since openworks-2.0 프로젝트.(After JDK 1.7)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 12. 28.    sa   신규 생성
 * </pre>
 * @see
 */

@Service
public class AlarmServiceImpl extends AbstractServiceImpl implements AlarmService {

    @Resource
    private AlarmDao dao;
    /* (non-Javadoc)
     * @see zes.openworks.web.alarm.AlarmService#totalboardList(zes.openworks.web.alarm.AlarmVO)
     */
    @Override
    public List<AlarmVO> alarmList(AlarmVO vo) {
        return dao.alarmList(vo);
    }
    /* (non-Javadoc)
     * @see zes.openworks.web.alarm.AlarmService#alarmInsert(zes.openworks.web.alarm.AlarmVO)
     */
    @Override
    public int alarmInsert(AlarmVO vo) {
        return dao.alarmInsert(vo);
    }
    /* (non-Javadoc)
     * @see zes.openworks.web.alarm.AlarmService#alarmUpdate(zes.openworks.web.alarm.AlarmVO)
     */
    @Override
    public int alarmUpdate(AlarmVO vo) {
        // TODO Auto-generated method stub
        return  dao.alarmUpdate(vo);
    }

    
}
