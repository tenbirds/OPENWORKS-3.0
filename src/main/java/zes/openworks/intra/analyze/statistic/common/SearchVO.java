/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.common;

import zes.base.vo.PaggingVO;
import zes.core.utils.DateFormatUtil;

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
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2013. 4.  8.    구선모   select box에서 사용할 변수 추가
 * </pre>
 * @see
 */
public class SearchVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 7650143140656798746L;

    /** 통계 아이디 */
    private String analyzeId = "";

    /** 조회대상 도메인 */
    private String domain = "localhost";

    /** 조회 시작일자 */
    private String startDate = "";

    /** 조회 종료일자 */
    private String endDate = "";

    /** 조회 단위 (시:HOUR / 일:DATE / 주:WEEK / 월:MONTH) */
    private String searchUnit = "HOUR";

    /** 비교 구분 */
    private String compareFlag = "1";

    /** 검색시간 */
    private String searchTime = "";

    /** 검색요일 */
    private String searchWeekDate = "";

    /** 검색단어 */
    private String searchText = "";

    private String[] domains = null;

    /** select box code */
    private String selBoxCd = "";
    /** select box value */
    private String selBoxVl = "";

    /**
     * String domain을 반환
     * 
     * @return String domain
     */
    public String getDomain() {
        return domain;
    }

    /**
     * domain을 설정
     * 
     * @param domain 을(를) String domain로 설정
     */
    public void setDomain(String domain) {
        this.domain = domain;
    }

    /**
     * String startDate을 반환
     * 
     * @return String startDate
     */
    public String getStartDate() {
        return startDate.replaceAll("-", "");
    }

    /**
     * String startDate을 반환
     * 
     * @return String startDate
     */
    public String getStartDateFmt() {
        return DateFormatUtil.getDateShort(DateFormatUtil.toDateShort(startDate.replaceAll("-", "")));
    }

    /**
     * startDate을 설정
     * 
     * @param startDate 을(를) String startDate로 설정
     */
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    /**
     * String endDate을 반환
     * 
     * @return String endDate
     */
    public String getEndDate() {
        return endDate.replaceAll("-", "");
    }

    /**
     * String endDate을 반환
     * 
     * @return String endDate
     */
    public String getEndDateFmt() {
        return DateFormatUtil.getDateShort(DateFormatUtil.toDateShort(endDate.replaceAll("-", "")));
    }

    /**
     * endDate을 설정
     * 
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    /**
     * String searchUnit을 반환
     * 
     * @return String searchUnit
     */
    public String getSearchUnit() {
        return searchUnit;
    }

    /**
     * searchUnit을 설정
     * 
     * @param searchUnit 을(를) String searchUnit로 설정
     */
    public void setSearchUnit(String searchUnit) {
        this.searchUnit = searchUnit;
    }

    /**
     * String compareFlag을 반환
     * 
     * @return String compareFlag
     */
    public String getCompareFlag() {
        return compareFlag;
    }

    /**
     * compareFlag을 설정
     * 
     * @param compareFlag 을(를) String compareFlag로 설정
     */
    public void setCompareFlag(String compareFlag) {
        this.compareFlag = compareFlag;
    }

    /**
     * String analyzeId을 반환
     * 
     * @return String analyzeId
     */
    public String getAnalyzeId() {
        return analyzeId;
    }

    /**
     * analyzeId을 설정
     * 
     * @param analyzeId 을(를) String analyzeId로 설정
     */
    public void setAnalyzeId(String analyzeId) {
        this.analyzeId = analyzeId;
    }

    /**
     * String searchTime을 반환
     * 
     * @return String searchTime
     */
    public String getSearchTime() {
        return searchTime;
    }

    /**
     * searchTime을 설정
     * 
     * @param searchTime 을(를) String searchTime로 설정
     */
    public void setSearchTime(String searchTime) {
        this.searchTime = searchTime;
    }

    /**
     * String searchWeekDate을 반환
     * 
     * @return String searchWeekDate
     */
    public String getSearchWeekDate() {
        return searchWeekDate;
    }

    /**
     * searchWeekDate을 설정
     * 
     * @param searchWeekDate 을(를) String searchWeekDate로 설정
     */
    public void setSearchWeekDate(String searchWeekDate) {
        this.searchWeekDate = searchWeekDate;
    }

    /**
     * String searchText을 반환
     * 
     * @return String searchText
     */
    public String getSearchText() {
        return searchText;
    }

    /**
     * searchText을 설정
     * 
     * @param searchText 을(를) String searchText로 설정
     */
    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }

    /**
     * String[] domains을 반환
     * 
     * @return String[] domains
     */
    public String[] getDomains() {
        return domains;
    }

    /**
     * domains을 설정
     * 
     * @param domains 을(를) String[] domains로 설정
     */
    public void setDomains(String[] domains) {
        this.domains = domains;
    }

    /**
     * String selBoxCd을 반환
     * 
     * @return String selBoxCd
     */
    public String getSelBoxCd() {
        return selBoxCd;
    }

    /**
     * selBoxCd을 설정
     * 
     * @param selBoxCd 을(를) String selBoxCd로 설정
     */
    public void setSelBoxCd(String selBoxCd) {
        this.selBoxCd = selBoxCd;
    }

    /**
     * String selBoxVl을 반환
     * 
     * @return String selBoxVl
     */
    public String getSelBoxVl() {
        return selBoxVl;
    }

    /**
     * selBoxVl을 설정
     * 
     * @param selBoxVl 을(를) String selBoxVl로 설정
     */
    public void setSelBoxVl(String selBoxVl) {
        this.selBoxVl = selBoxVl;
    }

}
