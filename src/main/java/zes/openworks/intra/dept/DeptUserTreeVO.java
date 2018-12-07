/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

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
 *  2012. 4. 30.    유상원   부서 관리
 * </pre>
 * @see
 */
public class DeptUserTreeVO extends DeptVO {

    static final long serialVersionUID = 4083481685889428643L;

    /** 정렬순서 */
    private String flag;

    /** 로그인 정보 */
    private LoginVO loginVo;

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public LoginVO getLoginVo() {
        return loginVo;
    }

    public void setLoginVo(LoginVO loginVo) {
        this.loginVo = loginVo;
    }
}
