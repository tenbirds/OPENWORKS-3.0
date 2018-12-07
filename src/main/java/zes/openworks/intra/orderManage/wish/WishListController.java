/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.wish;

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
 *  주문관리 > 구매/신청 관리
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 22.    이슬버미       신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/orderManage/wish")
public class WishListController extends IntraController {

    @Autowired private WishListService service;

    /**
     * wishView (구매희망목록)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_wishView.do", method = RequestMethod.GET)
    public void wishView(HttpServletRequest request, ModelMap model, WishListVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.wishList(vo));
    }

    /**
     * wishListPopup (구매희망 상세 정보)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="PD_wishListPop.do", method=RequestMethod.GET)
    public void storeView(HttpServletRequest request, ModelMap model, WishListVO vo) {

     OpHelper.bindSearchMap(vo, request);
      model.addAttribute("p_userId", vo.getUserId());
      model.addAttribute("p_grpSeq", vo.getGrpSeq());
      model.addAttribute(GlobalConfig.KEY_PAGER, service.wishDetailList(vo));
     //   model.addAttribute(GlobalConfig.KEY_DATA_VO,popService.userView(vo));
    }

    /**
     * consultListExcel (엑셀 다운로드)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    /*
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_wishListExcel.do")
    public String wishListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute WishListVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.put("_wishListInfo",service.wishList(vo).getList());
        model.put("_wishListExcel", service.wishListExcel(vo));
        IExcelVO wishListExcel = new WishListExcelVO();
        return responseExcel(model, wishListExcel);
    }
    */
    /**
     * wishListPopup (구매희망 엑셀 다운로드)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="PD_wishListExcel.do", method=RequestMethod.GET)
    public void wishListExcel(HttpServletRequest request, ModelMap model, WishListVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute("wishListInfo",service.wishList(vo).getList());
        model.addAttribute("wishListExcel", service.wishListExcel(vo));
    }

}
