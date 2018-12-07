/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.satisfy;

import java.util.List;

import zes.base.pager.Pager;

/**
 * 만족도 관리 서비스 객체
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
 *  2012. 6. 22.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface SatisfyService {

    /**
     * 사용자만족도 상세
     */
    SatisfyVO getSatisfy(SatisfyVO userSatisfyVO) throws Exception;

    /**
     * 사용자만족도 목록
     */
    List<SatisfyVO> getSatisfyList(SatisfyVO userSatisfyVO) throws Exception;

    /**
     * 사용자만족도 상세 목록
     */
    Pager<SatisfyVO> getSatisfyDetlList(SatisfyVO satisfyVo) throws Exception;

    /**
     * 사용자만족도 등록
     */
    Object insertSatisfy(SatisfyVO userSatisfyVO) throws Exception;

    /**
     * 사용자만족도 점수
     */
    SatisfyVO getScoreAvg(SatisfyVO userSatisfyVO) throws Exception;
}
