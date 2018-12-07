/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.cache;

import java.util.List;

import zes.openworks.component.domain.DomainVO;

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
public interface CacheReloadService {

    /**
     * 케시 갱신 동기화
     * 
     * @param cacheReloadVO 케시 정보
     * @return
     * @throws Exception
     */
    String synchronize(CacheReloadVO cacheReloadVo) throws Exception;

    /**
     * 도메인 목록
     * 
     * @param domainVo
     * @return
     * @throws Exception
     */
    List<DomainVO> getDomainList(DomainVO domainVo) throws Exception;
}
