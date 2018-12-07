/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

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
 *  2014. 10. 22.    이슬버미       신규
 * </pre>
 * @see
 */
public class SuplerCeartSaasIVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 수요자아이디 */
    private String endsUserId;

    /** 공급자아이디 */
    private String suplerId;

    /** 수요자여부 */
    private String consumerYn;
    
    /** 답변여부 */
    private String applyGbn;

    /** 전체단위 */
    private String unitSys;

    /** 전체단위-명 */
    private String unitSysNm;
    
    /** 기타단위내용 */
    private String etcUnitSys;

    /** 전체제공용량 */
    private String captySys;

    /** 전체단가 */
    private String amountSys;
    
    /** 제공방법 */
    private String splyMothSys;
    
    /** 제공방법-명 */
    private String splyMothSysNm;

    /** 답변여부 */
    private String applyYn;

    
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
     * String endsUserId을 반환
     * @return String endsUserId
     */
    public String getEndsUserId() {
        return endsUserId;
    }

    
    /**
     * endsUserId을 설정
     * @param endsUserId 을(를) String endsUserId로 설정
     */
    public void setEndsUserId(String endsUserId) {
        this.endsUserId = endsUserId;
    }

    
    /**
     * String suplerId을 반환
     * @return String suplerId
     */
    public String getSuplerId() {
        return suplerId;
    }

    
    /**
     * suplerId을 설정
     * @param suplerId 을(를) String suplerId로 설정
     */
    public void setSuplerId(String suplerId) {
        this.suplerId = suplerId;
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
     * String unitSys을 반환
     * @return String unitSys
     */
    public String getUnitSys() {
        return unitSys;
    }

    
    /**
     * unitSys을 설정
     * @param unitSys 을(를) String unitSys로 설정
     */
    public void setUnitSys(String unitSys) {
        this.unitSys = unitSys;
    }

    
    /**
     * String unitSysNm을 반환
     * @return String unitSysNm
     */
    public String getUnitSysNm() {
        return unitSysNm;
    }

    
    /**
     * unitSysNm을 설정
     * @param unitSysNm 을(를) String unitSysNm로 설정
     */
    public void setUnitSysNm(String unitSysNm) {
        this.unitSysNm = unitSysNm;
    }

    
    /**
     * String etcUnitSys을 반환
     * @return String etcUnitSys
     */
    public String getEtcUnitSys() {
        return etcUnitSys;
    }

    
    /**
     * etcUnitSys을 설정
     * @param etcUnitSys 을(를) String etcUnitSys로 설정
     */
    public void setEtcUnitSys(String etcUnitSys) {
        this.etcUnitSys = etcUnitSys;
    }

    
    /**
     * String captySys을 반환
     * @return String captySys
     */
    public String getCaptySys() {
        return captySys;
    }

    
    /**
     * captySys을 설정
     * @param captySys 을(를) String captySys로 설정
     */
    public void setCaptySys(String captySys) {
        this.captySys = captySys;
    }

    
    /**
     * String amountSys을 반환
     * @return String amountSys
     */
    public String getAmountSys() {
        return amountSys;
    }

    
    /**
     * amountSys을 설정
     * @param amountSys 을(를) String amountSys로 설정
     */
    public void setAmountSys(String amountSys) {
        this.amountSys = amountSys;
    }

    
    /**
     * String splyMothSys을 반환
     * @return String splyMothSys
     */
    public String getSplyMothSys() {
        return splyMothSys;
    }

    
    /**
     * splyMothSys을 설정
     * @param splyMothSys 을(를) String splyMothSys로 설정
     */
    public void setSplyMothSys(String splyMothSys) {
        this.splyMothSys = splyMothSys;
    }

    
    /**
     * String splyMothSysNm을 반환
     * @return String splyMothSysNm
     */
    public String getSplyMothSysNm() {
        return splyMothSysNm;
    }

    
    /**
     * splyMothSysNm을 설정
     * @param splyMothSysNm 을(를) String splyMothSysNm로 설정
     */
    public void setSplyMothSysNm(String splyMothSysNm) {
        this.splyMothSysNm = splyMothSysNm;
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