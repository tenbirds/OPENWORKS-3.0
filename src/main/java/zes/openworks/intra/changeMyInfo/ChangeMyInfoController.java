/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.changeMyInfo;

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
import zes.openworks.intra.mgr.MgrVO;


/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 10.    김영상       신규
 *</pre>
 * @see
 */

/**
 * 나의정보변경 Controller 
 */

@Controller
@RequestMapping(value = "/intra/changeMyInfo")
public class ChangeMyInfoController extends IntraController  {

    @Autowired
    private ChangeMyInfoService service;

    /**
     * 나의 정보 보기
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_changeMyInfo.do", method = RequestMethod.GET)
    public void viewMyInfo(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVO.getMngrId());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.viewMyInfo(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));//할당권한
    }

    /**
     * 나의 정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String updateMyInfo(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());
        vo.setMngrId(loginVO.getMngrId());
        int affected = service.updateMyInfo(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }    
    
    /**
     * 나의 비밀번호 변경 팝업
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_changeMyPwd.do", method = RequestMethod.GET)
    public void changeMyPwdPopup(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.viewMyInfo(vo));
    }
    
    /**
     * 나의 비밀번호 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updatePwdAction.do", method = RequestMethod.POST)
    public String updateMyPwd(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());
        vo.setMngrId(loginVO.getMngrId());
        int affected = service.updateMyPwd(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }else if(affected < 0){
            return responseText(model, "-1");
        }else{
            return responseText(model, Messages.FALSE);
        }
    }
}
