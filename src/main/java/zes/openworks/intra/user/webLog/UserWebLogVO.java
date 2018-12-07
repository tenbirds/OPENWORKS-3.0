/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.webLog;

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
 *  2012. 5. 22.    유상원   회원 접속 이력 관리
 * </pre>
 * @see
 */
public class UserWebLogVO extends PaggingVO {

    static final long serialVersionUID = -5079031874244096391L;

    /** 사용자 아이디 */
    private String userId;

    /** 사용자 접속일시 */
    private String loginDtm;

    /** 사용자 접속메뉴 */
    private String loginMenu;

    /** 사용자 인증방식 */
    private String loginAuth;

    /** 사용자 로그인 결과 */
    private String loginResult;

    /** 사용자 로그인 결과 */
    private String loginIp;

    /** 사용자 로그인 실패 이유 */
    private String loginFailReason;

    /** 총접속자 수 */
    private int entireUserCount;

    /** 로그인 수 */
    private int loginUserCount;

    /** 비로그인 수 */
    private int notLoginUserCount;

    /** gpin가입 */
    private int gpinUserCount;
    /** 공인인증가입 */
    private int certificateUserCount;
    /** 일반회원가입 */
    private int generalUserCount;
    /** 기타 */
    private int etcUserCount;
    /** 10대 */
    private int teenCount;
    /** 20대 */
    private int twentyCount;
    /** 30대 */
    private int thirtyCount;
    /** 40대 */
    private int fortyCount;
    /** 50대 */
    private int fiftyCount;
    /** 60대 */
    private int sixtyCount;
    /** 기타연령 */
    private int seventyEtcCount;
    /** 남성 */
    private int manCount;
    /** 여성 */
    private int womanCount;
    /** 미등록 성 */
    private int etcSexCount;
    /** 가입유형총합 */
    private int memberTypeCount;
    /** 연령대총합 */
    private int ageTypeCount;
    /** 성별총합 */
    private int sexTypeCount;
    /** 로그인 날짜 */
    private String loginDt;
    /** 가입유형 */
    private String regType;

    private int ipCount;

    private String loginIpTotal;

    /**
     * String loginIpTotal을 반환
     * 
     * @return String loginIpTotal
     */
    public String getLoginIpTotal() {
        return loginIpTotal;
    }

    /**
     * loginIpTotal을 설정
     * 
     * @param loginIpTotal 을(를) String loginIpTotal로 설정
     */
    public void setLoginIpTotal(String loginIpTotal) {
        this.loginIpTotal = loginIpTotal;
    }

    /**
     * int ipCount을 반환
     * 
     * @return int ipCount
     */
    public int getIpCount() {
        return ipCount;
    }

    /**
     * ipCount을 설정
     * 
     * @param ipCount 을(를) int ipCount로 설정
     */
    public void setIpCount(int ipCount) {
        this.ipCount = ipCount;
    }

    /**
     * String regType을 반환
     * 
     * @return String regType
     */
    public String getRegType() {
        return regType;
    }

