/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.userSet;

import zes.base.vo.BaseVO;

/**
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    강동성
 * </pre>
 * @see
 */
public class UserInfoVO extends BaseVO {

    private static final long serialVersionUID = -7276468050607537750L;

    /** 언어코드 */
    private String langCode;
    /** 회원유형 */
    private String userTy;
    /** 회원유형배열 */
    private String[] userTys;
    /** 설정항목코드 */
    private Integer iemCd;
    /** 항목유형 */
    private String iemTy;
    /** 사용가부코드 */
    private Integer useYnCd;
    /** 사용항목코드 */
    private String useIemCd;
    // 기본,추가,관심 항목설정 탭
    /** 회원구분 */
    private String userGubun;
    /** 설정항목 코드 */
    private Integer itemCode;
    /** 사용여부 코드 */
    private Integer useYnCode;
    /** 사용여부 이름 */
    private String useYnNm;
    /** 필수여부 코드 셀렉터 */
    private String useItemCd;
    /** 설정항목 이름 */
    private String itemNm;
    /** 설정항목 구분 */
    private String itemGubun;
    /** 개인 회원 COUNT */
    private Integer userCount;
    /** 사업자 회원 COUNT */
    private Integer companyCount;
    /** 공공기관 회원 COUNT */
    private Integer publicCount;
    /** 스토어정보 COUNT */
    private Integer storeCount;
    /** 사용여부 코드 */
    private String useYn;
    /** 번호 */
    private Integer seq;

    // 가입정보변경 이력 탭
    /** 변경된 사용여부 코드 배열 */
    private String[] paramUseYnCodes;
    /** 변경된 설정항목 코드 배열 */
    private String[] paramItemCodes;
    /** 변경전 설정항목 사용여부 코드 배열 */
    private String[] beforeYnCodes;
    /** 설정항목 이름 배열 */
    private String[] itemNms;
    /** 설정항목 구분 배열 */
    private String[] userGubuns;
    /** 사용여부 코드 배열 */
    private String[] useYnCodes;
    /** 사용여부 이름 배열 */
    private String[] useYnNms;

    /** 수정일시 */
    private String updtDt;
    /** 수정아이디 */
    private String updtId;
    /** 수정이름 */
    private String updtNm;
    /** 수정내용 */
    private String updtCn;

    /** 설정정보(사용여부 값) */
    private Integer mbtlnum;
    private Integer brthdy;
    private Integer sexdstnCd;
    private Integer slrcldLddLpnhCd;
    private Integer smsRecptnAgreCd;
    private Integer emailRecptnAgreCd;
    private Integer nsletRecptnAgreCd;
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
    
    /** 설정정보(사용여부값) 공공기관 추가 **/
    private Integer pblinsttNm;
    private Integer pblinsttZip;
    private Integer pblinsttBassAdres;
    private Integer pblinsttDetailAdres;
    private Integer pblinsttTelno;
    private Integer pblinsttRprsntvNm;
    private Integer pblinsttReprsntTelno;
    private Integer pblinsttFaxnum;
    private Integer pblinsttEmail;
    private Integer pblinsttUrl;
    
    private Integer langStoreNm;
    private Integer langStoreIntrcn;
    private Integer storeChargerNm;
    private Integer reprsntTelno;
    private Integer reprsntEmail;
    private Integer storeUrl;

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public String getUserTy() {
        return userTy;
    }

    public void setUserTy(String userTy) {
        this.userTy = userTy;
    }

    public String[] getUserTys() {
        return userTys;
    }

    public void setUserTys(String[] userTys) {
        this.userTys = userTys;
    }

    public Integer getIemCd() {
        return iemCd;
    }

    public void setIemCd(Integer iemCd) {
        this.iemCd = iemCd;
    }

    public String getIemTy() {
        return iemTy;
    }

    public void setIemTy(String iemTy) {
        this.iemTy = iemTy;
    }

    public Integer getUseYnCd() {
        return useYnCd;
    }

    public void setUseYnCd(Integer useYnCd) {
        this.useYnCd = useYnCd;
    }

    public String getUseIemCd() {
        return useIemCd;
    }

    public void setUseIemCd(String useIemCd) {
        this.useIemCd = useIemCd;
    }

    public String getUserGubun() {
        return userGubun;
    }

