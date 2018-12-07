/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.consult;

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
import zes.base.vo.IExcelVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  주문관리 > 컨설팅신청관리
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/orderManage/consult")
public class ConsultOrderController extends IntraController {

    @Autowired private ConsultOrderService service;

    /**
     * consultList (컨설팅신청 관리 목록)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void consultList(HttpServletRequest request, ModelMap model, ConsultOrderVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.consultList(vo));

    }


    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="ND_ctgryList.do", method=RequestMethod.POST)
    public String ctgryList(ConsultOrderVO vo, ModelMap model){

        return responseJson(model, service.ctgryList(vo));
    }

    /**
     * consultListExcel (엑셀 다운로드)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_consultListExcel.do")
    public String consultListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute ConsultOrderVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.put("_consultListExcel", service.consultListExcel(vo));
        IExcelVO consultListExcel = new ConsultOrderListExcelVO();
        return responseExcel(model, consultListExcel);
    }

}
