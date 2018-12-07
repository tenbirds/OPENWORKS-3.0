/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.code;

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
 *  2012. 5. 9.    이찬희   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class LoggingCodeVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -2449263717740464785L;

    private Integer grpCd;

    private Integer prvCd;

    /**
     * logging date
     */
    private String logDt;

    /**
     * logging type
     */
    private String logType;

    private String changeType;

    private String changeResutl;

    private String modId;

    
    /**  언어코드  */
    private String langCode;
    /**  언어명  */
    private String langNm;
    /**  도메인코드  */
    private Integer domainCd;
    /**  언어영문약어  */
    private String langEngAbb;
    /**  언어영문명  */
    private String langEngNm;
    /**  비고  */
    private String rm;
    
    
    public String getLogDt() {
        return logDt;
    }

    public Integer getGrpCd() {
        return grpCd;
    }

    public void setGrpCd(Integer grpCd) {
        this.grpCd = grpCd;
    }

    public Integer getPrvCd() {
        return prvCd;
    }

    public void setPrvCd(Integer prvCd) {
        this.prvCd = prvCd;
    }

    public void setLogDt(String logDt) {
        this.logDt = logDt;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getChangeType() {
        return changeType;
    }

    public void setChangeType(String changeType) {
        this.changeType = changeType;
    }

    public String getChangeResutl() {
        return changeResutl;
    }

    public void setChangeResutl(String changeResutl) {
        this.changeResutl = changeResutl;
    }

    public String getModId() {
        return modId;
    }

    public void setModId(String modId) {
        this.modId = modId;
    }

    
    /**
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    
    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    
    /**
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    
    /**
     * Integer domainCd을 반환
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    
    /**
     * domainCd을 설정
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    
    /**
     * String langEngAbb을 반환
     * @return String langEngAbb
     */
    public String getLangEngAbb() {
        return langEngAbb;
    }

    
    /**
     * langEngAbb을 설정
     * @param langEngAbb 을(를) String langEngAbb로 설정
     */
    public void setLangEngAbb(String langEngAbb) {
        this.langEngAbb = langEngAbb;
    }

    
    /**
     * String langEngNm을 반환
     * @return String langEngNm
     */
    public String getLangEngNm() {
        return langEngNm;
    }

    
    /**
     * langEngNm을 설정
     * @param langEngNm 을(를) String langEngNm로 설정
     */
    public void setLangEngNm(String langEngNm) {
        this.langEngNm = langEngNm;
    }

    
    /**
     * String rm을 반환
     * @return String rm
     */
    public String getRm() {
        return rm;
    }

    
    /**
     * rm을 설정
     * @param rm 을(를) String rm로 설정
     */
    public void setRm(String rm) {
        this.rm = rm;
    }
    
    
}
