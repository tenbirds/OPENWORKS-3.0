/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.login;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.listener.LoginSessionBinding;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.login.UserLogVO;
import zes.openworks.web.login.UserLoginService;

/**
 * 관리자 로그인 관리 컨트롤러
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
@Controller
@RequestMapping(value = "/login/mgr")
public class LoginController extends IntraController {

    private static final boolean IS_LOGIN_LIMIT_TRY = Boolean.FALSE;
    private static final int LOGIN_MAX_TRY_COUNT = 3;
    private static final int LOGIN_RETRY_DELAY = 300;

    @Autowired
    private LoginService service;
    
    @Autowired
    private UserLoginService webLoginService;

    /**
     * 로그인 폼
     */
    @RequestMapping(value = "ND_index.do", method = RequestMethod.GET)
    public String index(HttpServletRequest request, ModelMap model) {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        HttpSession session = request.getSession(true);
        
       /* 운영에 반영할때 주석 제거~~
        * if(!"http".equals(scheme) || !"intra.ceart.kr".equals(serverName) || serverPort != 80){
            session.invalidate();
            return alertAndBack(model, MessageHelper.getMsg(request, "isNotValidLink"));
        }*/
        return "/login/mgr/ND_index";
    }

    /**
     * 세션 만료 알림 페이지
     */
    @RequestMapping(value = "ND_LostSession.do", method = RequestMethod.GET)
    public void lostSession() {
    }

    /**
     * 권한 없음 알림 페이지
     */
    @RequestMapping(value = "ND_noAuth.do", method = RequestMethod.GET)
    public void noAuth() {
    }

    /**
     * 로그인 액션
     */
    @RequestMapping(value = "ND_loginAction.do", method = RequestMethod.POST)
    public String loginAction(LoginVO vo, HttpServletRequest request, ModelMap model, UserLogVO logVo) {
        LOG_RESULT logResult = LOG_RESULT.OK;
        String resultStr = "200";

        if(Validate.isEmpty(vo.getMngrId())) {
            return responseText(model, Messages.LOGIN_EMPTY_ID);
        }
        if(Validate.isEmpty(vo.getMngrPassword())) {
            return responseText(model, Messages.LOGIN_EMPTY_PWD);
        }

        HttpSession session = request.getSession(true);
        if(isValidLogin(session, logResult)) {

            LoginVO dataVo = service.loginAction(vo);
            if(dataVo.isValidId() && dataVo.isValidPwd()) {
                if("Y".equals(dataVo.getUseYn())) {
                    if(dataVo.isValidId() && dataVo.isValidPwd() && dataVo.isHasPermission()) {
                        session.setAttribute(GlobalConfig.MGR_SESSION_KEY, dataVo);

                        // 현재 접속자 구현을 위한 바인딩 리스너
                        session.setAttribute("__msbk", new LoginSessionBinding());
                    }
                }
                
            }else{
                String ipAddr = request.getRemoteAddr();
                logVo.setLoginIp(ipAddr);
                logVo.setUserId(vo.getMngrId());
                if(!"".equals(logVo.getUserId())){
                    webLoginService.logAction(logVo);
                }
            }
            
            
            service.logging(setLogginInfo(request, vo, "LOG_IN", logResult));
            
            if(!dataVo.isValidId() || !dataVo.isValidPwd()){
                resultStr = "notMatchLogin"; //ID & PASSWORD 입력오류 통합
            } else if(!dataVo.isValidId()) {
                //resultStr = Messages.LOGIN_NOT_FOUND_ID;
                resultStr = Messages.LOGIN_ID_PWD_VALID;
            } else if(!dataVo.isValidPwd()) {
                //resultStr = Messages.LOGIN_NOT_MATCH_PWD;
                resultStr = Messages.LOGIN_ID_PWD_VALID;
                logResult = LOG_RESULT.PASSWORD_FAIL;
            } else if(!dataVo.isHasPermission()) {
                resultStr = Messages.LOGIN_NO_AUTH;
            } else if("N".equals(dataVo.getUseYn())) {
                resultStr = Messages.LOGIN_NO_USE_ID;
            } else {
                resultStr = "200";
            }
            
        } else {
            resultStr = Messages.LOGIN_LIMIT_TRY;
        }

        return responseText(model, resultStr);
    }

    /**
     * 로그아웃 액션
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "ND_logoutAction.do", method = RequestMethod.GET)
    public String logoutAction(HttpServletRequest request) {

        HttpSession session = request.getSession(true);

        LoginVO vo = getLoginSession(request);
        if(Validate.isNotEmpty(vo) && Validate.isNotEmpty(vo.getMngrId())) {
            service.logging(setLogginInfo(request, vo, "LOG_OUT", LOG_RESULT.OK));

            Enumeration<String> enumer = session.getAttributeNames();
            while(enumer.hasMoreElements()) {
                String key = enumer.nextElement();
                session.removeAttribute(key);
            }
        }
        session.invalidate();

        return "redirect:" + Config.getString("url.mgrLogin");
    }

    /**
     * 로그인 제한 조건을 체크
     * 
     * @param session
     * @param logResult
     * @return
     */
    private boolean isValidLogin(HttpSession session, LOG_RESULT logResult) {

//        if(!IS_LOGIN_LIMIT_TRY) {
//            return true;
//        }

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

    private LoggingWebLoginVO setLogginInfo(HttpServletRequest request, LoginVO vo, String logType, LOG_RESULT logResult) {
        LoggingWebLoginVO logVO = new LoggingWebLoginVO();
        logVO.setLoginVO(vo);
        logVO.setLoginTy(logType);
        logVO.setLoginResult(String.valueOf(logResult));
        logVO.setLoginIp(request.getRemoteAddr());
        logVO.setMngrLoginMenu(request.getHeader("REFERER"));

        return logVO;
    }

    private enum LOG_RESULT {
        OK,
        PASSWORD_FAIL,
        OVER_COUNT_LOGIN_TRY,
        OVER_TIME_LOGIN_TRY,
    }
}
