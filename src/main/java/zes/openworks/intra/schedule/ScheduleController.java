/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.schedule;

import java.util.Calendar;

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
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

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
 *  2012. 5. 22.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/schedule")
public class ScheduleController extends IntraController {

    @Autowired
    private ScheduleService service;

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void scheduleList(HttpServletRequest request, ModelMap model, ScheduleVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.scheduleList(vo));

    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cal.do", method = RequestMethod.GET)
    public void schedulecal(HttpServletRequest request, ModelMap model, ScheduleVO vo) {
    }

    @RequestMapping(value = "ND_calList.do")
    public String schedulecalList(HttpServletRequest request, ModelMap model, ScheduleVO vo) {

        Calendar cal = Calendar.getInstance();
        int a = cal.get(Calendar.YEAR);
        int b = vo.getStartYear();
        int c = cal.get(Calendar.MONTH);
        int d = vo.getStartMonth();
        // 현재 년도와 이동년도의 차이를 구해 세팅
        vo.setStartY(b - a);
        // 현재 년도와 이동달의 차이를 구해세팅
        vo.setStartM(d - c);

        return responseJson(model, service.scheduleCalList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "PD_insertPop.do", "PD_updatePop" }, method = RequestMethod.GET)
    public String schedulePopForm(HttpServletRequest request, ModelMap model, ScheduleVO vo) {

        if(Validate.isNotEmpty(vo.getGbn())) {
            if(Validate.isNotEmpty(vo.getSeq())) {
                model.addAttribute(GlobalConfig.KEY_BASE_VO, service.updatePop(vo));
            }
        }

        return baseUrl + "/PD_insertPop";
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String scheduleInsertAction(HttpServletRequest request, ModelMap model, ScheduleVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegId(loginVo.getMngrId());

        int affected = service.scheduleInsertAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        } else {
            return responseText(model, Messages.FALSE);
        }

    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String scheduleUpdateAction(HttpServletRequest request, ModelMap model, ScheduleVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setModId(loginVo.getMngrId());

        int affected = service.scheduleUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String scheduleDeletAction(HttpServletRequest request, ModelMap model, ScheduleVO vo) {

        int affected = service.scheduleDeleteAction(vo);
        if(affected > StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_DeleteChoose.do", method = RequestMethod.POST)
    public String scheduleDeleteChoose(HttpServletRequest request, ModelMap model, ScheduleVO vo) {

        int affected = service.scheduleDeleteChoose(request);
        if(affected > StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }
}
