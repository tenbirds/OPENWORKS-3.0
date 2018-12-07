/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.suppost.qna;

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
 *  2014. 11. 14.    이슬버미       신규
 * </pre>
 * @see
 */
public class WebGoodsQnAVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -6594036688160149838L;

    /** 판매자아이디 */
    private String userId;
    /** 등록자아이디 */
    private String registId;
    /** 서비스명 */
    private String goodsNm;
    /** 언어코드 */
    private String langCode;
    /** 언어명 */
    private String langNm;
    /** 서비스코드 */
    private String goodsCode;
    /** 문의 일련번호 */
    private Integer goodsInqryNo;
    /** 문의제목 */
    private String inqrySj;
    /** 문의자 아이디 */
    private String inqrId;
    /** 문의자 명 */
    private String inqrNm;
    /** 카테고리 이름 */
    private String ctgryClNm;
    /** 문의일자 */
    private String inqryDt;
    /** 답변일자 */
    private String answerDt;
    /** 비밀글 */
    private String othbcAt;
    /** 문의상태 */
    private String answerSttusCd;
    /** 답변 이메일 */
    private String answerRecptnEmail;
    /** 답변 내용 */
    private String inqryAnswerCn;
    /** 문의 내용 */
    private String inqryCn;
    /** 담당자명 */
    private String goodsChargerNm;
    /** 담당자 이메일 */
    private String goodsChargerEmail;
    /** 담당자 연락처 */
    private String goodsChargerCttpc;

    /* 언어코드 */
    private String langCd;
    
    /**
     * String userId을 반환
     * 
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * userId을 설정
     * 
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
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
     * registId을 설정
     * 
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /**
     * String goodsNm을 반환
     * 
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }

    /**
     * goodsNm을 설정
     * 
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    /**
     * String langCode을 반환
     * 
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    /**
     * langCode을 설정
     * 
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    /**
     * String langNm을 반환
     * 
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    /**
     * langNm을 설정
     * 
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    /**
     * String goodsCode을 반환
     * 
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }

    /**
     * goodsCode을 설정
     * 
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    /**
     * Integer goodsInqryNo을 반환
     * 
     * @return Integer goodsInqryNo
     */
    public Integer getGoodsInqryNo() {
        return goodsInqryNo;
    }

    /**
     * goodsInqryNo을 설정
     * 
     * @param goodsInqryNo 을(를) Integer goodsInqryNo로 설정
     */
    public void setGoodsInqryNo(Integer goodsInqryNo) {
        this.goodsInqryNo = goodsInqryNo;
    }

    /**
     * String inqrySj을 반환
     * 
     * @return String inqrySj
     */
    public String getInqrySj() {
        return inqrySj;
    }

    /**
     * inqrySj을 설정
     * 
     * @param inqrySj 을(를) String inqrySj로 설정
     */
    public void setInqrySj(String inqrySj) {
        this.inqrySj = inqrySj;
    }

    /**
     * String inqrId을 반환
     * 
     * @return String inqrId
     */
    public String getInqrId() {
        return inqrId;
    }

    /**
     * inqrId을 설정
     * 
     * @param inqrId 을(를) String inqrId로 설정
     */
    public void setInqrId(String inqrId) {
        this.inqrId = inqrId;
    }

    /**
     * String inqrNm을 반환
     * 
     * @return String inqrNm
     */
    public String getInqrNm() {
        return inqrNm;
    }

    /**
     * inqrNm을 설정
     * 
     * @param inqrNm 을(를) String inqrNm로 설정
     */
    public void setInqrNm(String inqrNm) {
        this.inqrNm = inqrNm;
    }

    /**
     * String ctgryClNm을 반환
     * 
     * @return String ctgryClNm
     */
    public String getCtgryClNm() {
        return ctgryClNm;
    }

    /**
     * ctgryClNm을 설정
     * 
     * @param ctgryClNm 을(를) String ctgryClNm로 설정
     */
    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }

    /**
     * String inqryDt을 반환
     * 
     * @return String inqryDt
     */
    public String getInqryDt() {
        return inqryDt;
    }

    /**
     * inqryDt을 설정
     * 
     * @param inqryDt 을(를) String inqryDt로 설정
     */
    public void setInqryDt(String inqryDt) {
        this.inqryDt = inqryDt;
    }

    /**
     * String answerDt을 반환
     * 
     * @return String answerDt
     */
    public String getAnswerDt() {
        return answerDt;
    }

    /**
     * answerDt을 설정
     * 
     * @param answerDt 을(를) String answerDt로 설정
     */
    public void setAnswerDt(String answerDt) {
        this.answerDt = answerDt;
    }

    /**
     * String othbcAt을 반환
     * 
     * @return String othbcAt
     */
    public String getOthbcAt() {
        return othbcAt;
    }

    /**
     * othbcAt을 설정
     * 
     * @param othbcAt 을(를) String othbcAt로 설정
     */
    public void setOthbcAt(String othbcAt) {
        this.othbcAt = othbcAt;
    }

    /**
     * String answerSttusCd을 반환
     * 
     * @return String answerSttusCd
     */
    public String getAnswerSttusCd() {
        return answerSttusCd;
    }

    /**
     * answerSttusCd을 설정
     * 
     * @param answerSttusCd 을(를) String answerSttusCd로 설정
     */
    public void setAnswerSttusCd(String answerSttusCd) {
        this.answerSttusCd = answerSttusCd;
    }

    /**
     * String answerRecptnEmail을 반환
     * 
     * @return String answerRecptnEmail
     */
    public String getAnswerRecptnEmail() {
        return answerRecptnEmail;
    }

    /**
     * answerRecptnEmail을 설정
     * 
     * @param answerRecptnEmail 을(를) String answerRecptnEmail로 설정
     */
    public void setAnswerRecptnEmail(String answerRecptnEmail) {
        this.answerRecptnEmail = answerRecptnEmail;
    }

    /**
     * String inqryAnswerCn을 반환
     * 
     * @return String inqryAnswerCn
     */
    public String getInqryAnswerCn() {
        return inqryAnswerCn;
    }

    /**
     * inqryAnswerCn을 설정
     * 
     * @param inqryAnswerCn 을(를) String inqryAnswerCn로 설정
     */
    public void setInqryAnswerCn(String inqryAnswerCn) {
        this.inqryAnswerCn = inqryAnswerCn;
    }

    /**
     * String inqryCn을 반환
     * 
     * @return String inqryCn
     */
    public String getInqryCn() {
        return inqryCn;
    }

    /**
     * inqryCn을 설정
     * 
     * @param inqryCn 을(를) String inqryCn로 설정
     */
    public void setInqryCn(String inqryCn) {
        this.inqryCn = inqryCn;
    }

    /**
     * String goodsChargerNm을 반환
     * 
     * @return String goodsChargerNm
     */
    public String getGoodsChargerNm() {
        return goodsChargerNm;
    }

    /**
     * goodsChargerNm을 설정
     * 
     * @param goodsChargerNm 을(를) String goodsChargerNm로 설정
     */
    public void setGoodsChargerNm(String goodsChargerNm) {
        this.goodsChargerNm = goodsChargerNm;
    }

    /**
     * String goodsChargerEmail을 반환
     * 
     * @return String goodsChargerEmail
     */
    public String getGoodsChargerEmail() {
        return goodsChargerEmail;
    }

    /**
     * goodsChargerEmail을 설정
     * 
     * @param goodsChargerEmail 을(를) String goodsChargerEmail로 설정
     */
    public void setGoodsChargerEmail(String goodsChargerEmail) {
        this.goodsChargerEmail = goodsChargerEmail;
    }

    /**
     * String goodsChargerCttpc을 반환
     * 
     * @return String goodsChargerCttpc
     */
    public String getGoodsChargerCttpc() {
        return goodsChargerCttpc;
    }

    /**
     * goodsChargerCttpc을 설정
     * 
     * @param goodsChargerCttpc 을(를) String goodsChargerCttpc로 설정
     */
    public void setGoodsChargerCttpc(String goodsChargerCttpc) {
        this.goodsChargerCttpc = goodsChargerCttpc;
    }

    
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

    
    
}
