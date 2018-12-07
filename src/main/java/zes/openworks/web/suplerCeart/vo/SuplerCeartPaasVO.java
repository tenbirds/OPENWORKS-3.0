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
public class SuplerCeartPaasVO extends PaggingVO {

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
    
    /** 수요자여부 */
    private String consumerYn;
    
    /** 답변여부 */
    private String applyGbn;

    /** Language */
    private String langSys;

    /** Framework */
    private String frameworkSys;

    /** Cache */
    private String cacheSys;

    /** DBMS */
    private String dbmsSys;

    /** Fast Deploy */
    private String fastDeploySys;

    /** Etc */
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
