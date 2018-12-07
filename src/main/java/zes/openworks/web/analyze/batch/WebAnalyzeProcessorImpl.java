/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.analyze.batch;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.schedule.Processor;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 15.    김영상   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class WebAnalyzeProcessorImpl implements Processor {
    
    Logger logger = LoggerFactory.getLogger(WebAnalyzeProcessorImpl.class);

    @Resource
    private WebAnalyzeDAO dao;

    @Override
    public void process() {
        
        InetAddress inet;
        String svrIP = "";
        try {
            inet = InetAddress.getLocalHost();
            svrIP = inet.getHostAddress();
        } catch (UnknownHostException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        if(
            svrIP.equals("202.30.77.182") 
            /*|| svrIP.equals("202.30.77.210")*/
        ){
            logger.debug("======================================================");
            logger.debug("페이지로그 배치시작");

            dao.updateAnlzStatisticFlag(); // 데이터 플래그 수정
            
            dao.mergeAnalyzeFavoritePage(); // 많이 찾는 페이지

            dao.mergeAnalyzeStartPage(); // 시작 페이지

            dao.mergeAnalyzeEndPage(); // 종료 페이지

            logger.debug("배치종료");
            logger.debug("======================================================");
        }
    }
}
