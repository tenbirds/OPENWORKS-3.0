/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import zes.core.spi.oscache.Cache;
import zes.core.spi.oscache.ICache;
import zes.openworks.component.sns.SnsConst;

/**
 * SNS 정보 케시
 * 
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 9. 30.    방기배       신규
 * </pre>
 * @see
 */
public class SnsCache implements ICache {

    @Override
    public void createCache(SqlSession sqlSession) {

        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("useYn", "Y");

        List<Map<String, String>> snsInfoList = sqlSession.selectList("_cache.sns.getSnsInfoList", paramMap);
        Cache.put(SnsConst.SERVICE_LIST_KEY, snsInfoList);

        Map<String, Map<String, String>> snsInfoMap = new HashMap<String, Map<String, String>>();
        for(Map<String, String> snsInfo : snsInfoList) {

            String serviceId = snsInfo.get("SERVICEID");
            snsInfoMap.put(serviceId, snsInfo);
        }
        Cache.put(SnsConst.SERVICE_MAP_KEY, snsInfoMap);

    }

    @Override
    public void reloadCache(SqlSession sqlSession) {
        reloadCache(sqlSession, null);
    }

    @Override
    public void reloadCache(SqlSession sqlSession, Integer domainCd) {
        createCache(sqlSession);
    }

    @Override
    public String getName() {

        return "SNS 정보";
    }

}