    /**
     * regType을 설정
     * 
     * @param regType 을(를) String regType로 설정
     */
    public void setRegType(String regType) {
        this.regType = regType;
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
     * int memberTypeCount을 반환
     * 
     * @return int memberTypeCount
     */
    public int getMemberTypeCount() {
        return memberTypeCount;
    }

    /**
     * int ageTypeCount을 반환
     * 
     * @return int ageTypeCount
     */
    public int getAgeTypeCount() {
        return ageTypeCount;
    }

    /**
     * int sexTypeCount을 반환
     * 
     * @return int sexTypeCount
     */
    public int getSexTypeCount() {
        return sexTypeCount;
    }

    /**
     * memberTypeCount을 설정
     * 
     * @param memberTypeCount 을(를) int memberTypeCount로 설정
     */
    public void setMemberTypeCount(int memberTypeCount) {
        this.memberTypeCount = memberTypeCount;
    }

    /**
     * ageTypeCount을 설정
     * 
     * @param ageTypeCount 을(를) int ageTypeCount로 설정
     */
    public void setAgeTypeCount(int ageTypeCount) {
        this.ageTypeCount = ageTypeCount;
    }

    /**
     * sexTypeCount을 설정
     * 
     * @param sexTypeCount 을(를) int sexTypeCount로 설정
     */
    public void setSexTypeCount(int sexTypeCount) {
        this.sexTypeCount = sexTypeCount;
    }

    /**
     * int thirtyCount을 반환
     * 
     * @return int thirtyCount
     */
    public int getThirtyCount() {
        return thirtyCount;
    }

    /**
     * thirtyCount을 설정
     * 
     * @param thirtyCount 을(를) int thirtyCount로 설정
     */
    public void setThirtyCount(int thirtyCount) {
        this.thirtyCount = thirtyCount;
    }

    /**
     * int teenCount을 반환
     * 
     * @return int teenCount
     */
    public int getTeenCount() {
        return teenCount;
    }

    /**
     * int twentyCount을 반환
     * 
     * @return int twentyCount
     */
    public int getTwentyCount() {
        return twentyCount;
    }

    /**
     * int fortyCount을 반환
     * 
     * @return int fortyCount
     */
    public int getFortyCount() {
        return fortyCount;
    }

    /**
     * int fiftyCount을 반환
     * 
     * @return int fiftyCount
     */
    public int getFiftyCount() {
        return fiftyCount;
    }

    /**
     * int sixtyCount을 반환
     * 
     * @return int sixtyCount
     */
    public int getSixtyCount() {
        return sixtyCount;
    }

    /**
     * int seventyEtcCount을 반환
     * 
     * @return int seventyEtcCount
     */
    public int getSeventyEtcCount() {
        return seventyEtcCount;
    }

    /**
     * int manCount을 반환
     * 
     * @return int manCount
     */
    public int getManCount() {
        return manCount;
    }

    /**
     * int womanCount을 반환
     * 
     * @return int womanCount
     */
    public int getWomanCount() {
        return womanCount;
    }

    /**
     * int etcSexCount을 반환
     * 
     * @return int etcSexCount
     */
    public int getEtcSexCount() {
        return etcSexCount;
    }

    /**
     * teenCount을 설정
     * 
     * @param teenCount 을(를) int teenCount로 설정
     */
    public void setTeenCount(int teenCount) {
        this.teenCount = teenCount;
    }

    /**
     * twentyCount을 설정
     * 
     * @param twentyCount 을(를) int twentyCount로 설정
     */
    public void setTwentyCount(int twentyCount) {
        this.twentyCount = twentyCount;
    }

    /**
     * fortyCount을 설정
     * 
     * @param fortyCount 을(를) int fortyCount로 설정
     */
    public void setFortyCount(int fortyCount) {
        this.fortyCount = fortyCount;
    }

    /**
     * fiftyCount을 설정
     * 
     * @param fiftyCount 을(를) int fiftyCount로 설정
     */
    public void setFiftyCount(int fiftyCount) {
        this.fiftyCount = fiftyCount;
    }

    /**
     * sixtyCount을 설정
     * 
     * @param sixtyCount 을(를) int sixtyCount로 설정
     */
    public void setSixtyCount(int sixtyCount) {
        this.sixtyCount = sixtyCount;
    }

    /**
     * seventyEtcCount을 설정
     * 
     * @param seventyEtcCount 을(를) int seventyEtcCount로 설정
     */
    public void setSeventyEtcCount(int seventyEtcCount) {
        this.seventyEtcCount = seventyEtcCount;
    }

    /**
     * manCount을 설정
     * 
     * @param manCount 을(를) int manCount로 설정
     */
    public void setManCount(int manCount) {
        this.manCount = manCount;
    }

    /**
     * womanCount을 설정
     * 
     * @param womanCount 을(를) int womanCount로 설정
     */
    public void setWomanCount(int womanCount) {
        this.womanCount = womanCount;
    }

    /**
     * etcSexCount을 설정
     * 
     * @param etcSexCount 을(를) int etcSexCount로 설정
     */
    public void setEtcSexCount(int etcSexCount) {
        this.etcSexCount = etcSexCount;
    }

    /**
     * int gpinUserCount을 반환
     * 
     * @return int gpinUserCount
     */
    public int getGpinUserCount() {
        return gpinUserCount;
    }

    /**
     * int certificateUserCount을 반환
     * 
     * @return int certificateUserCount
     */
    public int getCertificateUserCount() {
        return certificateUserCount;
    }

    /**
     * int generalUserCount을 반환
     * 
     * @return int generalUserCount
     */
    public int getGeneralUserCount() {
        return generalUserCount;
    }

    /**
     * int etcUserCount을 반환
     * 
     * @return int etcUserCount
     */
    public int getEtcUserCount() {
        return etcUserCount;
    }

    /**
     * gpinUserCount을 설정
     * 
     * @param gpinUserCount 을(를) int gpinUserCount로 설정
     */
    public void setGpinUserCount(int gpinUserCount) {
        this.gpinUserCount = gpinUserCount;
    }

    /**
     * certificateUserCount을 설정
     * 
     * @param certificateUserCount 을(를) int certificateUserCount로 설정
     */
    public void setCertificateUserCount(int certificateUserCount) {
        this.certificateUserCount = certificateUserCount;
    }

    /**
     * generalUserCount을 설정
     * 
     * @param generalUserCount 을(를) int generalUserCount로 설정
     */
    public void setGeneralUserCount(int generalUserCount) {
        this.generalUserCount = generalUserCount;
    }

    /**
     * etcUserCount을 설정
     * 
     * @param etcUserCount 을(를) int etcUserCount로 설정
     */
    public void setEtcUserCount(int etcUserCount) {
        this.etcUserCount = etcUserCount;
    }

    /**
     * int notLoginUserCount을 반환
     * 
     * @return int notLoginUserCount
     */
    public int getNotLoginUserCount() {
        return notLoginUserCount;
    }

    /**
     * notLoginUserCount을 설정
     * 
     * @param notLoginUserCount 을(를) int notLoginUserCount로 설정
     */
    public void setNotLoginUserCount(int notLoginUserCount) {
        this.notLoginUserCount = notLoginUserCount;
    }

    /**
     * int entireUserCount을 반환
     * 
     * @return int entireUserCount
     */
    public int getEntireUserCount() {
        return entireUserCount;
    }

    /**
     * int loginUserCount을 반환
     * 
     * @return int loginUserCount
     */
    public int getLoginUserCount() {
        return loginUserCount;
    }

    /**
     * entireUserCount을 설정
     * 
     * @param entireUserCount 을(를) int entireUserCount로 설정
     */
    public void setEntireUserCount(int entireUserCount) {
        this.entireUserCount = entireUserCount;
    }

    /**
     * loginUserCount을 설정
     * 
     * @param loginUserCount 을(를) int loginUserCount로 설정
     */
    public void setLoginUserCount(int loginUserCount) {
        this.loginUserCount = loginUserCount;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLoginDtm() {
        return loginDtm;
    }

    public void setLoginDtm(String loginDtm) {
        this.loginDtm = loginDtm;
    }

    public String getLoginMenu() {
        return loginMenu;
    }

    public void setLoginMenu(String loginMenu) {
        this.loginMenu = loginMenu;
    }

    public String getLoginAuth() {
        return loginAuth;
    }

    public void setLoginAuth(String loginAuth) {
        this.loginAuth = loginAuth;
    }

    public String getLoginResult() {
        return loginResult;
    }

    public void setLoginResult(String loginResult) {
        this.loginResult = loginResult;
    }

    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }

    public String getLoginFailReason() {
        return loginFailReason;
    }

    public void setLoginFailReason(String loginFailReason) {
        this.loginFailReason = loginFailReason;
    }

}
