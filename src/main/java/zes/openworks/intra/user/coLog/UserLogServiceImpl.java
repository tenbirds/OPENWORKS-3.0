/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.coLog;

import java.util.List;

import javax.annotation.Resource;

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
 *  2012. 5. 22.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Service("userLogService")
public class UserLogServiceImpl extends AbstractServiceImpl implements UserLogService {

    @Resource
    private UserLogDAO dao;

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.user.coLog.UserLogService#userLogListR(zes.openworks
     * .intra.user.coLog.UserLogVO)
     */
    @Override
    public Pager<UserLogVO> userLogListR(UserLogVO vo) {
        return dao.userLogListR(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.user.coLog.UserLogService#userLogListO(zes.openworks
     * .intra.user.coLog.UserLogVO)
     */
    @Override
    public Pager<UserLogVO> userLogListO(UserLogVO vo) {
        return dao.userLogListO(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.user.coLog.UserLogService#userLogListU(zes.openworks
     * .intra.user.coLog.UserLogVO)
     */
    @Override
    public Pager<UserLogVO> userLogListU(UserLogVO vo) {
        return dao.userLogListU(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.user.coLog.UserLogService#userLogListExcel(zes.openworks
     * .intra.user.coLog.UserLogVO)
     */
    @Override
    public List<UserLogVO> userLogListExcel(UserLogVO vo) {
        return dao.userLogListExcel(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.user.coLog.UserLogService#menuNmList(zes.openworks
     * .intra.user.coLog.UserLogVO)
     */
    @Override
    public List<UserLogVO> menuNmList(UserLogVO vo) {

        return dao.menuNmList(vo);
    }

}
