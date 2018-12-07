/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.goods.qna;

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
 *  2014. 11. 25.    이슬버미       신규
 * </pre>
 * @see
 */
public class GoodsQnAVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 3397714501401033736L;

    /** 판매자아이디 */
    private String userId;
    /** 판매자이름 */
    private String userNm;
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
    /** 문의 일련번호 들 */
    private String[] goodsInqryNos;
    /** 문의제목 */
    private String inqrySj;
    /** 문의자 아이디 */
    private String inqrId;
    /** 문의자 명 */
    private String inqrNm;
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

    /** 서비스구분코드 */
    private String goodsTyCd;
    /** 서비스구분이름 */
    private String goodsTyNm;
    /** 카테고리코드 */
    private String ctgryCd;
    /** 카테고리 이름 */
    private String ctgryNm;
    /** 카테고리 부서코드 */
    private String parntsCtgryCd;
    /** 카테고리 깊이코드 */
    private String ctgryDp;
    /** 카테고리구분코드 */
    private String ctgryClCd;
    /** 카테고리구분이름 */
    private String ctgryClNm;
    /** 스토어명 */
    private String langStoreNm;

    /* 신고여부코드 */
    private String accuseAtCd;
    /* 신고사유코드 */
    private String accuseResnCd;
    /* 신고사유기타내용 */
    private String accuseResnEtcCn;
    
    private String inqryAccuseResnCd; 
    private String answerAccuseResnCd;
    private String inqryAccuseResnNm; 
    private String answerAccuseResnNm;
    private String inqryAccuseEtcCn; 
    private String answerAccuseEtcCn;    
    
    /* 문의신고자아이디 */
    private String inqryAplcntId;
    private String inqryAplcntNm;
    /* 답변신고자아이디 */
    private String answerAplcntId;
    private String answerAplcntNm;
    /* 문의수정일시 */
    private String inqryUpdateDt;
    /* 답변수정일시 */
    private String answerUpdateDt;
    /* 신고일시 */
    private String accuseDt;
    
    /**
     * String[] goodsInqryNos을 반환
     * 
     * @return String[] goodsInqryNos
     */
    public String[] getGoodsInqryNos() {
        return goodsInqryNos;
    }

    /**
     * goodsInqryNos을 설정
     * 
     * @param goodsInqryNos 을(를) String[] goodsInqryNos로 설정
     */
    public void setGoodsInqryNos(String[] goodsInqryNos) {
        this.goodsInqryNos = goodsInqryNos;
    }

    /**
     * String userNm을 반환
     * 
     * @return String userNm
     */
    public String getUserNm() {
        return userNm;
    }

    /**
     * userNm을 설정
     * 
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

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
     * String goodsTyCd을 반환
     * 
     * @return String goodsTyCd
     */
    public String getGoodsTyCd() {
        return goodsTyCd;
    }

    /**
     * goodsTyCd을 설정
     * 
     * @param goodsTyCd 을(를) String goodsTyCd로 설정
     */
    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    /**
     * String goodsTyNm을 반환
     * 
     * @return String goodsTyNm
     */
    public String getGoodsTyNm() {
        return goodsTyNm;
    }

    /**
     * goodsTyNm을 설정
     * 
     * @param goodsTyNm 을(를) String goodsTyNm로 설정
     */
    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }

    /**
     * String ctgryCd을 반환
     * 
     * @return String ctgryCd
     */
    public String getCtgryCd() {
        return ctgryCd;
    }

    /**
     * ctgryCd을 설정
     * 
     * @param ctgryCd 을(를) String ctgryCd로 설정
     */
    public void setCtgryCd(String ctgryCd) {
        this.ctgryCd = ctgryCd;
    }

    /**
     * String ctgryNm을 반환
     * 
     * @return String ctgryNm
     */
    public String getCtgryNm() {
        return ctgryNm;
    }

    /**
     * ctgryNm을 설정
     * 
     * @param ctgryNm 을(를) String ctgryNm로 설정
     */
    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }

    /**
     * String parntsCtgryCd을 반환
     * 
     * @return String parntsCtgryCd
     */
    public String getParntsCtgryCd() {
        return parntsCtgryCd;
    }

    /**
     * parntsCtgryCd을 설정
     * 
     * @param parntsCtgryCd 을(를) String parntsCtgryCd로 설정
     */
    public void setParntsCtgryCd(String parntsCtgryCd) {
        this.parntsCtgryCd = parntsCtgryCd;
    }

    /**
     * String ctgryDp을 반환
     * 
     * @return String ctgryDp
     */
    public String getCtgryDp() {
        return ctgryDp;
    }

    /**
     * ctgryDp을 설정
     * 
     * @param ctgryDp 을(를) String ctgryDp로 설정
     */
    public void setCtgryDp(String ctgryDp) {
        this.ctgryDp = ctgryDp;
    }

    /**
     * String ctgryClCd을 반환
     * 
     * @return String ctgryClCd
     */
    public String getCtgryClCd() {
        return ctgryClCd;
    }

    /**
     * ctgryClCd을 설정
     * 
     * @param ctgryClCd 을(를) String ctgryClCd로 설정
     */
    public void setCtgryClCd(String ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
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
     * String langStoreNm을 반환
     * 
     * @return String langStoreNm
     */
    public String getLangStoreNm() {
        return langStoreNm;
    }

    /**
     * langStoreNm을 설정
     * 
     * @param langStoreNm 을(를) String langStoreNm로 설정
     */
    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    
    /**
     * String accuseAtCd을 반환
     * @return String accuseAtCd
     */
    public String getAccuseAtCd() {
        return accuseAtCd;
    }

    
    /**
     * accuseAtCd을 설정
     * @param accuseAtCd 을(를) String accuseAtCd로 설정
     */
    public void setAccuseAtCd(String accuseAtCd) {
        this.accuseAtCd = accuseAtCd;
    }

    
   
    /**
     * String accuseResnCd을 반환
     * @return String accuseResnCd
     */
    public String getAccuseResnCd() {
        return accuseResnCd;
    }

    
    /**
     * accuseResnCd을 설정
     * @param accuseResnCd 을(를) String accuseResnCd로 설정
     */
    public void setAccuseResnCd(String accuseResnCd) {
        this.accuseResnCd = accuseResnCd;
    }


    
    /**
     * String accuseDt을 반환
     * @return String accuseDt
     */
    public String getAccuseDt() {
        return accuseDt;
    }

    
    /**
     * accuseDt을 설정
     * @param accuseDt 을(를) String accuseDt로 설정
     */
    public void setAccuseDt(String accuseDt) {
        this.accuseDt = accuseDt;
    }

    
    /**
     * String accuseResnEtcCn을 반환
     * @return String accuseResnEtcCn
     */
    public String getAccuseResnEtcCn() {
        return accuseResnEtcCn;
    }

    
    /**
     * accuseResnEtcCn을 설정
     * @param accuseResnEtcCn 을(를) String accuseResnEtcCn로 설정
     */
    public void setAccuseResnEtcCn(String accuseResnEtcCn) {
        this.accuseResnEtcCn = accuseResnEtcCn;
    }

    
    /**
     * String inqryAplcntId을 반환
     * @return String inqryAplcntId
     */
    public String getInqryAplcntId() {
        return inqryAplcntId;
    }

    
    /**
     * inqryAplcntId을 설정
     * @param inqryAplcntId 을(를) String inqryAplcntId로 설정
     */
    public void setInqryAplcntId(String inqryAplcntId) {
        this.inqryAplcntId = inqryAplcntId;
    }

    
    /**
     * String inqryAccuseResnCd을 반환
     * @return String inqryAccuseResnCd
     */
    public String getInqryAccuseResnCd() {
        return inqryAccuseResnCd;
    }

    
    /**
     * inqryAccuseResnCd을 설정
     * @param inqryAccuseResnCd 을(를) String inqryAccuseResnCd로 설정
     */
    public void setInqryAccuseResnCd(String inqryAccuseResnCd) {
        this.inqryAccuseResnCd = inqryAccuseResnCd;
    }

    
    /**
     * String answerAccuseResnCd을 반환
     * @return String answerAccuseResnCd
     */
    public String getAnswerAccuseResnCd() {
        return answerAccuseResnCd;
    }

    
    /**
     * answerAccuseResnCd을 설정
     * @param answerAccuseResnCd 을(를) String answerAccuseResnCd로 설정
     */
    public void setAnswerAccuseResnCd(String answerAccuseResnCd) {
        this.answerAccuseResnCd = answerAccuseResnCd;
    }

    
    /**
     * String inqryAccuseEtcCn을 반환
     * @return String inqryAccuseEtcCn
     */
    public String getInqryAccuseEtcCn() {
        return inqryAccuseEtcCn;
    }

    
    /**
     * inqryAccuseEtcCn을 설정
     * @param inqryAccuseEtcCn 을(를) String inqryAccuseEtcCn로 설정
     */
    public void setInqryAccuseEtcCn(String inqryAccuseEtcCn) {
        this.inqryAccuseEtcCn = inqryAccuseEtcCn;
    }

    
    /**
     * String answerAccuseEtcCn을 반환
     * @return String answerAccuseEtcCn
     */
    public String getAnswerAccuseEtcCn() {
        return answerAccuseEtcCn;
    }

    
    /**
     * answerAccuseEtcCn을 설정
     * @param answerAccuseEtcCn 을(를) String answerAccuseEtcCn로 설정
     */
    public void setAnswerAccuseEtcCn(String answerAccuseEtcCn) {
        this.answerAccuseEtcCn = answerAccuseEtcCn;
    }

    
    /**
     * String inqryAplcntNm을 반환
     * @return String inqryAplcntNm
     */
    public String getInqryAplcntNm() {
        return inqryAplcntNm;
    }

    
    /**
     * inqryAplcntNm을 설정
     * @param inqryAplcntNm 을(를) String inqryAplcntNm로 설정
     */
    public void setInqryAplcntNm(String inqryAplcntNm) {
        this.inqryAplcntNm = inqryAplcntNm;
    }

    
    /**
     * String answerAplcntId을 반환
     * @return String answerAplcntId
     */
    public String getAnswerAplcntId() {
        return answerAplcntId;
    }

    
    /**
     * answerAplcntId을 설정
     * @param answerAplcntId 을(를) String answerAplcntId로 설정
     */
    public void setAnswerAplcntId(String answerAplcntId) {
        this.answerAplcntId = answerAplcntId;
    }

    
    /**
     * String answerAplcntNm을 반환
     * @return String answerAplcntNm
     */
    public String getAnswerAplcntNm() {
        return answerAplcntNm;
    }

    
    /**
     * answerAplcntNm을 설정
     * @param answerAplcntNm 을(를) String answerAplcntNm로 설정
     */
    public void setAnswerAplcntNm(String answerAplcntNm) {
        this.answerAplcntNm = answerAplcntNm;
    }

    
    /**
     * String inqryUpdateDt을 반환
     * @return String inqryUpdateDt
     */
    public String getInqryUpdateDt() {
        return inqryUpdateDt;
    }

    
    /**
     * inqryUpdateDt을 설정
     * @param inqryUpdateDt 을(를) String inqryUpdateDt로 설정
     */
    public void setInqryUpdateDt(String inqryUpdateDt) {
        this.inqryUpdateDt = inqryUpdateDt;
    }

    
    /**
     * String answerUpdateDt을 반환
     * @return String answerUpdateDt
     */
    public String getAnswerUpdateDt() {
        return answerUpdateDt;
    }

    
    /**
     * answerUpdateDt을 설정
     * @param answerUpdateDt 을(를) String answerUpdateDt로 설정
     */
    public void setAnswerUpdateDt(String answerUpdateDt) {
        this.answerUpdateDt = answerUpdateDt;
    }

    
    /**
     * String inqryAccuseResnNm을 반환
     * @return String inqryAccuseResnNm
     */
    public String getInqryAccuseResnNm() {
        return inqryAccuseResnNm;
    }

    
    /**
     * inqryAccuseResnNm을 설정
     * @param inqryAccuseResnNm 을(를) String inqryAccuseResnNm로 설정
     */
    public void setInqryAccuseResnNm(String inqryAccuseResnNm) {
        this.inqryAccuseResnNm = inqryAccuseResnNm;
    }

    
    /**
     * String answerAccuseResnNm을 반환
     * @return String answerAccuseResnNm
     */
    public String getAnswerAccuseResnNm() {
        return answerAccuseResnNm;
    }

    
    /**
     * answerAccuseResnNm을 설정
     * @param answerAccuseResnNm 을(를) String answerAccuseResnNm로 설정
     */
    public void setAnswerAccuseResnNm(String answerAccuseResnNm) {
        this.answerAccuseResnNm = answerAccuseResnNm;
    }

    
 

}
