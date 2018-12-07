/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueledger;

import java.util.List;

import zes.base.vo.PaggingVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 12.    방기배       신규
 *</pre>
 * @see
 */
public class ProofIssueledgerVO extends PaggingVO {

    private static final long serialVersionUID = 2063258049023915798L;    
    
    private String userId;           /* 유저 아이디 */    
    private String svcNm;            /* 서비스 명 */    
    private String cntrctBeginDe;    /* 계약 시작일 */    
    private String cntrctEnd;        /* 계약 종료일 */    
    private String cntrDt;           /* 계약 일 */    
    private String notifyNum;        /* 공고 번호*/    
    private int notifySeq;           /* 공고 차수*/    
    private String cntrctMount;      /* 계약 금액 */    
    private String codeNm;           /* 실적 증명 신청 상태 그룹 코드 2045 / 발급 1003 / 신청 1001 */    
    private String bidGbnCd;         /* 구매 방식*/    
    private String cntrctBeginDeMin; /* 계약 시작일 최소값*/    
    private String cntrctEndMax;     /* 계약 종료일 최대값 */    
    private String userNm;           /* 회원명 */    
    private String realDmndOrgn;     /* 구매기관*/    
    private int cntrctSn;            /* 순번 */    
    private String cntrctSnArray;    /* 순번 배열 저장용*/    
    private String commUserId;       /* */    
    private String registDt;         /* 신청일자 (등록일)*/    
    private String certResultDt;     /* 발급일자*/    
    private String recogDt;          /* 승인일*/    
    private int certResultCode;      /* 코드번호 */   
    private String organNm;    
    private String issuResn;    
    private String issuMthNm;    
    private String sndngDe;          /* 발급일 */    
    private Integer rouIssuNo;    
    private Integer serviceCnt;    
    private String issuSttusNm;    
    private String pdfProfIssuFile;    
    private String prufPdBeginDe;    
    private Integer rouSn;          /* 이용실적발급일련번호*/    
    private String strRouSn;          /* 이용실적발급일련번호*/
    private String storeNm;          /* 이용실적발급일련번호*/    

    
    
    /**
     * String storeNm을 반환
     * @return String storeNm
     */
    public String getStoreNm() {
        return storeNm;
    }



    
    /**
     * storeNm을 설정
     * @param storeNm 을(를) String storeNm로 설정
     */
    public void setStoreNm(String storeNm) {
        this.storeNm = storeNm;
    }



    /**
     * String strRouSn을 반환
     * @return String strRouSn
     */
    public String getStrRouSn() {
        return strRouSn;
    }


    
    /**
     * strRouSn을 설정
     * @param strRouSn 을(를) String strRouSn로 설정
     */
    public void setStrRouSn(String strRouSn) {
        this.strRouSn = strRouSn;
    }


    private String issuSttus;    
    private String dateDiffe;    
    private String goodsNm;    
    private String goodsKndCd;    
    private Integer cntrctAmount;
    private int pdfProfIssuFileSeq = -1;
    private String fileId;

    private String localOrginlNm;
    
    
    
    
    /**
     * String goodsNm을 반환
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }

    
    /**
     * goodsNm을 설정
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }


    List<ProofIssueledgerVO> dataList;
    
//    private String[] item;
    
    
    /**
     * String recogDt을 반환
     * @return String recogDt
     */
    public String getRecogDt() {
        return recogDt;
    }

    /**
     * recogDt을 설정
     * @param recogDt 을(를) String recogDt로 설정
     */
    public void setRecogDt(String recogDt) {
        this.recogDt = recogDt;
    }


