/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.poll;

import zes.base.vo.PaggingVO;


/**
 * 설문 기본 정보
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 7. 17.    방기배       신규
 *</pre>
 * @see
 */
public class PollVO extends PaggingVO {

    private static final long serialVersionUID = -6062915207374506664L;

    /** 도메인 코드 */
    private Integer domainCd;
    /** 도메인 명 */
    private String domainNm;
    /** 일련번호 */
    private Integer seq;
    /** 제목 */
    private String title;
    /** 의도(취지) */
    private String purpose;
    /** 요약 */
    private String summary;
    /** 베너여부 */
    private String bannerYn;
    /** 상태 */
    private String state;
    /** 설문시작 여부 */
    private String startYn;
    /** 설문 종료 여부 */
    private String endYn;
    /** 설문 응답(참여)수 */
    private Integer responseCnt;
    /** 응답자수 제한 수치 */
    private Integer limitCnt;
    /** 중복 응답 허용여부 */
    private String dupYn;
    /** 중복응답 체크 방법(I:IP, U:USER, C:COOKIE) */
    private String dupCheck;
    /** 조회수 */
    private int readCnt;
    /** 설문그룹 수 */
    private int groupCnt;
    /** 공개여부(사용자단) */
    private String openYn;
    /** 시작일 */
    private String startTime;
    /** 종료일 */
    private String endTime;
    /** 등록일 */
    private String regTime;
    /** 수정일 */
    private String modiTime;
    /** 등록자의 부서코드 */
    private String deptCd;
    /** 등록자 아이디 */
    private String regId;
    /** 등록자 부서명 */
    private String deptNm;
    /** 등록자 이름 */
    private String regNm;

    /**
     * Integer domainCd을 반환
     * 
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * domainCd을 설정
     * 
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * String domainNm을 반환
     * 
     * @return String domainNm
     */
    public String getDomainNm() {
        return domainNm;
    }

    /**
     * domainNm을 설정
     * 
     * @param domainNm 을(를) String domainNm로 설정
     */
    public void setDomainNm(String domainNm) {
        this.domainNm = domainNm;
    }

    /**
     * Integer seq을 반환
     * 
     * @return Integer seq
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * seq을 설정
     * 
     * @param seq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * String title을 반환
     * 
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    /**
     * title을 설정
     * 
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * String purpose을 반환
     * 
     * @return String purpose
     */
    public String getPurpose() {
        return purpose;
    }

    /**
     * purpose을 설정
     * 
     * @param purpose 을(를) String purpose로 설정
     */
    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    /**
     * String summary을 반환
     * 
     * @return String summary
     */
    public String getSummary() {
        return summary;
    }

    /**
     * summary을 설정
     * 
     * @param summary 을(를) String summary로 설정
     */
    public void setSummary(String summary) {
        this.summary = summary;
    }

    /**
     * String bannerYn을 반환
     * 
     * @return String bannerYn
     */
    public String getBannerYn() {
        return bannerYn;
    }

    /**
     * bannerYn을 설정
     * 
     * @param bannerYn 을(를) String bannerYn로 설정
     */
    public void setBannerYn(String bannerYn) {
        this.bannerYn = bannerYn;
    }

    /**
     * String state을 반환
     * 
     * @return String state
     */
    public String getState() {
        return state;
    }

    /**
     * state을 설정
     * 
     * @param state 을(를) String state로 설정
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * String startYn을 반환
     * 
     * @return String startYn
     */
    public String getStartYn() {
        return startYn;
    }

    /**
     * startYn을 설정
     * 
     * @param startYn 을(를) String startYn로 설정
     */
    public void setStartYn(String startYn) {
        this.startYn = startYn;
    }

    /**
     * String endYn을 반환
     * 
     * @return String endYn
     */
    public String getEndYn() {
        return endYn;
    }

    /**
     * endYn을 설정
     * 
     * @param endYn 을(를) String endYn로 설정
     */
    public void setEndYn(String endYn) {
        this.endYn = endYn;
    }

    /**
     * int responseCnt을 반환
     * 
     * @return Integer responseCnt
     */
    public Integer getResponseCnt() {
        return responseCnt;
    }

