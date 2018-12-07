/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.common;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
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
 * 2014. 4. 17.    김영상       신규
 *</pre>
 * @see
 */
public class CommonDutyConstant {
    @Resource
    private CommonDutyService codService;
    
    /** 도메인과 도메인코드 매핑정보 */
    
    /*String domainName[] = {"korean","english","spanish"};
    String domainCode[] = {"2","3","4"};*/
    /*{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 */
    String domainName[] = {"korean","english","spanish","www"};
    String domainCode[] = {"2","3","4","2"};
    //}}
    Map<String,String> domainMap = new HashMap<String,String>();

    public CommonDutyConstant(){
        for(int i = 0 ; i < domainName.length ; i ++){
            domainMap.put(domainName[i],domainCode[i]);
        }
    }

    /**
     * 접속 도메인코드 구하기
     */
    public String getDomainCode(String subDomain){
        return domainMap.get(subDomain);
    }
    
    /**
     * 접속 사이트구분코드 구하기
     */
    public String getJoinSiteDivCd(HttpServletRequest request) {
        String sbscrbSiteSeCd = "";
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String hostNm = "";
        // 이전소스
        //hostNm = CmsUtil.getHostName(request.getServerName());
        
        //{{ BH, 2015.11.23, 도메인관리삭제로 인한 소스변경 
        //변경소스
        hostNm = "korean";
        //}}
        if("".equals(hostNm)){
            hostNm = "korean"; //기본 한국어
        }else{
            //한국어포털
            
            if("korean".equals(hostNm)){
                if(url.indexOf(Config.getString("url.mobileUrlPrefix")) > -1){  //모바일사이트
                    sbscrbSiteSeCd = "2002";
                }else{
                    sbscrbSiteSeCd = "2001";
                }
            //영어포털
            }else if("english".equals(hostNm)){
                if(url.indexOf(Config.getString("url.mobileUrlPrefix")) > -1){  //모바일사이트
                    sbscrbSiteSeCd = "3002";
                }else{
                    sbscrbSiteSeCd = "3001";
                }
            //스페인포털
            }else if("spanish".equals(hostNm)){
                if(url.indexOf(Config.getString("url.mobileUrlPrefix")) > -1){  //모바일사이트
                    sbscrbSiteSeCd = "4002";
                }else{
                    sbscrbSiteSeCd = "4001";
                }
            }else{            
                /*System.out.println("################################");
                System.out.println("####hostNm###"+hostNm+"########");
                System.out.println("################################");
                System.out.println("[ " + "개설되지 않은 도메인?" + " ]");
                System.out.println("################################");*/
            }
        }

        return sbscrbSiteSeCd;
    }

    /**
     * 리턴url구하기
     */
    public String getRedirectUrl(HttpServletRequest request) {
        String url = Validate.isEmpty(request.getRequestURL()) ? "" : request.getRequestURL().toString();
        String query = Validate.isEmpty(request.getQueryString()) ? "" : request.getQueryString().toString();
        String uri = url + "?" + query;
        String rtnDomUrl = "";
        String rtnDomain = "";
        String hostNm = "";
        String protoc = "";
        
        if(!"".equals(uri)){
            rtnDomain = CmsUtil.getRtnDomain(uri);
            hostNm = CmsUtil.getHostName(request.getServerName());
            if("Y".equals(Config.getString("global.sslUse"))){
                protoc  = "https";
            }else{
                protoc  = "http";
                url = url.replace(":446", "");
                url = url.replace(":445", "");
                url = url.replace(":444", "");
                url = url.replace(":443", "");
                url = url.replace(":80", "");
            }
            
            /* 이전소스
            if(uri.indexOf(Config.getString("url.mobileUrlPrefix")) > -1){
                rtnDomUrl = protoc + "://" + rtnDomain + "/" + hostNm + Config.getString("url.mobileUrlPrefix");  //모바일 돌려보낼 도메인과 URL
            }else if(uri.indexOf(Config.getString("url.boardMobileUrlPrefix")) > -1) {
                rtnDomUrl = protoc + "://" + rtnDomain + "/" + hostNm + Config.getString("url.mobileUrlPrefix");  //모바일 돌려보낼 도메인과 URL(게시판용)
            }else{
                rtnDomUrl = protoc + "://" + rtnDomain + "/" + hostNm + Config.getString("url.portalUrlPrefix");
            }
            */
            
            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경  
            // 변경소스
            if(uri.indexOf(Config.getString("url.mobileUrlPrefix")) > -1){
                rtnDomUrl = protoc + "://" + rtnDomain + "/korean"  + Config.getString("url.mobileUrlPrefix");  //모바일 돌려보낼 도메인과 URL
            }else if(uri.indexOf(Config.getString("url.boardMobileUrlPrefix")) > -1) {
                rtnDomUrl = protoc + "://" + rtnDomain + "/korean"  + Config.getString("url.mobileUrlPrefix");  //모바일 돌려보낼 도메인과 URL(게시판용)
            }else{
                rtnDomUrl = protoc + "://" + rtnDomain + "/korean" + Config.getString("url.portalUrlPrefix");
            }
            // }}
        }
        return rtnDomUrl;
    }   
    
}
