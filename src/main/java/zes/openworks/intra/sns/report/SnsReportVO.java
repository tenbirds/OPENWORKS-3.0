/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.sns.report;

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
 *  2013. 04.02      구선모   생성
 * </pre>
 * @see
 */
public class SnsReportVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 5375606999947243385L;

    /** domain */
    private String domain_cd;
    /** menu_code */
    private String menu_code;
    /** menu_nm */
    private String menu_nm;
    /** page_url */
    private String page_url;
    /** page_url */
    private String seq;
    /** contents */
    private String contents;
    /** reg_id */
    private String reg_id;
    /** reg_dt */
    private String reg_dt;
    /** modi_id */
    private String modi_id;

    /** del_yn */
    private String del_yn;
    /** report */
    private String report_yn;

    /** q_searchDomain */
    private String q_searchDomain;
    /** q_searchMenuCD */
    private String q_searchMenuCD;
    /** q_searchMenuNM */
    private String q_searchMenuNM;
    /** del_yn */
    private String q_searchDel_yn;
    /** del_yn1 */
    private String q_searchDel_yn1;
    /** report */
    private String q_searchReport_yn;

    /** 검색 - 시작일 */
    private String q_startDt;
    /** 검색 - 종료일 */
    private String q_endDt;
    /** 검색 - 전후week */
    private String q_week;

    /**
     * String domain_cd을 반환
     * 
     * @return String domain_cd
     */
    public String getDomain_cd() {
        return domain_cd;
    }

    /**
     * domain_cd을 설정
     * 
     * @param domain_cd 을(를) String domain_cd로 설정
     */
    public void setDomain_cd(String domain_cd) {
        this.domain_cd = domain_cd;
    }

    /**
     * String menu_code을 반환
     * 
     * @return String menu_code
     */
    public String getMenu_code() {
        return menu_code;
    }

    /**
     * menu_code을 설정
     * 
     * @param menu_code 을(를) String menu_code로 설정
     */
    public void setMenu_code(String menu_code) {
        this.menu_code = menu_code;
    }

    /**
     * String menu_nm을 반환
     * 
     * @return String menu_nm
     */
    public String getMenu_nm() {
        return menu_nm;
    }

    /**
     * menu_nm을 설정
     * 
     * @param menu_nm 을(를) String menu_nm로 설정
     */
    public void setMenu_nm(String menu_nm) {
        this.menu_nm = menu_nm;
    }

    /**
     * String page_url을 반환
     * 
     * @return String page_url
     */
    public String getPage_url() {
        return page_url;
    }

    /**
     * page_url을 설정
     * 
     * @param page_url 을(를) String page_url로 설정
     */
    public void setPage_url(String page_url) {
        this.page_url = page_url;
    }

    /**
     * String seq을 반환
     * 
     * @return String seq
     */
    public String getSeq() {
        return seq;
    }

    /**
     * seq을 설정
     * 
     * @param seq 을(를) String seq로 설정
     */
    public void setSeq(String seq) {
        this.seq = seq;
    }

    /**
     * String contents을 반환
     * 
     * @return String contents
     */
    public String getContents() {
        return contents;
    }

    /**
     * contents을 설정
     * 
     * @param contents 을(를) String contents로 설정
     */
    public void setContents(String contents) {
        this.contents = contents;
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
     * String del_yn을 반환
     * 
     * @return String del_yn
     */
    public String getDel_yn() {
        return del_yn;
    }

    /**
     * del_yn을 설정
     * 
     * @param del_yn 을(를) String del_yn로 설정
     */
    public void setDel_yn(String del_yn) {
        this.del_yn = del_yn;
    }

    /**
     * String report_yn을 반환
     * 
     * @return String report_yn
     */
    public String getReport_yn() {
        return report_yn;
    }

    /**
     * report_yn을 설정
     * 
     * @param report_yn 을(를) String report_yn로 설정
     */
    public void setReport_yn(String report_yn) {
        this.report_yn = report_yn;
    }

    /**
     * String q_searchDomain을 반환
     * 
     * @return String q_searchDomain
     */
    public String getQ_searchDomain() {
        return q_searchDomain;
    }

    /**
     * q_searchDomain을 설정
     * 
     * @param q_searchDomain 을(를) String q_searchDomain로 설정
     */
    public void setQ_searchDomain(String q_searchDomain) {
        this.q_searchDomain = q_searchDomain;
    }

    /**
     * String q_searchMenuCD을 반환
     * 
     * @return String q_searchMenuCD
     */
    public String getQ_searchMenuCD() {
        return q_searchMenuCD;
    }

    /**
     * q_searchMenuCD을 설정
     * 
     * @param q_searchMenuCD 을(를) String q_searchMenuCD로 설정
     */
    public void setQ_searchMenuCD(String q_searchMenuCD) {
        this.q_searchMenuCD = q_searchMenuCD;
    }

    /**
     * String q_searchMenuNM을 반환
     * 
     * @return String q_searchMenuNM
     */
    public String getQ_searchMenuNM() {
        return q_searchMenuNM;
    }

    /**
     * q_searchMenuNM을 설정
     * 
     * @param q_searchMenuNM 을(를) String q_searchMenuNM로 설정
     */
    public void setQ_searchMenuNM(String q_searchMenuNM) {
        this.q_searchMenuNM = q_searchMenuNM;
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
     * String q_searchDel_yn을 반환
     * 
     * @return String q_searchDel_yn
     */
    public String getQ_searchDel_yn() {
        return q_searchDel_yn;
    }

    /**
     * q_searchDel_yn을 설정
     * 
     * @param q_searchDel_yn 을(를) String q_searchDel_yn로 설정
     */
    public void setQ_searchDel_yn(String q_searchDel_yn) {
        this.q_searchDel_yn = q_searchDel_yn;
    }

    /**
     * String q_searchReport_yn을 반환
     * 
     * @return String q_searchReport_yn
     */
    public String getQ_searchReport_yn() {
        return q_searchReport_yn;
    }

    /**
     * q_searchReport_yn을 설정
     * 
     * @param q_searchReport_yn 을(를) String q_searchReport_yn로 설정
     */
    public void setQ_searchReport_yn(String q_searchReport_yn) {
        this.q_searchReport_yn = q_searchReport_yn;
    }

    /**
     * String q_searchDel_yn1을 반환
     * 
     * @return String q_searchDel_yn1
     */
    public String getQ_searchDel_yn1() {
        return q_searchDel_yn1;
    }

    /**
     * q_searchDel_yn1을 설정
     * 
     * @param q_searchDel_yn1 을(를) String q_searchDel_yn1로 설정
     */
    public void setQ_searchDel_yn1(String q_searchDel_yn1) {
        this.q_searchDel_yn1 = q_searchDel_yn1;
    }

}
