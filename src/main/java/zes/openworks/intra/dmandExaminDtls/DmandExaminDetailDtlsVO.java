/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDtls;

import zes.base.vo.PaggingVO;

/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2016. 10. 06.   최강식   신규
*</pre>
* @see
*/

public class DmandExaminDetailDtlsVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -2065559676127699119L;

    /*수요조사순번*/
    private int dmandExaminSn;
    /*회원아이디*/
    private String userId;
    /*순번*/
    private int dmandSurveyNo;
    /*상위기관명*/
    private String dmandSurveyHighorgname;
    /*기관명*/
    private String dmandSurveyOrgname;
    /*시스템명*/
    private String dmandSurveySysname;
    /*시스템목적*/
    private String dmandSurveySysobj;
    /*시스템구분(기존/신규)*/
    private String dmandSurveyDivision;
    /*담당자*/
    private String dmandSurveyManager;
    /*이메일*/
    private String dmandSurveyMail;
    /*연락처*/
    private String dmandSurveyPhone;
    /*구축년도(YYYY)*/
    private String dmandSurveyBuildy;
    /*최근업그레이드년도(YYYY)*/
    private String dmandSurveyUpy;
    /*구축비*/
    private String dmandSurveyBuildcost;
    /*당해년도유지보수비*/
    private String dmandSurveyMaint;
    /*당해년도운영비*/
    private String dmandSurveyExpenses;
    /*클라우드이용여부*/
    private String dmandSurveyClouduse;
    /*클라우드구분(민간/자체/G-Cloud)*/
    private String dmandSurveySeparation;
    /*클라우드도입년도(YYYY)*/
    private String dmandSurveyIntroy;
    /*시스템(Y/N)*/
    private String dmandSurveyFirstsyst;
    /*구현성(Y/N)*/
    private String dmandSurveyFirstreal;
    /*경제성(Y/N)*/
    private String dmandSurveyFirstecon;
    /*제외대상(Y/N)*/
    private String dmandSurveyExem;
    /*서비스(3/2/1)*/
    private String dmandSurveySecoundserv;
    /*데이터(3/2/1)*/
    private String dmandSurveySecounddata;
    /*연계(3/2/1)*/
    private String dmandSurveySecoundconn;
    /*업무대체율(3/2/1)*/
    private String dmandSurveySecoundsubs;
    /*업무대체비용(3/2/1)*/
    private String dmandSurveySecoundsubscost;
    /*업무대체수준(㉕+㉖)/2*/
    private String dmandSurveySecoundsubslevel;
    /*사고시파급효과(3/2/1)*/
    private String dmandSurveySecoundripp;
    /*총점*/
    private String dmandSurveyTotalscore;
    /*평균*/
    private String dmandSurveyAverage;
    /*클라우드자체평가등급*/
    private String dmandSurveySelflevel;
    /*클라우드전환 또는 도입예정(전환/도입예정/N)*/
    private String dmandSurveyChangep;
    /*클라우드구분(민간/자체/G-Cloud)*/
    private String dmandSurveySeparation2;
    /*2017년 1/4분기(단위:천원)*/
    private String dmandSurveyFiquater;
    /*2017년 2/4분기(단위:천원)*/
    private String dmandSurveySequater;
    /*2017년 3/4분기(단위:천원)*/
    private String dmandSurveyThquater;
    /*2017년 4/4분기(단위:천원)*/
    private String dmandSurveyFoquater;
    /*2017년 이후(단위:천원)*/
    private String dmandSurveyAfquater;
    /*2017년(Y/N)*/
    private String dmandSurveyChangeth;
    /*2017년 이후 전환연도(YYYY)*/
    private String dmandSurveyChangene;


    /**
     * int dmandExaminSn을 반환
     * @return int dmandExaminSn
     */
    public int getDmandExaminSn() {
        return dmandExaminSn;
    }

    /**
     * dmandExaminSn을 설정
     * @param dmandExaminSn 을(를) int dmandExaminSn로 설정
     */
    public void setDmandExaminSn(int dmandExaminSn) {
        this.dmandExaminSn = dmandExaminSn;
    }

    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * int dmandSurveyNo을 반환
     * @return int dmandSurveyNo
     */
    public int getDmandSurveyNo() {
        return dmandSurveyNo;
    }

    /**
     * dmandSurveyNo을 설정
     * @param dmandSurveyNo 을(를) int dmandSurveyNo로 설정
     */
    public void setDmandSurveyNo(int dmandSurveyNo) {
        this.dmandSurveyNo = dmandSurveyNo;
    }

    /**
     * String dmandSurveyHighorgname을 반환
     * @return String dmandSurveyHighorgname
     */
    public String getDmandSurveyHighorgname() {
        return dmandSurveyHighorgname;
    }

    /**
     * dmandSurveyHighorgname을 설정
     * @param dmandSurveyHighorgname 을(를) String dmandSurveyHighorgname로 설정
     */
    public void setDmandSurveyHighorgname(String dmandSurveyHighorgname) {
        this.dmandSurveyHighorgname = dmandSurveyHighorgname;
    }

    /**
     * String dmandSurveyOrgname을 반환
     * @return String dmandSurveyOrgname
     */
    public String getDmandSurveyOrgname() {
        return dmandSurveyOrgname;
    }

    /**
     * dmandSurveyOrgname을 설정
     * @param dmandSurveyOrgname 을(를) String dmandSurveyOrgname로 설정
     */
    public void setDmandSurveyOrgname(String dmandSurveyOrgname) {
        this.dmandSurveyOrgname = dmandSurveyOrgname;
    }

    /**
     * String dmandSurveySysname을 반환
     * @return String dmandSurveySysname
     */
    public String getDmandSurveySysname() {
        return dmandSurveySysname;
    }

    /**
     * dmandSurveySysname을 설정
     * @param dmandSurveySysname 을(를) String dmandSurveySysname로 설정
     */
    public void setDmandSurveySysname(String dmandSurveySysname) {
        this.dmandSurveySysname = dmandSurveySysname;
    }

    /**
     * String dmandSurveySysobj을 반환
     * @return String dmandSurveySysobj
     */
    public String getDmandSurveySysobj() {
        return dmandSurveySysobj;
    }

    /**
     * dmandSurveySysobj을 설정
     * @param dmandSurveySysobj 을(를) String dmandSurveySysobj로 설정
     */
    public void setDmandSurveySysobj(String dmandSurveySysobj) {
        this.dmandSurveySysobj = dmandSurveySysobj;
    }

    /**
     * String dmandSurveyDivision을 반환
     * @return String dmandSurveyDivision
     */
    public String getDmandSurveyDivision() {
        return dmandSurveyDivision;
    }

    /**
     * dmandSurveyDivision을 설정
     * @param dmandSurveyDivision 을(를) String dmandSurveyDivision로 설정
     */
    public void setDmandSurveyDivision(String dmandSurveyDivision) {
        this.dmandSurveyDivision = dmandSurveyDivision;
    }

    /**
     * String dmandSurveyManager을 반환
     * @return String dmandSurveyManager
     */
    public String getDmandSurveyManager() {
        return dmandSurveyManager;
    }

    /**
     * dmandSurveyManager을 설정
     * @param dmandSurveyManager 을(를) String dmandSurveyManager로 설정
     */
    public void setDmandSurveyManager(String dmandSurveyManager) {
        this.dmandSurveyManager = dmandSurveyManager;
    }

    /**
     * String dmandSurveyMail을 반환
     * @return String dmandSurveyMail
     */
    public String getDmandSurveyMail() {
        return dmandSurveyMail;
    }

    /**
     * dmandSurveyMail을 설정
     * @param dmandSurveyMail 을(를) String dmandSurveyMail로 설정
     */
    public void setDmandSurveyMail(String dmandSurveyMail) {
        this.dmandSurveyMail = dmandSurveyMail;
    }

    /**
     * String dmandSurveyPhone을 반환
     * @return String dmandSurveyPhone
     */
    public String getDmandSurveyPhone() {
        return dmandSurveyPhone;
    }

    /**
     * dmandSurveyPhone을 설정
     * @param dmandSurveyPhone 을(를) String dmandSurveyPhone로 설정
     */
    public void setDmandSurveyPhone(String dmandSurveyPhone) {
        this.dmandSurveyPhone = dmandSurveyPhone;
    }

    /**
     * String dmandSurveyBuildy을 반환
     * @return String dmandSurveyBuildy
     */
    public String getDmandSurveyBuildy() {
        return dmandSurveyBuildy;
    }

    /**
     * dmandSurveyBuildy을 설정
     * @param dmandSurveyBuildy 을(를) String dmandSurveyBuildy로 설정
     */
    public void setDmandSurveyBuildy(String dmandSurveyBuildy) {
        this.dmandSurveyBuildy = dmandSurveyBuildy;
    }

    /**
     * String dmandSurveyUpy을 반환
     * @return String dmandSurveyUpy
     */
    public String getDmandSurveyUpy() {
        return dmandSurveyUpy;
    }

    /**
     * dmandSurveyUpy을 설정
     * @param dmandSurveyUpy 을(를) String dmandSurveyUpy로 설정
     */
    public void setDmandSurveyUpy(String dmandSurveyUpy) {
        this.dmandSurveyUpy = dmandSurveyUpy;
    }

    /**
     * String dmandSurveyBuildcost을 반환
     * @return String dmandSurveyBuildcost
     */
    public String getDmandSurveyBuildcost() {
        return dmandSurveyBuildcost;
    }

    /**
     * dmandSurveyBuildcost을 설정
     * @param dmandSurveyBuildcost 을(를) String dmandSurveyBuildcost로 설정
     */
    public void setDmandSurveyBuildcost(String dmandSurveyBuildcost) {
        this.dmandSurveyBuildcost = dmandSurveyBuildcost;
    }

    /**
     * String dmandSurveyMaint을 반환
     * @return String dmandSurveyMaint
     */
    public String getDmandSurveyMaint() {
        return dmandSurveyMaint;
    }

    /**
     * dmandSurveyMaint을 설정
     * @param dmandSurveyMaint 을(를) String dmandSurveyMaint로 설정
     */
    public void setDmandSurveyMaint(String dmandSurveyMaint) {
        this.dmandSurveyMaint = dmandSurveyMaint;
    }

    /**
     * String dmandSurveyExpenses을 반환
     * @return String dmandSurveyExpenses
     */
    public String getDmandSurveyExpenses() {
        return dmandSurveyExpenses;
    }

    /**
     * dmandSurveyExpenses을 설정
     * @param dmandSurveyExpenses 을(를) String dmandSurveyExpenses로 설정
     */
    public void setDmandSurveyExpenses(String dmandSurveyExpenses) {
        this.dmandSurveyExpenses = dmandSurveyExpenses;
    }

    /**
     * String dmandSurveyClouduse을 반환
     * @return String dmandSurveyClouduse
     */
    public String getDmandSurveyClouduse() {
        return dmandSurveyClouduse;
    }

    /**
     * dmandSurveyClouduse을 설정
     * @param dmandSurveyClouduse 을(를) String dmandSurveyClouduse로 설정
     */
    public void setDmandSurveyClouduse(String dmandSurveyClouduse) {
        this.dmandSurveyClouduse = dmandSurveyClouduse;
    }

    /**
     * String dmandSurveySeparation을 반환
     * @return String dmandSurveySeparation
     */
    public String getDmandSurveySeparation() {
        return dmandSurveySeparation;
    }

    /**
     * dmandSurveySeparation을 설정
     * @param dmandSurveySeparation 을(를) String dmandSurveySeparation로 설정
     */
    public void setDmandSurveySeparation(String dmandSurveySeparation) {
        this.dmandSurveySeparation = dmandSurveySeparation;
    }

    /**
     * String dmandSurveyIntroy을 반환
     * @return String dmandSurveyIntroy
     */
    public String getDmandSurveyIntroy() {
        return dmandSurveyIntroy;
    }

    /**
     * dmandSurveyIntroy을 설정
     * @param dmandSurveyIntroy 을(를) String dmandSurveyIntroy로 설정
     */
    public void setDmandSurveyIntroy(String dmandSurveyIntroy) {
        this.dmandSurveyIntroy = dmandSurveyIntroy;
    }

    /**
     * String dmandSurveyFirstsyst을 반환
     * @return String dmandSurveyFirstsyst
     */
    public String getDmandSurveyFirstsyst() {
        return dmandSurveyFirstsyst;
    }

    /**
     * dmandSurveyFirstsyst을 설정
     * @param dmandSurveyFirstsyst 을(를) String dmandSurveyFirstsyst로 설정
     */
    public void setDmandSurveyFirstsyst(String dmandSurveyFirstsyst) {
        this.dmandSurveyFirstsyst = dmandSurveyFirstsyst;
    }

    /**
     * String dmandSurveyFirstreal을 반환
     * @return String dmandSurveyFirstreal
     */
    public String getDmandSurveyFirstreal() {
        return dmandSurveyFirstreal;
    }

    /**
     * dmandSurveyFirstreal을 설정
     * @param dmandSurveyFirstreal 을(를) String dmandSurveyFirstreal로 설정
     */
    public void setDmandSurveyFirstreal(String dmandSurveyFirstreal) {
        this.dmandSurveyFirstreal = dmandSurveyFirstreal;
    }

    /**
     * String dmandSurveyFirstecon을 반환
     * @return String dmandSurveyFirstecon
     */
    public String getDmandSurveyFirstecon() {
        return dmandSurveyFirstecon;
    }

    /**
     * dmandSurveyFirstecon을 설정
     * @param dmandSurveyFirstecon 을(를) String dmandSurveyFirstecon로 설정
     */
    public void setDmandSurveyFirstecon(String dmandSurveyFirstecon) {
        this.dmandSurveyFirstecon = dmandSurveyFirstecon;
    }

    /**
     * String dmandSurveyExem을 반환
     * @return String dmandSurveyExem
     */
    public String getDmandSurveyExem() {
        return dmandSurveyExem;
    }

    /**
     * dmandSurveyExem을 설정
     * @param dmandSurveyExem 을(를) String dmandSurveyExem로 설정
     */
    public void setDmandSurveyExem(String dmandSurveyExem) {
        this.dmandSurveyExem = dmandSurveyExem;
    }

    /**
     * String dmandSurveySecoundserv을 반환
     * @return String dmandSurveySecoundserv
     */
    public String getDmandSurveySecoundserv() {
        return dmandSurveySecoundserv;
    }

    /**
     * dmandSurveySecoundserv을 설정
     * @param dmandSurveySecoundserv 을(를) String dmandSurveySecoundserv로 설정
     */
    public void setDmandSurveySecoundserv(String dmandSurveySecoundserv) {
        this.dmandSurveySecoundserv = dmandSurveySecoundserv;
    }

    /**
     * String dmandSurveySecounddata을 반환
     * @return String dmandSurveySecounddata
     */
    public String getDmandSurveySecounddata() {
        return dmandSurveySecounddata;
    }

    /**
     * dmandSurveySecounddata을 설정
     * @param dmandSurveySecounddata 을(를) String dmandSurveySecounddata로 설정
     */
    public void setDmandSurveySecounddata(String dmandSurveySecounddata) {
        this.dmandSurveySecounddata = dmandSurveySecounddata;
    }

    /**
     * String dmandSurveySecoundconn을 반환
     * @return String dmandSurveySecoundconn
     */
    public String getDmandSurveySecoundconn() {
        return dmandSurveySecoundconn;
    }

    /**
     * dmandSurveySecoundconn을 설정
     * @param dmandSurveySecoundconn 을(를) String dmandSurveySecoundconn로 설정
     */
    public void setDmandSurveySecoundconn(String dmandSurveySecoundconn) {
        this.dmandSurveySecoundconn = dmandSurveySecoundconn;
    }

    /**
     * String dmandSurveySecoundsubs을 반환
     * @return String dmandSurveySecoundsubs
     */
    public String getDmandSurveySecoundsubs() {
        return dmandSurveySecoundsubs;
    }

    /**
     * dmandSurveySecoundsubs을 설정
     * @param dmandSurveySecoundsubs 을(를) String dmandSurveySecoundsubs로 설정
     */
    public void setDmandSurveySecoundsubs(String dmandSurveySecoundsubs) {
        this.dmandSurveySecoundsubs = dmandSurveySecoundsubs;
    }

    /**
     * String dmandSurveySecoundsubscost을 반환
     * @return String dmandSurveySecoundsubscost
     */
    public String getDmandSurveySecoundsubscost() {
        return dmandSurveySecoundsubscost;
    }

    /**
     * dmandSurveySecoundsubscost을 설정
     * @param dmandSurveySecoundsubscost 을(를) String dmandSurveySecoundsubscost로 설정
     */
    public void setDmandSurveySecoundsubscost(String dmandSurveySecoundsubscost) {
        this.dmandSurveySecoundsubscost = dmandSurveySecoundsubscost;
    }

    /**
     * String dmandSurveySecoundsubslevel을 반환
     * @return String dmandSurveySecoundsubslevel
     */
    public String getDmandSurveySecoundsubslevel() {
        return dmandSurveySecoundsubslevel;
    }

    /**
     * dmandSurveySecoundsubslevel을 설정
     * @param dmandSurveySecoundsubslevel 을(를) String dmandSurveySecoundsubslevel로 설정
     */
    public void setDmandSurveySecoundsubslevel(String dmandSurveySecoundsubslevel) {
        this.dmandSurveySecoundsubslevel = dmandSurveySecoundsubslevel;
    }

    /**
     * String dmandSurveySecoundripp을 반환
     * @return String dmandSurveySecoundripp
     */
    public String getDmandSurveySecoundripp() {
        return dmandSurveySecoundripp;
    }

    /**
     * dmandSurveySecoundripp을 설정
     * @param dmandSurveySecoundripp 을(를) String dmandSurveySecoundripp로 설정
     */
    public void setDmandSurveySecoundripp(String dmandSurveySecoundripp) {
        this.dmandSurveySecoundripp = dmandSurveySecoundripp;
    }

    /**
     * String dmandSurveyTotalscore을 반환
     * @return String dmandSurveyTotalscore
     */
    public String getDmandSurveyTotalscore() {
        return dmandSurveyTotalscore;
    }

    /**
     * dmandSurveyTotalscore을 설정
     * @param dmandSurveyTotalscore 을(를) String dmandSurveyTotalscore로 설정
     */
    public void setDmandSurveyTotalscore(String dmandSurveyTotalscore) {
        this.dmandSurveyTotalscore = dmandSurveyTotalscore;
    }

    /**
     * String dmandSurveyAverage을 반환
     * @return String dmandSurveyAverage
     */
    public String getDmandSurveyAverage() {
        return dmandSurveyAverage;
    }

    /**
     * dmandSurveyAverage을 설정
     * @param dmandSurveyAverage 을(를) String dmandSurveyAverage로 설정
     */
    public void setDmandSurveyAverage(String dmandSurveyAverage) {
        this.dmandSurveyAverage = dmandSurveyAverage;
    }

    /**
     * String dmandSurveySelflevel을 반환
     * @return String dmandSurveySelflevel
     */
    public String getDmandSurveySelflevel() {
        return dmandSurveySelflevel;
    }

    /**
     * dmandSurveySelflevel을 설정
     * @param dmandSurveySelflevel 을(를) String dmandSurveySelflevel로 설정
     */
    public void setDmandSurveySelflevel(String dmandSurveySelflevel) {
        this.dmandSurveySelflevel = dmandSurveySelflevel;
    }

    /**
     * String dmandSurveyChangep을 반환
     * @return String dmandSurveyChangep
     */
    public String getDmandSurveyChangep() {
        return dmandSurveyChangep;
    }

    /**
     * dmandSurveyChangep을 설정
     * @param dmandSurveyChangep 을(를) String dmandSurveyChangep로 설정
     */
    public void setDmandSurveyChangep(String dmandSurveyChangep) {
        this.dmandSurveyChangep = dmandSurveyChangep;
    }

    /**
     * String dmandSurveySeparation2을 반환
     * @return String dmandSurveySeparation2
     */
    public String getDmandSurveySeparation2() {
        return dmandSurveySeparation2;
    }

    /**
     * dmandSurveySeparation2을 설정
     * @param dmandSurveySeparation2 을(를) String dmandSurveySeparation2로 설정
     */
    public void setDmandSurveySeparation2(String dmandSurveySeparation2) {
        this.dmandSurveySeparation2 = dmandSurveySeparation2;
    }

    /**
     * String dmandSurveyFiquater을 반환
     * @return String dmandSurveyFiquater
     */
    public String getDmandSurveyFiquater() {
        return dmandSurveyFiquater;
    }

    /**
     * dmandSurveyFiquater을 설정
     * @param dmandSurveyFiquater 을(를) String dmandSurveyFiquater로 설정
     */
    public void setDmandSurveyFiquater(String dmandSurveyFiquater) {
        this.dmandSurveyFiquater = dmandSurveyFiquater;
    }

    /**
     * String dmandSurveySequater을 반환
     * @return String dmandSurveySequater
     */
    public String getDmandSurveySequater() {
        return dmandSurveySequater;
    }

    /**
     * dmandSurveySequater을 설정
     * @param dmandSurveySequater 을(를) String dmandSurveySequater로 설정
     */
    public void setDmandSurveySequater(String dmandSurveySequater) {
        this.dmandSurveySequater = dmandSurveySequater;
    }

    /**
     * String dmandSurveyThquater을 반환
     * @return String dmandSurveyThquater
     */
    public String getDmandSurveyThquater() {
        return dmandSurveyThquater;
    }

    /**
     * dmandSurveyThquater을 설정
     * @param dmandSurveyThquater 을(를) String dmandSurveyThquater로 설정
     */
    public void setDmandSurveyThquater(String dmandSurveyThquater) {
        this.dmandSurveyThquater = dmandSurveyThquater;
    }

    /**
     * String dmandSurveyFoquater을 반환
     * @return String dmandSurveyFoquater
     */
    public String getDmandSurveyFoquater() {
        return dmandSurveyFoquater;
    }

    /**
     * dmandSurveyFoquater을 설정
     * @param dmandSurveyFoquater 을(를) String dmandSurveyFoquater로 설정
     */
    public void setDmandSurveyFoquater(String dmandSurveyFoquater) {
        this.dmandSurveyFoquater = dmandSurveyFoquater;
    }

    /**
     * String dmandSurveyAfquater을 반환
     * @return String dmandSurveyAfquater
     */
    public String getDmandSurveyAfquater() {
        return dmandSurveyAfquater;
    }

    /**
     * dmandSurveyAfquater을 설정
     * @param dmandSurveyAfquater 을(를) String dmandSurveyAfquater로 설정
     */
    public void setDmandSurveyAfquater(String dmandSurveyAfquater) {
        this.dmandSurveyAfquater = dmandSurveyAfquater;
    }

    /**
     * String dmandSurveyChangeth을 반환
     * @return String dmandSurveyChangeth
     */
    public String getDmandSurveyChangeth() {
        return dmandSurveyChangeth;
    }

    /**
     * dmandSurveyChangeth을 설정
     * @param dmandSurveyChangeth 을(를) String dmandSurveyChangeth로 설정
     */
    public void setDmandSurveyChangeth(String dmandSurveyChangeth) {
        this.dmandSurveyChangeth = dmandSurveyChangeth;
    }

    /**
     * String dmandSurveyChangene을 반환
     * @return String dmandSurveyChangene
     */
    public String getDmandSurveyChangene() {
        return dmandSurveyChangene;
    }

    /**
     * dmandSurveyChangene을 설정
     * @param dmandSurveyChangene 을(를) String dmandSurveyChangene로 설정
     */
    public void setDmandSurveyChangene(String dmandSurveyChangene) {
        this.dmandSurveyChangene = dmandSurveyChangene;
    }

}