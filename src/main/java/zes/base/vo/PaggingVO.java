/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.vo;

import zes.base.pager.Pager;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;

/**
 * Base 페이징 관련 General VO
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 4.    방기배    JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class PaggingVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -7930224451287344029L;
    /** 페이지당 목록 수 */
    public static final int DEFAULT_ROW_PER_PAGE = GlobalConfig.DEFAULT_ROW_PER_PAGE;
    /** 한번에 표시할 페이지 수 */
    public static final int DEFAULT_PAGE_PER_PAGE = GlobalConfig.DEFAULT_PAGE_PER_PAGE;
    /** 현재 페이지 번호 */
    public static final int DEFAULT_CURR_PAGE = 1;

    /** 페이징 시작 번호 */
    private Integer pagingStartNum;
    /** 페이징 끝 번호 */
    private Integer pagingEndNum;
    /** 전체 결과 목록 수 */
    private Integer totalNum;

    /** 현재 Page 번호 */
    private Integer q_currPage;
    /** 페이지당 Row 수 */
    private Integer q_rowPerPage;
    /** 페이지 분할 표시 수 */
    private Integer q_pagePerPage;

    /** 정렬 대상 칼럼 */
    private String q_sortName;
    /** 정렬 방식 (ASC, DESC) */
    private String q_sortOrder;

    /** 기본 검색 조건 */
    private String q_searchKey;
    /** 기본 검색 값 */
    private String q_searchVal;
    /**
     * 기본 검색 유형
     * 유형 종류 - 1001:일치 / 1002:부분일치 / 1003:작거나같음 / 1004:크거나같음
     */
    private String q_searchType;

    public void init() {
        if(Validate.isEmpty(this.q_currPage)) {
            this.q_currPage = DEFAULT_CURR_PAGE;
        }
        if(Validate.isEmpty(this.q_rowPerPage)) {
            this.q_rowPerPage = DEFAULT_ROW_PER_PAGE;
        }
        if(Validate.isEmpty(this.q_pagePerPage)) {
            this.q_pagePerPage = DEFAULT_PAGE_PER_PAGE;
        }

        this.pagingStartNum = Pager.getStartNum(this.q_currPage, this.q_rowPerPage);
        this.pagingEndNum = Pager.getEndNum(this.pagingStartNum, this.q_rowPerPage);
    }

    /**
     * Integer pagingStartNum을 반환
     * 
     * @return Integer pagingStartNum
     */
    public Integer getPagingStartNum() {
        return pagingStartNum;
    }

    /**
     * pagingStartNum을 설정
     * 
     * @param pagingStartNum 을(를) Integer pagingStartNum로 설정
     */
    public void setPagingStartNum(Integer pagingStartNum) {
        this.pagingStartNum = pagingStartNum;
    }

    /**
     * Integer pagingEndNum을 반환
     * 
     * @return Integer pagingEndNum
     */
    public Integer getPagingEndNum() {
        return pagingEndNum;
    }

    /**
     * pagingEndNum을 설정
     * 
     * @param pagingEndNum 을(를) Integer pagingEndNum로 설정
     */
    public void setPagingEndNum(Integer pagingEndNum) {
        this.pagingEndNum = pagingEndNum;
    }

    /**
     * Integer totalNum을 반환
     * 
     * @return Integer totalNum
     */
    public Integer getTotalNum() {
        return totalNum;
    }

    /**
     * totalNum을 설정
     * 
     * @param totalNum 을(를) Integer totalNum로 설정
     */
    public void setTotalNum(Integer totalNum) {
        this.totalNum = totalNum;
    }

    /**
     * Integer q_currPage을 반환
     * 
     * @return Integer q_currPage
     */
    public Integer getQ_currPage() {
        return q_currPage;
    }

    /**
     * q_currPage을 설정
     * 
     * @param q_currPage 을(를) Integer q_currPage로 설정
     */
    public void setQ_currPage(Integer q_currPage) {
        this.q_currPage = q_currPage;
    }

    /**
     * Integer q_rowPerPage을 반환
     * 
     * @return Integer q_rowPerPage
     */
    public Integer getQ_rowPerPage() {
        return q_rowPerPage;
    }

    /**
     * q_rowPerPage을 설정
     * 
     * @param q_rowPerPage 을(를) Integer q_rowPerPage로 설정
     */
    public void setQ_rowPerPage(Integer q_rowPerPage) {
        this.q_rowPerPage = q_rowPerPage;
    }

    /**
     * Integer q_pagePerPage을 반환
     * 
     * @return Integer q_pagePerPage
     */
    public Integer getQ_pagePerPage() {
        return q_pagePerPage;
    }

    /**
     * q_pagePerPage을 설정
     * 
     * @param q_pagePerPage 을(를) Integer q_pagePerPage로 설정
     */
    public void setQ_pagePerPage(Integer q_pagePerPage) {
        this.q_pagePerPage = q_pagePerPage;
    }

    /**
     * String q_sortName을 반환
     * 
     * @return String q_sortName
     */
    public String getQ_sortName() {
        return q_sortName;
    }

    /**
     * q_sortName을 설정
     * 
     * @param q_sortName 을(를) String q_sortName로 설정
     */
    public void setQ_sortName(String q_sortName) {
        this.q_sortName = q_sortName;
    }

    /**
     * String q_sortOrder을 반환
     * 
     * @return String q_sortOrder
     */
    public String getQ_sortOrder() {
        return q_sortOrder;
    }

    /**
     * q_sortOrder을 설정
     * 
     * @param q_sortOrder 을(를) String q_sortOrder로 설정
     */
    public void setQ_sortOrder(String q_sortOrder) {
        this.q_sortOrder = q_sortOrder;
    }

    /**
     * String q_searchKey을 반환
     * 
     * @return String q_searchKey
     */
    public String getQ_searchKey() {
        return q_searchKey;
    }

    /**
     * q_searchKey을 설정
     * 
     * @param q_searchKey 을(를) String q_searchKey로 설정
     */
    public void setQ_searchKey(String q_searchKey) {
        this.q_searchKey = q_searchKey;
    }

    /**
     * String q_searchVal을 반환
     * 
     * @return String q_searchVal
     */
    public String getQ_searchVal() {
        return q_searchVal;
    }

    /**
     * q_searchVal을 설정
     * 
     * @param q_searchVal 을(를) String q_searchVal로 설정
     */
    public void setQ_searchVal(String q_searchVal) {
        this.q_searchVal = q_searchVal;
    }

    /**
     * String q_searchType을 반환
     * 
     * @return String q_searchType
     */
    public String getQ_searchType() {
        return q_searchType;
    }

    /**
     * q_searchType을 설정
     * 
     * @param q_searchType을(를) String q_searchType으로 설정
     */
    public void setQ_searchType(String q_searchType) {
        this.q_searchType = q_searchType;
    }

}
