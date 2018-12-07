/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.forn;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.web.g2b.cntrctInfo.CntrctInfoService;

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
 * 2014. 12. 17.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/goodsForn")
public class GoodsFornController extends WebController{

    @Autowired GoodsFornService goodsfornService;
    @Autowired CntrctInfoService cntrctInfoService;

    public boolean peerHandle()  {
        return true;
    }

    @RequestMapping(value = "/BD_goodsForn.do" , method = RequestMethod.GET)
    public String paging(HttpServletRequest request, ModelMap model, GoodsFornVO vo,@PathVariable String pathLang) throws Exception {

        String BaseURL = getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);
        //조회
        model.addAttribute(GlobalConfig.KEY_PAGER, goodsfornService.goodsFornList(vo));
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        return BaseURL + "/BD_goodsForn";

    }

}
