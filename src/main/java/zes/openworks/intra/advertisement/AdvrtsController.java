/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.advertisement;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.advertisement.AdvrtsService;

/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2015. 1. 7.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/advertisement")
public class AdvrtsController extends IntraController {

    @Autowired
    private AdvrtsService service;

    /**
     * 광고주정보 목록 
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void advrtsList(HttpServletRequest request, ModelMap model, AdvrtsVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.advrtsList(vo));
        
    }

    /**
     * 광고주정보 등록 폼 
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_insertForm.do", method = RequestMethod.GET)
    public void advrtsInsert(HttpServletRequest request, ModelMap model, AdvrtsVO vo) {
       
        OpHelper.bindSearchMap(vo, request);
        
    }

    /**
     * 광고주정보 수정 폼 
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_updateForm.do", method = RequestMethod.POST)
    public void advrtsUpdate(HttpServletRequest request, ModelMap model, AdvrtsVO vo) {
       
        OpHelper.bindSearchMap(vo, request);
        vo = service.advrtsUpdateForm(vo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, vo);
    }

    /**
     * 광고주정보 등록 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_InsertAdvrtsAction.do", method = RequestMethod.POST)
    public String insertAdvrtsAction(HttpServletRequest request, ModelMap model, AdvrtsVO vo) throws Exception {       

        // 검증   
        ValidateResultHolder holder = ValidateUtil.validate(vo);
        if(holder.isValid()) {
            LoginVO loginVo = getLoginSession(request);
            vo.setRegistId(loginVo.getMngrId());
            service.advrtsInsertAction(vo);
        } else {
            return responseText(model, Messages.FALSE);
        }
        return responseText(model, Messages.TRUE);

    }

    /**
     * 광고주정보 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_UpdateAdvrtsAction.do", method = RequestMethod.POST)
    public String updateAdvrtsAction(HttpServletRequest request, ModelMap model, AdvrtsVO vo) throws Exception {       

        //검증
        ValidateResultHolder holder = ValidateUtil.validate(vo);
        if(holder.isValid()) {
            LoginVO loginVo = getLoginSession(request);
            vo.setRegistId(loginVo.getMngrId());
            vo.setUpdtId(loginVo.getMngrId());

            if(request.getParameter("del_yn") != null && !"".equals(request.getParameter("del_yn"))){
                vo.setDeleteAt(request.getParameter("del_yn"));
                service.advrtsDeleteAction(vo);
            }else{
                service.advrtsUpdateAction(vo);
            }

        } else {           
            return responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);

    }

}
