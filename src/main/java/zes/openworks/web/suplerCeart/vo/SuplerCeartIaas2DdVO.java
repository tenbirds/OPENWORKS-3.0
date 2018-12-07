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
 *  2018. 03.      이홍석       신규
 * </pre>
 * @see
 */
public class SuplerCeartIaas2DdVO extends PaggingVO 
{
 
    private static final long serialVersionUID = 1L;

    private String notifyNum;       /** 공고번호 */        
    private int notifySeq;          /** 공고순번 */     
    private String endsUserId;      /** 수요자아이디 */         
    private String suplerId;        /** 공급자아이디 */       
    private String consumerYn;      /** 수요자 여부 */     
    private int dbSeq;           /** 데이터베이스 SEQ */
    
    private String dbUse;           /** DB 용도 */
    private String dbOs;            /** DB OS */
    private String dbCpu;           /** DB CPU */
    private String dbMemory;        /** DB 메모리 */
    private String dbDisk;          /** DB 디스크 */
    private String dbQnty;          /** DB 수량 */
    
    private String applyYn;         /** 답변여부 */  
    
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
     * int dbSeq을 반환
     * @return int dbSeq
     */
    public int getDbSeq() {
        return dbSeq;
    }


    /**
     * dbSeq을 설정
     * @param dbSeq 을(를) int dbSeq로 설정
     */
    public void setDbSeq(int dbSeq) {
        this.dbSeq = dbSeq;
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
