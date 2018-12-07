/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bidSttus.vo;

import java.util.List;

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
public class BidSttusListVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 8066298618131160918L;

    /** 언어코드 */
    private String langCode;

    /** 언어코드 배열 */
    private List<String> langCodes;

    /** 공고명/공고번호 구분 */
    private String searchDiv01;

    /** 공고명/공고번호 조회입력값 */
    private String searchKeyWord;
    
    /** 공고명/공고번호 조회입력값 */
    private String searchKeyWord01;
    
    /** 공고일/개찰일 구분 */
    private String searchDiv02;
    
    /** 조회일 시작 */
    private String searchStartDt;
    
    /** 조회일 종료 */
    private String searchEndDt;

    /** 수요기관명 */
    private String searchKeyWord02;

    /** 정렬구분 */
    private String searchDiv03;

    /** 공고번호 */
    private String notifyNum;    

    /** 공고순번 */
    private int notifySeq;

    /** 공고명 */
    private String bidNotifyNm;

    /** 입찰종류여부(2037)[입찰/견적] */
    private int bidGbnCd;

    /** 입찰종류명 */
    private String bidGbnNm;

    /** 수요기관 */
    private String realDmndOrgn;

    /** 서비스구분(1005)[SaaS/PaaS/IaaS] */
    private int goodKndCd;

    /** 서비스구분명 */
    private String goodKndNm;

    /** 공고종류(2038)[본공고/예비공고] */
    private int bidKndCd;

    /** 공고종류명 */
    private String bidKndNm;

    /** 공고분류(2039)[일반/긴급] */
    private int bidClassCd;

    /** 공고분류명 */
    private String bidClassNm;    
    
    /** 계약방법(2040)[일반/제한/수의/지명] */
    private int cntrMothod;

    /** 계약방법명 */
    private String cntrMothodNm;

    /** 입찰진행상태(2044)[대기중/응찰/마감/개찰/유찰/낙찰완료/낙찰취소/공고취소 등등] */
    private int bidPgesStat;

    /** 입찰진행상태명 */
    private String bidPgesStatNm;

    /** 공고 접수시작일 */
    private String strtDt;
    
    /** 공고 접수시작시간 */
    private String strtTime;
    
    /** 공고 접수마감일 */
    private String clseDt;
    
    /** 공고 접수마감시간 */
    private String clseTime;

    /** 마감여부 */
    private String closeYn;
    
    /** 수요자아이디 */
    private String endsUserId;

    /** 공급자아이디 */
    private String suplerId;

    
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
     * List<String> langCodes을 반환
     * @return List<String> langCodes
     */
    public List<String> getLangCodes() {
        return langCodes;
    }

    
    /**
     * langCodes을 설정
     * @param langCodes 을(를) List<String> langCodes로 설정
     */
    public void setLangCodes(List<String> langCodes) {
        this.langCodes = langCodes;
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
     * String searchKeyWord01을 반환
     * @return String searchKeyWord01
     */
    public String getSearchKeyWord01() {
        return searchKeyWord01;
    }

    
    /**
     * searchKeyWord01을 설정
     * @param searchKeyWord01 을(를) String searchKeyWord01로 설정
     */
    public void setSearchKeyWord01(String searchKeyWord01) {
        this.searchKeyWord01 = searchKeyWord01;
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
     * String searchStartDt을 반환
     * @return String searchStartDt
     */
    public String getSearchStartDt() {
        return searchStartDt;
    }

    
    /**
     * searchStartDt을 설정
     * @param searchStartDt 을(를) String searchStartDt로 설정
     */
    public void setSearchStartDt(String searchStartDt) {
        this.searchStartDt = searchStartDt;
    }

    
    /**
     * String searchEndDt을 반환
     * @return String searchEndDt
     */
    public String getSearchEndDt() {
        return searchEndDt;
    }

    
    /**
     * searchEndDt을 설정
     * @param searchEndDt 을(를) String searchEndDt로 설정
     */
    public void setSearchEndDt(String searchEndDt) {
        this.searchEndDt = searchEndDt;
    }

    
    /**
     * String searchKeyWord02을 반환
     * @return String searchKeyWord02
     */
    public String getSearchKeyWord02() {
        return searchKeyWord02;
    }

    
    /**
     * searchKeyWord02을 설정
     * @param searchKeyWord02 을(를) String searchKeyWord02로 설정
     */
    public void setSearchKeyWord02(String searchKeyWord02) {
        this.searchKeyWord02 = searchKeyWord02;
    }

    
    /**
     * String searchDiv03을 반환
     * @return String searchDiv03
     */
    public String getSearchDiv03() {
        return searchDiv03;
    }

    
    /**
     * searchDiv03을 설정
     * @param searchDiv03 을(를) String searchDiv03로 설정
     */
    public void setSearchDiv03(String searchDiv03) {
        this.searchDiv03 = searchDiv03;
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
     * int bidKndCd을 반환
     * @return int bidKndCd
     */
    public int getBidKndCd() {
        return bidKndCd;
    }

    
    /**
     * bidKndCd을 설정
     * @param bidKndCd 을(를) int bidKndCd로 설정
     */
    public void setBidKndCd(int bidKndCd) {
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
     * int bidClassCd을 반환
     * @return int bidClassCd
     */
    public int getBidClassCd() {
        return bidClassCd;
    }

    
    /**
     * bidClassCd을 설정
     * @param bidClassCd 을(를) int bidClassCd로 설정
     */
    public void setBidClassCd(int bidClassCd) {
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
     * int cntrMothod을 반환
     * @return int cntrMothod
     */
    public int getCntrMothod() {
        return cntrMothod;
    }

    
    /**
     * cntrMothod을 설정
     * @param cntrMothod 을(를) int cntrMothod로 설정
     */
    public void setCntrMothod(int cntrMothod) {
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
     * int bidPgesStat을 반환
     * @return int bidPgesStat
     */
    public int getBidPgesStat() {
        return bidPgesStat;
    }

    
    /**
     * bidPgesStat을 설정
     * @param bidPgesStat 을(를) int bidPgesStat로 설정
     */
    public void setBidPgesStat(int bidPgesStat) {
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
     * String closeYn을 반환
     * @return String closeYn
     */
    public String getCloseYn() {
        return closeYn;
    }

    
    /**
     * closeYn을 설정
     * @param closeYn 을(를) String closeYn로 설정
     */
    public void setCloseYn(String closeYn) {
        this.closeYn = closeYn;
    }

    
    /**
     * String endsUserId을 반환
     * @return String endsUserId
     */
    public String getEndsUserId() {
        return endsUserId;
    }

    
    /**
     * endsUserId을 설정
     * @param endsUserId 을(를) String endsUserId로 설정
     */
    public void setEndsUserId(String endsUserId) {
        this.endsUserId = endsUserId;
    }

    
    /**
     * String suplerId을 반환
     * @return String suplerId
     */
    public String getSuplerId() {
        return suplerId;
    }

    
    /**
     * suplerId을 설정
     * @param suplerId 을(를) String suplerId로 설정
     */
    public void setSuplerId(String suplerId) {
        this.suplerId = suplerId;
    }

}
