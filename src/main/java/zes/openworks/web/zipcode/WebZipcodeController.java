/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.zipcode;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.openworks.common.controller.WebController;
import zes.openworks.intra.zipcode.ZipcodeVO;


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
 * 2014. 10. 17.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/web/zipcode")
public class WebZipcodeController extends WebController {
    /**
     * 우편번호 목록 조회
     * 
     * @param
     * @return ModelMap
     */
    @RequestMapping(value = "PD_searchList.do")
    public void zipcodeList(ModelMap model, HttpServletRequest request, @ModelAttribute ZipcodeVO vo) throws Exception {
        /*OpHelper.bindSearchMap(vo, request);
        String sidoCd = request.getParameter("q_sidoCd");
        if(Validate.isEmpty(sidoCd)) {
            vo.setSidoCd("11");
        } else {
            vo.setSidoCd(sidoCd);
        }
        String sigunguCd = request.getParameter("q_sigunguCd");
        if(Validate.isEmpty(sigunguCd)) {
            vo.setSigunguCd("680");
        } else {
            vo.setSigunguCd(sigunguCd);
        }
        model.addAttribute(GlobalConfig.KEY_PAGER, service.zipcodeList(vo));*/

    }
    
    @RequestMapping(value = "AjaxRequestXML.do")
    public void AjaxRequestXML(ModelMap model, HttpServletRequest request) throws Exception {
    }
}
