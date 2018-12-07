/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.bassAgremManage;


/**
 * 
 *
 * @version 1.0
 * @since openworks-3.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 1. 30.    이홍석       신규
 *</pre>
 * @see
 */
public class BassAgremSummaryVO {

    /* 정상 협약건수 */
    private int normalityAgreement = 0;
    /* 승인완료건수 */
    private int admissionCompletion = 0;
    /* 협약갱신건수 */
    private int updateAgreement = 0;
    /* 반려/보완신청건수 */
    private int returnSupplementation  = 0;
    /* 협약종료 건수 */
    private int agreementExpiration = 0;
    
    /**
     * int normalityAgreement을 반환
     * @return int normalityAgreement
     */
    public int getNormalityAgreement() {
        return normalityAgreement;
    }
    /**
     * normalityAgreement을 설정
     * @param normalityAgreement 을(를) int normalityAgreement로 설정
     */
    public void setNormalityAgreement(int normalityAgreement) {
        this.normalityAgreement = normalityAgreement;
    }
    /**
     * int admissionCompletion을 반환
     * @return int admissionCompletion
     */
    public int getAdmissionCompletion() {
        return admissionCompletion;
    }
    /**
     * admissionCompletion을 설정
     * @param admissionCompletion 을(를) int admissionCompletion로 설정
     */
    public void setAdmissionCompletion(int admissionCompletion) {
        this.admissionCompletion = admissionCompletion;
    }
    /**
     * int updateAgreement을 반환
     * @return int updateAgreement
     */
    public int getUpdateAgreement() {
        return updateAgreement;
    }
    /**
     * updateAgreement을 설정
     * @param updateAgreement 을(를) int updateAgreement로 설정
     */
    public void setUpdateAgreement(int updateAgreement) {
        this.updateAgreement = updateAgreement;
    }
    /**
     * int returnSupplementation을 반환
     * @return int returnSupplementation
     */
    public int getReturnSupplementation() {
        return returnSupplementation;
    }
    /**
     * returnSupplementation을 설정
     * @param returnSupplementation 을(를) int returnSupplementation로 설정
     */
    public void setReturnSupplementation(int returnSupplementation) {
        this.returnSupplementation = returnSupplementation;
    }
    /**
     * int agreementExpiration을 반환
     * @return int agreementExpiration
     */
    public int getAgreementExpiration() {
        return agreementExpiration;
    }
    /**
     * agreementExpiration을 설정
     * @param agreementExpiration 을(를) int agreementExpiration로 설정
     */
    public void setAgreementExpiration(int agreementExpiration) {
        this.agreementExpiration = agreementExpiration;
    }
}
