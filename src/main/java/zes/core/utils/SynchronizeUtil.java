/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;

import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainGroupVO;

/**
 * 동기화 지원 UTIL 공통 URI를 호출하며 대상 서버 측에서 해당 파라미터를 통하여
 * 동기화를 구현 및 실행하도록 한다.
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 15.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class SynchronizeUtil {

    /** 연결 대기 시간 10초 */
    private static final int CONN_TIME_OUT = 10000;
    /** 공통 동기화 URL */
    private static final String SYNC_URI = GlobalConfig.SYNC_URL;

    public static String synchronize(List<DomainGroupVO> domainGroup, Map<String, Object> param) {

        StringBuilder result = new StringBuilder();

        if(Validate.isEmpty(domainGroup)) {
            return result.append("오류 : 싱크대상 사이트가 없습니다.").toString();
        }

        StringBuilder url = new StringBuilder(SYNC_URI);

        int statusCode = 500;

        int domainCnt = domainGroup.size();

        StringBuilder sb;
        String line = null;

        HttpClient httpclient = null;
        HttpHost httpHost = null;
        HttpParams httpParams = null;
        HttpPost post = null;
        HttpResponse response = null;
        HttpEntity entityResponse = null;

        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
        Iterator<String> it = param.keySet().iterator();
        while(it.hasNext()) {
            String key = it.next();
            nameValuePairs.add(new BasicNameValuePair(key, String.valueOf(param.get(key))));
        }

        UrlEncodedFormEntity entity = null;
        try {
            entity = new UrlEncodedFormEntity(nameValuePairs, GlobalConfig.ENCODING);
        } catch (Exception e) {
            // 직접지정으로 발생 불가
        }

        InputStream is = null;
        BufferedReader reader = null;

        for(int i = 0 ; i < domainCnt ; i++) {

            DomainGroupVO domainGroupVO = domainGroup.get(i);

            url = new StringBuilder();
            if(Validate.isNotEmpty(domainGroupVO.getGroupPortNo())) {
                httpHost = new HttpHost(domainGroupVO.getGroupIpAddr(), domainGroupVO.getGroupPortNo());
            } else {
                httpHost = new HttpHost(domainGroupVO.getGroupIpAddr());
            }

            if(Validate.isNotEmpty(domainGroupVO.getContextPath())) {
                url.append(domainGroupVO.getContextPath());
            }

            url.append(SYNC_URI);

            try {
                httpclient = new DefaultHttpClient();

                httpParams = httpclient.getParams();

                HttpConnectionParams.setConnectionTimeout(httpParams, CONN_TIME_OUT);
                HttpConnectionParams.setSoTimeout(httpParams, CONN_TIME_OUT);

                post = new HttpPost(url.toString());
                post.setEntity(entity);

                response = httpclient.execute(httpHost, post);
                entityResponse = response.getEntity();

                is = entityResponse.getContent();

                reader = new BufferedReader(new InputStreamReader(is, GlobalConfig.ENCODING), 1024);

                sb = new StringBuilder();
                line = null;
                while((line = reader.readLine()) != null) {
                    sb.append(line).append("\n");
                }

                statusCode = response.getStatusLine().getStatusCode();

            } catch (Exception e) {
                // do nothing
            } finally {
                try {
                    if(is != null) {
                        is.close();
                    }
                } catch (IOException e) {
                    // do nothing
                }
            }
        }

        return String.valueOf(statusCode);
    }
}
