/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.introduction;

import zes.base.vo.PaggingVO;

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
 * 2018. 3. 8.    이홍석       신규
 *</pre>
 * @see
 */
public class AgremManageVO extends PaggingVO 
{
    private static final long serialVersionUID = -9066643876847956548L;

    private String userId;   /** 사용자 아이디 */
    private String cmpnyNm;  /** 협약승인기업명 */
    
    private String q_companyName; /** 검색 - 기업명 */
    
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
     * String cmpnyNm을 반환
     * @return String cmpnyNm
     */
    public String getCmpnyNm() {
        return cmpnyNm;
    }
    /**
     * cmpnyNm을 설정
     * @param cmpnyNm 을(를) String cmpnyNm로 설정
     */
    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }
    /**
     * String q_companyName을 반환
     * @return String q_companyName
     */
    public String getQ_companyName() {
        return q_companyName;
    }
    /**
     * q_companyName을 설정
     * @param q_companyName 을(를) String q_companyName로 설정
     */
    public void setQ_companyName(String q_companyName) {
        this.q_companyName = q_companyName;
    }
    
}
