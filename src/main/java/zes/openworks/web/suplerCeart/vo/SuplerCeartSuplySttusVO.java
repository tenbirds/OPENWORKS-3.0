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
public class SuplerCeartSuplySttusVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 언어코드 */
    private String langCode;

    /** 언어코드 배열 */
    private List<String> langCodes;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;
    
    /** 입찰종류여부(2037) */
    private int bidGbnCd;
    
    /** 입찰종류여부명 */
    private String bidGbnNm;
    
    /** 서비스코드 */
    private String goodsCode;
    
    /** 서비스명 */
    private String goodsNm;
    
    /** 공급자ID */
    private String suplerId;
    
    /** 공급자명 */
    private String suplerNm;
    
    /** 수요자ID */
    private String commUserId;
    
    /** 수요자명 */
    private String commUserNm;
    
    /** 실 수요기관 */
    private String realDmndOrgn;
    
    /** 공급가 */
    private Long cntrctamount;
    
    /** 계약기간 시작 */
    private String cntrctBeginDe;
    
    /** 계약기간 종료 */
    private String cntrctEndDe;
    
    /** 서비스조회수 */
    private int goodsRdcnt;
    
    /** 검색구분1(서비스 대분류) */
    private String q_goodsTyCd;
    
    /** 검색구분1(서비스 대분류) */
    private String q_ctgryCd1;
    
    /** 검색구분2(서비스 중분류) */
    private String q_ctgryCd2;
    
    /** 검색구분3(서비스 소분류) */
    private String q_ctgryCd3;
    
    /** 검색어 */
    private String searchKeyWord;
    
    /** 검색 시작일 */
    private String searchStrtDt;
    
    /** 검색 종료일 */
    private String searchEndDt;
    
    /** 순번 */
    private int cntrctSn;

    /** 구매기관 */
    private String purchsInsttNm;
    
    private String cntrNum; //계약번호 
    private String cntrDt; //계약기간
    private String goodsTyNm;
    private String SplyForm;
    private String SplyFormUnit;
    private int serviceCnt;
    
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
     * String suplerNm을 반환
     * @return String suplerNm
     */
    public String getSuplerNm() {
        return suplerNm;
    }

    
    /**
     * suplerNm을 설정
     * @param suplerNm 을(를) String suplerNm로 설정
     */
    public void setSuplerNm(String suplerNm) {
        this.suplerNm = suplerNm;
    }

    
    /**
     * String commUserId을 반환
     * @return String commUserId
     */
    public String getCommUserId() {
        return commUserId;
    }

    
    /**
     * commUserId을 설정
     * @param commUserId 을(를) String commUserId로 설정
     */
    public void setCommUserId(String commUserId) {
        this.commUserId = commUserId;
    }

    
    /**
     * String commUserNm을 반환
     * @return String commUserNm
     */
    public String getCommUserNm() {
        return commUserNm;
    }

    
    /**
     * commUserNm을 설정
     * @param commUserNm 을(를) String commUserNm로 설정
     */
    public void setCommUserNm(String commUserNm) {
        this.commUserNm = commUserNm;
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
     * int cntrctamount을 반환
     * @return int cntrctamount
     */
    public Long getCntrctamount() {
        return cntrctamount;
    }

    
    /**
     * cntrctamount을 설정
     * @param cntrctamount 을(를) int cntrctamount로 설정
     */
    public void setCntrctamount(Long cntrctamount) {
        this.cntrctamount = cntrctamount;
    }

    
    /**
     * String cntrctBeginDe을 반환
     * @return String cntrctBeginDe
     */
    public String getCntrctBeginDe() {
        return cntrctBeginDe;
    }

    
    /**
     * cntrctBeginDe을 설정
     * @param cntrctBeginDe 을(를) String cntrctBeginDe로 설정
     */
    public void setCntrctBeginDe(String cntrctBeginDe) {
        this.cntrctBeginDe = cntrctBeginDe;
    }

    
    /**
     * String cntrctEndDe을 반환
     * @return String cntrctEndDe
     */
    public String getCntrctEndDe() {
        return cntrctEndDe;
    }

    
    /**
     * cntrctEndDe을 설정
     * @param cntrctEndDe 을(를) String cntrctEndDe로 설정
     */
    public void setCntrctEndDe(String cntrctEndDe) {
        this.cntrctEndDe = cntrctEndDe;
    }

    
    /**
     * int goodsRdcnt을 반환
     * @return int goodsRdcnt
     */
    public int getGoodsRdcnt() {
        return goodsRdcnt;
    }

    
    /**
     * goodsRdcnt을 설정
     * @param goodsRdcnt 을(를) int goodsRdcnt로 설정
     */
    public void setGoodsRdcnt(int goodsRdcnt) {
        this.goodsRdcnt = goodsRdcnt;
    }

    
    /**
     * String q_goodsTyCd을 반환
     * @return String q_goodsTyCd
     */
    public String getQ_goodsTyCd() {
        return q_goodsTyCd;
    }

    
    /**
     * q_goodsTyCd을 설정
     * @param q_goodsTyCd 을(를) String q_goodsTyCd로 설정
     */
    public void setQ_goodsTyCd(String q_goodsTyCd) {
        this.q_goodsTyCd = q_goodsTyCd;
    }

    
    /**
     * String q_ctgryCd1을 반환
     * @return String q_ctgryCd1
     */
    public String getQ_ctgryCd1() {
        return q_ctgryCd1;
    }

    
    /**
     * q_ctgryCd1을 설정
     * @param q_ctgryCd1 을(를) String q_ctgryCd1로 설정
     */
    public void setQ_ctgryCd1(String q_ctgryCd1) {
        this.q_ctgryCd1 = q_ctgryCd1;
    }

    
    /**
     * String q_ctgryCd2을 반환
     * @return String q_ctgryCd2
     */
    public String getQ_ctgryCd2() {
        return q_ctgryCd2;
    }

    
    /**
     * q_ctgryCd2을 설정
     * @param q_ctgryCd2 을(를) String q_ctgryCd2로 설정
     */
    public void setQ_ctgryCd2(String q_ctgryCd2) {
        this.q_ctgryCd2 = q_ctgryCd2;
    }

    
    /**
     * String q_ctgryCd3을 반환
     * @return String q_ctgryCd3
     */
    public String getQ_ctgryCd3() {
        return q_ctgryCd3;
    }

    
    /**
     * q_ctgryCd3을 설정
     * @param q_ctgryCd3 을(를) String q_ctgryCd3로 설정
     */
    public void setQ_ctgryCd3(String q_ctgryCd3) {
        this.q_ctgryCd3 = q_ctgryCd3;
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
     * String searchStrtDt을 반환
     * @return String searchStrtDt
     */
    public String getSearchStrtDt() {
        return searchStrtDt;
    }

    
    /**
     * searchStrtDt을 설정
     * @param searchStrtDt 을(를) String searchStrtDt로 설정
     */
    public void setSearchStrtDt(String searchStrtDt) {
        this.searchStrtDt = searchStrtDt;
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
     * int cntrctSn을 반환
     * @return int cntrctSn
     */
    public int getCntrctSn() {
        return cntrctSn;
    }


    
    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) int cntrctSn로 설정
     */
    public void setCntrctSn(int cntrctSn) {
        this.cntrctSn = cntrctSn;
    }
    
    
    /**
     * String purchsInsttNm을 반환
     * @return String purchsInsttNm
     */
    public String getPurchsInsttNm() {
        return purchsInsttNm;
    }


    
    /**
     * purchsInsttNm을 설정
     * @param purchsInsttNm 을(를) String purchsInsttNm로 설정
     */
    public void setPurchsInsttNm(String purchsInsttNm) {
        this.purchsInsttNm = purchsInsttNm;
    }


    /**
     * String cntrNum을 반환
     * @return String cntrNum
     */
    public String getCntrNum() {
        return cntrNum;
    }


    /**
     * cntrNum을 설정
     * @param cntrNum 을(를) String cntrNum로 설정
     */
    public void setCntrNum(String cntrNum) {
        this.cntrNum = cntrNum;
    }

    /**
     * String cntrDt을 반환
     * @return String cntrDt
     */
    public String getCntrDt() {
        return cntrDt;
    }
    
    /**
     * cntrDt을 설정
     * @param cntrDt 을(를) String cntrDt로 설정
     */
    public void setCntrDt(String cntrDt) {
        this.cntrDt = cntrDt;
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
     * String splyForm을 반환
     * @return String splyForm
     */
    public String getSplyForm() {
        return SplyForm;
    }


    
    /**
     * splyForm을 설정
     * @param splyForm 을(를) String splyForm로 설정
     */
    public void setSplyForm(String splyForm) {
        SplyForm = splyForm;
    }


    
    /**
     * String splyFormUnit을 반환
     * @return String splyFormUnit
     */
    public String getSplyFormUnit() {
        return SplyFormUnit;
    }

    /**
     * splyFormUnit을 설정
     * @param splyFormUnit 을(를) String splyFormUnit로 설정
     */
    public void setSplyFormUnit(String splyFormUnit) {
        SplyFormUnit = splyFormUnit;
    }


    
    /**
     * int serviceCnt을 반환
     * @return int serviceCnt
     */
    public int getServiceCnt() {
        return serviceCnt;
    }


    
    /**
     * serviceCnt을 설정
     * @param serviceCnt 을(를) int serviceCnt로 설정
     */
    public void setServiceCnt(int serviceCnt) {
        this.serviceCnt = serviceCnt;
    }
    
}
