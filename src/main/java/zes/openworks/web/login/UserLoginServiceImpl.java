/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 관리자 로그인 처리 구현객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("webLoginService")
public class UserLoginServiceImpl extends AbstractServiceImpl implements UserLoginService {

    @Resource
    private UserLoginDAO dao;

    @Override
    public UserLoginVO loginAction(UserLoginVO vo) {

        return dao.loginAction(vo);
    }

    @Override
    public UserLoginVO findIdAction(UserLoginVO vo) {

        return dao.findIdAction(vo);
    }

    @Override
    public UserLoginVO findPwdAction(UserLoginVO vo) {

        return dao.findPwdAction(vo);
    }
    
    @Override
    public String newPwdCreate(UserLoginVO vo) {

        return dao.newPwdCreate(vo);
    }

    @Override
    public int logAction(UserLogVO logVo) {
        return dao.logAction(logVo);
    }

    @Override
    public int loginYn(UserLogVO logVo) {

        return dao.logYn(logVo);
    }

    @Override
    public int logStatsCount(UserLogVO logVo) {
        if(logVo.getAge() >= 10 && logVo.getAge() < 20) {
            logVo.setAgeType("A");
        } else if(logVo.getAge() >= 20 && logVo.getAge() < 30) {
            logVo.setAgeType("B");
        } else if(logVo.getAge() >= 30 && logVo.getAge() < 40) {
            logVo.setAgeType("C");
        } else if(logVo.getAge() >= 40 && logVo.getAge() < 50) {
            logVo.setAgeType("D");
        } else if(logVo.getAge() >= 50 && logVo.getAge() < 60) {
            logVo.setAgeType("E");
        } else if(logVo.getAge() >= 60 && logVo.getAge() < 70) {
            logVo.setAgeType("F");
        } else if(logVo.getAge() >= 70) {
            logVo.setAgeType("G");
        } else {
            logVo.setAgeType("H");
        }
        return dao.logStatsCount(logVo);
    }

    @Override
    public UserLogVO userInfo(UserLogVO logVo) {
        return dao.userInfo(logVo);
    }

    @Override
    public int userAllCount(UserLogVO logVo) {
        return dao.userAllCount(logVo);
    }

    @Override
    public int userLog(UserLogVO logVo) {
        return dao.userLog(logVo);
    }

    @Override
    public void logging(LoggingWebUserLoginVO vo) {
        dao.logging(vo);
    }

    @Override
    public String passwordChangeDeCheck(UserLoginVO vo){
        return dao.passwordChangeDeCheck(vo);
    }

    @Override
    public String getDupCheck(UserLoginVO vo) {

        return dao.getDupCheck(vo);
    }

    @Override
    public String cetifybizNo(UserLoginVO vo) {

        return dao.cetifybizNo(vo);
    }

    @Override
    public int passwordUpdateAction(UserLoginVO vo) {

        return dao.passwordUpdateAction(vo);
    }
    
    @Override
    public int stplatAgreUpdateAction(UserLoginVO vo) {

        return dao.stplatAgreUpdateAction(vo);
    }
}
