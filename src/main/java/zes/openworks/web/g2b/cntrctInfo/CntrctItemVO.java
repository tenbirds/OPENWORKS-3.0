/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.cntrctInfo;

import zes.base.vo.BaseVO;


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
public class CntrctItemVO extends BaseVO {

    /**  */
    private static final long serialVersionUID = 8066298618131160918L;
    
    /* 통합계약번호 */
    private String cntrctUnionNo; 
    /* 통합계약 일련번호 */
    private int cntrctUnionSeq; 
    /* 물품분류번호 */
    private String itemClNo; 
    /* 물품식별번호 */
    private String itemIdntfcNo; 
    /* 계약물품 단가 */
    private String cntrctItemUntpc; 
    /* 계약물품 수량 */
    private String cntrctItemQy; 
    /* 계약물품명 */
    private String cntrctItemNm; 
    /* 계약물품 금액 */
    private String cntrctItemAmt;
    
    /**
     * String cntrctUnionNo을 반환
     * @return String cntrctUnionNo
     */
    public String getCntrctUnionNo() {
        return cntrctUnionNo;
    }
    
    /**
     * cntrctUnionNo을 설정
     * @param cntrctUnionNo 을(를) String cntrctUnionNo로 설정
     */
    public void setCntrctUnionNo(String cntrctUnionNo) {
        this.cntrctUnionNo = cntrctUnionNo;
    }
    
    /**
     * String cntrctUnionSeq을 반환
     * @return String cntrctUnionSeq
     */
    public int getCntrctUnionSeq() {
        return cntrctUnionSeq;
    }
    
    /**
     * cntrctUnionSeq을 설정
     * @param cntrctUnionSeq 을(를) String cntrctUnionSeq로 설정
     */
    public void setCntrctUnionSeq(int cntrctUnionSeq) {
        this.cntrctUnionSeq = cntrctUnionSeq;
    }
    
    /**
     * String itemClNo을 반환
     * @return String itemClNo
     */
    public String getItemClNo() {
        return itemClNo;
    }
    
    /**
     * itemClNo을 설정
     * @param itemClNo 을(를) String itemClNo로 설정
     */
    public void setItemClNo(String itemClNo) {
        this.itemClNo = itemClNo;
    }
    
    /**
     * String itemIdntfcNo을 반환
     * @return String itemIdntfcNo
     */
    public String getItemIdntfcNo() {
        return itemIdntfcNo;
    }
    
    /**
     * itemIdntfcNo을 설정
     * @param itemIdntfcNo 을(를) String itemIdntfcNo로 설정
     */
    public void setItemIdntfcNo(String itemIdntfcNo) {
        this.itemIdntfcNo = itemIdntfcNo;
    }
    
    /**
     * String cntrctItemUntpc을 반환
     * @return String cntrctItemUntpc
     */
    public String getCntrctItemUntpc() {
        return cntrctItemUntpc;
    }
    
    /**
     * cntrctItemUntpc을 설정
     * @param cntrctItemUntpc 을(를) String cntrctItemUntpc로 설정
     */
    public void setCntrctItemUntpc(String cntrctItemUntpc) {
        this.cntrctItemUntpc = cntrctItemUntpc;
    }
    
    /**
     * String cntrctItemQy을 반환
     * @return String cntrctItemQy
     */
    public String getCntrctItemQy() {
        return cntrctItemQy;
    }
    
    /**
     * cntrctItemQy을 설정
     * @param cntrctItemQy 을(를) String cntrctItemQy로 설정
     */
    public void setCntrctItemQy(String cntrctItemQy) {
        this.cntrctItemQy = cntrctItemQy;
    }
    
    /**
     * String cntrctItemNm을 반환
     * @return String cntrctItemNm
     */
    public String getCntrctItemNm() {
        return cntrctItemNm;
    }
    
    /**
     * cntrctItemNm을 설정
     * @param cntrctItemNm 을(를) String cntrctItemNm로 설정
     */
    public void setCntrctItemNm(String cntrctItemNm) {
        this.cntrctItemNm = cntrctItemNm;
    }
    
    /**
     * String cntrctItemAmt을 반환
     * @return String cntrctItemAmt
     */
    public String getCntrctItemAmt() {
        return cntrctItemAmt;
    }
    
    /**
     * cntrctItemAmt을 설정
     * @param cntrctItemAmt 을(를) String cntrctItemAmt로 설정
     */
    public void setCntrctItemAmt(String cntrctItemAmt) {
        this.cntrctItemAmt = cntrctItemAmt;
    }
    
    
}
