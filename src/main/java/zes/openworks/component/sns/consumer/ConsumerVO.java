/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.consumer;

import zes.base.vo.BaseVO;

/**
 * SNS 서비스 사용자에 등록한 사용자 인증 아이디 및 인증 키 관리 VO
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 8. 14.    방기배       신규
 * </pre>
 * @see
 */
public class ConsumerVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 2050899782236144586L;

    /** 서비스아이디 */
    private String serviceId;
    /** 서비스아이디 */
    private String serviceNm;
    /** 사용자키 */
    private String consumerKey;
    /** 사용자비밀키 */
    private String consumerSecretKey;
    /** 사용여부 */
    private String useYn;
    /** 등록자아이디 */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록 일시 */
    private String regDt;
    /** 수정자아이디 */
    private String modId;
    /** 수정자명 */
    private String modNm;
    /** 수정 일시 */
    private String modDt;

    /**
     * String serviceId을 반환
     * 
     * @return String serviceId
     */
    public String getServiceId() {
        return serviceId;
    }

    /**
     * serviceId을 설정
     * 
     * @param serviceId 을(를) String serviceId로 설정
     */
    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    /**
     * String serviceNm을 반환
     * 
     * @return String serviceNm
     */
    public String getServiceNm() {
        return serviceNm;
    }

    /**
     * serviceNm을 설정
     * 
     * @param serviceNm 을(를) String serviceNm로 설정
     */
    public void setServiceNm(String serviceNm) {
        this.serviceNm = serviceNm;
    }

    /**
     * String consumerKey을 반환
     * 
     * @return String consumerKey
     */
    public String getConsumerKey() {
        return consumerKey;
    }

    /**
     * consumerKey을 설정
     * 
     * @param consumerKey 을(를) String consumerKey로 설정
     */
    public void setConsumerKey(String consumerKey) {
        this.consumerKey = consumerKey;
    }

    /**
     * String consumerSecretKey을 반환
     * 
     * @return String consumerSecretKey
     */
    public String getConsumerSecretKey() {
        return consumerSecretKey;
    }

    /**
     * consumerSecretKey을 설정
     * 
     * @param consumerSecretKey 을(를) String consumerSecretKey로 설정
     */
    public void setConsumerSecretKey(String consumerSecretKey) {
        this.consumerSecretKey = consumerSecretKey;
    }

    /**
     * String useYn을 반환
     * 
     * @return String useYn
     */
    public String getUseYn() {
        return useYn;
    }

    /**
     * useYn을 설정
     * 
     * @param useYn 을(를) String useYn로 설정
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * String regId을 반환
     * 
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * regId을 설정
     * 
     * @param regId 을(를) String regId로 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * String regNm을 반환
     * 
     * @return String regNm
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * regNm을 설정
     * 
     * @param regNm 을(를) String regNm로 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

    /**
     * String regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * regDt을 설정
     * 
     * @param regDt 을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    /**
     * String modId을 반환
     * 
     * @return String modId
     */
    public String getModId() {
        return modId;
    }

    /**
     * modId을 설정
     * 
     * @param modId 을(를) String modId로 설정
     */
    public void setModId(String modId) {
        this.modId = modId;
    }

    /**
     * String modNm을 반환
     * 
     * @return String modNm
     */
    public String getModNm() {
        return modNm;
    }

    /**
     * modNm을 설정
     * 
     * @param modNm 을(를) String modNm로 설정
     */
    public void setModNm(String modNm) {
        this.modNm = modNm;
    }

    /**
     * String modDt을 반환
     * 
     * @return String modDt
     */
    public String getModDt() {
        return modDt;
    }

    /**
     * modDt을 설정
     * 
     * @param modDt 을(를) String modDt로 설정
     */
    public void setModDt(String modDt) {
        this.modDt = modDt;
    }

}