    /**
     * String certResultDt을 반환
     * @return String certResultDt
     */
    public String getCertResultDt() {
        return certResultDt;
    }

    
    /**
     * certResultDt을 설정
     * @param certResultDt 을(를) String certResultDt로 설정
     */
    public void setCertResultDt(String certResultDt) {
        this.certResultDt = certResultDt;
    }


    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }
    
    
    /**
     * String issuResn을 반환
     * @return String issuResn
     */
    public String getIssuResn() {
        return issuResn;
    }

    
    /**
     * issuResn을 설정
     * @param issuResn 을(를) String issuResn로 설정
     */
    public void setIssuResn(String issuResn) {
        this.issuResn = issuResn;
    }

    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    
    /**
     * int certResultCode을 반환
     * @return int certResultCode
     */
    public int getCertResultCode() {
        return certResultCode;
    }


    
    /**
     * certResultCode을 설정
     * @param certResultCode 을(를) int certResultCode로 설정
     */
    public void setCertResultCode(int certResultCode) {
        this.certResultCode = certResultCode;
    }


    /**
     * String commUserId을 반환
     * @return String commUserId
     */
    public String getCommUserId() {
        return commUserId;
    }

    
    /**
     * commUserId을 설정
     * @param commUserId 을(를) String commUserId로 설정
     */
    public void setCommUserId(String commUserId) {
        this.commUserId = commUserId;
    }


    /**
     * String cntrctSnArray을 반환
     * @return String cntrctSnArray
     */
    public String getCntrctSnArray() {
        return cntrctSnArray;
    }

    
    /**
     * cntrctSnArray을 설정
     * @param cntrctSnArray 을(를) String cntrctSnArray로 설정
     */
    public void setCntrctSnArray(String cntrctSnArray) {
        this.cntrctSnArray = cntrctSnArray;
    }

    
    /**
     * int cntrctSn을 반환
     * @return int cntrctSn
     */
    public int getCntrctSn() {
        return cntrctSn;
    }

    
    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) int cntrctSn로 설정
     */
    public void setCntrctSn(int cntrctSn) {
        this.cntrctSn = cntrctSn;
    }


    /**
     * String realDmndOrgn을 반환
     * @return String realDmndOrgn
     */
    public String getRealDmndOrgn() {
        return realDmndOrgn;
    }


    /**
     * realDmndOrgn을 설정
     * @param realDmndOrgn 을(를) String realDmndOrgn로 설정
     */
    public void setRealDmndOrgn(String realDmndOrgn) {
        this.realDmndOrgn = realDmndOrgn;
    }


    /**
     * String userNm을 반환
     * @return String userNm
     */
    public String getUserNm() {
        return userNm;
    }


    /**
     * userNm을 설정
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }


    /**
     * String cntrctBeginDeMin을 반환
     * @return String cntrctBeginDeMin
     */
    public String getCntrctBeginDeMin() {
        return cntrctBeginDeMin;
    }

    
    /**
     * cntrctBeginDeMin을 설정
     * @param cntrctBeginDeMin 을(를) String cntrctBeginDeMin로 설정
     */
    public void setCntrctBeginDeMin(String cntrctBeginDeMin) {
        this.cntrctBeginDeMin = cntrctBeginDeMin;
    }

    
    /**
     * String cntrctEndMax을 반환
     * @return String cntrctEndMax
     */
    public String getCntrctEndMax() {
        return cntrctEndMax;
    }

    
    /**
     * cntrctEndMax을 설정
     * @param cntrctEndMax 을(를) String cntrctEndMax로 설정
     */
    public void setCntrctEndMax(String cntrctEndMax) {
        this.cntrctEndMax = cntrctEndMax;
    }


    /**
     * String bidGbnCd을 반환
     * @return String bidGbnCd
     */
    public String getBidGbnCd() {
        return bidGbnCd;
    }

    
    /**
     * bidGbnCd을 설정
     * @param bidGbnCd 을(를) String bidGbnCd로 설정
     */
    public void setBidGbnCd(String bidGbnCd) {
        this.bidGbnCd = bidGbnCd;
    }



    /**
     * String notifyNum을 반환
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }


    
    /**
     * notifyNum을 설정
     * @param notifyNum 을(를) String notifyNum로 설정
     */
    public void setNotifyNum(String notifyNum) {
        this.notifyNum = notifyNum;
    }


    
    /**
     * int notifySeq을 반환
     * @return int notifySeq
     */
    public int getNotifySeq() {
        return notifySeq;
    }


    
    /**
     * notifySeq을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
    }

    
    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getCntrDt() {
        return cntrDt;
    }



    
    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setCntrDt(String cntrDt) {
        this.cntrDt = cntrDt;
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
     * String svcNm을 반환
     * @return String svcNm
     */
    public String getSvcNm() {
        return svcNm;
    }
    
    /**
     * svcNm을 설정
     * @param svcNm 을(를) String svcNm로 설정
     */
    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }
    
    /**
     * String cntrctBeginDe을 반환
     * @return String cntrctBeginDe
     */
    public String getCntrctBeginDe() {
        return cntrctBeginDe;
    }
    
    /**
     * cntrctBeginDe을 설정
     * @param cntrctBeginDe 을(를) String cntrctBeginDe로 설정
     */
    public void setCntrctBeginDe(String cntrctBeginDe) {
        this.cntrctBeginDe = cntrctBeginDe;
    }
    
    /**
     * String cntrctEnd을 반환
     * @return String cntrctEnd
     */
    public String getCntrctEnd() {
        return cntrctEnd;
    }
    
    /**
     * cntrctEnd을 설정
     * @param cntrctEnd 을(를) String cntrctEnd로 설정
     */
    public void setCntrctEnd(String cntrctEnd) {
        this.cntrctEnd = cntrctEnd;
    }
    
    /**
     * int cntrctMoun을 반환
     * @return int cntrctMoun
     */
    public String getCntrctMount() {
        return cntrctMount;
    }
    
    /**
     * cntrctMoun을 설정
     * @param cntrctMoun 을(를) int cntrctMoun로 설정
     */
    public void setCntrctMount(String cntrctMount) {
        this.cntrctMount = cntrctMount;
    }
    
    /**
     * int certResultCode을 반환
     * @return int certResultCode
     */
    public String getCodeNm() {
        return codeNm;
    }
    
    /**
     * certResultCode을 설정
     * @param certResultCode 을(를) int certResultCode로 설정
     */
    public void setCodeNm(String codeNm) {
        this.codeNm = codeNm;
    }

    
    /**
     * String organNm을 반환
     * @return String organNm
     */
    public String getOrganNm() {
        return organNm;
    }
    
    /**
     * organNm을 설정
     * @param organNm 을(를) String organNm로 설정
     */
    public void setOrganNm(String organNm) {
        this.organNm = organNm;
    }

    
    /**
     * Integer issuMthNm을 반환
     * @return Integer issuMthNm
     */
    public String getIssuMthNm() {
        return issuMthNm;
    }

    
    /**
     * issuMthNm을 설정
     * @param issuMthNm 을(를) Integer issuMthNm로 설정
     */
    public void setIssuMthNm(String issuMthNm) {
        this.issuMthNm = issuMthNm;
    }

    
    /**
     * String sndngDe을 반환
     * @return String sndngDe
     */
    public String getSndngDe() {
        return sndngDe;
    }

    
    /**
     * sndngDe을 설정
     * @param sndngDe 을(를) String sndngDe로 설정
     */
    public void setSndngDe(String sndngDe) {
        this.sndngDe = sndngDe;
    }

    
    /**
     * Integer rouIssuNo을 반환
     * @return Integer rouIssuNo
     */
    public Integer getRouIssuNo() {
        return rouIssuNo;
    }

    
    /**
     * rouIssuNo을 설정
     * @param rouIssuNo 을(를) Integer rouIssuNo로 설정
     */
    public void setRouIssuNo(Integer rouIssuNo) {
        this.rouIssuNo = rouIssuNo;
    }

    
    /**
     * Integer serviceCnt을 반환
     * @return Integer serviceCnt
     */
    public Integer getServiceCnt() {
        return serviceCnt;
    }

    
    /**
     * serviceCnt을 설정
     * @param serviceCnt 을(를) Integer serviceCnt로 설정
     */
    public void setServiceCnt(Integer serviceCnt) {
        this.serviceCnt = serviceCnt;
    }

    
    /**
     * String issuSttusNm을 반환
     * @return String issuSttusNm
     */
    public String getIssuSttusNm() {
        return issuSttusNm;
    }

    
    /**
     * issuSttusNm을 설정
     * @param issuSttusNm 을(를) String issuSttusNm로 설정
     */
    public void setIssuSttusNm(String issuSttusNm) {
        this.issuSttusNm = issuSttusNm;
    }

    
    /**
     * String pdfProfIssuFile을 반환
     * @return String pdfProfIssuFile
     */
    public String getPdfProfIssuFile() {
        return pdfProfIssuFile;
    }

    
    /**
     * pdfProfIssuFile을 설정
     * @param pdfProfIssuFile 을(를) String pdfProfIssuFile로 설정
     */
    public void setPdfProfIssuFile(String pdfProfIssuFile) {
        this.pdfProfIssuFile = pdfProfIssuFile;
    }

    
    /**
     * String prufPdBeginDe을 반환
     * @return String prufPdBeginDe
     */
    public String getPrufPdBeginDe() {
        return prufPdBeginDe;
    }

    
    /**
     * prufPdBeginDe을 설정
     * @param prufPdBeginDe 을(를) String prufPdBeginDe로 설정
     */
    public void setPrufPdBeginDe(String prufPdBeginDe) {
        this.prufPdBeginDe = prufPdBeginDe;
    }

    
    /**
     * Integer rouSn을 반환
     * @return Integer rouSn
     */
    public Integer getRouSn() {
        return rouSn;
    }

    
    /**
     * rouSn을 설정
     * @param rouSn 을(를) Integer rouSn로 설정
     */
    public void setRouSn(Integer rouSn) {
        this.rouSn = rouSn;
    }

    /**
     * String issuSttus을 반환
     * @return String issuSttus
     */
    public String getIssuSttus() {
        return issuSttus;
    }

    
    /**
     * issuSttus을 설정
     * @param issuSttus 을(를) String issuSttus로 설정
     */
    public void setIssuSttus(String issuSttus) {
        this.issuSttus = issuSttus;
    }

    
    /**
     * String dateDiffe을 반환
     * @return String dateDiffe
     */
    public String getDateDiffe() {
        return dateDiffe;
    }

    
    /**
     * dateDiffe을 설정
     * @param dateDiffe 을(를) String dateDiffe로 설정
     */
    public void setDateDiffe(String dateDiffe) {
        this.dateDiffe = dateDiffe;
    }

    
    /**
     * List<ProofIssueledgerVO> dataList을 반환
     * @return List<ProofIssueledgerVO> dataList
     */
    public List<ProofIssueledgerVO> getDataList() {
        return dataList;
    }

    
    /**
     * dataList을 설정
     * @param dataList 을(를) List<ProofIssueledgerVO> dataList로 설정
     */
    public void setDataList(List<ProofIssueledgerVO> dataList) {
        this.dataList = dataList;
    }


    /**
     * String goodsKndCd을 반환
     * @return String goodsKndCd
     */
    public String getGoodsKndCd() {
        return goodsKndCd;
    }


    /**
     * goodsKndCd을 설정
     * @param goodsKndCd 을(를) String goodsKndCd로 설정
     */
    public void setGoodsKndCd(String goodsKndCd) {
        this.goodsKndCd = goodsKndCd;
    }


    
    /**
     * Integer cntrctAmount을 반환
     * @return Integer cntrctAmount
     */
    public Integer getCntrctAmount() {
        return cntrctAmount;
    }


    
    /**
     * cntrctAmount을 설정
     * @param cntrctAmount 을(를) Integer cntrctAmount로 설정
     */
    public void setCntrctAmount(Integer cntrctAmount) {
        this.cntrctAmount = cntrctAmount;
    }


    /**
     * int pdfProfIssuFileSeq을 반환
     * @return int pdfProfIssuFileSeq
     */
    public int getPdfProfIssuFileSeq() {
        return pdfProfIssuFileSeq;
    }


    /**
     * pdfProfIssuFileSeq을 설정
     * @param pdfProfIssuFileSeq 을(를) int pdfProfIssuFileSeq로 설정
     */
    public void setPdfProfIssuFileSeq(int pdfProfIssuFileSeq) {
        this.pdfProfIssuFileSeq = pdfProfIssuFileSeq;
    }

    
    /**
     * String fileId을 반환
     * @return String fileId
     */
    public String getFileId() {
        return fileId;
    }


    
    /**
     * fileId을 설정
     * @param fileId 을(를) String fileId로 설정
     */
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }


    
    /**
     * String localOrginlNm을 반환
     * @return String localOrginlNm
     */
    public String getLocalOrginlNm() {
        return localOrginlNm;
    }


    
    /**
     * localOrginlNm을 설정
     * @param localOrginlNm 을(를) String localOrginlNm로 설정
     */
    public void setLocalOrginlNm(String localOrginlNm) {
        this.localOrginlNm = localOrginlNm;
    }

    
}
