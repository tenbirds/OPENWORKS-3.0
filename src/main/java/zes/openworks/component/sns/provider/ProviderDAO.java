/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.provider;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.core.lang.Validate;
import zes.openworks.component.sns.consumer.ConsumerVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * SNS 서비스 제공자 연계 정보 관리 DAO
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
@Repository
public class ProviderDAO extends EgovAbstractMapper {

    /**
     * SNS 서비스 제공자 연계 정보 목록
     * 
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<ProviderVO> getProviderList(ProviderVO providerVo) throws Exception {

        return list("_sns.provider.getProviderList", providerVo);
    }

    /**
     * SNS 서비스 제공자 연계 정보
     * 
     * @return
     * @throws Exception
     */
    public ProviderVO getProvider(ProviderVO providerVo) throws Exception {

        return (ProviderVO) selectByPk("_sns.provider.getProvider", providerVo);
    }

    /**
     * SNS 서비스 제공자 연계 정보 등록
     * 
     * @param providerVo
     * @return 신규정보 키값
     * @throws Exception
     */
    public Integer insertProvider(ProviderVO providerVo) throws Exception {

        return insert("_sns.provider.insertProvider", providerVo);
    }

    /**
     * SNS 서비스 제공자 연계 정보 수정
     * 
     * @param providerVo
     * @return 수정건수
     * @throws Exception
     */
    public Integer updateProvider(ProviderVO providerVo) throws Exception {

        return update("_sns.provider.updateProvider", providerVo);
    }

    /**
     * SNS 서비스 제공자 연계 정보 사용여부 수정
     * 
     * @param providerVo
     * @return 수정건수
     * @throws Exception
     */
    public Integer updateUseYn(ProviderVO providerVo) throws Exception {

        return update("_sns.provider.updateUseYn", providerVo);
    }

    /**
     * SNS 서비스 제공자 연계 정보 삭제
     * 
     * @param providerVo
     * @return 삭제건수
     * @throws Exception
     */
    public Integer deleteProvider(ProviderVO providerVo) throws Exception {

        ConsumerVO consumerVo = new ConsumerVO();
        consumerVo.setServiceId(providerVo.getServiceId());

        ConsumerVO consuVo = (ConsumerVO) selectByPk("_sns.consumer.getConsumer", consumerVo);

        if(Validate.isEmpty(consuVo)) {
            return new Integer(0);
        }

        return delete("_sns.provider.deleteProvider", providerVo);
    }
}
