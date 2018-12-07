/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.base.support;

import java.util.Iterator;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.util.ClassUtils;

import zes.core.spi.oscache.CacheFactory;
import zes.core.spi.oscache.ICache;

/**
 * 케시 관리 지원 클레스
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
 *  2012. 5. 9.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CacheHelper {

    /**
     * 케쉬 클레스의 인스턴스를 반환한다.
     * 
     * @param clazz
     * @return
     */
    public static ICache getCacheClass(String clazz) {

        Map<Class<?>, ICache> chacheMap = CacheFactory.getMap();
        Iterator<Class<?>> keys = chacheMap.keySet().iterator();

        while(keys.hasNext()) {
            ICache cache = chacheMap.get(keys.next());
            String cacheClass = ClassUtils.getShortName(cache.getClass());

            if(clazz.equals(cacheClass)) {
                return CacheFactory.extract(cache.getClass());
            }
        }
        return null;
    }

    /**
     * 케시 내역을 갱신한다.
     * 
     * @param clazzName
     * @param sqlSession
     */
    public static void cacheReload(String shortClassName, SqlSession sqlSession) {
        cacheReload(shortClassName, null, sqlSession);
    }

    /**
     * 케시 내역을 갱신한다.
     * 
     * @param clazzName
     * @param sqlSession
     */
    public static void cacheReload(String shortClassName, Integer domainCd, SqlSession sqlSession) {
        try {
            // 케쉬 정보 재설정
            CacheHelper.getCacheClass(shortClassName).reloadCache(sqlSession, domainCd);
        } catch (Exception e) {
            // do nothing
        }
    }
}
