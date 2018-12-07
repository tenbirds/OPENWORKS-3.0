/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import zes.core.lang.Validate;
import zes.openworks.intra.boardconf.BoardConfVO;

/**
 * 게시판 로그 관련 유틸
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2012. 6. 25.     홍길동      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardLogUtil {

    public static Integer defaultBbsCd(List<BoardConfVO> boardConfList) {
        return defaultBbsCd(boardConfList, null);
    }

    public static Integer defaultBbsCd(List<BoardConfVO> boardConfList, Integer bbsCd) {
        if(Validate.isEmpty(bbsCd)) {
            if(Validate.isNotEmpty(boardConfList)) {
                bbsCd = boardConfList.get(0).getBbsCd();
            } else {
                bbsCd = 1001;
            }
        }
        return bbsCd;
    }

    /**
     * 검색용 파라메타를 생성
     */
    public static Map<String, Object> crateParameterMap(BoardLogSearchVO searchVO) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("bbsCd", searchVO.getBbsCd());

        if(BoardLogConstant.TYPE_YEAR.equals(searchVO.getTypeCd())) {
            setYear(searchVO, paramMap);

            paramMap.put("startYear", searchVO.getSearchYear());

            searchVO.setYearList(createYearList(searchVO));
            searchVO.setSearchTerm(searchVO.getSearchYear() + "년부터 최근 3년간");

        } else if(BoardLogConstant.TYPE_MONTH.equals(searchVO.getTypeCd())) {
            setYear(searchVO, paramMap);
            setMonth(searchVO, paramMap);

            paramMap.put("searchYear", searchVO.getSearchYear());
            searchVO.setYearList(createYearList(searchVO));
            searchVO.setSearchTerm(searchVO.getSearchYear() + "년");

        } else if(BoardLogConstant.TYPE_DAY.equals(searchVO.getTypeCd())) {
            setYear(searchVO, paramMap);
            setMonth(searchVO, paramMap);
            setDay(searchVO, paramMap);

            paramMap.put("startMonth", searchVO.getSearchYear() + searchVO.getSearchMonth());
            searchVO.setYearList(createYearList(searchVO));
            searchVO.setMonthList(createMonthList(searchVO));
            searchVO.setSearchTerm(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월");

        } else if(BoardLogConstant.TYPE_HOUR.equals(searchVO.getTypeCd())) {
            setYear(searchVO, paramMap);
            setMonth(searchVO, paramMap);
            setDay(searchVO, paramMap);
            setHour(searchVO, paramMap);

            paramMap.put("startDay", searchVO.getSearchYear() + searchVO.getSearchMonth() + searchVO.getSearchDay());
            searchVO.setYearList(createYearList(searchVO));
            searchVO.setMonthList(createMonthList(searchVO));
            searchVO.setDayList(createDayList(searchVO));
            searchVO.setSearchTerm(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 " + searchVO.getSearchDay() + "일");
        }

        return paramMap;
    }

    /**
     * 검색년도 설정 (요청년도부터 이전 3년까지)
     */
    private static List<String> createYearList(BoardLogSearchVO boardLogSearchVO) {
        Integer curYear = Calendar.getInstance().get(Calendar.YEAR);
        List<String> searchYearList = new ArrayList<String>();
        int startYeat = Integer.parseInt(boardLogSearchVO.getSearchYear());
        for(int i = startYeat + 2 ; i >= startYeat - 2 ; i--) {
            if(i > curYear.intValue()) {
                continue;
            }
            searchYearList.add(String.valueOf(i));
        }
        return searchYearList;
    }

    /**
     * 검색월 설정 (요청월 1월 ~ 12월)
     */
    private static List<String> createMonthList(BoardLogSearchVO boardLogSearchVO) {
        boolean checkFlag = false;
        List<String> searchMonthList = new ArrayList<String>();
        Integer curYear = Calendar.getInstance().get(Calendar.YEAR);
        Integer curMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
        if(curYear.equals(Integer.valueOf(boardLogSearchVO.getSearchYear()))) {
            checkFlag = true;
        }
        for(int i = 1 ; i <= 12 ; i++) {
            if(checkFlag && (i > curMonth.intValue())) {
                continue;
            }
            searchMonthList.add(i < 10 ? "0" + i : String.valueOf(i));
        }
        return searchMonthList;
    }

    /**
     * 검색일 설정 (요청일 1일 ~ 31일)
     */
    private static List<String> createDayList(BoardLogSearchVO boardLogSearchVO) {
        boolean checkFlag = false;
        List<String> searchDayList = new ArrayList<String>();

        Calendar cal = Calendar.getInstance();
        Integer curYear = cal.get(Calendar.YEAR);
        Integer curMonth = cal.get(Calendar.MONTH) + 1;
        Integer curDay = cal.get(Calendar.DATE);
        if(curYear.equals(Integer.valueOf(boardLogSearchVO.getSearchYear()))
            && curMonth.equals(Integer.valueOf(boardLogSearchVO.getSearchMonth()))) {
            checkFlag = true;
        }

        cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), -1);
        Integer maxDate = cal.get(Calendar.DAY_OF_MONTH);
        for(int i = 1 ; i <= maxDate ; i++) {
            if(checkFlag && (i > curDay.intValue())) {
                continue;
            }
            searchDayList.add(i < 10 ? "0" + i : String.valueOf(i));
        }
        return searchDayList;
    }

    // 년간 검색시 날짜 파레메터를 설정
    private static void setYear(BoardLogSearchVO searchVO, Map<String, Object> paramMap) {
        if(Validate.isEmpty(searchVO.getSearchYear())) {
            searchVO.setSearchYear(String.format("%04d", Calendar.getInstance().get(Calendar.YEAR)));
        } else {
            searchVO.setSearchYear(String.format("%04d", Integer.valueOf(searchVO.getSearchYear())));
        }
    }

    // 월간 검색시 날짜 파라메터를 설정
    private static void setMonth(BoardLogSearchVO searchVO, Map<String, Object> paramMap) {
        if(Validate.isEmpty(searchVO.getSearchMonth())) {
            searchVO.setSearchMonth(String.format("%02d", Calendar.getInstance().get(Calendar.MONTH) + 1));
        } else {
            searchVO.setSearchMonth(String.format("%02d", Integer.valueOf(searchVO.getSearchMonth())));
        }
    }

    // 일간 검색시 날짜 파라메터를 설정
    private static void setDay(BoardLogSearchVO searchVO, Map<String, Object> paramMap) {
        if(Validate.isEmpty(searchVO.getSearchDay())) {
            searchVO.setSearchDay(String.format("%02d", Calendar.getInstance().get(Calendar.DATE)));
        } else {
            searchVO.setSearchDay(String.format("%02d", Integer.valueOf(searchVO.getSearchDay())));
        }
    }

    // 시간간 검색시 시간 파라메터를 설정
    private static void setHour(BoardLogSearchVO searchVO, Map<String, Object> paramMap) {
        if(Validate.isEmpty(searchVO.getSearchHour())) {
            searchVO.setSearchHour(String.format("%02d", Calendar.getInstance().get(Calendar.HOUR)));
        } else {
            searchVO.setSearchHour(String.format("%02d", Integer.valueOf(searchVO.getSearchHour())));
        }
    }

    // 년간 데이터 빠진 부분을 디폴트 값으로 저장 및 정렬 (3년간)
    public static void fillYear(List<BoardLogVO> yearList, String baseYear, int defaultValue) {
        Integer year = Integer.valueOf(baseYear);
        for(int i = 0 ; i < 3 ; i++) {
            boolean matched = false;
            for(BoardLogVO boardLogVO : yearList) {
                if(Integer.valueOf(boardLogVO.getLabel()).intValue() == (year.intValue() - i)) {
                    matched = true;
                }
            }
            if(!matched) {
                yearList.add(new BoardLogVO(String.valueOf(year - i), defaultValue));
            }
        }
        Collections.sort(yearList);
    }

    // 월간 데이터 빠진 부분을 디폴트 값으로 저장 및 정렬 (1-12월)
    public static void fillMonth(List<BoardLogVO> monthList, String baseMonth, int defaultValue) {
        for(int i = 1 ; i <= 12 ; i++) {
            boolean matched = false;
            for(BoardLogVO boardLogVO : monthList) {
                if(Integer.valueOf(boardLogVO.getLabel()).intValue() == i) {
                    matched = true;
                    boardLogVO.setLabel(String.valueOf(i));
                }
            }
            if(!matched) {
                monthList.add(new BoardLogVO(String.valueOf(i), defaultValue));
            }
        }
        Collections.sort(monthList);
    }

    // 일간 데이터 빠진 부분을 디폴트 값으로 저장 및 정렬 (1-31일)
    public static void fillDay(List<BoardLogVO> dayList, String baseDay, int defaultValue) {
        for(int i = 1 ; i <= 31 ; i++) {
            boolean matched = false;
            for(BoardLogVO boardLogVO : dayList) {
                if(Integer.valueOf(boardLogVO.getLabel()).intValue() == i) {
                    matched = true;
                    boardLogVO.setLabel(String.valueOf(i));
                }
            }
            if(!matched) {
                dayList.add(new BoardLogVO(String.valueOf(i), defaultValue));
            }
        }
        Collections.sort(dayList);
    }

    // 시간 데이터 빠진 부분을 디폴트 값으로 저장 및 정렬 (1-24시)
    public static void fillHour(List<BoardLogVO> hourList, String baseHour, int defaultValue) {
        for(int i = 1 ; i <= 24 ; i++) {
            boolean matched = false;
            for(BoardLogVO boardLogVO : hourList) {
                if(Integer.valueOf(boardLogVO.getLabel()).intValue() == i) {
                    matched = true;
                    boardLogVO.setLabel(String.valueOf(i));
                }
            }
            if(!matched) {
                hourList.add(new BoardLogVO(String.valueOf(i), defaultValue));
            }
        }
        Collections.sort(hourList);
    }
    
    
    /**
     * defaultDomcinCd 설명
     * @param boardConfList
     * @return
     */
    public static Integer defaultDomainCd(List<BoardConfVO> boardConfList) {
        return defaultDomainCd(boardConfList, null);
    }

    public static Integer defaultDomainCd(List<BoardConfVO> boardConfList, Integer domainCd) {
        if(Validate.isEmpty(domainCd)) {
            if(Validate.isNotEmpty(boardConfList)) {
                domainCd = boardConfList.get(0).getDomainCd();
            } else {
                domainCd = 2;
            }
        }
        return domainCd;
    }
    
    /**
     * defaultCtgCd 설명
     * @param boardConfList
     * @return
     */
    public static Integer defaultCtgCd(List<BoardConfVO> boardConfList) {
        return defaultDomainCd(boardConfList, null);
    }

    public static Integer defaultCtgCd(List<BoardConfVO> boardConfList, Integer ctgCd) {
        if(Validate.isEmpty(ctgCd)) {
            if(Validate.isNotEmpty(boardConfList)) {
                ctgCd = boardConfList.get(0).getCtgCd();
            } else {
                ctgCd = 2;
            }
        }
        return ctgCd;
    }
}
