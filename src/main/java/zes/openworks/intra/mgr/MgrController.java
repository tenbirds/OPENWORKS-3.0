package zes.openworks.intra.mgr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.menugrp.MenuGrpService;

/**
 * 담당자 관리 Controller
 * 
 * @author zesinc
 */

@Controller
@RequestMapping(value = "/intra/mgr")
public class MgrController extends IntraController {

    @Autowired
    private MgrService service;

    @Autowired
    private MenuGrpService menuGrpService;

    /**
     * 담당자 정보 관리 페이지(메인)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void index() {

    }

    /**
     * 담당자 정보 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_mgrList.do", method = RequestMethod.POST)
    public void mgrList(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);
        // model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.mgrList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.mgrList(vo));
    }

    /**
     * 담당자 정보 목록 조회(할당권한 포함)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_mgrListWithPermission.do")
    public void mgrListWithPermission(ModelMap model, HttpServletRequest request,
        @ModelAttribute("mgrVO") MgrVO vo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVO.getMngrId());

        vo.setDeptCode(vo.getDeptCode());
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.mgrListWithPermission(vo));
        model.addAttribute("deptNm", service.mgrDeptNm(vo));
    }

    /**
     * 담당자 정보 검색 목록 조회
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_mgrSearchList.do", method = RequestMethod.POST)
    public void mgrSearchList(MgrVO vo, ModelMap model) {

        if(Validate.isNotEmpty(vo.getQ_searchKey()) && Validate.isNotEmpty(vo.getQ_searchVal())) {

            model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.mgrSearchList(vo));
        }
    }

    /**
     * 담당자 정보 검색 목록 조회(자동완성)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_mgrSearchList.do", method = RequestMethod.POST)
    public String ajaxMgrSearchList(MgrVO vo, ModelMap model) {

        return responseJson(model, service.mgrSearchList(vo));
    }

    /**
     * 담당자 ID 중복 체크
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_checkDupleId.do", method = RequestMethod.GET)
    public String checkDupleId(MgrVO vo, ModelMap model) {

        int cnt = service.mgrView(vo);

        if(cnt != 0) {
            return responseText(model, Messages.FALSE);
        }
        return responseText(model, Messages.TRUE);
    }

    /**
     * 담당자 정보 등록 폼 팝업
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_insertForm.do", method = RequestMethod.GET)
    public void insertForm() {

    }

    /**
     * 담당자 정보 등록 폼-보안등급정책 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_security.do", method = RequestMethod.GET)
    public void securityPolicy() {

    }

    /**
     * 담당자 일괄권한지정 팝업
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_assignInsertList.do")
    public void assignInsertList(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {

        model.addAttribute("mgrId", vo.getMngrId());

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.authList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.currentlyList(vo));
    }

    /**
     * 담당자 권한 정보 일괄 입력 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertListAction.do")
    public String assignInsertListAction(HttpServletRequest request, ModelMap model) {

        int cnt = service.assignInsertListAction(request);

        if(cnt <= 0) {
            return responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);
    }

    /**
     * 담당자 정보 삭제(리스트) 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_deleteListAction.do")
    public String deleteListAction(HttpServletRequest request, ModelMap model) {
        service.deleteListAction(request);
        return responseText(model, Messages.TRUE);
    }

    /**
     * 담당자 부서이동 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_deptTransferAction.do", method = RequestMethod.POST)
    public String deptTransferAction(HttpServletRequest request, ModelMap model) {
        
        int cnt = service.deptTransferAction(request);
        
        if(cnt <= 0) {
            return responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);
    }

    /**
     * 담당자 정보 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String insertAction(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());

        Object newSeq = service.insertAction(vo);
        if(newSeq != null) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 담당자 정보 수정 폼
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_updateForm.do", method = RequestMethod.GET)
    public void updateForm(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.mgrViewWithPermission(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
    }

    /**
     * 담당자 부서이동 팝업
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_deptTransfer.do", method = RequestMethod.GET)
    public void deptTransfer(ModelMap model, HttpServletRequest request) throws Exception {
        Map<String, String[]> map = new HashMap<String, String[]>();
        map.put("mgrIds", request.getParameter("mgrIds").split(","));

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.getDeptTransferInfo(map));
    }

    /**
     * 담당자 비밀번호 변경 팝업
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_passwordUpdate.do", method = RequestMethod.GET)
    public void passwordUpdate(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {

    }

    /**
     * 담당자 할당권한 보기 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = { "PD_targetAssign.do", "PD_targetAssignByAuthCd.do" }, method = RequestMethod.GET)
    public ModelAndView assignment(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo, ModelAndView view) throws Exception {

        if(request.getRequestURI().endsWith("PD_targetAssign.do")) {
            List<MgrVO> authList = service.currentlyList(vo);
            if(vo.getAuthCode() == null && authList != null) {
                MgrVO mgrvo = authList.get(0);
                vo.setAuthCode(mgrvo.getAuthCode());
            }
            model.addAttribute(GlobalConfig.KEY_DATA_LIST, authList);
        } else {
            MgrVO authInfo = service.selectAuthNmByAuthCd(vo);
            model.addAttribute("authInfo", authInfo);
        }
        view.setViewName("/intra/mgr/PD_targetAssign");
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.menuList(vo));

        return view;
    }

    /**
     * 선택된 할당권한 메뉴리스트(할당권한 보기 팝업 메뉴명, 사용권한)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_targetAssignSelect.do", method = RequestMethod.GET)
    public void targetAssignSelect(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {

        model.addAttribute("authCode", vo.getAuthCode());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.menuList(vo));
    }

    /**
     * 담당자 권한 정보 입력 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertAssignAction.do")
    public String assignInsertAction(HttpServletRequest request, ModelMap model, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setRegId(loginVO.getMngrId());
        service.assignInsertAction(vo);

        return responseText(model, Messages.TRUE);
    }

    /**
     * 담당자 비밀번호 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updatePwdAction.do", method = RequestMethod.POST)
    public String updatePwdAction(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());
        
        int affected = service.updatePwdAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }else if(affected < 0){
            return responseText(model, "-1");
        }else{
            return responseText(model, Messages.FALSE);
        }        
    }

    /**
     * 담당자 정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String updateAction(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());

        int affected = service.updateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 담당자 권한 정보 수정 폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_assignForm.do", method = RequestMethod.GET)
    public void assignForm(MgrVO vo, ModelMap model) {

        model.addAttribute("menuGrpList", menuGrpService.menuGrpList());

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.menuAssignList(vo));
    }

    /**
     * 담당자 할당권한 보기 팝업
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_authAssignForm.do")
    public void assignUpdate(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) throws Exception {

        model.addAttribute("mgrId", vo.getMngrId());

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.authList(vo));
        model.addAttribute("currentlyListByMgrId", service.currentlyList(vo));
    }

    /**
     * 담당자 권한 정보 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_assignUpdateAction.do", method = RequestMethod.POST)
    public String assignUpdateAction(HttpServletRequest request, ModelMap model, MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setRegId(loginVO.getMngrId());
        service.assignUpdateAction(vo);

        return responseText(model, Messages.TRUE);
    }

    /**
     * 담당자 사용여부 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_mgrUseYnUpdateAction.do", method = RequestMethod.POST)
    public String useYnUpdateAction(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());

        int affected = service.useYnUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 담당자 정보 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());

        int affected = service.deleteAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * 접속 이력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_webLog.do")
    public void webLog(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.webLogList(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.getWebLogContents(vo));
        model.addAttribute("ipState", service.getIpState(vo));
    }

    /**
     * 변경 이력
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_changeLog.do")
    public void changeLog(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.changeLogList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_mgrListExcel.do")
    public String mgrListExcel(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.put("_mgrList", service.mgrListExcel(vo));

        return responseExcel(model, new MgrListExcelVO());
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_webLogExcel.do")
    public String webLogExcel(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.put("_mgrList", service.webLogExcel(vo));

        return responseExcel(model, new WebLogExcelVO());
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_changeLogExcel.do")
    public String changeLogExcel(ModelMap model, HttpServletRequest request, @ModelAttribute MgrVO vo) {
        OpHelper.bindSearchMap(vo, request);

        model.put("_mgrList", service.changeLogExcel(vo));

        return responseExcel(model, new ChangeLogExcelVO());
    }

    /**
     * registerExcelEnBlo 담당자 일괄등록 폼 조회
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
        List<MgrVO> mgrList = service.registerExcelEnBloLoad(request);

        model.addAttribute("mgrList", mgrList);
    }

    /**
     * 담당자 관리 일괄등록 처리
     * 
     * @return
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertMrgExcelEnBlocAction.do")
    public String insertMrgExcelEnBloc(ModelMap model, HttpServletRequest request, MgrVO vo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setModiId(loginVO.getMngrId());

        int affected = service.insertMrgExcelEnBloc(vo);

        if(affected > 0) {
            return responseJson(model, Messages.TRUE,  affected, Messages.COMMON_INSERT_OK);
        }

        return responseJson(model, Messages.FALSE, Messages.COMMON_PROCESS_FAIL);
    }
}
