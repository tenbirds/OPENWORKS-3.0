/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bid;

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
public class BidSuplerListVO extends PaggingVO {


    /**  */
    private static final long serialVersionUID = 1L;
    
    /** 수요자ID */
    private String userId;
    
    /** 구매희망목록 순번 */
    private String grpSeq;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 공고명*/
    private String bidNotifyNm;
    
    
    /** 공급자ID */
    private String suplerId;
    
    /** 공급자이름 */
    private String suplerName;
    
    /** 공급자이메일*/
    private String suplerEmail;
    
    /** 공급자전화번호 */
    private String suplerMbtlnum;


    /** 공고의 계약방법(2040) */
    private String cntrMothod;

    
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
     * String grpSeq을 반환
     * @return String grpSeq
     */
    public String getGrpSeq() {
        return grpSeq;
    }

    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) String grpSeq로 설정
     */
    public void setGrpSeq(String grpSeq) {
        this.grpSeq = grpSeq;
    }

    
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
     * String bidNotifyNm을 반환
     * @return String bidNotifyNm
     */
    public String getBidNotifyNm() {
        return bidNotifyNm;
    }


    
    /**
     * bidNotifyNm을 설정
     * @param bidNotifyNm 을(를) String bidNotifyNm로 설정
     */
    public void setBidNotifyNm(String bidNotifyNm) {
        this.bidNotifyNm = bidNotifyNm;
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
     * String suplerName을 반환
     * @return String suplerName
     */
    public String getSuplerName() {
        return suplerName;
    }

    
    /**
     * suplerName을 설정
     * @param suplerName 을(를) String suplerName로 설정
     */
    public void setSuplerName(String suplerName) {
        this.suplerName = suplerName;
    }

       
    
    /**
     * String suplerEmail을 반환
     * @return String suplerEmail
     */
    public String getSuplerEmail() {
        return suplerEmail;
    }


    
    /**
     * suplerEmail을 설정
     * @param suplerEmail 을(를) String suplerEmail로 설정
     */
    public void setSuplerEmail(String suplerEmail) {
        this.suplerEmail = suplerEmail;
    }


    /**
     * String suplerMbtlnum을 반환
     * @return String suplerMbtlnum
     */
    public String getSuplerMbtlnum() {
        return suplerMbtlnum;
    }


    
    /**
     * suplerMbtlnum을 설정
     * @param suplerMbtlnum 을(를) String suplerMbtlnum로 설정
     */
    public void setSuplerMbtlnum(String suplerMbtlnum) {
        this.suplerMbtlnum = suplerMbtlnum;
    }


    /**
     * String cntrMothod을 반환
     * @return String cntrMothod
     */
    public String getCntrMothod() {
        return cntrMothod;
    }

    
    /**
     * cntrMothod을 설정
     * @param cntrMothod 을(를) String cntrMothod로 설정
     */
    public void setCntrMothod(String cntrMothod) {
        this.cntrMothod = cntrMothod;
    }

}
