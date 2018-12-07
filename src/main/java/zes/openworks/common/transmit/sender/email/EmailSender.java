/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit.sender.email;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.transmit.Sender;

/**
 * 메일전송 클레스
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
public class EmailSender implements Sender {

    /** 전송에 필요한 정보 설정 */
    private Properties props;
    /** SL4J 로깅 */
    private static Logger logger = LoggerFactory.getLogger(EmailSender.class);
    /** 발송자 이름 */
    private static String senderNm = Config.getString("sender.senderNm");
    /** 발송자 이메일 */
    private static String senderMail = Config.getString("sender.senderEmail");

    @Override
    public Sender setProperties(Properties props) throws Exception {

        this.props = props;

        return this;
    }

    @Override
    public boolean send() {

        Boolean sendTf = Boolean.TRUE;

        // 기본값은 config/commons/global-config.xml 파일 내의 sender 속성 참조
        String senderName = props.getProperty("sender.name");
        if(senderName == null) {
            senderName = senderNm;
        }
        String senderEmail = props.getProperty("sender.email");
        if(senderEmail == null) {
            senderEmail = senderMail;
        }

        logger.debug("senderName is {}, senderEmail is {} ", senderName, senderEmail);

        String content = (String) this.props.get("content");

        // 실 구현시 for 문 내에서 개별전송 실패에 대한 처리 로직이 필요 할수 있음
        try {
            @SuppressWarnings("unchecked")
            List<Map<String, String>> receiptList = (List<Map<String, String>>) this.props.get("user.list");
            if(receiptList != null) {
                for(Map<String, String> receipt : receiptList) {

                    String userName = receipt.get("USER_NAME");
                    String email = receipt.get("EMAIL");

                    logger.debug("useris {}, content is {} ", userName + " : " + email, content);

                    // 설정된 프로퍼티를 사용하여 전송관련 로직 코딩

                }
            }
        } catch (Exception e) {
            if(logger.isDebugEnabled()) {
                logger.info("{} 전송을 실패하였습니다.", "EMAIL", e);
            }
            return Boolean.FALSE;
        }

        return sendTf;
    }
}
