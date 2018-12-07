/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.spi.useragent;

import javax.servlet.http.HttpServletRequest;

import nl.bitwalker.useragentutils.UserAgent;

/**
 * HttpServletRequest 객체의 Header 값중 user-agent 문자열 값으로
 * 브라우저 명, 브라우저 버전, OS 명, 장치 종류, 제조업체 등의 정보를 추출한다.
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
 *  2012. 7. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserAgentAdapter {

    /** 브라우저 정보 Adaptee */
    private UserAgent userAgent;

    /**
     * 브라우저 문자열로 초기화 한다.
     * 
     * @param userAgentString 브라우저 문자열
     */
    public UserAgentAdapter(String userAgentString) {
        this.userAgent = new UserAgent(userAgentString);
    }

    /**
     * HttpServletRequest 객체로 초기화 한다.
     * 
     * @param userAgentString 브라우저 문자열
     */
    public UserAgentAdapter(HttpServletRequest request) {
        if(null == request) {
            throw new IllegalArgumentException("HttpServletRequest is null");
        }
        String userAgentString = request.getHeader("User-Agent");
        this.userAgent = new UserAgent(userAgentString);
    }

    /**
     * 브라우저 명을 반환한다.
     * 
     * @return 브라우저 명
     */
    public String getBrowserName() {
        return this.userAgent.getBrowser().getName();
    }

    /**
     * 브라우저 버전을 반환한다.
     * 
     * @return 브라우저 버전
     */
    public String getBrowserVersion() {
        return this.userAgent.getBrowserVersion().getVersion();
    }

    /**
     * 브라우저 유형을
     * 반환한다.(WEB_BROWSER/EMAIL_CLIENT/MOBILE_BROWSER/ROBOT/TEXT_BROWSER/
     * TOOL/UNKNOWN)
     * 
     * @return 브라우저 유형
     */
    public String getBrowserType() {
        return this.userAgent.getBrowser().getBrowserType().getName();
    }

    /**
     * OS 명을 반환한다.
     * 
     * @return OS 명
     */
    public String getOsName() {
        return this.userAgent.getOperatingSystem().getName();
    }

    /**
     * 장치 종류(COMPUTER/MOBILE/TABLET/GAME_CONSOLE/DMR/UNKNOWN)
     * 
     * @return 장치 종류
     */
    public String getDiviceType() {
        return this.userAgent.getOperatingSystem().getDeviceType().getName();
    }

    /**
     * 장치 제조사명을 반환한다.
     * 
     * @return 장치 제조사명
     */
    public String getManufacturer() {
        return this.userAgent.getOperatingSystem().getManufacturer().getName();
    }

    /**
     * 브라우저 코어에 해당되는 엔진 명을 반환한다.
     * 
     * @return 렌더링 엔진명
     */
    public String getRenderingEngine() {
        return this.userAgent.getBrowser().getRenderingEngine().name();
    }

}
