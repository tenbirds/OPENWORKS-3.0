/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;


/**
 * 자동메일 큐 테이블 표현 VO
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일          수정자       수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 14.    김영상       신규
 *</pre>
 * @see
 */
public class AutoMailVO {
    
    /** 발송일련 */
    private Integer sndngSeq;
    /** 자동메일ID */
    private int atmcEmailId;
    /** 발송아이디 */
    private String sndngId = "";
    /** 이메일타이틀 */
    private String emailTitle = "";
    /** 이메일내용 */
    private String emailCn = "";
    /** 송신자명 */
    private String trnsmiterNm = "";
    /** 송신자이메일 */
    private String trnsmiterEmail = "";
    /** 수신자명 */
    private String rcverNm = "";
    /** 수신자이메일 */
    private String rcverEmail = "";
    /** 반송이메일 */
    private String retrnEmail = "";
    /** 1대1치환정보 */
    private String onetooneInfo = "";
    /** 첨부파일아이디 */
    private String atchFileId = "";
    /** 등록아이디 */
    private String registId = "";
    /** 리턴코드 */
    private String resultCode = "";
    /** 리턴메세지 */
    private String resultMsg = "";
    
    /**
     * Integer sndngSeq을 반환
     * @return Integer sndngSeq
     */
    public Integer getSndngSeq() {
        return sndngSeq;
    }
    
    /**
     * sndngSeq을 설정
     * @param sndngSeq 을(를) Integer sndngSeq로 설정
     */
    public void setSndngSeq(Integer sndngSeq) {
        this.sndngSeq = sndngSeq;
    }
    
    /**
     * int atmcEmailId을 반환
     * @return int atmcEmailId
     */
    public int getAtmcEmailId() {
        return atmcEmailId;
    }
    
    /**
     * atmcEmailId을 설정
     * @param atmcEmailId 을(를) int atmcEmailId로 설정
     */
    public void setAtmcEmailId(int atmcEmailId) {
        this.atmcEmailId = atmcEmailId;
    }
    
    /**
     * String sndngId을 반환
     * @return String sndngId
     */
    public String getSndngId() {
        return sndngId;
    }
    
    /**
     * sndngId을 설정
     * @param sndngId 을(를) String sndngId로 설정
     */
    public void setSndngId(String sndngId) {
        this.sndngId = sndngId;
    }
    
    /**
     * String emailTitle을 반환
     * @return String emailTitle
     */
    public String getEmailTitle() {
        return emailTitle;
    }
    
    /**
     * emailTitle을 설정
     * @param emailTitle 을(를) String emailTitle로 설정
     */
    public void setEmailTitle(String emailTitle) {
        this.emailTitle = emailTitle;
    }
    
    /**
     * String emailCn을 반환
     * @return String emailCn
     */
    public String getEmailCn() {
        return emailCn;
    }
    
    /**
     * emailCn을 설정
     * @param emailCn 을(를) String emailCn로 설정
     */
    public void setEmailCn(String emailCn) {
        this.emailCn = emailCn;
    }
    
    /**
     * String trnsmiterNm을 반환
     * @return String trnsmiterNm
     */
    public String getTrnsmiterNm() {
        return trnsmiterNm;
    }
    
    /**
     * trnsmiterNm을 설정
     * @param trnsmiterNm 을(를) String trnsmiterNm로 설정
     */
    public void setTrnsmiterNm(String trnsmiterNm) {
        this.trnsmiterNm = trnsmiterNm;
    }
    
    /**
     * String trnsmiterEmail을 반환
     * @return String trnsmiterEmail
     */
    public String getTrnsmiterEmail() {
        return trnsmiterEmail;
    }
    
    /**
     * trnsmiterEmail을 설정
     * @param trnsmiterEmail 을(를) String trnsmiterEmail로 설정
     */
    public void setTrnsmiterEmail(String trnsmiterEmail) {
        this.trnsmiterEmail = trnsmiterEmail;
    }
    
    /**
     * String rcverNm을 반환
     * @return String rcverNm
     */
    public String getRcverNm() {
        return rcverNm;
    }
    
    /**
     * rcverNm을 설정
     * @param rcverNm 을(를) String rcverNm로 설정
     */
    public void setRcverNm(String rcverNm) {
        this.rcverNm = rcverNm;
    }
    
    /**
     * String rcverEmail을 반환
     * @return String rcverEmail
     */
    public String getRcverEmail() {
        return rcverEmail;
    }
    
    /**
     * rcverEmail을 설정
     * @param rcverEmail 을(를) String rcverEmail로 설정
     */
    public void setRcverEmail(String rcverEmail) {
        this.rcverEmail = rcverEmail;
    }
    
    /**
     * String retrnEmail을 반환
     * @return String retrnEmail
     */
    public String getRetrnEmail() {
        return retrnEmail;
    }
    
    /**
     * retrnEmail을 설정
     * @param retrnEmail 을(를) String retrnEmail로 설정
     */
    public void setRetrnEmail(String retrnEmail) {
        this.retrnEmail = retrnEmail;
    }
    
    /**
     * String onetooneInfo을 반환
     * @return String onetooneInfo
     */
    public String getOnetooneInfo() {
        return onetooneInfo;
    }
    
    /**
     * onetooneInfo을 설정
     * @param onetooneInfo 을(를) String onetooneInfo로 설정
     */
    public void setOnetooneInfo(String onetooneInfo) {
        this.onetooneInfo = onetooneInfo;
    }
    
    /**
     * String atchFileId을 반환
     * @return String atchFileId
     */
    public String getAtchFileId() {
        return atchFileId;
    }
    
    /**
     * atchFileId을 설정
     * @param atchFileId 을(를) String atchFileId로 설정
     */
    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
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
     * String resultCode을 반환
     * @return String resultCode
     */
    public String getResultCode() {
        return resultCode;
    }

    
    /**
     * resultCode을 설정
     * @param resultCode 을(를) String resultCode로 설정
     */
    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    
    /**
     * String resultMsg을 반환
     * @return String resultMsg
     */
    public String getResultMsg() {
        return resultMsg;
    }

    
    /**
     * resultMsg을 설정
     * @param resultMsg 을(를) String resultMsg로 설정
     */
    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }
    


    
}
