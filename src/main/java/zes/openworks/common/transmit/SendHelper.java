/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.openworks.common.transmit.SenderFactory.SendType;

/**
 * 메시지 발송 헬퍼 클레스
 * 커플링을 해소 하기 위한 중간 역할
 * 
 * @version 1.0
 * @since openmonitor-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 9. 25.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class SendHelper {

    /** CmsSupport.class logger */
    private static Logger logger = LoggerFactory.getLogger(SendHelper.class);

    private SendHelper() {
    }

    public static boolean send(Properties props, String sendType) {

        return send(props, SendType.valueOf(sendType));
    }

    public static boolean send(Properties props, SendType sendType) {

        Sender sender = SenderFactory.getInstance(sendType);

        try {
            sender.setProperties(props);
            sender.send();
        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.info("{} 전송을 실패하였습니다.", sendType, e);
            }
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }

}
