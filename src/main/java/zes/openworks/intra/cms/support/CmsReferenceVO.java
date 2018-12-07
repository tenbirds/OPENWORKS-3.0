/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.support;

import zes.base.vo.BaseVO;

/**
 * CMS 컨트롤에서 대상 기능에 대한 메뉴설정 정보를 전달 받기 위한 BEAN으로
 * CMS 메뉴설정에서 기능을 호출할 때 정보를 담아서 전달하도록 한다.
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
public class CmsReferenceVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 1924120439659172870L;
    /** 관리자 서비스 URL */
    private String adminMenuUrl;
    /** 사용자 서비스 URL */
    private String userMenuUrl;
    /** 사용자 서비스 한글 명 */
    private String name;
    /** Spring BEAN 명 */
    private String beanNm;
    /** 사용자 서비스 정보를 받을 함수 명 */
    private String methodNm;
    /** beanNm + methodNm */
    private String controlNm;

    /**
     * CmsReferenceVO.java 생성자
     */
    public CmsReferenceVO() {
    }

    /**
     * String adminMenuUrl을 반환
     * 
     * @return String adminMenuUrl
     */
    public String getAdminMenuUrl() {
        return adminMenuUrl;
    }

    /**
     * adminMenuUrl을 설정
     * 
     * @param adminMenuUrl 을(를) String adminMenuUrl로 설정
     */
    public void setAdminMenuUrl(String adminMenuUrl) {
        this.adminMenuUrl = adminMenuUrl;
    }

    /**
     * String userMenuUrl을 반환
     * 
     * @return String userMenuUrl
     */
    public String getUserMenuUrl() {
        return userMenuUrl;
    }

    /**
     * userMenuUrl을 설정
     * 
     * @param userMenuUrl 을(를) String userMenuUrl로 설정
     */
    public void setUserMenuUrl(String userMenuUrl) {
        this.userMenuUrl = userMenuUrl;
    }

    /**
     * String name을 반환
     * 
     * @return String name
     */
    public String getName() {
        return name;
    }

    /**
     * name을 설정
     * 
     * @param name 을(를) String name로 설정
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * String beanNm을 반환
     * 
     * @return String beanNm
     */
    public String getBeanNm() {
        return beanNm;
    }

    /**
     * beanNm을 설정
     * 
     * @param beanNm 을(를) String beanNm로 설정
     */
    public void setBeanNm(String beanNm) {
        this.beanNm = beanNm;
    }

    /**
     * String methodNm을 반환
     * 
     * @return String methodNm
     */
    public String getMethodNm() {
        return methodNm;
    }

    /**
     * methodNm을 설정
     * 
     * @param methodNm 을(를) String methodNm로 설정
     */
    public void setMethodNm(String methodNm) {
        this.methodNm = methodNm;
    }

    /**
     * controlNm을 반환
     * 
     * @return String controlNm
     */
    public String getControlNm() {
        return controlNm;
    }

    /**
     * controlNm 설정
     * 
     * @param String controlNm을 controlNm로 설정
     */
    public void setControlNm(String controlNm) {
        this.controlNm = controlNm;
    }
}
