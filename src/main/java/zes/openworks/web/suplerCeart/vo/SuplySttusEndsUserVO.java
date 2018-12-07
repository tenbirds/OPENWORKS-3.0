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
public class SuplySttusEndsUserVO extends PaggingVO {

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
    
    /** 공급자ID */
    private String suplerId;

    /** 공급자명 */
    private String suplerNm;

    /** 공급자 회사명 */
    private String suplerStoreNm; 
    
    /** 수요자ID */
    private String endsUserId;
    
    /** 수요자명 */
    private String endsUserNm;
    
    /** 수요자 휴대전화 */
    private String endsUserMbtlnum;
    
    /** 수요자 e-mail */
    private String endsUserEmail;
    
    /** 수요자 기업/기관명 */
    private String endsUserStoreNm;
    
    /** 수요자 대표전화 */
    private String endsUserReprsntTelno;
    
    /** 공급 서비스코드 */
    private String goodsCode;
    
    /** 공급 서비스명 */
    private String goodsNm;

    /** 공급 서비스구분(1005) */
    private String goodKndCd;
    
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
     * String endsUserNm을 반환
     * @return String endsUserNm
     */
    public String getEndsUserNm() {
        return endsUserNm;
    }

    
    /**
     * endsUserNm을 설정
     * @param endsUserNm 을(를) String endsUserNm로 설정
     */
    public void setEndsUserNm(String endsUserNm) {
        this.endsUserNm = endsUserNm;
    }

    
    /**
     * String endsUserMbtlnum을 반환
     * @return String endsUserMbtlnum
     */
    public String getEndsUserMbtlnum() {
        return endsUserMbtlnum;
    }

    
    /**
     * endsUserMbtlnum을 설정
     * @param endsUserMbtlnum 을(를) String endsUserMbtlnum로 설정
     */
    public void setEndsUserMbtlnum(String endsUserMbtlnum) {
        this.endsUserMbtlnum = endsUserMbtlnum;
    }

    
    /**
     * String endsUserEmail을 반환
     * @return String endsUserEmail
     */
    public String getEndsUserEmail() {
        return endsUserEmail;
    }

    
    /**
     * endsUserEmail을 설정
     * @param endsUserEmail 을(를) String endsUserEmail로 설정
     */
    public void setEndsUserEmail(String endsUserEmail) {
        this.endsUserEmail = endsUserEmail;
    }

    
    /**
     * String endsUserStoreNm을 반환
     * @return String endsUserStoreNm
     */
    public String getEndsUserStoreNm() {
        return endsUserStoreNm;
    }

    
    /**
     * endsUserStoreNm을 설정
     * @param endsUserStoreNm 을(를) String endsUserStoreNm로 설정
     */
    public void setEndsUserStoreNm(String endsUserStoreNm) {
        this.endsUserStoreNm = endsUserStoreNm;
    }

    
    /**
     * String endsUserReprsntTelno을 반환
     * @return String endsUserReprsntTelno
     */
    public String getEndsUserReprsntTelno() {
        return endsUserReprsntTelno;
    }

    
    /**
     * endsUserReprsntTelno을 설정
     * @param endsUserReprsntTelno 을(를) String endsUserReprsntTelno로 설정
     */
    public void setEndsUserReprsntTelno(String endsUserReprsntTelno) {
        this.endsUserReprsntTelno = endsUserReprsntTelno;
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
     * String goodKndCd을 반환
     * @return String goodKndCd
     */
    public String getGoodKndCd() {
        return goodKndCd;
    }

    
    /**
     * goodKndCd을 설정
     * @param goodKndCd 을(를) String goodKndCd로 설정
     */
    public void setGoodKndCd(String goodKndCd) {
        this.goodKndCd = goodKndCd;
    }
    
    
}