    public void setUserGubun(String userGubun) {
        this.userGubun = userGubun;
    }

    public Integer getItemCode() {
        return itemCode;
    }

    public void setItemCode(Integer itemCode) {
        this.itemCode = itemCode;
    }

    public Integer getUseYnCode() {
        return useYnCode;
    }

    public void setUseYnCode(Integer useYnCode) {
        this.useYnCode = useYnCode;
    }

    public String getUseYnNm() {
        return useYnNm;
    }

    public void setUseYnNm(String useYnNm) {
        this.useYnNm = useYnNm;
    }

    public String getUseItemCd() {
        return useItemCd;
    }

    public void setUseItemCd(String useItemCd) {
        this.useItemCd = useItemCd;
    }

    public String getItemNm() {
        return itemNm;
    }

    public void setItemNm(String itemNm) {
        this.itemNm = itemNm;
    }

    public String getItemGubun() {
        return itemGubun;
    }

    public void setItemGubun(String itemGubun) {
        this.itemGubun = itemGubun;
    }

    public Integer getUserCount() {
        return userCount;
    }

    public void setUserCount(Integer userCount) {
        this.userCount = userCount;
    }

    public Integer getCompanyCount() {
        return companyCount;
    }

    public void setCompanyCount(Integer companyCount) {
        this.companyCount = companyCount;
    }

    public Integer getStoreCount() {
        return storeCount;
    }

