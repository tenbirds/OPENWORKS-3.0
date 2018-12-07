/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.note;

import zes.openworks.intra.login.LoginVO;

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
 *  2012. 5. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class NoteUserTreeVO extends NoteVO {

    static final long serialVersionUID = 4083481685889428643L;

    /** 로그인 정보 */
    private LoginVO loginVo;

    /**
     * LoginVO loginVo을 반환
     * 
     * @return LoginVO loginVo
     */
    public LoginVO getLoginVo() {
        return loginVo;
    }

    /**
     * loginVo을 설정
     * 
     * @param loginVo 을(를) LoginVO loginVo로 설정
     */
    public void setLoginVo(LoginVO loginVo) {
        this.loginVo = loginVo;
    }

}
