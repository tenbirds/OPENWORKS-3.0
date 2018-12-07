/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidInfo;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일                       수정자             수정내용
 *--------------  --------  -------------------------------
 * 2015. 12. 08.    KS       신규
 *</pre>
 * @see
 */
public class BidInfoVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 8066298618131160918L;
    /* 입찰/계약 구분 */
    private String flag;
    
    /* 명칭검색 */
    private String searchNmVal;
    /* 날짜검색구분(공고일자/입찰시작일자) */
    private String dateType;
    /* 조회날짜(시작) */
    private String sDate;
    /* 조회날짜(끝) */
    private String eDate;
    /* 기관검색구분(공고기관/수료기관) */
    private String searchKey;
    /* 공고명/ 공고번호*/
    private String searchType;
    /* 기관명검색 */
    private String searchVal;
    
    /* 입찰공고번호 */
    private String bidNotifyNo;
    /* 통합공고번호 */
    private String bidUnionNo;
    /* 입찰공고차수 */
    private String bidNotifySeqNo;
    /* 입찰건명 */
    private String bidNm;
    /* 공고일자 */
    private String pblancStartDate;
    /* 발주기관명 */
    private String orderOrgnNm;
    /* 수요기관명 */
    private String realOrgnNm;
    /* 계약방법 */
    private String cntrctMth;
    /* 입찰방식 */
    private String bidMthd;
    /* 낙찰방법 */
    private String scsbidMth;
    /* 업무구분 */
    private String bidType;
    /* 입찰시작일자 */
    private String bidStrtDate;
    /* 입찰접수마감일시 */
    private String bidEndDate;
    /* 추정가격 */
    private String prsmpAmt;
    /* 송신자ID */
    private String senderId;
    /* 문서코드 */
    private String messType;
    /* 문서명 */
    private String messNm;
    /* 문서관리번호 */
    private String docuMangNo;
    
    
    
    
    /**
     * String searchType을 반환
     * @return String searchType
     */
    public String getSearchType() {
        return searchType;
    }



    
    /**
     * searchType을 설정
     * @param searchType 을(를) String searchType로 설정
     */
    public void setSearchType(String searchType) {
        this.searchType = searchType;
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
     * String searchNmVal을 반환
     * @return String searchNmVal
     */
    public String getSearchNmVal() {
        return searchNmVal;
    }
    
    
    
    /**
     * searchNmVal을 설정
     * @param searchNmVal 을(를) String searchNmVal로 설정
     */
    public void setSearchNmVal(String searchNmVal) {
        this.searchNmVal = searchNmVal;
    }
    
    
    
    /**
     * String dateType을 반환
     * @return String dateType
     */
    public String getDateType() {
        return dateType;
    }


    
    /**
     * dateType을 설정
     * @param dateType 을(를) String dateType로 설정
     */
    public void setDateType(String dateType) {
        this.dateType = dateType;
    }


    
    /**
     * String searchKey을 반환
     * @return String searchKey
     */
    public String getSearchKey() {
        return searchKey;
    }


    
    /**
     * searchKey을 설정
     * @param searchKey 을(를) String searchKey로 설정
     */
    public void setSearchKey(String searchKey) {
        this.searchKey = searchKey;
    }


    
    /**
     * String searchVal을 반환
     * @return String searchVal
     */
    public String getSearchVal() {
        return searchVal;
    }


    
    /**
     * searchVal을 설정
     * @param searchVal 을(를) String searchVal로 설정
     */
    public void setSearchVal(String searchVal) {
        this.searchVal = searchVal;
    }
    
    /**
     * String sDate을 반환
     * @return String sDate
     */
    public String getsDate() {
        return sDate;
    }

    
    /**
     * sDate을 설정
     * @param sDate 을(를) String sDate로 설정
     */
    public void setsDate(String sDate) {
        this.sDate = sDate;
    }

    
    /**
     * String eDate을 반환
     * @return String eDate
     */
    public String geteDate() {
        return eDate;
    }

    
    /**
     * eDate을 설정
     * @param eDate 을(를) String eDate로 설정
     */
    public void seteDate(String eDate) {
        this.eDate = eDate;
    }
    
    /**
     * String bidNotifyNo을 반환
     * @return String bidNotifyNo
     */
    public String getBidNotifyNo() {
        return bidNotifyNo;
    }
    
    /**
     * bidNotifyNo을 설정
     * @param bidNotifyNo 을(를) String bidNotifyNo로 설정
     */
    public void setBidNotifyNo(String bidNotifyNo) {
        this.bidNotifyNo = bidNotifyNo;
    }
    
    /**
     * String bidUnionNo을 반환
     * @return String bidUnionNo
     */
    public String getBidUnionNo() {
        return bidUnionNo;
    }
    
    /**
     * bidUnionNo을 설정
     * @param bidUnionNo 을(를) String bidUnionNo로 설정
     */
    public void setBidUnionNo(String bidUnionNo) {
        this.bidUnionNo = bidUnionNo;
    }
    
    /**
     * String bidNotifySeqNo을 반환
     * @return String bidNotifySeqNo
     */
    public String getBidNotifySeqNo() {
        return bidNotifySeqNo;
    }
    
    /**
     * bidNotifySeqNo을 설정
     * @param bidNotifySeqNo 을(를) String bidNotifySeqNo로 설정
     */
    public void setBidNotifySeqNo(String bidNotifySeqNo) {
        this.bidNotifySeqNo = bidNotifySeqNo;
    }
    
    /**
     * String bidNm을 반환
     * @return String bidNm
     */
    public String getBidNm() {
        return bidNm;
    }
    
    /**
     * bidNm을 설정
     * @param bidNm 을(를) String bidNm로 설정
     */
    public void setBidNm(String bidNm) {
        this.bidNm = bidNm;
    }
    
    /**
     * String pblancStartDate을 반환
     * @return String pblancStartDate
     */
    public String getPblancStartDate() {
        return pblancStartDate;
    }
    
    /**
     * pblancStartDate을 설정
     * @param pblancStartDate 을(를) String pblancStartDate로 설정
     */
    public void setPblancStartDate(String pblancStartDate) {
        this.pblancStartDate = pblancStartDate;
    }
    
    /**
     * String orderOrgnNm을 반환
     * @return String orderOrgnNm
     */
    public String getOrderOrgnNm() {
        return orderOrgnNm;
    }
    
    /**
     * orderOrgnNm을 설정
     * @param orderOrgnNm 을(를) String orderOrgnNm로 설정
     */
    public void setOrderOrgnNm(String orderOrgnNm) {
        this.orderOrgnNm = orderOrgnNm;
    }
    
    /**
     * String realOrgnNm을 반환
     * @return String realOrgnNm
     */
    public String getRealOrgnNm() {
        return realOrgnNm;
    }
    
    /**
     * realOrgnNm을 설정
     * @param realOrgnNm 을(를) String realOrgnNm로 설정
     */
    public void setRealOrgnNm(String realOrgnNm) {
        this.realOrgnNm = realOrgnNm;
    }
    
    /**
     * String cntrctMth을 반환
     * @return String cntrctMth
     */
    public String getCntrctMth() {
        return cntrctMth;
    }
    
    /**
     * cntrctMth을 설정
     * @param cntrctMth 을(를) String cntrctMth로 설정
     */
    public void setCntrctMth(String cntrctMth) {
        this.cntrctMth = cntrctMth;
    }
    
    /**
     * String bidMthd을 반환
     * @return String bidMthd
     */
    public String getBidMthd() {
        return bidMthd;
    }
    
    /**
     * bidMthd을 설정
     * @param bidMthd 을(를) String bidMthd로 설정
     */
    public void setBidMthd(String bidMthd) {
        this.bidMthd = bidMthd;
    }
    
    /**
     * String scsbidMth을 반환
     * @return String scsbidMth
     */
    public String getScsbidMth() {
        return scsbidMth;
    }
    
    /**
     * scsbidMth을 설정
     * @param scsbidMth 을(를) String scsbidMth로 설정
     */
    public void setScsbidMth(String scsbidMth) {
        this.scsbidMth = scsbidMth;
    }
    
    /**
     * String bidType을 반환
     * @return String bidType
     */
    public String getBidType() {
        return bidType;
    }
    
    /**
     * bidType을 설정
     * @param bidType 을(를) String bidType로 설정
     */
    public void setBidType(String bidType) {
        this.bidType = bidType;
    }
    
    /**
     * String bidStrtDate을 반환
     * @return String bidStrtDate
     */
    public String getBidStrtDate() {
        return bidStrtDate;
    }
    
    /**
     * bidStrtDate을 설정
     * @param bidStrtDate 을(를) String bidStrtDate로 설정
     */
    public void setBidStrtDate(String bidStrtDate) {
        this.bidStrtDate = bidStrtDate;
    }
    
    /**
     * String bidEndDate을 반환
     * @return String bidEndDate
     */
    public String getBidEndDate() {
        return bidEndDate;
    }
    
    /**
     * bidEndDate을 설정
     * @param bidEndDate 을(를) String bidEndDate로 설정
     */
    public void setBidEndDate(String bidEndDate) {
        this.bidEndDate = bidEndDate;
    }
    
    /**
     * String prsmpAmt을 반환
     * @return String prsmpAmt
     */
    public String getPrsmpAmt() {
        return prsmpAmt;
    }
    
    /**
     * prsmpAmt을 설정
     * @param prsmpAmt 을(를) String prsmpAmt로 설정
     */
    public void setPrsmpAmt(String prsmpAmt) {
        this.prsmpAmt = prsmpAmt;
    }
    
    /**
     * String senderId을 반환
     * @return String senderId
     */
    public String getSenderId() {
        return senderId;
    }
    
    /**
     * senderId을 설정
     * @param senderId 을(를) String senderId로 설정
     */
    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }
    
    /**
     * String messType을 반환
     * @return String messType
     */
    public String getMessType() {
        return messType;
    }
    
    /**
     * messType을 설정
     * @param messType 을(를) String messType로 설정
     */
    public void setMessType(String messType) {
        this.messType = messType;
    }
    
    /**
     * String messNm을 반환
     * @return String messNm
     */
    public String getMessNm() {
        return messNm;
    }
    
    /**
     * messNm을 설정
     * @param messNm 을(를) String messNm로 설정
     */
    public void setMessNm(String messNm) {
        this.messNm = messNm;
    }
    
    /**
     * String docuMangNo을 반환
     * @return String docuMangNo
     */
    public String getDocuMangNo() {
        return docuMangNo;
    }
    
    /**
     * docuMangNo을 설정
     * @param docuMangNo 을(를) String docuMangNo로 설정
     */
    public void setDocuMangNo(String docuMangNo) {
        this.docuMangNo = docuMangNo;
    }
    
}
