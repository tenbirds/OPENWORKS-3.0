/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dcms.wiget;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainService;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.cms.CmsService;
import zes.openworks.intra.login.LoginVO;

/**
 * 사용자컨텐츠 관리
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
 *  2012. 6. 27.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/dcms/wiget")
public class WigetController extends IntraController {

    @Autowired
    WigetService wigetService;
    @Autowired
    CmsService cmsService;
    @Autowired
    DomainService domainService;

    /**
     * 화면 폼 목록
     */
    @RequestMapping(value = { "BD_PageFormList.do" })
    public void getWigetFormList(HttpServletRequest request, ModelMap model, WigetVO wigetVo) throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);

        if(Validate.isEmpty(wigetVo.getQ_rowPerPage()))
            wigetVo.setQ_rowPerPage(10);

        Pager<WigetVO> dataList = wigetService.getWigetFormList(wigetVo);

        model.addAttribute(GlobalConfig.KEY_PAGER, dataList);
    }

    /**
     * 화면 폼 등록 폼
     */
    @RequestMapping(value = { "BD_PageFormAdd.do", "BD_PageFormView.do" })
    public void getPageForm(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, wigetVo);

        String pageFormCd = wigetVo.getQ_pageFormCd();

        if(pageFormCd != null) {
            /** 화면 폼 정보 */
            wigetVo = wigetService.getPageForm(wigetVo);

            /** 화면 폼 위젯 영역 정보 */
            model.addAttribute("wigetAreaVo", wigetService.getWigetAreaList(wigetVo));
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);
    }

    /**
     * 화면 폼 등록 액션
     */
    @RequestMapping(value = "ND_PageFormInsertAction.do", method = RequestMethod.POST)
    public String pageFormInsertAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        wigetVo.setRegId(loginVo.getMngrId());

        Object primaryKey = wigetService.insertPageForm(wigetVo);

        String url = "BD_PageFormView.do?" + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_pageFormCd", primaryKey);

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 화면 폼 수정 액션
     */
    @RequestMapping(value = "ND_PageFormUpdateAction.do", method = RequestMethod.POST)
    public String pageFormUpdateAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        wigetVo.setRegId(loginVo.getMngrId());

        Object primaryKey = wigetService.updatePageForm(wigetVo);

        String url = "BD_PageFormView.do?"
            + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_pageFormCd", wigetVo.getQ_pageFormCd());

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 위젯 목록
     */
    @RequestMapping(value = { "BD_WigetList.do" })
    public void getWigetList(HttpServletRequest request, ModelMap model, WigetVO wigetVo) throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);

        if(Validate.isEmpty(wigetVo.getQ_rowPerPage()))
            wigetVo.setQ_rowPerPage(10);

        /** 화면 폼 목록 가져오기 */
        model.addAttribute("pageListVo", wigetService.getPageAllList(wigetVo));

        Pager<WigetVO> dataList = wigetService.getWigetList(wigetVo);

        model.addAttribute(GlobalConfig.KEY_PAGER, dataList);
    }

    /**
     * 위젯 등록 폼
     */
    @RequestMapping(value = { "BD_WigetForm.do", "BD_WigetView.do" })
    public void getWigetForm(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, wigetVo);

        model.addAttribute("bbsConfListVo", wigetService.getBbsConfList(wigetVo));

        String wigetCd = wigetVo.getQ_wigetCd();

        if(wigetCd != null) {
            /** 화면 폼 정보 */
            wigetVo = wigetService.getWiget(wigetVo);
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);
    }

    /**
     * 위젯 등록 액션
     */
    @RequestMapping(value = "ND_WigetInsertAction.do", method = RequestMethod.POST)
    public String wigetInsertAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        wigetVo.setRegId(loginVo.getMngrId());

        Object primaryKey = wigetService.insertWiget(wigetVo);

        String url = "BD_WigetView.do?" + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_wigetCd", primaryKey);

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 위젯 수정 액션
     */
    @RequestMapping(value = "ND_WigetUpdateAction.do", method = RequestMethod.POST)
    public String wigetUpdateAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        wigetVo.setModId(loginVo.getMngrId());

        Object primaryKey = wigetService.updateWiget(wigetVo);

        String url = "BD_WigetView.do?" + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_wigetCd", wigetVo.getQ_wigetCd());

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 위젯 삭제 액션
     */
    @RequestMapping(value = "ND_WigetDeleteAction.do", method = RequestMethod.POST)
    public String wigetDeleteAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        Object primaryKey = wigetService.deleteWiget(wigetVo);

        String url = "BD_WigetList.do";

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 화면 목록
     */
    @RequestMapping(value = { "BD_PageList.do" })
    public void getPageList(HttpServletRequest request, ModelMap model, WigetVO wigetVo) throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);

        if(Validate.isEmpty(wigetVo.getQ_rowPerPage()))
            wigetVo.setQ_rowPerPage(10);

        Pager<WigetVO> dataList = wigetService.getPageList(wigetVo);

        model.addAttribute(GlobalConfig.KEY_PAGER, dataList);
    }

    /**
     * 화면 등록 폼
     */
    @RequestMapping(value = { "BD_PageForm.do", "BD_PageView.do" })
    public void getPageFormAdd(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, wigetVo);

        /** 화면 폼 목록 가져오기 */
        model.addAttribute("pageFormListVo", wigetService.getUsePageFormList(wigetVo));

        String pageCd = wigetVo.getQ_pageCd();

        if(pageCd != null) {
            /** 화면 폼 정보 */
            wigetVo = wigetService.getPage(wigetVo);

            /** 화면 위젯 정보 */
            model.addAttribute("pageWigetVo", wigetService.getPageWigetList(wigetVo));
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);
    }

    /**
     * 화면 폼 정보 가져오기
     */
    @RequestMapping(value = "ND_ajaxPageForm.do", method = RequestMethod.POST)
    public String ajaxPageFormList(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        return responseJson(model, wigetService.getPageFormAreaList(wigetVo));
    }

    /**
     * 사이즈가 동일한 위젯 정보 가져오기
     */
    @RequestMapping(value = "ND_ajaxWigetList.do", method = RequestMethod.POST)
    public String ajaxWigetList(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        return responseJson(model, wigetService.getEqualSizeWigetList(wigetVo));
    }

    /**
     * 위젯 화면 등록 액션
     */
    @RequestMapping(value = "ND_PageInsertAction.do", method = RequestMethod.POST)
    public String pageInsertAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        wigetVo.setRegId(loginVo.getMngrId());

        Object primaryKey = wigetService.insertPage(wigetVo);

        String url = "BD_PageView.do?" + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_pageCd", primaryKey);

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_INSERT_OK, url);
    }

    /**
     * 화면에 등록된 위젯 정보 가져오기
     */
    @RequestMapping(value = "ND_ajaxPageWigetList.do", method = RequestMethod.POST)
    public String ajaxPageWigetList(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        return responseJson(model, wigetService.getPageWigetList(wigetVo));
    }

    /**
     * 위젯 화면 수정 액션
     */
    @RequestMapping(value = "ND_PageUpdateAction.do", method = RequestMethod.POST)
    public String pageUpdateAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        LoginVO loginVo = getLoginSession(request);
        wigetVo.setModId(loginVo.getMngrId());

        Object primaryKey = wigetService.updatePage(wigetVo);

        String url = "BD_PageView.do?" + OpHelper.getReplaceParamValue(OpHelper.getSearchQueryString(request), "q_pageCd", wigetVo.getQ_pageCd());

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_UPDATE_OK, url);
    }

    /**
     * 위젯 화면 삭제 액션
     */
    @RequestMapping(value = "ND_PageDeleteAction.do", method = RequestMethod.POST)
    public String pageDeleteAction(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        Object primaryKey = wigetService.deletePage(wigetVo);

        String url = "BD_PageList.do";

        if(Validate.isNull(primaryKey)) {
            return alertAndRedirect(model, Messages.COMMON_PROCESS_FAIL, url);
        }
        return alertAndRedirect(model, Messages.COMMON_DELETE_OK, url);
    }

    /**
     * 화면 미리보기
     */
    @RequestMapping(value = { "PD_WigetPreview.do" })
    public void getWigetPreview(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, wigetVo);

        /** 화면 위젯 정보 가져오기 */
        if(wigetVo.getQ_pageCd() != null) {
            // wigetVo.setQ_pageCd(wigetVo.getPageCd());

            /** 화면 폼 정보 */
            wigetVo = wigetService.getPage(wigetVo); // OP_CMS_PAGE,
                                                     // OP_CMS_PAGE_FORM

            /** 화면 위젯 정보 */
            model.addAttribute("pageWigetVo", wigetService.getPageWigetList(wigetVo)); // OP_CMS_PAGE_WIGET
                                                                                       // A,
                                                                                       // OP_CMS_WIGET
                                                                                       // B
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);
    }

    /**
     * 화면 위젯 정보 가져오기
     */
    @RequestMapping(value = "ND_ajaxAreaPageWigetList.do", method = RequestMethod.POST)
    public String ajaxAreaPageWigetList(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        return responseJson(model, wigetService.getAreaPageWigetList(wigetVo));
    }

    /**
     * 위젯 컨텐츠 만들기
     */
    @RequestMapping(value = { "ND_ajaxWigetContent.do" })
    public void getWigetContent(HttpServletRequest request, ModelMap model, WigetVO wigetVo)
        throws Exception {

        OpHelper.bindSearchMap(wigetVo, request);

        model.addAttribute(GlobalConfig.KEY_BASE_VO, wigetVo);

        /** 화면 위젯 정보 가져오기 */
        if(wigetVo.getQ_wigetCd() != null) {
            /** 위젯 컨텐츠 정보 */
            WigetVO wigetInfoVo = wigetService.getWiget(wigetVo);

            model.addAttribute("wigetInfoVo", wigetInfoVo);

            /** 게시판 컨텐츠 생성 */
            if(wigetInfoVo != null && "B".equals(wigetInfoVo.getWigetType())) {
                List<BoardVO> boardList = null;

                BoardVO boardVO = new BoardVO();

                boardVO.setNoticeBbscttAt("N");
                boardVO.setBbsCd(Integer.parseInt(wigetInfoVo.getBbsCd()));
                boardVO.setQ_rowPerPage(Integer.parseInt(wigetInfoVo.getBbsViewNum()));

                boardList = wigetService.getBoardList(boardVO);

                model.addAttribute("boardList", boardList);
            }
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, wigetVo);
    }
}
