/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bid;

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
public class TcnBidNotifyVO extends PaggingVO {


    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;
    
    /** 입찰종류여부 */
    private String bidGbnCd;

    /** 서비스구분 */
    private String goodKndCd;
    
    /** 수요자ID */
    private String userId;
    
    /** 구매희망목록 순번 */
    private String grpSeq;

    /** 공고종류 */
    private String bidKndCd;
    
    /** 공고분류 */
    private String bidClassCd;
    
    /** 계약방법 */
    private String cntrMothod;
    
    /** 수의계약사유첨부-첨부파일 */
    private int optlCntrFile;
    
    /** 수의계약사유첨부-첨부파일 */
    private List<FileVO> optlCntrFileList;

    /** 수의계약사유첨부-첨부파일ID(임시저장시 기존 등록되어 있는 파일을 구분하기 위해) */
    private String optlCntrFileId;

    /** 실수요기관 */
    private String realDmndOrgn;
    
    /** 수요자명 */
    private String userNm;

    /** 담당자명 */
    private String goodsChargerNm;

    /** 직책 */
    private String userPosition;
    
    /** 대표전화 */
    private String goodsChargerCttpc;

    /** 대표전화1 */
    private String goodsChargerCttpc1;
    
    /** 대표전화2 */
    private String goodsChargerCttpc2;
    
    /** 대표전화3 */
    private String goodsChargerCttpc3;
    

    /** 연계기관공고URL */
    private String linkOrgnUrl;
    
    /** 입찰공고명 */
    private String bidNotifyNm;
    
    /** 접수일시 */
    private String strtDt;
    
    /** 접수시간 */
    private String strtTime;
    
    /** 마감일시 */
    private String clseDt;
    
    /** 마감시간 */
    private String clseTime;
    
    /** 개찰일시 */
    private String openDt;
    
    /** 개찰시간 */
    private String openTime;

    /** 지역제한1 */
    private String areaLimit1;
    
    /** 지역제한2 */
    private String areaLimit2;
    
    /** 지역제한3 */
    private String areaLimit3;
    
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
    
    /** 자격제한-기타(입력용) */
    private String catyLimitEtcComt;
    
    /** 희망구매가 */
    private String hopePuchAmt;
    
    /** vat여부 */
    private String vatGbn;
    
    /** 납품일자 */
    private String delyDt;
    
    /** 납품시간 */
    private String delyTime;

    /** 합의여부 */
    private String talkGbn;
    
    /** 응답완료일 */
    private String rplyDt;
    
    /** 납품장소 */
    private String delyPlac;

    /** 납품-첨부파일 */
    private int delyFile;

    /** 납품-첨부파일 */
    private List<FileVO> delyFileList;

    /** 납품-첨부파일ID(임시저장시 기존 등록되어 있는 파일을 구분하기 위해) */
    private String delyFileId;

    /** 공고설명 */
    private String notifyCont;
    
    /** 상품코드 */
    private String goodsCd;

    
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
     * String goodKndCd을 반환
     * @return String goodKndCd
     */
    public String getGoodKndCd() {
        return goodKndCd;
    }

    
    /**
     * goodKndCd을 설정
     * @param goodKndCd 을(를) String goodKndCd로 설정
     */
    public void setGoodKndCd(String goodKndCd) {
        this.goodKndCd = goodKndCd;
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
     * String goodsChargerCttpc1을 반환
     * @return String goodsChargerCttpc1
     */
    public String getGoodsChargerCttpc1() {
        return goodsChargerCttpc1;
    }

    
    /**
     * goodsChargerCttpc1을 설정
     * @param goodsChargerCttpc1 을(를) String goodsChargerCttpc1로 설정
     */
    public void setGoodsChargerCttpc1(String goodsChargerCttpc1) {
        this.goodsChargerCttpc1 = goodsChargerCttpc1;
    }

    
    /**
     * String goodsChargerCttpc2을 반환
     * @return String goodsChargerCttpc2
     */
    public String getGoodsChargerCttpc2() {
        return goodsChargerCttpc2;
    }

    
    /**
     * goodsChargerCttpc2을 설정
     * @param goodsChargerCttpc2 을(를) String goodsChargerCttpc2로 설정
     */
    public void setGoodsChargerCttpc2(String goodsChargerCttpc2) {
        this.goodsChargerCttpc2 = goodsChargerCttpc2;
    }

    
    /**
     * String goodsChargerCttpc3을 반환
     * @return String goodsChargerCttpc3
     */
    public String getGoodsChargerCttpc3() {
        return goodsChargerCttpc3;
    }

    
    /**
     * goodsChargerCttpc3을 설정
     * @param goodsChargerCttpc3 을(를) String goodsChargerCttpc3로 설정
     */
    public void setGoodsChargerCttpc3(String goodsChargerCttpc3) {
        this.goodsChargerCttpc3 = goodsChargerCttpc3;
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
     * String goodsCd을 반환
     * @return String goodsCd
     */
    public String getGoodsCd() {
        return goodsCd;
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
     * String hopePuchAmt을 반환
     * @return String hopePuchAmt
     */
    public String getHopePuchAmt() {
        return hopePuchAmt;
    }

    
    /**
     * hopePuchAmt을 설정
     * @param hopePuchAmt 을(를) String hopePuchAmt로 설정
     */
    public void setHopePuchAmt(String hopePuchAmt) {
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
     * List<FileVO> delyFileList을 반환
     * @return List<FileVO> delyFileList
     */
    public List<FileVO> getDelyFileList() {
        return delyFileList;
    }

    
    /**
     * delyFileList을 설정
     * @param delyFileList 을(를) List<FileVO> delyFileList로 설정
     */
    public void setDelyFileList(List<FileVO> delyFileList) {
        this.delyFileList = delyFileList;
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
     * goodsCd을 설정
     * @param goodsCd 을(를) String goodsCd로 설정
     */
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }
}
