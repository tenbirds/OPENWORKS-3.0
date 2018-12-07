/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.wish.myWish;

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
public class MyWishVO extends PaggingVO {


    /**  */
    private static final long serialVersionUID = -3120224496733753666L;

    private String logSeq;                 /** 이용희망목록 일련번호 */
    private String userId;                 /** 사용자아이디 */    
    private String userNm;                 /** 사용자이름 */    
    private String langCode;               /** 언어코드 */    
    private List<String> langCodes;        /** 언어코드 배열 */    
    private String langNm;                 /** 언어이름 */    
    private String goodsTyNm;              /** 서비스뷴류체계*/    
    private String goodsCd;                /** 서비스코드 */    
    private String goodsCd2;               /** 서비스코드복수 */    
    private List<String> goodsCodeList;    /** 서비스코드 배열*/    
    private String goodsNm;                /** 서비스이름 */    
    private String beginDate;              /** 시작일짜 */    
    private String endDate;                /** 종료일짜 */    
    private String auditlogNm;             /** 사업명 */    
    private String srcDt;                  /** 적용일 */    
    private Integer grpSeq;                /** 그룹번호 */
    private String selChk;                 /** 선택여부 */
    private String regDt;                  /** 희망목록 등록일 */
    private String langStoreNm;            /** 상점이름 */
    private String filterCon;              /** 필터조건 */
    private String ctgryCode;              /** 카테고리 */
    private String keyWord;                /** 검색어 */  
    private String goodsTyCd;              /** 서비스 대분류  */
    private String langStoreUserId;        /** 공급자ID */
    private String confrmChk;              /** 확정여부 */
    private String confrmDt;               /** 확정일자 */
    private String confrmChkN;             /** 공급자로부터 답변이 없는건의 건수 */
    private String goodsConfrmYn;          /** 서비스 확정여부 */
    private String entrDt;                 /** 공급자로부터 답변일자 */
    private String splyAmt;    
    private String splyAmt_detail;
    private String contrctChk;             /** 계약확정여부 */
    private String contrctDt;              /** 계약확정일자 */
    
    private String notifyNum;              /** 공시번호 */
    private int notifySeq;                 /** 공시일련번호 */
    private String suplerId;               /** 제공자id */
    
    /**  */
    private Integer hopePuchAmt;
    
    private Integer splyLen;
    
    
    
    /**
     * String logSeq을 반환
     * @return String logSeq
     */
    public String getLogSeq() {
        return logSeq;
    }

    /**
     * logSeq을 설정
     * @param logSeq 을(를) String logSeq로 설정
     */
    public void setLogSeq(String logSeq) {
        this.logSeq = logSeq;
    }



