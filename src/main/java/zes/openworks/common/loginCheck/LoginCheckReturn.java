/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.loginCheck;

import javax.servlet.http.HttpServletRequest;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.openworks.intra.cms.support.CmsUtil;

/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 4. 23.    김영상       신규
 *</pre>
 * @see
 */
public class LoginCheckReturn {
    public String LoginCheckRtn(HttpServletRequest request) {
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String uri = url + "?" + query;
        String rst = "";
        String rtnDomUrl = "";
        String rtnDomain = "";
        String protoc = "";
        String stport = "";
        //subDomain명을 구함
        String hostNm = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        
        //uri가 있으면 도메인 구함
        if(!"".equals(uri)){
            rtnDomain = CmsUtil.getRtnDomain(uri);        
            //SSL사용유무에 따라 프로토콜변경
            if("Y".equals(Config.getString("global.sslUse"))){
                protoc  = "https";
                if("korean".equals(hostNm)){
                    stport = ":443";
                }else if("spanish".equals(hostNm)){
                    stport = ":443";
                }else if("english".equals(hostNm)){
                    stport = ":443";
                }else{
                    stport = ":443";
                }
            }else{
                protoc  = "http";
                url = url.replace(":446", "");
                url = url.replace(":445", "");
                url = url.replace(":444", "");
                url = url.replace(":443", "");
                url = url.replace(":80", "");
            }
            
            //모바일과 커뮤니티, 포털의 경우를 각각 분기
            if(uri.indexOf(Config.getString("url.mobileUrlPrefix")) > -1){
                rtnDomUrl = protoc + "://" + rtnDomain + stport + "/" + hostNm + Config.getString("url.mobileUrlPrefix");    //모바일 돌려보낼 도메인과 URL
            }else if(uri.indexOf(Config.getString("url.boardMobileUrlPrefix")) > -1){
                rtnDomUrl = protoc + "://" + rtnDomain + stport + "/" + hostNm + Config.getString("url.mobileUrlPrefix");    //모바일 돌려보낼 도메인과 URL(게시판용)
            }else if(uri.indexOf(Config.getString("url.cmUrlPrefix")) > -1){
                rtnDomUrl = protoc + "://" + rtnDomain + stport + "/" + hostNm + Config.getString("url.cmUrlPrefix");        //커뮤니티는
            }else{
                rtnDomUrl = protoc + "://" + rtnDomain + stport + "/" + hostNm + Config.getString("url.portalUrlPrefix");    //포털 돌려보낼 도메인과 URL
            }

            rst = rtnDomUrl+"login/user/BD_index.do";
        }
        return rst;
    }
}