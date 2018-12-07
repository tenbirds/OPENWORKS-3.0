/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.provider;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.openworks.component.sns.SnsHelper;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * SNS 서비스 제공자 연계 정보 관리 구현체
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
 *  2013. 8. 14.    방기배       신규
 * </pre>
 * @see
 */
@Service("providerService")
public class ProviderServiceImpl extends AbstractServiceImpl implements ProviderService {

    @Resource
    private ProviderDAO providerDao;

    @Override
    public List<ProviderVO> getProviderList(ProviderVO providerVo) throws Exception {

        return providerDao.getProviderList(providerVo);
    }

    @Override
    public ProviderVO getProvider(ProviderVO providerVo) throws Exception {

        return providerDao.getProvider(providerVo);
    }

    @Override
    public Integer insertProvider(ProviderVO providerVo) throws Exception {

        Integer cnt = providerDao.insertProvider(providerVo);

        if(cnt > 0) {
            // 케쉬 정보 재설정
            SnsHelper.cacheReload(providerDao.getSqlSession());
        }

        return cnt;
    }

    @Override
    public Boolean updateProvider(ProviderVO providerVo) throws Exception {

        Integer cnt = providerDao.updateProvider(providerVo);

        if(cnt.equals(0)) {
            return Boolean.FALSE;
        }

        // 케쉬 정보 재설정
        SnsHelper.cacheReload(providerDao.getSqlSession());

        return Boolean.TRUE;
    }

    @Override
    public Boolean updateUseYn(ProviderVO providerVo) throws Exception {

        Integer cnt = providerDao.updateUseYn(providerVo);

        if(cnt.equals(0)) {
            return Boolean.FALSE;
        }

        // 케쉬 정보 재설정
        SnsHelper.cacheReload(providerDao.getSqlSession());

        return Boolean.TRUE;
    }

    @Override
    public Boolean deleteProvider(ProviderVO providerVo) throws Exception {

        Integer cnt = providerDao.deleteProvider(providerVo);

        if(cnt.equals(0)) {
            return Boolean.FALSE;
        }

        // 케쉬 정보 재설정
        SnsHelper.cacheReload(providerDao.getSqlSession());

        return Boolean.TRUE;
    }

}
