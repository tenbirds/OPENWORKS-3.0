/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.utils;

import java.io.IOException;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.core.lang.Validate;

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
 *  2012. 4. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class JsonUtil {

    /** 로깅 */
    private static Logger logger = LoggerFactory.getLogger(JsonUtil.class);

    /**
     * 대상 객체를 JSON 객체 문자열로 반환한다.
     * 대상이 없거나, 오류 발생시 빈 배열형식("{}")의 문자열을 반환한다.
     * 
     * @param jsonObj
     * @return
     */
    public static String toJson(Object jsonObj) {

        String json = "{}";
        if(Validate.isNull(jsonObj)) {
            return json;
        }

        ObjectMapper mapper = new ObjectMapper();
        try {
            json = mapper.writeValueAsString(jsonObj);
        } catch (IOException e) {}

        return json;
    }

    /**
     * JSON 문자열로 객체를 생성하여 반환한다.
     * JSON과 Class TYPE이 일치 하지 않는 경우 <code>null</code>을 반환한다.
     * 
     * @param jsonStr
     * @param objType
     * @return
     */
    public static <T> T fromJson(String jsonStr, Class<T> objType) {
        T obj = null;

        ObjectMapper mapper = new ObjectMapper();
        try {
            obj = mapper.readValue(jsonStr, objType);
        } catch (IOException e) {
            if(logger.isDebugEnabled()) {
                logger.debug("change type failed", e);
            }
        }

        return obj;
    }
}
