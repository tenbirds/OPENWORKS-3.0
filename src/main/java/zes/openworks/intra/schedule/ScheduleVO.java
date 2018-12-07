/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.schedule;

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
 *  2012. 5. 22.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ScheduleVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 2002441908273848060L;

    /** 주제 */
    private String title;
    /** 일련번호 */
    private Integer seq;
    /** 시작일 */
    private String StartDt;
    /** 종료일 */
    private String endDt;
    /** 장소 */
    private String place;
    /** 휴일등록사유 */
    private String scheduleContent;
    /** 법정공휴일유무 */
    private String holidayYn;
    /** 반복여부 */
    private String repeatYearYn;
    /** 등록자 */
    private String regId;
    /** 등록일 */
    private String regDtm;
    /** 수정자 */
    private String modId;
    /** 수정일 */
    private String modDtm;
    /** 지정 법정 구분 */
    private String gbn;
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
     * String start을 반환
     * 
     * @return String start
     */
    public String getStart() {
        return start;
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
     * start을 설정
     * 
     * @param start 을(를) String start로 설정
     */
    public void setStart(String start) {
        this.start = start;
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
     * end을 설정
     * 
     * @param end 을(를) String end로 설정
     */
    public void setEnd(String end) {
        this.end = end;
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
     * String sM을 반환
     * 
     * @return String sM
     */
    public String getsM() {
        return sM;
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
     * String eY을 반환
     * 
     * @return String eY
     */
    public String geteY() {
        return eY;
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
     * String eD을 반환
     * 
     * @return String eD
     */
    public String geteD() {
        return eD;
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
     * sM을 설정
     * 
     * @param sM 을(를) String sM로 설정
     */
    public void setsM(String sM) {
        this.sM = sM;
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
     * eY을 설정
     * 
     * @param eY 을(를) String eY로 설정
     */
    public void seteY(String eY) {
        this.eY = eY;
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
     * eD을 설정
     * 
     * @param eD 을(를) String eD로 설정
     */
    public void seteD(String eD) {
        this.eD = eD;
    }

    /**
     * String gbn을 반환
     * 
     * @return String gbn
     */
    public String getGbn() {
        return gbn;
    }

    /**
     * gbn을 설정
     * 
     * @param gbn 을(를) String gbn로 설정
     */
    public void setGbn(String gbn) {
        this.gbn = gbn;
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
     * Integer seq을 반환
     * 
     * @return Integer seq
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * String startDt을 반환
     * 
     * @return String startDt
     */
    public String getStartDt() {
        return StartDt;
    }

    /**
     * String endDt을 반환
     * 
     * @return String endDt
     */
    public String getEndDt() {
        return endDt;
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
     * String scheduleContent을 반환
     * 
     * @return String scheduleContent
     */
    public String getScheduleContent() {
        return scheduleContent;
    }

    /**
     * String holidayYn을 반환
     * 
     * @return String holidayYn
     */
    public String getHolidayYn() {
        return holidayYn;
    }

    /**
     * String repeatYearYn을 반환
     * 
     * @return String repeatYearYn
     */
    public String getRepeatYearYn() {
        return repeatYearYn;
    }

    /**
     * String regId을 반환
     * 
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * String regDtm을 반환
     * 
     * @return String regDtm
     */
    public String getRegDtm() {
        return regDtm;
    }

    /**
     * String modId을 반환
     * 
     * @return String modId
     */
    public String getModId() {
        return modId;
    }

    /**
     * String modDtm을 반환
     * 
     * @return String modDtm
     */
    public String getModDtm() {
        return modDtm;
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
     * seq을 설정
     * 
     * @param seq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * startDt을 설정
     * 
     * @param startDt 을(를) String startDt로 설정
     */
    public void setStartDt(String startDt) {
        StartDt = startDt;
    }

    /**
     * endDt을 설정
     * 
     * @param endDt 을(를) String endDt로 설정
     */
    public void setEndDt(String endDt) {
        this.endDt = endDt;
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
     * scheduleContent을 설정
     * 
     * @param scheduleContent 을(를) String scheduleContent로 설정
     */
    public void setScheduleContent(String scheduleContent) {
        this.scheduleContent = scheduleContent;
    }

    /**
     * holidayYn을 설정
     * 
     * @param holidayYn 을(를) String holidayYn로 설정
     */
    public void setHolidayYn(String holidayYn) {
        this.holidayYn = holidayYn;
    }

    /**
     * repeatYearYn을 설정
     * 
     * @param repeatYearYn 을(를) String repeatYearYn로 설정
     */
    public void setRepeatYearYn(String repeatYearYn) {
        this.repeatYearYn = repeatYearYn;
    }

    /**
     * regId을 설정
     * 
     * @param regId 을(를) String regId로 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * regDtm을 설정
     * 
     * @param regDtm 을(를) String regDtm로 설정
     */
    public void setRegDtm(String regDtm) {
        this.regDtm = regDtm;
    }

    /**
     * modId을 설정
     * 
     * @param modId 을(를) String modId로 설정
     */
    public void setModId(String modId) {
        this.modId = modId;
    }

    /**
     * modDtm을 설정
     * 
     * @param modDtm 을(를) String modDtm로 설정
     */
    public void setModDtm(String modDtm) {
        this.modDtm = modDtm;
    }

}
