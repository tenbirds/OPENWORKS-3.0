/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.forn;

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
 *    수정일                       수정자             수정내용
 *--------------  --------  -------------------------------
 * 2015. 12. 08.    KS       신규
 *</pre>
 * @see
 */
public class GoodsFornVO extends PaggingVO {

    /**  TST_FORN_GOODS_I 해외클라우드정보 */
    private static final long serialVersionUID = 1L;

    
    /* 서비스명 */
    private String fornGoodsNm;
    /* 회사명 */
    private String fornCmpnyNm;
    /* 설명 */
    private String fornGoodsSumry;
    /* 분류명 */
    private String fornKndNm;
    /* 비고 */
    private String fornNote;
    /* 연결URL */
    private String fornLinkUrl;
    /*  */
    private String formSeq;
    /*  */
    private String createDt;
    /*  */
    private String updateDt;
   
 
    /**
     * String fornGoodsNm을 반환
     * @return String fornGoodsNm
     */
    public String getFornGoodsNm() {
        return fornGoodsNm;
    }
    
    /**
     * fornGoodsNm을 설정
     * @param fornGoodsNm 을(를) String fornGoodsNm로 설정
     */
    public void setFornGoodsNm(String fornGoodsNm) {
        this.fornGoodsNm = fornGoodsNm;
    }
 
    /**
     * String fornCmpnyNm을 반환
     * @return String fornCmpnyNm
     */
    public String getFornCmpnyNm() {
        return fornCmpnyNm;
    }
    
    /**
     * fornCmpnyNm을 설정
     * @param fornCmpnyNm 을(를) String fornCmpnyNm로 설정
     */
    public void setFornCmpnyNm(String fornCmpnyNm) {
        this.fornCmpnyNm = fornCmpnyNm;
    }
    
    /**
     * String fornGoodsSumry을 반환
     * @return String fornGoodsSumry
     */
    public String getFornGoodsSumry() {
        return fornGoodsSumry;
    }

    /**
     * fornGoodsSumry을 설정
     * @param fornGoodsSumry 을(를) String fornGoodsSumry로 설정
     */
    public void setFornGoodsSumry(String fornGoodsSumry) {
        this.fornGoodsSumry = fornGoodsSumry;
    }

    /**
     * String fornKndNm을 반환
     * @return String fornKndNm
     */
    public String getFornKndNm() {
        return fornKndNm;
    }

    /**
     * fornKndNm을 설정
     * @param fornKndNm 을(를) String fornKndNm로 설정
     */
    public void setFornKndNm(String fornKndNm) {
        this.fornKndNm = fornKndNm;
    }

    /**
     * String fornNote을 반환
     * @return String fornNote
     */
    public String getFornNote() {
        return fornNote;
    }

    /**
     * fornNote을 설정
     * @param fornNote 을(를) String fornNote로 설정
     */
    public void setFornNote(String fornNote) {
        this.fornNote = fornNote;
    }
    
    /**
     * String fornLinkUrl을 반환
     * @return String fornLinkUrl
     */
    public String getFornLinkUrl() {
        return fornLinkUrl;
    }

    
    /**
     * fornLinkUrl을 설정
     * @param fornLinkUrl 을(를) String fornLinkUrl로 설정
     */
    public void setFornLinkUrl(String fornLinkUrl) {
        this.fornLinkUrl = fornLinkUrl;
    }

    /**
     * String formSeq을 반환
     * @return String formSeq
     */
    public String getFormSeq() {
        return formSeq;
    }

    
    /**
     * formSeq을 설정
     * @param formSeq 을(를) String formSeq로 설정
     */
    public void setFormSeq(String formSeq) {
        this.formSeq = formSeq;
    }
    
    /**
     * String createDt을 반환
     * @return String createDt
     */
    public String getCreateDt() {
        return createDt;
    }

    
    /**
     * createDt을 설정
     * @param createDt 을(를) String createDt로 설정
     */
    public void setCreateDt(String createDt) {
        this.createDt = createDt;
    }
       
    /**
     * String updateDt을 반환
     * @return String updateDt
     */
    public String getUpdateDt() {
        return updateDt;
    }

    
    /**
     * fornLinkUrl을 설정
     * @param updateDt 을(를) String updateDt로 설정
     */
    public void setUpDateDt(String updateDt) {
        this.updateDt = updateDt;
    }
}
