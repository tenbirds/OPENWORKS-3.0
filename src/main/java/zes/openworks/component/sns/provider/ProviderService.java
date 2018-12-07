/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.provider;

import java.util.List;

/**
 * SNS 서비스 제공자 연계 정보 관리 인터페이스
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
public interface ProviderService {

    /**
     * SNS 서비스 제공자 연계 정보 목록
     * 
     * @return
     * @throws Exception
     */
    public List<ProviderVO> getProviderList(ProviderVO providerVo) throws Exception;

    /**
     * SNS 서비스 제공자 연계 정보
     * 
     * @return
     * @throws Exception
     */
    public ProviderVO getProvider(ProviderVO providerVo) throws Exception;

    /**
     * SNS 서비스 제공자 연계 정보 등록
     * 
     * @param providerVo
     * @return 신규정보 키값
     * @throws Exception
     */
    public Integer insertProvider(ProviderVO providerVo) throws Exception;

    /**
     * SNS 서비스 제공자 연계 정보 수정
     * 
     * @param providerVo
     * @return 수정건수
     * @throws Exception
     */
    public Boolean updateProvider(ProviderVO providerVo) throws Exception;

    /**
     * SNS 서비스 제공자 연계 정보 사용여부 수정
     * 
     * @param providerVo
     * @return 수정건수
     * @throws Exception
     */
    public Boolean updateUseYn(ProviderVO providerVo) throws Exception;

    /**
     * SNS 서비스 제공자 연계 정보 삭제
     * 
     * @param providerVo
     * @return 삭제건수
     * @throws Exception
     */
    public Boolean deleteProvider(ProviderVO providerVo) throws Exception;

}
