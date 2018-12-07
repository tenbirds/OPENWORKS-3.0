/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.batch;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.schedule.Processor;

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
 *  2012. 5. 15.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class AnalyzeProcessor implements Processor {

    Logger logger = LoggerFactory.getLogger(AnalyzeProcessor.class);

    @Resource
    private AnalyzeDAO dao;

    @Override
    public void process() {
        logger.debug("======================================================");
        logger.debug("배치시작");

        dao.updateAnlzStatisticFlag(); // 데이터 플래그 수정

        dao.mergeAnalyzePageView(); // 페이지 뷰 데이터 처리

        dao.mergeAnalyzeVisit(); // 방문자 데이터 처리

        dao.mergeAnalyzeOriginalVisit(); // 순방문자 데이터 처리

        dao.mergeAnalyzeFavoritePage(); // 많이 찾는 페이지

        dao.mergeAnalyzeStartPage(); // 시작 페이지

        dao.mergeAnalyzeEndPage(); // 종료 페이지

        dao.updateAnlzStatisticFlag2(); // 데이터 플래그 수정(클라이언트 Platform)

        dao.mergeAnalyzeOS(); // 클라이언트 OS

        dao.mergeAnalyzeBrowser(); // 클라이언트 Browser

        dao.mergeAnalyzeResolution(); // 클라이언트 해상도

        dao.mergeAnalyzeColorDepth(); // 클라이언트 색상수

        dao.mergeResidensePage(); // 페이지 체류시간

        dao.mergeResidenseSite(); // 사이트 체류시간

        dao.updateAnlzStatisticFlag3(); // 데이터 플래그 수정(검색엔진 유입)

        dao.mergeAnalyzeEndPage(); // 검색엔진

        dao.mergeInflow(); // 유입도메인

        dao.mergeVisitNum(); // 방문횟수별 분석

        dao.mergeRevisitPeriod(); // 재방문기간 분석

        dao.mergePageViewNum(); // 1회 방문페이지 뷰

        logger.debug("배치종료");
        logger.debug("======================================================");
    }

}
