/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.consumer;

import java.util.List;

/**
 * SNS 서비스 사용자에 등록한 사용자 인증 아이디 및 인증 키 관리 인터페이스
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
public interface ConsumerService {

    /**
     * SNS 서비스 사용자 연계 정보 목록
     * 
     * @return
     * @throws Exception
     */
    public List<ConsumerVO> getConsumerList(ConsumerVO consumerVo) throws Exception;

    /**
     * SNS 서비스 사용자 연계 정보
     * 
     * @return
     * @throws Exception
     */
    public ConsumerVO getConsumer(ConsumerVO consumerVo) throws Exception;

    /**
     * SNS 서비스 사용자 연계 정보 등록
     * 
     * @param consumerVo
     * @return 신규정보 키값
     * @throws Exception
     */
    public Integer insertConsumer(ConsumerVO consumerVo) throws Exception;

    /**
     * SNS 서비스 사용자 연계 정보 수정
     * 
     * @param consumerVo
     * @return 수정건수
     * @throws Exception
     */
    public Boolean updateConsumer(ConsumerVO consumerVo) throws Exception;

    /**
     * SNS 서비스 사용자 연계 정보 사용여부 수정
     * 
     * @param consumerVo
     * @return 수정건수
     * @throws Exception
     */
    public Boolean updateUseYn(ConsumerVO consumerVo) throws Exception;

    /**
     * SNS 서비스 사용자 연계 정보 삭제
     * 
     * @param consumerVo
     * @return 삭제건수
     * @throws Exception
     */
    public Boolean deleteConsumer(ConsumerVO consumerVo) throws Exception;

}
