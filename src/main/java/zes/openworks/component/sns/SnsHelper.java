/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns;

import org.apache.ibatis.session.SqlSession;

import zes.base.support.CacheHelper;

/**
 * SNS 관련 Helper 클레스
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
 *  2013. 10. 1.    방기배       신규
 * </pre>
 * @see
 */
public class SnsHelper {

    /** SNS 케시 클레스명(패키지명 제외) */
    private static final String CACHE_NAME = "SnsCache";

    /**
     * SNS 케시 내역을 갱신한다.
     * 
     * @param clazzName
     * @param sqlSession
     */
    public static void cacheReload(SqlSession sqlSession) {
        try {
            // 케쉬 정보 재설정
            CacheHelper.cacheReload(CACHE_NAME, sqlSession);
        } catch (Exception e) {
            // do nothing
        }
    }

}
