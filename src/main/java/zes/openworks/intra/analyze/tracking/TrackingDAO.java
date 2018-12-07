/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.tracking;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

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
 *  2012. 5. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class TrackingDAO extends EgovAbstractMapper {

    public void analyzeTracking(TrackingVO vo) {
        insert("_analyzeTracking.tracking", vo);
    }

    public void analyzeTrackingClientPlatform(TrackingVO vo) {
        insert("_analyzeTracking.trackingClientPlatform", vo);
    }

    public void analyzeTrackingReferrer(TrackingVO vo) {
        insert("_analyzeTracking.trackingReferrer", vo);
    }
}
