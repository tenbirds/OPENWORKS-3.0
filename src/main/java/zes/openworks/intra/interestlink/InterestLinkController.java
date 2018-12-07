/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.interestlink;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

@Controller
@RequestMapping(value = "/intra/interestlink")
public class InterestLinkController extends IntraController {

    @Autowired
    private InterestLinkService service;

    /**
     * 관심목록 목록보기 ( 전체 목록 보기 )
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_index.do")
    public void interestList(ModelMap model, HttpServletRequest request,
        @ModelAttribute InterestLinkVO interestLinkVo) throws Exception {

        OpHelper.bindSearchMap(interestLinkVo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.interestLinkPager(interestLinkVo));
    }

    /**
     * 관심목록 등록폼 & 수정폼(seq가 있는 경우)
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_iLinkAddForm.do", method = RequestMethod.GET)
    public void insertForm(ModelMap model, @ModelAttribute InterestLinkVO interestLinkVo) throws Exception {

    }

    /**
     * 카테고리 목록 반환
     */
    @RequestMapping(value = "ND_categoryList.do")
    public String getCategoryList(ModelMap model, HttpServletRequest request,
        @ModelAttribute InterestLinkVO interestLinkVo) {

        setValues(request, interestLinkVo);
        return responseJson(model, service.getCategoryList(interestLinkVo));
    }

    /**
     * 관심목록 등록 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_iLinkInsertAction.do", method = RequestMethod.POST)
    public String InsertAction(ModelMap model, HttpServletRequest request,
        @ModelAttribute InterestLinkVO interestLinkVo) throws Exception {

        setValues(request, interestLinkVo);

        int result = 0;
        if(Validate.isEmpty(interestLinkVo.getSeq())) {
            // 등록
            result = service.insertInterestLink(interestLinkVo);
        } else {
            // 수정
            result = service.updateInterestLink(interestLinkVo);
        }

        if(result == 1) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 관심 목록 삭제
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_iLinkDeleteAction.do", method = RequestMethod.POST)
    public String deleteAction(ModelMap model, HttpServletRequest request,
        @ModelAttribute InterestLinkVO interestLinkVo) throws Exception {

        Integer result = service.deleteInterestLink(interestLinkVo);

        if(result == 1) {
            return responseText(model, Messages.TRUE);
        } else {
            return responseText(model, Messages.FALSE);
        }
    }

    /**
     * 관심목록 목록 JSON 보기( 유저별 목록 보기 )
     */
    @RequestMapping(value = "ND_iLinkList.do", method = RequestMethod.GET)
    public void interestListJson(ModelMap model, HttpServletRequest request) throws Exception {

        InterestLinkVO interestLinkVo = new InterestLinkVO();
        setValues(request, interestLinkVo);

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.interestLinkList(interestLinkVo));
    }

    // 기본 값을 설정
    private void setValues(HttpServletRequest request, @ModelAttribute InterestLinkVO interestLinkVo) {
        LoginVO loginVo = OpHelper.getMgrSession(request);

        interestLinkVo.setVirKey(loginVo.getMngrId());
        interestLinkVo.setMngrId(loginVo.getMngrId());

    }
}
