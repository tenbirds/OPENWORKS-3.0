/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmSiteStat;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 12. 16.    		 boseok       	신규
 *</pre>
 * @see
 */
public class CmSiteStatVO extends PaggingVO {

    
    /**  */
    private static final long serialVersionUID = 6059439425103783972L;
    
    /** 조회 시작일자 */
    private String startDate = "";
    /** 조회 종료일자 */
    private String endDate = "";
    /** 조회 단위 (일:DATE / 주:WEEK / 월:MONTH) */
    private String searchUnit = "DATE";
    /** langCode */
    private String langCode = "";
    /** 커뮤니티 아이디 */
    private String cmmntyId = "";
    /** 전일 시작일자 */
    private String pastStartDate = "";
    /** 전일 종료일자 */
    private String pastEndDate = "";
    
    /**
     * String startDate을 반환
     * @return String startDate
     */
    public String getStartDate() {
        return startDate;
    }
    
    /**
     * startDate을 설정
     * @param startDate 을(를) String startDate로 설정
     */
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    
    /**
     * String endDate을 반환
     * @return String endDate
     */
    public String getEndDate() {
        return endDate;
    }
    
    /**
     * endDate을 설정
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    
    /**
     * String searchUnit을 반환
     * @return String searchUnit
     */
    public String getSearchUnit() {
        return searchUnit;
    }
    
    /**
     * searchUnit을 설정
     * @param searchUnit 을(를) String searchUnit로 설정
     */
    public void setSearchUnit(String searchUnit) {
        this.searchUnit = searchUnit;
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
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }
    
    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }
    
    /**
     * String pastStartDate을 반환
     * @return String pastStartDate
     */
    public String getPastStartDate() {
        return pastStartDate;
    }
    
    /**
     * pastStartDate을 설정
     * @param pastStartDate 을(를) String pastStartDate로 설정
     */
    public void setPastStartDate(String pastStartDate) {
        this.pastStartDate = pastStartDate;
    }
    
    /**
     * String pastEndDate을 반환
     * @return String pastEndDate
     */
    public String getPastEndDate() {
        return pastEndDate;
    }
    
    /**
     * pastEndDate을 설정
     * @param pastEndDate 을(를) String pastEndDate로 설정
     */
    public void setPastEndDate(String pastEndDate) {
        this.pastEndDate = pastEndDate;
    }
    
    
    
}
