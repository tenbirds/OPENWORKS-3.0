/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import zes.base.vo.BaseVO;

/**
 * 게시판 관리 사용여부 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *   수정일			수정자					수정내용
 * --------------  --------  ---------------------------------
 *  2012. 4. 25.	손재숙	 JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardConfYnVO extends BaseVO {

    private static final long serialVersionUID = 2888889154549584749L;

    /** 도메인 코드 */
    private Integer domainCd = 0;
    /** 게시판 코드 */
    private Integer bbsCd = 0;
    /** 사용여부 */
    private String useYn;
    /** 수정일 */
    private String updtDt;

    /** 게시판 설정 구분 코드 */
    private Integer gubunCd = 0;

    /*
     * -----------------------------------------------------------
     * GLOBAL
     */
    
    /** 분류 가부 */
    private String ctgYn;
    /** 공지게시글사용가부 */
    private String noticeBbscttUseYn; 
    /** 댓글사용 가부 */
    private String cmtYn;
    
    
    /** FEED 제공여부 */
    private String feedYn;

    /*
     * -----------------------------------------------------------
     * LIST
     */
    /** 다운로드 사용여부 */
    private String dwldYn;

    /*
     * -----------------------------------------------------------
     * FORM
     */
    /** 관리자단 에디터 사용여부 */
    private String mngrEditorYn;
    /** 사용자단 에디터 사용여부 */
    private String userEditorYn;
    /** 첨부파일 사용여부 */
    private String fileYn;
    /** 금칙어 사용여부 */
    private String bannedWordYn;
    /** 태그사용여부 */
    private String tagYn = "N";
    /** CAPTCHAR 사용여부 */
    private String captchaYn;
    /** 공개 여부 */
    private String othbcYn;
    /*
     * -----------------------------------------------------------
     * VIEW
     */
    /** 추천 사용여부 */
    private String recomendYn;
    /** 신고 사용여부 */
    private String accuseYn;

    /** 만족도 사용여부 */
    private String stsfdgYn;


    
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

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public Integer getGubunCd() {
        return gubunCd;
    }

    public void setGubunCd(Integer gubunCd) {
        this.gubunCd = gubunCd;
    }

    public String getCtgYn() {
        return ctgYn;
    }

    public void setCtgYn(String ctgYn) {
        this.ctgYn = ctgYn;
    }

    public String getNoticeBbscttUseYn() {
        return noticeBbscttUseYn;
    }

    public void setNoticeBbscttUseYn(String noticeBbscttUseYn) {
        this.noticeBbscttUseYn = noticeBbscttUseYn;
    }

    public String getCmtYn() {
        return cmtYn;
    }

    public void setCmtYn(String cmtYn) {
        this.cmtYn = cmtYn;
    }

    public String getFeedYn() {
        return feedYn;
    }

    public void setFeedYn(String feedYn) {
        this.feedYn = feedYn;
    }

    public String getDwldYn() {
        return dwldYn;
    }

    public void setDwldYn(String dwldYn) {
        this.dwldYn = dwldYn;
    }

    public String getMngrEditorYn() {
        return mngrEditorYn;
    }

    public void setMngrEditorYn(String mngrEditorYn) {
        this.mngrEditorYn = mngrEditorYn;
    }

    public String getUserEditorYn() {
        return userEditorYn;
    }

    public void setUserEditorYn(String userEditorYn) {
        this.userEditorYn = userEditorYn;
    }

    public String getFileYn() {
        return fileYn;
    }

    public void setFileYn(String fileYn) {
        this.fileYn = fileYn;
    }

    public String getBannedWordYn() {
        return bannedWordYn;
    }

    public void setBannedWordYn(String bannedWordYn) {
        this.bannedWordYn = bannedWordYn;
    }

    public String getTagYn() {
        return tagYn;
    }

    public void setTagYn(String tagYn) {
        this.tagYn = tagYn;
    }

    public String getCaptchaYn() {
        return captchaYn;
    }

    public void setCaptchaYn(String captchaYn) {
        this.captchaYn = captchaYn;
    }

    public String getOthbcYn() {
        return othbcYn;
    }

    public void setOthbcYn(String othbcYn) {
        this.othbcYn = othbcYn;
    }

    public String getRecomendYn() {
        return recomendYn;
    }

    public void setRecomendYn(String recomendYn) {
        this.recomendYn = recomendYn;
    }

    public String getAccuseYn() {
        return accuseYn;
    }

    public void setAccuseYn(String accuseYn) {
        this.accuseYn = accuseYn;
    }

    public String getStsfdgYn() {
        return stsfdgYn;
    }

    public void setStsfdgYn(String stsfdgYn) {
        this.stsfdgYn = stsfdgYn;
    }


}
