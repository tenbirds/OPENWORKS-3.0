/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.List;

import zes.base.vo.BaseVO;

/**
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
public class BoardLogSearchVO extends BaseVO {

    static final long serialVersionUID = -471486166399382576L;

    private List<String> yearList;
    private List<String> monthList;
    private List<String> dayList;

    /** 게시판 코드 */
    private Integer domainCd;
    /** 게시판 코드 */
    private Integer bbsCd;
    /** 게시판 분류코드 */
    private Integer ctgCd;
    /** 통계 유형 */
    private Integer typeCd;
    /** 검색 기간 */
    private String searchTerm;
    /** 검색 연도 */
    private String searchYear;
    /** 검색 월 */
    private String searchMonth;
    /** 검색 일 */
    private String searchDay;
    /** 검색 시간 */
    private String searchHour;

    public List<String> getYearList() {
        return yearList;
    }

    public void setYearList(List<String> yearList) {
        this.yearList = yearList;
    }

    public List<String> getMonthList() {
        return monthList;
    }

    public void setMonthList(List<String> monthList) {
        this.monthList = monthList;
    }

    public List<String> getDayList() {
        return dayList;
    }

    public void setDayList(List<String> dayList) {
        this.dayList = dayList;
    }
    
    public Integer getDomainCd() {
        return domainCd;
    }

    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }
    
    public Integer getCtgCd() {
        return ctgCd;
    }
    
    public void setCtgCd(Integer ctgCd) {
        this.ctgCd = ctgCd;
    }

    public String getSearchTerm() {
        return searchTerm;
    }

    public void setSearchTerm(String searchTerm) {
        this.searchTerm = searchTerm;
    }

    public Integer getTypeCd() {
        return typeCd;
    }

    public void setTypeCd(Integer typeCd) {
        this.typeCd = typeCd;
    }

    public String getSearchYear() {
        return searchYear;
    }

    public void setSearchYear(String searchYear) {
        this.searchYear = searchYear;
    }

    public String getSearchMonth() {
        return searchMonth;
    }

    public void setSearchMonth(String searchMonth) {
        this.searchMonth = searchMonth;
    }

    public String getSearchDay() {
        return searchDay;
    }

    public void setSearchDay(String searchDay) {
        this.searchDay = searchDay;
    }

    public String getSearchHour() {
        return searchHour;
    }

    public void setSearchHour(String searchHour) {
        this.searchHour = searchHour;
    }
}
