/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.rest.g2b;

import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import zes.openworks.common.rest.RestServiceClient;
import zes.openworks.common.rest.g2b.vo.G2bResponseVO;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.mapper.MapperWrapper;


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
public class G2bServiceClient {

    private static final Log log = LogFactory.getLog(RestServiceClient.class);
    
    
    public G2bResponseVO request(String url) throws Exception{
     
        DefaultHttpClient httpclient = new DefaultHttpClient();
        HttpGet httpGet = new HttpGet(url);
        G2bResponseVO g2bResponseVO = execute(httpclient, httpGet);
        
        return g2bResponseVO;
    }
    
    private G2bResponseVO execute(DefaultHttpClient httpclient, HttpRequestBase request) {
        G2bResponseVO g2bResponseVO = null;
        try {
            request.addHeader("Content-Type", "text/xml;charset=UTF-8");
            HttpResponse response = httpclient.execute(request);
            g2bResponseVO = getResponse(response);
        } catch (Exception e) {
            log.info(e);
        }
        return g2bResponseVO;
    }
    
 
    private G2bResponseVO getResponse(HttpResponse response) throws IOException, Exception {
        G2bResponseVO g2bResponseVO;
        String responseText = EntityUtils.toString(response.getEntity());
        g2bResponseVO = xmltoClass(responseText);
        
        return g2bResponseVO;
    }
    
    private G2bResponseVO xmltoClass(String xml) throws Exception {

        XStream xStream = new XStream(){
            // to enable ignoring of unknown elements
            @Override
            protected MapperWrapper wrapMapper(MapperWrapper next) {
                return new MapperWrapper(next) {
                    @Override
                    public boolean shouldSerializeMember(@SuppressWarnings("rawtypes") Class definedIn, String fieldName) {
                        if (definedIn == Object.class) {
                            try {
                                return this.realClass(fieldName) != null;
                            } catch (Exception e) {
                                return false;
                            }
                        }
                        return super.shouldSerializeMember(definedIn, fieldName);
                    }
                };
            }
        };
        xStream.setMode(XStream.NO_REFERENCES);
        xStream.processAnnotations(G2bResponseVO.class);
        G2bResponseVO g2bResponseVO = (G2bResponseVO) xStream.fromXML(xml);
        return g2bResponseVO;
        
    }
    
    
}
