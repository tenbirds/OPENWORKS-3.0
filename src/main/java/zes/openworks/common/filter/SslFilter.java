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
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.cms.support.CmsUtil;


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
public class SslFilter implements Filter {
    public SslFilter() {

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
    * 로그인관련 회원관련 URL 인지 확인
    *
    * @param request
    * @return
    */
    private String sslUrl(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        String hostNm = "";
        String protoc = "";
        String stport = "";
        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가
        // 추가소스
        String DomainName = GlobalConfig.DOMAIN_SUBNM;
        //}}
        hostNm = CmsUtil.getHostName(request.getServerName());
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String rdUrl = "";
        //SSL사용유무가 Y일 경우(로컬에서는 SSL환경을 구성하지 않았을 경우 N으로 세팅할것)
        if("Y".equals(Config.getString("global.sslUse")) && !"".equals(url)){
            //회원관련 소스 및 로그인관련 소스는 모두 SSL로 프로토콜을 변경
            if(!(url.indexOf("https") > -1) && (url.indexOf("/register/") > -1 || url.indexOf("/login/user/") > -1)){
                protoc  = "https";
                if("www".equals(hostNm)){
                    hostNm = "korean";
                }
                if("intra".equals(hostNm)){
                    stport = "447";
                }
                else if("korean".equals(hostNm)){
                    stport = "446";
                //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스제거
                }/*else if("spanish".equals(hostNm)){
                    stport = "445";
                }else if("english".equals(hostNm)){
                    stport = "444";
                }*/
                //}}
                else{
                    stport = "443";
                }

                String backUrl = "";
                // 이전소스
                //String[] arrUrl = url.split(".ceart.kr/");
                //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경
                // 변경소스
                String[] arrUrl = url.split("."+GlobalConfig.DOMAIN_MAINNM+"/");
                //}}
                if(arrUrl.length > 1) {
                    backUrl = arrUrl[1];
                }
                if(!"".equals(query)){
                    /* 이전소스
                    rdUrl = protoc + "://"+hostNm+".ceart.kr:"+stport+"/"+backUrl+"?"+query;*/

                    //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
                    // 변경소스
                    //rdUrl = protoc + "://"+DomainName+":"+stport+"/"+backUrl+"?"+query;
                    rdUrl = protoc + "://"+DomainName+"/"+backUrl+"?"+query;
                    //}}
                }else{
                    /* 이전소스
                    rdUrl = protoc + "://"+hostNm+".ceart.kr:"+stport+"/"+backUrl;*/

                    //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경
                    // 변경소스
                    //rdUrl = protoc + "://"+DomainName+":"+stport+"/"+backUrl;
                    rdUrl = protoc + "://"+DomainName+"/"+backUrl;
                    //}}
                }
                return rdUrl;
            }else {
                return "";
            }
        }else {
            return "";
        }
    }
}