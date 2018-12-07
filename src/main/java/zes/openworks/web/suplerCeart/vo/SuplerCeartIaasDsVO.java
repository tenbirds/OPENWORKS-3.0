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
public class SuplerCeartIaasDsVO extends PaggingVO {

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

    /** 수요자 여부 */
    private String consumerYn;

    /** 답변 SEQ */
    private int applySeq;

    /** 서버 용도 */
    private String serverUse;
    
    /** 서버 OS */
    private String serverOs;
    
    /** 서버 CPU */
    private String serverCpu;
    
    /** 서버 메모리 */
    private String serverMemory;
    
    /** 서버 디스크 */
    private String serverDisk;
    
    /** 서버 수량 */
    private String serverQnty;
    
    /** 서버 IP */
    private String serverIp;
    
    /** 서버 네트웍트래픽 */
    private String serverNetwork;
    
    /** 서버 GSLB */
    private String serverGslb;
    
    /** 서버 로드밸런스 */
    private String serverLdbl;
    
    /** 서버 스냅샷 */
    private String serverSnap;
    
    /** 서버 이미지 */
    private String serverImg;

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
     * int applySeq을 반환
     * @return int applySeq
     */
    public int getApplySeq() {
        return applySeq;
    }

    
    /**
     * applySeq을 설정
     * @param applySeq 을(를) int applySeq로 설정
     */
    public void setApplySeq(int applySeq) {
        this.applySeq = applySeq;
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
     * String serverIp을 반환
     * @return String serverIp
     */
    public String getServerIp() {
        return serverIp;
    }

    
    /**
     * serverIp을 설정
     * @param serverIp 을(를) String serverIp로 설정
     */
    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }

    
    /**
     * String serverNetwork을 반환
     * @return String serverNetwork
     */
    public String getServerNetwork() {
        return serverNetwork;
    }

    
    /**
     * serverNetwork을 설정
     * @param serverNetwork 을(를) String serverNetwork로 설정
     */
    public void setServerNetwork(String serverNetwork) {
        this.serverNetwork = serverNetwork;
    }

    
    /**
     * String serverGslb을 반환
     * @return String serverGslb
     */
    public String getServerGslb() {
        return serverGslb;
    }

    
    /**
     * serverGslb을 설정
     * @param serverGslb 을(를) String serverGslb로 설정
     */
    public void setServerGslb(String serverGslb) {
        this.serverGslb = serverGslb;
    }

    
    /**
     * String serverLdbl을 반환
     * @return String serverLdbl
     */
    public String getServerLdbl() {
        return serverLdbl;
    }

    
    /**
     * serverLdbl을 설정
     * @param serverLdbl 을(를) String serverLdbl로 설정
     */
    public void setServerLdbl(String serverLdbl) {
        this.serverLdbl = serverLdbl;
    }

    
    /**
     * String serverSnap을 반환
     * @return String serverSnap
     */
    public String getServerSnap() {
        return serverSnap;
    }

    
    /**
     * serverSnap을 설정
     * @param serverSnap 을(를) String serverSnap로 설정
     */
    public void setServerSnap(String serverSnap) {
        this.serverSnap = serverSnap;
    }

    
    /**
     * String serverImg을 반환
     * @return String serverImg
     */
    public String getServerImg() {
        return serverImg;
    }

    
    /**
     * serverImg을 설정
     * @param serverImg 을(를) String serverImg로 설정
     */
    public void setServerImg(String serverImg) {
        this.serverImg = serverImg;
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
