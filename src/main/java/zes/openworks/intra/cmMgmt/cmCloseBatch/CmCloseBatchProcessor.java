/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmCloseBatch;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.schedule.Processor;

/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 12. 16.    		 boseok       	신규
 *</pre>
 * @see
 */
public class CmCloseBatchProcessor implements Processor {

    Logger logger = LoggerFactory.getLogger(CmCloseBatchProcessor.class);

    @Resource
    private CmCloseBatchService cmCloseBatchService;
    
    /* (non-Javadoc)
     * @see zes.openworks.common.schedule.Processor#process()
     */
    @Override
    public void process() {
        // TODO Auto-generated method stub
        
        logger.info("======================================================");
        logger.info("커뮤니티 완전 폐쇄 배치시작");

        cmCloseBatchService.cmCloseBatchSchedule();    //커뮤니티 완전 폐쇄 CMMNTY_STTUS_CD = 1004 업데이트

        logger.info("커뮤니티 완전 폐쇄 배치종료");
        logger.info("======================================================");
    }
}
