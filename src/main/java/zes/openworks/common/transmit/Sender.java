/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.transmit;

import java.util.Properties;

/**
 * 메시지 송신 인터페이스
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
public interface Sender {

    /**
     * 송신에 필요한 정보 설정
     * 실 전송 클레스에서 필요한 속성들을 설정
     * 
     * @param props
     * @throws Exception
     */
    Sender setProperties(Properties props) throws Exception;

    /**
     * 발송
     * 속성 설정에서 발송에 필요한 정보가 모두 설정 되었다면 최종 발송을 한다.
     * 
     * @throws Exception
     */
    boolean send();

}
