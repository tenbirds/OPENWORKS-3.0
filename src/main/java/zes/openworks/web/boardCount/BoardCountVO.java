/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.boardCount;

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
 *  2013. 5. 7.    sa   신규 생성
 * </pre>
 * @see
 */
public class BoardCountVO {

    private Integer domainCd;
    private String menuCode;
    private Integer ymdDate;
    private String count;

    /**
     * Integer domainCd을 반환
     * 
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * domainCd을 설정
     * 
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * String menuCode을 반환
     * 
     * @return String menuCode
     */
    public String getMenuCode() {
        return menuCode;
    }

    /**
     * menuCode을 설정
     * 
     * @param menuCode 을(를) String menuCode로 설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    /**
     * String count을 반환
     * 
     * @return String count
     */
    public String getCount() {
        return count;
    }

    /**
     * count을 설정
     * 
     * @param count 을(를) String count로 설정
     */
    public void setCount(String count) {
        this.count = count;
    }

    /**
     * Integer ymdDate을 반환
     * 
     * @return Integer ymdDate
     */
    public Integer getYmdDate() {
        return ymdDate;
    }

    /**
     * ymdDate을 설정
     * 
     * @param ymdDate 을(를) Integer ymdDate로 설정
     */
    public void setYmdDate(Integer ymdDate) {
        this.ymdDate = ymdDate;
    }

}
