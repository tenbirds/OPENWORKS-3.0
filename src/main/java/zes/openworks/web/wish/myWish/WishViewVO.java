package zes.openworks.web.wish.myWish;

/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
import zes.base.vo.BaseVO;

/**
 * @version 1.0
 * @since openworks-3.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 4. 3.    이홍석       신규
 *         </pre>
 * 
 * @see
 */
public class WishViewVO extends BaseVO 
{    
    private static final long serialVersionUID = 1L;
    
    private String logSeq; 
    private String userId;
    private String notifyNum;
    private int    notifySeq;
    private String langStoreUserId;
    private String goodsCd;
    
    /**
     * String logSeq을 반환
     * @return String logSeq
     */
    public String getLogSeq() {
        return logSeq;
    }
    
    /**
     * logSeq을 설정
     * @param logSeq 을(를) String logSeq로 설정
     */
    public void setLogSeq(String logSeq) {
        this.logSeq = logSeq;
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
     * String notifyNum을 반환
     * 
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }

    /**
     * notifyNum을 설정
     * 
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
     * String langStoreUserId을 반환
     * @return String langStoreUserId
     */
    public String getLangStoreUserId() {
        return langStoreUserId;
    }

    /**
     * langStoreUserId을 설정
     * @param langStoreUserId 을(를) String langStoreUserId로 설정
     */
    public void setLangStoreUserId(String langStoreUserId) {
        this.langStoreUserId = langStoreUserId;
    }
 
    /**
     * String goodsCd을 반환
     * @return String goodsCd
     */
    public String getGoodsCd() {
        return goodsCd;
    }

    /**
     * goodsCd을 설정
     * @param goodsCd 을(를) String goodsCd로 설정
     */
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }
}
