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
public class TcnNotifySplyVO extends PaggingVO {


    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;

    /** 공고번호 */
    private int notifySeq;

    /** 공급자ID */
    private String userId;

    /** 서비스코드 */
    private String goodsCode;

    /** 확인여부 */
    private String confmGbn;

    /** 답변여부 */
    private String askApplyCd;

    /** 입찰진행상태 */
    private String bidPgesStat;

    /** 선정/낙찰여부 */
    private String bidSussGbn;

    /** 선정일자 */
    private String bidSussDt;

    /** 평가서 */
    private List<FileVO> evalSheetFileList;

    /** 평가서 */
    private int evalSheetFile;

    /** 계약여부 */
    private String cntrGbn;

    /** 공급가 */
    private String splyAmt;

    /** VAT 여부 */
    private String vatGbn;

    /** 추가답변 */
    private String addAnswer;

    /** 비고 */
    private String splyNote;

    /** 납품-첨부파일 */
    private List<FileVO> splyFileList;

    /** 납품-첨부파일 */
    private int splyFile;

    /** 완료일시 */
    private String entrDt;

    
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
     * String askApplyCd을 반환
     * @return String askApplyCd
     */
    public String getAskApplyCd() {
        return askApplyCd;
    }

    
    /**
     * askApplyCd을 설정
     * @param askApplyCd 을(를) String askApplyCd로 설정
     */
    public void setAskApplyCd(String askApplyCd) {
        this.askApplyCd = askApplyCd;
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
     * String splyAmt을 반환
     * @return String splyAmt
     */
    public String getSplyAmt() {
        return splyAmt;
    }

    
    /**
     * splyAmt을 설정
     * @param splyAmt 을(를) String splyAmt로 설정
     */
    public void setSplyAmt(String splyAmt) {
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
