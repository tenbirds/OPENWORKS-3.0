/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.plan;

import java.util.List;

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
 *  2013. 3. 13     구선모   생성
 * </pre>
 * @see
 */
public class PlanVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -5375606999947243385L;

    /** ROW번호 */
    private int num;
    /** 일련번호 */
    private String plan_seq;
    /** 제목 */
    private String title;
    /** 장소 */
    private String place;
    /** 내용 */
    private String content;
    /** 시작일자 */
    private String start_dt;
    /** 종료일자 */
    private String end_dt;
    /** 시작시간 시간구분 */
    private String s_time_gb;
    /** 종료시간 시간구분 */
    private String e_time_gb;
    /** 시작시간 */
    private String start_time;
    /** 종료시간 */
    private String end_time;
    /** 등록자ID */
    private String reg_id;
    /** 등록일시 */
    private String reg_dt;
    /** 수정자ID */
    private String modi_id;
    /** 수정일시 */
    private String modi_dt;

    /** 검색 - 시작일 */
    private String q_startDt;
    /** 검색 - 종료일 */
    private String q_endDt;
    /** 검색 - 전후week */
    private String q_week;

    /** 달력의 시작일 종료일 */
    private String start;
    private String end;

    /** 달력의 시작년도와 데이터의 시작 년도 차이 */
    private int startY;
    private int startM;
    private int endY;
    private int startYear;
    private int startMonth;

    /** 시작년도 */
    private String sY;
    /** 시작월(M-1) */
    private String sM;
    /** 시작일 */
    private String sD;
    /** 종료년도 */
    private String eY;
    /** 종료월 (M-1) */
    private String eM;
    /** 종료일 */
    private String eD;

    /** 일일일정, 주간일정 */
    private List<PlanVO> dw_Plan;

    /**
     * String q_week을 반환
     * 
     * @return String q_week
     */
    public String getQ_week() {
        return q_week;
    }

    /**
     * q_week을 설정
     * 
     * @param q_week 을(를) String q_week로 설정
     */
    public void setQ_week(String q_week) {
        this.q_week = q_week;
    }

    /**
     * List<List> dw_Plan을 반환
     * 
     * @return List<List> dw_Plan
     */

    public List<PlanVO> getDw_Plan() {
        return dw_Plan;
    }

    /**
     * dw_Plan을 설정
     * 
     * @param dw_Plan 을(를) List<List> dw_Plan로 설정
     */
    public void setDw_Plan(List<PlanVO> dw_Plan) {
        this.dw_Plan = dw_Plan;
    }

    /**
     * String start을 반환
     * 
     * @return String start
     */
    public String getStart() {
        return start;
    }

    /**
     * start을 설정
     * 
     * @param start 을(를) String start로 설정
     */
    public void setStart(String start) {
        this.start = start;
    }

    /**
     * String end을 반환
     * 
     * @return String end
     */
    public String getEnd() {
        return end;
    }

    /**
     * end을 설정
     * 
     * @param end 을(를) String end로 설정
     */
    public void setEnd(String end) {
        this.end = end;
    }

    /**
     * int startY을 반환
     * 
     * @return int startY
     */
    public int getStartY() {
        return startY;
    }

    /**
     * startY을 설정
     * 
     * @param startY 을(를) int startY로 설정
     */
    public void setStartY(int startY) {
        this.startY = startY;
    }

    /**
     * int startM을 반환
     * 
     * @return int startM
     */
    public int getStartM() {
        return startM;
    }

    /**
     * startM을 설정
     * 
     * @param startM 을(를) int startM로 설정
     */
    public void setStartM(int startM) {
        this.startM = startM;
    }

    /**
     * int endY을 반환
     * 
     * @return int endY
     */
    public int getEndY() {
        return endY;
    }

    /**
     * endY을 설정
     * 
     * @param endY 을(를) int endY로 설정
     */
    public void setEndY(int endY) {
        this.endY = endY;
    }

    /**
     * int startYear을 반환
     * 
     * @return int startYear
     */
    public int getStartYear() {
        return startYear;
    }

    /**
     * startYear을 설정
     * 
     * @param startYear 을(를) int startYear로 설정
     */
    public void setStartYear(int startYear) {
        this.startYear = startYear;
    }

    /**
     * int startMonth을 반환
     * 
     * @return int startMonth
     */
    public int getStartMonth() {
        return startMonth;
    }

    /**
     * startMonth을 설정
     * 
     * @param startMonth 을(를) int startMonth로 설정
     */
    public void setStartMonth(int startMonth) {
        this.startMonth = startMonth;
    }

    /**
     * String sY을 반환
     * 
     * @return String sY
     */
    public String getsY() {
        return sY;
    }

    /**
     * sY을 설정
     * 
     * @param sY 을(를) String sY로 설정
     */
    public void setsY(String sY) {
        this.sY = sY;
    }

    /**
     * String sM을 반환
     * 
     * @return String sM
     */
    public String getsM() {
        return sM;
    }

    /**
     * sM을 설정
     * 
     * @param sM 을(를) String sM로 설정
     */
    public void setsM(String sM) {
        this.sM = sM;
    }

    /**
     * String sD을 반환
     * 
     * @return String sD
     */
    public String getsD() {
        return sD;
    }

    /**
     * sD을 설정
     * 
     * @param sD 을(를) String sD로 설정
     */
    public void setsD(String sD) {
        this.sD = sD;
    }

    /**
     * String eY을 반환
     * 
     * @return String eY
     */
    public String geteY() {
        return eY;
    }

    /**
     * eY을 설정
     * 
     * @param eY 을(를) String eY로 설정
     */
    public void seteY(String eY) {
        this.eY = eY;
    }

    /**
     * String eM을 반환
     * 
     * @return String eM
     */
    public String geteM() {
        return eM;
    }

    /**
     * eM을 설정
     * 
     * @param eM 을(를) String eM로 설정
     */
    public void seteM(String eM) {
        this.eM = eM;
    }

    /**
     * String eD을 반환
     * 
     * @return String eD
     */
    public String geteD() {
        return eD;
    }

    /**
     * eD을 설정
     * 
     * @param eD 을(를) String eD로 설정
     */
    public void seteD(String eD) {
        this.eD = eD;
    }

    /**
     * int num을 반환
     * 
     * @return int num
     */
    public int getNum() {
        return num;
    }

    /**
     * num을 설정
     * 
     * @param num 을(를) int num로 설정
     */
    public void setNum(int num) {
        this.num = num;
    }

    /**
     * String plan_seq을 반환
     * 
     * @return String plan_seq
     */
    public String getPlan_seq() {
        return plan_seq;
    }

    /**
     * plan_seq을 설정
     * 
     * @param plan_seq 을(를) String plan_seq로 설정
     */
    public void setPlan_seq(String plan_seq) {
        this.plan_seq = plan_seq;
    }

    /**
     * String title을 반환
     * 
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    /**
     * title을 설정
     * 
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * String place을 반환
     * 
     * @return String place
     */
    public String getPlace() {
        return place;
    }

    /**
     * place을 설정
     * 
     * @param place 을(를) String place로 설정
     */
    public void setPlace(String place) {
        this.place = place;
    }

    /**
     * String content을 반환
     * 
     * @return String content
     */
    public String getContent() {
        return content;
    }

    /**
     * content을 설정
     * 
     * @param content 을(를) String content로 설정
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * String start_dt을 반환
     * 
     * @return String start_dt
     */
    public String getStart_dt() {
        return start_dt;
    }

    /**
     * start_dt을 설정
     * 
     * @param start_dt 을(를) String start_dt로 설정
     */
    public void setStart_dt(String start_dt) {
        this.start_dt = start_dt;
    }

    /**
     * String end_dt을 반환
     * 
     * @return String end_dt
     */
    public String getEnd_dt() {
        return end_dt;
    }

    /**
     * end_dt을 설정
     * 
     * @param end_dt 을(를) String end_dt로 설정
     */
    public void setEnd_dt(String end_dt) {
        this.end_dt = end_dt;
    }

    /**
     * String s_time_gb을 반환
     * 
     * @return String s_time_gb
     */
    public String getS_time_gb() {
        return s_time_gb;
    }

    /**
     * s_time_gb을 설정
     * 
     * @param s_time_gb 을(를) String s_time_gb로 설정
     */
    public void setS_time_gb(String s_time_gb) {
        this.s_time_gb = s_time_gb;
    }

    /**
     * String e_time_gb을 반환
     * 
     * @return String e_time_gb
     */
    public String getE_time_gb() {
        return e_time_gb;
    }

    /**
     * e_time_gb을 설정
     * 
     * @param e_time_gb 을(를) String e_time_gb로 설정
     */
    public void setE_time_gb(String e_time_gb) {
        this.e_time_gb = e_time_gb;
    }

    /**
     * String start_time을 반환
     * 
     * @return String start_time
     */
    public String getStart_time() {
        return start_time;
    }

    /**
     * start_time을 설정
     * 
     * @param start_time 을(를) String start_time로 설정
     */
    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    /**
     * String end_time을 반환
     * 
     * @return String end_time
     */
    public String getEnd_time() {
        return end_time;
    }

    /**
     * end_time을 설정
     * 
     * @param end_time 을(를) String end_time로 설정
     */
    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    /**
     * String reg_id을 반환
     * 
     * @return String reg_id
     */
    public String getReg_id() {
        return reg_id;
    }

    /**
     * reg_id을 설정
     * 
     * @param reg_id 을(를) String reg_id로 설정
     */
    public void setReg_id(String reg_id) {
        this.reg_id = reg_id;
    }

    /**
     * String reg_dt을 반환
     * 
     * @return String reg_dt
     */
    public String getReg_dt() {
        return reg_dt;
    }

    /**
     * reg_dt을 설정
     * 
     * @param reg_dt 을(를) String reg_dt로 설정
     */
    public void setReg_dt(String reg_dt) {
        this.reg_dt = reg_dt;
    }

    /**
     * String modi_id을 반환
     * 
     * @return String modi_id
     */
    public String getModi_id() {
        return modi_id;
    }

    /**
     * modi_id을 설정
     * 
     * @param modi_id 을(를) String modi_id로 설정
     */
    public void setModi_id(String modi_id) {
        this.modi_id = modi_id;
    }

    /**
     * String modi_dt을 반환
     * 
     * @return String modi_dt
     */
    public String getModi_dt() {
        return modi_dt;
    }

    /**
     * modi_dt을 설정
     * 
     * @param modi_dt 을(를) String modi_dt로 설정
     */
    public void setModi_dt(String modi_dt) {
        this.modi_dt = modi_dt;
    }

    /**
     * String q_startDt을 반환
     * 
     * @return String q_startDt
     */
    public String getQ_startDt() {
        return q_startDt;
    }

    /**
     * q_startDt을 설정
     * 
     * @param q_startDt 을(를) String q_startDt로 설정
     */
    public void setQ_startDt(String q_startDt) {
        this.q_startDt = q_startDt;
    }

    /**
     * String q_endDt을 반환
     * 
     * @return String q_endDt
     */
    public String getQ_endDt() {
        return q_endDt;
    }

    /**
     * q_endDt을 설정
     * 
     * @param q_endDt 을(를) String q_endDt로 설정
     */
    public void setQ_endDt(String q_endDt) {
        this.q_endDt = q_endDt;
    }

}
