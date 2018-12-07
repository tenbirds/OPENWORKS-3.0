/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.vo.FileVO;
import zes.base.vo.TreeVO;
import zes.core.lang.AssertUtil;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.cms.layout.LayoutService;
import zes.openworks.intra.cms.layout.LayoutVO;
import zes.openworks.intra.cms.support.CmsReferenceVO;
import zes.openworks.intra.cms.support.CmsSupport;
import zes.openworks.intra.cms.support.CmsUploadUtil;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.user.grade.UserGradeVO;

/**
 * 사용자 메뉴관리 컨트롤 객체
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OP 1.0
 */
@Controller
@RequestMapping(value = "/intra/cms")
public class CmsController extends IntraController {

    @Autowired
    CmsService cmsService;
    @Autowired
    LayoutService layoutService;
    @Autowired
    DomainService domainService;

    /**
     * 선택한 컨트롤(BEAN Name)과 함수명을 받아서 대상 목록을 반환한다.
     * 
     * @param umrVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "getCmsRefernce.do")
    public String getCmsReference(HttpServletRequest request, ModelMap model, CmsReferenceVO cmsRVO)
        throws Exception {

        String result = "";

        CmsSupport cms = new CmsSupport();
        List<CmsReferenceVO> umrList = cms.getCmsReference(request.getSession().getServletContext(), cmsRVO);

        if(Validate.isNotEmpty(umrList)) {
            StringBuilder resultBb = new StringBuilder();

            for(CmsReferenceVO referenceVO : umrList) {
                resultBb.append(referenceVO.getName()).append(",").append(referenceVO.getUserMenuUrl()).append("||")
                    .append(referenceVO.getAdminMenuUrl()).append("\n");
            }
            result = resultBb.substring(0, resultBb.length() - 1);
        }

        return responseText(model, result);
    }

    /**
     * 메뉴정보 관리 페이지
     * 
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "BD_Index.do")
    public void index(HttpServletRequest request, ModelMap model, DomainVO domainVO) throws Exception {

        if(Validate.isEmpty(domainVO.getDomainCd())) {
            List<DomainVO> domainList = domainService.getDomainList(domainVO);
            List<DomainVO> dataList = new ArrayList<DomainVO>();

            // 총괄운영자 & 일반 운영자 구분 필요시 수정
            // LoginVO loginVO = getLoginSession(request);
            dataList = domainList;

            Integer dataCnt = new Integer(0);

            if(Validate.isNotEmpty(dataList)) {
                dataCnt = dataList.size();
            }

            model.addAttribute(GlobalConfig.KEY_DATA_LIST, dataList);
            model.addAttribute(GlobalConfig.KEY_BASE_VO, dataCnt);
        } else {
            DomainVO domain = domainService.getDomain(domainVO);
            model.addAttribute(GlobalConfig.KEY_DATA_VO, domain);
        }

    }

    /**
     * 메뉴정보 TAB 페이지
     * 
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "INC_TabView.do", "INC_ChargerTabView.do", "BD_ChargerTabView.do" })
    public void tabView(HttpServletRequest request, ModelMap model, CmsVO cmsVo)
        throws Exception {

        CmsVO dataVo = cmsService.getMenu(cmsVo);

        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVo);

    }

    /**
     * 메뉴정보 목록 조회 (계층별 Tree 조회)
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_MenuList.do")
    public String menuList(ModelMap model, CmsVO cmsVo) throws Exception {

        AssertUtil.assertNotNull(cmsVo.getDomainCd(), "INVALID_ARGUMENTS");

        List<TreeVO> menuList = cmsService.getMenuList(cmsVo);

        return responseJson(model, menuList);
    }

    /**
     * 컨텐츠 담당자 메뉴정보 관리 페이지
     * 
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_ChargerIndex.do")
    public void chargerIndex(HttpServletRequest request, ModelMap model, DomainVO domainVO)
        throws Exception {

        List<DomainVO> dataList = domainService.getDomainList(domainVO);

        Integer dataCnt = new Integer(0);

        if(Validate.isNotEmpty(dataList)) {
            dataCnt = dataList.size();
        }

        request.setAttribute(GlobalConfig.KEY_DATA_LIST, dataList);
        request.setAttribute(GlobalConfig.KEY_BASE_VO, dataCnt);

    }

    /**
     * 사이트 선택 트리목록
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_ChargerMenuList.do")
    public String chargerMenuList(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        cmsVo.setDeptCd(loginVo.getDeptCode());
        cmsVo.setMgrId(loginVo.getMngrId());

        List<TreeVO> menuList = cmsService.getChargeMenuList(cmsVo);

        return responseJson(model, menuList);

    }

    /**
     * 메뉴정보 상세 조회
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = { "INC_MenuView.do", "INC_ChargerMenuView.do" })
    public void menuView(HttpServletRequest request, ModelMap model,
        CmsVO cmsVo, LayoutVO layoutVo) throws Exception {

        CmsVO dataVo = cmsService.getMenu(cmsVo);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, dataVo);

        List<LayoutVO> layoutList = layoutService.getLayoutList(layoutVo);
        model.addAttribute("layoutList", layoutList);

        List<UserGradeVO> userGradeList = cmsService.getUserGradeList(cmsVo);
        model.addAttribute("USER_GRADE_LIST", userGradeList);

        model.addAttribute("MENU_TYPE_LIST", CmsConstant.MENU_TYPE_LIST);
        model.addAttribute("LINK_TYPE_LIST", CmsConstant.LINK_TYPE_LIST);
        model.addAttribute("AUTH_TYPE_LIST", CmsConstant.AUTH_TYPE_LIST);

        CmsSupport support = new CmsSupport();
        model.addAttribute("CONTROL_LIST", support.getCmsReferenceList(request.getSession().getServletContext()));

    }

    /**
     * 메뉴정보 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_InsertAction.do", method = RequestMethod.POST)
    public String insertAction(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        cmsVo.setRegId(loginVo.getMngrId());

        try {
            cmsService.insertMenu(cmsVo);
        } catch (Exception e) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK);
    }

    /**
     * 사이트별 최상위 메뉴 생성
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_CreateMenu.do", method = RequestMethod.POST)
    public String createMenuAction(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        cmsVo.setRegId(loginVo.getMngrId());

        try {
            cmsService.createMenu(cmsVo);
        } catch (Exception e) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Boolean.TRUE, Messages.COMMON_INSERT_OK);
    }

    /**
     * 메뉴정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_UpdateAction.do", method = RequestMethod.POST)
    public String updateAction(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        @SuppressWarnings("unchecked")
        List<FileVO> fileList = CmsUploadUtil.upload(
            (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY), cmsVo);

        if(Validate.isNotEmpty(fileList) && fileList.size() > 0) {
            FileVO fileVO = null;
            for(int i = 0 ; i < fileList.size() ; i++) {
                fileVO = fileList.get(i);
                if("titleImgFile".equals(fileVO.getInputNm())) {
                    cmsVo.setTitleImg(fileVO.getFileUrl());
                }
                if("menuTitleImgFile".equals(fileVO.getInputNm())) {
                    cmsVo.setMenuTitleImg(fileVO.getFileUrl());
                }
                if("menuOnImgFile".equals(fileVO.getInputNm())) {
                    cmsVo.setMenuOnImg(fileVO.getFileUrl());
                }
                if("menuOffImgFile".equals(fileVO.getInputNm())) {
                    cmsVo.setMenuOffImg(fileVO.getFileUrl());
                }
            }
        }

        cmsVo.setFileList(fileList);

        LoginVO loginVo = getLoginSession(request);
        cmsVo.setModId(loginVo.getMngrId());

        // 사용자 권한 설정
        List<CmsUserGradeVO> cmsUserGradeVo = new ArrayList<CmsUserGradeVO>();
        String[] userGradeCds = request.getParameterValues("userGradeCds");
        if(null != userGradeCds) {
            for(String userGradeCd : userGradeCds) {
                CmsUserGradeVO gradeVo = new CmsUserGradeVO();
                gradeVo.setUserGradeCd(userGradeCd);
                cmsUserGradeVo.add(gradeVo);
            }
        }
        cmsVo.setUserGradeCd(cmsUserGradeVo);

        int affected = cmsService.updateMenu(cmsVo);

        if(affected != 1) {
            return responseText(model, Boolean.FALSE);
        }

        cmsService.synchronize(cmsVo);

        return responseText(model, Boolean.TRUE);
    }

    /**
     * 컨텐츠 담당자 메뉴정보 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_ChargerUpdateAction.do", method = RequestMethod.POST)
    public String chargerUpdateAction(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        cmsVo.setModId(loginVo.getMngrId());

        int affected = cmsService.chargerUpdateMenu(cmsVo);

        if(affected != 1) {
            return responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);
    }

    /**
     * 메뉴이동 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_MoveAction.do", method = RequestMethod.POST)
    public String moveAction(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        cmsVo.setModId(loginVo.getMngrId());

        int affected = cmsService.updateMoveMenu(cmsVo);

        if(affected < 1) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Boolean.TRUE, Messages.COMMON_PROCESS_OK);
    }

    /**
     * 메뉴정보 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_DeleteAction.do", method = RequestMethod.POST)
    public String deleteAction(HttpServletRequest request, ModelMap model, CmsVO cmsVo) throws Exception {

        int affected = cmsService.deleteMenu(cmsVo);

        if(affected < 1) {
            return responseJson(model, Boolean.FALSE, Messages.COMMON_PROCESS_FAIL);
        }

        return responseJson(model, Boolean.TRUE, Messages.COMMON_DELETE_OK);
    }

}
