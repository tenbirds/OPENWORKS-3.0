/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCertif;

import zes.base.vo.PaggingVO;

/** *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2017. 11. 24.    SKYOU      신규
 * </pre> rou_issu_service_i (이용실적증명서발급내역)
 * @see
 */
public class MyCertifGoodsVO extends PaggingVO {
    
    static final long serialVersionUID = 5550561918037642268L;
    
    private int rouSvcSn;           //이용실적증명서발급 일렴번호 
    private int rouSn;              //발급신청번호 
    private int cntrctSvcSn;        //서비스발금신청번호 
    private String[] cntrctSvcSns;    
   
    /*리스트용*/
    private String cntrctSn;            /*계약서번호*/
    private String svcNm;               /*사업명*/
    private String goodsCode;
    private String goodsNm;
    private String goodsTyNm;
    private String suplerStoreNm;
    private String cntrDt;
    private String cntrctEndDe;
    private String cntrctBeginDe;
    private String ctrtcSnId;           /*계약서파일*/ 
    private int cntrctCount; 
    private double cntrctAmount;
    private int serviceCnt;
    private String commUserId;
    private String sportAt;
    
    private String searchDiv01;     /** 조회조건1 */
    private String searchDiv02;     /** 조회조건2 */
    private String searchKeyWord;   /** 조회 Text */
    
    private String splyFromPeriod;  /*계약기간*/
    private String rlCntrctInsttAt; /*실제 계약 이용 요부  N:계약기간, Y:이용기관*/
    private String cmpnyNm; /*제공기관 필드 추가*/
    
    private String commonBuseoCode;
    
    /**
     * String cmpnyNm을 반환
     * @return String cmpnyNm
     */
    public String getCmpnyNm() {
        return cmpnyNm;
    }

    
    /**
     * cmpnyNm을 설정
     * @param cmpnyNm 을(를) String cmpnyNm로 설정
     */
    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    /**
     * int rouSvcSn을 반환
     * @return int rouSvcSn
     */
    public int getRouSvcSn() {
        return rouSvcSn;
    }
    
    /**
     * rouSvcSn을 설정
     * @param rouSvcSn 을(를) int rouSvcSn로 설정
     */
    public void setRouSvcSn(int rouSvcSn) {
        this.rouSvcSn = rouSvcSn;
    }
    
    /**
     * int rouSn을 반환
     * @return int rouSn
     */
    public int getRouSn() {
        return rouSn;
    }
    
    /**
     * rouSn을 설정
     * @param rouSn 을(를) int rouSn로 설정
     */
    public void setRouSn(int rouSn) {
        this.rouSn = rouSn;
    }
    
