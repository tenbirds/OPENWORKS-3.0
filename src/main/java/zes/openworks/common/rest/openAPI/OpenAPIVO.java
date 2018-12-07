/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.openAPI;

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
 *  2014. 12. 23.    이슬버미       신규
 * </pre>
 * @see
 */
public class OpenAPIVO {

    String id;
    String name;
    /* 서비스명 */
    String goodsNm;
    /* 카테고리 */
    String ctgryclCd;
    /* 서비스구분 */
    String goodsTyCd;
    /* 시작 등록일 */
    String sDate;
    /* 종료 등록일 */
    String eDate;

    String langCode;


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
     * String id을 반환
     *
     * @return String id
     */
    public String getId() {
        return id;
    }

    /**
     * id을 설정
     *
     * @param id 을(를) String id로 설정
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * String name을 반환
     *
     * @return String name
     */
    public String getName() {
        return name;
    }

    /**
     * name을 설정
     *
     * @param name 을(를) String name로 설정
     */
    public void setName(String name) {
        this.name = name;
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
     * String ctgryclCd을 반환
     *
     * @return String ctgryclCd
     */
    public String getCtgryclCd() {
        return ctgryclCd;
    }

    /**
     * ctgryclCd을 설정
     *
     * @param ctgryclCd 을(를) String ctgryclCd로 설정
     */
    public void setCtgryclCd(String ctgryclCd) {
        this.ctgryclCd = ctgryclCd;
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
     * String sDate을 반환
     *
     * @return String sDate
     */
    public String getsDate() {
        return sDate;
    }

    /**
     * sDate을 설정
     *
     * @param sDate 을(를) String sDate로 설정
     */
    public void setsDate(String sDate) {
        this.sDate = sDate;
    }

    /**
     * String eDate을 반환
     *
     * @return String eDate
     */
    public String geteDate() {
        return eDate;
    }

    /**
     * eDate을 설정
     *
     * @param eDate 을(를) String eDate로 설정
     */
    public void seteDate(String eDate) {
        this.eDate = eDate;
    }

}
