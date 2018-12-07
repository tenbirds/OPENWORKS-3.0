/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myGoods;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;

@Controller
@RequestMapping(value = "/**/mygoods")
public class MyGoodsController extends GeneralController {

    @Autowired
    MyGoodsService service;

    @Autowired
    CommonDutyService commonService;

    public String requestUrl(HttpServletRequest request) {

        //String responseUrl = request.getRequestURI();
        /*이전소스
          return responseUrl.substring(0, responseUrl.lastIndexOf("/"));*/     
        return "/korean/pt/mygoods";
     
    }

    public String serverNm(HttpServletRequest request) {

        /* 이전소스
        String serverNm = request.getServerName();
        return "/"+serverNm.substring(0, serverNm.indexOf("."));
        */

        String serverNm = "korean";
        return "/"+serverNm;

    }

    public String Language(HttpServletRequest request) {
        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }

    @RequestMapping(value = "BD_purchsList.do")
    public String purchsList(HttpServletRequest request, ModelMap model, MyGoodsVO vo) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_purchsList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), serverNm(request) + "/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

//        // 판매하기 권한 체크
//        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
//            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
//        }

        OpHelper.bindSearchMap(vo, request);

        vo.setLangCode(Language(request));

        model.addAttribute(GlobalConfig.KEY_CODE_LIST, commonService.serviceLangList());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.purchsIndex(vo));

        return requestUrl(request) + "/BD_purchsList";
    }

    @RequestMapping(value = "BD_cnslList.do")
    public String cnsList(HttpServletRequest request, ModelMap model, MyGoodsVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_cnslList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), serverNm(request) + "/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

//        // 판매하기 권한 체크
//        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
//            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
//        }

        OpHelper.bindSearchMap(vo, request);
        vo.setLangCode(Language(request));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, commonService.serviceLangList());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.cnsIndex(vo));

        return requestUrl(request) + "/BD_cnslList";
    }

    @RequestMapping(value = "BD_intrstPrdtList.do")
    public String prdtIntrstList(HttpServletRequest request, ModelMap model, MyGoodsVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_intrstPrdtList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), serverNm(request) + "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

//        // 판매하기 권한 체크
//        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
//            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
//        }

        OpHelper.bindSearchMap(vo, request);
        vo.setLangCode(Language(request));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, commonService.serviceLangList());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.intrstIndex(vo));        
        return requestUrl(request) + "/BD_intrstPrdtList";
    }

    @RequestMapping(value = "ND_intrstPrdtDelete.do")
    public String prdtIntrstDelete(HttpServletRequest request, ModelMap model, MyGoodsVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_intrstPrdtList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), serverNm(request) + "/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

//        // 판매하기 권한 체크
//        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
//            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
//        }

        OpHelper.bindSearchMap(vo, request);
        vo.setLangCode(Language(request));
        if(service.intrstDelete(vo) == StringUtil.ONE) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "watchDeleteOk"));
        }
        return responseJson(model, Messages.FALSE, "watchFail");
    }

    @RequestMapping(value = "BD_recentPrdtList.do")
    public String recentPrdtIntrstList(HttpServletRequest request, ModelMap model, MyGoodsVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_recentPrdtList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), serverNm(request) + "/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

//        // 판매하기 권한 체크
//        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
//            return alertAndBack(model, MessageHelper.getMsg(request, "noAuth"));
//        }

        OpHelper.bindSearchMap(vo, request);
        vo.setLangCode(Language(request));
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, commonService.serviceLangList());
        model.addAttribute(GlobalConfig.KEY_PAGER, service.recentIndex(vo));
        return requestUrl(request) + "/BD_recentPrdtList";
    }

}