    /**
     * Integer hopePuchAmt을 반환
     * @return Integer hopePuchAmt
     */
    public Integer getHopePuchAmt() {
        return hopePuchAmt;
    }


    
    /**
     * hopePuchAmt을 설정
     * @param hopePuchAmt 을(를) Integer hopePuchAmt로 설정
     */
    public void setHopePuchAmt(Integer hopePuchAmt) {
        this.hopePuchAmt = hopePuchAmt;
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
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }
    
    
    /**
     * String goodsTyNm을 반환
     * @return String goodsTyNm
     */
    public String getGoodsTyNm() {
        return goodsTyNm;
    }


    
    /**
     * goodsTyNm을 설정
     * @param goodsTyNm 을(를) String goodsTyNm로 설정
     */
    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }


    /**
     * String goodsCd을 반환
     * @return String goodsCd
     */
    public String getGoodsCd() {
        return goodsCd;
    }

    
    /**
     * goodsCd을 설정
     * @param goodsCd 을(를) String goodsCd로 설정
     */
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }
    

    /**
     * String goodsCd2을 반환
     * @return String goodsCd2
     */
    public String getGoodsCd2() {
        return goodsCd2;
    }
    
    /**
     * goodsCd2을 설정
     * @param goodsCd2 을(를) String goodsCd2로 설정
     */
    public void setGoodsCd2(String goodsCd2) {
        this.goodsCd2 = goodsCd2;
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
     * String beginDate을 반환
     * @return String beginDate
     */
    public String getBeginDate() {
        return beginDate;
    }

    
    /**
     * beginDate을 설정
     * @param beginDate 을(를) String beginDate로 설정
     */
    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    
    /**
     * String endDate을 반환
     * @return String endDate
     */
    public String getEndDate() {
        return endDate;
    }

    
    /**
     * endDate을 설정
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
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
     * String srcDt을 반환
     * @return String srcDt
     */
    public String getSrcDt() {
        return srcDt;
    }

    
    /**
     * srcDt을 설정
     * @param srcDt 을(를) String srcDt로 설정
     */
    public void setSrcDt(String srcDt) {
        this.srcDt = srcDt;
    }

    
    /**
     * Integer grpSeq을 반환
     * @return Integer grpSeq
     */
    public Integer getGrpSeq() {
        return grpSeq;
    }

    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) Integer grpSeq로 설정
     */
    public void setGrpSeq(Integer grpSeq) {
        this.grpSeq = grpSeq;
    }

    
    /**
     * String selChk을 반환
     * @return String selChk
     */
    public String getSelChk() {
        return selChk;
    }

    
    /**
     * selChk을 설정
     * @param selChk 을(를) String selChk로 설정
     */
    public void setSelChk(String selChk) {
        this.selChk = selChk;
    }

    
    /**
     * String regDt을 반환
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * regDt을 설정
     * @param regDt 을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
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
     * String filterCon을 반환
     * @return String filterCon
     */
    public String getFilterCon() {
        return filterCon;
    }

    
    /**
     * filterCon을 설정
     * @param filterCon 을(를) String filterCon로 설정
     */
    public void setFilterCon(String filterCon) {
        this.filterCon = filterCon;
    }

    
    /**
     * String ctgryCode을 반환
     * @return String ctgryCode
     */
    public String getCtgryCode() {
        return ctgryCode;
    }

    
    /**
     * ctgryCode을 설정
     * @param ctgryCode 을(를) String ctgryCode로 설정
     */
    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }

    
    /**
     * String keyWord을 반환
     * @return String keyWord
     */
    public String getKeyWord() {
        return keyWord;
    }

    
    /**
     * keyWord을 설정
     * @param keyWord 을(를) String keyWord로 설정
     */
    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    
    /**
     * String goodsTyCd을 반환
     * @return String goodsTyCd
     */
    public String getGoodsTyCd() {
        return goodsTyCd;
    }

    
    /**
     * goodsTyCd을 설정
     * @param goodsTyCd 을(를) String goodsTyCd로 설정
     */
    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    
    /**
     * String langStoreUserId을 반환
     * @return String langStoreUserId
     */
    public String getLangStoreUserId() {
        return langStoreUserId;
    }

    
    /**
     * langStoreUserId을 설정
     * @param langStoreUserId 을(를) String langStoreUserId로 설정
     */
    public void setLangStoreUserId(String langStoreUserId) {
        this.langStoreUserId = langStoreUserId;
    }

    
    /**
     * String confrmChk을 반환
     * @return String confrmChk
     */
    public String getConfrmChk() {
        return confrmChk;
    }

    
    /**
     * confrmChk을 설정
     * @param confrmChk 을(를) String confrmChk로 설정
     */
    public void setConfrmChk(String confrmChk) {
        this.confrmChk = confrmChk;
    }

    
    /**
     * String confrmDt을 반환
     * @return String confrmDt
     */
    public String getConfrmDt() {
        return confrmDt;
    }

    
    /**
     * confrmDt을 설정
     * @param confrmDt 을(를) String confrmDt로 설정
     */
    public void setConfrmDt(String confrmDt) {
        this.confrmDt = confrmDt;
    }

    /**
     * String confrmChkN을 반환
     * @return String confrmChkN
     */
    public String getConfrmChkN() {
        return confrmChkN;
    }

    /**
     * confrmChkN을 설정
     * @param confrmChkN 을(를) String confrmChkN로 설정
     */
    public void setConfrmChkN(String confrmChkN) {
        this.confrmChkN = confrmChkN;
    }

    /**
     * String goodsConfrmYn을 반환
     * @return String goodsConfrmYn
     */
    public String getGoodsConfrmYn() {
        return goodsConfrmYn;
    }

    
    /**
     * goodsConfrmYn을 설정
     * @param goodsConfrmYn 을(를) String goodsConfrmYn로 설정
     */
    public void setGoodsConfrmYn(String goodsConfrmYn) {
        this.goodsConfrmYn = goodsConfrmYn;
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
     * String splyAmt_detail을 반환
     * @return String splyAmt_detail
     */
    public String getSplyAmt_detail() {
        return splyAmt_detail;
    }

    /**
     * splyAmt_detail을 설정
     * @param splyAmt_detail 을(를) String splyAmt_detail로 설정
     */
    public void setSplyAmt_detail(String splyAmt_detail) {
        this.splyAmt_detail = splyAmt_detail;
    }

    
    /**
     * String contrctChk을 반환
     * @return String contrctChk
     */
    public String getContrctChk() {
        return contrctChk;
    }

    
    /**
     * contrctChk을 설정
     * @param contrctChk 을(를) String contrctChk로 설정
     */
    public void setContrctChk(String contrctChk) {
        this.contrctChk = contrctChk;
    }

    
    /**
     * String contrctDt을 반환
     * @return String contrctDt
     */
    public String getContrctDt() {
        return contrctDt;
    }

    
    /**
     * contrctDt을 설정
     * @param contrctDt 을(를) String contrctDt로 설정
     */
    public void setContrctDt(String contrctDt) {
        this.contrctDt = contrctDt;
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
    public void setNotifySeq(Integer notifySeq) {
        if  (notifySeq!=null) this.notifySeq = notifySeq;
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
     * Integer splyLen을 반환
     * @return Integer splyLen
     */
    public Integer getSplyLen() {
        return splyLen;
    }

    
    /**
     * splyLen을 설정
     * @param splyLen 을(를) Integer splyLen로 설정
     */
    public void setSplyLen(Integer splyLen) {
        this.splyLen = splyLen;
    }

       
}
