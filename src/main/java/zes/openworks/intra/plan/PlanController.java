/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.plan;

import java.util.Calendar;
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
 *  2013. 3. 14.    구선모   생성
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/plan")
public class PlanController extends IntraController {

    @Autowired
    private PlanService service;

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void planList(HttpServletRequest request, ModelMap model, PlanVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.planList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_cal.do", method = RequestMethod.GET)
    public void plancal(HttpServletRequest request, ModelMap model, PlanVO vo) {
    }

    @RequestMapping(value = "ND_calList.do")
    public String plancalList(HttpServletRequest request, ModelMap model, PlanVO vo) {

        Calendar cal = Calendar.getInstance();
        int a = cal.get(Calendar.YEAR);
        int b = vo.getStartYear();
        int c = cal.get(Calendar.MONTH);
        int d = vo.getStartMonth();

        // 현재 년도와 이동년도의 차이를 구해 세팅
        vo.setStartY(b - a);
        // 현재 년도와 이동달의 차이를 구해세팅
        vo.setStartM(d - c);

        return responseJson(model, service.planCalList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "PD_insertPop.do", "PD_updatePop" }, method = RequestMethod.GET)
    public String planPopForm(HttpServletRequest request, ModelMap model, PlanVO vo) {

        if(Validate.isNotEmpty(vo.getPlan_seq())) {
            model.addAttribute(GlobalConfig.KEY_BASE_VO, service.planUpdatePop(vo));
        }

        return baseUrl + "/PD_insertPop";
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String planInsertAction(HttpServletRequest request, ModelMap model, PlanVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        vo.setReg_id(loginVo.getMngrId());

        int affected = service.planInsertAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String planUpdateAction(HttpServletRequest request, ModelMap model, PlanVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        vo.setModi_id(loginVo.getMngrId());

        int affected = service.planUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String planDeletAction(HttpServletRequest request, ModelMap model, PlanVO vo) {

        int affected = service.planDeleteAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_DeleteChoose.do", method = RequestMethod.POST)
    public String planDeleteChoose(HttpServletRequest request, ModelMap model, PlanVO vo) {

        int affected = service.planDeleteChoose(request);

        if(affected > StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_day.do" }, method = RequestMethod.GET)
    public void planDay(HttpServletRequest request, ModelMap model, PlanVO vo) {

        model.addAttribute(GlobalConfig.KEY_BASE_VO, service.planDayList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "BD_week.do" }, method = RequestMethod.GET)
    public void planWeek(HttpServletRequest request, ModelMap model, PlanVO vo) {

        List<PlanVO> searchVO = service.planSearchDay(vo);
        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, searchVO);

        vo.setQ_startDt(searchVO.get(0).getQ_startDt());
        model.addAttribute(GlobalConfig.KEY_BASE_VO, service.planWeekList(vo));
    }

}
