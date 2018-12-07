/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.certfc.bizrno;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.openworks.intra.cms.support.CmsUtil;


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
 * 2014. 11. 21.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/common/bizrno")
public class BizrNoChkController {
    /**
     * 사업자번호인증 샘플메인
     */
    @RequestMapping(value = "niceCheck.do", method = RequestMethod.GET)
    public void ipinMain() throws UnsupportedEncodingException {

    }

    /**
     * 사업자번호인증 결과
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "rnCheckRequest.do")
    public void ipinResult(HttpServletRequest request, ModelMap model) throws UnsupportedEncodingException {
        
        String hostNm = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        String bizNo = request.getParameter("bizNo");
        String bizName = request.getParameter("bizName");        
        model.addAttribute("bizNo", bizNo);
        model.addAttribute("bizName", bizName);
        model.addAttribute("SubDomain", hostNm);        
    }
}
