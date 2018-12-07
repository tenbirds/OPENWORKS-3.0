/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.controller;

import javax.servlet.http.HttpServletRequest;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.openworks.intra.login.LoginVO;

/**
 * 관리자단 공통 컨트롤러
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
 *  2012. 4. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class IntraController extends GeneralController {

    /**
     * <code>HttpServletRequest</code>에서 관리자 세션정보 얻기
     */
    public static LoginVO getLoginSession(HttpServletRequest request) {
        return OpHelper.getMgrSession(request);
    }

    /**
     * 관리자 권한이 있는지 확인하여 반환한다.
     * 
     * @param request
     * @return
     */
    public static boolean isSuperUser(HttpServletRequest request) {

        String assign = (String) request.getAttribute("MenuAssignType");

        return (assign != null && assign.equals("G") ? true : false);
    }
}
