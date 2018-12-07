/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns;

import zes.openworks.common.Messages;

/**
 * SNS 관리 개별 메시지 클레스
 * 
 * @version 1.0
 * @since openworks 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 10. 4.    방기배       신규
 * </pre>
 * @see
 */
public class SnsMessages extends Messages {

    /** 중복 등록시 메시지 */
    public static final String SNS_DUPLICATE = "이미 등록된 서비스입니다.";
}
