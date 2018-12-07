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
public class MyCeartIaasDdVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 사용자아이디 */
    private String userId;
    
    /** 공급자아이디 */
    private String langStoreId;

    /** 수요자 여부 */
    private String consumerYn;

    /** 답변 SEQ */
    private int applySeq;

    /** DB 용도 */
    private String dbUse;
    
    /** DB OS */
    private String dbOs;
    
    /** DB CPU */
    private String dbCpu;
    
    /** DB 메모리 */
    private String dbMemory;
    
    /** DB 디스크 */
    private String dbDisk;
    
    /** DB 수량 */
    private String dbQnty;
    
    /** DB IP */
    private String dbIp;
    
    /** DB 네트웍트래픽 */
    private String dbNetwork;
    
    /** DB 추가디스크 */
    private String dbAddDisk;
    
    /** DB 백업스토리지 */
    private String dbBackStorg;
    
    /** DB 저장공간 */
    private String dbStorgSpace;
    
    /** DB 전송량 */
    private String dbTransVlmn;

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
     * String dbUse을 반환
     * @return String dbUse
     */
    public String getDbUse() {
        return dbUse;
    }

    
    /**
     * dbUse을 설정
     * @param dbUse 을(를) String dbUse로 설정
     */
    public void setDbUse(String dbUse) {
        this.dbUse = dbUse;
    }

    
    /**
     * String dbOs을 반환
     * @return String dbOs
     */
    public String getDbOs() {
        return dbOs;
    }

    
    /**
     * dbOs을 설정
     * @param dbOs 을(를) String dbOs로 설정
     */
    public void setDbOs(String dbOs) {
        this.dbOs = dbOs;
    }

    
    /**
     * String dbCpu을 반환
     * @return String dbCpu
     */
    public String getDbCpu() {
        return dbCpu;
    }

    
    /**
     * dbCpu을 설정
     * @param dbCpu 을(를) String dbCpu로 설정
     */
    public void setDbCpu(String dbCpu) {
        this.dbCpu = dbCpu;
    }

    
    /**
     * String dbMemory을 반환
     * @return String dbMemory
     */
    public String getDbMemory() {
        return dbMemory;
    }

    
    /**
     * dbMemory을 설정
     * @param dbMemory 을(를) String dbMemory로 설정
     */
    public void setDbMemory(String dbMemory) {
        this.dbMemory = dbMemory;
    }

    
    /**
     * String dbDisk을 반환
     * @return String dbDisk
     */
    public String getDbDisk() {
        return dbDisk;
    }

    
    /**
     * dbDisk을 설정
     * @param dbDisk 을(를) String dbDisk로 설정
     */
    public void setDbDisk(String dbDisk) {
        this.dbDisk = dbDisk;
    }

    
    /**
     * String dbQnty을 반환
     * @return String dbQnty
     */
    public String getDbQnty() {
        return dbQnty;
    }

    
    /**
     * dbQnty을 설정
     * @param dbQnty 을(를) String dbQnty로 설정
     */
    public void setDbQnty(String dbQnty) {
        this.dbQnty = dbQnty;
    }

    
    /**
     * String dbIp을 반환
     * @return String dbIp
     */
    public String getDbIp() {
        return dbIp;
    }

    
    /**
     * dbIp을 설정
     * @param dbIp 을(를) String dbIp로 설정
     */
    public void setDbIp(String dbIp) {
        this.dbIp = dbIp;
    }

    
    /**
     * String dbNetwork을 반환
     * @return String dbNetwork
     */
    public String getDbNetwork() {
        return dbNetwork;
    }

    
    /**
     * dbNetwork을 설정
     * @param dbNetwork 을(를) String dbNetwork로 설정
     */
    public void setDbNetwork(String dbNetwork) {
        this.dbNetwork = dbNetwork;
    }

    
    /**
     * String dbAddDisk을 반환
     * @return String dbAddDisk
     */
    public String getDbAddDisk() {
        return dbAddDisk;
    }

    
    /**
     * dbAddDisk을 설정
     * @param dbAddDisk 을(를) String dbAddDisk로 설정
     */
    public void setDbAddDisk(String dbAddDisk) {
        this.dbAddDisk = dbAddDisk;
    }

    
    /**
     * String dbBackStorg을 반환
     * @return String dbBackStorg
     */
    public String getDbBackStorg() {
        return dbBackStorg;
    }

    
    /**
     * dbBackStorg을 설정
     * @param dbBackStorg 을(를) String dbBackStorg로 설정
     */
    public void setDbBackStorg(String dbBackStorg) {
        this.dbBackStorg = dbBackStorg;
    }

    
    /**
     * String dbStorgSpace을 반환
     * @return String dbStorgSpace
     */
    public String getDbStorgSpace() {
        return dbStorgSpace;
    }

    
    /**
     * dbStorgSpace을 설정
     * @param dbStorgSpace 을(를) String dbStorgSpace로 설정
     */
    public void setDbStorgSpace(String dbStorgSpace) {
        this.dbStorgSpace = dbStorgSpace;
    }

    
    /**
     * String dbTransVlmn을 반환
     * @return String dbTransVlmn
     */
    public String getDbTransVlmn() {
        return dbTransVlmn;
    }

    
    /**
     * dbTransVlmn을 설정
     * @param dbTransVlmn 을(를) String dbTransVlmn로 설정
     */
    public void setDbTransVlmn(String dbTransVlmn) {
        this.dbTransVlmn = dbTransVlmn;
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
