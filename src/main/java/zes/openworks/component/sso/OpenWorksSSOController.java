/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sso;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.listener.LoginSessionBinding;
import zes.openworks.intra.login.LoginVO;

/**
 * SSO 로그인
 * 
 * @version 1.0
 * @since openworks-openapi 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 8. 9.    손해석       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/component/sso")
public class OpenWorksSSOController extends IntraController {

    private static final boolean IS_LOGIN_LIMIT_TRY = Boolean.FALSE;
    private static final int LOGIN_MAX_TRY_COUNT = 5;
    private static final int LOGIN_RETRY_DELAY = 30;

    @Autowired
    private OpenWorksSSOService service;

    /**
     * 로그인 폼
     */
    @RequestMapping(value = "ND_SSOindex.do", method = RequestMethod.POST)
    public void SSOindex() {
    }

    /**
     * SSO 로그인 ND_openWorksSSO.jsp
     */
    @RequestMapping(value = "ND_openWorksSSO.do", method = RequestMethod.POST)
    public String openWorksSSO(LoginVO vo, HttpServletRequest request, ModelMap model) {

        LOG_RESULT logResult = LOG_RESULT.OK;
        vo.setSSOClientIp(request.getRemoteAddr());
        String loginurl = "/login/mgr/ND_index.do";
        String resultStr = "200";
        String mgrId = vo.getMgrSSOId();
        vo.setMngrId(mgrId);
        if(Validate.isEmpty(vo.getMngrId())) {
            // return responseText(model, SsoMessages.SSO_EMPTY_ID);
            return alertAndRedirect(model, SsoMessages.SSO_EMPTY_ID, loginurl);
        }

        if(Validate.isEmpty(vo.getMgrSSOCd())) {
            // return responseText(model, SsoMessages.SSOCODE_EMPTY);
            return alertAndRedirect(model, SsoMessages.SSOCODE_EMPTY, loginurl);
        }
        HttpSession session = request.getSession(true);
        if(isValidLogin(session, logResult)) {

            LoginVO ssoDataVo = service.openWorksSSO(vo);

            if("Y".equals(ssoDataVo.getUseYn())) {

                if(ssoDataVo.isValidSSOId() && ssoDataVo.isValidSSOCd() && ssoDataVo.isValidSSOIp()) {

                    if(ssoDataVo.isValidId() && ssoDataVo.isValidPwd() && ssoDataVo.isHasPermission()) {
                        session.setAttribute(GlobalConfig.MGR_SESSION_KEY, ssoDataVo);

                        // 현재 접속자 구현을 위한 바인딩 리스너
                        session.setAttribute("__msbk", new LoginSessionBinding());
                    }
                }
            }

            if(!ssoDataVo.isValidSSOId()) {
                resultStr = SsoMessages.SSO_NOT_ID;
            }
            else if(!ssoDataVo.isValidSSOCd()) {
                resultStr = SsoMessages.SSOCODE_NOT_MATCH;
            }
            else if(!ssoDataVo.isValidSSOIp()) {
                resultStr = SsoMessages.SSOIP_NOT_MATCH;
            }
            else if("N".equals(ssoDataVo.getSSOUseYN())) {
                resultStr = SsoMessages.SSO_NO_USE_ID;
            }

            else if(!ssoDataVo.isValidId()) {
                resultStr = SsoMessages.LOGIN_NOT_FOUND_ID;
            } else if(!ssoDataVo.isValidPwd()) {
                resultStr = SsoMessages.LOGIN_NOT_MATCH_PWD;
                logResult = LOG_RESULT.PASSWORD_FAIL;
            } else if(!ssoDataVo.isHasPermission()) {
                resultStr = SsoMessages.LOGIN_NO_AUTH;
            } else if("N".equals(ssoDataVo.getUseYn())) {
                resultStr = SsoMessages.LOGIN_NO_USE_ID;
            } else {
                resultStr = "SSO 오픈웍스 관리자로 로그인합니다.";
            }
        } else {
            resultStr = SsoMessages.LOGIN_LIMIT_TRY;
        }
        // return alertAndRedirect(model, "로그인이 필요합니다.", url);
        // return responseText(model, resultStr);

        return alertAndRedirect(model, resultStr, loginurl);
    }

    /**
     * 로그인 제한 조건을 체크
     * 
     * @param session
     * @param logResult
     * @return
     */
    private boolean isValidLogin(HttpSession session, LOG_RESULT logResult) {

        if(!IS_LOGIN_LIMIT_TRY) {
            return true;
        }

        String loginLimitCount = (String) session.getAttribute("__LOGIN_TRY_COUNT");
        if(Validate.isAlphaNumeric(loginLimitCount)) {
            int loginTryCount = Integer.parseInt(loginLimitCount) + 1;

            /* 로그인 제한 횟수를 초과함 */
            if(loginTryCount > LOGIN_MAX_TRY_COUNT) {
                // 현재시간 설정
                Long loginLimitTime = (Long) session.getAttribute("__LOGIN_REJECT_TIME");

                /* 로그인 제한 횟수를 최초로 초과함, 로긴 거부 */
                if(Validate.isEmpty(loginLimitTime)) {
                    session.setAttribute("__LOGIN_REJECT_TIME",
                        Long.valueOf(String.valueOf(System.currentTimeMillis())));

                    logResult = LOG_RESULT.OVER_COUNT_LOGIN_TRY;
                    return false;
                } else {
                    long currentTime = System.currentTimeMillis();
                    long elapsedTime = currentTime - loginLimitTime.longValue();

                    /* 로그인 재시도 지연시간을 지남, 로그인 허용 */
                    if((elapsedTime / 1000) > LOGIN_RETRY_DELAY) {

                        session.removeAttribute("__LOGIN_TRY_COUNT");
                        session.removeAttribute("__LOGIN_REJECT_TIME");

                        return true;
                    }
                    /* 로그인 재시도 지연시간이 남았음, 로그인 거부 */
                    else {
                        logResult = LOG_RESULT.OVER_TIME_LOGIN_TRY;
                        return false;
                    }
                }
            }
            /* 아직 로그인 제한 횟수에 도달하지 않음 : 허용 */
            else {
                session.setAttribute("__LOGIN_TRY_COUNT", String.valueOf(loginTryCount));

                return true;
            }
        }
        /* 최초 로그인 시도임 : 로그인 허용 */
        else {
            session.setAttribute("__LOGIN_TRY_COUNT", String.valueOf(1));

            return true;
        }
    }

    private enum LOG_RESULT {
        OK,
        PASSWORD_FAIL,
        OVER_COUNT_LOGIN_TRY,
        OVER_TIME_LOGIN_TRY,
    }
}
