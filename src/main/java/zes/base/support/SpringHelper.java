/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.support;

import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * Spring FrameWork 관련 지원 클레스
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
 *  2012. 5. 9.    방기배   신규 생성
 * </pre>
 * @see
 */
public class SpringHelper {

    /**
     * Spring Bean으로 로드된 Component를 이름으로 찾아서 반환한다.
     * 
     * @param svrCtx
     * @param serviceName
     * @return
     */
    public static Object findController(ServletContext svrCtx, String serviceName) {

        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(svrCtx);

        Map<String, Object> applMap = ctx.getBeansWithAnnotation(Controller.class);

        return applMap.get(serviceName);
    }

    /**
     * Spring Bean으로 로드된 Service 객체를 이름으로 찾아서 반환한다.
     * 
     * @param svrCtx
     * @param serviceName
     * @return
     */
    public static Object findService(ServletContext svrCtx, String serviceName) {

        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(svrCtx);

        Map<String, Object> applMap = ctx.getBeansWithAnnotation(Service.class);

        return applMap.get(serviceName);
    }

    /**
     * Spring Bean으로 로드된 DAO 객체를 이름으로 찾아서 반환한다.
     * 
     * @param svrCtx
     * @param serviceName
     * @return
     */
    public static Object findDao(ServletContext svrCtx, String serviceName) {

        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(svrCtx);

        Map<String, Object> applMap = ctx.getBeansWithAnnotation(Repository.class);

        return applMap.get(serviceName);
    }
}
