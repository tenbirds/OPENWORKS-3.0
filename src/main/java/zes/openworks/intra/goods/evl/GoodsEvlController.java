/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.goods.evl;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;


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
 * 2014. 11. 25.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/goods/evl")
public class GoodsEvlController extends IntraController{

    @Autowired private GoodsEvlService service;
    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model,GoodsEvlVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.evlList(vo));

    }
    
    @RequestMapping(value = "ND_ctgryList.do", method = RequestMethod.POST)
    public String ctgryList(GoodsEvlVO vo, ModelMap model ) {
        return responseJson(model, service.ctgryList(vo));
    }
    
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(HttpServletRequest request, ModelMap model,GoodsEvlVO vo){
        
        int affected = service.deleteAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }
    
    
}
