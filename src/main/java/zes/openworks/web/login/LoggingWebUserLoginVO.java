/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since kwea_new 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 2. 5.    김영상      신규
 *</pre>
 * @see
 */
public class LoggingWebUserLoginVO extends PaggingVO {

    private static final long serialVersionUID = -7034137009652214284L;

    private UserLoginVO UserLoginVO;

    private String loginDtm;

    private String loginMenu;

    private String logAuth;

    private String loginResult;

    private String loginIp;

    private String loginFailReason;

    private String pwdChgDate;

    private String pwdChgDays;

    private Integer ipCnt;

    
    
    
    /**
     * UserLoginVO userLoginVO을 반환
     * @return UserLoginVO userLoginVO
     */
    public UserLoginVO getUserLoginVO() {
        return UserLoginVO;
    }


    
    /**
     * userLoginVO을 설정
     * @param userLoginVO 을(를) UserLoginVO userLoginVO로 설정
     */
    public void setUserLoginVO(UserLoginVO userLoginVO) {
        UserLoginVO = userLoginVO;
    }


    /**
     * String loginDtm을 반환
     * @return String loginDtm
     */
    public String getLoginDtm() {
        return loginDtm;
    }

    
    /**
     * loginDtm을 설정
     * @param loginDtm 을(를) String loginDtm로 설정
     */
    public void setLoginDtm(String loginDtm) {
        this.loginDtm = loginDtm;
    }

    
    /**
     * String loginMenu을 반환
     * @return String loginMenu
     */
    public String getLoginMenu() {
        return loginMenu;
    }

    
    /**
     * loginMenu을 설정
     * @param loginMenu 을(를) String loginMenu로 설정
     */
    public void setLoginMenu(String loginMenu) {
        this.loginMenu = loginMenu;
    }

    
    /**
     * String logAuth을 반환
     * @return String logAuth
     */
    public String getLogAuth() {
        return logAuth;
    }

    
    /**
     * logAuth을 설정
     * @param logAuth 을(를) String logAuth로 설정
     */
    public void setLogAuth(String logAuth) {
        this.logAuth = logAuth;
    }

    
    /**
     * String loginResult을 반환
     * @return String loginResult
     */
    public String getLoginResult() {
        return loginResult;
    }

    
    /**
     * loginResult을 설정
     * @param loginResult 을(를) String loginResult로 설정
     */
    public void setLoginResult(String loginResult) {
        this.loginResult = loginResult;
    }

    
    /**
     * String loginIp을 반환
     * @return String loginIp
     */
    public String getLoginIp() {
        return loginIp;
    }

    
    /**
     * loginIp을 설정
     * @param loginIp 을(를) String loginIp로 설정
     */
    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }

    
    /**
     * String loginFailReason을 반환
     * @return String loginFailReason
     */
    public String getLoginFailReason() {
        return loginFailReason;
    }

    
    /**
     * loginFailReason을 설정
     * @param loginFailReason 을(를) String loginFailReason로 설정
     */
    public void setLoginFailReason(String loginFailReason) {
        this.loginFailReason = loginFailReason;
    }

    
    /**
     * String pwdChgDate을 반환
     * @return String pwdChgDate
     */
    public String getPwdChgDate() {
        return pwdChgDate;
    }

    
    /**
     * pwdChgDate을 설정
     * @param pwdChgDate 을(를) String pwdChgDate로 설정
     */
    public void setPwdChgDate(String pwdChgDate) {
        this.pwdChgDate = pwdChgDate;
    }

    
    /**
     * String pwdChgDays을 반환
     * @return String pwdChgDays
     */
    public String getPwdChgDays() {
        return pwdChgDays;
    }

    
    /**
     * pwdChgDays을 설정
     * @param pwdChgDays 을(를) String pwdChgDays로 설정
     */
    public void setPwdChgDays(String pwdChgDays) {
        this.pwdChgDays = pwdChgDays;
    }

    
    /**
     * Integer ipCnt을 반환
     * @return Integer ipCnt
     */
    public Integer getIpCnt() {
        return ipCnt;
    }

    
    /**
     * ipCnt을 설정
     * @param ipCnt 을(를) Integer ipCnt로 설정
     */
    public void setIpCnt(Integer ipCnt) {
        this.ipCnt = ipCnt;
    }
}
