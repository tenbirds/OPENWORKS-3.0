/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import zes.base.vo.SessVO;

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
 *  2012. 8. 31.    Administrator   신규 생성
 * </pre>
 * @see
 */
public class UserLogVO extends SessVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 4810469658302194652L;

    /** 접속자아이디 */
    private String userId;
    /** 최종접속시간 */
    private String loginDt;
    /** 접속아이피 */
    private String loginIp;
    /** 금일 접속 횟수 */
    private int loginCount;
    /** 전체회원수 */
    private int entireUserCount;
    /** 로그인회원수 */
    private int loginUserCount;
    /** 가입유형 */
    private int sbscrbTyCd;
    /** 연령 */
    private int age;
    /** 성별 */
    private int sex;
    /** 연령대 */
    private String ageType;
    /** 로그인 횟수 */
    private int loginCnt;
    /** 최근 접속 날짜 */
    private String latestLoginDtm;
    /** 성공유무 */
    private int loginResult = 0;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLoginDt() {
        return loginDt;
    }

    public void setLoginDt(String loginDt) {
        this.loginDt = loginDt;
    }

    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }

    public int getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(int loginCount) {
        this.loginCount = loginCount;
    }

    public int getEntireUserCount() {
        return entireUserCount;
    }

    public void setEntireUserCount(int entireUserCount) {
        this.entireUserCount = entireUserCount;
    }

    public int getLoginUserCount() {
        return loginUserCount;
    }

    public void setLoginUserCount(int loginUserCount) {
        this.loginUserCount = loginUserCount;
    }

    public int getSbscrbTyCd() {
        return sbscrbTyCd;
    }

    public void setSbscrbTyCd(int sbscrbTyCd) {
        this.sbscrbTyCd = sbscrbTyCd;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getAgeType() {
        return ageType;
    }

    public void setAgeType(String ageType) {
        this.ageType = ageType;
    }

    public int getLoginCnt() {
        return loginCnt;
    }

    public void setLoginCnt(int loginCnt) {
        this.loginCnt = loginCnt;
    }

    public String getLatestLoginDtm() {
        return latestLoginDtm;
    }

    public void setLatestLoginDtm(String latestLoginDtm) {
        this.latestLoginDtm = latestLoginDtm;
    }

    public int getLoginResult() {
        return loginResult;
    }

    public void setLoginResult(int loginResult) {
        this.loginResult = loginResult;
    }

}
