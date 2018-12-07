/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dept;

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
import zes.base.vo.IExcelVO;
import zes.base.vo.TreeVO;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
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
 *  2012. 4. 30.    유상원   부서 관리
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/dept")
public class DeptController extends IntraController {

    @Autowired
    private DeptService service;

    /**
     * 부서관리 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * 부서관리 목록 for TreeList
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptList.do", method = RequestMethod.POST)
    public String deptList(DeptVO vo, ModelMap model) {

        return responseJson(model, service.deptList(vo));
    }

    /**
     * 부서정보 목록 조회 (전체 Tree 조회)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptListAll.do", method = RequestMethod.POST)
    public String deptListAll(DeptVO vo, ModelMap model) {

        return responseJson(model, service.deptListAll(vo));
    }

    /**
     * 부서정보 목록 조회 (autocomplite 겸용)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptSearchList.do", method = RequestMethod.POST)
    public String deptSearchList(DeptVO vo, ModelMap model) {

        return responseJson(model, service.deptSearchList(vo));
    }

    /**
     * 부서정보 상세 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptView.do", method = RequestMethod.POST)
    public void deptView(DeptVO vo, ModelMap model) {

        model.addAttribute("deptKey", service.deptKey(vo).getDeptKey());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.deptView(vo));
    }

    /**
     * 부서정보 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String insertAction(DeptVO vo, ModelMap model) {

        int affected = service.insertAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        } else {
            return responseText(model, Messages.FALSE);
        }
    }

    /**
     * 부서 코드 중복확인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptDupCheck.do", method = RequestMethod.POST)
    public String deptDupCheck(DeptVO vo, ModelMap model) {

        return responseText(model, service.dupCheckDept(vo));
    }

    /**
     * 부서정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String updateAction(DeptVO vo, ModelMap model) {

        int affected = service.updateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 부서정보 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(DeptVO vo, ModelMap model) {

        int affected = service.deleteAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 부서정보 목록 조회 (계층별 Tree 조회) : for NOTE
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptUserTreeList.do", method = RequestMethod.POST)
    public String deptList(DeptUserTreeVO vo, HttpServletRequest request, ModelMap model) {

        vo.setLoginVo(OpHelper.getMgrSession(request));

        List<TreeVO> deptList = service.deptUserTreeList(vo);

        return responseJson(model, deptList);
    }

    /**
     * 부서관리 엑셀출력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_deptListExcel.do")
    public String deptListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute DeptVO vo) {

        OpHelper.bindSearchMap(vo, request);

        model.put("_deptList", service.deptListExcel(vo));
        IExcelVO deptListExcel = new DeptListExcelVO();
        return responseExcel(model, deptListExcel);
    }

    /**
     * registerExcelEnBloForm 부서 일괄등록 폼 조회
     * 
     * @param model
     * @param request
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_registerExcelEnBloc.do", method = RequestMethod.GET)
    public void registerExcelEnBloForm(ModelMap model, HttpServletRequest request) throws Exception {

    }

    /**
     * registerExcelEnBloLoad 일괄 등록할 첨부한 엑셀내용 불러오기
     * 
     * @param model
     * @param request
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_registerExcelEnBloc.do", method = RequestMethod.POST)
    public void registerExcelEnBloLoad(ModelMap model, HttpServletRequest request) throws Exception {
        List<DeptVO> deptList = service.registerExcelEnBloLoad(request);

        model.addAttribute("deptList", deptList);
    }

    /**
     * insertDeptExcelEnBloc 부서 일괄등록 처리
     * 
     * @param model
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertDeptExcelEnBlocAction.do")
    public String insertDeptExcelEnBloc(ModelMap model, HttpServletRequest request, DeptVO vo) throws Exception {
        int affected = service.insertDeptExcelEnBloc(vo);

        if(affected > 0) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }
}
