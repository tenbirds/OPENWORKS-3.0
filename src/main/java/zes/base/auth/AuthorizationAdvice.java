/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.auth;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import zes.base.auth.anotation.AuthIntra;
import zes.core.lang.Validate;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.menugrp.MenuItemVO;

/**
 * <code>Annotation</code> 기반 권한 체크 <code>Advice</code>
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
 *  2012. 2. 29.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class AuthorizationAdvice implements MethodBeforeAdvice {

    /** SL4J 로깅 */
    private static Logger logger = LoggerFactory.getLogger(AuthorizationAdvice.class);

    @Override
    @SuppressWarnings("unchecked")
    public void before(Method method, Object[] args, Object target) throws Exception {

        logger.debug("================ CHECK AUTHORIZATION LOGIC START ================");

        AuthIntra ano = method.getAnnotation(AuthIntra.class);
        AuthType authType = ano.authType();
        String[] authParams = ano.authParams();
        
        System.out.println("ano: " + ano);
        
        System.out.println("authType: " + authType);
        System.out.println("authParams: " + authParams);

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginVo = (LoginVO) RequestUtil.getSessionAttribue(request, GlobalConfig.MGR_SESSION_KEY);

        // 요청 정보
        Map<String, String[]> reqParamMap = request.getParameterMap();
        String reqControllerNm = target.getClass().getName();

        // 메뉴 정보
        String menuControllerNm = "";
        Map<String, String> menuParamMap = new HashMap<String, String>();

        // 권한정보
        boolean isAuth = false;
        /*
         * READ("R") : 조회권한
         * BASIC("A") : 기본권한(본인 컨텐츠는 모든권한)
         * GENERALIZE("G") : 관리자권한(타인 컨텐츠 포함)
         */
        String authTypeCode = authType.getCode();
        String assignTypeCd = "";

        List<MenuItemVO> menuList = loginVo.getPermissionList();
        
        for(MenuItemVO menu : menuList) {
            menuControllerNm = menu.getControllerNm();

            // 컨트롤러명 일치
            if(Validate.isNotEmpty(menuControllerNm) && reqControllerNm.equals(menuControllerNm)) {

                menuParamMap = getQueryMap(menu.getMenuUrl());
                
                System.out.println("menuParamMap: " + menuParamMap);
                /*
                 * 파라미터 키와 파라미터의 값을 비교하여 확인
                 */
                if(authParams.length > 0) {
                    int authCnt = 0;
                    Iterator<String> it = menuParamMap.keySet().iterator();

                    while(it.hasNext()) {
                        String key = it.next();
                        System.out.println("key: " + key);
                        
                        System.out.println("reqParamMap.containsKey(key): " + reqParamMap.containsKey(key));
                        
                        if(reqParamMap.containsKey(key)) {
                            String paramValues = reqParamMap.get(key)[0];
                            String authValue = menuParamMap.get(key);
                            
                            System.out.println("paramValues: " + paramValues);
                            System.out.println("authValue: " + authValue);
                            if (!"1001".equals(paramValues)) {
                                if(paramValues.equals(authValue)) {
                                    authCnt++;
                                }                                
                            }
                        }
                    }
                    // 설정된 파라미터와 값이 모두 일치할경우 = 권한있음.
                    System.out.println("authCnt: " + authCnt);
                    System.out.println("authParams.length: " + authParams.length);
                    
                    if(authCnt == authParams.length) {
                        assignTypeCd = menu.getMenuItemDesc();
                    }
                } else {
                    assignTypeCd = menu.getMenuItemDesc();
                }
                
                System.out.println("getMenuItemDesc: " + menu.getMenuItemDesc());
                break;
            }
        }

        System.out.println("assignTypeCd: " + assignTypeCd);
        
        // 메뉴 관리에 컨트롤러가 등록되지 않은 경우에는 권한 체크를 하지 않는다.
        if(Validate.isEmpty(assignTypeCd)) {
            assignTypeCd = "G";
        }

        
        if(assignTypeCd.indexOf("G") > -1) {
            System.out.println("AAAAA");
            isAuth = true;
        } else if(assignTypeCd.indexOf("A") > -1) {
            System.out.println("BBBBB");
            if(authTypeCode.equals("R") || authTypeCode.equals("A")) {
                isAuth = true;
            }
        } else {
            System.out.println("CCCCC");
            System.out.println("authTypeCode: " + authTypeCode);
            
            //if(authTypeCode.equals("R")) {
                isAuth = true;
            //}
        }
        System.out.println("isAuth: " + isAuth);
        if(isAuth) {
            request.setAttribute("MenuAssignType", assignTypeCd);
        } else {
            throw new NoAuthException("메뉴 사용 권한이 없습니다.");
        }

        logger.debug("================ CHECK AUTHORIZATION LOGIC END ================");
    }

    /**
     * 주소의 파라미터 Map
     * 
     * @param String
     * @return Map
     */
    private static Map<String, String> getQueryMap(String query) {

        String splitParam = "";
        int posQmark = query.indexOf("?");
        if(posQmark > -1) {
            splitParam = query.substring(posQmark + 1);
        } else {
            splitParam = query;
        }

        Map<String, String> map = new HashMap<String, String>();
        if(splitParam.indexOf("=") > -1) {
            String[] params = splitParam.split("&");
            for(String param : params) {
                String[] arrSplitParam = param.split("=");
                String name = arrSplitParam[0];
                String value = arrSplitParam[1];
                map.put(name, value);
            }
        }
        return map;
    }
}
