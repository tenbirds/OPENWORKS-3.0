/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.suppost.evl;

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
public class WebGoodsEvlVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 6891909399221651073L;

    /** 평가자 아이디 */
    private String userId;
    
    /** 평가 일련번호 */
    private Integer goodsEvlSeq;
    /** 서비스코드 */
    private String goodsCode;
    /** 서비스명 */
    private String goodsNm;
    /** 언어 코드 */
    private String langCode;
    /** 언어 명 */
    private String langNm;
    /** 평가 점수 */
    private String evlScore;
    /** 평가 내용 */
    private String evlSntnc;
    /** 등록자 아이디 */
    private String registId;
    /** 등록자 명 */
    private String registNm;
    /** 평가 일 */
    private String registDt;
    /** 카테고리 이름 */
    private String ctgryClNm;
    
    /* 언어코드 */
    private String langCd;
    
    
    
    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    
    /**
     * userId을 설정
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
     * Integer goodsEvlSeq을 반환
     * 
     * @return Integer goodsEvlSeq
     */
    public Integer getGoodsEvlSeq() {
        return goodsEvlSeq;
    }

    /**
     * goodsEvlSeq을 설정
     * 
     * @param goodsEvlSeq 을(를) Integer goodsEvlSeq로 설정
     */
    public void setGoodsEvlSeq(Integer goodsEvlSeq) {
        this.goodsEvlSeq = goodsEvlSeq;
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
     * String evlScore을 반환
     * 
     * @return String evlScore
     */
    public String getEvlScore() {
        return evlScore;
    }

    /**
     * evlScore을 설정
     * 
     * @param evlScore 을(를) String evlScore로 설정
     */
    public void setEvlScore(String evlScore) {
        this.evlScore = evlScore;
    }

    /**
     * String evlSntnc을 반환
     * 
     * @return String evlSntnc
     */
    public String getEvlSntnc() {
        return evlSntnc;
    }

    /**
     * evlSntnc을 설정
     * 
     * @param evlSntnc 을(를) String evlSntnc로 설정
     */
    public void setEvlSntnc(String evlSntnc) {
        this.evlSntnc = evlSntnc;
    }

    /**
     * String registNm을 반환
     * 
     * @return String registNm
     */
    public String getRegistNm() {
        return registNm;
    }

    /**
     * registNm을 설정
     * 
     * @param registNm 을(를) String registNm로 설정
     */
    public void setRegistNm(String registNm) {
        this.registNm = registNm;
    }

    /**
     * String registDt을 반환
     * 
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }

    /**
     * registDt을 설정
     * 
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    
    /**
     * String ctgryClNm을 반환
     * @return String ctgryClNm
     */
    public String getCtgryClNm() {
        return ctgryClNm;
    }

    
    /**
     * ctgryClNm을 설정
     * @param ctgryClNm 을(를) String ctgryClNm로 설정
     */
    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
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
