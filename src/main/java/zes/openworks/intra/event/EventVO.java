/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.event;

import java.util.List;

import zes.base.vo.FileVO;
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
 *  2014. 10. 16.    이슬버미       신규
 * </pre>
 * @see
 */
public class EventVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1664674897859964548L;
    /** 언어코드 */
    private String langCode;
    /** 이벤트일련 */
    private Integer eventSn;
    /** 이벤트일련 배열 */
    private String[] eventSns;
    /** 이벤트유형코드 */
    private Integer eventTyCd;
    /** 이벤트유형이름 */
    private String eventTyNm;
    /** 이벤트위치구분코드 */
    private Integer eventLcSeCd;
    /** 이벤트위치구분코드 키배열 */
    private List<EventVO> eventLcSeCdList;
    /** 이벤트위치구분코드 키 */
    private String eventLcSeCds;
    /** 이벤트위치구분이름 */
    private String eventLcSeNm;
    /** 이벤트타이틀 */
    private String eventTitle;
    /** 이벤트내용 */
    private String eventCn;
    /** 시작일자 */
    private String beginDate;
    /** 종료일자 */
    private String endDate;
    /** 시작시점 비교 */
    private String gubun;
    /** 이벤트썸네일파일일련 */
    private Integer eventThumbFileSeq = -1;
    /** 이벤트파일경로 */
    private String eventFilePath;
    /** 이미지ALT */
    private String imageAlt;
    /** 발표일자 */
    private String presnatnDate;
    /** 발표시간 */
    private String presnatnHm;
    /** 링크URL */
    private String linkUrl;
    /** 당첨자확인URL */
    private String przwnerCnfirmUrl;
    /** 강제마감여부 */
    private String enfrcClosAt;
    /** 강제마감일시 */
    private String enfrcClosDt;
    /** 이벤트삭제여부 */
    private String eventDeleteAt;
    /** 이벤트조회수 */
    private Integer eventRdcnt;
    /** 등록아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 도메인일련 */
    private Integer domainSn;
    /** 이벤트정렬번호 */
    private Integer eventSortNo;
    /** 도메인코드 */
    private Integer domainCd;
    /** 사이트코드(List) */
    private List<EventVO> domainCdList;
    /** 사이트 설명 */
    private String domainDc;
    /** 등록된 사이트 코드들 */
    private String domainCds;
    /** 이미지 삭제 여부 */
    private String flag;
    /** 진행상태 */
    private String eventStatus;
    /** 참여자수 */
    private Integer partcptnCnt;
    private String checkYn;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 체크된 첨부파일 목록 (수정 시) */
    private String[] fileIds;
    /** 첨부파일 수 */
    private Integer fileCnt = 0;
    /** 댓글 일련번호 수 */
    private Integer eventCmtSeq;
    /** 댓글 작성일 */
    private String writngDt;
    /** 댓글 작성자 ID */
    private String wrterId;
    /** 댓글 작성자 이름 */
    private String wrterNm;
    /** 댓글 내용 */
    private String eventCmtCn;
    /** 댓글 작성자 IP */
    private String wrterIp;
    /* 위치구분순번 */
    private Integer lcSeSn;
    
    
    
    
    
    
    /**
     * String linkUrl을 반환
     * @return String linkUrl
     */
    public String getLinkUrl() {
        return linkUrl;
    }


    
    /**
     * linkUrl을 설정
     * @param linkUrl 을(를) String linkUrl로 설정
     */
    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
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
     * String[] eventSns을 반환
     * @return String[] eventSns
     */
    public String[] getEventSns() {
        return eventSns;
    }
    
    /**
     * eventSns을 설정
     * @param eventSns 을(를) String[] eventSns로 설정
     */
    public void setEventSns(String[] eventSns) {
        this.eventSns = eventSns;
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
     * String eventTyNm을 반환
     * @return String eventTyNm
     */
    public String getEventTyNm() {
        return eventTyNm;
    }
    
    /**
     * eventTyNm을 설정
     * @param eventTyNm 을(를) String eventTyNm로 설정
     */
    public void setEventTyNm(String eventTyNm) {
        this.eventTyNm = eventTyNm;
    }
    
    /**
     * Integer eventLcSeCd을 반환
     * @return Integer eventLcSeCd
     */
    public Integer getEventLcSeCd() {
        return eventLcSeCd;
    }
    
    /**
     * eventLcSeCd을 설정
     * @param eventLcSeCd 을(를) Integer eventLcSeCd로 설정
     */
    public void setEventLcSeCd(Integer eventLcSeCd) {
        this.eventLcSeCd = eventLcSeCd;
    }
    
    /**
     * List<EventVO> eventLcSeCdList을 반환
     * @return List<EventVO> eventLcSeCdList
     */
    public List<EventVO> getEventLcSeCdList() {
        return eventLcSeCdList;
    }
    
    /**
     * eventLcSeCdList을 설정
     * @param eventLcSeCdList 을(를) List<EventVO> eventLcSeCdList로 설정
     */
    public void setEventLcSeCdList(List<EventVO> eventLcSeCdList) {
        this.eventLcSeCdList = eventLcSeCdList;
    }
    
    /**
     * String eventLcSeCds을 반환
     * @return String eventLcSeCds
     */
    public String getEventLcSeCds() {
        return eventLcSeCds;
    }
    
    /**
     * eventLcSeCds을 설정
     * @param eventLcSeCds 을(를) String eventLcSeCds로 설정
     */
    public void setEventLcSeCds(String eventLcSeCds) {
        this.eventLcSeCds = eventLcSeCds;
    }
    
    /**
     * String eventLcSeNm을 반환
     * @return String eventLcSeNm
     */
    public String getEventLcSeNm() {
        return eventLcSeNm;
    }
    
    /**
     * eventLcSeNm을 설정
     * @param eventLcSeNm 을(를) String eventLcSeNm로 설정
     */
    public void setEventLcSeNm(String eventLcSeNm) {
        this.eventLcSeNm = eventLcSeNm;
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
     * String gubun을 반환
     * @return String gubun
     */
    public String getGubun() {
        return gubun;
    }
    
    /**
     * gubun을 설정
     * @param gubun 을(를) String gubun로 설정
     */
    public void setGubun(String gubun) {
        this.gubun = gubun;
    }
    
    /**
     * Integer eventThumbFileSeq을 반환
     * @return Integer eventThumbFileSeq
     */
    public Integer getEventThumbFileSeq() {
        return eventThumbFileSeq;
    }
    
    /**
     * eventThumbFileSeq을 설정
     * @param eventThumbFileSeq 을(를) Integer eventThumbFileSeq로 설정
     */
    public void setEventThumbFileSeq(Integer eventThumbFileSeq) {
        this.eventThumbFileSeq = eventThumbFileSeq;
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
     * String enfrcClosAt을 반환
     * @return String enfrcClosAt
     */
    public String getEnfrcClosAt() {
        return enfrcClosAt;
    }
    
    /**
     * enfrcClosAt을 설정
     * @param enfrcClosAt 을(를) String enfrcClosAt로 설정
     */
    public void setEnfrcClosAt(String enfrcClosAt) {
        this.enfrcClosAt = enfrcClosAt;
    }
    
    /**
     * String enfrcClosDt을 반환
     * @return String enfrcClosDt
     */
    public String getEnfrcClosDt() {
        return enfrcClosDt;
    }
    
    /**
     * enfrcClosDt을 설정
     * @param enfrcClosDt 을(를) String enfrcClosDt로 설정
     */
    public void setEnfrcClosDt(String enfrcClosDt) {
        this.enfrcClosDt = enfrcClosDt;
    }
    
    /**
     * String eventDeleteAt을 반환
     * @return String eventDeleteAt
     */
    public String getEventDeleteAt() {
        return eventDeleteAt;
    }
    
    /**
     * eventDeleteAt을 설정
     * @param eventDeleteAt 을(를) String eventDeleteAt로 설정
     */
    public void setEventDeleteAt(String eventDeleteAt) {
        this.eventDeleteAt = eventDeleteAt;
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
     * Integer domainSn을 반환
     * @return Integer domainSn
     */
    public Integer getDomainSn() {
        return domainSn;
    }
    
    /**
     * domainSn을 설정
     * @param domainSn 을(를) Integer domainSn로 설정
     */
    public void setDomainSn(Integer domainSn) {
        this.domainSn = domainSn;
    }
    
    /**
     * Integer eventSortNo을 반환
     * @return Integer eventSortNo
     */
    public Integer getEventSortNo() {
        return eventSortNo;
    }
    
    /**
     * eventSortNo을 설정
     * @param eventSortNo 을(를) Integer eventSortNo로 설정
     */
    public void setEventSortNo(Integer eventSortNo) {
        this.eventSortNo = eventSortNo;
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
     * List<EventVO> domainCdList을 반환
     * @return List<EventVO> domainCdList
     */
    public List<EventVO> getDomainCdList() {
        return domainCdList;
    }
    
    /**
     * domainCdList을 설정
     * @param domainCdList 을(를) List<EventVO> domainCdList로 설정
     */
    public void setDomainCdList(List<EventVO> domainCdList) {
        this.domainCdList = domainCdList;
    }
    
    /**
     * String domainDc을 반환
     * @return String domainDc
     */
    public String getDomainDc() {
        return domainDc;
    }
    
    /**
     * domainDc을 설정
     * @param domainDc 을(를) String domainDc로 설정
     */
    public void setDomainDc(String domainDc) {
        this.domainDc = domainDc;
    }
    
    /**
     * String domainCds을 반환
     * @return String domainCds
     */
    public String getDomainCds() {
        return domainCds;
    }
    
    /**
     * domainCds을 설정
     * @param domainCds 을(를) String domainCds로 설정
     */
    public void setDomainCds(String domainCds) {
        this.domainCds = domainCds;
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
     * Integer partcptnCnt을 반환
     * @return Integer partcptnCnt
     */
    public Integer getPartcptnCnt() {
        return partcptnCnt;
    }
    
    /**
     * partcptnCnt을 설정
     * @param partcptnCnt 을(를) Integer partcptnCnt로 설정
     */
    public void setPartcptnCnt(Integer partcptnCnt) {
        this.partcptnCnt = partcptnCnt;
    }
    
    /**
     * String checkYn을 반환
     * @return String checkYn
     */
    public String getCheckYn() {
        return checkYn;
    }
    
    /**
     * checkYn을 설정
     * @param checkYn 을(를) String checkYn로 설정
     */
    public void setCheckYn(String checkYn) {
        this.checkYn = checkYn;
    }
    
    /**
     * List<FileVO> fileList을 반환
     * @return List<FileVO> fileList
     */
    public List<FileVO> getFileList() {
        return fileList;
    }
    
    /**
     * fileList을 설정
     * @param fileList 을(를) List<FileVO> fileList로 설정
     */
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }
    
    /**
     * String[] fileIds을 반환
     * @return String[] fileIds
     */
    public String[] getFileIds() {
        return fileIds;
    }
    
    /**
     * fileIds을 설정
     * @param fileIds 을(를) String[] fileIds로 설정
     */
    public void setFileIds(String[] fileIds) {
        this.fileIds = fileIds;
    }
    
    /**
     * Integer fileCnt을 반환
     * @return Integer fileCnt
     */
    public Integer getFileCnt() {
        return fileCnt;
    }
    
    /**
     * fileCnt을 설정
     * @param fileCnt 을(를) Integer fileCnt로 설정
     */
    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
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
     * Integer lcSeSn을 반환
     * @return Integer lcSeSn
     */
    public Integer getLcSeSn() {
        return lcSeSn;
    }
    
    /**
     * lcSeSn을 설정
     * @param lcSeSn 을(를) Integer lcSeSn로 설정
     */
    public void setLcSeSn(Integer lcSeSn) {
        this.lcSeSn = lcSeSn;
    }

    
    
}
