/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpEntityEnclosingRequestBase;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.openworks.common.rest.util.JsonUtils;

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
 *  2014. 11. 6.    이슬버미       신규
 * </pre>
 * @see
 */
@SuppressWarnings({"rawtypes","unchecked"})
public class RestServiceClient {

    private static final Log log = LogFactory.getLog(RestServiceClient.class);

    
    public RestServiceResult request(String url, RequestMethod requestMethod) throws Exception{
    return request(url, requestMethod, null, Object.class);
    }
    
    public <T>RestServiceResult<T> request(String url, RequestMethod requestMethod, Class<T> resultDataType)throws Exception{
        return request(url, requestMethod, null, resultDataType);
    }
    
    public RestServiceResult request(String url, RequestMethod requestMethod,
            Object requestObject) throws Exception{
        return request(url, requestMethod, requestObject, Object.class);
    }
    
    public <T>RestServiceResult<T> request(String url,RequestMethod requestMethod, Object requestObject,Class<T> resultDataType) throws Exception{
    
        DefaultHttpClient httpclient = new DefaultHttpClient();    
        RestServiceResult<T> restServiceResult = null;
    
        if (requestMethod == RequestMethod.GET){
            HttpGet httpGet = new HttpGet(url);
            restServiceResult = execute(httpclient, httpGet, null,RestServiceResult.class);
        } else if (requestMethod == RequestMethod.POST){
            String requestBody = JsonUtils.toJson(requestObject);
            HttpPost httpPost = new HttpPost(url);
            restServiceResult = execute(httpclient, httpPost, requestBody,RestServiceResult.class);
        } else if (requestMethod == RequestMethod.PUT){
            String requestBody = JsonUtils.toJson(requestObject);
            HttpPut httpPut = new HttpPut(url);
            restServiceResult = execute(httpclient, httpPut, requestBody,RestServiceResult.class);
        } else if (requestMethod == RequestMethod.DELETE){
            String requestBody = JsonUtils.toJson(requestObject);
            HttpDelete httpDelete = new HttpDelete(url);
            restServiceResult = execute(httpclient, httpDelete, requestBody,RestServiceResult.class);
        }
    
        Object resultDataRaw = restServiceResult.getData();
        String resultDataString = JsonUtils.toJson(resultDataRaw);
    
        if (resultDataType == String.class){
            restServiceResult.setData((T) resultDataString);
        } else{
            T resultData = JsonUtils.toObject(resultDataString, resultDataType);
            restServiceResult.setData(resultData);
        }

    return restServiceResult;
}   
    
    private <T> T execute(DefaultHttpClient httpclient, HttpRequestBase request, String requestBody, Class<T> resultDataType) {
        T restServiceResult = null;
        try {
            request.addHeader("Content-Type", MediaType.APPLICATION_JSON + "");
            request.addHeader("Accept", MediaType.APPLICATION_JSON + "");
            if(!StringUtils.isEmpty(requestBody)) {
                setEntity(request, requestBody);
            }
            HttpResponse response = httpclient.execute(request);
            restServiceResult = getResponse(response, resultDataType);
        } catch (Exception e) {
            log.info(e);
        }
        return restServiceResult;
    }
    private <T> T getResponse(HttpResponse response, Class<T> resultDataType) throws IOException, Exception {
        T restServiceResult;
        String responseText = EntityUtils.toString(response.getEntity());
        if(resultDataType == String.class) {
            restServiceResult = (T) responseText;
        } else {
            restServiceResult = JsonUtils.toObject(responseText, resultDataType);
        }
        return restServiceResult;
    }

    private void setEntity(HttpRequestBase request, String requestBody)
        throws UnsupportedEncodingException {
        if(!(request instanceof HttpEntityEnclosingRequestBase)) {
            return;
        }
        ((HttpEntityEnclosingRequestBase) request).setEntity(new StringEntity(requestBody, "UTF-8"));
    }

}
