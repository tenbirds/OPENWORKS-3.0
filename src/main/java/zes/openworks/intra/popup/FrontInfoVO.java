/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.popup;


/**
 * 
 *
 * @version 1.0
 * @since openworks-3.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 7. 3.    이홍석       신규
 *</pre>
 * @see
 */
public class FrontInfoVO {

    private static final long serialVersionUID = 2063258049023915798L;
    
    private int agreement; 
    private int use_cnt;
    private int use_amt;
    
    /**
     * int agreement을 반환
     * @return int agreement
     */
    public int getAgreement() {
        return agreement;
    }
    
    /**
     * agreement을 설정
     * @param agreement 을(를) int agreement로 설정
     */
    public void setAgreement(int agreement) {
        this.agreement = agreement;
    }
    
    /**
     * int use_cnt을 반환
     * @return int use_cnt
     */
    public int getUse_cnt() {
        return use_cnt;
    }
    
    /**
     * use_cnt을 설정
     * @param use_cnt 을(를) int use_cnt로 설정
     */
    public void setUse_cnt(int use_cnt) {
        this.use_cnt = use_cnt;
    }
    
    /**
     * int use_amt을 반환
     * @return int use_amt
     */
    public int getUse_amt() {
        return use_amt;
    }
    
    /**
     * use_amt을 설정
     * @param use_amt 을(를) int use_amt로 설정
     */
    public void setUse_amt(int use_amt) {
        this.use_amt = use_amt;
    }
}

