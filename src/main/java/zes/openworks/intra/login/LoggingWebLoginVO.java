/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.login;

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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class LoggingWebLoginVO extends PaggingVO {

    private static final long serialVersionUID = -7585522619158793623L;

    private LoginVO loginVO;

    /**
     * logging date
     */
    private String loginPnttm;

    /**
     * logging type
     */
    private String loginTy;

    /**
     * logging result
     */
    private String loginResult;

    /**
     * loggin ip
     */
    private String loginIp;

    /**
     * mngr loggin menu
     */
    private String mngrLoginMenu;

    /**
     * loggin auth
     */
    private String loginAuth;

    private String passwordChangeDe;

    private String pwdChgDays;

    private Integer ipCnt;

    public LoginVO getLoginVO() {
        return loginVO;
    }

    public void setLoginVO(LoginVO loginVO) {
        this.loginVO = loginVO;
    }

    public String getLoginPnttm() {
        return loginPnttm;
    }

    public void setLoginPnttm(String loginPnttm) {
        this.loginPnttm = loginPnttm;
    }

    public String getLoginTy() {
        return loginTy;
    }

    public void setLoginTy(String loginTy) {
        this.loginTy = loginTy;
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

    public String getMngrLoginMenu() {
        return mngrLoginMenu;
    }

    public void setMngrLoginMenu(String mngrLoginMenu) {
        this.mngrLoginMenu = mngrLoginMenu;
    }

    public String getLoginAuth() {
        return loginAuth;
    }

    public void setLoginAuth(String loginAuth) {
        this.loginAuth = loginAuth;
    }

    public String getPasswordChangeDe() {
        return passwordChangeDe;
    }

    public void setPasswordChangeDe(String passwordChangeDe) {
        this.passwordChangeDe = passwordChangeDe;
    }

    public String getPwdChgDays() {
        return pwdChgDays;
    }

    public void setPwdChgDays(String pwdChgDays) {
        this.pwdChgDays = pwdChgDays;
    }

    public Integer getIpCnt() {
        return ipCnt;
    }

    public void setIpCnt(Integer ipCnt) {
        this.ipCnt = ipCnt;
    }
}
