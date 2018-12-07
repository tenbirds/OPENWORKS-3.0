/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 * * << 개정이력(Modification Information) >>
 *
 *     수정일                 수정자      수정내용
 * --------------  --------  -------------------------------
 * 2017.12.12.    SKYOU  신규    공급현황>계약수기등록
 * </pre>
 * @see
 */
public class SuplerCntrctGoodsVO extends PaggingVO {

    static final long serialVersionUID = 8021523148984509635L;
    
    private String cntrctSvcSn; 
    private int cntrctSn; 
    private String goodsCode;
    private String goodsName;
    private String splyForm; 
    private String splyFormEtc ; 
    private String cntrctCount; 
    private String cntrctAmount;
    
  
    
    /**
     * String cntrctSvcSn을 반환
     * @return String cntrctSvcSn
     */
    public String getCntrctSvcSn() {
        return cntrctSvcSn;
    }
    
    /**
     * cntrctSvcSn을 설정
     * @param cntrctSvcSn 을(를) String cntrctSvcSn로 설정
     */
    public void setCntrctSvcSn(String cntrctSvcSn) {
        this.cntrctSvcSn = cntrctSvcSn;
    }
    
    /**
     * int cntrctSn을 반환
     * @return int cntrctSn
     */
    public int getCntrctSn() {
        return cntrctSn;
    }

    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) int cntrctSn로 설정
     */
    public void setCntrctSn(int cntrctSn) {
        this.cntrctSn = cntrctSn;
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
     * String splyForm을 반환
     * @return String splyForm
     */
    public String getSplyForm() {
        return splyForm;
    }
    
    /**
     * splyForm을 설정
     * @param splyForm 을(를) String splyForm로 설정
     */
    public void setSplyForm(String splyForm) {
        this.splyForm = splyForm;
    }
    
    /**
     * String splyFormEtc을 반환
     * @return String splyFormEtc
     */
    public String getSplyFormEtc() {
        return splyFormEtc;
    }
    
    /**
     * splyFormEtc을 설정
     * @param splyFormEtc 을(를) String splyFormEtc로 설정
     */
    public void setSplyFormEtc(String splyFormEtc) {
        this.splyFormEtc = splyFormEtc;
    }
    
    /**
     * String cntrctCount을 반환
     * @return String cntrctCount
     */
    public String getCntrctCount() {
        return cntrctCount;
    }
    
    /**
     * cntrctCount을 설정
     * @param cntrctCount 을(를) String cntrctCount로 설정
     */
    public void setCntrctCount(String cntrctCount) {
        this.cntrctCount = cntrctCount;
    }
    
    /**
     * String cntrctAmount을 반환
     * @return String cntrctAmount
     */
    public String getCntrctAmount() {
        return cntrctAmount;
    }
    
    /**
     * cntrctAmount을 설정
     * @param cntrctAmount 을(를) String cntrctAmount로 설정
     */
    public void setCntrctAmount(String cntrctAmount) {
        this.cntrctAmount = cntrctAmount;
    }

    
    
}
