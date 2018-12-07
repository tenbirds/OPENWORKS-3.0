/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import zes.base.vo.BaseVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.web.alarm.AlarmService;
import zes.openworks.web.alarm.AlarmVO;

/**
 * RequestContextHolder.currentRequestAttributes() 메소드를 통하여
 * Multipart 컨텐츠에서 파라미터를 추출하기 위한 변환과정
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
 *  2013. 6. 26.    방기배       신규
 * </pre>
 * @see
 */
public class MultipartInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private AlarmService alarmervice;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if(request instanceof MultipartHttpServletRequest) {
            RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
        }

        return true;
    }

    //{SKYOU 2015-11-30 관심서비스 갯수
    @Override
    public void postHandle(
        HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
        throws Exception {

        //  if(validate(request)) {
              BaseVO baseVo = (BaseVO) (request.getSession().getAttribute(GlobalConfig.USER_SESSION_KEY));
              if(Validate.isNotNull(baseVo)) {
                  /* 로그인, 관심서비스등록, 관심서비스삭제시 즐겨찾기 개수 recount*/
                      String acceptURI =request.getRequestURI();
                    //  if(acceptURI.indexOf("ND_loginAction.do") > -1 || acceptURI.indexOf("ND_itst.do") > -1 || acceptURI.indexOf("ND_intrstPrdtDelete.do") > -1){
                          /*MyGoodsVO myvo  = new  MyGoodsVO();
                          myvo.setUserId(request.getSession().getAttribute("MEM_ID").toString());
                          myvo.setLangCode("00");
                          request.getSession().setAttribute("INTRO_CNT",   goodservice.intrstCnt(myvo));*/
                       //   AlarmVO vo = new  AlarmVO();
                       //   vo.setConfrmId(request.getSession().getAttribute("MEM_ID").toString());
                       //   request.getSession().setAttribute("alarmList", alarmervice.alarmList(vo));
                     // }
              }


        //  }

    }
    //}}
}
