/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.webevent;

import org.apache.commons.lang.StringUtils;

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
 *  2014. 10. 30.    이슬버미       신규
 * </pre>
 * @see
 */
public class WebEventMessages {

    
    public static final Integer ST_LOGIN_CK = 1000;
    public static final Integer ST_ANSWER_CK = 1001;
    public static final Integer SUCCESS = 0;
    
    
    /* 상태 */
    private Integer status;
    /* 상태 메시지 */
    private String statusMsg = StringUtils.EMPTY;

    public WebEventMessages(Integer status, String statusMsg) {

        this.status = status;
        this.statusMsg = statusMsg;
    }

    /**
     * Boolean status을 반환
     * 
     * @return Integer status
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * status을 설정
     * 
     * @param status 을(를) Integer status로 설정
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * String statusMsg을 반환
     * 
     * @return String statusMsg
     */
    public String getStatusMsg() {
        return statusMsg;
    }

    /**
     * statusMsg을 설정
     * 
     * @param statusMsg 을(를) String statusMsg로 설정
     */
    public void setStatusMsg(String statusMsg) {
        this.statusMsg = statusMsg;
    }

}
