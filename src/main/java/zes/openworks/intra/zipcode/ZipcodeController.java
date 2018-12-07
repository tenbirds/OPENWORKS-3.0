/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.zipcode;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.openworks.common.controller.IntraController;

/**
 * 우편번호관리 컨트롤 Controller
 *
 * @author zesinc
 */

@Controller
@RequestMapping(value = "/intra/zipcode")
public class ZipcodeController extends IntraController {

    /**
     * 우편번호 목록 조회
     *
     * @param
     * @return ModelMap
     */
    @RequestMapping(value = "PD_searchList.do")
    public void zipcodeList(ModelMap model, HttpServletRequest request, @ModelAttribute ZipcodeVO vo) throws Exception {

    }

    @RequestMapping(value = "AjaxRequestXML.do")
    public void AjaxRequestXML(ModelMap model, HttpServletRequest request) throws Exception {

    }
}
