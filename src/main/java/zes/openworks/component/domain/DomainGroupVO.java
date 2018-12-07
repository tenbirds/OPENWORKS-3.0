/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.domain;

import java.io.Serializable;

/**
 * 사이트 그룹 관리 VO
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
 *  2012. 6. 18.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class DomainGroupVO implements Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = -6579495456557227605L;

    /** 사이트코드 */
    private Integer domainCd;
    /** IP 주소 */
    private String groupIpAddr;
    /** 사이트 포트 */
    private Integer groupPortNo;
    /** 컨텍스트 */
    private String contextPath;

    /**
     * Integer domainCd을 반환
     * 
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * domainCd을 설정
     * 
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * String groupIpAddr을 반환
     * 
     * @return String groupIpAddr
     */
    public String getGroupIpAddr() {
        return groupIpAddr;
    }

    /**
     * groupIpAddr을 설정
     * 
     * @param groupIpAddr 을(를) String groupIpAddr로 설정
     */
    public void setGroupIpAddr(String groupIpAddr) {
        this.groupIpAddr = groupIpAddr;
    }

    /**
     * Integer groupPortNo을 반환
     * 
     * @return Integer groupPortNo
     */
    public Integer getGroupPortNo() {
        return groupPortNo;
    }

    /**
     * groupPortNo을 설정
     * 
     * @param groupPortNo 을(를) Integer groupPortNo로 설정
     */
    public void setGroupPortNo(Integer groupPortNo) {
        this.groupPortNo = groupPortNo;
    }

    /**
     * String contextPath을 반환
     * 
     * @return String contextPath
     */
    public String getContextPath() {
        return contextPath;
    }

    /**
     * contextPath을 설정
     * 
     * @param contextPath 을(를) String contextPath로 설정
     */
    public void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

}
