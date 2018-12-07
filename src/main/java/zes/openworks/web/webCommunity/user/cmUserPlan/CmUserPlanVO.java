/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserPlan;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 12. 1.    		 boseok       	신규
 *</pre>
 * @see
 */
public class CmUserPlanVO extends PaggingVO {
    
    /**  */
    private static final long serialVersionUID = 5110655803215195908L;
    
    /** ROW번호 */
    private int rnum = 0;
    /**  일정관리일련  */
    private Integer schdulSeq;
    
    /**  사용자아이디  */
    private String userId;
    /**  언어코드  */
    private String langCode;
    /**  커뮤니티아이디  */
    private String cmmntyId;
    /**  커뮤니티메뉴코드  */
    private String cmmntyMenuCode;

    /**  일정제목  */
    private String schdulSj;
    /**  시작일자  */
    private String beginDate;
    /**  종료일자  */
    private String endDate;
    /**  일정내용  */
    private String schdulCn;
    /**  반복유형코드  */
    private Integer reptitTyCd;
    /**  등록아이디  */
    private String registId;
    /**  등록일시  */
    private String registDt;
    /**  수정아이디  */
    private String updtId;
    /**  수정일시  */
    private String updtDt;
    
    
    /** 검색 - 시작일 */
    private String q_startDt;
    /** 검색 - 종료일 */
    private String q_endDt;
    /** 검색 - 전후week */
    private String q_week;
    
    /** 달력의 시작일 종료일 */
    private String start;
    private String end;
    
