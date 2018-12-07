/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.goods.evl;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 25.    이슬버미       신규
 *</pre>
 * @see
 */
public class GoodsEvlVO extends PaggingVO{

    /**  */
    private static final long serialVersionUID = 5825458757737138515L;

    /** 평가자 아이디 */
    private String userId;
    
    /** 평가 일련번호 */
    private Integer goodsEvlSeq;
    /** 문의 일련번호 들 */
    private String[] goodsEvlSeqs;
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
    
    
    
    
    
    
    /**
     * String[] goodsEvlSeqs을 반환
     * @return String[] goodsEvlSeqs
     */
    public String[] getGoodsEvlSeqs() {
        return goodsEvlSeqs;
    }



    
    /**
     * goodsEvlSeqs을 설정
     * @param goodsEvlSeqs 을(를) String[] goodsEvlSeqs로 설정
     */
    public void setGoodsEvlSeqs(String[] goodsEvlSeqs) {
        this.goodsEvlSeqs = goodsEvlSeqs;
    }



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
     * Integer goodsEvlSeq을 반환
     * @return Integer goodsEvlSeq
     */
    public Integer getGoodsEvlSeq() {
        return goodsEvlSeq;
    }


    
    /**
     * goodsEvlSeq을 설정
     * @param goodsEvlSeq 을(를) Integer goodsEvlSeq로 설정
     */
    public void setGoodsEvlSeq(Integer goodsEvlSeq) {
        this.goodsEvlSeq = goodsEvlSeq;
    }


    
    /**
     * String goodsCode을 반환
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }


    
    /**
     * goodsCode을 설정
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }


    
    /**
     * String goodsNm을 반환
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }


    
    /**
     * goodsNm을 설정
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }


    
    /**
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }


    
    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }


    
    /**
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }


    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }


    
    /**
     * String evlScore을 반환
     * @return String evlScore
     */
    public String getEvlScore() {
        return evlScore;
    }


    
    /**
     * evlScore을 설정
     * @param evlScore 을(를) String evlScore로 설정
     */
    public void setEvlScore(String evlScore) {
        this.evlScore = evlScore;
    }


    
    /**
     * String evlSntnc을 반환
     * @return String evlSntnc
     */
    public String getEvlSntnc() {
        return evlSntnc;
    }


    
    /**
     * evlSntnc을 설정
     * @param evlSntnc 을(를) String evlSntnc로 설정
     */
    public void setEvlSntnc(String evlSntnc) {
        this.evlSntnc = evlSntnc;
    }


    
    /**
     * String registId을 반환
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }


    
    /**
     * registId을 설정
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }


    
    /**
     * String registNm을 반환
     * @return String registNm
     */
    public String getRegistNm() {
        return registNm;
    }


    
    /**
     * registNm을 설정
     * @param registNm 을(를) String registNm로 설정
     */
    public void setRegistNm(String registNm) {
        this.registNm = registNm;
    }


    
    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }


    
    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }


    /**
     * String goodsTyCd을 반환
     * @return String goodsTyCd
     */
    public String getGoodsTyCd() {
        return goodsTyCd;
    }

    
    /**
     * goodsTyCd을 설정
     * @param goodsTyCd 을(를) String goodsTyCd로 설정
     */
    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    
    /**
     * String goodsTyNm을 반환
     * @return String goodsTyNm
     */
    public String getGoodsTyNm() {
        return goodsTyNm;
    }

    
    /**
     * goodsTyNm을 설정
     * @param goodsTyNm 을(를) String goodsTyNm로 설정
     */
    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }

    
    /**
     * String ctgryCd을 반환
     * @return String ctgryCd
     */
    public String getCtgryCd() {
        return ctgryCd;
    }

    
    /**
     * ctgryCd을 설정
     * @param ctgryCd 을(를) String ctgryCd로 설정
     */
    public void setCtgryCd(String ctgryCd) {
        this.ctgryCd = ctgryCd;
    }

    
    /**
     * String ctgryNm을 반환
     * @return String ctgryNm
     */
    public String getCtgryNm() {
        return ctgryNm;
    }

    
    /**
     * ctgryNm을 설정
     * @param ctgryNm 을(를) String ctgryNm로 설정
     */
    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }

    
    /**
     * String parntsCtgryCd을 반환
     * @return String parntsCtgryCd
     */
    public String getParntsCtgryCd() {
        return parntsCtgryCd;
    }

    
    /**
     * parntsCtgryCd을 설정
     * @param parntsCtgryCd 을(를) String parntsCtgryCd로 설정
     */
    public void setParntsCtgryCd(String parntsCtgryCd) {
        this.parntsCtgryCd = parntsCtgryCd;
    }

    
    /**
     * String ctgryDp을 반환
     * @return String ctgryDp
     */
    public String getCtgryDp() {
        return ctgryDp;
    }

    
    /**
     * ctgryDp을 설정
     * @param ctgryDp 을(를) String ctgryDp로 설정
     */
    public void setCtgryDp(String ctgryDp) {
        this.ctgryDp = ctgryDp;
    }

    /**
     * String ctgryClCd을 반환
     * @return String ctgryClCd
     */
    public String getCtgryClCd() {
        return ctgryClCd;
    }
    
    /**
     * ctgryClCd을 설정
     * @param ctgryClCd 을(를) String ctgryClCd로 설정
     */
    public void setCtgryClCd(String ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
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
    
    
    
}
