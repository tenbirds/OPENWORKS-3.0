/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.sale.goods.WebGoodsManageVO;
import zes.openworks.web.sale.goods.WebGoodsService;

@Controller
@RequestMapping(value = "/**/sale")
public class SleController extends WebController {

    @Autowired SleService service;
    @Autowired CommonDutyService commonService;
    @Autowired WebGoodsService webGoodsService;


    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    public String serverNm(HttpServletRequest request) {
        String serverNm = request.getServerName();
        return "/"+serverNm.substring(0, serverNm.indexOf("."));
    }

    public String Language(HttpServletRequest request) {
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        return commonService.getLangCd(Integer.parseInt(domainCd));
    }

    @RequestMapping(value = "BD_index.do")
    public String index(HttpServletRequest request, ModelMap model, SleVO vo) {
        // 로그인 회원 체크
        UserLoginVO userLoginVO     = OpHelper.getUserSession(request);
        
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_index.do";
            return alertAndRedirect(model,MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            vo.setUserId(userLoginVO.getUserId());
            vo.setMasterId(userLoginVO.getMasterId());
        }

        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
            //return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");          
        }

        WebGoodsManageVO goodsVo = new WebGoodsManageVO();
        goodsVo.setLangCode(Language(request));
        goodsVo.setUserId(userLoginVO.getUserId());

        List<WebGoodsManageVO> storeLangList = webGoodsService.storeLangList(goodsVo);
        for(int i = 0; i < storeLangList.size() ; i++) { if("Y".equals(storeLangList.get(i).getStoreSction())){ storeLangList.get(0).setStoreSction("Y");}}
        model.addAttribute("storeLangList", storeLangList); // 스토어언어조회
        model.addAttribute("storeLangNm", webGoodsService.storeLangNm(goodsVo.getLangCode()));

//        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.goodsOrder(vo));
        Integer[] ctgryClCd;
        ctgryClCd = new Integer[] {1001,1002,1003};
        vo.setCtgryClCd(ctgryClCd);
        // 처리해야할 상세정보(견적)요청서
        model.addAttribute("orderG", service.goodsOrder(vo));
        model.addAttribute("orderGCount", service.goodsOrderCount(vo));
        // 입찰참여(응찰) 현황
        model.addAttribute("buying", service.buyingRequest(vo));
        // 승인 대기 서비스현황
        model.addAttribute("waitG", service.goodsWait(vo));
        model.addAttribute("waitGCount", service.goodsWaitCount(vo));
        // 답변대기 Q&amp;A
        model.addAttribute("inqr", service.goodsInqr(vo));
        model.addAttribute("inqrCount", service.goodsInqrCount(vo));
        vo.setLangCode(Language(request));
        // 답변대기 비즈매칭
        model.addAttribute("biz", service.goodsBiz(vo));
        model.addAttribute("bizCount", service.goodsBizCount(vo));        
        // 씨앗공지
        model.addAttribute("noti", service.goodsNoti(vo));       
        // 의견공유
        model.addAttribute("subBoard", service.goodsSubBoard(vo));  

        /*
        ctgryClCd = new Integer[] {1003};
        vo.setCtgryClCd(ctgryClCd);
        model.addAttribute("orderC", service.goodsOrder(vo));
        model.addAttribute("orderCCount", service.goodsOrderCount(vo));
        model.addAttribute("waitC", service.goodsWait(vo));
        model.addAttribute("waitCCount", service.goodsWaitCount(vo));
        */
        
        return requestUrl(request) + "/BD_index";
    }

    @RequestMapping(value = "BD_noGradeMember.do")
    public String noGradeMember(HttpServletRequest request, ModelMap model, UserLoginVO userVO) {

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_noGradeMember.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/korean/pt/login/user/BD_index.do" + returnUrl);
        } else {
            model.addAttribute("userVo",userLoginVO);
        }

        return requestUrl(request) + "/BD_noGradeMember";
    }
}
