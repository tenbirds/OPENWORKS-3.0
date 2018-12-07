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
 *  2018. 03.     이홍석       신규
 * </pre>
 * @see
 */
public class SuplerCeartSaas2IVO extends PaggingVO {

    private static final long serialVersionUID = 1L;

    private String notifyNum;       /** 공고번호 */    
    private int notifySeq;          /** 공고순번 */    
    private String endsUserId;      /** 수요자아이디 */    
    private String suplerId;        /** 공급자아이디 */    
    private String consumerYn;      /** 수요자여부 */    
    private String applyGbn;        /** 답변여부 */
    
    private String supportMethod;           /** 제공방법             */
    private String supportMethodNm;         /** 제공방법_명          */
    private String userManagerSeparate;     /** 사용자/관리자 분리   */
    private String userManagerSeparateNm;   /** 사용자/관리자 분리_명  */
    private String serviceSupplyMethod;     /** 서비스제공방식       */                         
    private String serviceSupplyMethodNm;   /** 서비스제공방식_명    */
    private String encryption;              /** 암호화               */                
    private String encryptionNm;            /** 암호화_명            */                
    private String multiPlatform;           /** 다중플랫폼지원       */
    
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
     * String supportMethod을 반환
     * @return String supportMethod
     */
    public String getSupportMethod() {
        return supportMethod;
    }


    
    /**
     * supportMethod을 설정
     * @param supportMethod 을(를) String supportMethod로 설정
     */
    public void setSupportMethod(String supportMethod) {
        this.supportMethod = supportMethod;
    }


    
    /**
     * String supportMethodNm을 반환
     * @return String supportMethodNm
     */
    public String getSupportMethodNm() {
        return supportMethodNm;
    }


    /**
     * supportMethodNm을 설정
     * @param supportMethodNm 을(를) String supportMethodNm로 설정
     */
    public void setSupportMethodNm(String supportMethodNm) {
        this.supportMethodNm = supportMethodNm;
    }


    /**
     * String userManagerSeparate을 반환
     * @return String userManagerSeparate
     */
    public String getUserManagerSeparate() {
        return userManagerSeparate;
    }


    
    /**
     * userManagerSeparate을 설정
     * @param userManagerSeparate 을(를) String userManagerSeparate로 설정
     */
    public void setUserManagerSeparate(String userManagerSeparate) {
        this.userManagerSeparate = userManagerSeparate;
    }


    
    /**
     * String userManagerSeparateNm을 반환
     * @return String userManagerSeparateNm
     */
    public String getUserManagerSeparateNm() {
        return userManagerSeparateNm;
    }


    /**
     * userManagerSeparateNm을 설정
     * @param userManagerSeparateNm 을(를) String userManagerSeparateNm로 설정
     */
    public void setUserManagerSeparateNm(String userManagerSeparateNm) {
        this.userManagerSeparateNm = userManagerSeparateNm;
    }


    /**
     * String serviceSupplyMethod을 반환
     * @return String serviceSupplyMethod
     */
    public String getServiceSupplyMethod() {
        return serviceSupplyMethod;
    }


    
    /**
     * serviceSupplyMethod을 설정
     * @param serviceSupplyMethod 을(를) String serviceSupplyMethod로 설정
     */
    public void setServiceSupplyMethod(String serviceSupplyMethod) {
        this.serviceSupplyMethod = serviceSupplyMethod;
    }


    
    /**
     * String serviceSupplyMethodNm을 반환
     * @return String serviceSupplyMethodNm
     */
    public String getServiceSupplyMethodNm() {
        return serviceSupplyMethodNm;
    }


    
    /**
     * serviceSupplyMethodNm을 설정
     * @param serviceSupplyMethodNm 을(를) String serviceSupplyMethodNm로 설정
     */
    public void setServiceSupplyMethodNm(String serviceSupplyMethodNm) {
        this.serviceSupplyMethodNm = serviceSupplyMethodNm;
    }


    
    /**
     * String encryption을 반환
     * @return String encryption
     */
    public String getEncryption() {
        return encryption;
    }


    
    /**
     * encryption을 설정
     * @param encryption 을(를) String encryption로 설정
     */
    public void setEncryption(String encryption) {
        this.encryption = encryption;
    }


    
    /**
     * String encryptionNm을 반환
     * @return String encryptionNm
     */
    public String getEncryptionNm() {
        return encryptionNm;
    }


    
    /**
     * encryptionNm을 설정
     * @param encryptionNm 을(를) String encryptionNm로 설정
     */
    public void setEncryptionNm(String encryptionNm) {
        this.encryptionNm = encryptionNm;
    }


    
    /**
     * String multiPlatform을 반환
     * @return String multiPlatform
     */
    public String getMultiPlatform() {
        return multiPlatform;
    }


    
    /**
     * multiPlatform을 설정
     * @param multiPlatform 을(를) String multiPlatform로 설정
     */
    public void setMultiPlatform(String multiPlatform) {
        this.multiPlatform = multiPlatform;
    }

}
