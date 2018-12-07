/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.batch;

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
 *  2012. 5. 15.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class AnalyzeDAO extends EgovAbstractMapper {

    public int updateAnlzStatisticFlag() {

        return update("_analyzeBatch.updateAnlzStatisticFlag", null);
    }

    public int mergeAnalyzePageView() {

        return update("_analyzeBatch.mergeAnalyzePageView", null);
    }

    public int mergeAnalyzeVisit() {

        return update("_analyzeBatch.mergeAnalyzeVisit", null);
    }

    public int mergeAnalyzeOriginalVisit() {

        return update("_analyzeBatch.mergeAnalyzeOriginalVisit", null);
    }

    public int mergeAnalyzeFavoritePage() {

        return update("_analyzeBatch.mergeAnalyzeFavoritePage", null);
    }

    public int mergeAnalyzeStartPage() {

        return update("_analyzeBatch.mergeAnalyzeStartPage", null);
    }

    public int mergeAnalyzeEndPage() {

        return update("_analyzeBatch.mergeAnalyzeEndPage", null);
    }

    public int updateAnlzStatisticFlag2() {

        return update("_analyzeBatch.updateAnlzStatisticFlag2", null);
    }

    public int mergeAnalyzeOS() {

        return update("_analyzeBatch.mergeAnalyzeOS", null);
    }

    public int mergeAnalyzeBrowser() {

        return update("_analyzeBatch.mergeAnalyzeBrowser", null);
    }

    public int mergeAnalyzeResolution() {

        return update("_analyzeBatch.mergeAnalyzeResolution", null);
    }

    public int mergeAnalyzeColorDepth() {

        return update("_analyzeBatch.mergeAnalyzeColorDepth", null);
    }

    public int mergeResidensePage() {

        return update("_analyzeBatch.mergeResidensePage", null);
    }

    public int mergeResidenseSite() {

        return update("_analyzeBatch.mergeResidenseSite", null);
    }

    public int updateAnlzStatisticFlag3() {

        return update("_analyzeBatch.updateAnlzStatisticFlag3", null);
    }

    public int mergeSearchEngine() {

        return update("_analyzeBatch.mergeSearchEngine", null);
    }

    public int mergeInflow() {

        return update("_analyzeBatch.mergeInflow", null);
    }

    public int mergeVisitNum() {

        return update("_analyzeBatch.mergeVisitNum", null);
    }

    public int mergeRevisitPeriod() {

        return update("_analyzeBatch.mergeRevisitPeriod", null);
    }

    public int mergePageViewNum() {

        return update("_analyzeBatch.mergePageViewNum", null);
    }
}
