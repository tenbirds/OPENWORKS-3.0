/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

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
 * 2018. 5. 23.    방기배       신규
 *</pre>
 * @see
 */
public class HistoryGoodsSearchVO
{
    private static final long serialVersionUID = 1L;

    private String keyword;    /** 키워드 */
    private String filtercon;  /** 필터조건 */
    
    /**
     * String keyword을 반환
     * @return String keyword
     */
    public String getKeyword()
    {
        return keyword;
    }
    /**
     * keyword을 설정
     * @param keyword 을(를) String keyword로 설정
     */
    public void setKeyword(String keyword)
    {
        this.keyword = keyword;
    }
    /**
     * String filtercon을 반환
     * @return String filtercon
     */
    public String getFiltercon()
    {
        return filtercon;
    }
    /**
     * filtercon을 설정
     * @param filtercon 을(를) String filtercon로 설정
     */
    public void setFiltercon(String filtercon)
    {
        this.filtercon = filtercon;
    }
    
}
