/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.poll;

import zes.base.vo.PaggingVO;

/**
 * <pre>
 * 설문 기본 정보 BEAN
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 11.
 * @version $Id: WebPollVO.java 2010. 3. 11. yesno $
 */
public class WebPollVO extends PaggingVO {

    private static final long serialVersionUID = -6062915207374506664L;

    /** 일련번호 */
    private Integer seq;
    /** 도메인 코드 */
    private Integer domainCd;
    /** 제목 */
    private String title;
    /** 의도(취지) */
    private String purpose;
    /** 요약 */
    private String summary;
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
    /** 중복응답 체크 결과 Y/N */
    private String validCheck;
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
    /** 회원여부 */
    private String userYn;

    /**
     * @return Integer seq 값을 반환
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * @param seq
     *        값으로 Integer seq 값을 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * @return Integer domainCd 값을 반환
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * @param domainCd
     *        값으로 Integer domainCd 값을 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * @return String title 값을 반환
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title
     *        값으로 String title 값을 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return String purpose 값을 반환
     */
    public String getPurpose() {
        return purpose;
    }

    /**
     * @param purpose
     *        값으로 String purpose 값을 설정
     */
    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    /**
     * @return String summary 값을 반환
     */
    public String getSummary() {
        return summary;
    }

    /**
     * @param summary
     *        값으로 String summary 값을 설정
     */
    public void setSummary(String summary) {
        this.summary = summary;
    }

    /**
     * @return String state 값을 반환
     */
    public String getState() {
        return state;
    }

    /**
     * @param state
     *        값으로 String state 값을 설정
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * @return String startYn 값을 반환
     */
    public String getStartYn() {
        return startYn;
    }

    /**
     * @param startYn
     *        값으로 String startYn 값을 설정
     */
    public void setStartYn(String startYn) {
        this.startYn = startYn;
    }

    /**
     * @return String endYn 값을 반환
     */
    public String getEndYn() {
        return endYn;
    }

    /**
     * @param endYn
     *        값으로 String endYn 값을 설정
     */
    public void setEndYn(String endYn) {
        this.endYn = endYn;
    }

    /**
     * @return Integer responseCnt 값을 반환
     */
    public Integer getResponseCnt() {
        return responseCnt;
    }

    /**
     * @param responseCnt
     *        값으로 Integer responseCnt 값을 설정
     */
    public void setResponseCnt(Integer responseCnt) {
        this.responseCnt = responseCnt;
    }

    /**
     * @return Integer limitCnt 값을 반환
     */
    public Integer getLimitCnt() {
        return limitCnt;
    }

    /**
     * @param limitCnt
     *        값으로 Integer limitCnt 값을 설정
     */
    public void setLimitCnt(Integer limitCnt) {
        this.limitCnt = limitCnt;
    }

    /**
     * @return String dupYn 값을 반환
     */
    public String getDupYn() {
        return dupYn;
    }

    /**
     * @param dupYn
     *        값으로 String dupYn 값을 설정
     */
    public void setDupYn(String dupYn) {
        this.dupYn = dupYn;
    }

    /**
     * @return String dupCheck 값을 반환
     */
    public String getDupCheck() {
        return dupCheck;
    }

    /**
     * @param dupCheck
     *        값으로 String dupCheck 값을 설정
     */
    public void setDupCheck(String dupCheck) {
        this.dupCheck = dupCheck;
    }

    /**
     * @return String validCheck 값을 반환
     */
    public String getValidCheck() {
        return validCheck;
    }

    /**
     * @param validCheck
     *        값으로 String validCheck 값을 설정
     */
    public void setValidCheck(String validCheck) {
        this.validCheck = validCheck;
    }

    /**
     * @return int readCnt 값을 반환
     */
    public int getReadCnt() {
        return readCnt;
    }

    /**
     * @param readCnt
     *        값으로 int readCnt 값을 설정
     */
    public void setReadCnt(int readCnt) {
        this.readCnt = readCnt;
    }

    /**
     * @return int groupCnt 값을 반환
     */
    public int getGroupCnt() {
        return groupCnt;
    }

    /**
     * @param groupCnt
     *        값으로 int groupCnt 값을 설정
     */
    public void setGroupCnt(int groupCnt) {
        this.groupCnt = groupCnt;
    }

    /**
     * @return String openYn 값을 반환
     */
    public String getOpenYn() {
        return openYn;
    }

    /**
     * @param openYn
     *        값으로 String openYn 값을 설정
     */
    public void setOpenYn(String openYn) {
        this.openYn = openYn;
    }

    /**
     * @return String startTime 값을 반환
     */
    public String getStartTime() {
        return startTime;
    }

    /**
     * @param startTime
     *        값으로 String startTime 값을 설정
     */
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /**
     * @return String endTime 값을 반환
     */
    public String getEndTime() {
        return endTime;
    }

    /**
     * @param endTime
     *        값으로 String endTime 값을 설정
     */
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /**
     * @return String regTime 값을 반환
     */
    public String getRegTime() {
        return regTime;
    }

    /**
     * @param regTime
     *        값으로 String regTime 값을 설정
     */
    public void setRegTime(String regTime) {
        this.regTime = regTime;
    }

    /**
     * @return String modiTime 값을 반환
     */
    public String getModiTime() {
        return modiTime;
    }

    /**
     * @param modiTime
     *        값으로 String modiTime 값을 설정
     */
    public void setModiTime(String modiTime) {
        this.modiTime = modiTime;
    }

    /**
     * @return String deptCd 값을 반환
     */
    public String getDeptCd() {
        return deptCd;
    }

    /**
     * @param deptCd
     *        값으로 String deptCd 값을 설정
     */
    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    /**
     * @return String regId 값을 반환
     */
    public String getRegId() {
        return regId;
    }

    /**
     * @param regId
     *        값으로 String regId 값을 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * @return String deptNm 값을 반환
     */
    public String getDeptNm() {
        return deptNm;
    }

    /**
     * @param deptNm
     *        값으로 String deptNm 값을 설정
     */
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    /**
     * @return String regNm 값을 반환
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * @param regNm
     *        값으로 String regNm 값을 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

    /**
     * String userYn을 반환
     * 
     * @return String userYn
     */
    public String getUserYn() {
        return userYn;
    }

    /**
     * userYn을 설정
     * 
     * @param userYn 을(를) String userYn로 설정
     */
    public void setUserYn(String userYn) {
        this.userYn = userYn;
    }

}
