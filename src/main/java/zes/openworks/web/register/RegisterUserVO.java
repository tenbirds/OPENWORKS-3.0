/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

import java.util.List;
import java.util.Map;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.Email;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *       수정일             수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 18.     홍길동     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class RegisterUserVO  extends PaggingVO {

    static final long serialVersionUID = -844244739945971999L;

    /** 사용자아이디 */
    private String userId;
    private String langCode;
    /** 국가코드 */
    private String nationCode;
    private String nationNm;
    /** 사용자비밀번호 */
    private String beforePassword;
    private String userPassword;
    private String userPassword2;
    /** 사용자명 */
    private String userNm;
    /** 이메일 */
    @Email
    private String email;
    /** 가입유형 */
    private Integer sbscrbTyCd;
    /** 국제전화번호 */
    private String intrlTelno;
    /** 전화번호 */
    private String telno;
    /** 우편번호 */
    private String zip;
    /** 기본주소 */
    private String bassAdres;
    /** 상세주소 */
    private String detailAdres;
    /** 등록자아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정자아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 최근로그인일시 */
    private String recentLoginDt;
    /** 로그인카운트 */
    private Integer loginCnt;
    /** 사용자유형코드 */
    private Integer userTyCd;
    private Integer userTyCd2;
    /** 사용자등급코드 */
    private String userGradCode;
    /** 사용자상태 */
    private Integer userSttusCd = 1001;
    /** 비밀번호수정일자 */
    private String passwordChangeDe;
    /** 사용자KEY */
    private String userKey;
    /** 중복가입방지키 */
    private String dplctSbscrbIndvdlznKey;
    /** 가입사이트구분코드 */
    private Integer sbscrbSiteSeCd;
    /** 내선전화번호 */
    private String lxtnTelno;

    /** 휴대폰번호 */
    private String mbtlnum;
    /** 생년월일 */
    private String brthdy;
    /** 성별코드 */
    private Integer sexdstnCd;
    /** 양력음력윤달코드 */
    private Integer slrcldLrrLpnhCd;
    /** SMS수신동의가부 */
    private Integer smsRecptnAgreCd;
    /** 이메일수신동의가부 -> 이메일수신동의코드(광고홍보)로 수정. 2015-10-23 */
    private Integer emailRecptnAgreCd;
    /** 이메일수신동의코드(뉴스레터/세미나) 추가. 2015-10-23 */
    private Integer nsletRecptnAgreCd;
    /** 이메일수신동의코드(입찰공고) 추가. 2015-10-23 */
    private Integer bidRecptnAgreCd;
    /** 회사명 */
    private String cmpnyNm;
    /** 회사우편번호 */
    private String cmpnyZip;
    /** 회사기본주소 */
    private String cmpnyBassAdres;
    /** 회사상세주소 */
    private String cmpnyDetailAdres;
    /** 회사전화번호 */
    private String cmpnyTelno;
    /** 회사대표자명 */
    private String cmpnyRprsntvNm;
    /** 사업자등록번호 */
    private String bizrno;
    /** 회사대표전화번호 */
    private String cmpnyReprsntTelno;
    /** 회사팩스번호 */
    private String cmpnyFaxnum;
    /** 회사이메일 */
    private String cmpnyEmail;
    /** 회사URL */
    private String cmpnyUrl;
    /** 회사내선전화번호 */
    private Integer cmpnyLxtnTelno;
    /** FAX수신동의가부 */
    private Integer faxRecptnAgreCd;
    /** 회사 이메일 수신동의가부 */
    private String cmpnyEmailRecptnAgreCd;

    /** 스토어 언어코드 */
    private String storeLangCode;
    /** 스토어 언어코드 배열 */
    private String[] storeLangCodes;
    /** 언어별상점명 */
    private String langStoreNm;
    /** 언어별상점명 배열 */
    private String[] langStoreNms;
    /** 언어별상점소개 */
    private String langStoreIntrcn;
    /** 언어별상점소개 배열 */
    private String[] langStoreIntrcns;
    /** 상점URL */
    private String storeUrl;
    /** 상점URL 배열 */
    private String[] storeUrls;
    /** 대표전화번호 */
    private String reprsntTelno;
    
    private String reprsntTelno1;
    private String reprsntTelno2;
    private String reprsntTelno3;
    /** 대표전화번호 배열 */
    private String[] reprsntTelnos;
    /** 대표이메일 */
    private String reprsntEmail;
    /** 대표이메일 배열 */
    private String[] reprsntEmails;
    /** 상점담당자명 */
    private String storeChargerNm;
    /** 상점담당자명 배열 */
    private String[] storeChargerNms;
    /** 상점이미지파일일련 */
    private Integer storeImageFileSeq = -1;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;

    /** 전체회원수 */
    private Integer totalUserCnt;
    /** 금일가입회원수 */
    private Integer todayRegUserCnt;
    /** 전체탈퇴회원수 */
    private Integer totalUserStateNCnt;

    /** 관심항목고유번호 */
    private Integer seq;

    /** RegisterUserVO List */
    private List<RegisterUserVO> userList;

    /** 관심카테고리 */
    private String ctgryCode;
    private String[] ctgryCodes;
    private List<Map<String, String>> ctgryList;

    /** 로그인가능일시 - 휴면계정 전환 관련 */
    private String validLoginDt;
    /** 휴면전환일시 - 휴면계정 전환 관련 */
    private String dormancyConversionDt;

    /** 휴면전환일시 */
    private String drmncyDt;
    /** 휴면복구일시 */
    private String recovryDt;

    /*============= 수요조사 관련 START =================*/
    /** 수요조사 담당자 여부 **/
    private String dmandExaminChargerAt;
    /** 기관담당자 기관정보 업데이트 여부 : 기관회원옵션의 기관코드가 기관정보테이블의 정보와 맞지 않으면 Y 를 반환 정보수정을 하도록 유도 **/
    private String pblinsttUpdtAt;
    /** 수요조사 기관명 확인 여부 **/
    private String pblinsttNmCnfirmAt;
    /** 수요조사 저장 카운트 **/
    private Integer dmandExaminSaveCnt;
    /*============= 수요조사 관련 END ===================*/
    
    /*============= 공공기관 옵션 추가 START =================*/
    /** 공공기관 코드 */
    private Integer pblinsttCd;
    /** 공공기관 명 */
    private String pblinsttNm;
    /** 공공기관 전화번호 */
    private String pblinsttTelno;
    /** 공공기관 이메일 */
    private String pblinsttEmail;
    /** 공공기관 홈페이지URL */
    private String pblinsttUrl;
    /** 공공기관 우편번호 */
    private String pblinsttZip;
    /** 공공기관 기관코드 */
    private String orgnCode;
    /** 공공기관 부서코드 */
    private String buseoCode;
    /** 공공기관 기본주소 */
    private String pblinsttBassAdres;
    /** 공공기관 상세주소 */
    private String pblinsttDetailAdres;
    /*============= 공공기관 옵션 추가 END =================*/
    
    /** 공급자 신청 상태 코드 **/
    private int agremStatCd;
    
    /**마스터아이디*/
    private String masterId;
    /**부서명*/
    private String cmpnyBuseo;
    
    /**  페이지조회수  */
    private Integer pgeRdcnt = 0;
    /** 계정삭제 배열 */
    private String[] deleleLists;
    
    /**기관명*/
    private String orgnNm;

    /**
     * Integer pblinsttCd을 반환
     * @return Integer pblinsttCd
     */
    public Integer getPblinsttCd() {
        return pblinsttCd;
    }


    /**
     * pblinsttCd을 설정
     * @param pblinsttCd 을(를) Integer pblinsttCd로 설정
     */
    public void setPblinsttCd(Integer pblinsttCd) {
        this.pblinsttCd = pblinsttCd;
    }


    /**
     * String pblinsttNm을 반환
     * @return String pblinsttNm
     */
    public String getPblinsttNm() {
        return pblinsttNm;
    }


    /**
     * pblinsttNm을 설정
     * @param pblinsttNm 을(를) String pblinsttNm로 설정
     */
    public void setPblinsttNm(String pblinsttNm) {
        this.pblinsttNm = pblinsttNm;
    }

    public String getPblinsttTelno() {
        return pblinsttTelno;
    }

    public void setPblinsttTelno(String value) {
        this.pblinsttTelno = value;
    }

    public String getPblinsttEmail() {
        return pblinsttEmail;
    }

    public void setPblinsttEmail(String value) {
        this.pblinsttEmail = value;
    }

    /**
     * String pblinsttUrl을 반환
     * @return String pblinsttUrl
     */
    public String getPblinsttUrl() {
        return pblinsttUrl;
    }


    /**
     * pblinsttUrl을 설정
     * @param pblinsttUrl 을(를) String pblinsttUrl로 설정
     */
    public void setPblinsttUrl(String pblinsttUrl) {
        this.pblinsttUrl = pblinsttUrl;
    }


    /**
     * String pblinsttZip을 반환
     * @return String pblinsttZip
     */
    public String getPblinsttZip() {
        return pblinsttZip;
    }


    /**
     * pblinsttZip을 설정
     * @param pblinsttZip 을(를) String pblinsttZip로 설정
     */
    public void setPblinsttZip(String pblinsttZip) {
        this.pblinsttZip = pblinsttZip;
    }


    /**
     * String pblinsttBassAdres을 반환
     * @return String pblinsttBassAdres
     */
    public String getPblinsttBassAdres() {
        return pblinsttBassAdres;
    }


    /**
     * pblinsttBassAdres을 설정
     * @param pblinsttBassAdres 을(를) String pblinsttBassAdres로 설정
     */
    public void setPblinsttBassAdres(String pblinsttBassAdres) {
        this.pblinsttBassAdres = pblinsttBassAdres;
    }


    /**
     * String pblinsttDetailAdres을 반환
     * @return String pblinsttDetailAdres
     */
    public String getPblinsttDetailAdres() {
        return pblinsttDetailAdres;
    }


    /**
     * pblinsttDetailAdres을 설정
     * @param pblinsttDetailAdres 을(를) String pblinsttDetailAdres로 설정
     */
    public void setPblinsttDetailAdres(String pblinsttDetailAdres) {
        this.pblinsttDetailAdres = pblinsttDetailAdres;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public String getNationCode() {
        return nationCode;
    }

    public void setNationCode(String nationCode) {
        this.nationCode = nationCode;
    }

    public String getNationNm() {
        return nationNm;
    }

    public void setNationNm(String nationNm) {
        this.nationNm = nationNm;
    }

    public String getBeforePassword() {
        return beforePassword;
    }

    public void setBeforePassword(String beforePassword) {
        this.beforePassword = beforePassword;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPassword2() {
        return userPassword2;
    }

    public void setUserPassword2(String userPassword2) {
        this.userPassword2 = userPassword2;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getSbscrbTyCd() {
        return sbscrbTyCd;
    }

    public void setSbscrbTyCd(Integer sbscrbTyCd) {
        this.sbscrbTyCd = sbscrbTyCd;
    }

    public String getIntrlTelno() {
        return intrlTelno;
    }

    public void setIntrlTelno(String intrlTelno) {
        this.intrlTelno = intrlTelno;
    }

    public String getTelno() {
        return telno;
    }

    public void setTelno(String telno) {
        this.telno = telno;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    public String getBassAdres() {
        return bassAdres;
    }

    public void setBassAdres(String bassAdres) {
        this.bassAdres = bassAdres;
    }

    public String getDetailAdres() {
        return detailAdres;
    }

    public void setDetailAdres(String detailAdres) {
        this.detailAdres = detailAdres;
    }

    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getRegistDt() {
        return registDt;
    }

    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    public String getUpdtId() {
        return updtId;
    }

    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getRecentLoginDt() {
        return recentLoginDt;
    }

    public void setRecentLoginDt(String recentLoginDt) {
        this.recentLoginDt = recentLoginDt;
    }

    public Integer getLoginCnt() {
        return loginCnt;
    }

    public void setLoginCnt(Integer loginCnt) {
        this.loginCnt = loginCnt;
    }

    public Integer getUserTyCd() {
        return userTyCd;
    }

    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }

    public Integer getUserTyCd2() {
        return userTyCd2;
    }

    public void setUserTyCd2(Integer userTyCd2) {
        this.userTyCd2 = userTyCd2;
    }

    public String getUserGradCode() {
        return userGradCode;
    }

    public void setUserGradCode(String userGradCode) {
        this.userGradCode = userGradCode;
    }

    public Integer getUserSttusCd() {
        return userSttusCd;
    }

    public void setUserSttusCd(Integer userSttusCd) {
        this.userSttusCd = userSttusCd;
    }

    public String getPasswordChangeDe() {
        return passwordChangeDe;
    }

    public void setPasswordChangeDe(String passwordChangeDe) {
        this.passwordChangeDe = passwordChangeDe;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getDplctSbscrbIndvdlznKey() {
        return dplctSbscrbIndvdlznKey;
    }

    public void setDplctSbscrbIndvdlznKey(String dplctSbscrbIndvdlznKey) {
        this.dplctSbscrbIndvdlznKey = dplctSbscrbIndvdlznKey;
    }

    public Integer getSbscrbSiteSeCd() {
        return sbscrbSiteSeCd;
    }

    public void setSbscrbSiteSeCd(Integer sbscrbSiteSeCd) {
        this.sbscrbSiteSeCd = sbscrbSiteSeCd;
    }

    public String getLxtnTelno() {
        return lxtnTelno;
    }

    public void setLxtnTelno(String lxtnTelno) {
        this.lxtnTelno = lxtnTelno;
    }

    public String getMbtlnum() {
        return mbtlnum;
    }

    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    public String getBrthdy() {
        return brthdy;
    }

    public void setBrthdy(String brthdy) {
        this.brthdy = brthdy;
    }

    public Integer getSexdstnCd() {
        return sexdstnCd;
    }

    public void setSexdstnCd(Integer sexdstnCd) {
        this.sexdstnCd = sexdstnCd;
    }

    public Integer getSlrcldLrrLpnhCd() {
        return slrcldLrrLpnhCd;
    }

    public void setSlrcldLrrLpnhCd(Integer slrcldLrrLpnhCd) {
        this.slrcldLrrLpnhCd = slrcldLrrLpnhCd;
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

    public String getCmpnyNm() {
        return cmpnyNm;
    }

    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    public String getCmpnyZip() {
        return cmpnyZip;
    }

    public void setCmpnyZip(String cmpnyZip) {
        this.cmpnyZip = cmpnyZip;
    }

    public String getCmpnyBassAdres() {
        return cmpnyBassAdres;
    }

    public void setCmpnyBassAdres(String cmpnyBassAdres) {
        this.cmpnyBassAdres = cmpnyBassAdres;
    }

    public String getCmpnyDetailAdres() {
        return cmpnyDetailAdres;
    }

    public void setCmpnyDetailAdres(String cmpnyDetailAdres) {
        this.cmpnyDetailAdres = cmpnyDetailAdres;
    }

    public String getCmpnyTelno() {
        return cmpnyTelno;
    }

    public void setCmpnyTelno(String cmpnyTelno) {
        this.cmpnyTelno = cmpnyTelno;
    }

    public String getCmpnyRprsntvNm() {
        return cmpnyRprsntvNm;
    }

    public void setCmpnyRprsntvNm(String cmpnyRprsntvNm) {
        this.cmpnyRprsntvNm = cmpnyRprsntvNm;
    }

    public String getBizrno() {
        return bizrno;
    }

    public void setBizrno(String bizrno) {
        this.bizrno = bizrno;
    }

    public String getCmpnyReprsntTelno() {
        return cmpnyReprsntTelno;
    }

    public void setCmpnyReprsntTelno(String cmpnyReprsntTelno) {
        this.cmpnyReprsntTelno = cmpnyReprsntTelno;
    }

    public String getCmpnyFaxnum() {
        return cmpnyFaxnum;
    }

    public void setCmpnyFaxnum(String cmpnyFaxnum) {
        this.cmpnyFaxnum = cmpnyFaxnum;
    }

    public String getCmpnyEmail() {
        return cmpnyEmail;
    }

    public void setCmpnyEmail(String cmpnyEmail) {
        this.cmpnyEmail = cmpnyEmail;
    }

    public String getCmpnyUrl() {
        return cmpnyUrl;
    }

    public void setCmpnyUrl(String cmpnyUrl) {
        this.cmpnyUrl = cmpnyUrl;
    }

    public Integer getCmpnyLxtnTelno() {
        return cmpnyLxtnTelno;
    }

    public void setCmpnyLxtnTelno(Integer cmpnyLxtnTelno) {
        this.cmpnyLxtnTelno = cmpnyLxtnTelno;
    }

    public Integer getFaxRecptnAgreCd() {
        return faxRecptnAgreCd;
    }

    public void setFaxRecptnAgreCd(Integer faxRecptnAgreCd) {
        this.faxRecptnAgreCd = faxRecptnAgreCd;
    }

    public String getCmpnyEmailRecptnAgreCd() {
        return cmpnyEmailRecptnAgreCd;
    }

    public void setCmpnyEmailRecptnAgreCd(String cmpnyEmailRecptnAgreCd) {
        this.cmpnyEmailRecptnAgreCd = cmpnyEmailRecptnAgreCd;
    }

    public String getStoreLangCode() {
        return storeLangCode;
    }

    public void setStoreLangCode(String storeLangCode) {
        this.storeLangCode = storeLangCode;
    }

    public String[] getStoreLangCodes() {
        return storeLangCodes;
    }

    public void setStoreLangCodes(String[] storeLangCodes) {
        this.storeLangCodes = storeLangCodes;
    }

    public String getLangStoreNm() {
        return langStoreNm;
    }

    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    public String[] getLangStoreNms() {
        return langStoreNms;
    }

    public void setLangStoreNms(String[] langStoreNms) {
        this.langStoreNms = langStoreNms;
    }

    public String getLangStoreIntrcn() {
        return langStoreIntrcn;
    }

    public void setLangStoreIntrcn(String langStoreIntrcn) {
        this.langStoreIntrcn = langStoreIntrcn;
    }

    public String[] getLangStoreIntrcns() {
        return langStoreIntrcns;
    }

    public void setLangStoreIntrcns(String[] langStoreIntrcns) {
        this.langStoreIntrcns = langStoreIntrcns;
    }

    public String getStoreUrl() {
        return storeUrl;
    }

    public void setStoreUrl(String storeUrl) {
        this.storeUrl = storeUrl;
    }

    public String[] getStoreUrls() {
        return storeUrls;
    }

    public void setStoreUrls(String[] storeUrls) {
        this.storeUrls = storeUrls;
    }

    public String getReprsntTelno() {
        return reprsntTelno;
    }

    public void setReprsntTelno(String reprsntTelno) {
        this.reprsntTelno = reprsntTelno;
    }

    public String getReprsntTelno1() {
        return reprsntTelno1;
    }

    public void setReprsntTelno1(String reprsntTelno1) {
        this.reprsntTelno1 = reprsntTelno1;
    }
    public String getReprsntTelno2() {
        return reprsntTelno2;
    }

    public void setReprsntTelno2(String reprsntTelno2) {
        this.reprsntTelno2 = reprsntTelno2;
    }
    
    public String getReprsntTelno3() {
        return reprsntTelno3;
    }

    public void setReprsntTelno3(String reprsntTelno3) {
        this.reprsntTelno3 = reprsntTelno3;
    }
    
    public String[] getReprsntTelnos() {
        return reprsntTelnos;
    }

    public void setReprsntTelnos(String[] reprsntTelnos) {
        this.reprsntTelnos = reprsntTelnos;
    }

    public String getReprsntEmail() {
        return reprsntEmail;
    }

    public void setReprsntEmail(String reprsntEmail) {
        this.reprsntEmail = reprsntEmail;
    }

    public String[] getReprsntEmails() {
        return reprsntEmails;
    }

    public void setReprsntEmails(String[] reprsntEmails) {
        this.reprsntEmails = reprsntEmails;
    }

    public String getStoreChargerNm() {
        return storeChargerNm;
    }

    public void setStoreChargerNm(String storeChargerNm) {
        this.storeChargerNm = storeChargerNm;
    }

    public String[] getStoreChargerNms() {
        return storeChargerNms;
    }

    public void setStoreChargerNms(String[] storeChargerNms) {
        this.storeChargerNms = storeChargerNms;
    }

    public Integer getStoreImageFileSeq() {
        return storeImageFileSeq;
    }

    public void setStoreImageFileSeq(Integer storeImageFileSeq) {
        this.storeImageFileSeq = storeImageFileSeq;
    }

    public List<FileVO> getFileList() {
        return fileList;
    }

    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    public Integer getTotalUserCnt() {
        return totalUserCnt;
    }

    public void setTotalUserCnt(Integer totalUserCnt) {
        this.totalUserCnt = totalUserCnt;
    }

    public Integer getTodayRegUserCnt() {
        return todayRegUserCnt;
    }

    public void setTodayRegUserCnt(Integer todayRegUserCnt) {
        this.todayRegUserCnt = todayRegUserCnt;
    }

    public Integer getTotalUserStateNCnt() {
        return totalUserStateNCnt;
    }

    public void setTotalUserStateNCnt(Integer totalUserStateNCnt) {
        this.totalUserStateNCnt = totalUserStateNCnt;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public List<RegisterUserVO> getUserList() {
        return userList;
    }

    public void setUserList(List<RegisterUserVO> userList) {
        this.userList = userList;
    }

    public String getCtgryCode() {
        return ctgryCode;
    }

    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }

    public String[] getCtgryCodes() {
        return ctgryCodes;
    }

    public void setCtgryCodes(String[] ctgryCodes) {
        this.ctgryCodes = ctgryCodes;
    }

    public List<Map<String, String>> getCtgryList() {
        return ctgryList;
    }

    public void setCtgryList(List<Map<String, String>> ctgryList) {
        this.ctgryList = ctgryList;
    }

    public String getValidLoginDt() {
        return validLoginDt;
    }

    public void setValidLoginDt(String validLoginDt) {
        this.validLoginDt = validLoginDt;
    }

    public String getDormancyConversionDt() {
        return dormancyConversionDt;
    }

    public void setDormancyConversionDt(String dormancyConversionDt) {
        this.dormancyConversionDt = dormancyConversionDt;
    }

    public String getDrmncyDt() {
        return drmncyDt;
    }

    public void setDrmncyDt(String drmncyDt) {
        this.drmncyDt = drmncyDt;
    }

    public String getRecovryDt() {
        return recovryDt;
    }

    public void setRecovryDt(String recovryDt) {
        this.recovryDt = recovryDt;
    }


    /**
     * String dmandExaminChargerAt을 반환
     * @return String dmandExaminChargerAt
     */
    public String getDmandExaminChargerAt() {
        return dmandExaminChargerAt;
    }


    /**
     * dmandExaminChargerAt을 설정
     * @param dmandExaminChargerAt 을(를) String dmandExaminChargerAt로 설정
     */
    public void setDmandExaminChargerAt(String dmandExaminChargerAt) {
        this.dmandExaminChargerAt = dmandExaminChargerAt;
    }


    /**
     * int agremStatCd을 반환
     * @return int agremStatCd
     */
    public int getAgremStatCd() {
        return agremStatCd;
    }


    /**
     * agremStatCd을 설정
     * @param agremStatCd 을(를) int agremStatCd로 설정
     */
    public void setAgremStatCd(int agremStatCd) {
        this.agremStatCd = agremStatCd;
    }


    
    /**
     * String masterId을 반환
     * @return String masterId
     */
    public String getMasterId() {
        return masterId;
    }


    
    /**
     * masterId을 설정
     * @param masterId 을(를) String masterId로 설정
     */
    public void setMasterId(String masterId) {
        this.masterId = masterId;
    }


    
    /**
     * String cmpnyBuseo을 반환
     * @return String cmpnyBuseo
     */
    public String getCmpnyBuseo() {
        return cmpnyBuseo;
    }


    
    /**
     * cmpnyBuseo을 설정
     * @param cmpnyBuseo 을(를) String cmpnyBuseo로 설정
     */
    public void setCmpnyBuseo(String cmpnyBuseo) {
        this.cmpnyBuseo = cmpnyBuseo;
    }

    /**
     * String[] deleleLists을 반환
     * @return String[] deleleLists
     */
    public String[] getDeleleLists() {
        return deleleLists;
    }


    
    /**
     * deleleLists을 설정
     * @param deleleLists 을(를) String[] deleleLists로 설정
     */
    public void setDeleleLists(String[] deleleLists) {
        this.deleleLists = deleleLists;
    }


    
    /**
     * Integer pgeRdcnt을 반환
     * @return Integer pgeRdcnt
     */
    public Integer getPgeRdcnt() {
        return pgeRdcnt;
    }


    
    /**
     * pgeRdcnt을 설정
     * @param pgeRdcnt 을(를) Integer pgeRdcnt로 설정
     */
    public void setPgeRdcnt(Integer pgeRdcnt) {
        this.pgeRdcnt = pgeRdcnt;
    }


    
    /**
     * String orgnNm을 반환
     * @return String orgnNm
     */
    public String getOrgnNm() {
        return orgnNm;
    }


    
    /**
     * orgnNm을 설정
     * @param orgnNm 을(를) String orgnNm로 설정
     */
    public void setOrgnNm(String orgnNm) {
        this.orgnNm = orgnNm;
    }


    /**
     * String orgnCode을 반환
     * @return String orgnCode
     */
    public String getOrgnCode() {
        return orgnCode;
    }


    /**
     * orgnCode을 설정
     * @param orgnCode 을(를) String orgnCode로 설정
     */
    public void setOrgnCode(String orgnCode) {
        this.orgnCode = orgnCode;
    }


    /**
     * String buseoCode을 반환
     * @return String buseoCode
     */
    public String getBuseoCode() {
        return buseoCode;
    }


    /**
     * buseoCode을 설정
     * @param buseoCode 을(를) String buseoCode로 설정
     */
    public void setBuseoCode(String buseoCode) {
        this.buseoCode = buseoCode;
    }


    
    /**
     * String pblinsttUpdtAt을 반환
     * @return String pblinsttUpdtAt
     */
    public String getPblinsttUpdtAt() {
        return pblinsttUpdtAt;
    }


    
    /**
     * pblinsttUpdtAt을 설정
     * @param pblinsttUpdtAt 을(를) String pblinsttUpdtAt로 설정
     */
    public void setPblinsttUpdtAt(String pblinsttUpdtAt) {
        this.pblinsttUpdtAt = pblinsttUpdtAt;
    }


    
    /**
     * String pblinsttNmCnfirmAt을 반환
     * @return String pblinsttNmCnfirmAt
     */
    public String getPblinsttNmCnfirmAt() {
        return pblinsttNmCnfirmAt;
    }


    
    /**
     * pblinsttNmCnfirmAt을 설정
     * @param pblinsttNmCnfirmAt 을(를) String pblinsttNmCnfirmAt로 설정
     */
    public void setPblinsttNmCnfirmAt(String pblinsttNmCnfirmAt) {
        this.pblinsttNmCnfirmAt = pblinsttNmCnfirmAt;
    }


    
    /**
     * Integer dmandExaminSaveCnt을 반환
     * @return Integer dmandExaminSaveCnt
     */
    public Integer getDmandExaminSaveCnt() {
        return dmandExaminSaveCnt;
    }


    
    /**
     * dmandExaminSaveCnt을 설정
     * @param dmandExaminSaveCnt 을(를) Integer dmandExaminSaveCnt로 설정
     */
    public void setDmandExaminSaveCnt(Integer dmandExaminSaveCnt) {
        this.dmandExaminSaveCnt = dmandExaminSaveCnt;
    }

}
