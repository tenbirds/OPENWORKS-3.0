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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import zes.base.support.OpHelper;
import zes.core.crypto.ARIACrypto;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.StringUtil;
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
@RequestMapping(value = "/intra/weblog")
public class WeblogSsoController extends IntraController {
private String WeblogServer = new String();
    
    /**
     * 웹로그시스템 모니터링 SSO 연동
     * @param model 
     */
    @RequestMapping(value = "BD_webLogSSo.do", method = RequestMethod.GET)
    public String mailSSo(HttpServletRequest request, ModelMap model) {

        // sso연동할 호스트 어드레스 global-config.xml에 있음
        /* 20150812 웹로그 링크 추가  시작 */
        //WeblogServer = Config.getString("weblog.MonitorAddr"); 20150812 수정전 원본
        String linkNo = request.getParameter("linkNo");
        
        if(linkNo.equals("1")) {
            linkNo = "weblog.MonitorAddr";
        }
        else if(linkNo.equals("2")) {
            linkNo = "weblog.MonitorAddr_Test";
        }
        else {
            linkNo = "weblog.MonitorAddr";
        }
        
        WeblogServer = Config.getString(linkNo);
        /* 20150812 웹로그 링크 추가  끝 */

        // 로그인 ID 가져오기
        LoginVO LV = OpHelper.getMgrSession(request);

        // 로그인이 안되어 있으면
        if(LV == null){
            return "redirect:/login/mgr/ND_index.do";
        }
        //웹로그시스템과 약속된 공용아이디
        String MgrId = "wiselog";

        ARIACrypto AC = new ARIACrypto();

        // 암호화 진행
        String qs = AC.encrypt(MgrId);
        // unicode로 변환
        qs = StringUtil.URLEncoder(qs);
        // 모니터링시스템으로 gogo
        return "redirect:" + WeblogServer + qs;

    }
}
