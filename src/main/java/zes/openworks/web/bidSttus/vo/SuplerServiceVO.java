/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bidSttus.vo;

import java.util.List;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일                       수정자             수정내용
 *--------------  --------  -------------------------------
 * 2015. 12. 08.    KS       신규
 *</pre>
 * @see
 */
public class SuplerServiceVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 언어코드 */
    private String langCode;

    /** 언어코드 배열 */
    private List<String> langCodes;

    /** 공급자아이디 */
    private String suplerId;
    
    /** 공급자명 */
    private String suplerNm;
    
    /** 공급자기업명 */
    private String suplerStoreNm;
    
    /** 서비스구분(2038) */
    private String goodKndCd;
    
    /** 서비스구분명 */
    private String goodKndNm;

    /** 서비스코드 */
    private String goodsCode;    
    
    /** 서비스명 */
    private String goodsNm;

    /** 조회조건1 */
    private String searchDiv01;
    
    /** 조회조건2 */
    private String searchDiv02;
    
    /** 검색어 */
    private String searchKeyWord;
    
    /** 수요자아이디 */
    private String commUserId;

    /** 수요자아이디 */
    private String commUserNm;
    
    /** 회사 */
    private String cmpnyNm;
    
    private String userId;
    private String immeGubun;    

    

    
    
    
    /**
     * String immeGubun을 반환
     * @return String immeGubun
     */
    public String getImmeGubun() {
        return immeGubun;
    }



    
    /**
     * immeGubun을 설정
     * @param immeGubun 을(를) String immeGubun로 설정
     */
    public void setImmeGubun(String immeGubun) {
        this.immeGubun = immeGubun;
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

    
    /**
     * String goodKndNm을 반환
     * @return String goodKndNm
     */
    public String getGoodKndNm() {
        return goodKndNm;
    }

    
    /**
     * goodKndNm을 설정
     * @param goodKndNm 을(를) String goodKndNm로 설정
     */
    public void setGoodKndNm(String goodKndNm) {
        this.goodKndNm = goodKndNm;
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


}
