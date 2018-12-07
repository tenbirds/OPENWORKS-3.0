/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base;

import zes.core.spi.commons.configuration.Config;

/**
 * 메시지 규격화 클레스
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
 *  2012. 5. 16.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BaseMessages {

    /*-- COMMON RESULT RESPONSE --*/
    public static final Boolean TRUE = Boolean.TRUE;
    public static final Boolean FALSE = Boolean.FALSE;

    /*-- COMMON SUCCESS --*/
    public static final String COMMON_INSERT_OK = success("msg.insertOk");
    public static final String COMMON_UPDATE_OK = success("msg.updateOk");
    public static final String COMMON_DELETE_OK = success("msg.deleteOk");
    public static final String COMMON_PROCESS_OK = fail("msg.processOk");

    /*-- COMMON FAIL --*/
    public static final String COMMON_VALIDATE_FAIL = fail("msg.validateFail");
    public static final String COMMON_PROCESS_FAIL = fail("msg.processFail");
    public static final String COMMON_INVALID_PARAM = fail("msg.invalidParam");
    public static final String COMMON_ILLEGA_REQUEST = fail("msg.illegalRequest");
    public static final String COMMON_NO_AUTH = fail("msg.noAuth");
    public static final String COMMON_HAS_PERSONAL_INFO = fail("msg.hasPersonalInfo");
    public static final String COMMON_FILE_SIZE_OVER = fail("msg.fileSizeOver");

    /*-- COMMON DATA --*/
    public static final String COMMON_NO_DATA = fail("msg.noData");

    /*-- 로그인 --*/
    public static final String LOGIN_REQUIRED = fail("msg.requiredLogin");
    public static final String LOGIN_EMPTY_ID = msg("msg.emptyId");
    public static final String LOGIN_EMPTY_PWD = msg("msg.emptyPwd");
    public static final String LOGIN_NO_USE_ID = msg("msg.noUseId");
    public static final String LOGIN_NO_USE_DEPTIN = msg("msg.noUseDeptIn");
    public static final String LOGIN_NO_USE_ID_DEPT = msg("msg.noUseIdAndDept");
    public static final String LOGIN_NOT_FOUND_ID = msg("msg.notFoundId");
    public static final String LOGIN_NOT_MATCH_PWD = msg("msg.notMatchPwd");
    public static final String LOGIN_NO_AUTH = msg("msg.noAuth");
    public static final String LOGIN_LIMIT_TRY = msg("msg.limitTry");
    public static final String LOGIN_NO_SESSION = msg("msg.noSession");

    /**
     * 성공 메시지 생성
     * 
     * @param key
     * @return
     */
    private static String success(String key) {
        return /* "200|" + */Config.getString(key);
    }

    /**
     * 실패 메시지 생성
     * 
     * @param key
     * @return
     */
    private static String fail(String key) {
        return /* "500|" + */Config.getString(key);
    }

    /**
     * 기본 메시지
     * 
     * @param key
     * @return
     */
    private static String msg(String key) {
        return Config.getString(key);
    }
}
