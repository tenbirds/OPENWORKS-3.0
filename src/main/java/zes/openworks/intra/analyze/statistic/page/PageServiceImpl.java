/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.page;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.analyze.statistic.base.BaseServiceImpl;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

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
@Service("pageService")
public class PageServiceImpl extends BaseServiceImpl implements PageService {

    @Resource
    private PageDAO dao;

    @Override
    public Pager<ResultVO> getStatisticPageList(ResultVO vo, ResultVO sumVo) {

        Integer sumVal = sumVo != null ? sumVo.getValue() : 0;
        vo.setValue(sumVal);
        return dao.getStatisticPageList(vo);
    }

    @Override
    public List<ResultVO> getTopStatisticList(ResultVO vo, ResultVO sumVo) {

        Integer sumVal = sumVo != null ? sumVo.getValue() : 0;
        vo.setValue(sumVal);
        List<ResultVO> topList = dao.getTopStatisticList(vo);

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

        defaultSearchDate(vo);
        defaultPagingData(vo);

        return dao.getStatisticSum(vo);

    }

    // public List<ResultVO> getStatistic(SearchVO vo) {
    //
    // defaultSearchDate(vo);
    //
    // List<ResultVO> list1 = dao.getStatistic(vo);
    //
    // // 비교 통계는 검색일자가 변경되어서 Copy VO가 필요함
    // SearchVO copyVO = new SearchVO();
    // BeanUtils.copyProperties(vo, copyVO);
    // setCompareDate(copyVO);
    // List<ResultVO> list2 = dao.getCompare(copyVO);
    //
    //
    // mergeValues(list1, list2);
    //
    // // 증감계산
    // // 두번째 arg는 비교 대상 항목을 셋팅
    // setVariation(list1, list2);
    //
    // return list1;
    // }

    // public List<ResultVO> getStatisticTimeGroup(SearchVO vo) {
    //
    // defaultSearchDate(vo);
    // defaultSearchTime(vo);
    //
    // List<ResultVO> list1 = dao.getStatisticTimeGroup(vo);
    //
    //
    //
    // return list1;
    // }

    // public List<ResultVO> getStatisticWeekDateGroup(SearchVO vo) {
    //
    // defaultSearchDate(vo);
    // defaultSearchWeekDate(vo);
    //
    // List<ResultVO> list1 = dao.getStatisticWeekDateGroup(vo);
    //
    //
    //
    // return list1;
    // }

    // public List<ResultVO> getStatisticTime(SearchVO vo) {
    //
    // defaultSearchDate(vo);
    //
    // List<ResultVO> list1 = dao.getStatisticTime(vo);
    //
    // return list1;
    // }

    // public List<ResultVO> getStatisticWeekDate(SearchVO vo) {
    //
    // defaultSearchDate(vo);
    //
    // List<ResultVO> list1 = dao.getStatisticWeekDate(vo);
    //
    // return list1;
    // }

}
