/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.layout;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.cms.content.ContentService;
import zes.openworks.intra.cms.content.ContentVO;
import zes.openworks.intra.login.LoginVO;

/**
 * 사이트 관리
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 2. 27.
 * @since : OP 1.0
 */
@Controller
@RequestMapping(value = "/intra/cms/layout")
public class LayoutController extends IntraController {

    @Autowired
    LayoutService layoutService;
    @Autowired
    ContentService contentService;

    /**
     * 레이아웃 목록
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_LayoutList.do" })
    public void getLayoutList(ModelMap model, LayoutVO layoutVo) throws Exception {

        List<DomainVO> domainList = layoutService.getDomainList(layoutVo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, domainList);

        List<LayoutVO> dataList = layoutService.getLayoutList(layoutVo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, dataList);

    }

    /**
     * 레이아웃 등록 폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = { "BD_InsertLayoutForm.do" })
    public void insertLayoutForm(ModelMap model, LayoutVO layoutVo) throws Exception {

        // 검증 데이터
        ValidateResultHolder holder = ValidateUtil.validate(layoutVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        List<DomainVO> domainList = layoutService.getDomainList(layoutVo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, domainList);

    }

    /**
     * 레이아웃 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_InsertLayoutAction.do", method = RequestMethod.POST)
    public String insertLayoutAction(HttpServletRequest request, ModelMap model, LayoutVO layoutVo) throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(layoutVo);
        if(holder.isValid()) {
            LoginVO loginVo = getLoginSession(request);
            layoutVo.setRegId(loginVo.getMngrId());

            layoutService.insertLayout(layoutVo);

            // 레이아웃 동기화
            layoutService.synchronize(layoutVo);

        } else {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_VALIDATE_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK);
    }

    /**
     * 레이아웃 수정 폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_UpdateLayoutForm.do" })
    public void updateLayoutForm(ModelMap model, LayoutVO layoutVo) throws Exception {

        // 검증 데이터
        ValidateResultHolder holder = ValidateUtil.validate(layoutVo);
        model.addAttribute(GlobalConfig.KEY_VALIDATE, holder);

        List<DomainVO> domainList = layoutService.getDomainList(layoutVo);
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, domainList);

        LayoutVO dataVo = layoutService.getLayout(layoutVo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVo);
    }

    /**
     * 레이아웃 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_UpdateLayoutAction.do", method = RequestMethod.POST)
    public String updateLayoutAction(HttpServletRequest request, ModelMap model, LayoutVO layoutVo) throws Exception {

        // 검증
        ValidateResultHolder holder = ValidateUtil.validate(layoutVo);
        if(holder.isValid()) {
            LoginVO loginVo = getLoginSession(request);
            layoutVo.setModId(loginVo.getMngrId());

            layoutService.updateLayout(layoutVo);

            // 레이아웃 동기화
            layoutService.synchronize(layoutVo);

        } else {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_VALIDATE_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 레이아웃 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_DeleteLayoutAction.do", method = RequestMethod.POST)
    public String deleteLayoutAction(ModelMap model, LayoutVO layoutVo) throws Exception {

        int affected = layoutService.deleteLayout(layoutVo);
        if(affected == 0) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }
        return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
    }

    /**
     * 레이아웃 미리보기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_LayoutPreView.do")
    public String getLayoutPreView(HttpServletRequest request, ModelMap model,
        LayoutVO layoutVo, ContentVO contentVo) throws Exception {

        String previewContent = request.getParameter("previewContent");

        if(Validate.isEmpty(previewContent)) {
            OpHelper.bindSearchMap(contentVo, request);
            contentVo = contentService.getContent(contentVo);
            model.addAttribute(GlobalConfig.KEY_DATA_VO, contentVo);
        }

        return "common/decorator/web/preview";
    }
}
