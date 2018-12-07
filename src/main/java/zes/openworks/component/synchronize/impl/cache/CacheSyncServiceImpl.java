/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.synchronize.impl.cache;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.support.CacheHelper;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.component.synchronize.SynchronizeService;
import zes.openworks.component.synchronize.SynchronizeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 케쉬 정보 동기화 서비스
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
 *  2012. 5. 7.    방기배   신규 생성
 * </pre>
 * @see
 */
@Service("cacheSyncService")
public class CacheSyncServiceImpl extends EgovAbstractMapper implements SynchronizeService {

    /**
     * 케시 정보 동기화
     */
    @Override
    public void synchronize(HttpServletRequest request, SynchronizeVO synchronizeVo) throws Exception {

        OpHelper.bindRequestMap(synchronizeVo, request);
        Map<String, Object> paramMap = synchronizeVo.getDataMap();

        // 케쉬 정보 재설정
        if(Validate.isNotEmpty(synchronizeVo.getDomainCd())) {
            CacheHelper.cacheReload((String) paramMap.get("cacheName"), synchronizeVo.getDomainCd(), getSqlSession());
        } else {
            CacheHelper.cacheReload((String) paramMap.get("cacheName"), getSqlSession());
        }

    }

}
