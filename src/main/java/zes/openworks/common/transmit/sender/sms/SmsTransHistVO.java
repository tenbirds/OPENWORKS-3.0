/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.sms;


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
 * 2014. 11. 21.    김영상       신규
 *</pre>
 * @see
 */
public class SmsTransHistVO {
    /** 발송일련 */
    private Integer sndngSeq;
    /** 수신휴대폰번호 */
    private String rcverMbtlnum;
    /** 발송자연락처 */
    private String senderTelno;
    /** 발송메시지 */
    private String sndngMssage;
    /** 발송업무구분코드 */
    private String sndngDutySeCode;
    /** 등록일시 */
    private String registDt;
    
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
     * String rcverMbtlnum을 반환
     * @return String rcverMbtlnum
     */
    public String getRcverMbtlnum() {
        return rcverMbtlnum;
    }
    
    /**
     * rcverMbtlnum을 설정
     * @param rcverMbtlnum 을(를) String rcverMbtlnum로 설정
     */
    public void setRcverMbtlnum(String rcverMbtlnum) {
        this.rcverMbtlnum = rcverMbtlnum;
    }
    
    /**
     * String senderTelno을 반환
     * @return String senderTelno
     */
    public String getSenderTelno() {
        return senderTelno;
    }
    
    /**
     * senderTelno을 설정
     * @param senderTelno 을(를) String senderTelno로 설정
     */
    public void setSenderTelno(String senderTelno) {
        this.senderTelno = senderTelno;
    }
    
    /**
     * String sndngMssage을 반환
     * @return String sndngMssage
     */
    public String getSndngMssage() {
        return sndngMssage;
    }
    
    /**
     * sndngMssage을 설정
     * @param sndngMssage 을(를) String sndngMssage로 설정
     */
    public void setSndngMssage(String sndngMssage) {
        this.sndngMssage = sndngMssage;
    }
    
    /**
     * String sndngDutySeCode을 반환
     * @return String sndngDutySeCode
     */
    public String getSndngDutySeCode() {
        return sndngDutySeCode;
    }
    
    /**
     * sndngDutySeCode을 설정
     * @param sndngDutySeCode 을(를) String sndngDutySeCode로 설정
     */
    public void setSndngDutySeCode(String sndngDutySeCode) {
        this.sndngDutySeCode = sndngDutySeCode;
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
    
    
}
