/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.pop;

import java.util.List;

import zes.base.vo.FileVO;

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
 *  2014. 11. 21.    이슬버미       신규
 * </pre>
 * @see
 */
public class PopVO {

    /**
     * 회원정보
     */
    /* 아이디 */
    private String userId;
    /* 이름 */
    private String userNm;
    /* 유저타입 */
    private String userTyCd;
    /* 유저명 */
    private String userTyNm;
    /* 이메일 */
    private String email;
    /* 휴대폰번호 */
    private String mbtlnum;
    /* 전화번호 */
    private String telno;
    /* 기본주소 */
    private String bassAdres;
    /* 상세주소 */
    private String detailAdres;

    /* 회사명 */
    private String indvdlCmpnyNm;
    /* 회사대표번호 */
    private String indvdlCmpnyReprsntTelno;
    /* 회사대표자명 */
    private String indvdlCmpnyRprsntvNm;
    /* 회사전화번호 */
    private String indvdlCmpnyTelno;
    /* 회사팩스번호 */
    private String indvdlCmpnyFxnum;
    /* 회사이메일 */
    private String indvdlCmpnyEmail;
    /* 회사 URL */
    private String indvdlCmpnyUrl;
    /* 회사 기본 주소 */
    private String indvdlCmpnyBassAdres;
    /* 회사 상세 주소 */
    private String indvdlCmpnyDetailAdres;
    /* 회사 사업자 번호 */
    private String indvdlBizrNo;

    /* 회사명 */
    private String entrprsCmpnyNm;
    /* 회사대표번호 */
    private String entrprsCmpnyReprsntTelno;
    /* 회사대표자명 */
    private String entrprsCmpnyRprsntvNm;
    /* 회사전화번호 */
    private String entrprsCmpnyTelno;
    /* 회사팩스번호 */
    private String entrprsCmpnyFxnum;
    /* 회사이메일 */
    private String entrprsCmpnyEmail;
    /* 회사 URL */
    private String entrprsCmpnyUrl;
    /* 회사 기본 주소 */
    private String entrprsCmpnyBassAdresc;
    /* 회사 상세 주소 */
    private String entrprsCmpnyDetailAdres;
    /* 회사 사업자 번호 */
    private String entrprsBizrNo;

    /* 회사 명 */
    private String pblinsttNm;
    /* 회사 대표 번호 */
    private String pblinsttBizrNo;
    /* 회사 사업자 번호 */
    private String pblinsttTelno;    
    
    /* 스토어 언어별 상정명 */
    private String langStoreNm;
    /* 스토어 언어별 상점소개 */
    private String langStoreIntrcn;
    /* 스토어 담당자 명 */
    private String storeChargerNm;
    /* 스토어 담당자 연락처 */
    private String reprsntTelno;
    /* 스토어 담당자 이메일 */
    private String reprsntEmail;

    /**
     * 신청내용
     */
    private String purchsNo;
    private String orderMbtlnum;
    private String orderEmail;
    private String orderCmpnyReprsntTelno;
    private String orderChargerNm;
    private String orderChargerCttpc;
    private String orderChargerEmail;
    private String orderDlivMssage;
    private String goodsCode;
    private String orderCnfirmAt;

    /**
     * 메타팝업
     */
    private String codeLangCode;
    private Integer codeGroupCd;
    private Integer codeIndvdlzCd;
    private String codeIndvdlzCdNm;
    
    private String metaGoodsCode;
    private String metaLangCd;
    private Integer metaGroupCd;
    private Integer metaIndvdlzCd;
    private Integer metaEtcCn;
    
    private Integer cdStart;
    private Integer cdEnd;
    
    /** 서비스코드 */
    private String goodsCd;   
    /** 서비스명 */
    private String goodsNm;
    private List<FileVO> imageFile;
    /** 서비스개요 */
    private String goodsSumry;
   
    /**
     * 전문가선택 팝업
     */
    
    /**  columnVal1 */
    private String columnVal1;
 
    /** columnVal2 */
    private String columnVal2;
 
