/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.auth;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.openworks.common.GlobalConfig;

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
 *  2012. 5. 8.    이찬희   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/authComm")
public class AuthCommonController {

    @Resource(name = "authService")
    private AuthService service;

    /**
     * 부서별 할당권한 목록
     */
    @RequestMapping(value = "PD_authMenuList.do", method = RequestMethod.GET)
    public void authMenuList(AuthVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.authMenuList(vo));
    }
}
