/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.domain;

import java.util.List;

/**
 * 사이트관리 서비스객체 인터페이스
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
public interface DomainService {

    /**
     * 사이트 상세
     * 
     * @param domainVo
     * @return
     */
    DomainVO getDomain(DomainVO domainVo) throws Exception;

    /**
     * 사이트 목록
     * 
     * @param domainVo
     * @return
     */
    List<DomainVO> getDomainList(DomainVO domainVo) throws Exception;

    /**
     * 사이트정보 등록
     * 
     * @param domainVo
     * @return
     */
    Object insertDomain(DomainVO domainVo) throws Exception;

    /**
     * 사이트정보 수정
     * 
     * @param domainVo
     * @return
     */
    int updateDomain(DomainVO domainVo) throws Exception;

    /**
     * 사이트 삭제
     * 
     * @param domainVo
     * @return
     */
    int deleteDomain(DomainVO domainVo) throws Exception;

}
