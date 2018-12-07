/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter.batch;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.schedule.Processor;

/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 8. 25.    방기배       신규
 *</pre>
 * @see
 */
public class NewsLetterDeleteExpiredCrtfcBatchProcessor implements Processor {
    Logger logger = LoggerFactory.getLogger(NewsLetterDeleteExpiredCrtfcBatchProcessor.class);

    @Resource
    private NewsLetterDeleteExpiredCrtfcBatchService newsLetterDeleteExpiredCrtfcBatchService;
    
    @Override
    public void process() {
        // TODO Auto-generated method stub
        
        logger.info("======================================================");
        logger.info("뉴스레터 만료된 인증 삭제 시작");

        newsLetterDeleteExpiredCrtfcBatchService.newsLetterExpiredCrtfcDelete();

        logger.info("뉴스레터 만료된 인증 삭제 끝");
        logger.info("======================================================");
        
        logger.info("======================================================");
        logger.info("뉴스레터 테이블에서 회원테이블에 존재하는 이메일이 있으면 삭제 시작");

        newsLetterDeleteExpiredCrtfcBatchService.newsLetterMemberDelete();

        logger.info("뉴스레터 테이블에서 회원테이블에 존재하는 이메일이 있으면 삭제  끝");
        logger.info("======================================================");
    }
}
