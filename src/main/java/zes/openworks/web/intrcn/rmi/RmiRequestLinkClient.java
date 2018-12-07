/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.intrcn.rmi;

import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import egovframework.mgt.fci.link.service.EgovFciRequestLink;
import egovframework.mgt.fci.reqiem.service.FciRequestIemVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 *  Spring Container에 담긴 Bean을 꺼내기 위한 홀더 역할을 하는 클래스
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 10. 10.    이슬버미       신규
 * </pre>
 * @see
 */
public class RmiRequestLinkClient {

    ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:/config/spring/client-rmi.xml");
    EgovFciRequestLink link = (EgovFciRequestLink) context.getBean("fciRequestLinkClient");

    String userId = "marketplace";
    String authKey = "";

    /**
     * checkConnection (연결 상태 확인 메소드)
     * 
     * @throws Exception
     */
    public String checkConnection() throws Exception {
        return link.checkConnection(userId, authKey);
    }

    /**
     * getRequestStatus (신청된 상호호환성에 대한 현재 상태 요청.)
     * 
     * @param requestId
     * @return
     * @throws Exception
     */
    public Map<String, String> getRequestStatus(String requestId) throws Exception {
        return link.getRequestStatus(userId, authKey, requestId);
    }

    /**
     * getRequestStatusList (신청된 상호호환성에 대한 현재 상태 요청)
     * 
     * @param requestIdList
     * @return
     * @throws Exception
     */
    public List<Map<String, String>> getRequestStatusList(String[] requestIdList) throws Exception {
        return link.getRequestStatusList(userId, authKey, requestIdList);
    }

    /**
     * insertCheckRequest (상호호환성 신청 요청)
     * 
     * @param fciRequestIemVO
     * @throws Exception
     */
    public String insertCheckRequest(FciRequestIemVO fciRequestIemVO) throws Exception {        
        return link.insertCheckRequest(userId, authKey, fciRequestIemVO);
    }

}
