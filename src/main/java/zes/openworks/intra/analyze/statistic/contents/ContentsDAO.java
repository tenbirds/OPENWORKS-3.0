/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.contents;

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
public class ContentsDAO extends EgovAbstractMapper {

    /**
     * 목록 조회
     * 
     * @param request
     * @param crudVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ResultVO> getStatisticList(SearchVO vo) {

        return list("_analyzeContents." + vo.getAnalyzeId() + ".getStatisticList", vo);
    }

    public ResultVO getStatisticSum(SearchVO vo) {

        return (ResultVO) selectByPk("_analyzeContents." + vo.getAnalyzeId() + ".getStatisticSum", vo);
    }
}
