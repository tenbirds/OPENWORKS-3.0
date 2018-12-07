/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

/**
 * 게시판 컨버터옵션 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 * 	수정일			수정자				수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 25.	      손재숙	JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardConvertOptionVO extends BoardVO {

    static final long serialVersionUID = 9196639835280708011L;

    /** 모두 표시 */
    private String showAll = "N";
    /** 공지게시글사용가부 */
    private String noticeBbscttUseYn = "N";
    /** 카테고리 사용 */
    private String ctgCdYn = "N";
    /** 제목 사용 */
    private String bbscttSjYn = "N";
    /** 요약 사용 */
    private String cnSumryYn = "N";
    /** 등록일 사용 */
    private String registDtYn = "N";
    /** 수정일 사용 */
    private String updtDtYn = "N";
    /** 작성자이름 사용 */
    private String registerNmYn = "N";
    /** 매니저ID 사용 */
    private String mngrIdYn = "N";
    /** 유저ID 사용 */
    private String userKeyYn = "N";
    /** 조회수 사용 */
    private String rdcntYn = "N";
    /** 신고수 사용 */
    private String accuseCntYn = "N";
    /** 추천수 사용 */
    private String recomendCntYn = "N";

    /** 최대 결과갯수 */
    private Integer maxResult = 0;

    public String getShowAll() {
        return showAll;
    }

    public void setShowAll(String showAll) {
        this.showAll = showAll;
    }

    public String getNoticeBbscttUseYn() {
        return noticeBbscttUseYn;
    }

    public void setNoticeBbscttUseYn(String noticeBbscttUseYn) {
        this.noticeBbscttUseYn = noticeBbscttUseYn;
    }

    public String getCtgCdYn() {
        return ctgCdYn;
    }

    public void setCtgCdYn(String ctgCdYn) {
        this.ctgCdYn = ctgCdYn;
    }

    public String getBbscttSjYn() {
        return bbscttSjYn;
    }

    public void setBbscttSjYn(String bbscttSjYn) {
        this.bbscttSjYn = bbscttSjYn;
    }

    public String getCnSumryYn() {
        return cnSumryYn;
    }

    public void setCnSumryYn(String cnSumryYn) {
        this.cnSumryYn = cnSumryYn;
    }

    public String getRegistDtYn() {
        return registDtYn;
    }

    public void setRegistDtYn(String registDtYn) {
        this.registDtYn = registDtYn;
    }

    public String getUpdtDtYn() {
        return updtDtYn;
    }

    public void setUpdtDtYn(String updtDtYn) {
        this.updtDtYn = updtDtYn;
    }

    public String getRegisterNmYn() {
        return registerNmYn;
    }

    public void setRegNmYn(String registerNmYn) {
        this.registerNmYn = registerNmYn;
    }

    public String getMngrIdYn() {
        return mngrIdYn;
    }

    public void setMngrIdYn(String mngrIdYn) {
        this.mngrIdYn = mngrIdYn;
    }

    public String getUserKeyYn() {
        return userKeyYn;
    }

    public void setUserKeyYn(String userKeyYn) {
        this.userKeyYn = userKeyYn;
    }

    public String getRdcntYn() {
        return rdcntYn;
    }

    public void setRdcntYn(String rdcntYn) {
        this.rdcntYn = rdcntYn;
    }

    public String getAccuseCntYn() {
        return accuseCntYn;
    }

    public void setAccuseCntYn(String accuseCntYn) {
        this.accuseCntYn = accuseCntYn;
    }

    public String getRecomendCntYn() {
        return recomendCntYn;
    }

    public void setRecomendCntYn(String recomendCntYn) {
        this.recomendCntYn = recomendCntYn;
    }

    public Integer getMaxResult() {
        return maxResult;
    }

    public void setMaxResult(Integer maxResult) {
        this.maxResult = maxResult;
    }
}
