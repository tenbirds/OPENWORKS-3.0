/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

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
 *  2012. 7. 16.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class RegisterVO {

    private Integer userTyCd;
    private Integer nationCode;
    private String langCode = "00";

    /** 설정정보(사용여부 값) */
    private String email;
    private Integer mbtlnum;
    private Integer brthdy;
    private Integer sexdstnCd;
    private Integer slrcldLddLpnhCd;
    private Integer smsRecptnAgreCd;
    private Integer emailRecptnAgreCd;

    /** 이메일수신동의코드(뉴스레터/세미나) 추가. 2015-10-23 */
    private Integer nsletRecptnAgreCd;
    /** 이메일수신동의코드(입찰공고) 추가. 2015-10-23 */
    private Integer bidRecptnAgreCd;

    private Integer cmpnyNm;
    private Integer cmpnyZip;
    private Integer cmpnyBassAdres;
    private Integer cmpnyDetailAdres;
    private Integer cmpnyTelno;
    private Integer cmpnyRprsntvNm;
    private Integer bizrno;
    private Integer cmpnyReprsntTelno;
    private Integer cmpnyFaxnum;
    private Integer cmpnyEmail;
    private Integer cmpnyUrl;
    private Integer faxRecptnAgreCd;

    private Integer langStoreNm;
    private Integer langStoreIntrcn;
    private Integer storeChargerNm;
    private Integer reprsntTelno;
    private Integer reprsntEmail;
    private Integer storeUrl;

    public Integer getUserTyCd() {
        return userTyCd;
    }

    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }

    public Integer getNationCode() {
        return nationCode;
    }

    public void setNationCode(Integer nationCode) {
        this.nationCode = nationCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public Integer getMbtlnum() {
        return mbtlnum;
    }

    public void setMbtlnum(Integer mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    public Integer getBrthdy() {
        return brthdy;
    }

    public void setBrthdy(Integer brthdy) {
        this.brthdy = brthdy;
    }

    public Integer getSexdstnCd() {
        return sexdstnCd;
    }

    public void setSexdstnCd(Integer sexdstnCd) {
        this.sexdstnCd = sexdstnCd;
    }

    public Integer getSlrcldLddLpnhCd() {
        return slrcldLddLpnhCd;
    }

    public void setSlrcldLddLpnhCd(Integer slrcldLddLpnhCd) {
        this.slrcldLddLpnhCd = slrcldLddLpnhCd;
    }

    public Integer getSmsRecptnAgreCd() {
        return smsRecptnAgreCd;
    }

    public void setSmsRecptnAgreCd(Integer smsRecptnAgreCd) {
        this.smsRecptnAgreCd = smsRecptnAgreCd;
    }

    public Integer getEmailRecptnAgreCd() {
        return emailRecptnAgreCd;
    }

    public void setEmailRecptnAgreCd(Integer emailRecptnAgreCd) {
        this.emailRecptnAgreCd = emailRecptnAgreCd;
    }

    /** 2015-10-23 추가 */
    public Integer getNsletRecptnAgreCd() {
        return nsletRecptnAgreCd;
    }

    public void setNsletRecptnAgreCd(Integer nsletRecptnAgreCd) {
        this.nsletRecptnAgreCd = nsletRecptnAgreCd;
    }

    public Integer getBidRecptnAgreCd() {
        return bidRecptnAgreCd;
    }

    public void setBidRecptnAgreCd(Integer bidRecptnAgreCd) {
        this.bidRecptnAgreCd = bidRecptnAgreCd;
    }
    /** 2015-10-23 추가 끝 */

    public Integer getCmpnyNm() {
        return cmpnyNm;
    }

    public void setCmpnyNm(Integer cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    public Integer getCmpnyZip() {
        return cmpnyZip;
    }

    public void setCmpnyZip(Integer cmpnyZip) {
        this.cmpnyZip = cmpnyZip;
    }

    public Integer getCmpnyBassAdres() {
        return cmpnyBassAdres;
    }

    public void setCmpnyBassAdres(Integer cmpnyBassAdres) {
        this.cmpnyBassAdres = cmpnyBassAdres;
    }

    public Integer getCmpnyDetailAdres() {
        return cmpnyDetailAdres;
    }

    public void setCmpnyDetailAdres(Integer cmpnyDetailAdres) {
        this.cmpnyDetailAdres = cmpnyDetailAdres;
    }

    public Integer getCmpnyTelno() {
        return cmpnyTelno;
    }

    public void setCmpnyTelno(Integer cmpnyTelno) {
        this.cmpnyTelno = cmpnyTelno;
    }

    public Integer getCmpnyRprsntvNm() {
        return cmpnyRprsntvNm;
    }

    public void setCmpnyRprsntvNm(Integer cmpnyRprsntvNm) {
        this.cmpnyRprsntvNm = cmpnyRprsntvNm;
    }

    public Integer getBizrno() {
        return bizrno;
    }

    public void setBizrno(Integer bizrno) {
        this.bizrno = bizrno;
    }

    public Integer getCmpnyReprsntTelno() {
        return cmpnyReprsntTelno;
    }

    public void setCmpnyReprsntTelno(Integer cmpnyReprsntTelno) {
        this.cmpnyReprsntTelno = cmpnyReprsntTelno;
    }

    public Integer getCmpnyFaxnum() {
        return cmpnyFaxnum;
    }

    public void setCmpnyFaxnum(Integer cmpnyFaxnum) {
        this.cmpnyFaxnum = cmpnyFaxnum;
    }

    public Integer getCmpnyEmail() {
        return cmpnyEmail;
    }

    public void setCmpnyEmail(Integer cmpnyEmail) {
        this.cmpnyEmail = cmpnyEmail;
    }

    public Integer getCmpnyUrl() {
        return cmpnyUrl;
    }

    public void setCmpnyUrl(Integer cmpnyUrl) {
        this.cmpnyUrl = cmpnyUrl;
    }

    public Integer getFaxRecptnAgreCd() {
        return faxRecptnAgreCd;
    }

    public void setFaxRecptnAgreCd(Integer faxRecptnAgreCd) {
        this.faxRecptnAgreCd = faxRecptnAgreCd;
    }

    public Integer getLangStoreNm() {
        return langStoreNm;
    }

    public void setLangStoreNm(Integer langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    public Integer getLangStoreIntrcn() {
        return langStoreIntrcn;
    }

    public void setLangStoreIntrcn(Integer langStoreIntrcn) {
        this.langStoreIntrcn = langStoreIntrcn;
    }

    public Integer getStoreChargerNm() {
        return storeChargerNm;
    }

    public void setStoreChargerNm(Integer storeChargerNm) {
        this.storeChargerNm = storeChargerNm;
    }

    public Integer getReprsntTelno() {
        return reprsntTelno;
    }

    public void setReprsntTelno(Integer reprsntTelno) {
        this.reprsntTelno = reprsntTelno;
    }

    public Integer getReprsntEmail() {
        return reprsntEmail;
    }

    public void setReprsntEmail(Integer reprsntEmail) {
        this.reprsntEmail = reprsntEmail;
    }

    public Integer getStoreUrl() {
        return storeUrl;
    }

    public void setStoreUrl(Integer storeUrl) {
        this.storeUrl = storeUrl;
    }

}
