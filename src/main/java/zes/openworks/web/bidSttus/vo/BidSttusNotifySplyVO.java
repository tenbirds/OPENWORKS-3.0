/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bidSttus.vo;

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
public class BidSttusNotifySplyVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

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

    /** 공급자아이디 */
    private String suplerId;

    /** 서비스코드 */
    private String goodsCode;
    
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

    /** 납품-첨부파일 */
    private List<FileVO> splyFileList;

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
     * List<FileVO> splyFileList을 반환
     * @return List<FileVO> splyFileList
     */
    public List<FileVO> getSplyFileList() {
        return splyFileList;
    }

    
    /**
     * splyFileList을 설정
     * @param splyFileList 을(를) List<FileVO> splyFileList로 설정
     */
    public void setSplyFileList(List<FileVO> splyFileList) {
        this.splyFileList = splyFileList;
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

    
    
}
