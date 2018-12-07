/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

/**
 * 관리자 로그인 처리 프로세스 인터페이스
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
public interface UserLoginService {

    /**
     * 로그인 액션
     */
    UserLoginVO loginAction(UserLoginVO userVO);

    /**
     * 아이디 찾기 액션
     */
    UserLoginVO findIdAction(UserLoginVO userVO);

    /**
     * 패스워드 찾기 액션
     */
    UserLoginVO findPwdAction(UserLoginVO userVO);

    /**
     * 패스워드 신규 생성
     */
    String newPwdCreate(UserLoginVO userVO);
    
    /**
     * 접속이력남김 액션
     * 
     * @param logVo
     */
    int logAction(UserLogVO logVo);

    /**
     * 금일 접속 확인여부
     * 
     * @param logVo
     * @return
     */
    int loginYn(UserLogVO logVo);

    /**
     * logStatsCount 설명
     * 
     * @param logVo
     */
    int logStatsCount(UserLogVO logVo);

    /**
     * userInfo 설명
     * 
     * @param logVo
     */
    UserLogVO userInfo(UserLogVO logVo);

    /**
     * userAllCount 설명
     * 
     * @param logVo
     * @return
     */
    int userAllCount(UserLogVO logVo);

    /**
     * userLog 설명
     * 
     * @param logVo
     */
    int userLog(UserLogVO logVo);

    /**
     * logging 설명
     * @param setLogginInfo
     */
    void logging(LoggingWebUserLoginVO vo);

    String passwordChangeDeCheck(UserLoginVO vo);

    /**
     * getDupCheck 설명
     * @param vo
     * @return
     */
    String getDupCheck(UserLoginVO vo);

    /**
     * cetifybizNo 설명
     * @param vo
     * @return
     */
    String cetifybizNo(UserLoginVO vo);

    /**
     * passwordUpdateAction 설명
     * @param vo
     * @return
     */
    int passwordUpdateAction(UserLoginVO vo);
    
    /**
     * stplatAgreUpdateAction 설명
     * @param vo
     * @return
     */
    int stplatAgreUpdateAction(UserLoginVO vo);
}
