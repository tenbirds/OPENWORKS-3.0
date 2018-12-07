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
public class MyCeartSaasDVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고순번 */
    private int notifySeq;

    /** 사용자아이디 */
    private String userId;

    /** 공급자아이디 */
    private String langStoreId;

    /** 수요자여부 */
    private String consumerYn;
    
    /** 답변seq */
    private int applySeq;

    /** 옵션명 */
    private String optionNm;

    /** 개별단위 */
    private String unitItem;

    /** 개별제공용량 */
    private String captyItem;

    /** 개별단가 */
    private int amountItem;

    /** 설명 */
    private String cmntItem;
    

    /** 답변등록여부 */
    private String applyYn;

    
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
     * String consumerYn을 반환
     * @return String consumerYn
     */
    public String getConsumerYn() {
        return consumerYn;
    }

    
    /**
     * consumerYn을 설정
     * @param consumerYn 을(를) String consumerYn로 설정
     */
    public void setConsumerYn(String consumerYn) {
        this.consumerYn = consumerYn;
    }

    
    /**
     * int applySeq을 반환
     * @return int applySeq
     */
    public int getApplySeq() {
        return applySeq;
    }

    
    /**
     * applySeq을 설정
     * @param applySeq 을(를) int applySeq로 설정
     */
    public void setApplySeq(int applySeq) {
        this.applySeq = applySeq;
    }

    
    /**
     * String optionNm을 반환
     * @return String optionNm
     */
    public String getOptionNm() {
        return optionNm;
    }

    
    /**
     * optionNm을 설정
     * @param optionNm 을(를) String optionNm로 설정
     */
    public void setOptionNm(String optionNm) {
        this.optionNm = optionNm;
    }

    
    /**
     * String unitItem을 반환
     * @return String unitItem
     */
    public String getUnitItem() {
        return unitItem;
    }

    
    /**
     * unitItem을 설정
     * @param unitItem 을(를) String unitItem로 설정
     */
    public void setUnitItem(String unitItem) {
        this.unitItem = unitItem;
    }

    
    /**
     * String captyItem을 반환
     * @return String captyItem
     */
    public String getCaptyItem() {
        return captyItem;
    }

    
    /**
     * captyItem을 설정
     * @param captyItem 을(를) String captyItem로 설정
     */
    public void setCaptyItem(String captyItem) {
        this.captyItem = captyItem;
    }

    
    /**
     * int amountItem을 반환
     * @return int amountItem
     */
    public int getAmountItem() {
        return amountItem;
    }

    
    /**
     * amountItem을 설정
     * @param amountItem 을(를) int amountItem로 설정
     */
    public void setAmountItem(int amountItem) {
        this.amountItem = amountItem;
    }

    
    /**
     * String cmntItem을 반환
     * @return String cmntItem
     */
    public String getCmntItem() {
        return cmntItem;
    }

    
    /**
     * cmntItem을 설정
     * @param cmntItem 을(를) String cmntItem로 설정
     */
    public void setCmntItem(String cmntItem) {
        this.cmntItem = cmntItem;
    }

    
    /**
     * String applyYn을 반환
     * @return String applyYn
     */
    public String getApplyYn() {
        return applyYn;
    }

    
    /**
     * applyYn을 설정
     * @param applyYn 을(를) String applyYn로 설정
     */
    public void setApplyYn(String applyYn) {
        this.applyYn = applyYn;
    }

}
