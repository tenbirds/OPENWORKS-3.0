/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

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
 *  2014. 10. 22.    이슬버미       신규
 * </pre>
 * @see
 */
public class MyCeartBidNotifyVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;

    /** 입찰종류여부(2037) */
    private int bidGbnCd;

    /** 입찰종류여부 */
    private String bidGbnNm;

    /** 입찰종류여부(1005) */
    private int goodKndCd;

    /** 입찰종류여부 */
    private String goodKndNm;

    /** 수요자아이디 */
    private String userId;
    
    /** 공급자아이디 */
    private String langStoreId;
    
    /** 구매희망목록순번 */
    private String grpSeq;
    
    /** 공고종류코드(2038) */
    private String bidKndCd;
    
    /** 공고종류명 */
    private String bidKndNm;

    /** 공고분류코드(2039) */
    private String bidClassCd;
    
    /** 공고분류명 */
    private String bidClassNm;
    
    /** 계약방법코드(2040) */
    private String cntrMothod;
    
    /** 계약방법명 */
    private String cntrMothodNm;
    
    /** 수의계약사유첨부 파일 SEQ */
    private int optlCntrFile;
    
    /** 수의계약사유첨부-첨부파일 */
    private List<FileVO> optlCntrFileList;
    
    /** 수의계약사유첨부 파일 실 파일명 */
    private String optlCntrFileOrgNm;

    /** 수의계약사유첨부 파일ID(OP_FILE테이블 참조) */
    private String optlCntrFileId;
    
    /** 수의계약사유첨부 파일명 Size */
    private String optlCntrFileSize;
    
    /** 수의계약사유첨부 파일명 Type */
    private String optlCntrFileTy; 
    
    /** 실수요기관 */
    private String realDmndOrgn;
    
    /** 담당자명 */
    private String goodsChargerNm;
    
    /** 연락처 */
    private String goodsChargerCttpc;
    
    /** 직급/직책 */
    private String userPosition;
    
    /** 연계기관공고URL */
    private String linkOrgnUrl;
    
    /** 입찰공고명 */
    private String bidNotifyNm;
    
    /** 접수일자 */
    private String strtDt;
    
    /** 접수시간 */
    private String strtTime;
    
    /** 마감일자 */
    private String clseDt;
    
    /** 마감시간 */
    private String clseTime;
    
    /** 개찰일자 */
    private String openDt;
    
    /** 개찰시간 */
    private String openTime;
    
    /** 지역제한1 코드 */
    private String areaLimit1;
    
    /** 지역제한1 코드명 */
    private String areaLimit1Nm;
    
    /** 지역제한2 코드 */
    private String areaLimit2;
    
    /** 지역제한2 코드명 */
    private String areaLimit2Nm;
    
    /** 지역제한3 코드 */
    private String areaLimit3;
    
    /** 지역제한3 코드명 */
    private String areaLimit3Nm;
    
    /** 자격제한-중소기업 */
    private String catyLimitEntr;
    
    /** 자격제한-벤처기업 */
    private String catyLimitVntr;
    
    /** 자격제한-사회적기업 */
    private String catyLimitSoc;
    
    /** 자격제한-여성기업 */
    private String catyLimitWomn;
    
    /** 자격제한-장애인 */
    private String catyLimitDiad;
    
    /** 자격제한-기타 */
    private String catyLimitEtc;
    
    /** 자격제한-기타-comment */
    private String catyLimitEtcComt;
    
    /** 희망구매가 */
    private int hopePuchAmt;
    
    /** VAT여부 */
    private String vatGbn;
    
    /** 납품일자 */
    private String delyDt;
    
    /** 납품시간 */
    private String delyTime;
    
    /** 협의여부 */
    private String talkGbn;
    
    /** 응답완료일 */
    private String rplyDt;

    /** 응답완료일 */
    private String rplyTime;

    /** 납품장소 */
    private String delyPlac;
    
    /** 납품-첨부파일 SEQ */
    private int delyFile;
    
    /** 납품-첨부파일 실 파일명 */
    private String delyFileOrgNm;

    /** 납품-첨부파일 파일ID(OP_FILE테이블 참조) */
    private String delyFileId;
    
    /** 납품-첨부파일 파일명 Size */
    private String delyFileSize;
    
    /** 납품-첨부파일 파일명 Type */
    private String delyFileTy; 
    
    /** 공고설명 */
    private String notifyCont;
    
    /** 입찰진행상태 코드(2044) */
    private String bidPgesStat;
    
    /** 입찰진행상태명 */
    private String bidPgesStatNm;
    
    /** 변경/취소 사유 */
    private String bidChngCause;
    
    /** 등록일자 */
    private String entrDt;
    
    /** 수정일자 */
    private String updtDt;
    
    /** 취소일자 */
    private String cnclDt;

    /** 조회조건1 */
    private String searchDiv01;
    
    /** 조회조건2 */
    private String searchDiv02;
    
    /** 조회 Text */
    private String searchKeyWord;

    /** 평가서 첨부 SEQ */
    private int evalSheetFile;
    
    /** 평가서 첨부 실 파일명 */
    private String evalSheetFileOrgNm;

    /** 평가서 첨부 파일ID(OP_FILE테이블 참조) */
    private String evalSheetFileId;
    
    /** 평가서 첨부 파일명 Size */
    private String evalSheetFileSize;
    
    /** 평가서 첨부 파일명 Type */
    private String evalSheetFileTy; 
    
    /** 평가서 첨부 */
    private List<FileVO> evalSheetFileList;

    /** 집행관이름 */
    private String baffNm;
    
    /** 실제개찰일 */
    private String realOpenDt;
    
    /** 실제개찰시간 */
    private String realOpenTm;

    /** 선정/낙찰 완료 정보의 사유 */
    private String evalCause;

    
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
     * int bidGbnCd을 반환
     * @return int bidGbnCd
     */
    public int getBidGbnCd() {
        return bidGbnCd;
    }

    
    /**
     * bidGbnCd을 설정
     * @param bidGbnCd 을(를) int bidGbnCd로 설정
     */
    public void setBidGbnCd(int bidGbnCd) {
        this.bidGbnCd = bidGbnCd;
    }

    
    /**
     * String bidGbnNm을 반환
     * @return String bidGbnNm
     */
    public String getBidGbnNm() {
        return bidGbnNm;
    }

    
    /**
     * bidGbnNm을 설정
     * @param bidGbnNm 을(를) String bidGbnNm로 설정
     */
    public void setBidGbnNm(String bidGbnNm) {
        this.bidGbnNm = bidGbnNm;
    }

    
    /**
     * int goodKndCd을 반환
     * @return int goodKndCd
     */
    public int getGoodKndCd() {
        return goodKndCd;
    }

    
    /**
     * goodKndCd을 설정
     * @param goodKndCd 을(를) int goodKndCd로 설정
     */
    public void setGoodKndCd(int goodKndCd) {
        this.goodKndCd = goodKndCd;
    }

    
    /**
     * String goodKndNm을 반환
     * @return String goodKndNm
     */
    public String getGoodKndNm() {
        return goodKndNm;
    }

    
    /**
     * goodKndNm을 설정
     * @param goodKndNm 을(를) String goodKndNm로 설정
     */
    public void setGoodKndNm(String goodKndNm) {
        this.goodKndNm = goodKndNm;
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
     * String langStoreId을 반환
     * @return String langStoreId
     */
    public String getLangStoreId() {
        return langStoreId;
    }

    
    /**
     * langStoreId을 설정
     * @param langStoreId 을(를) String langStoreId로 설정
     */
    public void setLangStoreId(String langStoreId) {
        this.langStoreId = langStoreId;
    }

    
    /**
     * String grpSeq을 반환
     * @return String grpSeq
     */
    public String getGrpSeq() {
        return grpSeq;
    }

    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) String grpSeq로 설정
     */
    public void setGrpSeq(String grpSeq) {
        this.grpSeq = grpSeq;
    }

    
    /**
     * String bidKndCd을 반환
     * @return String bidKndCd
     */
    public String getBidKndCd() {
        return bidKndCd;
    }

    
    /**
     * bidKndCd을 설정
     * @param bidKndCd 을(를) String bidKndCd로 설정
     */
    public void setBidKndCd(String bidKndCd) {
        this.bidKndCd = bidKndCd;
    }

    
    /**
     * String bidKndNm을 반환
     * @return String bidKndNm
     */
    public String getBidKndNm() {
        return bidKndNm;
    }

    
    /**
     * bidKndNm을 설정
     * @param bidKndNm 을(를) String bidKndNm로 설정
     */
    public void setBidKndNm(String bidKndNm) {
        this.bidKndNm = bidKndNm;
    }

    
    /**
     * String bidClassCd을 반환
     * @return String bidClassCd
     */
    public String getBidClassCd() {
        return bidClassCd;
    }

    
    /**
     * bidClassCd을 설정
     * @param bidClassCd 을(를) String bidClassCd로 설정
     */
    public void setBidClassCd(String bidClassCd) {
        this.bidClassCd = bidClassCd;
    }

    
    /**
     * String bidClassNm을 반환
     * @return String bidClassNm
     */
    public String getBidClassNm() {
        return bidClassNm;
    }

    
    /**
     * bidClassNm을 설정
     * @param bidClassNm 을(를) String bidClassNm로 설정
     */
    public void setBidClassNm(String bidClassNm) {
        this.bidClassNm = bidClassNm;
    }

    
    /**
     * String cntrMothod을 반환
     * @return String cntrMothod
     */
    public String getCntrMothod() {
        return cntrMothod;
    }

    
    /**
     * cntrMothod을 설정
     * @param cntrMothod 을(를) String cntrMothod로 설정
     */
    public void setCntrMothod(String cntrMothod) {
        this.cntrMothod = cntrMothod;
    }

    
    /**
     * String cntrMothodNm을 반환
     * @return String cntrMothodNm
     */
    public String getCntrMothodNm() {
        return cntrMothodNm;
    }

    
    /**
     * cntrMothodNm을 설정
     * @param cntrMothodNm 을(를) String cntrMothodNm로 설정
     */
    public void setCntrMothodNm(String cntrMothodNm) {
        this.cntrMothodNm = cntrMothodNm;
    }

    
    /**
     * int optlCntrFile을 반환
     * @return int optlCntrFile
     */
    public int getOptlCntrFile() {
        return optlCntrFile;
    }

    
    /**
     * optlCntrFile을 설정
     * @param optlCntrFile 을(를) int optlCntrFile로 설정
     */
    public void setOptlCntrFile(int optlCntrFile) {
        this.optlCntrFile = optlCntrFile;
    }

    
    /**
     * List<FileVO> optlCntrFileList을 반환
     * @return List<FileVO> optlCntrFileList
     */
    public List<FileVO> getOptlCntrFileList() {
        return optlCntrFileList;
    }

    
    /**
     * optlCntrFileList을 설정
     * @param optlCntrFileList 을(를) List<FileVO> optlCntrFileList로 설정
     */
    public void setOptlCntrFileList(List<FileVO> optlCntrFileList) {
        this.optlCntrFileList = optlCntrFileList;
    }

    
    /**
     * String optlCntrFileOrgNm을 반환
     * @return String optlCntrFileOrgNm
     */
    public String getOptlCntrFileOrgNm() {
        return optlCntrFileOrgNm;
    }

    
    /**
     * optlCntrFileOrgNm을 설정
     * @param optlCntrFileOrgNm 을(를) String optlCntrFileOrgNm로 설정
     */
    public void setOptlCntrFileOrgNm(String optlCntrFileOrgNm) {
        this.optlCntrFileOrgNm = optlCntrFileOrgNm;
    }

    
    /**
     * String optlCntrFileId을 반환
     * @return String optlCntrFileId
     */
    public String getOptlCntrFileId() {
        return optlCntrFileId;
    }

    
    /**
     * optlCntrFileId을 설정
     * @param optlCntrFileId 을(를) String optlCntrFileId로 설정
     */
    public void setOptlCntrFileId(String optlCntrFileId) {
        this.optlCntrFileId = optlCntrFileId;
    }

    
    /**
     * String optlCntrFileSize을 반환
     * @return String optlCntrFileSize
     */
    public String getOptlCntrFileSize() {
        return optlCntrFileSize;
    }

    
    /**
     * optlCntrFileSize을 설정
     * @param optlCntrFileSize 을(를) String optlCntrFileSize로 설정
     */
    public void setOptlCntrFileSize(String optlCntrFileSize) {
        this.optlCntrFileSize = optlCntrFileSize;
    }

    
    /**
     * String optlCntrFileTy을 반환
     * @return String optlCntrFileTy
     */
    public String getOptlCntrFileTy() {
        return optlCntrFileTy;
    }

    
    /**
     * optlCntrFileTy을 설정
     * @param optlCntrFileTy 을(를) String optlCntrFileTy로 설정
     */
    public void setOptlCntrFileTy(String optlCntrFileTy) {
        this.optlCntrFileTy = optlCntrFileTy;
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
     * String goodsChargerNm을 반환
     * @return String goodsChargerNm
     */
    public String getGoodsChargerNm() {
        return goodsChargerNm;
    }

    
    /**
     * goodsChargerNm을 설정
     * @param goodsChargerNm 을(를) String goodsChargerNm로 설정
     */
    public void setGoodsChargerNm(String goodsChargerNm) {
        this.goodsChargerNm = goodsChargerNm;
    }

    
    /**
     * String goodsChargerCttpc을 반환
     * @return String goodsChargerCttpc
     */
    public String getGoodsChargerCttpc() {
        return goodsChargerCttpc;
    }

    
    /**
     * goodsChargerCttpc을 설정
     * @param goodsChargerCttpc 을(를) String goodsChargerCttpc로 설정
     */
    public void setGoodsChargerCttpc(String goodsChargerCttpc) {
        this.goodsChargerCttpc = goodsChargerCttpc;
    }

    
    /**
     * String userPosition을 반환
     * @return String userPosition
     */
    public String getUserPosition() {
        return userPosition;
    }

    
    /**
     * userPosition을 설정
     * @param userPosition 을(를) String userPosition로 설정
     */
    public void setUserPosition(String userPosition) {
        this.userPosition = userPosition;
    }

    
    /**
     * String linkOrgnUrl을 반환
     * @return String linkOrgnUrl
     */
    public String getLinkOrgnUrl() {
        return linkOrgnUrl;
    }

    
    /**
     * linkOrgnUrl을 설정
     * @param linkOrgnUrl 을(를) String linkOrgnUrl로 설정
     */
    public void setLinkOrgnUrl(String linkOrgnUrl) {
        this.linkOrgnUrl = linkOrgnUrl;
    }

    
    /**
     * String bidNotifyNm을 반환
     * @return String bidNotifyNm
     */
    public String getBidNotifyNm() {
        return bidNotifyNm;
    }

    
    /**
     * bidNotifyNm을 설정
     * @param bidNotifyNm 을(를) String bidNotifyNm로 설정
     */
    public void setBidNotifyNm(String bidNotifyNm) {
        this.bidNotifyNm = bidNotifyNm;
    }

    
    /**
     * String strtDt을 반환
     * @return String strtDt
     */
    public String getStrtDt() {
        return strtDt;
    }

    
    /**
     * strtDt을 설정
     * @param strtDt 을(를) String strtDt로 설정
     */
    public void setStrtDt(String strtDt) {
        this.strtDt = strtDt;
    }

    
    /**
     * String strtTime을 반환
     * @return String strtTime
     */
    public String getStrtTime() {
        return strtTime;
    }

    
    /**
     * strtTime을 설정
     * @param strtTime 을(를) String strtTime로 설정
     */
    public void setStrtTime(String strtTime) {
        this.strtTime = strtTime;
    }

    
    /**
     * String clseDt을 반환
     * @return String clseDt
     */
    public String getClseDt() {
        return clseDt;
    }

    
    /**
     * clseDt을 설정
     * @param clseDt 을(를) String clseDt로 설정
     */
    public void setClseDt(String clseDt) {
        this.clseDt = clseDt;
    }

    
    /**
     * String clseTime을 반환
     * @return String clseTime
     */
    public String getClseTime() {
        return clseTime;
    }

    
    /**
     * clseTime을 설정
     * @param clseTime 을(를) String clseTime로 설정
     */
    public void setClseTime(String clseTime) {
        this.clseTime = clseTime;
    }

    
    /**
     * String openDt을 반환
     * @return String openDt
     */
    public String getOpenDt() {
        return openDt;
    }

    
    /**
     * openDt을 설정
     * @param openDt 을(를) String openDt로 설정
     */
    public void setOpenDt(String openDt) {
        this.openDt = openDt;
    }

    
    /**
     * String openTime을 반환
     * @return String openTime
     */
    public String getOpenTime() {
        return openTime;
    }

    
    /**
     * openTime을 설정
     * @param openTime 을(를) String openTime로 설정
     */
    public void setOpenTime(String openTime) {
        this.openTime = openTime;
    }

    
    /**
     * String areaLimit1을 반환
     * @return String areaLimit1
     */
    public String getAreaLimit1() {
        return areaLimit1;
    }

    
    /**
     * areaLimit1을 설정
     * @param areaLimit1 을(를) String areaLimit1로 설정
     */
    public void setAreaLimit1(String areaLimit1) {
        this.areaLimit1 = areaLimit1;
    }

    
    /**
     * String areaLimit1Nm을 반환
     * @return String areaLimit1Nm
     */
    public String getAreaLimit1Nm() {
        return areaLimit1Nm;
    }

    
    /**
     * areaLimit1Nm을 설정
     * @param areaLimit1Nm 을(를) String areaLimit1Nm로 설정
     */
    public void setAreaLimit1Nm(String areaLimit1Nm) {
        this.areaLimit1Nm = areaLimit1Nm;
    }

    
    /**
     * String areaLimit2을 반환
     * @return String areaLimit2
     */
    public String getAreaLimit2() {
        return areaLimit2;
    }

    
    /**
     * areaLimit2을 설정
     * @param areaLimit2 을(를) String areaLimit2로 설정
     */
    public void setAreaLimit2(String areaLimit2) {
        this.areaLimit2 = areaLimit2;
    }

    
    /**
     * String areaLimit2Nm을 반환
     * @return String areaLimit2Nm
     */
    public String getAreaLimit2Nm() {
        return areaLimit2Nm;
    }

    
    /**
     * areaLimit2Nm을 설정
     * @param areaLimit2Nm 을(를) String areaLimit2Nm로 설정
     */
    public void setAreaLimit2Nm(String areaLimit2Nm) {
        this.areaLimit2Nm = areaLimit2Nm;
    }

    
    /**
     * String areaLimit3을 반환
     * @return String areaLimit3
     */
    public String getAreaLimit3() {
        return areaLimit3;
    }

    
    /**
     * areaLimit3을 설정
     * @param areaLimit3 을(를) String areaLimit3로 설정
     */
    public void setAreaLimit3(String areaLimit3) {
        this.areaLimit3 = areaLimit3;
    }

    
    /**
     * String areaLimit3Nm을 반환
     * @return String areaLimit3Nm
     */
    public String getAreaLimit3Nm() {
        return areaLimit3Nm;
    }

    
    /**
     * areaLimit3Nm을 설정
     * @param areaLimit3Nm 을(를) String areaLimit3Nm로 설정
     */
    public void setAreaLimit3Nm(String areaLimit3Nm) {
        this.areaLimit3Nm = areaLimit3Nm;
    }

    
    /**
     * String catyLimitEntr을 반환
     * @return String catyLimitEntr
     */
    public String getCatyLimitEntr() {
        return catyLimitEntr;
    }

    
    /**
     * catyLimitEntr을 설정
     * @param catyLimitEntr 을(를) String catyLimitEntr로 설정
     */
    public void setCatyLimitEntr(String catyLimitEntr) {
        this.catyLimitEntr = catyLimitEntr;
    }

    
    /**
     * String catyLimitVntr을 반환
     * @return String catyLimitVntr
     */
    public String getCatyLimitVntr() {
        return catyLimitVntr;
    }

    
    /**
     * catyLimitVntr을 설정
     * @param catyLimitVntr 을(를) String catyLimitVntr로 설정
     */
    public void setCatyLimitVntr(String catyLimitVntr) {
        this.catyLimitVntr = catyLimitVntr;
    }

    
    /**
     * String catyLimitSoc을 반환
     * @return String catyLimitSoc
     */
    public String getCatyLimitSoc() {
        return catyLimitSoc;
    }

    
    /**
     * catyLimitSoc을 설정
     * @param catyLimitSoc 을(를) String catyLimitSoc로 설정
     */
    public void setCatyLimitSoc(String catyLimitSoc) {
        this.catyLimitSoc = catyLimitSoc;
    }

    
    /**
     * String catyLimitWomn을 반환
     * @return String catyLimitWomn
     */
    public String getCatyLimitWomn() {
        return catyLimitWomn;
    }

    
    /**
     * catyLimitWomn을 설정
     * @param catyLimitWomn 을(를) String catyLimitWomn로 설정
     */
    public void setCatyLimitWomn(String catyLimitWomn) {
        this.catyLimitWomn = catyLimitWomn;
    }

    
    /**
     * String catyLimitDiad을 반환
     * @return String catyLimitDiad
     */
    public String getCatyLimitDiad() {
        return catyLimitDiad;
    }

    
    /**
     * catyLimitDiad을 설정
     * @param catyLimitDiad 을(를) String catyLimitDiad로 설정
     */
    public void setCatyLimitDiad(String catyLimitDiad) {
        this.catyLimitDiad = catyLimitDiad;
    }

    
    /**
     * String catyLimitEtc을 반환
     * @return String catyLimitEtc
     */
    public String getCatyLimitEtc() {
        return catyLimitEtc;
    }

    
    /**
     * catyLimitEtc을 설정
     * @param catyLimitEtc 을(를) String catyLimitEtc로 설정
     */
    public void setCatyLimitEtc(String catyLimitEtc) {
        this.catyLimitEtc = catyLimitEtc;
    }

    
    /**
     * String catyLimitEtcComt을 반환
     * @return String catyLimitEtcComt
     */
    public String getCatyLimitEtcComt() {
        return catyLimitEtcComt;
    }

    
    /**
     * catyLimitEtcComt을 설정
     * @param catyLimitEtcComt 을(를) String catyLimitEtcComt로 설정
     */
    public void setCatyLimitEtcComt(String catyLimitEtcComt) {
        this.catyLimitEtcComt = catyLimitEtcComt;
    }

    
    /**
     * int hopePuchAmt을 반환
     * @return int hopePuchAmt
     */
    public int getHopePuchAmt() {
        return hopePuchAmt;
    }

    
    /**
     * hopePuchAmt을 설정
     * @param hopePuchAmt 을(를) int hopePuchAmt로 설정
     */
    public void setHopePuchAmt(int hopePuchAmt) {
        this.hopePuchAmt = hopePuchAmt;
    }

    
    /**
     * String vatGbn을 반환
     * @return String vatGbn
     */
    public String getVatGbn() {
        return vatGbn;
    }

    
    /**
     * vatGbn을 설정
     * @param vatGbn 을(를) String vatGbn로 설정
     */
    public void setVatGbn(String vatGbn) {
        this.vatGbn = vatGbn;
    }

    
    /**
     * String delyDt을 반환
     * @return String delyDt
     */
    public String getDelyDt() {
        return delyDt;
    }

    
    /**
     * delyDt을 설정
     * @param delyDt 을(를) String delyDt로 설정
     */
    public void setDelyDt(String delyDt) {
        this.delyDt = delyDt;
    }

    
    /**
     * String delyTime을 반환
     * @return String delyTime
     */
    public String getDelyTime() {
        return delyTime;
    }

    
    /**
     * delyTime을 설정
     * @param delyTime 을(를) String delyTime로 설정
     */
    public void setDelyTime(String delyTime) {
        this.delyTime = delyTime;
    }

    
    /**
     * String talkGbn을 반환
     * @return String talkGbn
     */
    public String getTalkGbn() {
        return talkGbn;
    }

    
    /**
     * talkGbn을 설정
     * @param talkGbn 을(를) String talkGbn로 설정
     */
    public void setTalkGbn(String talkGbn) {
        this.talkGbn = talkGbn;
    }

    
    /**
     * String rplyDt을 반환
     * @return String rplyDt
     */
    public String getRplyDt() {
        return rplyDt;
    }

    
    /**
     * rplyDt을 설정
     * @param rplyDt 을(를) String rplyDt로 설정
     */
    public void setRplyDt(String rplyDt) {
        this.rplyDt = rplyDt;
    }

    
    /**
     * String rplyTime을 반환
     * @return String rplyTime
     */
    public String getRplyTime() {
        return rplyTime;
    }

    
    /**
     * rplyTime을 설정
     * @param rplyTime 을(를) String rplyTime로 설정
     */
    public void setRplyTime(String rplyTime) {
        this.rplyTime = rplyTime;
    }

    
    /**
     * String delyPlac을 반환
     * @return String delyPlac
     */
    public String getDelyPlac() {
        return delyPlac;
    }

    
    /**
     * delyPlac을 설정
     * @param delyPlac 을(를) String delyPlac로 설정
     */
    public void setDelyPlac(String delyPlac) {
        this.delyPlac = delyPlac;
    }

    
    /**
     * int delyFile을 반환
     * @return int delyFile
     */
    public int getDelyFile() {
        return delyFile;
    }

    
    /**
     * delyFile을 설정
     * @param delyFile 을(를) int delyFile로 설정
     */
    public void setDelyFile(int delyFile) {
        this.delyFile = delyFile;
    }

    
    /**
     * String delyFileOrgNm을 반환
     * @return String delyFileOrgNm
     */
    public String getDelyFileOrgNm() {
        return delyFileOrgNm;
    }

    
    /**
     * delyFileOrgNm을 설정
     * @param delyFileOrgNm 을(를) String delyFileOrgNm로 설정
     */
    public void setDelyFileOrgNm(String delyFileOrgNm) {
        this.delyFileOrgNm = delyFileOrgNm;
    }

    
    /**
     * String delyFileId을 반환
     * @return String delyFileId
     */
    public String getDelyFileId() {
        return delyFileId;
    }

    
    /**
     * delyFileId을 설정
     * @param delyFileId 을(를) String delyFileId로 설정
     */
    public void setDelyFileId(String delyFileId) {
        this.delyFileId = delyFileId;
    }

    
    /**
     * String delyFileSize을 반환
     * @return String delyFileSize
     */
    public String getDelyFileSize() {
        return delyFileSize;
    }

    
    /**
     * delyFileSize을 설정
     * @param delyFileSize 을(를) String delyFileSize로 설정
     */
    public void setDelyFileSize(String delyFileSize) {
        this.delyFileSize = delyFileSize;
    }

    
    /**
     * String delyFileTy을 반환
     * @return String delyFileTy
     */
    public String getDelyFileTy() {
        return delyFileTy;
    }

    
    /**
     * delyFileTy을 설정
     * @param delyFileTy 을(를) String delyFileTy로 설정
     */
    public void setDelyFileTy(String delyFileTy) {
        this.delyFileTy = delyFileTy;
    }

    
    /**
     * String notifyCont을 반환
     * @return String notifyCont
     */
    public String getNotifyCont() {
        return notifyCont;
    }

    
    /**
     * notifyCont을 설정
     * @param notifyCont 을(를) String notifyCont로 설정
     */
    public void setNotifyCont(String notifyCont) {
        this.notifyCont = notifyCont;
    }

    
    /**
     * String bidPgesStat을 반환
     * @return String bidPgesStat
     */
    public String getBidPgesStat() {
        return bidPgesStat;
    }

    
    /**
     * bidPgesStat을 설정
     * @param bidPgesStat 을(를) String bidPgesStat로 설정
     */
    public void setBidPgesStat(String bidPgesStat) {
        this.bidPgesStat = bidPgesStat;
    }

    
    /**
     * String bidPgesStatNm을 반환
     * @return String bidPgesStatNm
     */
    public String getBidPgesStatNm() {
        return bidPgesStatNm;
    }

    
    /**
     * bidPgesStatNm을 설정
     * @param bidPgesStatNm 을(를) String bidPgesStatNm로 설정
     */
    public void setBidPgesStatNm(String bidPgesStatNm) {
        this.bidPgesStatNm = bidPgesStatNm;
    }

    
    /**
     * String bidChngCause을 반환
     * @return String bidChngCause
     */
    public String getBidChngCause() {
        return bidChngCause;
    }

    
    /**
     * bidChngCause을 설정
     * @param bidChngCause 을(를) String bidChngCause로 설정
     */
    public void setBidChngCause(String bidChngCause) {
        this.bidChngCause = bidChngCause;
    }

    
    /**
     * String entrDt을 반환
     * @return String entrDt
     */
    public String getEntrDt() {
        return entrDt;
    }

    
    /**
     * entrDt을 설정
     * @param entrDt 을(를) String entrDt로 설정
     */
    public void setEntrDt(String entrDt) {
        this.entrDt = entrDt;
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
     * String cnclDt을 반환
     * @return String cnclDt
     */
    public String getCnclDt() {
        return cnclDt;
    }

    
    /**
     * cnclDt을 설정
     * @param cnclDt 을(를) String cnclDt로 설정
     */
    public void setCnclDt(String cnclDt) {
        this.cnclDt = cnclDt;
    }

    
    /**
     * String searchDiv01을 반환
     * @return String searchDiv01
     */
    public String getSearchDiv01() {
        return searchDiv01;
    }

    
    /**
     * searchDiv01을 설정
     * @param searchDiv01 을(를) String searchDiv01로 설정
     */
    public void setSearchDiv01(String searchDiv01) {
        this.searchDiv01 = searchDiv01;
    }

    
    /**
     * String searchDiv02을 반환
     * @return String searchDiv02
     */
    public String getSearchDiv02() {
        return searchDiv02;
    }

    
    /**
     * searchDiv02을 설정
     * @param searchDiv02 을(를) String searchDiv02로 설정
     */
    public void setSearchDiv02(String searchDiv02) {
        this.searchDiv02 = searchDiv02;
    }

    
    /**
     * String searchKeyWord을 반환
     * @return String searchKeyWord
     */
    public String getSearchKeyWord() {
        return searchKeyWord;
    }

    
    /**
     * searchKeyWord을 설정
     * @param searchKeyWord 을(를) String searchKeyWord로 설정
     */
    public void setSearchKeyWord(String searchKeyWord) {
        this.searchKeyWord = searchKeyWord;
    }

    
    /**
     * int evalSheetFile을 반환
     * @return int evalSheetFile
     */
    public int getEvalSheetFile() {
        return evalSheetFile;
    }

    
    /**
     * evalSheetFile을 설정
     * @param evalSheetFile 을(를) int evalSheetFile로 설정
     */
    public void setEvalSheetFile(int evalSheetFile) {
        this.evalSheetFile = evalSheetFile;
    }

    
    /**
     * String evalSheetFileOrgNm을 반환
     * @return String evalSheetFileOrgNm
     */
    public String getEvalSheetFileOrgNm() {
        return evalSheetFileOrgNm;
    }

    
    /**
     * evalSheetFileOrgNm을 설정
     * @param evalSheetFileOrgNm 을(를) String evalSheetFileOrgNm로 설정
     */
    public void setEvalSheetFileOrgNm(String evalSheetFileOrgNm) {
        this.evalSheetFileOrgNm = evalSheetFileOrgNm;
    }

    
    /**
     * String evalSheetFileId을 반환
     * @return String evalSheetFileId
     */
    public String getEvalSheetFileId() {
        return evalSheetFileId;
    }

    
    /**
     * evalSheetFileId을 설정
     * @param evalSheetFileId 을(를) String evalSheetFileId로 설정
     */
    public void setEvalSheetFileId(String evalSheetFileId) {
        this.evalSheetFileId = evalSheetFileId;
    }

    
    /**
     * String evalSheetFileSize을 반환
     * @return String evalSheetFileSize
     */
    public String getEvalSheetFileSize() {
        return evalSheetFileSize;
    }

    
    /**
     * evalSheetFileSize을 설정
     * @param evalSheetFileSize 을(를) String evalSheetFileSize로 설정
     */
    public void setEvalSheetFileSize(String evalSheetFileSize) {
        this.evalSheetFileSize = evalSheetFileSize;
    }

    
    /**
     * String evalSheetFileTy을 반환
     * @return String evalSheetFileTy
     */
    public String getEvalSheetFileTy() {
        return evalSheetFileTy;
    }

    
    /**
     * evalSheetFileTy을 설정
     * @param evalSheetFileTy 을(를) String evalSheetFileTy로 설정
     */
    public void setEvalSheetFileTy(String evalSheetFileTy) {
        this.evalSheetFileTy = evalSheetFileTy;
    }

    
    /**
     * List<FileVO> evalSheetFileList을 반환
     * @return List<FileVO> evalSheetFileList
     */
    public List<FileVO> getEvalSheetFileList() {
        return evalSheetFileList;
    }

    
    /**
     * evalSheetFileList을 설정
     * @param evalSheetFileList 을(를) List<FileVO> evalSheetFileList로 설정
     */
    public void setEvalSheetFileList(List<FileVO> evalSheetFileList) {
        this.evalSheetFileList = evalSheetFileList;
    }

    
    /**
     * String baffNm을 반환
     * @return String baffNm
     */
    public String getBaffNm() {
        return baffNm;
    }

    
    /**
     * baffNm을 설정
     * @param baffNm 을(를) String baffNm로 설정
     */
    public void setBaffNm(String baffNm) {
        this.baffNm = baffNm;
    }

    
    /**
     * String realOpenDt을 반환
     * @return String realOpenDt
     */
    public String getRealOpenDt() {
        return realOpenDt;
    }

    
    /**
     * realOpenDt을 설정
     * @param realOpenDt 을(를) String realOpenDt로 설정
     */
    public void setRealOpenDt(String realOpenDt) {
        this.realOpenDt = realOpenDt;
    }

    
    /**
     * String realOpenTm을 반환
     * @return String realOpenTm
     */
    public String getRealOpenTm() {
        return realOpenTm;
    }

    
    /**
     * realOpenTm을 설정
     * @param realOpenTm 을(를) String realOpenTm로 설정
     */
    public void setRealOpenTm(String realOpenTm) {
        this.realOpenTm = realOpenTm;
    }

    
    /**
     * String evalCause을 반환
     * @return String evalCause
     */
    public String getEvalCause() {
        return evalCause;
    }

    
    /**
     * evalCause을 설정
     * @param evalCause 을(를) String evalCause로 설정
     */
    public void setEvalCause(String evalCause) {
        this.evalCause = evalCause;
    }

}