    /** columnVal3 */
    private String columnVal3;
 
    
    
    
    /**
     * String pblinsttNm을 반환
     * @return String pblinsttNm
     */
    public String getPblinsttNm() {
        return pblinsttNm;
    }

    
    /**
     * pblinsttNm을 설정
     * @param pblinsttNm 을(를) String pblinsttNm로 설정
     */
    public void setPblinsttNm(String pblinsttNm) {
        this.pblinsttNm = pblinsttNm;
    }

    
    /**
     * String pblinsttBizrNo을 반환
     * @return String pblinsttBizrNo
     */
    public String getPblinsttBizrNo() {
        return pblinsttBizrNo;
    }

    
    /**
     * pblinsttBizrNo을 설정
     * @param pblinsttBizrNo 을(를) String pblinsttBizrNo로 설정
     */
    public void setPblinsttBizrNo(String pblinsttBizrNo) {
        this.pblinsttBizrNo = pblinsttBizrNo;
    }

    
    /**
     * String pblinsttTelno을 반환
     * @return String pblinsttTelno
     */
    public String getPblinsttTelno() {
        return pblinsttTelno;
    }

    
    /**
     * pblinsttTelno을 설정
     * @param pblinsttTelno 을(를) String pblinsttTelno로 설정
     */
    public void setPblinsttTelno(String pblinsttTelno) {
        this.pblinsttTelno = pblinsttTelno;
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
     * String userTyCd을 반환
     * 
     * @return String userTyCd
     */
    public String getUserTyCd() {
        return userTyCd;
    }

    /**
     * userTyCd을 설정
     * 
     * @param userTyCd 을(를) String userTyCd로 설정
     */
    public void setUserTyCd(String userTyCd) {
        this.userTyCd = userTyCd;
    }

    /**
     * String email을 반환
     * 
     * @return String email
     */
    public String getEmail() {
        return email;
    }

    /**
     * email을 설정
     * 
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * String mbtlnum을 반환
     * 
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }

    /**
     * mbtlnum을 설정
     * 
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    /**
     * String telno을 반환
     * 
     * @return String telno
     */
    public String getTelno() {
        return telno;
    }

    /**
     * telno을 설정
     * 
     * @param telno 을(를) String telno로 설정
     */
    public void setTelno(String telno) {
        this.telno = telno;
    }

    /**
     * String indvdlCmpnyNm을 반환
     * 
     * @return String indvdlCmpnyNm
     */
    public String getIndvdlCmpnyNm() {
        return indvdlCmpnyNm;
    }

    /**
     * indvdlCmpnyNm을 설정
     * 
     * @param indvdlCmpnyNm 을(를) String indvdlCmpnyNm로 설정
     */
    public void setIndvdlCmpnyNm(String indvdlCmpnyNm) {
        this.indvdlCmpnyNm = indvdlCmpnyNm;
    }

    /**
     * String indvdlCmpnyReprsntTelno을 반환
     * 
     * @return String indvdlCmpnyReprsntTelno
     */
    public String getIndvdlCmpnyReprsntTelno() {
        return indvdlCmpnyReprsntTelno;
    }

    /**
     * indvdlCmpnyReprsntTelno을 설정
     * 
     * @param indvdlCmpnyReprsntTelno 을(를) String indvdlCmpnyReprsntTelno로 설정
     */
    public void setIndvdlCmpnyReprsntTelno(String indvdlCmpnyReprsntTelno) {
        this.indvdlCmpnyReprsntTelno = indvdlCmpnyReprsntTelno;
    }

    /**
     * String indvdlCmpnyRprsntvNm을 반환
     * 
     * @return String indvdlCmpnyRprsntvNm
     */
    public String getIndvdlCmpnyRprsntvNm() {
        return indvdlCmpnyRprsntvNm;
    }

    /**
     * indvdlCmpnyRprsntvNm을 설정
     * 
     * @param indvdlCmpnyRprsntvNm 을(를) String indvdlCmpnyRprsntvNm로 설정
     */
    public void setIndvdlCmpnyRprsntvNm(String indvdlCmpnyRprsntvNm) {
        this.indvdlCmpnyRprsntvNm = indvdlCmpnyRprsntvNm;
    }

    /**
     * String indvdlCmpnyTelno을 반환
     * 
     * @return String indvdlCmpnyTelno
     */
    public String getIndvdlCmpnyTelno() {
        return indvdlCmpnyTelno;
    }

    /**
     * indvdlCmpnyTelno을 설정
     * 
     * @param indvdlCmpnyTelno 을(를) String indvdlCmpnyTelno로 설정
     */
    public void setIndvdlCmpnyTelno(String indvdlCmpnyTelno) {
        this.indvdlCmpnyTelno = indvdlCmpnyTelno;
    }

    /**
     * String indvdlCmpnyFxnum을 반환
     * 
     * @return String indvdlCmpnyFxnum
     */
    public String getIndvdlCmpnyFxnum() {
        return indvdlCmpnyFxnum;
    }

    /**
     * indvdlCmpnyFxnum을 설정
     * 
     * @param indvdlCmpnyFxnum 을(를) String indvdlCmpnyFxnum로 설정
     */
    public void setIndvdlCmpnyFxnum(String indvdlCmpnyFxnum) {
        this.indvdlCmpnyFxnum = indvdlCmpnyFxnum;
    }

    /**
     * String indvdlCmpnyEmail을 반환
     * 
     * @return String indvdlCmpnyEmail
     */
    public String getIndvdlCmpnyEmail() {
        return indvdlCmpnyEmail;
    }

    /**
     * indvdlCmpnyEmail을 설정
     * 
     * @param indvdlCmpnyEmail 을(를) String indvdlCmpnyEmail로 설정
     */
    public void setIndvdlCmpnyEmail(String indvdlCmpnyEmail) {
        this.indvdlCmpnyEmail = indvdlCmpnyEmail;
    }

    /**
     * String entrprsCmpnyNm을 반환
     * 
     * @return String entrprsCmpnyNm
     */
    public String getEntrprsCmpnyNm() {
        return entrprsCmpnyNm;
    }

    /**
     * entrprsCmpnyNm을 설정
     * 
     * @param entrprsCmpnyNm 을(를) String entrprsCmpnyNm로 설정
     */
    public void setEntrprsCmpnyNm(String entrprsCmpnyNm) {
        this.entrprsCmpnyNm = entrprsCmpnyNm;
    }

    /**
     * String entrprsCmpnyReprsntTelno을 반환
     * 
     * @return String entrprsCmpnyReprsntTelno
     */
    public String getEntrprsCmpnyReprsntTelno() {
        return entrprsCmpnyReprsntTelno;
    }

    /**
     * entrprsCmpnyReprsntTelno을 설정
     * 
     * @param entrprsCmpnyReprsntTelno 을(를) String entrprsCmpnyReprsntTelno로 설정
     */
    public void setEntrprsCmpnyReprsntTelno(String entrprsCmpnyReprsntTelno) {
        this.entrprsCmpnyReprsntTelno = entrprsCmpnyReprsntTelno;
    }

    /**
     * String entrprsCmpnyRprsntvNm을 반환
     * 
     * @return String entrprsCmpnyRprsntvNm
     */
    public String getEntrprsCmpnyRprsntvNm() {
        return entrprsCmpnyRprsntvNm;
    }

    /**
     * entrprsCmpnyRprsntvNm을 설정
     * 
     * @param entrprsCmpnyRprsntvNm 을(를) String entrprsCmpnyRprsntvNm로 설정
     */
    public void setEntrprsCmpnyRprsntvNm(String entrprsCmpnyRprsntvNm) {
        this.entrprsCmpnyRprsntvNm = entrprsCmpnyRprsntvNm;
    }

    /**
     * String entrprsCmpnyTelno을 반환
     * 
     * @return String entrprsCmpnyTelno
     */
    public String getEntrprsCmpnyTelno() {
        return entrprsCmpnyTelno;
    }

    /**
     * entrprsCmpnyTelno을 설정
     * 
     * @param entrprsCmpnyTelno 을(를) String entrprsCmpnyTelno로 설정
     */
    public void setEntrprsCmpnyTelno(String entrprsCmpnyTelno) {
        this.entrprsCmpnyTelno = entrprsCmpnyTelno;
    }

    /**
     * String entrprsCmpnyFxnum을 반환
     * 
     * @return String entrprsCmpnyFxnum
     */
    public String getEntrprsCmpnyFxnum() {
        return entrprsCmpnyFxnum;
    }

    /**
     * entrprsCmpnyFxnum을 설정
     * 
     * @param entrprsCmpnyFxnum 을(를) String entrprsCmpnyFxnum로 설정
     */
    public void setEntrprsCmpnyFxnum(String entrprsCmpnyFxnum) {
        this.entrprsCmpnyFxnum = entrprsCmpnyFxnum;
    }

    /**
     * String entrprsCmpnyEmail을 반환
     * 
     * @return String entrprsCmpnyEmail
     */
    public String getEntrprsCmpnyEmail() {
        return entrprsCmpnyEmail;
    }

    /**
     * entrprsCmpnyEmail을 설정
     * 
     * @param entrprsCmpnyEmail 을(를) String entrprsCmpnyEmail로 설정
     */
    public void setEntrprsCmpnyEmail(String entrprsCmpnyEmail) {
        this.entrprsCmpnyEmail = entrprsCmpnyEmail;
    }

    /**
     * Integer purchsNo을 반환
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
     * String orderMbtlnum을 반환
     * 
     * @return String orderMbtlnum
     */
    public String getOrderMbtlnum() {
        return orderMbtlnum;
    }

    /**
     * orderMbtlnum을 설정
     * 
     * @param orderMbtlnum 을(를) String orderMbtlnum로 설정
     */
    public void setOrderMbtlnum(String orderMbtlnum) {
        this.orderMbtlnum = orderMbtlnum;
    }

    /**
     * String orderEmail을 반환
     * 
     * @return String orderEmail
     */
    public String getOrderEmail() {
        return orderEmail;
    }

    /**
     * orderEmail을 설정
     * 
     * @param orderEmail 을(를) String orderEmail로 설정
     */
    public void setOrderEmail(String orderEmail) {
        this.orderEmail = orderEmail;
    }

    /**
     * String orderCmpnyReprsntTelno을 반환
     * 
     * @return String orderCmpnyReprsntTelno
     */
    public String getOrderCmpnyReprsntTelno() {
        return orderCmpnyReprsntTelno;
    }

    /**
     * orderCmpnyReprsntTelno을 설정
     * 
     * @param orderCmpnyReprsntTelno 을(를) String orderCmpnyReprsntTelno로 설정
     */
    public void setOrderCmpnyReprsntTelno(String orderCmpnyReprsntTelno) {
        this.orderCmpnyReprsntTelno = orderCmpnyReprsntTelno;
    }

    /**
     * String orderChargerNm을 반환
     * 
     * @return String orderChargerNm
     */
    public String getOrderChargerNm() {
        return orderChargerNm;
    }

    /**
     * orderChargerNm을 설정
     * 
     * @param orderChargerNm 을(를) String orderChargerNm로 설정
     */
    public void setOrderChargerNm(String orderChargerNm) {
        this.orderChargerNm = orderChargerNm;
    }

    /**
     * String orderChargerCttpc을 반환
     * 
     * @return String orderChargerCttpc
     */
    public String getOrderChargerCttpc() {
        return orderChargerCttpc;
    }

    /**
     * orderChargerCttpc을 설정
     * 
     * @param orderChargerCttpc 을(를) String orderChargerCttpc로 설정
     */
    public void setOrderChargerCttpc(String orderChargerCttpc) {
        this.orderChargerCttpc = orderChargerCttpc;
    }

    /**
     * String orderChargerEmail을 반환
     * 
     * @return String orderChargerEmail
     */
    public String getOrderChargerEmail() {
        return orderChargerEmail;
    }

    /**
     * orderChargerEmail을 설정
     * 
     * @param orderChargerEmail 을(를) String orderChargerEmail로 설정
     */
    public void setOrderChargerEmail(String orderChargerEmail) {
        this.orderChargerEmail = orderChargerEmail;
    }

    /**
     * String orderDlivMssage을 반환
     * 
     * @return String orderDlivMssage
     */
    public String getOrderDlivMssage() {
        return orderDlivMssage;
    }

    /**
     * orderDlivMssage을 설정
     * 
     * @param orderDlivMssage 을(를) String orderDlivMssage로 설정
     */
    public void setOrderDlivMssage(String orderDlivMssage) {
        this.orderDlivMssage = orderDlivMssage;
    }

    public String getGoodsCode() {
        return goodsCode;
    }

    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
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
     * String userTyNm을 반환
     * 
     * @return String userTyNm
     */
    public String getUserTyNm() {
        return userTyNm;
    }

    /**
     * userTyNm을 설정
     * 
     * @param userTyNm 을(를) String userTyNm로 설정
     */
    public void setUserTyNm(String userTyNm) {
        this.userTyNm = userTyNm;
    }

    /**
     * String indvdlCmpnyUrl을 반환
     * 
     * @return String indvdlCmpnyUrl
     */
    public String getIndvdlCmpnyUrl() {
        return indvdlCmpnyUrl;
    }

    /**
     * indvdlCmpnyUrl을 설정
     * 
     * @param indvdlCmpnyUrl 을(를) String indvdlCmpnyUrl로 설정
     */
    public void setIndvdlCmpnyUrl(String indvdlCmpnyUrl) {
        this.indvdlCmpnyUrl = indvdlCmpnyUrl;
    }

    /**
     * String indvdlCmpnyBassAdres을 반환
     * 
     * @return String indvdlCmpnyBassAdres
     */
    public String getIndvdlCmpnyBassAdres() {
        return indvdlCmpnyBassAdres;
    }

    /**
     * indvdlCmpnyBassAdres을 설정
     * 
     * @param indvdlCmpnyBassAdres 을(를) String indvdlCmpnyBassAdres로 설정
     */
    public void setIndvdlCmpnyBassAdres(String indvdlCmpnyBassAdres) {
        this.indvdlCmpnyBassAdres = indvdlCmpnyBassAdres;
    }

    /**
     * String indvdlCmpnyDetailAdres을 반환
     * 
     * @return String indvdlCmpnyDetailAdres
     */
    public String getIndvdlCmpnyDetailAdres() {
        return indvdlCmpnyDetailAdres;
    }

    /**
     * indvdlCmpnyDetailAdres을 설정
     * 
     * @param indvdlCmpnyDetailAdres 을(를) String indvdlCmpnyDetailAdres로 설정
     */
    public void setIndvdlCmpnyDetailAdres(String indvdlCmpnyDetailAdres) {
        this.indvdlCmpnyDetailAdres = indvdlCmpnyDetailAdres;
    }

    /**
     * String entrprsCmpnyUrl을 반환
     * 
     * @return String entrprsCmpnyUrl
     */
    public String getEntrprsCmpnyUrl() {
        return entrprsCmpnyUrl;
    }

    /**
     * entrprsCmpnyUrl을 설정
     * 
     * @param entrprsCmpnyUrl 을(를) String entrprsCmpnyUrl로 설정
     */
    public void setEntrprsCmpnyUrl(String entrprsCmpnyUrl) {
        this.entrprsCmpnyUrl = entrprsCmpnyUrl;
    }

    /**
     * String entrprsCmpnyBassAdresc을 반환
     * 
     * @return String entrprsCmpnyBassAdresc
     */
    public String getEntrprsCmpnyBassAdresc() {
        return entrprsCmpnyBassAdresc;
    }

    /**
     * entrprsCmpnyBassAdresc을 설정
     * 
     * @param entrprsCmpnyBassAdresc 을(를) String entrprsCmpnyBassAdresc로 설정
     */
    public void setEntrprsCmpnyBassAdresc(String entrprsCmpnyBassAdresc) {
        this.entrprsCmpnyBassAdresc = entrprsCmpnyBassAdresc;
    }

    /**
     * String entrprsCmpnyDetailAdres을 반환
     * 
     * @return String entrprsCmpnyDetailAdres
     */
    public String getEntrprsCmpnyDetailAdres() {
        return entrprsCmpnyDetailAdres;
    }

    /**
     * entrprsCmpnyDetailAdres을 설정
     * 
     * @param entrprsCmpnyDetailAdres 을(를) String entrprsCmpnyDetailAdres로 설정
     */
    public void setEntrprsCmpnyDetailAdres(String entrprsCmpnyDetailAdres) {
        this.entrprsCmpnyDetailAdres = entrprsCmpnyDetailAdres;
    }

    /**
     * String langStoreNm을 반환
     * 
     * @return String langStoreNm
     */
    public String getLangStoreNm() {
        return langStoreNm;
    }

    /**
     * langStoreNm을 설정
     * 
     * @param langStoreNm 을(를) String langStoreNm로 설정
     */
    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    /**
     * String langStoreIntrcn을 반환
     * 
     * @return String langStoreIntrcn
     */
    public String getLangStoreIntrcn() {
        return langStoreIntrcn;
    }

    /**
     * langStoreIntrcn을 설정
     * 
     * @param langStoreIntrcn 을(를) String langStoreIntrcn로 설정
     */
    public void setLangStoreIntrcn(String langStoreIntrcn) {
        this.langStoreIntrcn = langStoreIntrcn;
    }

    /**
     * String storeChargerNm을 반환
     * 
     * @return String storeChargerNm
     */
    public String getStoreChargerNm() {
        return storeChargerNm;
    }

    /**
     * storeChargerNm을 설정
     * 
     * @param storeChargerNm 을(를) String storeChargerNm로 설정
     */
    public void setStoreChargerNm(String storeChargerNm) {
        this.storeChargerNm = storeChargerNm;
    }

    /**
     * String reprsntTelno을 반환
     * 
     * @return String reprsntTelno
     */
    public String getReprsntTelno() {
        return reprsntTelno;
    }

    /**
     * reprsntTelno을 설정
     * 
     * @param reprsntTelno 을(를) String reprsntTelno로 설정
     */
    public void setReprsntTelno(String reprsntTelno) {
        this.reprsntTelno = reprsntTelno;
    }

    /**
     * String reprsntEmail을 반환
     * 
     * @return String reprsntEmail
     */
    public String getReprsntEmail() {
        return reprsntEmail;
    }

    /**
     * reprsntEmail을 설정
     * 
     * @param reprsntEmail 을(를) String reprsntEmail로 설정
     */
    public void setReprsntEmail(String reprsntEmail) {
        this.reprsntEmail = reprsntEmail;
    }

    /**
     * String bassAdres을 반환
     * 
     * @return String bassAdres
     */
    public String getBassAdres() {
        return bassAdres;
    }

    /**
     * bassAdres을 설정
     * 
     * @param bassAdres 을(를) String bassAdres로 설정
     */
    public void setBassAdres(String bassAdres) {
        this.bassAdres = bassAdres;
    }

    /**
     * String detailAdres을 반환
     * 
     * @return String detailAdres
     */
    public String getDetailAdres() {
        return detailAdres;
    }

    /**
     * detailAdres을 설정
     * 
     * @param detailAdres 을(를) String detailAdres로 설정
     */
    public void setDetailAdres(String detailAdres) {
        this.detailAdres = detailAdres;
    }

    /**
     * String indvdlBizrNo을 반환
     * 
     * @return String indvdlBizrNo
     */
    public String getIndvdlBizrNo() {
        return indvdlBizrNo;
    }

    /**
     * indvdlBizrNo을 설정
     * 
     * @param indvdlBizrNo 을(를) String indvdlBizrNo로 설정
     */
    public void setIndvdlBizrNo(String indvdlBizrNo) {
        this.indvdlBizrNo = indvdlBizrNo;
    }

    /**
     * String entrprsBizrNo을 반환
     * 
     * @return String entrprsBizrNo
     */
    public String getEntrprsBizrNo() {
        return entrprsBizrNo;
    }

    /**
     * entrprsBizrNo을 설정
     * 
     * @param entrprsBizrNo 을(를) String entrprsBizrNo로 설정
     */
    public void setEntrprsBizrNo(String entrprsBizrNo) {
        this.entrprsBizrNo = entrprsBizrNo;
    }

    /**
     * String codeLangCode을 반환
     * @return String codeLangCode
     */
    public String getCodeLangCode() {
        return codeLangCode;
    }

    /**
     * codeLangCode을 설정
     * @param codeLangCode 을(를) String codeLangCode로 설정
     */
    public void setCodeLangCode(String codeLangCode) {
        this.codeLangCode = codeLangCode;
    }

    /**
     * Integer codeGroupCd을 반환
     * @return Integer codeGroupCd
     */
    public Integer getCodeGroupCd() {
        return codeGroupCd;
    }

    /**
     * codeGroupCd을 설정
     * @param codeGroupCd 을(를) Integer codeGroupCd로 설정
     */
    public void setCodeGroupCd(Integer codeGroupCd) {
        this.codeGroupCd = codeGroupCd;
    }

    /**
     * Integer codeIndvdlzCd을 반환
     * @return Integer codeIndvdlzCd
     */
    public Integer getCodeIndvdlzCd() {
        return codeIndvdlzCd;
    }

    /**
     * codeIndvdlzCd을 설정
     * @param codeIndvdlzCd 을(를) Integer codeIndvdlzCd로 설정
     */
    public void setCodeIndvdlzCd(Integer codeIndvdlzCd) {
        this.codeIndvdlzCd = codeIndvdlzCd;
    }

    /**
     * String codeIndvdlzCdNm을 반환
     * @return String codeIndvdlzCdNm
     */
    public String getCodeIndvdlzCdNm() {
        return codeIndvdlzCdNm;
    }

    /**
     * codeIndvdlzCdNm을 설정
     * @param codeIndvdlzCdNm 을(를) String codeIndvdlzCdNm로 설정
     */
    public void setCodeIndvdlzCdNm(String codeIndvdlzCdNm) {
        this.codeIndvdlzCdNm = codeIndvdlzCdNm;
    }

    /**
     * String metaGoodsCode을 반환
     * @return String metaGoodsCode
     */
    public String getMetaGoodsCode() {
        return metaGoodsCode;
    }

    /**
     * metaGoodsCode을 설정
     * @param metaGoodsCode 을(를) String metaGoodsCode로 설정
     */
    public void setMetaGoodsCode(String metaGoodsCode) {
        this.metaGoodsCode = metaGoodsCode;
    }

    /**
     * String metaLangCd을 반환
     * @return String metaLangCd
     */
    public String getMetaLangCd() {
        return metaLangCd;
    }

    /**
     * metaLangCd을 설정
     * @param metaLangCd 을(를) String metaLangCd로 설정
     */
    public void setMetaLangCd(String metaLangCd) {
        this.metaLangCd = metaLangCd;
    }

    /**
     * Integer metaGroupCd을 반환
     * @return Integer metaGroupCd
     */
    public Integer getMetaGroupCd() {
        return metaGroupCd;
    }

    /**
     * metaGroupCd을 설정
     * @param metaGroupCd 을(를) Integer metaGroupCd로 설정
     */
    public void setMetaGroupCd(Integer metaGroupCd) {
        this.metaGroupCd = metaGroupCd;
    }

    /**
     * Integer metaIndvdlzCd을 반환
     * @return Integer metaIndvdlzCd
     */
    public Integer getMetaIndvdlzCd() {
        return metaIndvdlzCd;
    }

    /**
     * metaIndvdlzCd을 설정
     * @param metaIndvdlzCd 을(를) Integer metaIndvdlzCd로 설정
     */
    public void setMetaIndvdlzCd(Integer metaIndvdlzCd) {
        this.metaIndvdlzCd = metaIndvdlzCd;
    }

    /**
     * Integer metaEtcCn을 반환
     * @return Integer metaEtcCn
     */
    public Integer getMetaEtcCn() {
        return metaEtcCn;
    }

    /**
     * metaEtcCn을 설정
     * @param metaEtcCn 을(를) Integer metaEtcCn로 설정
     */
    public void setMetaEtcCn(Integer metaEtcCn) {
        this.metaEtcCn = metaEtcCn;
    }

    /**
     * Integer cdStart을 반환
     * @return Integer cdStart
     */
    public Integer getCdStart() {
        return cdStart;
    }

    /**
     * cdStart을 설정
     * @param cdStart 을(를) Integer cdStart로 설정
     */
    public void setCdStart(Integer cdStart) {
        this.cdStart = cdStart;
    }

    /**
     * Integer cdEnd을 반환
     * @return Integer cdEnd
     */
    public Integer getCdEnd() {
        return cdEnd;
    }

    /**
     * cdEnd을 설정
     * @param cdEnd 을(를) Integer cdEnd로 설정
     */
    public void setCdEnd(Integer cdEnd) {
        this.cdEnd = cdEnd;
    }
 
    public String getGoodsCd() {
        return goodsCd;
    }
    
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    } 
    
    public String getGoodsNm() {
        return goodsNm;
    }
    
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }
 
    
    public List<FileVO> getImageFile() {
        return imageFile;
    }

    public void setImageFile(List<FileVO> imageFile) {
        this.imageFile = imageFile;
    }

    public String getGoodsSumry() {
        return goodsSumry;
    }

    public void setGoodsSumry(String goodsSumry) {
        this.goodsSumry = goodsSumry;
    }


    public String getColumnVal1() {
        return columnVal1;
    }

    public void setColumnVal1(String columnVal1) {
        this.columnVal1 = columnVal1;
    }
    
    public String getColumnVal2() {
        return columnVal2;
    }

    public void setColumnVal2(String columnVal2) {
        this.columnVal2 = columnVal2;
    }
    
    public String getColumnVal3() {
        return columnVal3;
    }

    public void setColumnVal3(String columnVal3) {
        this.columnVal3 = columnVal3;
    }
    
}
