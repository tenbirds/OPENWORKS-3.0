/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

import java.util.List;

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
public class MyCeartNotifySplyVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 공급자아이디 */
    private String userId;

    /** 공급자명 */
    private String langStoreNm;

    /** 서비스코드 */
    private String goodsCode;

    /** 서비스코드 배열 */
    private List<String> goodsCodeList;
    
    /** 서비스명 */
    private String goodsName;
    
    /** 확인여부 */
    private String confmGbn;
    
    /** 답변여부코드 */
    private int askApplyCd;
    
    /** 답변여부명 */
    private String askApplyNm;
    
    /** 입찰진행상태코드 */
    private int bidPgesStat;
    
    /** 입찰진행상태명 */
    private String bidPgesStatNm;
    
    /** 선정/낙찰여부 */
    private String bidSussGbn;
    
    /** 선정날짜 */
    private String bidSussDt;
    
    /** 평가서 파일 SEQ */
    private int evalSheetFile;
    
    /** 평가서 실 파일명 */
    private String evalSheetFileOrgNm;
    
    /** 계약여부 */
    private String cntrGbn;
    
    /** 공급가 */
    private int splyAmt;
    
    /** VAT 여부 */
    private String vatGbn;
    
    /** 추가답변 */
    private String addAnswer;
    
    /** 비고 */
    private String splyNote;
    
    /** 납품-첨부파일 SEQ */
    private int splyFile;
    
    /** 납품 첨부파일 실 파일명 */
    private String splyFileOrgNm;

    /** 납품 첨부파일 파일 ID */
    private String splyFileId;
    
    /** 납품 첨부파일 파일 Size */
    private String splyFileSize;
    
    /** 납품 첨부파일 파일 Type */
    private String splyFileTy;

    /** 완료일시 */
    private String entrDt;

    /** 공급자 담당자 */
    private String storeChargerNm;

    /** 공급자 대표전화 */
    private String reprsntTelno;

    /** 공급자 E-MAIL */
    private String reprsntEmail;

    /** 공급자 휴대전화 */
    private String mbtlnum;
    
    /** 공급자 사업자번호 */
    private String bizrno;

    
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
     * String langStoreNm을 반환
     * @return String langStoreNm
     */
    public String getLangStoreNm() {
        return langStoreNm;
    }

    
    /**
     * langStoreNm을 설정
     * @param langStoreNm 을(를) String langStoreNm로 설정
     */
    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    
    /**
     * String goodsCode을 반환
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }

    
    /**
     * goodsCode을 설정
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    
    /**
     * List<String> goodsCodeList을 반환
     * @return List<String> goodsCodeList
     */
    public List<String> getGoodsCodeList() {
        return goodsCodeList;
    }

    
    /**
     * goodsCodeList을 설정
     * @param goodsCodeList 을(를) List<String> goodsCodeList로 설정
     */
    public void setGoodsCodeList(List<String> goodsCodeList) {
        this.goodsCodeList = goodsCodeList;
    }

    
    /**
     * String goodsName을 반환
     * @return String goodsName
     */
    public String getGoodsName() {
        return goodsName;
    }

    
    /**
     * goodsName을 설정
     * @param goodsName 을(를) String goodsName로 설정
     */
    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    
    /**
     * String confmGbn을 반환
     * @return String confmGbn
     */
    public String getConfmGbn() {
        return confmGbn;
    }

    
    /**
     * confmGbn을 설정
     * @param confmGbn 을(를) String confmGbn로 설정
     */
    public void setConfmGbn(String confmGbn) {
        this.confmGbn = confmGbn;
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
     * String bidSussDt을 반환
     * @return String bidSussDt
     */
    public String getBidSussDt() {
        return bidSussDt;
    }

    
    /**
     * bidSussDt을 설정
     * @param bidSussDt 을(를) String bidSussDt로 설정
     */
    public void setBidSussDt(String bidSussDt) {
        this.bidSussDt = bidSussDt;
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
     * int splyAmt을 반환
     * @return int splyAmt
     */
    public int getSplyAmt() {
        return splyAmt;
    }

    
    /**
     * splyAmt을 설정
     * @param splyAmt 을(를) int splyAmt로 설정
     */
    public void setSplyAmt(int splyAmt) {
        this.splyAmt = splyAmt;
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
     * String addAnswer을 반환
     * @return String addAnswer
     */
    public String getAddAnswer() {
        return addAnswer;
    }

    
    /**
     * addAnswer을 설정
     * @param addAnswer 을(를) String addAnswer로 설정
     */
    public void setAddAnswer(String addAnswer) {
        this.addAnswer = addAnswer;
    }

    
    /**
     * String splyNote을 반환
     * @return String splyNote
     */
    public String getSplyNote() {
        return splyNote;
    }

    
    /**
     * splyNote을 설정
     * @param splyNote 을(를) String splyNote로 설정
     */
    public void setSplyNote(String splyNote) {
        this.splyNote = splyNote;
    }

    
    /**
     * int splyFile을 반환
     * @return int splyFile
     */
    public int getSplyFile() {
        return splyFile;
    }

    
    /**
     * splyFile을 설정
     * @param splyFile 을(를) int splyFile로 설정
     */
    public void setSplyFile(int splyFile) {
        this.splyFile = splyFile;
    }

    
    /**
     * String splyFileOrgNm을 반환
     * @return String splyFileOrgNm
     */
    public String getSplyFileOrgNm() {
        return splyFileOrgNm;
    }

    
    /**
     * splyFileOrgNm을 설정
     * @param splyFileOrgNm 을(를) String splyFileOrgNm로 설정
     */
    public void setSplyFileOrgNm(String splyFileOrgNm) {
        this.splyFileOrgNm = splyFileOrgNm;
    }

    
    /**
     * String splyFileId을 반환
     * @return String splyFileId
     */
    public String getSplyFileId() {
        return splyFileId;
    }

    
    /**
     * splyFileId을 설정
     * @param splyFileId 을(를) String splyFileId로 설정
     */
    public void setSplyFileId(String splyFileId) {
        this.splyFileId = splyFileId;
    }

    
    /**
     * String splyFileSize을 반환
     * @return String splyFileSize
     */
    public String getSplyFileSize() {
        return splyFileSize;
    }

    
    /**
     * splyFileSize을 설정
     * @param splyFileSize 을(를) String splyFileSize로 설정
     */
    public void setSplyFileSize(String splyFileSize) {
        this.splyFileSize = splyFileSize;
    }

    
    /**
     * String splyFileTy을 반환
     * @return String splyFileTy
     */
    public String getSplyFileTy() {
        return splyFileTy;
    }

    
    /**
     * splyFileTy을 설정
     * @param splyFileTy 을(를) String splyFileTy로 설정
     */
    public void setSplyFileTy(String splyFileTy) {
        this.splyFileTy = splyFileTy;
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
     * String storeChargerNm을 반환
     * @return String storeChargerNm
     */
    public String getStoreChargerNm() {
        return storeChargerNm;
    }

    
    /**
     * storeChargerNm을 설정
     * @param storeChargerNm 을(를) String storeChargerNm로 설정
     */
    public void setStoreChargerNm(String storeChargerNm) {
        this.storeChargerNm = storeChargerNm;
    }

    
    /**
     * String reprsntTelno을 반환
     * @return String reprsntTelno
     */
    public String getReprsntTelno() {
        return reprsntTelno;
    }

    
    /**
     * reprsntTelno을 설정
     * @param reprsntTelno 을(를) String reprsntTelno로 설정
     */
    public void setReprsntTelno(String reprsntTelno) {
        this.reprsntTelno = reprsntTelno;
    }

    
    /**
     * String reprsntEmail을 반환
     * @return String reprsntEmail
     */
    public String getReprsntEmail() {
        return reprsntEmail;
    }

    
    /**
     * reprsntEmail을 설정
     * @param reprsntEmail 을(를) String reprsntEmail로 설정
     */
    public void setReprsntEmail(String reprsntEmail) {
        this.reprsntEmail = reprsntEmail;
    }

    
    /**
     * String mbtlnum을 반환
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }

    
    /**
     * mbtlnum을 설정
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    
    /**
     * String bizrno을 반환
     * @return String bizrno
     */
    public String getBizrno() {
        return bizrno;
    }

    
    /**
     * bizrno을 설정
     * @param bizrno 을(를) String bizrno로 설정
     */
    public void setBizrno(String bizrno) {
        this.bizrno = bizrno;
    }

}