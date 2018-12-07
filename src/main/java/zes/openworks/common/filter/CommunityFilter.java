/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import zes.core.lang.Validate;
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
 * 2014. 11. 13.    김영상       신규
 *</pre>
 * @see
 */
public class CommunityFilter implements Filter {
    //private FilterConfig filterConfig;

    public CommunityFilter() {
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

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String rdUrl = rdCmUrl(req, res);
        if("".equals(rdUrl)) {
            chain.doFilter(request, response);
        }else{
            res.sendRedirect(res.encodeRedirectURL(rdUrl));
        }
    }
   
    /**
    * 요청이 커뮤니티를 호출하는 URL 인지 확인
    * 
    * @param request
    * @return
    */
    private String rdCmUrl(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        String hostNm = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String cmId = "";
        String rdUrl = "";        
        
        if(!"".equals(url) && (url.indexOf("/community/") > -1)){
            cmId = url.split("/community/")[1];
        }
        if(!"".equals(cmId)) {
            if("www".equals(hostNm)){
                hostNm = "korean";
            }
            /* 이전소스
            rdUrl = "http://"+hostNm+".ceart.kr/"+hostNm+"/cm/user/cmUserMain/BD_index.do?cmmntyId="+cmId;*/
            
            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
            // 변경소스
               rdUrl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/"+hostNm+"/cm/user/cmUserMain/BD_index.do?cmmntyId="+cmId;
            //}}
            
            return rdUrl;
        } else {
            return "";
        }
    }
}
