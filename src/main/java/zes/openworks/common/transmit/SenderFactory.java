/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit;

import zes.openworks.common.transmit.sender.email.EmailSender;
import zes.openworks.common.transmit.sender.sendmail.SendMailSender;
import zes.openworks.common.transmit.sender.sms.SmsSender;

/**
 * 요청에 따른 전송 클레스 생성 반환
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
public class SenderFactory {

    /**
     * 전송 가능 방식 목록 정의
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
     *  2012. 3. 23.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
     * </pre>
     * @see
     */
    public enum SendType {
        SMS, EMAIL, SEND_MAIL
    }

    /**
     * 별칭으로 전송 클레스 반환
     * 
     * <pre>
     * SMS : SMS 메시지
     * EMAIL : EMAIL 발송
     * </pre>
     * 
     * @param senderName
     * @return
     */
    public static Sender getInstance(String sendType) {

        return getInstance(SendType.valueOf(sendType));
    }

    /**
     * 별칭으로 전송 클레스 반환
     * 
     * <pre>
     * SMS : SMS 메시지
     * EMAIL : EMAIL 발송
     * </pre>
     * 
     * @param senderType
     * @return
     */
    public static Sender getInstance(SendType sendType) {
        if(SendType.SMS.equals(sendType)) {
            return new SmsSender();
        } else if(SendType.EMAIL.equals(sendType)) {
            return new EmailSender();
        } else if(SendType.SEND_MAIL.equals(sendType)) {
            return new SendMailSender();
        } else {
            new Throwable("지원하지 않는 전송 방식입니다.");
        }
        return null;
    }

}
