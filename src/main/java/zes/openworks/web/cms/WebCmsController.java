/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.cms;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 19.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/web/cms")
public class WebCmsController  extends GeneralController{

    
    /**
     * intrCnToProcess (호환성 절차 안내)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/intrCnToProcess/BD_index.do" , method = RequestMethod.GET)
    public String intrCnToProcess(HttpServletRequest request, ModelMap model) throws Exception{
        return "/web/intrcn/process/BD_index";
    }
    
}
