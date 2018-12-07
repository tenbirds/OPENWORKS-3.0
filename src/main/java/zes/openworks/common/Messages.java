/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.openworks.common;

import zes.base.BaseMessages;
import zes.core.spi.commons.configuration.Config;

/**
 * BaseMessage 클레스에 시스템에 정의된 공통 메시지 상속받고 있으며
 * 정의 되지 않은 이외의 전역 공통의 메시지를 설정하여 사용한다. <br />
 * config/common/message-config.xml 파일 내용 참조
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
 *  2012. 5. 16.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class Messages extends BaseMessages {
    public static final String MOVE_MODIFY_PAGE = msg("msg.moveMemModifyPage");
    public static final String MOVE_WITHDRAW_PAGE = msg("msg.moveWithdrawPage");
    public static final String DONE_WITHDRAW = msg("msg.doneWithdraw");
    public static final String DEL_MENU_AUTH_ASGN = msg("msg.delMenuAuthAsgn");    
    public static final String NO_AUTH = msg("msg.noAuth");
    public static final String LOGIN_ID_PWD_VALID = msg("msg.loginIdPwdValid");
    
    //이벤트관련
    public static final String LOGIN_CHK = msg("msg.userLoginCheck");
    public static final String EVENT_ANSWER_CHK = msg("msg.chkEventAnswer"); 
    public static final String EVENT_APPLCN = msg("msg.eventApplcn");
    public static final String EVENT_MODI = msg("msg.eventModi");
    public static final String EVENT_DEL = msg("msg.eventDel");
    
    //스토어    
    public static final String GOODS_HIDDEN = msg("msg.goodsHidden");
    public static final String INC_INQUIRY_CHK = msg("msg.incInquiryCheck");
    
    
    
    /**
     * 기본 메시지
     * 
     * @param key
     * @return
     */
    private static String msg(String key) {
        return Config.getString(key);
    }
    
  
    
}
