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
public class MyCeartTenderVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;

    /** 수요자ID */
    private String endsUserId;

    /** 공급자ID */
    private String userId;

    /** 공급자명 */
    private String langStoreNm;

    /** 공급자 사업자번호 */
    private String bizrno;
    
    /** 서비스코드 */
    private String goodsCode;
    
    /** 서비스명 */
    private String goodsName;
    
    /** 확인여부 */
    private String confmGbn;
    
    /** 답변여부(2043) */
    private int askApplyCd;
    
    /** 답변여부명 */
    private String askApplyNm;
    
    /** 입찰진행상태(2044) */
    private int bidPgesStat;
    
    /** 입찰진행상태명 */
    private String bidPgesStatNm;
    
    /** 선정/낙찰 여부 */
    private String bidSussGbn;
    
    /** 선정날짜 */
    private String bidSussDt;    
    
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
    
    /** 납품-첨부파일 실 파일명 */
    private String splytFileOrgNm;

    /** 납품-첨부파일 파일ID(OP_FILE테이블 참조) */
    private String splyFileId;
    
    /** 납품-첨부파일 파일명 Size */
    private String splyFileSize;
    
    /** 납품-첨부파일 파일명 Type */
    private String splyFileTy; 

    /** 납품-첨부파일 */
    private List<FileVO> splyFileList;
    
    /** 완료일시 */
    private String bidEntrDt;
    
    /** 체결완료여부 */
    private String bidFinishGbn;
    
    /** 사유 */
    private String evalCause;

    /** 낙찰순위 */
    private int bidRank;
    
    /** 낙찰등록일 */
    private String sussEntrDt;
    
    /** 입찰진행상태에 따른 사유 */
    private String bidChngCause;

    /** 집행관 */
    private String baffNm;
    
    /** 개찰일자 */
    private String realOpenDt;
    
    /** 개찰시간 */
    private String realOpenTm;

    
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
     * String splytFileOrgNm을 반환
     * @return String splytFileOrgNm
     */
    public String getSplytFileOrgNm() {
        return splytFileOrgNm;
    }

    
    /**
     * splytFileOrgNm을 설정
     * @param splytFileOrgNm 을(를) String splytFileOrgNm로 설정
     */
    public void setSplytFileOrgNm(String splytFileOrgNm) {
        this.splytFileOrgNm = splytFileOrgNm;
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
     * String bidEntrDt을 반환
     * @return String bidEntrDt
     */
    public String getBidEntrDt() {
        return bidEntrDt;
    }

    
    /**
     * bidEntrDt을 설정
     * @param bidEntrDt 을(를) String bidEntrDt로 설정
     */
    public void setBidEntrDt(String bidEntrDt) {
        this.bidEntrDt = bidEntrDt;
    }

    
    /**
     * String bidFinishGbn을 반환
     * @return String bidFinishGbn
     */
    public String getBidFinishGbn() {
        return bidFinishGbn;
    }

    
    /**
     * bidFinishGbn을 설정
     * @param bidFinishGbn 을(를) String bidFinishGbn로 설정
     */
    public void setBidFinishGbn(String bidFinishGbn) {
        this.bidFinishGbn = bidFinishGbn;
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

    
    /**
     * int bidRank을 반환
     * @return int bidRank
     */
    public int getBidRank() {
        return bidRank;
    }

    
    /**
     * bidRank을 설정
     * @param bidRank 을(를) int bidRank로 설정
     */
    public void setBidRank(int bidRank) {
        this.bidRank = bidRank;
    }

    
    /**
     * String sussEntrDt을 반환
     * @return String sussEntrDt
     */
    public String getSussEntrDt() {
        return sussEntrDt;
    }

    
    /**
     * sussEntrDt을 설정
     * @param sussEntrDt 을(를) String sussEntrDt로 설정
     */
    public void setSussEntrDt(String sussEntrDt) {
        this.sussEntrDt = sussEntrDt;
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

}
