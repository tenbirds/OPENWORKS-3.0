/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myGoods;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

public class MyGoodsVO extends PaggingVO {

    private static final long serialVersionUID = -101271876633700444L;
    /* 신청내용보기 */
    public static final Integer OM_TY_CD_VE = 1001;
    /* 다운로드 */
    public static final Integer OM_TY_CD_DW = 1002;
    /* 컨설팅 */
    public static final Integer OM_MT_CD_CT = 1003;

    /** 판매자아이디 */
    private String registId;
    /** 사용자아이디 */
    private String userId;
    /** 사용자아이디 */
    private String userNm;
    /** 언어코드 */
    private String langCode;
    /** 언어코드 배열 */
    private List<String> langCodes;
    /** 언어이름 */
    private String langNm;
    /** 서비스코드 */
    private String goodsCode;
    /** 서비스이름 */
    private String goodsNm;
    /** 서비스가격 */
    private String goodsPc;
    /** 서비스구분코드 */
    private String goodsTyCd;
    /** 서비스구분이름 */
    private String goodsTyNm;
    /** 카테고리코드 */
    private String ctgryCd;
    /** 카테고리 이름 */
    private String ctgryNm;
    /** 판매방식코드 */
    private Integer sleMthdCd;
    /** 판매방식이름 */
    private String sleMthdNm;
    /** 시작일짜 */
    private String beginDate;
    /** 종료일짜 */
    private String endDate;
    /** 카테고리 부서코드 */
    private String parntsCtgryCd;
    /** 카테고리 깊이코드 */
    private String ctgryDp;
    /** 주문일시 */
    private String orderDt;
    /** 주문번호 */
    private String purchsNo;
    /** 주문자아이디 */
    private String ordrrId;
    /** 주문자이름 */
    private String ordrrNm;
    /** 스토어이름 */
    private String storeNm;
    /** 주문확인여부 */
    private String orderCnfirmAt;
    /** 카테고리구분코드 */
    private String ctgryClCd;
    /** 카테고리구분이름 */
    private String ctgryClNm;
    
    private Integer goodsImageFileSeq;
    
    private List<FileVO> imageFile;
    
    /** 커뮤니티아이디 */
    private String cmmntyId;
    
    private String cmpnyNm;
    
    private String sellCnt;
    
    private String evlScore;
    
    private String intrstSetupDt;
    
    private String sellStop;

    private String inqireDt;
    
    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public List<String> getLangCodes() {
        return langCodes;
    }

    public void setLangCodes(List<String> langCodes) {
        this.langCodes = langCodes;
    }

