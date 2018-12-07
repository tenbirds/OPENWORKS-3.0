/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.suppost.evl;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.login.UserLoginVO;

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
 *  2014. 11. 14.    이슬버미       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/sale/support/evl")
public class WebGoodsEvlController extends WebController {

    @Autowired
    WebGoodsEvlService service;

    /**
     * index (문의 목록)
     * 
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public String index(HttpServletRequest request, ModelMap model, WebGoodsEvlVO vo, @PathVariable String pathLang) {

        // 언어 적용 Url
        String baseURL = getBaseUrl(model, pathLang);

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + pathLang + "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        // 언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())) {
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }

        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_goodsTy", service.goodsTyList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.evlList(vo));

        return baseURL + "/BD_index";

    }

    /**
     * myQnaList (서비스평)
     * 
     * @param request
     * @param model
     * @param vo
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "BD_myEvlList.do", method = RequestMethod.GET)
    public String myEvlList(HttpServletRequest request, ModelMap model, WebGoodsEvlVO vo, @PathVariable String pathLang) {

        // 언어 적용 Url
        String baseURL = getBaseUrl(model, pathLang);

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_myEvlList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + pathLang + "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            vo.setRegistId(userLoginVO.getUserId());
        }

        OpHelper.bindSearchMap(vo, request);

        // 언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())) {
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }

        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_goodsTy", service.goodsTyList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.evlList(vo));

        return baseURL + "/BD_myEvlList";

    }

}
