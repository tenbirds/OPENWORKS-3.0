/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.sns.report;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
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
@RequestMapping(value = "/intra/sns/report")
public class SnsReportController extends IntraController {

    @Autowired
    private SnsReportService snsReprotService;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void snsReportList(HttpServletRequest request, ModelMap model, SnsReportVO vo) {

        OpHelper.bindSearchMap(vo, request);

        publicList(request, model, vo, "baseList");
    }

    @RequestMapping(value = "BD_delList.do", method = RequestMethod.GET)
    public void snsReportDelList(HttpServletRequest request, ModelMap model, SnsReportVO vo) {

        OpHelper.bindSearchMap(vo, request);

        publicList(request, model, vo, "delList");
    }

    public void publicList(HttpServletRequest request, ModelMap model, SnsReportVO vo, String type) {

        if(vo.getQ_searchDomain() == null)
        {
            vo.setQ_searchDomain("1");

            Map<String, Object> dataMap = vo.getDataMap();

            dataMap.put("q_searchDomain", "1");

            if(type.equals("baseList")) {
                dataMap.put("q_searchDel_yn", "N");
            } else {
                dataMap.put("q_searchDel_yn1", "N");
            }

            vo.setDataMap(dataMap);
        }

        model.addAttribute("MenuList", snsReprotService.getMenuCodeList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, snsReprotService.snsReportList(vo));
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_snsReportDelUpdate.do", method = RequestMethod.POST)
    public String snsReportDelUpdate(HttpServletRequest request, ModelMap model) {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        int affected = snsReprotService.snsReportDelUpdate(request, loginVo.getMngrId());

        if(affected > 0)
        {
            return responseText(model, Messages.COMMON_DELETE_OK);
        }
        else
        {
            return responseText(model, Messages.COMMON_PROCESS_FAIL);
        }
    }

    @RequestMapping(value = "ND_menu.do", method = RequestMethod.POST)
    public String menuSearch(HttpServletRequest request, ModelMap model, SnsReportVO vo) {

        return responseJson(model, snsReprotService.getMenuCodeList(vo));
    }

}
