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
public class BidPaasInfoVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;
    
    /** 수요자ID */
    private String userId;

    /** 답변여부 */
    private String applyGbn;
    
    /** language */
    private String langSys;

    /** framework */
    private String frameworkSys;
    
    /** cache */
    private String cacheSys;
    
    /** dbms */
    private String dbmsSys;
    
    /** fast deploy */
    private String fastDeploySys;

    /** etc */
    private String etcSys;

    
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
     * String langSys을 반환
     * @return String langSys
     */
    public String getLangSys() {
        return langSys;
    }

    
    /**
     * langSys을 설정
     * @param langSys 을(를) String langSys로 설정
     */
    public void setLangSys(String langSys) {
        this.langSys = langSys;
    }

    
    /**
     * String frameworkSys을 반환
     * @return String frameworkSys
     */
    public String getFrameworkSys() {
        return frameworkSys;
    }

    
    /**
     * frameworkSys을 설정
     * @param frameworkSys 을(를) String frameworkSys로 설정
     */
    public void setFrameworkSys(String frameworkSys) {
        this.frameworkSys = frameworkSys;
    }

    
    /**
     * String cacheSys을 반환
     * @return String cacheSys
     */
    public String getCacheSys() {
        return cacheSys;
    }

    
    /**
     * cacheSys을 설정
     * @param cacheSys 을(를) String cacheSys로 설정
     */
    public void setCacheSys(String cacheSys) {
        this.cacheSys = cacheSys;
    }

    
    /**
     * String dbmsSys을 반환
     * @return String dbmsSys
     */
    public String getDbmsSys() {
        return dbmsSys;
    }

    
    /**
     * dbmsSys을 설정
     * @param dbmsSys 을(를) String dbmsSys로 설정
     */
    public void setDbmsSys(String dbmsSys) {
        this.dbmsSys = dbmsSys;
    }

    
    /**
     * String fastDeploySys을 반환
     * @return String fastDeploySys
     */
    public String getFastDeploySys() {
        return fastDeploySys;
    }

    
    /**
     * fastDeploySys을 설정
     * @param fastDeploySys 을(를) String fastDeploySys로 설정
     */
    public void setFastDeploySys(String fastDeploySys) {
        this.fastDeploySys = fastDeploySys;
    }

    
    /**
     * String etcSys을 반환
     * @return String etcSys
     */
    public String getEtcSys() {
        return etcSys;
    }

    
    /**
     * etcSys을 설정
     * @param etcSys 을(를) String etcSys로 설정
     */
    public void setEtcSys(String etcSys) {
        this.etcSys = etcSys;
    }

}
