/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.annotate.JsonSerialize;


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
 * 2014. 11. 6.    이슬버미       신규
 *</pre>
 * @see
 */
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
public class RestServiceResult<E> {

    private String service = "Ceart Market RestServer";
    private int status = RestResultCode.SUCCESS.getResultCode();
    private String statusMsg = StringUtils.EMPTY;

    private E data;

    public RestServiceResult(){

    }

    public RestServiceResult(E data){
        setData(data);
    }

    public RestServiceResult(int errorCode){
        setStatus(errorCode);
        setData(data);
    }

    public RestServiceResult(RestResultCode resultCode){
        setStatus(resultCode.getResultCode());
        setStatusMsg(resultCode.getDefaultMessage());
        setData(data);
    }

    public RestServiceResult(RestResultCode resultCode,String message){
        setStatus(resultCode.getResultCode());
        setStatusMsg(message + " : " + resultCode.getDefaultMessage());
        setData(data);
    }

    public RestServiceResult(String message){
        setStatus(RestResultCode.CM_UNEXPECTED.getResultCode());
        setStatusMsg(message);
        setData(data);
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public int getStatus(){
        return status;
    }

    public void setStatus(int status){
        this.status = status;
    }

    public String getStatusMsg(){
        if (StringUtils.isEmpty(statusMsg)){
            RestResultCode migalooResult = RestResultCode
                    .getMigalooResultCode(status);
            return migalooResult.getDefaultMessage();
        }

        return statusMsg;
    }

    public void setStatusMsg(String statusMsg){
        this.statusMsg = statusMsg;
    }

    public E getData(){
        return data;
    }

    public void setData(E data){
        this.data = data;
    }


}
