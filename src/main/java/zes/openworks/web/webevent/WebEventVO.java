/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.webevent;

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
 *  2014. 10. 27.    이슬버미       신규
 * </pre>
 * @see
 */
public class WebEventVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1467577351305365913L;

    /* 기본형 */
    public static final Integer EV_TY_CD_BS = 1001;
    /* 참여형 */
    public static final Integer EV_TY_CD_PT = 1002;
    /* 참여형 회원 + 비회원 */
    public static final Integer EV_TY_CD_PM = 1003;

    /* 이벤트 일련번허 */
    private Integer eventSn;
    /* 이벤트 다음 일련번호 */
    private Integer nextSeq;
    /* 이벤트 이번 일련번호 */
    private Integer preSeq;
    /* 기본형, 참여형 */
    private String flag;
    /* 이벤트 구분 */
    private Integer eventTyCd;
    /* 이벤트 제목 */
    private String eventTitle;
    /* 이벤트 요역 */
    private String eventSumry;
    /* 이벤트 다음 제목 */
    private String nextTitle;
    /* 이벤트 이전 제목 */
    private String preTitle;
    /* 이벤트 내용 */
    private String eventCn;
    /* 이벤트 시작날짜 */
    private String beginDate;
    /* 이벤트 종료날짜 */
    private String endDate;
    /* 등록일자 */
    private String registDt;
    /* 다음 날짜 */
    private String nextDate;
    /* 이전 날짜 */
    private String preDate;
    /* 이벤트 파일URL */
    private String eventFilePath;
    /** 이미지ALT */
    private String imageAlt;
    /** 발표일자 */
    private String presnatnDate;
    /** 발표시간 */
    private String presnatnHm;
    /** 당첨자확인URL */
    private String przwnerCnfirmUrl;
    /** 댓글 일련번호 */
    private Integer eventCmtSeq;
    /** 댓글내용 */
    private String eventCmtCn;
    /** 댓글 작성자 아이디 */
    private String wrterId;
    /** 댓글 작성자 이름 */
    private String wrterNm;
    /** 댓글 작성자 닉네임 */
    private String wrterNcnm;
    /** 댓글 패스워드 */
    private String wrterPassword;
    /** 댓글 등록일 */
    private String writngDt;
    /** 댓글 원본 작성자 */
    private String orgWrterId;
    /** 댓글 작성자 IP */
    private String wrterIp;
    /** 이벤트조회수 */
    private Integer eventRdcnt;
    /** 댓글참여수 */
    private Integer commentRcnt;
    /** 진행상태 */
    private String eventStatus;
    /** 도메인코드 */
    private Integer domainCd;
    /** 카테고리분류코드 */
    private Integer ctgryClCd;
    
    /**
     * String eventSumry을 반환
     * @return String eventSumry
     */
    public String getEventSumry() {
        return eventSumry;
    }

    
    /**
     * eventSumry을 설정
     * @param eventSumry 을(를) String eventSumry로 설정
     */
    public void setEventSumry(String eventSumry) {
        this.eventSumry = eventSumry;
    }

    /**
     * Integer eventSn을 반환
     * @return Integer eventSn
     */
    public Integer getEventSn() {
        return eventSn;
    }
    
    /**
     * eventSn을 설정
     * @param eventSn 을(를) Integer eventSn로 설정
     */
    public void setEventSn(Integer eventSn) {
        this.eventSn = eventSn;
    }
    
    /**
     * Integer nextSeq을 반환
     * @return Integer nextSeq
     */
    public Integer getNextSeq() {
        return nextSeq;
    }
    
    /**
     * nextSeq을 설정
     * @param nextSeq 을(를) Integer nextSeq로 설정
     */
    public void setNextSeq(Integer nextSeq) {
        this.nextSeq = nextSeq;
    }
    
    /**
     * Integer preSeq을 반환
     * @return Integer preSeq
     */
    public Integer getPreSeq() {
        return preSeq;
    }
    
    /**
     * preSeq을 설정
     * @param preSeq 을(를) Integer preSeq로 설정
     */
    public void setPreSeq(Integer preSeq) {
        this.preSeq = preSeq;
    }
    
    /**
     * String flag을 반환
     * @return String flag
     */
    public String getFlag() {
        return flag;
    }
    
    /**
     * flag을 설정
     * @param flag 을(를) String flag로 설정
     */
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    /**
     * Integer eventTyCd을 반환
     * @return Integer eventTyCd
     */
    public Integer getEventTyCd() {
        return eventTyCd;
    }
    
    /**
     * eventTyCd을 설정
     * @param eventTyCd 을(를) Integer eventTyCd로 설정
     */
    public void setEventTyCd(Integer eventTyCd) {
        this.eventTyCd = eventTyCd;
    }
    
    /**
     * String eventTitle을 반환
     * @return String eventTitle
     */
    public String getEventTitle() {
        return eventTitle;
    }
    
    /**
     * eventTitle을 설정
     * @param eventTitle 을(를) String eventTitle로 설정
     */
    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }
    
    /**
     * String nextTitle을 반환
     * @return String nextTitle
     */
    public String getNextTitle() {
        return nextTitle;
    }
    
    /**
     * nextTitle을 설정
     * @param nextTitle 을(를) String nextTitle로 설정
     */
    public void setNextTitle(String nextTitle) {
        this.nextTitle = nextTitle;
    }
    
    /**
     * String preTitle을 반환
     * @return String preTitle
     */
    public String getPreTitle() {
        return preTitle;
    }
    
    /**
     * preTitle을 설정
     * @param preTitle 을(를) String preTitle로 설정
     */
    public void setPreTitle(String preTitle) {
        this.preTitle = preTitle;
    }
    
    /**
     * String eventCn을 반환
     * @return String eventCn
     */
    public String getEventCn() {
        return eventCn;
    }
    
    /**
     * eventCn을 설정
     * @param eventCn 을(를) String eventCn로 설정
     */
    public void setEventCn(String eventCn) {
        this.eventCn = eventCn;
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
     * String nextDate을 반환
     * @return String nextDate
     */
    public String getNextDate() {
        return nextDate;
    }
    
    /**
     * nextDate을 설정
     * @param nextDate 을(를) String nextDate로 설정
     */
    public void setNextDate(String nextDate) {
        this.nextDate = nextDate;
    }
    
    /**
     * String preDate을 반환
     * @return String preDate
     */
    public String getPreDate() {
        return preDate;
    }
    
    /**
     * preDate을 설정
     * @param preDate 을(를) String preDate로 설정
     */
    public void setPreDate(String preDate) {
        this.preDate = preDate;
    }
    
    /**
     * String eventFilePath을 반환
     * @return String eventFilePath
     */
    public String getEventFilePath() {
        return eventFilePath;
    }
    
    /**
     * eventFilePath을 설정
     * @param eventFilePath 을(를) String eventFilePath로 설정
     */
    public void setEventFilePath(String eventFilePath) {
        this.eventFilePath = eventFilePath;
    }
    
    /**
     * String imageAlt을 반환
     * @return String imageAlt
     */
    public String getImageAlt() {
        return imageAlt;
    }
    
    /**
     * imageAlt을 설정
     * @param imageAlt 을(를) String imageAlt로 설정
     */
    public void setImageAlt(String imageAlt) {
        this.imageAlt = imageAlt;
    }
    
    /**
     * String presnatnDate을 반환
     * @return String presnatnDate
     */
    public String getPresnatnDate() {
        return presnatnDate;
    }
    
    /**
     * presnatnDate을 설정
     * @param presnatnDate 을(를) String presnatnDate로 설정
     */
    public void setPresnatnDate(String presnatnDate) {
        this.presnatnDate = presnatnDate;
    }
    
    /**
     * String przwnerCnfirmUrl을 반환
     * @return String przwnerCnfirmUrl
     */
    public String getPrzwnerCnfirmUrl() {
        return przwnerCnfirmUrl;
    }
    
    /**
     * przwnerCnfirmUrl을 설정
     * @param przwnerCnfirmUrl 을(를) String przwnerCnfirmUrl로 설정
     */
    public void setPrzwnerCnfirmUrl(String przwnerCnfirmUrl) {
        this.przwnerCnfirmUrl = przwnerCnfirmUrl;
    }
    
    /**
     * Integer eventCmtSeq을 반환
     * @return Integer eventCmtSeq
     */
    public Integer getEventCmtSeq() {
        return eventCmtSeq;
    }
    
    /**
     * eventCmtSeq을 설정
     * @param eventCmtSeq 을(를) Integer eventCmtSeq로 설정
     */
    public void setEventCmtSeq(Integer eventCmtSeq) {
        this.eventCmtSeq = eventCmtSeq;
    }
    
    /**
     * String eventCmtCn을 반환
     * @return String eventCmtCn
     */
    public String getEventCmtCn() {
        return eventCmtCn;
    }
    
    /**
     * eventCmtCn을 설정
     * @param eventCmtCn 을(를) String eventCmtCn로 설정
     */
    public void setEventCmtCn(String eventCmtCn) {
        this.eventCmtCn = eventCmtCn;
    }
    
    /**
     * String wrterId을 반환
     * @return String wrterId
     */
    public String getWrterId() {
        return wrterId;
    }
    
    /**
     * wrterId을 설정
     * @param wrterId 을(를) String wrterId로 설정
     */
    public void setWrterId(String wrterId) {
        this.wrterId = wrterId;
    }
    
    /**
     * String wrterNm을 반환
     * @return String wrterNm
     */
    public String getWrterNm() {
        return wrterNm;
    }
    
    /**
     * wrterNm을 설정
     * @param wrterNm 을(를) String wrterNm로 설정
     */
    public void setWrterNm(String wrterNm) {
        this.wrterNm = wrterNm;
    }

    /**
     * String wrterNcnm을 반환
     * @return String wrterNcnm
     */
    public String getWrterNcnm() {
        return wrterNcnm;
    }
    
    /**
     * wrterNcnm을 설정
     * @param wrterNm 을(를) String wrterNcnm로 설정
     */
    public void setWrterNcnm(String wrterNcnm) {
        this.wrterNcnm = wrterNcnm;
    }

    /**
     * String wrterPassword을 반환
     * @return String wrterPassword
     */
    public String getWrterPassword() {
        return wrterPassword;
    }
    
    /**
     * wrterPassword을 설정
     * @param wrterPassword 을(를) String wrterPassword로 설정
     */
    public void setWrterPassword(String wrterPassword) {
        this.wrterPassword = wrterPassword;
    }

    
    /**
     * String writngDt을 반환
     * @return String writngDt
     */
    public String getWritngDt() {
        return writngDt;
    }
    
    /**
     * writngDt을 설정
     * @param writngDt 을(를) String writngDt로 설정
     */
    public void setWritngDt(String writngDt) {
        this.writngDt = writngDt;
    }
    
    /**
     * String orgWrterId을 반환
     * @return String orgWrterId
     */
    public String getOrgWrterId() {
        return orgWrterId;
    }
    
    /**
     * orgWrterId을 설정
     * @param orgWrterId 을(를) String orgWrterId로 설정
     */
    public void setOrgWrterId(String orgWrterId) {
        this.orgWrterId = orgWrterId;
    }
    
    /**
     * String wrterIp을 반환
     * @return String wrterIp
     */
    public String getWrterIp() {
        return wrterIp;
    }
    
    /**
     * wrterIp을 설정
     * @param wrterIp 을(를) String wrterIp로 설정
     */
    public void setWrterIp(String wrterIp) {
        this.wrterIp = wrterIp;
    }
    
    /**
     * Integer eventRdcnt을 반환
     * @return Integer eventRdcnt
     */
    public Integer getEventRdcnt() {
        return eventRdcnt;
    }
    
    /**
     * eventRdcnt을 설정
     * @param eventRdcnt 을(를) Integer eventRdcnt로 설정
     */
    public void setEventRdcnt(Integer eventRdcnt) {
        this.eventRdcnt = eventRdcnt;
    }
    
    /**
     * Integer commentRcnt을 반환
     * @return Integer commentRcnt
     */
    public Integer getCommentRcnt() {
        return commentRcnt;
    }
    
    /**
     * commentRcnt을 설정
     * @param commentRcnt 을(를) Integer commentRcnt로 설정
     */
    public void setCommentRcnt(Integer commentRcnt) {
        this.commentRcnt = commentRcnt;
    }
    
    /**
     * String eventStatus을 반환
     * @return String eventStatus
     */
    public String getEventStatus() {
        return eventStatus;
    }
    
    /**
     * eventStatus을 설정
     * @param eventStatus 을(를) String eventStatus로 설정
     */
    public void setEventStatus(String eventStatus) {
        this.eventStatus = eventStatus;
    }

    
    /**
     * String presnatnHm을 반환
     * @return String presnatnHm
     */
    public String getPresnatnHm() {
        return presnatnHm;
    }

    
    /**
     * presnatnHm을 설정
     * @param presnatnHm 을(를) String presnatnHm로 설정
     */
    public void setPresnatnHm(String presnatnHm) {
        this.presnatnHm = presnatnHm;
    }


    /**
     * Integer ctgryClCd을 반환
     * @return Integer ctgryClCd
     */
    public Integer getCtgryClCd() {
        return ctgryClCd;
    }


    /**
     * ctgryClCd을 설정
     * @param ctgryClCd 을(를) Integer ctgryClCd로 설정
     */
    public void setCtgryClCd(Integer ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }


    /**
     * Integer domainCd을 반환
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }


    /**
     * domainCd을 설정
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
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

    

}
