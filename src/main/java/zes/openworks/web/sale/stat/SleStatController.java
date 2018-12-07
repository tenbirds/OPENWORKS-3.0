/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.stat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.store.goods.GoodsManageExcelVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;

@Controller
@RequestMapping(value = "/**/sale/stat")
public class SleStatController extends WebController {

    @Autowired
    SleStatService service;
    @Autowired
    CommonDutyService commonService;

    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    public String serverNm(HttpServletRequest request) {
        String serverNm = request.getServerName();
        return "/" + serverNm.substring(0, serverNm.indexOf("."));
    }

    public String Language(HttpServletRequest request) {
        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }

    @RequestMapping(value = "BD_index.do")
    public String index(HttpServletRequest request, ModelMap model, WebGoodsManageVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_index.do";
            return alertAndRedirect(model, Messages.LOGIN_CHK, "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
        }

        OpHelper.bindSearchMap(vo, request);
        vo.getDataMap().put("q_userId", userLoginVO.getUserId());

        // 언어
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList(vo));

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));

        return requestUrl(request) + "/BD_index";
    }

    @RequestMapping(value = "BD_noGradeMember.do")
    public String noGradeMember(HttpServletRequest request, ModelMap model, UserLoginVO userVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_noGradeMember.do";
            return alertAndRedirect(model, Messages.LOGIN_CHK, "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            model.addAttribute("userVo", userLoginVO);
        }

        return requestUrl(request) + "/BD_noGradeMember";
    }

    /**
     * ctgryList (카테고리 목록)
     *
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value = "ND_ctgryList.do", method = RequestMethod.POST)
    public String ctgryList(WebGoodsManageVO vo, ModelMap model) {

        return responseJson(model, service.ctgryList(vo));
    }

    @RequestMapping(value="INC_EXCEL.do")
    public String excel(ModelMap model, HttpServletRequest request, WebGoodsManageVO vo) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);

        OpHelper.bindSearchMap(vo, request);
        vo.getDataMap().put("q_userId",userLoginVO.getUserId());

        model.put("q_excel", "11"); // 목록별 구분값
        vo.getDataMap().put("q_excel", model.get("q_excel"));
        model.put("_goodsList", service.goodsList(vo));
        model.put("q_excelFileName", "판매하기 통계목록");

        GoodsManageExcelVO GoodsManageExcel = new GoodsManageExcelVO();
        GoodsManageExcel.setModel(model);
        GoodsManageExcel.setHostNm(request.getServerName().substring(0,request.getServerName().indexOf(".")));

        return responseExcel(model, GoodsManageExcel);
    }
}