    public String getLangNm() {
        return langNm;
    }

    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    public String getGoodsNm() {
        return goodsNm;
    }

    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    public String getGoodsTyCd() {
        return goodsTyCd;
    }

    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    public String getGoodsTyNm() {
        return goodsTyNm;
    }

    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }

    public String getCtgryCd() {
        return ctgryCd;
    }

    public void setCtgryCd(String ctgryCd) {
        this.ctgryCd = ctgryCd;
    }

    public String getCtgryNm() {
        return ctgryNm;
    }

    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }

    public Integer getSleMthdCd() {
        return sleMthdCd;
    }

    public void setSleMthdCd(Integer sleMthdCd) {
        this.sleMthdCd = sleMthdCd;
    }

    public String getSleMthdNm() {
        return sleMthdNm;
    }

    public void setSleMthdNm(String sleMthdNm) {
        this.sleMthdNm = sleMthdNm;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getParntsCtgryCd() {
        return parntsCtgryCd;
    }

    public void setParntsCtgryCd(String parntsCtgryCd) {
        this.parntsCtgryCd = parntsCtgryCd;
    }

    public String getCtgryDp() {
        return ctgryDp;
    }

    public void setCtgryDp(String ctgryDp) {
        this.ctgryDp = ctgryDp;
    }

    public String getOrderDt() {
        return orderDt;
    }

    public void setOrderDt(String orderDt) {
        this.orderDt = orderDt;
    }

    public String getPurchsNo() {
        return purchsNo;
    }

    public void setPurchsNo(String purchsNo) {
        this.purchsNo = purchsNo;
    }

    public String getOrdrrId() {
        return ordrrId;
    }

    public void setOrdrrId(String ordrrId) {
        this.ordrrId = ordrrId;
    }

    public String getOrdrrNm() {
        return ordrrNm;
    }

    public void setOrdrrNm(String ordrrNm) {
        this.ordrrNm = ordrrNm;
    }

    public String getStoreNm() {
        return storeNm;
    }

    public void setStoreNm(String storeNm) {
        this.storeNm = storeNm;
    }

    public String getOrderCnfirmAt() {
        return orderCnfirmAt;
    }

    public void setOrderCnfirmAt(String orderCnfirmAt) {
        this.orderCnfirmAt = orderCnfirmAt;
    }

    public String getCtgryClCd() {
        return ctgryClCd;
    }

    public void setCtgryClCd(String ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }

    public String getCtgryClNm() {
        return ctgryClNm;
    }

    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }

    /**
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }

    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }

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
     * List<FileVO> imageFile을 반환
     * @return List<FileVO> imageFile
     */
    public List<FileVO> getImageFile() {
        return imageFile;
    }

    /**
     * imageFile을 설정
     * @param imageFile 을(를) List<FileVO> imageFile로 설정
     */
    public void setImageFile(List<FileVO> imageFile) {
        this.imageFile = imageFile;
    }

    /**
     * Integer goodsImageFileSeq을 반환
     * @return Integer goodsImageFileSeq
     */
    public Integer getGoodsImageFileSeq() {
        return goodsImageFileSeq;
    }

    /**
     * goodsImageFileSeq을 설정
     * @param goodsImageFileSeq 을(를) Integer goodsImageFileSeq로 설정
     */
    public void setGoodsImageFileSeq(Integer goodsImageFileSeq) {
        this.goodsImageFileSeq = goodsImageFileSeq;
    }

    /**
     * String sellCnt을 반환
     * @return String sellCnt
     */
    public String getSellCnt() {
        return sellCnt;
    }

    /**
     * sellCnt을 설정
     * @param sellCnt 을(를) String sellCnt로 설정
     */
    public void setSellCnt(String sellCnt) {
        this.sellCnt = sellCnt;
    }

    /**
     * String evlScore을 반환
     * @return String evlScore
     */
    public String getEvlScore() {
        return evlScore;
    }

    /**
     * evlScore을 설정
     * @param evlScore 을(를) String evlScore로 설정
     */
    public void setEvlScore(String evlScore) {
        this.evlScore = evlScore;
    }

    /**
     * String intrstSetupDt을 반환
     * @return String intrstSetupDt
     */
    public String getIntrstSetupDt() {
        return intrstSetupDt;
    }

    /**
     * intrstSetupDt을 설정
     * @param intrstSetupDt 을(를) String intrstSetupDt로 설정
     */
    public void setIntrstSetupDt(String intrstSetupDt) {
        this.intrstSetupDt = intrstSetupDt;
    }

    /**
     * String sellStop을 반환
     * @return String sellStop
     */
    public String getSellStop() {
        return sellStop;
    }

    /**
     * sellStop을 설정
     * @param sellStop 을(를) String sellStop로 설정
     */
    public void setSellStop(String sellStop) {
        this.sellStop = sellStop;
    }

    /**
     * String inqireDt을 반환
     * @return String inqireDt
     */
    public String getInqireDt() {
        return inqireDt;
    }

    /**
     * inqireDt을 설정
     * @param inqireDt 을(를) String inqireDt로 설정
     */
    public void setInqireDt(String inqireDt) {
        this.inqireDt = inqireDt;
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
     * String goodsPc을 반환
     * @return String goodsPc
     */
    public String getGoodsPc() {
        return goodsPc;
    }

    /**
     * goodsPc을 설정
     * @param goodsPc 을(를) String goodsPc로 설정
     */
    public void setGoodsPc(String goodsPc) {
        this.goodsPc = goodsPc;
    }

   
}
