/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.popup;

import java.io.File;
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
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.advertisement.AdvrtsVO;
import zes.openworks.intra.login.LoginVO;

/**
 * 팝업창 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 17.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/popup")
public class PopupController extends IntraController {

    /** 파일 저장 경로 */
    public static final String POPUP_IMG_STORE = "popup" + File.separator;

    @Autowired
    private PopupService service;

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void bannerList(HttpServletRequest request, ModelMap model, PopupVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.popupList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_popupUseYnUpdateAction.do")
    public String useYnUpdateAction(ModelMap model, HttpServletRequest request, PopupVO vo) {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVO.getMngrId());
        int affected = service.useYnUpdateAction(vo);

        return responseText(model, affected);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "BD_insertForm.do", "BD_updateForm.do" }, method = RequestMethod.POST)
    public String bannerForm(HttpServletRequest request, ModelMap model, PopupVO vo) {
        AdvrtsVO avo = new AdvrtsVO();
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
        model.addAttribute("advertisList", service.advrtsList(avo));
        if(Validate.isNotEmpty(vo.getPopupSn())) {
            model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.popupDomainList(vo));
            model.addAttribute(GlobalConfig.KEY_BASE_VO, service.popupUpdateForm(vo));
        }

        return baseUrl + "/BD_insertForm";
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String bannerInsertAction(HttpServletRequest request, ModelMap model, PopupVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());

        List<FileVO> fileList = UploadHelper.upload(request, POPUP_IMG_STORE, Boolean.TRUE);

        if(Validate.isNotEmpty(fileList) && fileList.size() > 0) {
            for(int i = 0 ; i < fileList.size() ; i++) {
                FileVO fileVO = fileList.get(i);
                vo.setPopupFilePath(fileVO.getFileUrl());
                vo.setFileNm(fileVO.getLocalNm());
            }
        }

        int affected = service.popupInsertAction(vo, request);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String bannerUpdateAction(HttpServletRequest request, ModelMap model, PopupVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        List<FileVO> fileList = UploadHelper.upload(request, POPUP_IMG_STORE, Boolean.TRUE);

        for(int i = 0 ; i < fileList.size() ; i++) {
            FileVO fileVO = fileList.get(i);
            vo.setPopupFilePath(fileVO.getFileUrl());
            vo.setFileNm(fileVO.getLocalNm());
        }
        
        if(Validate.isNotEmpty(vo.getPopupFilePath() ) || Integer.valueOf(vo.getMakeTyCd()).equals("1001") || Integer.valueOf(vo.getMakeTyCd()).equals("1002")) {
            int affected2 = service.FileDel(vo);
            if(affected2 != StringUtil.ONE) {
                responseText(model, Messages.COMMON_PROCESS_FAIL);
            }
        }

        int affected = service.popupUpdate(vo, request);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_viewPop.do", method = RequestMethod.GET)
    public String viewPop(HttpServletRequest request, ModelMap model, PopupVO vo) {
        return responseJson(model, service.viewPop(vo));
    }
    
    /**
     * popupDeleteAction (팝업관리 삭제)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String popupDeleteAction(ModelMap model, PopupVO vo) {
        
        int affected = service.popupDeleteAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
        
    }
    
    
    /**
     * 사용자화면 정보갱신 팝업창
     * popFrontInfo 설명
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/PD_popFrontInfo.do")
    public void popFrontInfo(HttpServletRequest request, ModelMap model)
    {   
        
        model.addAttribute("frontInfo", service.selectFrontInfo() );
        
    }
    
    /**
     * 사용자화면 정보갱신 
     * popUpdateFrontInfo 설명
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/popUpdateFrontInfo.do")
    public String popUpdateFrontInfo(HttpServletRequest request, ModelMap model, FrontInfoVO vo)
    {
        service.updateFrontInfo(vo);
        
        return responseJson(model, service.selectFrontInfo() );
    }
    
    
}
