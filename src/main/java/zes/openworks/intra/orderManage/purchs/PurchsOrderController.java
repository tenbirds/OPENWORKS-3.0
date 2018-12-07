/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.purchs;

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
import zes.openworks.web.pop.PopService;
import zes.openworks.web.pop.PopVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  주문관리 > 구매/신청 관리
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/orderManage/purchs")
public class PurchsOrderController extends IntraController {

    @Autowired private PurchsOrderService service;
    @Autowired private PopService popService;
    
    /**
     * purchsList (구매/신청관리 목록)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void purchsList(HttpServletRequest request, ModelMap model, PurchsOrderVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.purchsList(vo));
    }
    
    /**
     * ctgryList (카테고리 목록)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="ND_ctgryList.do", method=RequestMethod.POST)
    public String ctgryList(PurchsOrderVO vo, ModelMap model){
        
        return responseJson(model, service.ctgryList(vo));
    }
    
    /**
     * userView (사용자 정보)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="PD_userView.do", method=RequestMethod.GET)
    public void userView(HttpServletRequest request, ModelMap model, PopVO vo) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO,popService.userView(vo));
    }
    
    /**
     * userView (수기입력(비회원) 정보)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="PD_tempUserView.do", method=RequestMethod.GET)
    public void tempUserView(HttpServletRequest request, ModelMap model, PopVO vo) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO,popService.tempUserView(vo));
    }
    
    /**
     * storeView (판매자 정보)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="PD_storeView.do", method=RequestMethod.GET)
    public void storeView(HttpServletRequest request, ModelMap model, PopVO vo) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO,popService.userView(vo));
    }

    /**
     * regstCnView (신청내용)
     * @param requestO
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_reqstCnView.do", method = RequestMethod.GET)
    public void regstCnView(HttpServletRequest request, ModelMap model, PopVO vo) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, popService.regstCnView(vo));
    }
    
    /**
     * consultListExcel (엑셀 다운로드)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_purchsListExcel.do")
    public String purchsListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute PurchsOrderVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.put("_purchsListExcel", service.purchsListExcel(vo));
        IExcelVO purchsListExcel = new PurchsOrderListExcelVO();
        return responseExcel(model, purchsListExcel);
    }
    
}
