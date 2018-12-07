/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.extSysSso;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import zes.base.support.OpHelper;
import zes.core.crypto.ARIACrypto;
import zes.core.spi.commons.configuration.Config;
//import zes.core.utils.StringUtil;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;
/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 8.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/mail")
public class EmsSsoController extends IntraController {
private String MailServer = new String();
    
    /**
     * EMS 메일 시스템 SSO 연동
     */
    @RequestMapping(value = "BD_emsSSo.do", method = RequestMethod.GET)
    public String mailSSo(HttpServletRequest request) {

        // sso연동할 호스트 어드레스 global-config.xml에 있음
        MailServer = Config.getString("mail.mailSsoAddr");

        // 로그인 ID 가져오기
        LoginVO LV = OpHelper.getMgrSession(request);

        // 로그인이 안되어 있으면
        if(LV == null){
            return "redirect:/login/mgr/ND_index.do";
        }

        String MgrId = LV.getMngrId().trim();

        // 로그인이 안되어 있으면
        if(MgrId == null || MgrId.length() < 1){
            return "redirect:/login/mgr/ND_index.do";
        }

        ARIACrypto AC =  new ARIACrypto();

        // 암호화 진행
        String qs = AC.encrypt(MgrId);

        // unicode로 변환
        //qs = StringUtil.URLEncoder(qs);

        // 메일시스템으로 gogo
        return "redirect:" + MailServer + qs;

    }
}
