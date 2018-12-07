/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.connectCnt;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.analyze.statistic.common.SearchVO;
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
 *  2012. 5. 13.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class ConnectCntDAO extends EgovAbstractMapper {

    @SuppressWarnings("unchecked")
    public List<ResultVO> getStatistic(SearchVO vo) {

        return list("_analyzeConnectCnt." + vo.getAnalyzeId() + ".getStatistic_" + vo.getSearchUnit(), vo);
    }

    @SuppressWarnings("unchecked")
    public List<ResultVO> getCompare(SearchVO vo) {

        return list("_analyzeConnectCnt." + vo.getAnalyzeId() + ".getCompare_" + vo.getSearchUnit(), vo);
    }

    /**
     * 같은시간 접속자 로그
     * getStatisticTimeGroup 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> getStatisticTimeGroup(SearchVO vo) {

        return list("_analyzeConnectCnt." + vo.getAnalyzeId() + ".getStatistic", vo);
    }

    /**
     * 같은요일 접속자 로그
     * getStatisticTimeGroup 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> getStatisticWeekDateGroup(SearchVO vo) {

        return list("_analyzeConnectCnt." + vo.getAnalyzeId() + ".getStatistic", vo);
    }

    /**
     * 시간대별 평균 접속 수
     * getStatisticTime 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> getStatisticTime(SearchVO vo) {

        return list("_analyzeConnectCnt." + vo.getAnalyzeId() + ".getStatistic", vo);
    }

    /**
     * 요일별 평균 접속 수
     * getStatisticTime 설명
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> getStatisticWeekDate(SearchVO vo) {

        return list("_analyzeConnectCnt." + vo.getAnalyzeId() + ".getStatistic", vo);
    }

}
