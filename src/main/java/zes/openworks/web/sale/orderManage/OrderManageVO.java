/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.orderManage;

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
 *  2014. 11. 14.    이슬버미       신규
 * </pre>
 * @see
 */
public class OrderManageVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 6442679210075642537L;

    /* 신청내용보기 */
    public static final Integer OM_TY_CD_VE = 1002;
    /* 다운로드 */
    public static final Integer OM_TY_CD_DW = 1001;

    /* 컨설팅 */
    public static final Integer OM_MT_CD_CT = 1003;

    /* 언어코드 */
    private String langCd;
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
    private String langEngNm;
    /** 서비스코드 */
    private String goodsCd;
    /** 서비스이름 */
    private String goodsNm;
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
    /** 구매신청,다운로드 여부 */
    private String ordrOx;
    /** 주문확인여부 */
    private String orderCnfirmAt;
    /** 카테고리구분코드 */
    private String ctgryClCd;
    /** 카테고리구분이름 */
    private String ctgryClNm;
    /** 다운로드 URL */
    private String goodsDwldUrl;
    /** 다운로드 이름 */
    private String goodsDwldNm;
    /* 가격 */
    private String goodsPc;
    /**
     * String langEngNm을 반환
     * 
     * @return String langEngNm
     */
    public String getLangEngNm() {
        return langEngNm;
    }

    /**
     * langEngNm을 설정
     * 
     * @param langEngNm 을(를) String langEngNm로 설정
     */
    public void setLangEngNm(String langEngNm) {
        this.langEngNm = langEngNm;
    }

    /**
     * String langCd을 반환
     * 
     * @return String langCd
     */
    public String getLangCd() {
        return langCd;
    }

    /**
     * langCd을 설정
     * 
     * @param langCd 을(를) String langCd로 설정
     */
    public void setLangCd(String langCd) {
        this.langCd = langCd;
    }

    /**
     * String registId을 반환
     * 
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    /**
     * registId을 설정
     * 
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /**
     * List<String> langCodes을 반환
     * 
     * @return List<String> langCodes
     */
    public List<String> getLangCodes() {
        return langCodes;
    }

    /**
     * langCodes을 설정
     * 
     * @param langCodes 을(를) List<String> langCodes로 설정
     */
    public void setLangCodes(List<String> langCodes) {
        this.langCodes = langCodes;
    }

    /**
     * String parntsCtgryCd을 반환
     * 
     * @return String parntsCtgryCd
     */
    public String getParntsCtgryCd() {
        return parntsCtgryCd;
    }

    /**
     * parntsCtgryCd을 설정
     * 
     * @param parntsCtgryCd 을(를) String parntsCtgryCd로 설정
     */
    public void setParntsCtgryCd(String parntsCtgryCd) {
        this.parntsCtgryCd = parntsCtgryCd;
    }

    /**
     * String ctgryDp을 반환
     * 
     * @return String ctgryDp
     */
    public String getCtgryDp() {
        return ctgryDp;
    }

    /**
     * ctgryDp을 설정
     * 
     * @param ctgryDp 을(를) String ctgryDp로 설정
     */
    public void setCtgryDp(String ctgryDp) {
        this.ctgryDp = ctgryDp;
    }

    /**
     * String userId을 반환
     * 
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * userId을 설정
     * 
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * String userNm을 반환
     * 
     * @return String userNm
     */
    public String getUserNm() {
        return userNm;
    }

    /**
     * userNm을 설정
     * 
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    /**
     * String langCode을 반환
     * 
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    /**
     * langCode을 설정
     * 
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    /**
     * String langNm을 반환
     * 
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    /**
     * langNm을 설정
     * 
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    /**
     * String goodsCd을 반환
     * 
     * @return String goodsCd
     */
    public String getGoodsCd() {
        return goodsCd;
    }

    /**
     * goodsCd을 설정
     * 
     * @param goodsCd 을(를) String goodsCd로 설정
     */
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }

    /**
     * String goodsNm을 반환
     * 
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }

    /**
     * goodsNm을 설정
     * 
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    /**
     * String goodsTyCd을 반환
     * 
     * @return String goodsTyCd
     */
    public String getGoodsTyCd() {
        return goodsTyCd;
    }

    /**
     * goodsTyCd을 설정
     * 
     * @param goodsTyCd 을(를) String goodsTyCd로 설정
     */
    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    /**
     * String goodsTyNm을 반환
     * 
     * @return String goodsTyNm
     */
    public String getGoodsTyNm() {
        return goodsTyNm;
    }

    /**
     * goodsTyNm을 설정
     * 
     * @param goodsTyNm 을(를) String goodsTyNm로 설정
     */
    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }

    /**
     * String ctgryCd을 반환
     * 
     * @return String ctgryCd
     */
    public String getCtgryCd() {
        return ctgryCd;
    }

    /**
     * ctgryCd을 설정
     * 
     * @param ctgryCd 을(를) String ctgryCd로 설정
     */
    public void setCtgryCd(String ctgryCd) {
        this.ctgryCd = ctgryCd;
    }

    /**
     * String ctgryNm을 반환
     * 
     * @return String ctgryNm
     */
    public String getCtgryNm() {
        return ctgryNm;
    }

    /**
     * ctgryNm을 설정
     * 
     * @param ctgryNm 을(를) String ctgryNm로 설정
     */
    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }

    /**
     * Integer sleMthdCd을 반환
     * 
     * @return Integer sleMthdCd
     */
    public Integer getSleMthdCd() {
        return sleMthdCd;
    }

    /**
     * sleMthdCd을 설정
     * 
     * @param sleMthdCd 을(를) Integer sleMthdCd로 설정
     */
    public void setSleMthdCd(Integer sleMthdCd) {
        this.sleMthdCd = sleMthdCd;
    }

    /**
     * String sleMthdNm을 반환
     * 
     * @return String sleMthdNm
     */
    public String getSleMthdNm() {
        return sleMthdNm;
    }

    /**
     * sleMthdNm을 설정
     * 
     * @param sleMthdNm 을(를) String sleMthdNm로 설정
     */
    public void setSleMthdNm(String sleMthdNm) {
        this.sleMthdNm = sleMthdNm;
    }

    /**
     * String beginDate을 반환
     * 
     * @return String beginDate
     */
    public String getBeginDate() {
        return beginDate;
    }

    /**
     * beginDate을 설정
     * 
     * @param beginDate 을(를) String beginDate로 설정
     */
    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    /**
     * String endDate을 반환
     * 
     * @return String endDate
     */
    public String getEndDate() {
        return endDate;
    }

    /**
     * endDate을 설정
     * 
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    /**
     * String orderDt을 반환
     * 
     * @return String orderDt
     */
    public String getOrderDt() {
        return orderDt;
    }

    /**
     * orderDt을 설정
     * 
     * @param orderDt 을(를) String orderDt로 설정
     */
    public void setOrderDt(String orderDt) {
        this.orderDt = orderDt;
    }

    /**
     * String purchsNo을 반환
     * 
     * @return String purchsNo
     */
    public String getPurchsNo() {
        return purchsNo;
    }

    /**
     * purchsNo을 설정
     * 
     * @param purchsNo 을(를) String purchsNo로 설정
     */
    public void setPurchsNo(String purchsNo) {
        this.purchsNo = purchsNo;
    }

    /**
     * String ordrrId을 반환
     * 
     * @return String ordrrId
     */
    public String getOrdrrId() {
        return ordrrId;
    }

    /**
     * ordrrId을 설정
     * 
     * @param ordrrId 을(를) String ordrrId로 설정
     */
    public void setOrdrrId(String ordrrId) {
        this.ordrrId = ordrrId;
    }

    /**
     * String ordrrNm을 반환
     * 
     * @return String ordrrNm
     */
    public String getOrdrrNm() {
        return ordrrNm;
    }

    /**
     * ordrrNm을 설정
     * 
     * @param ordrrNm 을(를) String ordrrNm로 설정
     */
    public void setOrdrrNm(String ordrrNm) {
        this.ordrrNm = ordrrNm;
    }

    /**
     * String storeNm을 반환
     * 
     * @return String storeNm
     */
    public String getStoreNm() {
        return storeNm;
    }

    /**
     * storeNm을 설정
     * 
     * @param storeNm 을(를) String storeNm로 설정
     */
    public void setStoreNm(String storeNm) {
        this.storeNm = storeNm;
    }

    /**
     * String orderCnfirmAt을 반환
     * 
     * @return String orderCnfirmAt
     */
    public String getOrderCnfirmAt() {
        return orderCnfirmAt;
    }

    /**
     * orderCnfirmAt을 설정
     * 
     * @param orderCnfirmAt 을(를) String orderCnfirmAt로 설정
     */
    public void setOrderCnfirmAt(String orderCnfirmAt) {
        this.orderCnfirmAt = orderCnfirmAt;
    }

    /**
     * String ctgryClCd을 반환
     * 
     * @return String ctgryClCd
     */
    public String getCtgryClCd() {
        return ctgryClCd;
    }

    /**
     * ctgryClCd을 설정
     * 
     * @param ctgryClCd 을(를) String ctgryClCd로 설정
     */
    public void setCtgryClCd(String ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }

    /**
     * String ctgryClNm을 반환
     * 
     * @return String ctgryClNm
     */
    public String getCtgryClNm() {
        return ctgryClNm;
    }

    /**
     * ctgryClNm을 설정
     * 
     * @param ctgryClNm 을(를) String ctgryClNm로 설정
     */
    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }

    /**
     * String goodsDwldUrl을 반환
     * 
     * @return String goodsDwldUrl
     */
    public String getGoodsDwldUrl() {
        return goodsDwldUrl;
    }

    /**
     * goodsDwldUrl을 설정
     * 
     * @param goodsDwldUrl 을(를) String goodsDwldUrl로 설정
     */
    public void setGoodsDwldUrl(String goodsDwldUrl) {
        this.goodsDwldUrl = goodsDwldUrl;
    }

    /**
     * String goodsDwldNm을 반환
     * 
     * @return String goodsDwldNm
     */
    public String getGoodsDwldNm() {
        return goodsDwldNm;
    }

    /**
     * goodsDwldNm을 설정
     * 
     * @param goodsDwldNm 을(를) String goodsDwldNm로 설정
     */
    public void setGoodsDwldNm(String goodsDwldNm) {
        this.goodsDwldNm = goodsDwldNm;
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

    /**
     * String ordrOx을 반환
     * @return String ordrOx
     */
    public String getOrdrOx() {
        return ordrOx;
    }

    /**
     * ordrOx을 설정
     * @param ordrOx 을(를) String ordrOx로 설정
     */
    public void setOrdrOx(String ordrOx) {
        this.ordrOx = ordrOx;
    }

    
    
}
