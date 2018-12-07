/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.cache;

import zes.base.vo.BaseVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 18.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CacheReloadVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 1429236788261850002L;
    /** 사이트코드 */
    private Integer domainCd;
    /** 동기화 대상 케시 명칭 */
    private String cacheName;

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
     * String cacheName을 반환
     * 
     * @return String cacheName
     */
    public String getCacheName() {
        return cacheName;
    }

    /**
     * cacheName을 설정
     * 
     * @param cacheName 을(를) String cacheName로 설정
     */
    public void setCacheName(String cacheName) {
        this.cacheName = cacheName;
    }
}
