/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.stickyNote;

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
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 포스트잇 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/stickynote")
public class StickyNoteController extends IntraController {

    @Autowired
    private StickyNoteService stickyNoteService;

    /**
     * 포스트잇 목록 얻기
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_index.do", method = RequestMethod.GET)
    public void index(ModelMap model, HttpServletRequest request) {

        // 사용자 정보 설정
        LoginVO loginVo = OpHelper.getMgrSession(request);

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, stickyNoteService.stickyNoteList(loginVo.getMngrId()));
    }

    /**
     * 포스트잇 등록 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_insertAction.do", method = RequestMethod.POST)
    public String insertAction(ModelMap model, HttpServletRequest request,
        @ModelAttribute StickyNoteVO stickyNoteBean) throws Exception {

        // 사용자 정보 설정
        LoginVO loginVo = OpHelper.getMgrSession(request);
        stickyNoteBean.setMngrId(loginVo.getMngrId());

        Integer newSeq = stickyNoteService.insertAction(stickyNoteBean);

        if(newSeq == null) {
            return responseText(model, new Integer(0));
        } else {
            return responseText(model, newSeq);
        }
    }

    /**
     * 포스트잇 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_updateAction.do", method = RequestMethod.POST)
    public String updateAction(ModelMap model, HttpServletRequest request,
        @ModelAttribute StickyNoteVO stickyNoteBean) throws Exception {

        // 사용자 정보 설정
        LoginVO loginVo = OpHelper.getMgrSession(request);
        stickyNoteBean.setMngrId(loginVo.getMngrId());

        int affected = stickyNoteService.updateAction(stickyNoteBean);

        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.FALSE);
        } else {
            return responseText(model, Messages.TRUE);
        }
    }

    /**
     * 포스트잇 삭제 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(ModelMap model, HttpServletRequest request,
        @ModelAttribute StickyNoteVO stickyNoteBean) throws Exception {

        // 사용자 정보 설정
        LoginVO loginVo = OpHelper.getMgrSession(request);
        stickyNoteBean.setMngrId(loginVo.getMngrId());

        int affected = stickyNoteService.deleteAction(stickyNoteBean);

        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);
    }

}
