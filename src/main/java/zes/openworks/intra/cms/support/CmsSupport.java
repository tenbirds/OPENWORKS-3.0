/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.support;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import zes.core.lang.MethodUtil;
import zes.core.lang.Validate;

/**
 * 사용자메뉴관리 상세에서 대상 응용컨텐츠에 해당하는 <code>Anotation</code>이 정의된
 * <code>Controller</code> 목록을 가져온다.
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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CmsSupport {

    /** CmsSupport.class logger */
    private static Logger logger = LoggerFactory.getLogger(CmsSupport.class);

    /**
     * 사용자컨텐츠 관리에서 응용컨텐츠에 해당하는 <code>Controller</code> 목록을 반환
     * 
     * @return <code>Controller</code> 목록
     */
    public List<CmsReferenceVO> getCmsReferenceList(ServletContext svrCtx) {

        List<CmsReferenceVO> controlList = new ArrayList<CmsReferenceVO>();

        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(svrCtx,
            "org.springframework.web.servlet.FrameworkServlet.CONTEXT.dispatcher");

        Map<String, Object> applMap = ctx.getBeansWithAnnotation(CmsReference.class);

        // 레퍼런스 존재여부
        if(Validate.isNotEmpty(applMap)) {

            CmsReference ano;
            // Object bean = null;
            CmsReferenceVO cmsVo = null;

            Iterator<String> keys = applMap.keySet().iterator();
            String key = "";

            while(keys.hasNext()) {
                cmsVo = new CmsReferenceVO();

                key = keys.next();
                ano = ctx.findAnnotationOnBean(key, CmsReference.class);

                cmsVo.setName(ano.name());
                cmsVo.setMethodNm(ano.method());
                cmsVo.setBeanNm(key);
                cmsVo.setControlNm(key + "|" + ano.method());

                controlList.add(cmsVo);
            }

        }
        return controlList;
    }

    /**
     * 사용자컨텐츠 관리에서 선택된 응용컨텐츠에서 사용자URL 정보를 추출한다.
     * 
     * @return 서비스명,사용자,관리자URL 정보 목록
     */
    @SuppressWarnings("unchecked")
    public List<CmsReferenceVO> getCmsReference(ServletContext svrCtx, CmsReferenceVO cmsRVO) {

        List<CmsReferenceVO> cmsList = null;

        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(svrCtx,
            "org.springframework.web.servlet.FrameworkServlet.CONTEXT.dispatcher");

        Map<String, Object> applMap = ctx.getBeansWithAnnotation(CmsReference.class);

        Object bean = applMap.get(cmsRVO.getBeanNm());

        Method m = MethodUtil.getMethod(bean.getClass(), cmsRVO.getMethodNm());

        try {
            if(m != null) {
                cmsList = (List<CmsReferenceVO>) m.invoke(bean);
            }
        } catch (Exception e) {
            logger.error("CMS 관리 목록 생성 실패 " + cmsRVO.getMethodNm(), e);
        }

        return cmsList;
    }
}
