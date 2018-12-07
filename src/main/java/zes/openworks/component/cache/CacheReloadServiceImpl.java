/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.core.utils.SynchronizeUtil;
import zes.openworks.component.domain.DomainDAO;
import zes.openworks.component.domain.DomainGroupVO;
import zes.openworks.component.domain.DomainVO;

/**
 * 케시 정보 동기화
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
 *  2012. 6. 18.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Service("cacheReloadService")
public class CacheReloadServiceImpl implements CacheReloadService {

    @Resource
    private DomainDAO domainDAO;

    @Override
    public String synchronize(CacheReloadVO cacheReloadVo) throws Exception {

        List<DomainGroupVO> domainGroup = domainDAO.getDomainGroupSync(cacheReloadVo.getDomainCd());

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("serviceName", "cacheSyncService");
        param.put("domainCd", cacheReloadVo.getDomainCd());
        param.put("cacheName", cacheReloadVo.getCacheName());

        return SynchronizeUtil.synchronize(domainGroup, param);
    }

    @Override
    public List<DomainVO> getDomainList(DomainVO domainVo) throws Exception {

        return domainDAO.getDomainList(domainVo);
    }
}
