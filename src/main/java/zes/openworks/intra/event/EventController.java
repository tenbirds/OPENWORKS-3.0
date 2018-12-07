/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.event;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;


/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 16.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/event")
public class EventController extends IntraController  {

    /** 파일 저장 경로 */
    public static final String EVENT_IMG_STORE = "event" + File.separator;
    public static final String RESOURCE_PATH = "";

    @Autowired EventService service;

    /**
     * 이벤트목록
     * eventList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void eventList(HttpServletRequest request, ModelMap model, EventVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.eventList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
     
    }
    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_view.do")
    public void eventView(HttpServletRequest request, ModelMap model, EventVO vo) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO + StringUtil.ONE,service.eventLcSeList(vo));
        model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.eventUpdateForm(vo));
    }
    
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_eventEnfrcClosAtUpdateAction.do")
    public String eventEnfrcClosAtUpdateAction(ModelMap model, HttpServletRequest request, EventVO vo) {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVO.getMngrId());
        int affected = service.enfrcClosAtUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "BD_insertForm.do", "BD_updateForm.do" })
    public String eventForm(HttpServletRequest request, ModelMap model, EventVO vo) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO + StringUtil.ONE,service.eventLcSeList(vo));

        if(Validate.isNotEmpty(vo.getEventSn())) {
            model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.eventDomainList(vo));
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.eventUpdateForm(vo));
        }
        
        return baseUrl + "/BD_insertForm";
    }
    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "PD_answerList.do"})
    public void answerList(HttpServletRequest request, ModelMap model, EventVO vo) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.answerList(vo));
        model.addAttribute(GlobalConfig.KEY_BASE_VO,vo);
    }
    
    

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String eventInsertAction(HttpServletRequest request, ModelMap model, EventVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());
        
        //파일 업로드
        List<FileVO> fileList = new ArrayList<FileVO>();
        fileList = UploadHelper.upload(request,EVENT_IMG_STORE);
        vo.setFileList(fileList);
        
        int affected = service.eventInsertAction(vo, request);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }        
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String eventUpdateAction(HttpServletRequest request, ModelMap model, EventVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        //파일 업로드
        List<FileVO> fileList = new ArrayList<FileVO>();
        fileList = UploadHelper.upload(request,EVENT_IMG_STORE);
        vo.setFileList(fileList);
        
        int affected = service.eventUpdate(vo, request);
        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_orderList.do", method = RequestMethod.POST)
    public String orderList(HttpServletRequest request, ModelMap model, EventVO vo) {

        return responseJson(model, service.orderList(vo));
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_orderUpdate.do", method = RequestMethod.POST)
    public String orderUpdate(HttpServletRequest request, ModelMap model, EventVO vo) {

        int affected = service.orderUpdate(vo, request);
        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }
    
    
    /**
     * eventDeleteAction (이벤트관리 삭제)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String eventDeleteAction(ModelMap model, EventVO vo) {
        
        int affected = service.eventDeleteAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
        
    }
    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_order.do")
    public void bannerOrder(HttpServletRequest request, ModelMap model, EventVO vo) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
    }
 
    
    /**
     * eventListExcel (댓글 엑셀출력)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_answerListExcel.do")
    public String answerListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute EventVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.put("_answerList", service.answerListExcel(vo));
        IExcelVO answerListExcel = new EventListExcelVO();
        return responseExcel(model, answerListExcel);
    }
    
}
