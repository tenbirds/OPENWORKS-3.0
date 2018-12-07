/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.quick;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.web.main.MainService;

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
 *  2012. 7. 24.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/web/quick" })
public class QuickController extends GeneralController {

    @Autowired
    private MainService service;

    @RequestMapping(value = "/ND_quickMenu.do")
    public void quickMenu(HttpServletRequest request, ModelMap model) {
        // 퀵
        List<BannerVO> quickMenu = new ArrayList<BannerVO>();
        BannerVO bannerVO = new BannerVO();
        quickMenu = service.quickMenuListToday(bannerVO);
        model.addAttribute("quickMenu", quickMenu);

    }
}
