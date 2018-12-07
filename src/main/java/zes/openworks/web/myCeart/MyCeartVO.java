/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart;

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
public class MyCeartVO extends PaggingVO {

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

    /** 사용자아이디-수요자 */
    private String userId;

    /** 구매희망목록순번 */
    private int grpSeq;
    
    /** 사업명 */
    private String auditlogNm;
    
    /** 사용자아이디-공급자 */
    private String langStoreId;
    
    /** 사용자명-공급자 */
    private String langStoreNm;
    
    /** 서비스코드 */
    private String goodsCode;
    
    /** 서비스명 */
    private String goodsNm;
    
    /** 서비스종류 */
    private String goodsKndCd;

    /** 완료일시 */
    private String entrDt;
    
    /** 마감일시 */
    private String clseDt;
    
    /** 응답완료일 */
    private String rplyDt;

    /** 응답완료 초과여부-견적선정 가능여부 */
    private String rplyDtYn;

    /** 답변여부코드 */
    private String askApplyCd;
    
    /** 답변여부명 */
    private String askApplyNm;
    
    /** 계약여부 */
    private String cntrGbn;
    
    /** 계약여부명 */
    private String cntrGbnNm;

    /** 선정/낙찰여부 */
    private String bidSussGbn;
    
    /** 선정/낙찰여부 */
    private String bidSussGbnNm;
    
    /** 조회조건1 */
    private String searchDiv01;
    
    /** 조회조건2 */
    private String searchDiv02;
    
    /** 조회 Text */
    private String searchKeyWord;

    /** 평가서-첨부파일 */
    private int evalSheetFile;
    
    /** 평가서-첨부파일 */
    private List<FileVO> evalSheetFileList;

    /** 선정날짜 */
    private String bidSussDt;

    /** 입찰진행상태 */
    private String bidPgesStat;

    /** 평가서 원본 파일명 */
    private String evalSheetFileOrginlNm;

    /** 완료요청 여부 */
    private String bidFinishGbn;

    /** 공급자 완료일시 */
    private String splyEntrDt;

    
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
     * int grpSeq을 반환
     * @return int grpSeq
     */
    public int getGrpSeq() {
        return grpSeq;
    }

    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) int grpSeq로 설정
     */
    public void setGrpSeq(int grpSeq) {
        this.grpSeq = grpSeq;
    }

    
    /**
     * String auditlogNm을 반환
     * @return String auditlogNm
     */
    public String getAuditlogNm() {
        return auditlogNm;
    }

    
    /**
     * auditlogNm을 설정
     * @param auditlogNm 을(를) String auditlogNm로 설정
     */
    public void setAuditlogNm(String auditlogNm) {
        this.auditlogNm = auditlogNm;
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
     * String rplyDtYn을 반환
     * @return String rplyDtYn
     */
    public String getRplyDtYn() {
        return rplyDtYn;
    }

    
    /**
     * rplyDtYn을 설정
     * @param rplyDtYn 을(를) String rplyDtYn로 설정
     */
    public void setRplyDtYn(String rplyDtYn) {
        this.rplyDtYn = rplyDtYn;
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
     * String cntrGbnNm을 반환
     * @return String cntrGbnNm
     */
    public String getCntrGbnNm() {
        return cntrGbnNm;
    }

    
    /**
     * cntrGbnNm을 설정
     * @param cntrGbnNm 을(를) String cntrGbnNm로 설정
     */
    public void setCntrGbnNm(String cntrGbnNm) {
        this.cntrGbnNm = cntrGbnNm;
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
     * String bidSussGbnNm을 반환
     * @return String bidSussGbnNm
     */
    public String getBidSussGbnNm() {
        return bidSussGbnNm;
    }

    
    /**
     * bidSussGbnNm을 설정
     * @param bidSussGbnNm 을(를) String bidSussGbnNm로 설정
     */
    public void setBidSussGbnNm(String bidSussGbnNm) {
        this.bidSussGbnNm = bidSussGbnNm;
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
     * String evalSheetFileOrginlNm을 반환
     * @return String evalSheetFileOrginlNm
     */
    public String getEvalSheetFileOrginlNm() {
        return evalSheetFileOrginlNm;
    }

    
    /**
     * evalSheetFileOrginlNm을 설정
     * @param evalSheetFileOrginlNm 을(를) String evalSheetFileOrginlNm로 설정
     */
    public void setEvalSheetFileOrginlNm(String evalSheetFileOrginlNm) {
        this.evalSheetFileOrginlNm = evalSheetFileOrginlNm;
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
     * String splyEntrDt을 반환
     * @return String splyEntrDt
     */
    public String getSplyEntrDt() {
        return splyEntrDt;
    }

    
    /**
     * splyEntrDt을 설정
     * @param splyEntrDt 을(를) String splyEntrDt로 설정
     */
    public void setSplyEntrDt(String splyEntrDt) {
        this.splyEntrDt = splyEntrDt;
    }

}
