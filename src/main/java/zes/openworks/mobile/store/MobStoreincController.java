/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.mobile.store;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.code.CodeService;
import zes.openworks.web.store.StoreincService;
import zes.openworks.web.store.StoreincVO;
import zes.openworks.web.store.premium.PremiumService;


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
 * 2014. 11. 7.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/m/store/inc")
public class MobStoreincController extends WebController{

    @Autowired StoreincService service;
    @Autowired PremiumService  premiumService;
    @Autowired CodeService codeService;
    @Autowired AutoMailService amservice;
    
    /**
     * dstbStoreView (상세 화면 분배)
     * 
     * goodsCode (필수)
     * pageUrlNm (선택 = C : 서비스평, I : 문의하기, RE : 리뷰, RT : 연관 ) 지정 이동
     * => SKYOU 2015.12.16 디자인 변경됨 : tab (inquiry :Q&A, review:리뷰 , :사용화면, cntrct:납품실적, vodplay:소개영상, relation:연관서비스) 
     * @param request
     * @param model
     * @param vo 
     * @param boardVO
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "/BD_storeView.do" , method = {RequestMethod.GET, RequestMethod.POST})
    public String dstbStoreView (HttpServletRequest request, ModelMap model,StoreincVO vo ,@PathVariable String pathLang) {
        
        getBaseUrl(model,pathLang) ;
        
        StringBuffer returnUrl = new StringBuffer();
        String domainNm = service.dstbStoreView(vo);
        if(Validate.isEmpty(domainNm)){
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsHidden"));
        }
        
        if(service.dstbStoreStatus(vo) == StringUtil.ZERO){
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsHidden"));
        }
        
        returnUrl.append("redirect:/");
        returnUrl.append(pathLang);
        returnUrl.append("/m/store/software");
        returnUrl.append("/BD_view.do");
        returnUrl.append("?goodsCode=" + vo.getGoodsCode());
        returnUrl.append("&pageUrlNm=" + vo.getPageUrlNm());
        returnUrl.append("&goodsTyCd=" + domainNm);
        returnUrl.append("&ctgryPath=" + vo.getCtgryPath());
        
        return returnUrl.toString();
    }
       
}
