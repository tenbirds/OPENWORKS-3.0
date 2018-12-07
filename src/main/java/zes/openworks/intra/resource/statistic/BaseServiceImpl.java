/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.resource.statistic;

import java.util.Calendar;
import java.util.List;

import zes.core.lang.Validate;
import zes.core.utils.DateCalcUtil;
import zes.core.utils.DateFormatUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

// import org.eclipse.jetty.util.log.Log;

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
 *  2012. 5. 14.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BaseServiceImpl extends AbstractServiceImpl {

    /**
     * 검색일자 기본값을 셋팅
     * 
     * @param vo
     */
    protected void defaultSearchDate(RscCntSearchVO vo) {

        // Log.info(":>>>>>>>>>111111>>>!!!!!!!!!!!!~~~~~~~getStartDate~~~"+vo.getStartDate());
        // Log.info(":>>>>>>>>>>22222222>>!!!!!!!!!!!!~~~~~~~getEndDate~~~"+vo.getEndDate());
        if(Validate.isEmpty(vo.getStartDate()) && Validate.isEmpty(vo.getEndDate())) {
            // 입력된 날짜가 없는경우(최초조회)에는 1주일을 기본값으로 한다
            vo.setStartDate(DateCalcUtil.addDate(-6, DateFormatUtil.getTodayShort()));
            vo.setEndDate(DateFormatUtil.getTodayShort());
        } else if(Validate.isEmpty(vo.getStartDate())) {
            // 시작일이 없는경우 마지막 날짜 1일을 기본으로 한다
            vo.setStartDate(vo.getEndDate());
        } else if(Validate.isEmpty(vo.getEndDate())) {
            // 종료일이 없는경우 시작 날짜 1일을 기본으로 한다
            vo.setEndDate(vo.getStartDate());
        }

        // Log.info(":>>>>>>>>3333333>>>!!!!!!!!!!!!~~~~~~~getStartDate~~~"+vo.getStartDate());
        // Log.info(":>>>>>>>>44444444>>>>!!!!!!!!!!!!~~~~~~~getEndDate~~~"+vo.getEndDate());
    }

    protected void defaultPagingData(RscCntSearchVO vo) {

        vo.init();

    }

    /**
     * 검색일자 기본값을 셋팅
     * 
     * @param vo
     */
    protected void defaultSearchTime(RscCntSearchVO vo) {

        if(vo.getSearchTime().equals("")) {
            // 처음 호출되는경우 현재 시간을 조회 한다

            int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY) - 1;
            String strHour = "";
            strHour = (hour < 10) ? "0" + hour : "" + hour;

            vo.setSearchTime(strHour);

        } else {
            // 정상
        }

    }

    /**
     * 검색일자 기본값을 셋팅
     * 
     * @param vo
     */
    protected void defaultSearchWeekDate(RscCntSearchVO vo) {

        if(vo.getSearchTime().equals("")) {
            // 처음 호출되는경우 현재 시간을 조회 한다

            int weekDate = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);

            vo.setSearchWeekDate("" + weekDate);

        } else {
            // 정상
        }

    }

    /**
     * sourceList의 값을 targetList로 복사
     * 
     * @param targetList
     * @param sourceList
     */
    protected void mergeValues(List<RscCntResultVO> targetList, List<RscCntResultVO> sourceList) {

        for(int i = 0 ; i < targetList.size() ; i++) {
            RscCntResultVO targetVO = targetList.get(i);
            RscCntResultVO sourceVO = sourceList.get(i);
            List<Integer> values = targetVO.getValues();
            List<Integer> mobileValues = targetVO.getMobileValues();
            values.add(sourceVO.getValue());
            mobileValues.add(sourceVO.getMobileValue());
        }

    }

    /**
     * 증감 계산
     * 
     * @param targetList
     * @param sourceList
     */
    protected void setVariation(List<RscCntResultVO> targetList, List<RscCntResultVO> sourceList) {

        for(int i = 0 ; i < targetList.size() ; i++) {
            RscCntResultVO targetVO = targetList.get(i);
            RscCntResultVO sourceVO = sourceList.get(i);

            targetVO.setVariation(targetVO.getValue() - sourceVO.getValue());
            targetVO.setMobileVariation(targetVO.getMobileValue() - sourceVO.getMobileValue());
        }
    }

    protected void setCompareDate(RscCntSearchVO vo) {
        if(vo.getCompareFlag().equals("7")) {
            vo.setStartDate(DateCalcUtil.addDate(-8, vo.getStartDate()));
            vo.setEndDate(DateCalcUtil.addDate(-1, vo.getEndDate()));
        } else if(vo.getCompareFlag().equals("30")) {
            vo.setStartDate(DateCalcUtil.addDate(-31, vo.getStartDate()));
            vo.setEndDate(DateCalcUtil.addDate(-1, vo.getEndDate()));
        } else {
            vo.setStartDate(DateCalcUtil.addDate(-1, vo.getStartDate()));
            vo.setEndDate(DateCalcUtil.addDate(-1, vo.getEndDate()));
        }
    }
}
