/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.summary;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.openworks.intra.analyze.statistic.base.BaseServiceImpl;
import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.analyze.statistic.common.SearchVO;

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
@Service("summaryService")
public class SummaryServiceImpl extends BaseServiceImpl implements SummaryService {

    @Resource
    private SummaryDAO dao;

    @Override
    public List<ResultVO> getStatistic(SearchVO vo) {

        defaultSearchDate(vo);

        List<ResultVO> list1 = dao.getStatistic(vo);

        return list1;
    }

    @Override
    public List<ResultVO> getTopStatisticList(ResultVO vo, ResultVO sumVo) {

        Integer sumVal = sumVo != null ? sumVo.getValue() : 0;
        vo.setValue(sumVal);
        List<ResultVO> topList = dao.getStatisticList(vo);

        if(topList.size() > 7) {
            topList.remove(topList.size() - 1);
            ResultVO etcVo = new ResultVO();
            int tempValue = 0;
            float tempRate = 0.0f;
            for(ResultVO _vo : topList) {
                tempValue += _vo.getValue();
                tempRate += _vo.getRateValue();
            }
            etcVo.setTitle("기타");
            etcVo.setValue(sumVal - tempValue);
            etcVo.setRateValue(Math.round((100 - tempRate) * 100) / 100.0f);
            topList.add(etcVo);
        }

        return topList;
    }

    @Override
    public ResultVO getStatisticSum(ResultVO vo) {

        // defaultSearchDate(vo);
        // defaultPagingData(vo);

        return dao.getStatisticSum(vo);

    }

}
