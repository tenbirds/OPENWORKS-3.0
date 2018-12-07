/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.banner;

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
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    sa   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/banner")
public class BannerController extends IntraController {

    /** 파일 저장 경로 */
    public static final String BANNER_IMG_STORE = "banner" + File.separator;
    public static final String RESOURCE_PATH = "";

    @Autowired
    private BannerService service;

    /**
     * 베너목록
     * BannerList 설명
     * 
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void bannerList(HttpServletRequest request, ModelMap model, BannerVO vo) {

        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.bannerList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_order.do")
    public void bannerOrder(HttpServletRequest request, ModelMap model, BannerVO vo) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_bannerUseYnUpdateAction.do")
    public String useYnUpdateAction(ModelMap model, HttpServletRequest request, BannerVO vo) {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVO.getMngrId());
        int affected = service.useYnUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "BD_insertForm.do", "BD_updateForm.do" })
    public String bannerForm(HttpServletRequest request, ModelMap model, BannerVO vo) {
        AdvrtsVO avo = new AdvrtsVO();
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.domainList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO + StringUtil.ONE,service.bannerLcSeList(vo));
        model.addAttribute("advertisList", service.advrtsList(avo));
        if(Validate.isNotEmpty(vo.getBannerSn())) {
            model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.bannerDomainList(vo));
            model.addAttribute(GlobalConfig.KEY_BASE_LIST, service.bannerUpdateForm(vo));
        }
        
        return baseUrl + "/BD_insertForm";
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String bannerInsertAction(HttpServletRequest request, ModelMap model, BannerVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setRegistId(loginVo.getMngrId());

        List<FileVO> fileList = UploadHelper.upload(request, BANNER_IMG_STORE, Boolean.TRUE);

        if(Validate.isNotEmpty(fileList) && fileList.size() > 0) {
            for(int i = 0 ; i < fileList.size() ; i++) {
                FileVO fileVO = fileList.get(i);
                vo.setBannerFilePath(fileVO.getFileUrl());
            }
        }
        int affected = service.bannerInsertAction(vo, request);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String bannerUpdateAction(HttpServletRequest request, ModelMap model, BannerVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        List<FileVO> fileList = UploadHelper.upload(request, BANNER_IMG_STORE, Boolean.TRUE);

        for(int i = 0 ; i < fileList.size() ; i++) {
            FileVO fileVO = fileList.get(i);
            vo.setBannerFilePath(fileVO.getFileUrl());
        }
        if(Validate.isNotEmpty(vo.getFlag()) || Validate.isNotEmpty(vo.getBannerFilePath())) {
            int affected2 = service.fileDel(vo);
            if(affected2 != StringUtil.ONE) {
                return responseText(model, Messages.FALSE);
            }
        }

        int affected = service.bannerUpdate(vo, request);
        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_orderList.do", method = RequestMethod.POST)
    public String orderList(HttpServletRequest request, ModelMap model, BannerVO vo) {

        return responseJson(model, service.orderList(vo));
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_orderUpdate.do", method = RequestMethod.POST)
    public String orderUpdate(HttpServletRequest request, ModelMap model, BannerVO vo) {

        int affected = service.orderUpdate(vo, request);
        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }
    
    
    /**
     * bannerDeleteAction (팝업관리 삭제)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String bannerDeleteAction(ModelMap model, BannerVO vo) {
        
        int affected = service.bannerDeleteAction(vo);
        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
        
    }
    
}
