/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.coLog;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.base.vo.IExcelVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;

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
 *  2012. 5. 22.    김연성   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/user/coLog")
public class UserLogContrller extends IntraController {

    @Autowired
    private UserLogService service;

    /**
     * 회원정보조회이력관리 목록조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_userLogListR.do")
    public ModelAndView userLogListR(ModelAndView model, HttpServletRequest request, @ModelAttribute("userLogVO") UserLogVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);

         Pager<UserLogVO> pager = service.userLogListR(vo);
        
         for(int i = 0 ; i < pager.getList().size() ; i++) {
             String reason = pager.getList().get(i).getAccessResn();
             reason = reason.replaceAll("<br/>", "\n");
             pager.getList().get(i).setAccessResn(reason);
         }
        model.addObject(GlobalConfig.KEY_PAGER, service.userLogListR(vo));

        return model;
    }

    /**
     * 회원정보출력이력관리 목록조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_userLogListO.do")
    public ModelAndView userLogListO(ModelAndView model, HttpServletRequest request, @ModelAttribute("userLogVO") UserLogVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);

         Pager<UserLogVO> pager = service.userLogListO(vo);
        
         for(int i = 0 ; i < pager.getList().size() ; i++) {
             String reason = pager.getList().get(i).getAccessResn();
             reason = reason.replaceAll("<br/>", "\n");
             pager.getList().get(i).setAccessResn(reason);
         }

        model.addObject(GlobalConfig.KEY_PAGER, pager);
        model.addObject("menuNmList", service.menuNmList(vo));

        return model;
    }

    /**
     * 회원목록조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_userLogListU.do")
    public ModelAndView userLogListU(ModelAndView model, HttpServletRequest request, @ModelAttribute("userLogVO") UserLogVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);

         Pager<UserLogVO> pager = service.userLogListU(vo);
        
         for(int i = 0 ; i < pager.getList().size() ; i++) {
         String reason = pager.getList().get(i).getAccessResn();
         reason = reason.replaceAll("<br/>", "\n");
         pager.getList().get(i).setAccessResn(reason);
         }

        model.addObject(GlobalConfig.KEY_PAGER, pager);

        return model;
    }

    /**
     * 회원정보조회이력관리 목록 엑셀출력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_userLogListExcel.do")
    public String userLogListRExcel(ModelMap model, HttpServletRequest request, @ModelAttribute UserLogVO vo) {

        OpHelper.bindSearchMap(vo, request);

        String menuType = request.getParameter("menuType");
        vo.setLogMenuTy(menuType);

        model.put("_userLogList", service.userLogListExcel(vo));

        if(menuType.equals("R")) {
            IExcelVO userLogListRExcel = new UserLogListRExcelVO();
            return responseExcel(model, userLogListRExcel);
        } else if(menuType.equals("U")) {
            IExcelVO userLogListUExcel = new UserLogListUExcelVO();
            return responseExcel(model, userLogListUExcel);
        } else {
            IExcelVO userLogListOExcel = new UserLogListOExcelVO();
            return responseExcel(model, userLogListOExcel);
        }

    }

}
