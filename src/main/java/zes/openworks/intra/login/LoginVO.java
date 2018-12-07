/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.login;

import java.util.List;

import zes.base.vo.SessVO;
import zes.openworks.intra.menu.MenuVO;
import zes.openworks.intra.menugrp.MenuGrpVO;
import zes.openworks.intra.menugrp.MenuItemVO;

/**
 * 관리자 로그인 정보 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class LoginVO extends SessVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 4810469658302194652L;

    /** 언어 코드 */
    private String langCode;
    /** 관리 도메인코드 */
    private List<String> domainCds;
    /** 관리자아이디 */
    private String mngrId;
    /** 부서코드 */
    private String deptCode;
    /** 부서명 */
    private String deptNm;
    /** 관리자명 */
    private String mngrNm;
    /** 관리자비밀번호 */
    private String mngrPassword;
    /** 직위코드 */
    private Integer ofcpsCd;
    /** 전화번호 */
    private String telno;
    /** 팩스번호 */
    private String faxnum;
    /** 휴대폰번호 */
    private String mbtlnum;
    /** 이메일 */
    private String email;
    /** 로그인카운트 */
    private Integer loginCnt;
    /** 로그인일시 */
    private String loginDt;
    /** 사용가부 */
    private String useYn;
    /** 알림가부 */
    private String ntcnYn;
    /** 이메일통지가부 */
    private String emailNticeYn;
    /** SNS통지가부 */
    private String snsNticeYn;
    /** 등록자아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정일시 */
    private String updtDt;
    /** 수정자아이디 */
    private String updtId;
    /** 비밀번호변경일 */
    private String passwordChangeDe;
    /** 특별여부 */
    private String speclAt;
    /** 상태코드 */
    private Integer sttusCode;
    /** 상태시작일시 */
    private String sttusBeginDt;
    /** 상태종료일시 */
    private String sttusEndDt;
    /** 담당업무 */
    private String chrgJob;

    /** 할당 메뉴 그룹 */
    private List<MenuGrpVO> asnMenuGrpList;
    /** 권한 그룹 */
    private List<Integer> permissionGrpList;
    /** 권한 목록 */
    private List<MenuItemVO> permissionList;
    /** 내 메뉴 목록 */
    private List<MenuVO> myMenuList;

    /** 메뉴 그룹 , 구분 문자열 */
    private String authType;

    /** 유효한 ID 여부 */
    private boolean isValidId = false;
    /** 유효한 비밀번호 여부 */
    private boolean isValidPwd = false;
    /** 할당권한 존재 여부 */
    private boolean hasPermission = false;

    private boolean validSSOId;

    private boolean validSSOCd;

    private boolean validSSOIp;

    private String SSOUseYN;

    private String SSOIp;

    private String SSOClientIp;

    private String mgrSSOCd;

    private String mgrSSOId;

    /**
     * String langCode을 반환
     * 
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    /**
     * langCode을 설정
     * 
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    /**
     * List<String> domainCds을 반환
     * 
     * @return List<String> domainCds
     */
    public List<String> getDomainCds() {
        return domainCds;
    }

    /**
     * domainCds을 설정
     * 
     * @param domainCds 을(를) List<String> domainCds로 설정
     */
    public void setDomainCds(List<String> domainCds) {
        this.domainCds = domainCds;
    }

    /**
     * String mngrId을 반환
     * 
     * @return String mngrId
     */
    public String getMngrId() {
        return mngrId;
    }

    /**
     * mngrId을 설정
     * 
     * @param mngrId 을(를) String mngrId로 설정
     */
    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    /**
     * String deptCode을 반환
     * 
     * @return String deptCode
     */
    public String getDeptCode() {
        return deptCode;
    }

    /**
     * deptCode을 설정
     * 
     * @param deptCode 을(를) String deptCode로 설정
     */
    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }

    /**
     * String deptNm을 반환
     * 
     * @return String deptNm
     */
    public String getDeptNm() {
        return deptNm;
    }

    /**
     * deptNm을 설정
     * 
     * @param deptNm 을(를) String deptNm로 설정
     */
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    /**
     * String mngrNm을 반환
     * 
     * @return String mngrNm
     */
    public String getMngrNm() {
        return mngrNm;
    }

    /**
     * mngrNm을 설정
     * 
     * @param mngrNm 을(를) String mngrNm로 설정
     */
    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    /**
     * String mngrPassword을 반환
     * 
     * @return String mngrPassword
     */
    public String getMngrPassword() {
        return mngrPassword;
    }

    /**
     * mngrPassword을 설정
     * 
     * @param mngrPassword 을(를) String mngrPassword로 설정
     */
    public void setMngrPassword(String mngrPassword) {
        this.mngrPassword = mngrPassword;
    }

    /**
     * Integer ofcpsCd을 반환
     * 
     * @return Integer ofcpsCd
     */
    public Integer getOfcpsCd() {
        return ofcpsCd;
    }

    /**
     * ofcpsCd을 설정
     * 
     * @param ofcpsCd 을(를) Integer ofcpsCd로 설정
     */
    public void setOfcpsCd(Integer ofcpsCd) {
        this.ofcpsCd = ofcpsCd;
    }

    /**
     * String telno을 반환
     * 
     * @return String telno
     */
    public String getTelno() {
        return telno;
    }

    /**
     * telno을 설정
     * 
     * @param telno 을(를) String telno로 설정
     */
    public void setTelno(String telno) {
        this.telno = telno;
    }

    /**
     * String faxnum을 반환
     * 
     * @return String faxnum
     */
    public String getFaxnum() {
        return faxnum;
    }

    /**
     * faxnum을 설정
     * 
     * @param faxnum 을(를) String faxnum로 설정
     */
    public void setFaxnum(String faxnum) {
        this.faxnum = faxnum;
    }

    /**
     * String mbtlnum을 반환
     * 
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }

    /**
     * mbtlnum을 설정
     * 
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    /**
     * String email을 반환
     * 
     * @return String email
     */
    public String getEmail() {
        return email;
    }

    /**
     * email을 설정
     * 
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Integer loginCnt을 반환
     * 
     * @return Integer loginCnt
     */
    public Integer getLoginCnt() {
        return loginCnt;
    }

    /**
     * loginCnt을 설정
     * 
     * @param loginCnt 을(를) Integer loginCnt로 설정
     */
    public void setLoginCnt(Integer loginCnt) {
        this.loginCnt = loginCnt;
    }

    /**
     * String loginDt을 반환
     * 
     * @return String loginDt
     */
    public String getLoginDt() {
        return loginDt;
    }

    /**
     * loginDt을 설정
     * 
     * @param loginDt 을(를) String loginDt로 설정
     */
    public void setLoginDt(String loginDt) {
        this.loginDt = loginDt;
    }

    /**
     * String useYn을 반환
     * 
     * @return String useYn
     */
    public String getUseYn() {
        return useYn;
    }

    /**
     * useYn을 설정
     * 
     * @param useYn 을(를) String useYn로 설정
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * String ntcnYn을 반환
     * 
     * @return String ntcnYn
     */
    public String getNtcnYn() {
        return ntcnYn;
    }

    /**
     * ntcnYn을 설정
     * 
     * @param ntcnYn 을(를) String ntcnYn로 설정
     */
    public void setNtcnYn(String ntcnYn) {
        this.ntcnYn = ntcnYn;
    }

    /**
     * String emailNticeYn을 반환
     * 
     * @return String emailNticeYn
     */
    public String getEmailNticeYn() {
        return emailNticeYn;
    }

    /**
     * emailNticeYn을 설정
     * 
     * @param emailNticeYn 을(를) String emailNticeYn로 설정
     */
    public void setEmailNticeYn(String emailNticeYn) {
        this.emailNticeYn = emailNticeYn;
    }

    /**
     * String snsNticeYn을 반환
     * 
     * @return String snsNticeYn
     */
    public String getSnsNticeYn() {
        return snsNticeYn;
    }

    /**
     * snsNticeYn을 설정
     * 
     * @param snsNticeYn 을(를) String snsNticeYn로 설정
     */
    public void setSnsNticeYn(String snsNticeYn) {
        this.snsNticeYn = snsNticeYn;
    }

    /**
     * String registId을 반환
     * 
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    /**
     * registId을 설정
     * 
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /**
     * String registDt을 반환
     * 
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }

    /**
     * registDt을 설정
     * 
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    /**
     * String updtDt을 반환
     * 
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }

    /**
     * updtDt을 설정
     * 
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    /**
     * String updtId을 반환
     * 
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }

    /**
     * updtId을 설정
     * 
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    /**
     * String passwordChangeDe을 반환
     * 
     * @return String passwordChangeDe
     */
    public String getPasswordChangeDe() {
        return passwordChangeDe;
    }

    /**
     * passwordChangeDe을 설정
     * 
     * @param passwordChangeDe 을(를) String passwordChangeDe로 설정
     */
    public void setPasswordChangeDe(String passwordChangeDe) {
        this.passwordChangeDe = passwordChangeDe;
    }

    /**
     * String speclAt을 반환
     * 
     * @return String speclAt
     */
    public String getSpeclAt() {
        return speclAt;
    }

    /**
     * speclAt을 설정
     * 
     * @param speclAt 을(를) String speclAt로 설정
     */
    public void setSpeclAt(String speclAt) {
        this.speclAt = speclAt;
    }

    /**
     * Integer sttusCode을 반환
     * 
     * @return Integer sttusCode
     */
    public Integer getSttusCode() {
        return sttusCode;
    }

    /**
     * sttusCode을 설정
     * 
     * @param sttusCode 을(를) Integer sttusCode로 설정
     */
    public void setSttusCode(Integer sttusCode) {
        this.sttusCode = sttusCode;
    }

    /**
     * String sttusBeginDt을 반환
     * 
     * @return String sttusBeginDt
     */
    public String getSttusBeginDt() {
        return sttusBeginDt;
    }

    /**
     * sttusBeginDt을 설정
     * 
     * @param sttusBeginDt 을(를) String sttusBeginDt로 설정
     */
    public void setSttusBeginDt(String sttusBeginDt) {
        this.sttusBeginDt = sttusBeginDt;
    }

    /**
     * String sttusEndDt을 반환
     * 
     * @return String sttusEndDt
     */
    public String getSttusEndDt() {
        return sttusEndDt;
    }

    /**
     * sttusEndDt을 설정
     * 
     * @param sttusEndDt 을(를) String sttusEndDt로 설정
     */
    public void setSttusEndDt(String sttusEndDt) {
        this.sttusEndDt = sttusEndDt;
    }

    /**
     * String chrgJob을 반환
     * 
     * @return String chrgJob
     */
    public String getChrgJob() {
        return chrgJob;
    }

    /**
     * chrgJob을 설정
     * 
     * @param chrgJob 을(를) String chrgJob로 설정
     */
    public void setChrgJob(String chrgJob) {
        this.chrgJob = chrgJob;
    }

    /**
     * List<MenuGrpVO> asnMenuGrpList을 반환
     * 
     * @return List<MenuGrpVO> asnMenuGrpList
     */
    public List<MenuGrpVO> getAsnMenuGrpList() {
        return asnMenuGrpList;
    }

    /**
     * asnMenuGrpList을 설정
     * 
     * @param asnMenuGrpList 을(를) List<MenuGrpVO> asnMenuGrpList로 설정
     */
    public void setAsnMenuGrpList(List<MenuGrpVO> asnMenuGrpList) {
        this.asnMenuGrpList = asnMenuGrpList;
    }

    /**
     * List<Integer> permissionGrpList을 반환
     * 
     * @return List<Integer> permissionGrpList
     */
    public List<Integer> getPermissionGrpList() {
        return permissionGrpList;
    }

    /**
     * permissionGrpList을 설정
     * 
     * @param permissionGrpList 을(를) List<Integer> permissionGrpList로 설정
     */
    public void setPermissionGrpList(List<Integer> permissionGrpList) {
        this.permissionGrpList = permissionGrpList;
    }

    /**
     * List<MenuItemVO> permissionList을 반환
     * 
     * @return List<MenuItemVO> permissionList
     */
    public List<MenuItemVO> getPermissionList() {
        return permissionList;
    }

    /**
     * permissionList을 설정
     * 
     * @param permissionList 을(를) List<MenuItemVO> permissionList로 설정
     */
    public void setPermissionList(List<MenuItemVO> permissionList) {
        this.permissionList = permissionList;
    }

    /**
     * List<MenuVO> myMenuList을 반환
     * 
     * @return List<MenuVO> myMenuList
     */
    public List<MenuVO> getMyMenuList() {
        return myMenuList;
    }

    /**
     * myMenuList을 설정
     * 
     * @param myMenuList 을(를) List<MenuVO> myMenuList로 설정
     */
    public void setMyMenuList(List<MenuVO> myMenuList) {
        this.myMenuList = myMenuList;
    }

    /**
     * String authType을 반환
     * 
     * @return String authType
     */
    public String getAuthType() {
        return authType;
    }

    /**
     * authType을 설정
     * 
     * @param authType 을(를) String authType로 설정
     */
    public void setAuthType(String authType) {
        this.authType = authType;
    }

    /**
     * boolean isValidId을 반환
     * 
     * @return boolean isValidId
     */
    public boolean isValidId() {
        return isValidId;
    }

    /**
     * isValidId을 설정
     * 
     * @param isValidId 을(를) boolean isValidId로 설정
     */
    public void setValidId(boolean isValidId) {
        this.isValidId = isValidId;
    }

    /**
     * boolean isValidPwd을 반환
     * 
     * @return boolean isValidPwd
     */
    public boolean isValidPwd() {
        return isValidPwd;
    }

    /**
     * isValidPwd을 설정
     * 
     * @param isValidPwd 을(를) boolean isValidPwd로 설정
     */
    public void setValidPwd(boolean isValidPwd) {
        this.isValidPwd = isValidPwd;
    }

    /**
     * boolean hasPermission을 반환
     * 
     * @return boolean hasPermission
     */
    public boolean isHasPermission() {
        return hasPermission;
    }

    /**
     * hasPermission을 설정
     * 
     * @param hasPermission 을(를) boolean hasPermission로 설정
     */
    public void setHasPermission(boolean hasPermission) {
        this.hasPermission = hasPermission;
    }

    /**
     * boolean validSSOId을 반환
     * 
     * @return boolean validSSOId
     */
    public boolean isValidSSOId() {
        return validSSOId;
    }

    /**
     * validSSOId을 설정
     * 
     * @param validSSOId 을(를) boolean validSSOId로 설정
     */
    public void setValidSSOId(boolean validSSOId) {
        this.validSSOId = validSSOId;
    }

    /**
     * boolean validSSOCd을 반환
     * 
     * @return boolean validSSOCd
     */
    public boolean isValidSSOCd() {
        return validSSOCd;
    }

    /**
     * validSSOCd을 설정
     * 
     * @param validSSOCd 을(를) boolean validSSOCd로 설정
     */
    public void setValidSSOCd(boolean validSSOCd) {
        this.validSSOCd = validSSOCd;
    }

    /**
     * boolean validSSOIp을 반환
     * 
     * @return boolean validSSOIp
     */
    public boolean isValidSSOIp() {
        return validSSOIp;
    }

    /**
     * validSSOIp을 설정
     * 
     * @param validSSOIp 을(를) boolean validSSOIp로 설정
     */
    public void setValidSSOIp(boolean validSSOIp) {
        this.validSSOIp = validSSOIp;
    }

    /**
     * String sSOUseYN을 반환
     * 
     * @return String sSOUseYN
     */
    public String getSSOUseYN() {
        return SSOUseYN;
    }

    /**
     * sSOUseYN을 설정
     * 
     * @param sSOUseYN 을(를) String sSOUseYN로 설정
     */
    public void setSSOUseYN(String sSOUseYN) {
        SSOUseYN = sSOUseYN;
    }

    /**
     * String sSOIp을 반환
     * 
     * @return String sSOIp
     */
    public String getSSOIp() {
        return SSOIp;
    }

    /**
     * sSOIp을 설정
     * 
     * @param sSOIp 을(를) String sSOIp로 설정
     */
    public void setSSOIp(String sSOIp) {
        SSOIp = sSOIp;
    }

    /**
     * String sSOClientIp을 반환
     * 
     * @return String sSOClientIp
     */
    public String getSSOClientIp() {
        return SSOClientIp;
    }

    /**
     * sSOClientIp을 설정
     * 
     * @param sSOClientIp 을(를) String sSOClientIp로 설정
     */
    public void setSSOClientIp(String sSOClientIp) {
        SSOClientIp = sSOClientIp;
    }

    /**
     * String mgrSSOCd을 반환
     * 
     * @return String mgrSSOCd
     */
    public String getMgrSSOCd() {
        return mgrSSOCd;
    }

    /**
     * mgrSSOCd을 설정
     * 
     * @param mgrSSOCd 을(를) String mgrSSOCd로 설정
     */
    public void setMgrSSOCd(String mgrSSOCd) {
        this.mgrSSOCd = mgrSSOCd;
    }

    /**
     * String mgrSSOId을 반환
     * 
     * @return String mgrSSOId
     */
    public String getMgrSSOId() {
        return mgrSSOId;
    }

    /**
     * mgrSSOId을 설정
     * 
     * @param mgrSSOId 을(를) String mgrSSOId로 설정
     */
    public void setMgrSSOId(String mgrSSOId) {
        this.mgrSSOId = mgrSSOId;
    }

}
