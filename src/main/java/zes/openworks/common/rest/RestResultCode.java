/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest;


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
 * 2014. 12. 26.    이슬버미       신규
 *</pre>
 * @see
 */
public enum RestResultCode {

    SUCCESS(0,"Success"),
    FAIL(-1,"Failed"),
    
    
    CM_MIN(8100,"minimum"),
    CM_MAX(8200,"maximum"),
    CM_REQUIRED(9000,"required"),
    CM_FAIL_REQUEST(9100,"Failed to request."),
    CM_DB_CONN_ERROR(9200, "Failed to connect to DB."),
    CM_FAIL_INSERT_ALERT_INFO(9300, "Failed to insert alert info to DB."),
    CM_SERVER_EXCEPTION(9900,"Server Exception."),
    CM_UNEXPECTED(9999,"Unexpeted Error.");
    
    ;
    
    
    
    private int resultCode;
    private String defaultMessage;

    RestResultCode(int resultCode, String defaultMessage){
        this.resultCode = resultCode;
        this.defaultMessage = defaultMessage;
    }

    public int getResultCode(){
        return resultCode;
    }
    
    public static RestResultCode getMigalooResultCode(int resultCode){
        for(RestResultCode migalooResult : RestResultCode.values()){
            if (resultCode == migalooResult.getResultCode())
                return migalooResult;
        }
        return RestResultCode.FAIL;
    }

    public String getDefaultMessage(){
        return defaultMessage;
    }

    
}
