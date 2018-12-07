/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.login;

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
@Service("loginService")
public class LoginServiceImpl extends AbstractServiceImpl implements LoginService {

    @Resource
    private LoginDAO dao;

    @Override
    public LoginVO loginAction(LoginVO vo) {

        return dao.loginAction(vo);
    }

    /*
     * (non-Javadoc)
     * @see
     * zes.openworks.intra.login.LoginService#logging(zes.openworks.intra.login
     * .LoginVO)
     */
    @Override
    public void logging(LoggingWebLoginVO vo) {
        dao.logging(vo);
    }

}
