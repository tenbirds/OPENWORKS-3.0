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
public class MyCeartSaas2DnVO extends PaggingVO {

    private static final long serialVersionUID = 1L;

    private String notifyNum;    /** 공고번호 */   
    private int notifySeq;       /** 공고순번 */    
    private String userId;       /** 사용자아이디 */    
    private String langStoreId;  /** 공급자아이디 */    
    private String consumerYn;   /** 수요자여부 */   
    private int needSeq;         /** 필요항목seq */
    private int saas2DoCnt;      /** 필요항목아래 옵션항목의 갯수 */
    
    private String functionName; /** 기능명 */    
    private String amount;       /** 개별단가 */    
    private String unitCode;     /** 개별단위 */    
    private String unitCodeNm;   /** 개별단위 - 명  */    
    
    private String applyYn;      /** 답변등록여부 */

    
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
     * int needSeq을 반환
     * @return int needSeq
     */
    public int getNeedSeq() {
        return needSeq;
    }


    /**
     * needSeq을 설정
     * @param needSeq 을(를) int needSeq로 설정
     */
    public void setNeedSeq(int needSeq) {
        this.needSeq = needSeq;
    }


    /**
     * int saas2DoCnt을 반환
     * @return int saas2DoCnt
     */
    public int getSaas2DoCnt() {
        return saas2DoCnt;
    }


    /**
     * saas2DoCnt을 설정
     * @param saas2DoCnt 을(를) int saas2DoCnt로 설정
     */
    public void setSaas2DoCnt(int saas2DoCnt) {
        this.saas2DoCnt = saas2DoCnt;
    }


    /**
     * String functionName을 반환
     * @return String functionName
     */
    public String getFunctionName() {
        return functionName;
    }


    /**
     * functionName을 설정
     * @param functionName 을(를) String functionName로 설정
     */
    public void setFunctionName(String functionName) {
        this.functionName = functionName;
    }


    /**
     * String amount을 반환
     * @return String amount
     */
    public String getAmount() {
        return amount;
    }


    /**
     * amount을 설정
     * @param amount 을(를) String amount로 설정
     */
    public void setAmount(String amount) {
        this.amount = amount;
    }


    /**
     * String unitCode을 반환
     * @return String unitCode
     */
    public String getUnitCode() {
        return unitCode;
    }


    /**
     * unitCode을 설정
     * @param unitCode 을(를) String unitCode로 설정
     */
    public void setUnitCode(String unitCode) {
        this.unitCode = unitCode;
    }


    /**
     * String unitCodeNm을 반환
     * @return String unitCodeNm
     */
    public String getUnitCodeNm() {
        return unitCodeNm;
    }


    /**
     * unitCodeNm을 설정
     * @param unitCodeNm 을(를) String unitCodeNm로 설정
     */
    public void setUnitCodeNm(String unitCodeNm) {
        this.unitCodeNm = unitCodeNm;
    }


    /**
     * String applyYn을 반환
     * @return String applyYn
     */
    public String getApplyYn() {
        return applyYn;
    }

    
    /**
     * applyYn을 설정
     * @param applyYn 을(를) String applyYn로 설정
     */
    public void setApplyYn(String applyYn) {
        this.applyYn = applyYn;
    }

}