    /**
     * responseCnt을 설정
     * 
     * @param responseCnt 을(를) Integer responseCnt로 설정
     */
    public void setResponseCnt(Integer responseCnt) {
        this.responseCnt = responseCnt;
    }

    /**
     * int limitCnt을 반환
     * 
     * @return Integer limitCnt
     */
    public Integer getLimitCnt() {
        return limitCnt;
    }

    /**
     * limitCnt을 설정
     * 
     * @param limitCnt 을(를) Integer limitCnt로 설정
     */
    public void setLimitCnt(Integer limitCnt) {
        this.limitCnt = limitCnt;
    }

    /**
     * String dupYn을 반환
     * 
     * @return String dupYn
     */
    public String getDupYn() {
        return dupYn;
    }

    /**
     * dupYn을 설정
     * 
     * @param dupYn 을(를) String dupYn로 설정
     */
    public void setDupYn(String dupYn) {
        this.dupYn = dupYn;
    }

    /**
     * String dupCheck을 반환
     * 
     * @return String dupCheck
     */
    public String getDupCheck() {
        return dupCheck;
    }

    /**
     * dupCheck을 설정
     * 
     * @param dupCheck 을(를) String dupCheck로 설정
     */
    public void setDupCheck(String dupCheck) {
        this.dupCheck = dupCheck;
    }

    /**
     * int readCnt을 반환
     * 
     * @return int readCnt
     */
    public int getReadCnt() {
        return readCnt;
    }

    /**
     * readCnt을 설정
     * 
     * @param readCnt 을(를) int readCnt로 설정
     */
    public void setReadCnt(int readCnt) {
        this.readCnt = readCnt;
    }

    /**
     * int groupCnt을 반환
     * 
     * @return int groupCnt
     */
    public int getGroupCnt() {
        return groupCnt;
    }

    /**
     * groupCnt을 설정
     * 
     * @param groupCnt 을(를) int groupCnt로 설정
     */
    public void setGroupCnt(int groupCnt) {
        this.groupCnt = groupCnt;
    }

    /**
     * String openYn을 반환
     * 
     * @return String openYn
     */
    public String getOpenYn() {
        return openYn;
    }

    /**
     * openYn을 설정
     * 
     * @param openYn 을(를) String openYn로 설정
     */
    public void setOpenYn(String openYn) {
        this.openYn = openYn;
    }

    /**
     * String startTime을 반환
     * 
     * @return String startTime
     */
    public String getStartTime() {
        return startTime;
    }

    /**
     * startTime을 설정
     * 
     * @param startTime 을(를) String startTime로 설정
     */
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /**
     * String endTime을 반환
     * 
     * @return String endTime
     */
    public String getEndTime() {
        return endTime;
    }

    /**
     * endTime을 설정
     * 
     * @param endTime 을(를) String endTime로 설정
     */
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /**
     * String regTime을 반환
     * 
     * @return String regTime
     */
    public String getRegTime() {
        return regTime;
    }

    /**
     * regTime을 설정
     * 
     * @param regTime 을(를) String regTime로 설정
     */
    public void setRegTime(String regTime) {
        this.regTime = regTime;
    }

    /**
     * String modiTime을 반환
     * 
     * @return String modiTime
     */
    public String getModiTime() {
        return modiTime;
    }

    /**
     * modiTime을 설정
     * 
     * @param modiTime 을(를) String modiTime로 설정
     */
    public void setModiTime(String modiTime) {
        this.modiTime = modiTime;
    }

    /**
     * String deptCd을 반환
     * 
     * @return String deptCd
     */
    public String getDeptCd() {
        return deptCd;
    }

    /**
     * deptCd을 설정
     * 
     * @param deptCd 을(를) String deptCd로 설정
     */
    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    /**
     * String regId을 반환
     * 
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * regId을 설정
     * 
     * @param regId 을(를) String regId로 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * String deptNm을 반환
     * 
     * @return String deptNm
     */
    public String getDeptNm() {
        return deptNm;
    }

    /**
     * deptNm을 설정
     * 
     * @param deptNm 을(를) String deptNm로 설정
     */
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    /**
     * String regNm을 반환
     * 
     * @return String regNm
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * regNm을 설정
     * 
     * @param regNm 을(를) String regNm로 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

}
