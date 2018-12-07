/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.auth;

import java.lang.reflect.Method;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import zes.base.auth.anotation.AuthIntra;
import zes.core.lang.AnnotationUtil;
import zes.core.lang.Validate;
import zes.core.utils.PathMapper;
import zes.openworks.common.GlobalConfig;

/**
 * <code>URL</code> 기반 권한 체크 <code>Interceptor</code>
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
 *  2012. 3. 1.    방기배   신규 추가
 * </pre>
 * @see
 */
public class AuthenticateInterceptor extends HandlerInterceptorAdapter implements ApplicationContextAware {

    /** &#64;Controller Annotation이 적용된 클레스를 얻기 위함 */
    private ApplicationContext applicationContext;

    /** 권한 메핑 URL */
    private static Map<String, String> AuthorizeUrlMap;

    /** Spring Framework의 URL PathMatcher (&#64;RequestMapping 어노테이션 매핑) */
    // private PathMatcher pathMatcher = new AntPathMatcher();

    /** Openworks 기본 URL PathMatcher */
    private final PathMapper authURlMapper = new PathMapper();

    /**
     * 관리자단 URL Prefix
     * 
     * @see GlobalConfig
     */
    private static final String ADM_URL_PRE_FIX = GlobalConfig.MGR_URL_PREFIX;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
        setAuthorizeUrlMap();
    }

    /**
     * 
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String requestUrl = request.getRequestURI();
        request.getParameterMap();

        if(requestUrl.startsWith(ADM_URL_PRE_FIX)) {

            // pathMatcher.match(pattern, getPath(request));

            Method m = (Method) authURlMapper.get(getPath(request));

            if(Validate.isNotEmpty(m)) {
                AuthIntra authAno;
                authAno = m.getAnnotation(AuthIntra.class);
                authAno.authType();
                authAno.authParams();

                throw new ModelAndViewDefiningException(new ModelAndView(GlobalConfig.MGR_LOST_SESSION));
            }
        }

        return super.preHandle(request, response, handler);
    }

    private boolean setAuthorizeUrlMap() {

        if(null == AuthorizeUrlMap) {
            Map<String, Object> controllerMap = applicationContext.getBeansWithAnnotation(Controller.class);

            AuthIntra authenticateAnnotation;
            RequestMapping requestMappingAnnotation;

            String[] basePath = null;
            String[] values;
            // String[] params;

            for(final Object ctrl : controllerMap.values()) {

                Class<? extends Object> ctrlClass = ctrl.getClass();
                requestMappingAnnotation = ctrlClass.getAnnotation(RequestMapping.class);
                if(Validate.isNotEmpty(requestMappingAnnotation)
                    && Validate.isNotEmpty(requestMappingAnnotation.value())) {
                    basePath = requestMappingAnnotation.value();
                }

                Method[] methods = AnnotationUtil.getMethodWidthAnnotations(ctrlClass, AuthIntra.class);
                for(Method m : methods) {

                    authenticateAnnotation = m.getAnnotation(AuthIntra.class);
                    authenticateAnnotation.authType();
                    authenticateAnnotation.authParams();

                    requestMappingAnnotation = m.getAnnotation(RequestMapping.class);
                    values = requestMappingAnnotation.value();
                    // params = requestMappingAnnotation.params();

                    for(String pattern : values) {
                        if(Validate.isNotEmpty(basePath)) {
                            for(String base : basePath) {
                                pattern = base + "/" + pattern;

                                if(pattern.startsWith("/*") || pattern.startsWith(ADM_URL_PRE_FIX)) {
                                    authURlMapper.put(m, pattern);
                                }
                            }
                        } else {
                            if(pattern.startsWith("/*") || pattern.startsWith(ADM_URL_PRE_FIX)) {
                                authURlMapper.put(m, pattern);
                            }
                        }
                    }
                }
            }
        }

        return true;
    }

    /**
     * 요청 URL(ServletPath 포함)과 QueryString 결합한 결과
     * 
     * @param request
     * @return 전체 URL
     */
    private String getPath(HttpServletRequest request) {

        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        String query = request.getQueryString();

        return (servletPath == null ? "" : servletPath) + (pathInfo == null ? "" : pathInfo)
            + (query == null ? "" : ("?" + query));
    }
}
