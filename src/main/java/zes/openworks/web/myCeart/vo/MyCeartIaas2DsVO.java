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
 *  2014. 10. 22.    이슬버미       신규
 * </pre>
 * @see
 */
public class MyCeartIaas2DsVO extends PaggingVO 
{

    private static final long serialVersionUID = 1L;

    private String notifyNum;             /** 공고번호 */    
    private int notifySeq;                /** 공고순번 */    
    private String userId;                /** 사용자아이디 */    
    private String langStoreId;           /** 공급자아이디 */    
    private String consumerYn;            /** 수요자 여부 */    
    private int serverSeq;                /** 서버 SEQ */
    
    private String serverUse;             /** 서버 용도 */    
    private String serverOs;              /** 서버 OS */    
    private String serverCpu;             /** 서버 CPU */    
    private String serverMemory;          /** 서버 메모리 */    
    private String serverDisk;            /** 서버 디스크 */    
    private String serverQnty;            /** 서버 수량 */    
        
    private String applyYn;               /** 답변여부 */

    
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
     * int serverSeq을 반환
     * @return int serverSeq
     */
    public int getServerSeq() {
        return serverSeq;
    }

    
    /**
     * serverSeq을 설정
     * @param serverSeq 을(를) int serverSeq로 설정
     */
    public void setServerSeq(int serverSeq) {
        this.serverSeq = serverSeq;
    }

    
    /**
     * String serverUse을 반환
     * @return String serverUse
     */
    public String getServerUse() {
        return serverUse;
    }

    
    /**
     * serverUse을 설정
     * @param serverUse 을(를) String serverUse로 설정
     */
    public void setServerUse(String serverUse) {
        this.serverUse = serverUse;
    }

    
    /**
     * String serverOs을 반환
     * @return String serverOs
     */
    public String getServerOs() {
        return serverOs;
    }

    
    /**
     * serverOs을 설정
     * @param serverOs 을(를) String serverOs로 설정
     */
    public void setServerOs(String serverOs) {
        this.serverOs = serverOs;
    }

    
    /**
     * String serverCpu을 반환
     * @return String serverCpu
     */
    public String getServerCpu() {
        return serverCpu;
    }

    
    /**
     * serverCpu을 설정
     * @param serverCpu 을(를) String serverCpu로 설정
     */
    public void setServerCpu(String serverCpu) {
        this.serverCpu = serverCpu;
    }

    
    /**
     * String serverMemory을 반환
     * @return String serverMemory
     */
    public String getServerMemory() {
        return serverMemory;
    }

    
    /**
     * serverMemory을 설정
     * @param serverMemory 을(를) String serverMemory로 설정
     */
    public void setServerMemory(String serverMemory) {
        this.serverMemory = serverMemory;
    }

    
    /**
     * String serverDisk을 반환
     * @return String serverDisk
     */
    public String getServerDisk() {
        return serverDisk;
    }

    
    /**
     * serverDisk을 설정
     * @param serverDisk 을(를) String serverDisk로 설정
     */
    public void setServerDisk(String serverDisk) {
        this.serverDisk = serverDisk;
    }

    
    /**
     * String serverQnty을 반환
     * @return String serverQnty
     */
    public String getServerQnty() {
        return serverQnty;
    }

    
    /**
     * serverQnty을 설정
     * @param serverQnty 을(를) String serverQnty로 설정
     */
    public void setServerQnty(String serverQnty) {
        this.serverQnty = serverQnty;
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
