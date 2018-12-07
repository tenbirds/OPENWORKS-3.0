/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.consumer;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * SNS 서비스 사용자에 등록한 사용자 인증 아이디 및 인증 키 관리 DAO
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
public class ConsumerDAO extends EgovAbstractMapper {

    /**
     * SNS 서비스 사용자 정보 목록
     * 
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<ConsumerVO> getConsumerList(ConsumerVO consumerVo) throws Exception {

        return list("_sns.consumer.getConsumerList", consumerVo);
    }

    /**
     * SNS 서비스 사용자 정보
     * 
     * @return
     * @throws Exception
     */
    public ConsumerVO getConsumer(ConsumerVO consumerVo) throws Exception {

        return (ConsumerVO) selectByPk("_sns.consumer.getConsumer", consumerVo);
    }

    /**
     * SNS 서비스 사용자 정보 등록
     * 
     * @param consumerVo
     * @return 신규정보 키값
     * @throws Exception
     */
    public Integer insertConsumer(ConsumerVO consumerVo) throws Exception {

        return insert("_sns.consumer.insertConsumer", consumerVo);
    }

    /**
     * SNS 서비스 사용자 정보 수정
     * 
     * @param consumerVo
     * @return 수정건수
     * @throws Exception
     */
    public Integer updateConsumer(ConsumerVO consumerVo) throws Exception {

        return update("_sns.consumer.updateConsumer", consumerVo);
    }

    /**
     * SNS 서비스 사용자 정보 사용여부 수정
     * 
     * @param consumerVo
     * @return 수정건수
     * @throws Exception
     */
    public Integer updateUseYn(ConsumerVO consumerVo) throws Exception {

        return update("_sns.consumer.updateUseYn", consumerVo);
    }

    /**
     * SNS 서비스 사용자 정보 삭제
     * 
     * @param consumerVo
     * @return 삭제건수
     * @throws Exception
     */
    public Integer deleteConsumer(ConsumerVO consumerVo) throws Exception {

        return delete("_sns.consumer.deleteConsumer", consumerVo);
    }
}
