/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

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
 *  2018. 03.      이홍석       신규
 * </pre>
 * @see
 */
public class MyCeartScs2VO extends PaggingVO {

    private static final long serialVersionUID = 1L;

    private String notifyNum;       /** 공고번호 */   
    
    private int notifySeq;          /** 공고순번 */    
    private String userId;          /** 수요자아이디 */    
    private String langStoreId;     /** 공급자아이디 */    
    private String consumerYn;      /** 수요자여부 */      
    private String applyGbn;        /** 답변여부 */    
    
    private String cnslRelm;         /** 컨설팅 영역 */    
    private String cnslRelmNm;       /** 컨설팅 영역Nm */
    private String cnslRelmEtc;      /** 컨설팅 영역 _ 기타 */   
    private String cnslScope;        /** 컨설팅 범위 */   
    private String cnslScopeNm;      /** 컨설팅 범위Nm */   
    private String excArea;          /** 컨설팅 수행가능지역 */   
    private String excAreaNm;        /** 컨설팅 수행가능지역Nm */   
    private String indcWhole;        /** 도입전반(성능/사용랑) */    
    private String setupMgr;         /** Setup & Migration  */
    private String oper;             /** 운영 */
    private String qlityTest;        /** 품질보증/테스트 */
    private String scrty;            /** 보안 */
    private String education;        /** 교육 */
    
    
    /**
     * String notifyNum을 반환
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }

    
    /**
     * notifyNum을 설정
     * @param notifyNum 을(를) String notifyNum로 설정
     */
    public void setNotifyNum(String notifyNum) {
        this.notifyNum = notifyNum;
    }

    
    /**
     * int notifySeq을 반환
     * @return int notifySeq
     */
    public int getNotifySeq() {
        return notifySeq;
    }

    
    /**
     * notifySeq을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
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
     * String langStoreId을 반환
     * @return String langStoreId
     */
    public String getLangStoreId() {
        return langStoreId;
    }

    
    /**
     * langStoreId을 설정
     * @param langStoreId 을(를) String langStoreId로 설정
     */
    public void setLangStoreId(String langStoreId) {
        this.langStoreId = langStoreId;
    }

    
    /**
     * String consumerYn을 반환
     * @return String consumerYn
     */
    public String getConsumerYn() {
        return consumerYn;
    }

    
    /**
     * consumerYn을 설정
     * @param consumerYn 을(를) String consumerYn로 설정
     */
    public void setConsumerYn(String consumerYn) {
        this.consumerYn = consumerYn;
    }

    
    /**
     * String applyGbn을 반환
     * @return String applyGbn
     */
    public String getApplyGbn() {
        return applyGbn;
    }

    
    /**
     * applyGbn을 설정
     * @param applyGbn 을(를) String applyGbn로 설정
     */
    public void setApplyGbn(String applyGbn) {
        this.applyGbn = applyGbn;
    }


    
    /**
     * String cnslRelm을 반환
     * @return String cnslRelm
     */
    public String getCnslRelm() {
        return cnslRelm;
    }


    
    /**
     * cnslRelm을 설정
     * @param cnslRelm 을(를) String cnslRelm로 설정
     */
    public void setCnslRelm(String cnslRelm) {
        this.cnslRelm = cnslRelm;
    }


    
    /**
     * String cnslRelmNm을 반환
     * @return String cnslRelmNm
     */
    public String getCnslRelmNm() {
        return cnslRelmNm;
    }


    
    /**
     * cnslRelmNm을 설정
     * @param cnslRelmNm 을(를) String cnslRelmNm로 설정
     */
    public void setCnslRelmNm(String cnslRelmNm) {
        this.cnslRelmNm = cnslRelmNm;
    }


    
    /**
     * String cnslRelmEtc을 반환
     * @return String cnslRelmEtc
     */
    public String getCnslRelmEtc() {
        return cnslRelmEtc;
    }


    
    /**
     * cnslRelmEtc을 설정
     * @param cnslRelmEtc 을(를) String cnslRelmEtc로 설정
     */
    public void setCnslRelmEtc(String cnslRelmEtc) {
        this.cnslRelmEtc = cnslRelmEtc;
    }


    
    /**
     * String cnslScope을 반환
     * @return String cnslScope
     */
    public String getCnslScope() {
        return cnslScope;
    }


    
    /**
     * cnslScope을 설정
     * @param cnslScope 을(를) String cnslScope로 설정
     */
    public void setCnslScope(String cnslScope) {
        this.cnslScope = cnslScope;
    }


    
    /**
     * String cnslScopeNm을 반환
     * @return String cnslScopeNm
     */
    public String getCnslScopeNm() {
        return cnslScopeNm;
    }


    
    /**
     * cnslScopeNm을 설정
     * @param cnslScopeNm 을(를) String cnslScopeNm로 설정
     */
    public void setCnslScopeNm(String cnslScopeNm) {
        this.cnslScopeNm = cnslScopeNm;
    }


    
    /**
     * String excArea을 반환
     * @return String excArea
     */
    public String getExcArea() {
        return excArea;
    }


    
    /**
     * excArea을 설정
     * @param excArea 을(를) String excArea로 설정
     */
    public void setExcArea(String excArea) {
        this.excArea = excArea;
    }


    
    /**
     * String excAreaNm을 반환
     * @return String excAreaNm
     */
    public String getExcAreaNm() {
        return excAreaNm;
    }


    
    /**
     * excAreaNm을 설정
     * @param excAreaNm 을(를) String excAreaNm로 설정
     */
    public void setExcAreaNm(String excAreaNm) {
        this.excAreaNm = excAreaNm;
    }


    
    /**
     * String indcWhole을 반환
     * @return String indcWhole
     */
    public String getIndcWhole() {
        return indcWhole;
    }


    
    /**
     * indcWhole을 설정
     * @param indcWhole 을(를) String indcWhole로 설정
     */
    public void setIndcWhole(String indcWhole) {
        this.indcWhole = indcWhole;
    }


    
    /**
     * String setupMgr을 반환
     * @return String setupMgr
     */
    public String getSetupMgr() {
        return setupMgr;
    }


    
    /**
     * setupMgr을 설정
     * @param setupMgr 을(를) String setupMgr로 설정
     */
    public void setSetupMgr(String setupMgr) {
        this.setupMgr = setupMgr;
    }


    
    /**
     * String oper을 반환
     * @return String oper
     */
    public String getOper() {
        return oper;
    }


    
    /**
     * oper을 설정
     * @param oper 을(를) String oper로 설정
     */
    public void setOper(String oper) {
        this.oper = oper;
    }


    
    /**
     * String qlityTest을 반환
     * @return String qlityTest
     */
    public String getQlityTest() {
        return qlityTest;
    }


    /**
     * qlityTest을 설정
     * @param qlityTest 을(를) String qlityTest로 설정
     */
    public void setQlityTest(String qlityTest) {
        this.qlityTest = qlityTest;
    }


    /**
     * String scrty을 반환
     * @return String scrty
     */
    public String getScrty() {
        return scrty;
    }


    
    /**
     * scrty을 설정
     * @param scrty 을(를) String scrty로 설정
     */
    public void setScrty(String scrty) {
        this.scrty = scrty;
    }


    
    /**
     * String education을 반환
     * @return String education
     */
    public String getEducation() {
        return education;
    }


    
    /**
     * education을 설정
     * @param education 을(를) String education로 설정
     */
    public void setEducation(String education) {
        this.education = education;
    }

}
