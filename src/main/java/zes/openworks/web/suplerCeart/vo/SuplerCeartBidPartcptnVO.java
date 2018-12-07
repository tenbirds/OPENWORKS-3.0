/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

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
public class SuplerCeartBidPartcptnVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 언어코드 */
    private String langCode;

    /** 언어코드 배열 */
    private List<String> langCodes;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 수요자ID*/
    private String endsUserId;

    /** 공급자ID*/
    private String suplerId;

    /** 공고명 */
    private String bidNotifyNm;
    
    /** 수요기관 */
    private String realDmndOrgn;
    
    /** 계약방법(2040) */
    private int cntrMothod;
    
    /** 계약방법 코드명 */
    private String cntrMothodNm;

    /** 답변여부(2043) */
    private int askApplyCd;
    
    /** 답변여부 코드명 */
    private String askApplyNm;
    
    /** 입찰진행상태(2044) */
    private int bidPgesStat;
    
    /** 입찰진행상태 코드명 */
    private String bidPgesStatNm;
    
    /** 공고 접수일 */
    private String strtDt;
    
    /** 공고 접수시간 */
    private String strtTime;
    
    /** 공고 마감일 */
    private String clseDt;
    
    /** 공고 마감시간 */
    private String clseTime;
    
    /** 응찰일 */
    private String entrDt;
    
    /** 응찰 시간 */
    private String entrTime;
    
    /** 선정/낙찰여부 */
    private String bidSussGbn;
    
    /** 계약여부 */
    private String cntrGbn;

    /** 조회조건1 */
    private String searchDiv01;
    
    /** 조회조건2 */
    private String searchDiv02;
    
    /** 조회 Text */
    private String searchKeyWord;

    
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
     * int askApplyCd을 반환
     * @return int askApplyCd
     */
    public int getAskApplyCd() {
        return askApplyCd;
    }

    
    /**
     * askApplyCd을 설정
     * @param askApplyCd 을(를) int askApplyCd로 설정
     */
    public void setAskApplyCd(int askApplyCd) {
        this.askApplyCd = askApplyCd;
    }

    
    /**
     * String askApplyNm을 반환
     * @return String askApplyNm
     */
    public String getAskApplyNm() {
        return askApplyNm;
    }

    
    /**
     * askApplyNm을 설정
     * @param askApplyNm 을(를) String askApplyNm로 설정
     */
    public void setAskApplyNm(String askApplyNm) {
        this.askApplyNm = askApplyNm;
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
     * String entrTime을 반환
     * @return String entrTime
     */
    public String getEntrTime() {
        return entrTime;
    }

    
    /**
     * entrTime을 설정
     * @param entrTime 을(를) String entrTime로 설정
     */
    public void setEntrTime(String entrTime) {
        this.entrTime = entrTime;
    }

    
    /**
     * String bidSussGbn을 반환
     * @return String bidSussGbn
     */
    public String getBidSussGbn() {
        return bidSussGbn;
    }

    
    /**
     * bidSussGbn을 설정
     * @param bidSussGbn 을(를) String bidSussGbn로 설정
     */
    public void setBidSussGbn(String bidSussGbn) {
        this.bidSussGbn = bidSussGbn;
    }

    
    /**
     * String cntrGbn을 반환
     * @return String cntrGbn
     */
    public String getCntrGbn() {
        return cntrGbn;
    }

    
    /**
     * cntrGbn을 설정
     * @param cntrGbn 을(를) String cntrGbn로 설정
     */
    public void setCntrGbn(String cntrGbn) {
        this.cntrGbn = cntrGbn;
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

    
}