    /**
     * String cntrctSn을 반환
     * @return String cntrctSn
     */
    public String getCntrctSn() {
        return cntrctSn;
    }

    
    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) String cntrctSn로 설정
     */
    public void setCntrctSn(String cntrctSn) {
        this.cntrctSn = cntrctSn;
    }

    /**
     * int cntrctSvcSn을 반환
     * @return int cntrctSvcSn
     */
    public int getCntrctSvcSn() {
        return cntrctSvcSn;
    }

    
    /**
     * cntrctSvcSn을 설정
     * @param cntrctSvcSn 을(를) int cntrctSvcSn로 설정
     */
    public void setCntrctSvcSn(int cntrctSvcSn) {
        this.cntrctSvcSn = cntrctSvcSn;
    }

    
    /**
     * String[] cntrctSvcSns을 반환
     * @return String[] cntrctSvcSns
     */
    public String[] getCntrctSvcSns() {
        return cntrctSvcSns;
    }

    
    /**
     * cntrctSvcSns을 설정
     * @param cntrctSvcSns 을(를) String[] cntrctSvcSns로 설정
     */
    public void setCntrctSvcSns(String[] cntrctSvcSns) {
        this.cntrctSvcSns = cntrctSvcSns;
    }
    
    /**
     * String svcNm을 반환
     * @return String svcNm
     */
    public String getSvcNm() {
        return svcNm;
    }

    
    /**
     * svcNm을 설정
     * @param svcNm 을(를) String svcNm로 설정
     */
    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }
    
    /**
     * long serialversionuid을 반환
     * @return long serialversionuid
     */
    public static long getSerialversionuid() {
        return serialVersionUID;
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
     * String suplerStoreNm을 반환
     * @return String suplerStoreNm
     */
    public String getSuplerStoreNm() {
        return suplerStoreNm;
    }
    
    /**
     * suplerStoreNm을 설정
     * @param suplerStoreNm 을(를) String suplerStoreNm로 설정
     */
    public void setSuplerStoreNm(String suplerStoreNm) {
        this.suplerStoreNm = suplerStoreNm;
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
     * String cntrctEndDe을 반환
     * @return String cntrctEndDe
     */
    public String getCntrctEndDe() {
        return cntrctEndDe;
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
     * cntrctEndDe을 설정
     * @param cntrctEndDe 을(를) String cntrctEndDe로 설정
     */
    public void setCntrctEndDe(String cntrctEndDe) {
        this.cntrctEndDe = cntrctEndDe;
    }
    
    /**
     * String ctrtcSnId을 반환
     * @return String ctrtcSnId
     */
    public String getCtrtcSnId() {
        return ctrtcSnId;
    }

    
    /**
     * ctrtcSnId을 설정
     * @param ctrtcSnId 을(를) String ctrtcSnId로 설정
     */
    public void setCtrtcSnId(String ctrtcSnId) {
        this.ctrtcSnId = ctrtcSnId;
    }

    /**
     * int cntrctCount을 반환
     * @return int cntrctCount
     */
    public int getCntrctCount() {
        return cntrctCount;
    }
    
    /**
     * cntrctCount을 설정
     * @param cntrctCount 을(를) int cntrctCount로 설정
     */
    public void setCntrctCount(int cntrctCount) {
        this.cntrctCount = cntrctCount;
    }
    
    
    /**
     * double cntrctAmount을 반환
     * @return double cntrctAmount
     */
    public double getCntrctAmount() {
        return cntrctAmount;
    }

    
    /**
     * cntrctAmount을 설정
     * @param cntrctAmount 을(를) double cntrctAmount로 설정
     */
    public void setCntrctAmount(double cntrctAmount) {
        this.cntrctAmount = cntrctAmount;
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
     * String sportAt을 반환
     * @return String sportAt
     */
    public String getSportAt() {
        return sportAt;
    }

    
    /**
     * sportAt을 설정
     * @param sportAt 을(를) String sportAt로 설정
     */
    public void setSportAt(String sportAt) {
        this.sportAt = sportAt;
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
     * String splyFromPeriod을 반환
     * @return String splyFromPeriod
     */
    public String getSplyFromPeriod() {
        return splyFromPeriod;
    }
    
    /**
     * splyFromPeriod을 설정
     * @param splyFromPeriod 을(를) String splyFromPeriod로 설정
     */
    public void setSplyFromPeriod(String splyFromPeriod) {
        this.splyFromPeriod = splyFromPeriod;
    }

    
    /**
     * String rlCntrctInsttAt을 반환
     * @return String rlCntrctInsttAt
     */
    public String getRlCntrctInsttAt() {
        return rlCntrctInsttAt;
    }

    
    /**
     * rlCntrctInsttAt을 설정
     * @param rlCntrctInsttAt 을(를) String rlCntrctInsttAt로 설정
     */
    public void setRlCntrctInsttAt(String rlCntrctInsttAt) {
        this.rlCntrctInsttAt = rlCntrctInsttAt;
    }


    /**
     * String commonBuseoCode을 반환
     * @return String commonBuseoCode
     */
    public String getCommonBuseoCode() {
        return commonBuseoCode;
    }


    /**
     * commonBuseoCode을 설정
     * @param commonBuseoCode 을(를) String commonBuseoCode로 설정
     */
    public void setCommonBuseoCode(String commonBuseoCode) {
        this.commonBuseoCode = commonBuseoCode;
    }

    
}
