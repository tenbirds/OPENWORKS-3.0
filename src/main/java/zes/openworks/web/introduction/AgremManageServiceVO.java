/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.introduction;

import zes.base.vo.BaseVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 3. 9.    이홍석       신규
 *</pre>
 * @see
 */
public class AgremManageServiceVO extends BaseVO {
    
    private static final long serialVersionUID = -9066643876847956548L;

    
    private String q_userId;   /** 사용자 아이디 */
    
    
    private String userId;     /** 사용자 아이디 */
    private String goodsCode;  /** 상품코드 */
    private String goodsNm;    /** 상품명 */
    private int goodsKndCd;    /** 상품타입코드 */
    
    /**
     * String q_userId을 반환
     * @return String q_userId
     */
    public String getQ_userId() {
        return q_userId;
    }
    /**
     * q_userId을 설정
     * @param q_userId 을(를) String q_userId로 설정
     */
    public void setQ_userId(String q_userId) {
        this.q_userId = q_userId;
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
     * int goodsKndCd을 반환
     * @return int goodsKndCd
     */
    public int getGoodsKndCd() {
        return goodsKndCd;
    }
    /**
     * goodsKndCd을 설정
     * @param goodsKndCd 을(를) int goodsKndCd로 설정
     */
    public void setGoodsKndCd(int goodsKndCd) {
        this.goodsKndCd = goodsKndCd;
    }
    
    
}
