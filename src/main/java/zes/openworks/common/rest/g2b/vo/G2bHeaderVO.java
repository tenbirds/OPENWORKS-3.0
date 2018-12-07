/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b.vo;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 11.    이슬버미       신규
 *</pre>
 * @see
 */
public class G2bHeaderVO {

    @XStreamAlias("resultCode")
    private String resultCode;
    
    @XStreamAlias("resultMsg")
    private String resultMsg;

    
    /**
     * String resultCode을 반환
     * @return String resultCode
     */
    public String getResultCode() {
        return resultCode;
    }

    
    /**
     * resultCode을 설정
     * @param resultCode 을(를) String resultCode로 설정
     */
    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    
    /**
     * String resultMsg을 반환
     * @return String resultMsg
     */
    public String getResultMsg() {
        return resultMsg;
    }

    
    /**
     * resultMsg을 설정
     * @param resultMsg 을(를) String resultMsg로 설정
     */
    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }
    
    
    
    
}
