/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.consumer;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.openworks.component.sns.SnsHelper;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * SNS 서비스 사용자에 등록한 사용자 인증 아이디 및 인증 키 관리 구현체
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
@Service("consumerService")
public class ConsumerServiceImpl extends AbstractServiceImpl implements ConsumerService {

    @Resource
    private ConsumerDAO consumerDao;

    @Override
    public List<ConsumerVO> getConsumerList(ConsumerVO consumerVo) throws Exception {

        return consumerDao.getConsumerList(consumerVo);
    }

    @Override
    public ConsumerVO getConsumer(ConsumerVO consumerVo) throws Exception {

        return consumerDao.getConsumer(consumerVo);
    }

    @Override
    public Integer insertConsumer(ConsumerVO consumerVo) throws Exception {

        Integer cnt = consumerDao.insertConsumer(consumerVo);

        if(cnt > 0) {
            // 케쉬 정보 재설정
            SnsHelper.cacheReload(consumerDao.getSqlSession());
        }

        return cnt;
    }

    @Override
    public Boolean updateConsumer(ConsumerVO consumerVo) throws Exception {

        Integer cnt = consumerDao.updateConsumer(consumerVo);

        if(cnt.equals(0)) {
            return Boolean.FALSE;
        }

        // 케쉬 정보 재설정
        SnsHelper.cacheReload(consumerDao.getSqlSession());

        return Boolean.TRUE;
    }

    @Override
    public Boolean updateUseYn(ConsumerVO consumerVo) throws Exception {

        Integer cnt = consumerDao.updateUseYn(consumerVo);

        if(cnt.equals(0)) {
            return Boolean.FALSE;
        }

        // 케쉬 정보 재설정
        SnsHelper.cacheReload(consumerDao.getSqlSession());

        return Boolean.TRUE;
    }

    @Override
    public Boolean deleteConsumer(ConsumerVO consumerVo) throws Exception {

        Integer cnt = consumerDao.deleteConsumer(consumerVo);

        if(cnt.equals(0)) {
            return Boolean.FALSE;
        }

        // 케쉬 정보 재설정
        SnsHelper.cacheReload(consumerDao.getSqlSession());

        return Boolean.TRUE;
    }

}
