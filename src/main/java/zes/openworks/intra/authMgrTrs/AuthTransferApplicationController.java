package zes.openworks.intra.authMgrTrs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 권한 이양 신청 Controller
 * 
 * @author Administrator
 */
@Controller
@RequestMapping(value = "/intra/authMgrTrsAp")
public class AuthTransferApplicationController extends IntraController {

    @Autowired
    private AuthTransferApplicationService service;

    /**
     * 권한 이양 신청 메인
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView list(ModelAndView view, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {
        LoginVO loginVO = getLoginSession(request);
        vo.setMngrId(loginVO.getMngrId());

        OpHelper.bindSearchMap(vo, request);
        view.addObject(GlobalConfig.KEY_PAGER, service.list(vo));
        return view;
    }

    /**
     * 권한 이양 신청 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_authTransferAppInsForm.do")
    public void authTransferApp(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {
        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVO.getMngrId());

        // 권한 이양 신청자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        // 현재 할당 권한 정보
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        // 현재 할당 된 개별권한의 메뉴 정보
        model.addAttribute("prvDataList", service.prvCurrentlyList(vo));
    }

    /**
     * 권한 이양 대상자 목록
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_directorSerch.do")
    public ModelAndView directorSerchList(ModelAndView model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo)
        throws Exception {
        OpHelper.bindSearchMap(vo, request);
        model.addObject(GlobalConfig.KEY_PAGER, service.directorSerchList(vo));
        return model;
    }

    /**
     * 권한 이양 신청 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do")
    public String insertAction(HttpServletRequest request, ModelMap model) {
        service.insertAction(request);
        return responseText(model, Messages.TRUE);
    }

    /**
     * 권한 이양 수정 폼
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_view.do")
    public void view(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {

        LoginVO loginVO = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVO.getMngrId());

        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));
        // 현재 할당 권한 정보
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        // 현재 할당 된 개별권한의 메뉴 정보
        model.addAttribute("prvDataList", service.prvCurrentlyList(vo));
        // 이양시킬 권한 정보
        model.addAttribute("sendDataList", service.sendCurrentlyList(vo));

        // 처리확인여부
        model.addAttribute("resTypeCd", service.resTypeCdCheck(vo));
    }

    /**
     * 권한 이양 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_updateAction.do")
    public String updateAction(HttpServletRequest request, ModelMap model) {
        service.updateAction(request);
        return responseText(model, Messages.TRUE);
    }

    /**
     * 권한 상세정보
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_assignment.do")
    public ModelAndView assignment(ModelAndView model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {
        model.addObject(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu(vo));
        model.addObject(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount(vo));

        return model;
    }

    /**
     * 권한이양 처리결과 - 승인
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_resultViewP.do")
    public void resultViewP(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {
        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));

        // 신청자 변경전 권한
        // List<AuthTransferApplicationVO> mgrAuthBeforeList =
        // service.mgrAuthBeforeList(vo);
        // model.addAttribute("mgrAuthBeforeList", mgrAuthBeforeList);

        // 신청자 변경후 권한
        List<AuthTransferApplicationVO> currentlyList = service.currentlyList(vo);
        model.addAttribute("currentlyList", currentlyList);

        // 대상자 변경전 권한
        List<AuthTransferApplicationVO> targetMgrAuthBeforeList = service.targetMgrAuthBeforeList(vo);
        model.addAttribute("targetMgrAuthBeforeList", targetMgrAuthBeforeList);

        // 대상자 변경후 권한
        List<AuthTransferApplicationVO> targetMgrAuthAfterList = service.targetMgrAuthAfterList(vo);
        model.addAttribute("targetMgrAuthAfterList", targetMgrAuthAfterList);

        // 실제 이양시킨 권한
        List<AuthTransferApplicationVO> authTrasferList = service.authTrasferList(vo);
        model.addAttribute("authTrasferList", authTrasferList);
    }

    /**
     * 권한이양 처리결과 - 수정승인
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_resultViewT.do")
    public void resultViewT(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {
        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));

        // 신청자 변경전 권한
        // List<AuthTransferApplicationVO> mgrAuthBeforeList =
        // service.mgrAuthBeforeList(vo);
        // model.addAttribute("mgrAuthBeforeList", mgrAuthBeforeList);

        // 신청자 변경후 권한
        List<AuthTransferApplicationVO> currentlyList = service.currentlyList(vo);
        model.addAttribute("currentlyList", currentlyList);

        // 대상자 변경전 권한
        List<AuthTransferApplicationVO> targetMgrAuthBeforeList = service.targetMgrAuthBeforeList(vo);
        model.addAttribute("targetMgrAuthBeforeList", targetMgrAuthBeforeList);

        // 대상자 변경후 권한
        List<AuthTransferApplicationVO> targetMgrAuthAfterList = service.targetMgrAuthAfterList(vo);
        model.addAttribute("targetMgrAuthAfterList", targetMgrAuthAfterList);

        // 실제 이양시킨 권한
        List<AuthTransferApplicationVO> authTrasferList = service.authTrasferList(vo);
        model.addAttribute("authTrasferList", authTrasferList);
    }

    /**
     * 권한이양 처리결과 - 반려
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_resultViewC.do")
    public void resultViewC(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferApplicationVO vo) throws Exception {
        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));

        // 신청자 변경전 권한
        List<AuthTransferApplicationVO> mgrAuthBeforeList = service.mgrAuthBeforeList(vo);
        model.addAttribute("mgrAuthBeforeList", mgrAuthBeforeList);

        // 대상자 변경전 권한
        List<AuthTransferApplicationVO> targetMgrAuthBeforeList = service.targetMgrAuthBeforeList(vo);
        model.addAttribute("targetMgrAuthBeforeList", targetMgrAuthBeforeList);
    }
}
