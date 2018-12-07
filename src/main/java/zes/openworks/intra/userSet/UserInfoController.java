/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.userSet;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.utils.StringUtil;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 회원가입정보설정관리 컨트롤 Controller
 * 
 * @author zesinc
 */

@Controller
@RequestMapping(value = "/intra/userSet")
public class UserInfoController extends IntraController {

    @Autowired
    private UserInfoService service;

    /**
     * 회원가입정보설정 기본 항목 화면 LIST
     * 
     * @param
     * @return ModelAndView
     */
    @RequestMapping(value = "BD_index.do")
    @AuthIntra(authType = AuthType.READ)
    public ModelAndView userJoinInfo(ModelAndView view, HttpServletRequest request, @ModelAttribute UserInfoVO vo) throws Exception {

        if("".equals(vo.getIemTy()) || vo.getIemTy() == null) {
            vo.setIemTy("B");
        }

        view.addObject("listCount", service.userInfoCount(vo));
        view.addObject("list", service.userInfoList(vo));
        view.addObject("listUseNm", service.getUseYnNameList());
        view.addObject("userSelect", service.userSelect());
        return view;
    }

    /**
     * 회원가입정보설정 기본 & 추가 항목 수정
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do")
    public String userInfoSetUpdate(ModelMap model, HttpServletRequest request, UserInfoVO vo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        vo.setUpdtId(loginVo.getMngrId());

        int affected = service.userInfoSetUpdate(vo);

        if(affected == StringUtil.ONE) {
            service.userInfoSetLog(vo); // 회원가입정보설정 변경시 이력 LOG 등록
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 회원가입정보설정 회원 선택 여부 수정
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_userSelectUpdate.do")
    public String userSelectUpdate(ModelMap model, HttpServletRequest request, UserInfoVO vo) throws Exception {
        String[] arrItemGubun = request.getParameterValues("selectVal[]");
        
        int affected = service.userSelectUpdate(arrItemGubun);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 회원가입정보설정 관심목록 LIST
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_userInfoInterest.do")
    public ModelAndView interestItemList(ModelAndView view, HttpServletRequest request, @ModelAttribute UserInfoVO vo) throws Exception {

        if("".equals(vo.getIemTy()) || vo.getIemTy() == null) {
            vo.setIemTy("B");
        }

        view.addObject("listCount", service.userInfoCount(vo));
        view.addObject("list", service.userInfoList(vo));
        view.addObject("listUseNm", service.getUseYnNameList());
        view.addObject("userSelect", service.userSelect());
        view.setViewName("/intra/userSet/BD_userInfoInterest");
        return view;
    }

    /**
     * 회원가입정보설정 관심목록 등록
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_interestInsertAction.do", method = RequestMethod.POST)
    public String interestInsert(ModelMap model, HttpServletRequest request, UserInfoVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);

        vo.setUpdtId(loginVo.getMngrId());

        int affected = service.interestInsert(vo);

        String message;
        if(affected == StringUtil.ONE) {
            service.interestSetLog(vo); // 관심목록 등록시 변경 이력 LOG 등록
            message = Messages.COMMON_INSERT_OK;
        } else {
            message = Messages.COMMON_PROCESS_FAIL;
        }

        return alertAndRedirect(model, message, "/intra/userSet/BD_userInfoInterest.do");
    }

    /**
     * 회원가입정보설정 관심목록 수정
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_interestUpdateAction.do")
    public String interestUpdate(ModelMap model, HttpServletRequest request, UserInfoVO vo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        vo.setUpdtId(loginVo.getMngrId());

        int affected = service.interestUpdate(vo);

        if(affected == StringUtil.ONE) {
            service.interestSetLog(vo); // 관심목록 수정시 변경 이력 LOG 등록
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 회원가입정보설정 관심목록 삭제
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_interestDeleteAction.do")
    public String interestDelete(ModelMap model, HttpServletRequest request, UserInfoVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);

        vo.setUpdtId(loginVo.getMngrId());

        int affected = service.interestDelete(vo);

        if(affected == StringUtil.ONE) {
            service.interestSetLog(vo); // 관심목록 삭제시 변경 이력 LOG 등록
            return alertAndRedirect(model, Messages.COMMON_DELETE_OK, "/intra/userSet/BD_userInfoInterest.do");
        }
        return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, "/intra/userSet/BD_userInfoInterest.do");
    }

    /**
     * 회원가입정보 변경 이력 LIST
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_userInfoLog.do")
    public ModelAndView userInfoLogList(ModelAndView view, HttpServletRequest request,
        @ModelAttribute UserInfoVO vo) {

        List<UserInfoVO> list = service.setLogList();

        int listLen = list.size();

        view.addObject("list", list);
        view.addObject("listLen", listLen);

        return view;
    }
}
