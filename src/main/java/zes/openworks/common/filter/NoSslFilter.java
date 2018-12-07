/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;


/**
 *
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 8.    김영상       신규
 *</pre>
 * @see
 */
public class NoSslFilter implements Filter {
    public NoSslFilter() {

    }

    //필터 초기화 작업
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        //this.filterConfig = filterConfig;
    }

    //필터가 사용한 자원을 반납
    @Override
    public void destroy() {
        //filterConfig = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String rdUrl = sslUrl(req, res);
        if("".equals(rdUrl)) {
            chain.doFilter(request, response);
        }else{
            res.sendRedirect(res.encodeRedirectURL(rdUrl));
        }
    }

    /**
    * 로그인관련 회원관련 URL이 아닌지 확인
    *
    * @param request
    * @return
    */
    private String sslUrl(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String uri = "";
        if(!"".equals(query)){
            uri = url + "?" + query;
        }else{
            uri = url;
        }
        //SSL사용유무가 Y일 경우 .do로 호출된 모든 소스 중 SSL이 적용되어야 할 페이지를 제외하고 http프로토콜로 변환
        if("Y".equals(Config.getString("global.sslUse")) && !"".equals(uri)){
            //회원관련/로그인관련/서비스카테고리호출/데코레이터전역설정소스/각종인증소스 등은 호출되기전 기존 프로토콜을 유지
            if((uri.indexOf("https") > -1) && !(uri.indexOf("/register/") > -1) && !(uri.indexOf("/login/") > -1)
                && !(uri.indexOf("/common/commonduty/") > -1) && !(uri.indexOf("/MD_globalConfig") > -1)
                && !(uri.indexOf("/MD_massageConfig") > -1) && !(uri.indexOf("/common/ipin/") > -1)
                && !(uri.indexOf("/common/bizrno/") > -1) && !(uri.indexOf("/common/checkplus/") > -1)){
                uri = uri.replace("https", "http");
                uri = uri.replace(":446", "");
                uri = uri.replace(":445", "");
                uri = uri.replace(":444", "");
                uri = uri.replace(":443", "");
                uri = uri.replace(":80", "");
                return uri;
            }else {
                return "";
            }
        }else {
            return "";
        }
    }
}
