/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.satisfy;

import zes.base.pager.Pager;
import zes.base.vo.PaggingVO;

/**
 * 만족도 관리 VO 객체
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
 *  2012. 6. 22.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class SatisfyVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 5683886657385554691L;

    /** 사이트코드 */
    private Integer domainCd;
    /** 사이트명 */
    private String domainNm;
    /** 메뉴코드 */
    private String menuCode;
    /** 메뉴명 */
    private String menuNm;
    
    /** 등록일 */
    private String regD;
    /** 전체포인트 */
    private Integer totalPoint;
    /** 전체응답자수 */
    private Integer totalReplyCnt;
    /** 만족도번호 */
    private Integer itemNo;
    /** 일련번호 */
    private Integer seqNo;
    /** 코멘트 */
    private String comments;
    /** 등록자ID */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록자IP */
    private String regIp;
    /** 등록일시 */
    private String regDt;
    /** 평점수 */
    private Integer scoreCnt = 0;
    /** 평점합 */
    private Integer scoreSum = 0;
    /** 만족도 상세리스트 */
    private Pager<SatisfyVO> satisfyDetlList;

    /** 검색시작 일자 */
    private String startDt;
    /** 검색종료 일자 */
    private String endDt;

    /** 새로 추가된 메뉴명 */
    private String userMenuNm;
    /**
     * 사용자 만족도 점수(사용자 화면 표시용)
     * 
     * @return
     */
    public String getScoreAvg() {
        if(this.scoreCnt == 0) {
            return "[0.0점 /0몇 참여]";
        } else {
            Float avg = Float.valueOf(this.scoreSum) / Float.valueOf(this.scoreCnt);
            return "[평균 " + String.format("%.1f", avg) + "점 /" + this.scoreCnt + "명 참여]";
        }
    }

    public void setScoreAvg(String scoreAvg) {
    }

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
     * String menuCode을 반환
     * 
     * @return String menuCode
     */
    public String getMenuCode() {
        return menuCode;
    }

    /**
     * menuCode을 설정
     * 
     * @param menuCode 을(를) String menuCode로 설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    /**
     * String menuNm을 반환
     * 
     * @return String menuNm
     */
    public String getMenuNm() {
        return menuNm;
    }

    /**
     * menuNm을 설정
     * 
     * @param menuNm 을(를) String menuNm로 설정
     */
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    /**
     * String regD을 반환
     * 
     * @return String regD
     */
    public String getRegD() {
        return regD;
    }

    /**
     * regD을 설정
     * 
     * @param regD 을(를) String regD로 설정
     */
    public void setRegD(String regD) {
        this.regD = regD;
    }

    /**
     * Integer totalPoint을 반환
     * 
     * @return Integer totalPoint
     */
    public Integer getTotalPoint() {
        return totalPoint;
    }

    /**
     * totalPoint을 설정
     * 
     * @param totalPoint 을(를) Integer totalPoint로 설정
     */
    public void setTotalPoint(Integer totalPoint) {
        this.totalPoint = totalPoint;
    }

    /**
     * Integer totalReplyCnt을 반환
     * 
     * @return Integer totalReplyCnt
     */
    public Integer getTotalReplyCnt() {
        return totalReplyCnt;
    }

    /**
     * totalReplyCnt을 설정
     * 
     * @param totalReplyCnt 을(를) Integer totalReplyCnt로 설정
     */
    public void setTotalReplyCnt(Integer totalReplyCnt) {
        this.totalReplyCnt = totalReplyCnt;
    }

    /**
     * Integer itemNo을 반환
     * 
     * @return Integer itemNo
     */
    public Integer getItemNo() {
        return itemNo;
    }

    /**
     * itemNo을 설정
     * 
     * @param itemNo 을(를) Integer itemNo로 설정
     */
    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    /**
     * Integer seqNo을 반환
     * 
     * @return Integer seqNo
     */
    public Integer getSeqNo() {
        return seqNo;
    }

    /**
     * seqNo을 설정
     * 
     * @param seqNo 을(를) Integer seqNo로 설정
     */
    public void setSeqNo(Integer seqNo) {
        this.seqNo = seqNo;
    }

    /**
     * String comments을 반환
     * 
     * @return String comments
     */
    public String getComments() {
        return comments;
    }

    /**
     * comments을 설정
     * 
     * @param comments 을(를) String comments로 설정
     */
    public void setComments(String comments) {
        this.comments = comments;
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

    /**
     * String regIp을 반환
     * 
     * @return String regIp
     */
    public String getRegIp() {
        return regIp;
    }

    /**
     * regIp을 설정
     * 
     * @param regIp 을(를) String regIp로 설정
     */
    public void setRegIp(String regIp) {
        this.regIp = regIp;
    }

    /**
     * String regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * regDt을 설정
     * 
     * @param regDt 을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    /**
     * Pager satisfyDetlList을 반환
     * 
     * @return Pager satisfyDetlList
     */
    public Pager<SatisfyVO> getSatisfyDetlList() {
        return satisfyDetlList;
    }

    /**
     * satisfyDetlList을 설정
     * 
     * @param satisfyDetlList 을(를) Pager satisfyDetlList로 설정
     */
    public void setSatisfyDetlList(Pager<SatisfyVO> satisfyDetlList) {
        this.satisfyDetlList = satisfyDetlList;
    }

    /**
     * String startDt을 반환
     * 
     * @return String startDt
     */
    public String getStartDt() {
        return startDt;
    }

    /**
     * startDt을 설정
     * 
     * @param startDt 을(를) String startDt로 설정
     */
    public void setStartDt(String startDt) {
        this.startDt = startDt;
    }

    /**
     * String endDt을 반환
     * 
     * @return String endDt
     */
    public String getEndDt() {
        return endDt;
    }

    /**
     * endDt을 설정
     * 
     * @param endDt 을(를) String endDt로 설정
     */
    public void setEndDt(String endDt) {
        this.endDt = endDt;
    }

    
    /**
     * String userMenuNm을 반환
     * @return String userMenuNm
     */
    public String getUserMenuNm() {
        return userMenuNm;
    }

    
    /**
     * userMenuNm을 설정
     * @param userMenuNm 을(를) String userMenuNm로 설정
     */
    public void setUserMenuNm(String userMenuNm) {
        this.userMenuNm = userMenuNm;
    }

}
