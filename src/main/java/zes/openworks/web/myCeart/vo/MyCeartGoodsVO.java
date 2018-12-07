/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

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
public class MyCeartGoodsVO extends PaggingVO{


    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;
    
    /** 서비스코드 */
    private String goodsCode;

    /** 서비스명 */
    private String goodsName;

    /** 공급자ID */
    private String langStoreId;

    /** 공급자명 */
    private String langStoreNm;

    /** 서비스이미지 SEQ */
    private int goodsImageFileSeq;

    /** 서비스이미지 URL */
    private String goodsFileUrl;

    
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
     * String goodsName을 반환
     * @return String goodsName
     */
    public String getGoodsName() {
        return goodsName;
    }

    
    /**
     * goodsName을 설정
     * @param goodsName 을(를) String goodsName로 설정
     */
    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
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
     * int goodsImageFileSeq을 반환
     * @return int goodsImageFileSeq
     */
    public int getGoodsImageFileSeq() {
        return goodsImageFileSeq;
    }

    
    /**
     * goodsImageFileSeq을 설정
     * @param goodsImageFileSeq 을(를) int goodsImageFileSeq로 설정
     */
    public void setGoodsImageFileSeq(int goodsImageFileSeq) {
        this.goodsImageFileSeq = goodsImageFileSeq;
    }

    
    /**
     * String goodsFileUrl을 반환
     * @return String goodsFileUrl
     */
    public String getGoodsFileUrl() {
        return goodsFileUrl;
    }

    
    /**
     * goodsFileUrl을 설정
     * @param goodsFileUrl 을(를) String goodsFileUrl로 설정
     */
    public void setGoodsFileUrl(String goodsFileUrl) {
        this.goodsFileUrl = goodsFileUrl;
    }
    
}
