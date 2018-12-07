/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.intrcn.atibilityegov;

import zes.base.vo.PaggingVO;

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
 *  2014. 10. 31.    이슬버미       신규
 * </pre>
 * @see
 */
public class AtibilityEgovVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -8029374156779380831L;

    /* 호환성확인신청번호 */
    private Integer cmptbCnfirmRegstSeq;
    /* 호환성분석대상명 */
    private String cmptbAnalsTrgetNm;
    /* 호환성분류코드 */
    private Integer cmptbClCd;
    /* 호환성분류이름 */
    private String cmptbClNm;
    /* 사업자명 */
    private String bsnnNm;
    /* 분석신청자명 */
    private String analsApplcntNm;
    /* 신청자전화번호 */
    private String applcntTelno;
    /* 신청자팩스번호 */
    private String applcntFxnum;
    /* 신청자이메일주소 */
    private String applcntEmail;
    /* 분석대상설명 */
    private String analsTrgetDc;
    /* 버전 */
    private String ver;
    /* 분석신청날짜 */
    private String analsReqstDe;
    /* 분석장소우편번호 */
    private String analsPlaceZip;
    /* 분석장소기본주소 */
    private String analsPlaceBassAdres;
    /* 분석장소상세주소 */
    private String analsPlaceDetailAdres;
    /* 신청자 아이디 */
    private String registId;
    /* 호환성점검 항목선택 */
    private String imeCheck;
    /* 호환성점검 항목이름 */
    private String imeRequstCn;
    /* 호환성 상태 */
    private String cmptbStatus;

    /* 아키텍처항목여부 */
    private String archtcIemAt;
    /* 가이드항목여부 */
    private String guideIemAt;
    /* 표준프레임워크항목여부 */
    private String egovFrameIemAt;
    /* 아키텍처항목신청요약 */
    private String archtcImeReqstSumry;
    /* 가이드항목신청요약 */
    private String guideImeReqstSumry;
    /* 표준프레임워크항목요약 */
    private String egovFrameIemSumry;
    /* 호환성확인신청아이디 */
    private String cmptbCnfirmReqstId;
    
    /* 언어코드 */
    private String langCd;

    
    
    
    /**
     * String langCd을 반환
     * @return String langCd
     */
    public String getLangCd() {
        return langCd;
    }

    
    /**
     * langCd을 설정
     * @param langCd 을(를) String langCd로 설정
     */
    public void setLangCd(String langCd) {
        this.langCd = langCd;
    }

    /**
     * String analsApplcntNm을 반환
     * 
     * @return String analsApplcntNm
     */
    public String getAnalsApplcntNm() {
        return analsApplcntNm;
    }

    /**
     * String analsPlaceBassAdres을 반환
     * 
     * @return String analsPlaceBassAdres
     */
    public String getAnalsPlaceBassAdres() {
        return analsPlaceBassAdres;
    }

    /**
     * String analsPlaceDetailAdres을 반환
     * 
     * @return String analsPlaceDetailAdres
     */
    public String getAnalsPlaceDetailAdres() {
        return analsPlaceDetailAdres;
    }

    /**
     * String analsPlaceZip을 반환
     * 
     * @return String analsPlaceZip
     */
    public String getAnalsPlaceZip() {
        return analsPlaceZip;
    }

    /**
     * String analsReqstDe을 반환
     * 
     * @return String analsReqstDe
     */
    public String getAnalsReqstDe() {
        return analsReqstDe;
    }

    /**
     * String analsTrgetDc을 반환
     * 
     * @return String analsTrgetDc
     */
    public String getAnalsTrgetDc() {
        return analsTrgetDc;
    }

    /**
     * String applcntEmail을 반환
     * 
     * @return String applcntEmail
     */
    public String getApplcntEmail() {
        return applcntEmail;
    }

    /**
     * String applcntFxnum을 반환
     * 
     * @return String applcntFxnum
     */
    public String getApplcntFxnum() {
        return applcntFxnum;
    }

    /**
     * String applcntTelno을 반환
     * 
     * @return String applcntTelno
     */
    public String getApplcntTelno() {
        return applcntTelno;
    }

    /**
     * String archtcIemAt을 반환
     * 
     * @return String archtcIemAt
     */
    public String getArchtcIemAt() {
        return archtcIemAt;
    }

    /**
     * String archtcImeReqstSumry을 반환
     * 
     * @return String archtcImeReqstSumry
     */
    public String getArchtcImeReqstSumry() {
        return archtcImeReqstSumry;
    }

    /**
     * String bsnnNm을 반환
     * 
     * @return String bsnnNm
     */
    public String getBsnnNm() {
        return bsnnNm;
    }

    /**
     * String cmptbAnalsTrgetNm을 반환
     * 
     * @return String cmptbAnalsTrgetNm
     */
    public String getCmptbAnalsTrgetNm() {
        return cmptbAnalsTrgetNm;
    }

    /**
     * Integer cmptbClCd을 반환
     * 
     * @return Integer cmptbClCd
     */
    public Integer getCmptbClCd() {
        return cmptbClCd;
    }

    /**
     * Integer cmptbClNm을 반환
     * 
     * @return String cmptbClNm
     */
    public String getCmptbClNm() {
        return cmptbClNm;
    }

    /**
     * Integer cmptbCnfirmRegstSeq을 반환
     * 
     * @return Integer cmptbCnfirmRegstSeq
     */
    public Integer getCmptbCnfirmRegstSeq() {
        return cmptbCnfirmRegstSeq;
    }

    /**
     * String cmptbCnfirmReqstId을 반환
     * 
     * @return String cmptbCnfirmReqstId
     */
    public String getCmptbCnfirmReqstId() {
        return cmptbCnfirmReqstId;
    }

    /**
     * String cmptbStatus을 반환
     * 
     * @return String cmptbStatus
     */
    public String getCmptbStatus() {
        return cmptbStatus;
    }

    /**
     * String egovFrameIemAt을 반환
     * 
     * @return String egovFrameIemAt
     */
    public String getEgovFrameIemAt() {
        return egovFrameIemAt;
    }

    /**
     * String egovFrameIemSumry을 반환
     * 
     * @return String egovFrameIemSumry
     */
    public String getEgovFrameIemSumry() {
        return egovFrameIemSumry;
    }

    /**
     * String guideIemAt을 반환
     * 
     * @return String guideIemAt
     */
    public String getGuideIemAt() {
        return guideIemAt;
    }

    /**
     * String guideImeReqstSumry을 반환
     * 
     * @return String guideImeReqstSumry
     */
    public String getGuideImeReqstSumry() {
        return guideImeReqstSumry;
    }

    /**
     * String imeCheck을 반환
     * 
     * @return String imeCheck
     */
    public String getImeCheck() {
        return imeCheck;
    }

    /**
     * String imeRequstCn을 반환
     * 
     * @return String imeRequstCn
     */
    public String getImeRequstCn() {
        return imeRequstCn;
    }

    /**
     * String registId을 반환
     * 
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    /**
     * String ver을 반환
     * 
     * @return String ver
     */
    public String getVer() {
        return ver;
    }

    /**
     * analsApplcntNm을 설정
     * 
     * @param analsApplcntNm 을(를) String analsApplcntNm로 설정
     */
    public void setAnalsApplcntNm(String analsApplcntNm) {
        this.analsApplcntNm = analsApplcntNm;
    }

    /**
     * analsPlaceBassAdres을 설정
     * 
     * @param analsPlaceBassAdres 을(를) String analsPlaceBassAdres로 설정
     */
    public void setAnalsPlaceBassAdres(String analsPlaceBassAdres) {
        this.analsPlaceBassAdres = analsPlaceBassAdres;
    }

    /**
     * analsPlaceDetailAdres을 설정
     * 
     * @param analsPlaceDetailAdres 을(를) String analsPlaceDetailAdres로 설정
     */
    public void setAnalsPlaceDetailAdres(String analsPlaceDetailAdres) {
        this.analsPlaceDetailAdres = analsPlaceDetailAdres;
    }

    /**
     * analsPlaceZip을 설정
     * 
     * @param analsPlaceZip 을(를) String analsPlaceZip로 설정
     */
    public void setAnalsPlaceZip(String analsPlaceZip) {
        this.analsPlaceZip = analsPlaceZip;
    }

    /**
     * analsReqstDe을 설정
     * 
     * @param analsReqstDe 을(를) String analsReqstDe로 설정
     */
    public void setAnalsReqstDe(String analsReqstDe) {
        this.analsReqstDe = analsReqstDe;
    }

    /**
     * analsTrgetDc을 설정
     * 
     * @param analsTrgetDc 을(를) String analsTrgetDc로 설정
     */
    public void setAnalsTrgetDc(String analsTrgetDc) {
        this.analsTrgetDc = analsTrgetDc;
    }

    /**
     * applcntEmail을 설정
     * 
     * @param applcntEmail 을(를) String applcntEmail로 설정
     */
    public void setApplcntEmail(String applcntEmail) {
        this.applcntEmail = applcntEmail;
    }

    /**
     * applcntFxnum을 설정
     * 
     * @param applcntFxnum 을(를) String applcntFxnum로 설정
     */
    public void setApplcntFxnum(String applcntFxnum) {
        this.applcntFxnum = applcntFxnum;
    }

    /**
     * applcntTelno을 설정
     * 
     * @param applcntTelno 을(를) String applcntTelno로 설정
     */
    public void setApplcntTelno(String applcntTelno) {
        this.applcntTelno = applcntTelno;
    }

    /**
     * archtcIemAt을 설정
     * 
     * @param archtcIemAt 을(를) String archtcIemAt로 설정
     */
    public void setArchtcIemAt(String archtcIemAt) {
        this.archtcIemAt = archtcIemAt;
    }

    /**
     * archtcImeReqstSumry을 설정
     * 
     * @param archtcImeReqstSumry 을(를) String archtcImeReqstSumry로 설정
     */
    public void setArchtcImeReqstSumry(String archtcImeReqstSumry) {
        this.archtcImeReqstSumry = archtcImeReqstSumry;
    }

    /**
     * bsnnNm을 설정
     * 
     * @param bsnnNm 을(를) String bsnnNm로 설정
     */
    public void setBsnnNm(String bsnnNm) {
        this.bsnnNm = bsnnNm;
    }

    /**
     * cmptbAnalsTrgetNm을 설정
     * 
     * @param cmptbAnalsTrgetNm 을(를) String cmptbAnalsTrgetNm로 설정
     */
    public void setCmptbAnalsTrgetNm(String cmptbAnalsTrgetNm) {
        this.cmptbAnalsTrgetNm = cmptbAnalsTrgetNm;
    }

    /**
     * cmptbClCd을 설정
     * 
     * @param cmptbClCd 을(를) Integer cmptbClCd로 설정
     */
    public void setCmptbClCd(Integer cmptbClCd) {
        this.cmptbClCd = cmptbClCd;
    }

    /**
     * cmptbClNm을 설정
     * 
     * @param cmptbClNm 을(를) String cmptbClNm로 설정
     */
    public void setCmptbClNm(String cmptbClNm) {
        this.cmptbClNm = cmptbClNm;
    }

    /**
     * cmptbCnfirmRegstNo을 설정
     * 
     * @param cmptbCnfirmRegstNo 을(를) Integer cmptbCnfirmRegstNo로 설정
     */
    public void setCmptbCnfirmRegstSeq(Integer cmptbCnfirmRegstSeq) {
        this.cmptbCnfirmRegstSeq = cmptbCnfirmRegstSeq;
    }

    /**
     * cmptbCnfirmReqstId을 설정
     * 
     * @param cmptbCnfirmReqstId 을(를) String cmptbCnfirmReqstId로 설정
     */
    public void setCmptbCnfirmReqstId(String cmptbCnfirmReqstId) {
        this.cmptbCnfirmReqstId = cmptbCnfirmReqstId;
    }

    /**
     * cmptbStatus을 설정
     * 
     * @param cmptbStatus 을(를) String cmptbStatus로 설정
     */
    public void setCmptbStatus(String cmptbStatus) {
        this.cmptbStatus = cmptbStatus;
    }

    /**
     * egovFrameIemAt을 설정
     * 
     * @param egovFrameIemAt 을(를) String egovFrameIemAt로 설정
     */
    public void setEgovFrameIemAt(String egovFrameIemAt) {
        this.egovFrameIemAt = egovFrameIemAt;
    }

    /**
     * egovFrameIemSumry을 설정
     * 
     * @param egovFrameIemSumry 을(를) String egovFrameIemSumry로 설정
     */
    public void setEgovFrameIemSumry(String egovFrameIemSumry) {
        this.egovFrameIemSumry = egovFrameIemSumry;
    }

    /**
     * guideIemAt을 설정
     * 
     * @param guideIemAt 을(를) String guideIemAt로 설정
     */
    public void setGuideIemAt(String guideIemAt) {
        this.guideIemAt = guideIemAt;
    }

    /**
     * guideImeReqstSumry을 설정
     * 
     * @param guideImeReqstSumry 을(를) String guideImeReqstSumry로 설정
     */
    public void setGuideImeReqstSumry(String guideImeReqstSumry) {
        this.guideImeReqstSumry = guideImeReqstSumry;
    }

    /**
     * imeCheck을 설정
     * 
     * @param imeCheck 을(를) String imeCheck로 설정
     */
    public void setImeCheck(String imeCheck) {
        this.imeCheck = imeCheck;
    }

    /**
     * imeRequstCn을 설정
     * 
     * @param imeRequstCn 을(를) String imeRequstCn로 설정
     */
    public void setImeRequstCn(String imeRequstCn) {
        this.imeRequstCn = imeRequstCn;
    }

    /**
     * registId을 설정
     * 
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /**
     * ver을 설정
     * 
     * @param ver 을(를) String ver로 설정
     */
    public void setVer(String ver) {
        this.ver = ver;
    }

}