    public void setStoreCount(Integer storeCount) {
        this.storeCount = storeCount;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String[] getParamUseYnCodes() {
        return paramUseYnCodes;
    }

    public void setParamUseYnCodes(String[] paramUseYnCodes) {
        this.paramUseYnCodes = paramUseYnCodes;
    }

    public String[] getParamItemCodes() {
        return paramItemCodes;
    }

    public void setParamItemCodes(String[] paramItemCodes) {
        this.paramItemCodes = paramItemCodes;
    }

    public String[] getBeforeYnCodes() {
        return beforeYnCodes;
    }

    public void setBeforeYnCodes(String[] beforeYnCodes) {
        this.beforeYnCodes = beforeYnCodes;
    }

    public String[] getItemNms() {
        return itemNms;
    }

    public void setItemNms(String[] itemNms) {
        this.itemNms = itemNms;
    }

    public String[] getUserGubuns() {
        return userGubuns;
    }

    public void setUserGubuns(String[] userGubuns) {
        this.userGubuns = userGubuns;
    }

    public String[] getUseYnCodes() {
        return useYnCodes;
    }

    public void setUseYnCodes(String[] useYnCodes) {
        this.useYnCodes = useYnCodes;
    }

    public String[] getUseYnNms() {
        return useYnNms;
    }

    public void setUseYnNms(String[] useYnNms) {
        this.useYnNms = useYnNms;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getUpdtId() {
        return updtId;
    }

    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    public String getUpdtNm() {
        return updtNm;
    }

    public void setUpdtNm(String updtNm) {
        this.updtNm = updtNm;
    }

    public String getUpdtCn() {
        return updtCn;
    }

    public void setUpdtCn(String updtCn) {
        this.updtCn = updtCn;
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

    
    /**
     * Integer pblinsttNm을 반환
     * @return Integer pblinsttNm
     */
    public Integer getPblinsttNm() {
        return pblinsttNm;
    }

    
    /**
     * pblinsttNm을 설정
     * @param pblinsttNm 을(를) Integer pblinsttNm로 설정
     */
    public void setPblinsttNm(Integer pblinsttNm) {
        this.pblinsttNm = pblinsttNm;
    }

    
    /**
     * Integer pblinsttZip을 반환
     * @return Integer pblinsttZip
     */
    public Integer getPblinsttZip() {
        return pblinsttZip;
    }

    
    /**
     * pblinsttZip을 설정
     * @param pblinsttZip 을(를) Integer pblinsttZip로 설정
     */
    public void setPblinsttZip(Integer pblinsttZip) {
        this.pblinsttZip = pblinsttZip;
    }

    
    /**
     * Integer pblinsttBassAdres을 반환
     * @return Integer pblinsttBassAdres
     */
    public Integer getPblinsttBassAdres() {
        return pblinsttBassAdres;
    }

    
    /**
     * pblinsttBassAdres을 설정
     * @param pblinsttBassAdres 을(를) Integer pblinsttBassAdres로 설정
     */
    public void setPblinsttBassAdres(Integer pblinsttBassAdres) {
        this.pblinsttBassAdres = pblinsttBassAdres;
    }

    
    /**
     * Integer pblinsttDetailAdres을 반환
     * @return Integer pblinsttDetailAdres
     */
    public Integer getPblinsttDetailAdres() {
        return pblinsttDetailAdres;
    }

    
    /**
     * pblinsttDetailAdres을 설정
     * @param pblinsttDetailAdres 을(를) Integer pblinsttDetailAdres로 설정
     */
    public void setPblinsttDetailAdres(Integer pblinsttDetailAdres) {
        this.pblinsttDetailAdres = pblinsttDetailAdres;
    }

    
    /**
     * Integer pblinsttTelno을 반환
     * @return Integer pblinsttTelno
     */
    public Integer getPblinsttTelno() {
        return pblinsttTelno;
    }

    
    /**
     * pblinsttTelno을 설정
     * @param pblinsttTelno 을(를) Integer pblinsttTelno로 설정
     */
    public void setPblinsttTelno(Integer pblinsttTelno) {
        this.pblinsttTelno = pblinsttTelno;
    }

    
    /**
     * Integer pblinsttRprsntvNm을 반환
     * @return Integer pblinsttRprsntvNm
     */
    public Integer getPblinsttRprsntvNm() {
        return pblinsttRprsntvNm;
    }

    
    /**
     * pblinsttRprsntvNm을 설정
     * @param pblinsttRprsntvNm 을(를) Integer pblinsttRprsntvNm로 설정
     */
    public void setPblinsttRprsntvNm(Integer pblinsttRprsntvNm) {
        this.pblinsttRprsntvNm = pblinsttRprsntvNm;
    }

    
    /**
     * Integer pblinsttReprsntTelno을 반환
     * @return Integer pblinsttReprsntTelno
     */
    public Integer getPblinsttReprsntTelno() {
        return pblinsttReprsntTelno;
    }

    
    /**
     * pblinsttReprsntTelno을 설정
     * @param pblinsttReprsntTelno 을(를) Integer pblinsttReprsntTelno로 설정
     */
    public void setPblinsttReprsntTelno(Integer pblinsttReprsntTelno) {
        this.pblinsttReprsntTelno = pblinsttReprsntTelno;
    }

    
    /**
     * Integer pblinsttFaxnum을 반환
     * @return Integer pblinsttFaxnum
     */
    public Integer getPblinsttFaxnum() {
        return pblinsttFaxnum;
    }

    
    /**
     * pblinsttFaxnum을 설정
     * @param pblinsttFaxnum 을(를) Integer pblinsttFaxnum로 설정
     */
    public void setPblinsttFaxnum(Integer pblinsttFaxnum) {
        this.pblinsttFaxnum = pblinsttFaxnum;
    }

    
    /**
     * Integer pblinsttEmail을 반환
     * @return Integer pblinsttEmail
     */
    public Integer getPblinsttEmail() {
        return pblinsttEmail;
    }

    
    /**
     * pblinsttEmail을 설정
     * @param pblinsttEmail 을(를) Integer pblinsttEmail로 설정
     */
    public void setPblinsttEmail(Integer pblinsttEmail) {
        this.pblinsttEmail = pblinsttEmail;
    }

    
    /**
     * Integer pblinsttUrl을 반환
     * @return Integer pblinsttUrl
     */
    public Integer getPblinsttUrl() {
        return pblinsttUrl;
    }

    
    /**
     * pblinsttUrl을 설정
     * @param pblinsttUrl 을(를) Integer pblinsttUrl로 설정
     */
    public void setPblinsttUrl(Integer pblinsttUrl) {
        this.pblinsttUrl = pblinsttUrl;
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

    /**
     * Integer publicCount을 반환
     * @return Integer publicCount
     */
    public Integer getPublicCount() {
        return publicCount;
    }

    /**
     * publicCount을 설정
     * @param publicCount 을(를) Integer publicCount로 설정
     */
    public void setPublicCount(Integer publicCount) {
        this.publicCount = publicCount;
    }

}