    /** 시작시간 시간구분 */
    private String beginTimeSe;
    /** 종료시간 시간구분 */
    private String endTimeSe;
    /** 시작시간 */
    private String beginHm;
    /** 종료시간 */
    private String endHm;
    /**  공개설정코드  */
    private Integer othbcSetupCd;
    
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
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }
    
    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }
    
    /**
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }
    
    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }
    
    /**
     * String cmmntyMenuCode을 반환
     * @return String cmmntyMenuCode
     */
    public String getCmmntyMenuCode() {
        return cmmntyMenuCode;
    }
    
    /**
     * cmmntyMenuCode을 설정
     * @param cmmntyMenuCode 을(를) String cmmntyMenuCode로 설정
     */
    public void setCmmntyMenuCode(String cmmntyMenuCode) {
        this.cmmntyMenuCode = cmmntyMenuCode;
    }
    
    /**
     * Integer schdulSeq을 반환
     * @return Integer schdulSeq
     */
    public Integer getSchdulSeq() {
        return schdulSeq;
    }
    
    /**
     * schdulSeq을 설정
     * @param schdulSeq 을(를) Integer schdulSeq로 설정
     */
    public void setSchdulSeq(Integer schdulSeq) {
        this.schdulSeq = schdulSeq;
    }
    
    /**
     * String schdulSj을 반환
     * @return String schdulSj
     */
    public String getSchdulSj() {
        return schdulSj;
    }
    
    /**
     * schdulSj을 설정
     * @param schdulSj 을(를) String schdulSj로 설정
     */
    public void setSchdulSj(String schdulSj) {
        this.schdulSj = schdulSj;
    }
    
    /**
     * String beginDate을 반환
     * @return String beginDate
     */
    public String getBeginDate() {
        return beginDate;
    }
    
    /**
     * beginDate을 설정
     * @param beginDate 을(를) String beginDate로 설정
     */
    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }
    
    /**
     * String endDate을 반환
     * @return String endDate
     */
    public String getEndDate() {
        return endDate;
    }
    
    /**
     * endDate을 설정
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    
    /**
     * String schdulCn을 반환
     * @return String schdulCn
     */
    public String getSchdulCn() {
        return schdulCn;
    }
    
    /**
     * schdulCn을 설정
     * @param schdulCn 을(를) String schdulCn로 설정
     */
    public void setSchdulCn(String schdulCn) {
        this.schdulCn = schdulCn;
    }
    
    /**
     * Integer reptitTyCd을 반환
     * @return Integer reptitTyCd
     */
    public Integer getReptitTyCd() {
        return reptitTyCd;
    }
    
    /**
     * reptitTyCd을 설정
     * @param reptitTyCd 을(를) Integer reptitTyCd로 설정
     */
    public void setReptitTyCd(Integer reptitTyCd) {
        this.reptitTyCd = reptitTyCd;
    }
    
    /**
     * String registId을 반환
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }
    
    /**
     * registId을 설정
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }
    
    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }
    
    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }
    
    /**
     * String updtId을 반환
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }
    
    /**
     * updtId을 설정
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }
    
    /**
     * String updtDt을 반환
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }
    
    /**
     * updtDt을 설정
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    
    /**
     * String q_startDt을 반환
     * @return String q_startDt
     */
    public String getQ_startDt() {
        return q_startDt;
    }

    
    /**
     * q_startDt을 설정
     * @param q_startDt 을(를) String q_startDt로 설정
     */
    public void setQ_startDt(String q_startDt) {
        this.q_startDt = q_startDt;
    }

    
    /**
     * String q_endDt을 반환
     * @return String q_endDt
     */
    public String getQ_endDt() {
        return q_endDt;
    }

    
    /**
     * q_endDt을 설정
     * @param q_endDt 을(를) String q_endDt로 설정
     */
    public void setQ_endDt(String q_endDt) {
        this.q_endDt = q_endDt;
    }

    
    /**
     * String q_week을 반환
     * @return String q_week
     */
    public String getQ_week() {
        return q_week;
    }

    
    /**
     * q_week을 설정
     * @param q_week 을(를) String q_week로 설정
     */
    public void setQ_week(String q_week) {
        this.q_week = q_week;
    }

    
    /**
     * String start을 반환
     * @return String start
     */
    public String getStart() {
        return start;
    }

    
    /**
     * start을 설정
     * @param start 을(를) String start로 설정
     */
    public void setStart(String start) {
        this.start = start;
    }

    
    /**
     * String end을 반환
     * @return String end
     */
    public String getEnd() {
        return end;
    }

    
    /**
     * end을 설정
     * @param end 을(를) String end로 설정
     */
    public void setEnd(String end) {
        this.end = end;
    }

    
    /**
     * int startY을 반환
     * @return int startY
     */
    public int getStartY() {
        return startY;
    }

    
    /**
     * startY을 설정
     * @param startY 을(를) int startY로 설정
     */
    public void setStartY(int startY) {
        this.startY = startY;
    }

    
    /**
     * int startM을 반환
     * @return int startM
     */
    public int getStartM() {
        return startM;
    }

    
    /**
     * startM을 설정
     * @param startM 을(를) int startM로 설정
     */
    public void setStartM(int startM) {
        this.startM = startM;
    }

    
    /**
     * int endY을 반환
     * @return int endY
     */
    public int getEndY() {
        return endY;
    }

    
    /**
     * endY을 설정
     * @param endY 을(를) int endY로 설정
     */
    public void setEndY(int endY) {
        this.endY = endY;
    }

    
    /**
     * int startYear을 반환
     * @return int startYear
     */
    public int getStartYear() {
        return startYear;
    }

    
    /**
     * startYear을 설정
     * @param startYear 을(를) int startYear로 설정
     */
    public void setStartYear(int startYear) {
        this.startYear = startYear;
    }

    
    /**
     * int startMonth을 반환
     * @return int startMonth
     */
    public int getStartMonth() {
        return startMonth;
    }

    
    /**
     * startMonth을 설정
     * @param startMonth 을(를) int startMonth로 설정
     */
    public void setStartMonth(int startMonth) {
        this.startMonth = startMonth;
    }

    
    /**
     * String sY을 반환
     * @return String sY
     */
    public String getsY() {
        return sY;
    }

    
    /**
     * sY을 설정
     * @param sY 을(를) String sY로 설정
     */
    public void setsY(String sY) {
        this.sY = sY;
    }

    
    /**
     * String sM을 반환
     * @return String sM
     */
    public String getsM() {
        return sM;
    }

    
    /**
     * sM을 설정
     * @param sM 을(를) String sM로 설정
     */
    public void setsM(String sM) {
        this.sM = sM;
    }

    
    /**
     * String sD을 반환
     * @return String sD
     */
    public String getsD() {
        return sD;
    }

    
    /**
     * sD을 설정
     * @param sD 을(를) String sD로 설정
     */
    public void setsD(String sD) {
        this.sD = sD;
    }

    
    /**
     * String eY을 반환
     * @return String eY
     */
    public String geteY() {
        return eY;
    }

    
    /**
     * eY을 설정
     * @param eY 을(를) String eY로 설정
     */
    public void seteY(String eY) {
        this.eY = eY;
    }

    
    /**
     * String eM을 반환
     * @return String eM
     */
    public String geteM() {
        return eM;
    }

    
    /**
     * eM을 설정
     * @param eM 을(를) String eM로 설정
     */
    public void seteM(String eM) {
        this.eM = eM;
    }

    
    /**
     * String eD을 반환
     * @return String eD
     */
    public String geteD() {
        return eD;
    }

    
    /**
     * eD을 설정
     * @param eD 을(를) String eD로 설정
     */
    public void seteD(String eD) {
        this.eD = eD;
    }

    
    /**
     * String beginTimeSe을 반환
     * @return String beginTimeSe
     */
    public String getBeginTimeSe() {
        return beginTimeSe;
    }

    
    /**
     * beginTimeSe을 설정
     * @param beginTimeSe 을(를) String beginTimeSe로 설정
     */
    public void setBeginTimeSe(String beginTimeSe) {
        this.beginTimeSe = beginTimeSe;
    }

    
    /**
     * String endTimeSe을 반환
     * @return String endTimeSe
     */
    public String getEndTimeSe() {
        return endTimeSe;
    }

    
    /**
     * endTimeSe을 설정
     * @param endTimeSe 을(를) String endTimeSe로 설정
     */
    public void setEndTimeSe(String endTimeSe) {
        this.endTimeSe = endTimeSe;
    }

    
    /**
     * String beginHm을 반환
     * @return String beginHm
     */
    public String getBeginHm() {
        return beginHm;
    }

    
    /**
     * beginHm을 설정
     * @param beginHm 을(를) String beginHm로 설정
     */
    public void setBeginHm(String beginHm) {
        this.beginHm = beginHm;
    }

    
    /**
     * String endHm을 반환
     * @return String endHm
     */
    public String getEndHm() {
        return endHm;
    }

    
    /**
     * endHm을 설정
     * @param endHm 을(를) String endHm로 설정
     */
    public void setEndHm(String endHm) {
        this.endHm = endHm;
    }

    
    /**
     * int rnum을 반환
     * @return int rnum
     */
    public int getRnum() {
        return rnum;
    }

    
    /**
     * rnum을 설정
     * @param rnum 을(를) int rnum로 설정
     */
    public void setRnum(int rnum) {
        this.rnum = rnum;
    }

    
    /**
     * Integer othbcSetupCd을 반환
     * @return Integer othbcSetupCd
     */
    public Integer getOthbcSetupCd() {
        return othbcSetupCd;
    }

    
    /**
     * othbcSetupCd을 설정
     * @param othbcSetupCd 을(를) Integer othbcSetupCd로 설정
     */
    public void setOthbcSetupCd(Integer othbcSetupCd) {
        this.othbcSetupCd = othbcSetupCd;
    }
    
}
