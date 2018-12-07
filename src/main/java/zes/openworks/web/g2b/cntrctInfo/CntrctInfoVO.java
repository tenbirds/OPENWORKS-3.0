/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.cntrctInfo;

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
public class CntrctInfoVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 8066298618131160918L;
    
    /* 통합계약번호 */
    private String cntrctUnionNo; 
    /* 계약번호 */
    private String cntrctNo; 
    /* 계약건명 */
    private String cntrctNm; 
    /* 계약구분 */
    private String cntrctType; 
    /* 계약방법 */
    private String cntrctMth; 
    /* 계약일자 */
    private String cntrctDate; 
    /* 계약기간 */
    private String cntrctPd; 
    /* 총계약금액 */
    private String cntrctAmt; 
    /* 금차계약금액 */
    private String cntrctThisTimeAmt;
    /* 공고번호 */
    private String bidNotifyNo; 
    /* 발주기관명 */
    private String orderOrgnNm; 
    /* 기관구분코드 */
    private String realOrgnCode; 
    /* 기관(업체)명 - 수요기관 */
    private String realOrgnNm; 
    /* 계약업체구분 */
    private String mainCntrctEntrpsType; 
    /* 주계약업체명 */
    private String mainCntrctEntrpsNm; 
    /* 송신자ID */
    private String senderId;
    /* 문서코드 */
    private String messType;
    /* 문서명 */
    private String messNm;
    /* 문서관리번호 */
    private String docuMangNo;
    

    
    /**
     * String cntrctUnionNo을 반환
     * @return String cntrctUnionNo
     */
    public String getCntrctUnionNo() {
        return cntrctUnionNo;
    }


    
    /**
     * cntrctUnionNo을 설정
     * @param cntrctUnionNo 을(를) String cntrctUnionNo로 설정
     */
    public void setCntrctUnionNo(String cntrctUnionNo) {
        this.cntrctUnionNo = cntrctUnionNo;
    }


    
    /**
     * String cntrctNo을 반환
     * @return String cntrctNo
     */
    public String getCntrctNo() {
        return cntrctNo;
    }


    
    /**
     * cntrctNo을 설정
     * @param cntrctNo 을(를) String cntrctNo로 설정
     */
    public void setCntrctNo(String cntrctNo) {
        this.cntrctNo = cntrctNo;
    }


    
    /**
     * String cntrctNm을 반환
     * @return String cntrctNm
     */
    public String getCntrctNm() {
        return cntrctNm;
    }


    
    /**
     * cntrctNm을 설정
     * @param cntrctNm 을(를) String cntrctNm로 설정
     */
    public void setCntrctNm(String cntrctNm) {
        this.cntrctNm = cntrctNm;
    }


    
    /**
     * String cntrctType을 반환
     * @return String cntrctType
     */
    public String getCntrctType() {
        return cntrctType;
    }


    
    /**
     * cntrctType을 설정
     * @param cntrctType 을(를) String cntrctType로 설정
     */
    public void setCntrctType(String cntrctType) {
        this.cntrctType = cntrctType;
    }


    
    /**
     * String cntrctMth을 반환
     * @return String cntrctMth
     */
    public String getCntrctMth() {
        return cntrctMth;
    }


    
    /**
     * cntrctMth을 설정
     * @param cntrctMth 을(를) String cntrctMth로 설정
     */
    public void setCntrctMth(String cntrctMth) {
        this.cntrctMth = cntrctMth;
    }


    
    /**
     * String cntrctDate을 반환
     * @return String cntrctDate
     */
    public String getCntrctDate() {
        return cntrctDate;
    }


    
    /**
     * cntrctDate을 설정
     * @param cntrctDate 을(를) String cntrctDate로 설정
     */
    public void setCntrctDate(String cntrctDate) {
        this.cntrctDate = cntrctDate;
    }


    
    /**
     * String cntrctPd을 반환
     * @return String cntrctPd
     */
    public String getCntrctPd() {
        return cntrctPd;
    }


    
    /**
     * cntrctPd을 설정
     * @param cntrctPd 을(를) String cntrctPd로 설정
     */
    public void setCntrctPd(String cntrctPd) {
        this.cntrctPd = cntrctPd;
    }


    
    /**
     * String cntrctAmt을 반환
     * @return String cntrctAmt
     */
    public String getCntrctAmt() {
        return cntrctAmt;
    }


    
    /**
     * cntrctAmt을 설정
     * @param cntrctAmt 을(를) String cntrctAmt로 설정
     */
    public void setCntrctAmt(String cntrctAmt) {
        this.cntrctAmt = cntrctAmt;
    }


    
    /**
     * String bidNotifyNo을 반환
     * @return String bidNotifyNo
     */
    public String getBidNotifyNo() {
        return bidNotifyNo;
    }


    
    /**
     * bidNotifyNo을 설정
     * @param bidNotifyNo 을(를) String bidNotifyNo로 설정
     */
    public void setBidNotifyNo(String bidNotifyNo) {
        this.bidNotifyNo = bidNotifyNo;
    }

    
    /**
     * String orderOrgnNm을 반환
     * @return String orderOrgnNm
     */
    public String getOrderOrgnNm() {
        return orderOrgnNm;
    }


    
    /**
     * orderOrgnNm을 설정
     * @param orderOrgnNm 을(를) String orderOrgnNm로 설정
     */
    public void setOrderOrgnNm(String orderOrgnNm) {
        this.orderOrgnNm = orderOrgnNm;
    }


    
    /**
     * String realOrgnCode을 반환
     * @return String realOrgnCode
     */
    public String getRealOrgnCode() {
        return realOrgnCode;
    }


    
    /**
     * realOrgnCode을 설정
     * @param realOrgnCode 을(를) String realOrgnCode로 설정
     */
    public void setRealOrgnCode(String realOrgnCode) {
        this.realOrgnCode = realOrgnCode;
    }


    
    /**
     * String realOrgnNm을 반환
     * @return String realOrgnNm
     */
    public String getRealOrgnNm() {
        return realOrgnNm;
    }


    
    /**
     * realOrgnNm을 설정
     * @param realOrgnNm 을(를) String realOrgnNm로 설정
     */
    public void setRealOrgnNm(String realOrgnNm) {
        this.realOrgnNm = realOrgnNm;
    }


    
    /**
     * String mainCntrctEntrpsType을 반환
     * @return String mainCntrctEntrpsType
     */
    public String getMainCntrctEntrpsType() {
        return mainCntrctEntrpsType;
    }


    
    /**
     * mainCntrctEntrpsType을 설정
     * @param mainCntrctEntrpsType 을(를) String mainCntrctEntrpsType로 설정
     */
    public void setMainCntrctEntrpsType(String mainCntrctEntrpsType) {
        this.mainCntrctEntrpsType = mainCntrctEntrpsType;
    }


    
    /**
     * String mainCntrctEntrpsNm을 반환
     * @return String mainCntrctEntrpsNm
     */
    public String getMainCntrctEntrpsNm() {
        return mainCntrctEntrpsNm;
    }


    
    /**
     * mainCntrctEntrpsNm을 설정
     * @param mainCntrctEntrpsNm 을(를) String mainCntrctEntrpsNm로 설정
     */
    public void setMainCntrctEntrpsNm(String mainCntrctEntrpsNm) {
        this.mainCntrctEntrpsNm = mainCntrctEntrpsNm;
    }


    
    /**
     * String senderId을 반환
     * @return String senderId
     */
    public String getSenderId() {
        return senderId;
    }


    
    /**
     * senderId을 설정
     * @param senderId 을(를) String senderId로 설정
     */
    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }


    
    /**
     * String messType을 반환
     * @return String messType
     */
    public String getMessType() {
        return messType;
    }


    
    /**
     * messType을 설정
     * @param messType 을(를) String messType로 설정
     */
    public void setMessType(String messType) {
        this.messType = messType;
    }


    
    /**
     * String messNm을 반환
     * @return String messNm
     */
    public String getMessNm() {
        return messNm;
    }


    
    /**
     * messNm을 설정
     * @param messNm 을(를) String messNm로 설정
     */
    public void setMessNm(String messNm) {
        this.messNm = messNm;
    }


    
    /**
     * String docuMangNo을 반환
     * @return String docuMangNo
     */
    public String getDocuMangNo() {
        return docuMangNo;
    }


    
    /**
     * docuMangNo을 설정
     * @param docuMangNo 을(를) String docuMangNo로 설정
     */
    public void setDocuMangNo(String docuMangNo) {
        this.docuMangNo = docuMangNo;
    }



    /**
     * String cntrctThisTimeAmt을 반환
     * @return String cntrctThisTimeAmt
     */
    public String getCntrctThisTimeAmt() {
        return cntrctThisTimeAmt;
    }



    /**
     * cntrctThisTimeAmt을 설정
     * @param cntrctThisTimeAmt 을(를) String cntrctThisTimeAmt로 설정
     */
    public void setCntrctThisTimeAmt(String cntrctThisTimeAmt) {
        this.cntrctThisTimeAmt = cntrctThisTimeAmt;
    }
    
}
