/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import zes.core.spi.commons.configuration.Config;

/**
 * SNS 연계 관련 설정 값 관리
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
 *  2013. 8. 21.    방기배       신규
 * </pre>
 * @see
 */
public class SnsConfig {

    /** 서비스 제공자 목록 */
    public static final List<Map<String, String>> PROVIDERS = new ArrayList<Map<String, String>>();
    /** 인증 유형 목록 */
    public static final List<Map<String, String>> AUTHTYPES = new ArrayList<Map<String, String>>();
    /** 인증 유형 멥 */
    public static final Map<String, String> AUTHTYPE = new HashMap<String, String>();

    /* 값 설정 */
    static {

        String key = "";
        String splitKey = "";
        Map<String, String> tmpMap = null;

        // 서비스제공자
        Iterator<?> it = Config.getKeys("sns.providers");
        while(it.hasNext()) {
            tmpMap = new HashMap<String, String>();

            key = String.valueOf(it.next());
            splitKey = key.substring(key.lastIndexOf(".") + 1);

            tmpMap.put("serviceId", splitKey);
            tmpMap.put("serviceNm", Config.getString(key));
            PROVIDERS.add(tmpMap);
        }

        it = Config.getKeys("sns.authType");
        while(it.hasNext()) {
            tmpMap = new HashMap<String, String>();

            key = String.valueOf(it.next());
            splitKey = key.substring(key.lastIndexOf(".") + 1);

            tmpMap.put("authType", splitKey);
            tmpMap.put("authNm", Config.getString(key));

            AUTHTYPE.put(splitKey, Config.getString(key));
            AUTHTYPES.add(tmpMap);
        }

    }

}
