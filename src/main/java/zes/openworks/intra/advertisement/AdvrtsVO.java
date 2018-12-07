/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.advertisement;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 7.    김영상       신규
 *</pre>
 * @see
 */
public class AdvrtsVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 8312655580969239502L;

    /** 광고의뢰인일련번호 */
    private Integer advrtsClientSeq;
    
    /** 광고의뢰업체명 */
    private String advrtsReqestEntrpsNm;
    
    /** 담당자명 */
    private String advrtsChargerNm;
    
    /** 담당자전화번호 */
    private String advrtsChargerTelno;
    
    /** 담당자이메일 */
    private String advrtsChargerEmail;
    
    /** 담당자휴대전화 */
    private String advrtsChargerMbtlnum;
    
    /** 등록자ID */
    private String registId;
    
    /** 등록일시 */
    private String registDt;
    
    /** 수정자ID */
    private String updtId;
    
    /** 수정일시 */
    private String updtDt;
    
    /** 삭제여부 */
    private String deleteAt;

    
    /**
     * Integer advrtsClientSeq을 반환
     * @return Integer advrtsClientSeq
     */
    public Integer getAdvrtsClientSeq() {
        return advrtsClientSeq;
    }

    
    /**
     * advrtsClientSeq을 설정
     * @param advrtsClientSeq 을(를) Integer advrtsClientSeq로 설정
     */
    public void setAdvrtsClientSeq(Integer advrtsClientSeq) {
        this.advrtsClientSeq = advrtsClientSeq;
    }

    
    /**
     * String advrtsReqestEntrpsNm을 반환
     * @return String advrtsReqestEntrpsNm
     */
    public String getAdvrtsReqestEntrpsNm() {
        return advrtsReqestEntrpsNm;
    }

    
    /**
     * advrtsReqestEntrpsNm을 설정
     * @param advrtsReqestEntrpsNm 을(를) String advrtsReqestEntrpsNm로 설정
     */
    public void setAdvrtsReqestEntrpsNm(String advrtsReqestEntrpsNm) {
        this.advrtsReqestEntrpsNm = advrtsReqestEntrpsNm;
    }

    
    /**
     * String advrtsChargerNm을 반환
     * @return String advrtsChargerNm
     */
    public String getAdvrtsChargerNm() {
        return advrtsChargerNm;
    }

    
    /**
     * advrtsChargerNm을 설정
     * @param advrtsChargerNm 을(를) String advrtsChargerNm로 설정
     */
    public void setAdvrtsChargerNm(String advrtsChargerNm) {
        this.advrtsChargerNm = advrtsChargerNm;
    }

    
    /**
     * String advrtsChargerTelno을 반환
     * @return String advrtsChargerTelno
     */
    public String getAdvrtsChargerTelno() {
        return advrtsChargerTelno;
    }

    
    /**
     * advrtsChargerTelno을 설정
     * @param advrtsChargerTelno 을(를) String advrtsChargerTelno로 설정
     */
    public void setAdvrtsChargerTelno(String advrtsChargerTelno) {
        this.advrtsChargerTelno = advrtsChargerTelno;
    }

    
    /**
     * String advrtsChargerEmail을 반환
     * @return String advrtsChargerEmail
     */
    public String getAdvrtsChargerEmail() {
        return advrtsChargerEmail;
    }

    
    /**
     * advrtsChargerEmail을 설정
     * @param advrtsChargerEmail 을(를) String advrtsChargerEmail로 설정
     */
    public void setAdvrtsChargerEmail(String advrtsChargerEmail) {
        this.advrtsChargerEmail = advrtsChargerEmail;
    }

    
    /**
     * String advrtsChargerMbtlnum을 반환
     * @return String advrtsChargerMbtlnum
     */
    public String getAdvrtsChargerMbtlnum() {
        return advrtsChargerMbtlnum;
    }

    
    /**
     * advrtsChargerMbtlnum을 설정
     * @param advrtsChargerMbtlnum 을(를) String advrtsChargerMbtlnum로 설정
     */
    public void setAdvrtsChargerMbtlnum(String advrtsChargerMbtlnum) {
        this.advrtsChargerMbtlnum = advrtsChargerMbtlnum;
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
     * String updtId을 반환
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }

    
    /**
     * updtId을 설정
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    
    /**
     * String updtDt을 반환
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }

    
    /**
     * updtDt을 설정
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    
    /**
     * String deleteAt을 반환
     * @return String deleteAt
     */
    public String getDeleteAt() {
        return deleteAt;
    }

    
    /**
     * deleteAt을 설정
     * @param deleteAt 을(를) String deleteAt로 설정
     */
    public void setDeleteAt(String deleteAt) {
        this.deleteAt = deleteAt;
    }
}
