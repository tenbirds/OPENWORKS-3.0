/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandExaminDc;

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
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;


/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2016. 10. 01.   최강식   신규
*</pre>
* @see
*/

@Controller
@RequestMapping(value = "/intra/dmandExaminDc")
public class DmandExaminDcController extends IntraController {

    @Autowired private DmandExaminDcService service;

    /**
     * 설명회 신청 목록
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void wishView(HttpServletRequest request, ModelMap model, DmandExaminDcVO vo) {

        OpHelper.bindSearchMap(vo, request);
        if(Validate.isEmpty(vo.getPartcptSe())){
            vo.setPartcptSe(1001);
        }
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandExaminDcList(vo));
    }


    /**
     * 설명회 신청 목록 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_indexExcel.do", method=RequestMethod.GET)
    public void wishListExcel(HttpServletRequest request, ModelMap model, DmandExaminDcVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        model.addAttribute("dmandExaminDcListExcel", service.dmandExaminDcListExcel(vo));
    }

}
