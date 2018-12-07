/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

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
public class RequestInfoLogInterceptor extends HandlerInterceptorAdapter {

    /** 자체 로깅 */
    private static Logger logger = LoggerFactory.getLogger(RequestInfoLogInterceptor.class);

    /** 요청 로그 출력 */
    OpenworksLogger requestInfoLog = new OpenworksLogger();
    /** StopWatch */
    private StopWatch stopWatch = new StopWatch();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
        Object handler) throws Exception {
        stopWatch = new StopWatch();
        stopWatch.start();

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
        Object handler, ModelAndView modelAndView) throws Exception {

        requestInfoLog.setModelAndView(modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
        Object handler, Exception ex) throws Exception {

        requestInfoLog.setRequest(request).setHandler(handler).setException(ex);

        if(stopWatch.isRunning()) {
            stopWatch.stop();
        }

        String accept = request.getHeader("Accept");
        String contentType = request.getHeader("Content-type");
        StringBuilder sb = new StringBuilder(requestInfoLog.getResult());

        sb.append("\nAccept is ").append(accept);
        sb.append("\nContentType is ").append(contentType);

        sb.append("\nELAPSED    : " + stopWatch.getTotalTimeSeconds() + " sec");
        sb.append("\n------------------------------------------");

        logger.debug(sb.toString());

    }

}
