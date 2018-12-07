/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.authStat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.openworks.common.controller.IntraController;

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
 *  2012. 5. 17.    이찬희   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/authStat")
public class AuthStatController extends IntraController {

    @Autowired
    private AuthStatService service;

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "BD_index.do")
    public void personPerAuth(ModelMap model, HttpServletRequest request) {
        model.addAttribute("stat", service.getPersonPerAuth(request.getParameterMap()));
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "BD_webPerYear.do")
    public void authWebLoggingPerYear(ModelMap model, HttpServletRequest request) {
        model.addAttribute("chart", service.getAuthWebLoggingPerMonth4Chart(request.getParameterMap()));
        model.addAttribute("stat", service.getAuthWebLoggingPerYear(request.getParameterMap()));
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "BD_webPerMonth.do")
    public void authWebLoggingPerMonth(ModelMap model, HttpServletRequest request) {
        model.addAttribute("chart", service.getAuthWebLoggingPerMonth4Chart(request.getParameterMap()));
        model.addAttribute("stat", service.getAuthWebLoggingPerMonth(request.getParameterMap()));
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "BD_webPerDay.do")
    public void authWebLoggingPerDay(ModelMap model, HttpServletRequest request) {
        model.addAttribute("chart", service.getAuthWebLoggingPerDay4Chart(request.getParameterMap()));
        model.addAttribute("stat", service.getAuthWebLoggingPerDay(request.getParameterMap()));
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "BD_authPerDept.do")
    public void authPerDept(ModelMap model, HttpServletRequest request) {
        model.addAttribute("stat", service.getAuthPerDept(request.getParameterMap()));
    }

}
