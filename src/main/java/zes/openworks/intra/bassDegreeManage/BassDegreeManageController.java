/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.bassDegreeManage;

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
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 3.    방기배       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/bassDegreeManage")

    /* 기본협약차수관리 Controller*/
    public class BassDegreeManageController extends IntraController {    
    
    @Autowired 
    private BassDegreeManageService service;
    
    
    
    /* 기본협약 차수관리 차수 리스트 출력*/
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = {RequestMethod.POST,RequestMethod.GET})
    public void bassDegreeManageList(HttpServletRequest request, ModelMap model, BassDegreeManageVO vo) {
        
    OpHelper.bindSearchMap(vo, request);
    model.addAttribute(GlobalConfig.KEY_PAGER, service.bassDegreeManageList(vo));
        
    }
    
    /* 기본협약차수관리 차수 추가*/
    @RequestMapping(value = "BD_degreeInsert.do", method = RequestMethod.POST)
    public String BD_degreeInsert(HttpServletRequest request, ModelMap model, BassDegreeManageVO vo) {
        
        vo.setBassDegreeStdt(request.getParameter("bassDegreeStdt").replace("-",""));
        vo.setBassDegreeEnddt(request.getParameter("bassDegreeEnddt").replace("-",""));
        
        OpHelper.bindSearchMap(vo, request);
        
        /* 실행하여 성공, 실패 값을 가지고온다*/
        Integer key = service.bassDegreeManageInsert(vo);

        
        /* 실패시 실패 메시지를 띄어주고 되돌아간다.*/
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }
        
        /* 성공시 메시지 출력 후 되돌아간다*/
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, "BD_index.do");
    }
    
    /* 기본협약차수관리 차수 삭제*/
    @RequestMapping(value = "BD_degreeDelete.do", method = RequestMethod.POST)
    public String BD_degreeDelete(HttpServletRequest request, ModelMap model, BassDegreeManageVO vo) {
        
        //삭제할 기본협약 차수
        vo.setBassDegree(Integer.parseInt(request.getParameter("DeleteDegree")));

        /* 실행하여 성공, 실패 값을 가지고온다*/
        Integer key = service.bassDegreeManageDelete(vo);
        
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }
        
        /* 성공시 메시지 출력 후 되돌아간다*/
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, "BD_index.do");
    }
    
    /* 기본협약차수관리 차수 수정*/
    @RequestMapping(value = "BD_degreeUpdate.do", method = RequestMethod.POST)
    public String BD_degreeUpdate(HttpServletRequest request, ModelMap model, BassDegreeManageVO vo) {
        
        //수정할 기본협약 차수
        vo.setBassDegree(Integer.parseInt(request.getParameter("UpdateDegree")));
        vo.setBassDegreeEnddt(request.getParameter("bassDegreeEnddt").replace("-",""));
        
        OpHelper.bindSearchMap(vo, request);
        
        /* 실행하여 성공, 실패 값을 가지고온다*/
        Integer key = service.bassDegreeManageUpdate(vo);
        
        if(Validate.isEmpty(key)) {
            return alertAndBack(model, Messages.COMMON_PROCESS_FAIL);
        }
        
        /* 성공시 메시지 출력 후 되돌아간다*/
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, "BD_index.do");
    }
        
}
