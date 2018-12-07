package zes.openworks.intra.authMgrTrs;

import java.util.List;

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
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 권한 이양 요청관리 Controller
 * 
 * @author Administrator
 */
@Controller
@RequestMapping(value = "/intra/authMgrTrsReq")
public class AuthTransferController extends IntraController {

    @Autowired
    private AuthTransferService service;

    /**
     * 권한이양관리 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView list(ModelAndView view, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);
        view.addObject(GlobalConfig.KEY_PAGER, service.list(vo));
        view.addObject("resTypeCds", vo.getResTypeCds());
        return view;
    }

    /**
     * 권한이양관리 승인 폼
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "BD_view.do")
    public void view(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));
        // //현재 할당 권한이양 정보
        // model.addAttribute(Commons.KEY_DATA_LIST,service.currentlyList(vo));
        // 현재 할당 된 개별권한의 메뉴 정보
        model.addAttribute("prvDataList", service.prvCurrentlyList(vo));
        // 이양시킬 권한 정보
        model.addAttribute("sendDataList", service.sendCurrentlyList(vo));

        // 처리확인여부
        model.addAttribute("resTypeCd", service.resTypeCdCheck(vo));
    }

    /**
     * 권한이양관리 대상자 권한정보
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_targetAssignMenu.do")
    public void targetAssignMenu(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        vo.setMngrId(vo.getTargetMgrId());
        // 권한 이양 대상자 직위명
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.targetTitleNm(vo));
        // 현재 할당 권한 정보
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
    }

    /**
     * 권한이양관리 승인액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_approveAction.do", method = RequestMethod.POST)
    public String approveAction(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        LoginVO loginVo = getLoginSession(request);
        vo.setPrcMgrId(loginVo.getMngrId());

        service.authReqApproveAction(vo);
        service.authReqItemApproveAction(request);

        service.authMgrAssignApproveAction(request);
        service.authReqItemMenuApproveAction(request);

        service.deleteAction(request);
        return responseText(model, Messages.TRUE);
    }

    /**
     * 권한이양관리 반려액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_retrocedeAction.do", method = RequestMethod.POST)
    public String retrocedeAction(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        service.authReqApproveAction(vo);
        service.authReqItemRetrocedeAction(request);

        return responseText(model, Messages.TRUE);
    }

    /**
     * 권한이양 처리결과 - 승인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_resultViewP.do")
    public void resultViewP(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));

        // 신청자 변경전 권한
        List<AuthTransferVO> mgrAuthBeforeList = service.mgrAuthBeforeList(vo);
        model.addAttribute("mgrAuthBeforeList", mgrAuthBeforeList);

        // 신청자 변경후 권한
        List<AuthTransferVO> currentlyList = service.currentlyList(vo);
        model.addAttribute("currentlyList", currentlyList);

        // 대상자 변경전 권한
        List<AuthTransferVO> targetMgrAuthBeforeList = service.targetMgrAuthBeforeList(vo);
        model.addAttribute("targetMgrAuthBeforeList", targetMgrAuthBeforeList);

        // 대상자 변경후 권한
        List<AuthTransferVO> targetMgrAuthAfterList = service.targetMgrAuthAfterList(vo);
        model.addAttribute("targetMgrAuthAfterList", targetMgrAuthAfterList);

        // 실제 이양시킨 권한
        List<AuthTransferVO> authTrasferList = service.authTrasferList(vo);
        model.addAttribute("authTrasferList", authTrasferList);
    }

    /**
     * 권한이양 처리결과 - 수정승인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_resultViewT.do")
    public void resultViewT(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));

        // 신청자 변경전 권한
        List<AuthTransferVO> mgrAuthBeforeList = service.mgrAuthBeforeList(vo);
        model.addAttribute("mgrAuthBeforeList", mgrAuthBeforeList);

        // 신청자 변경후 권한
        List<AuthTransferVO> currentlyList = service.currentlyList(vo);
        model.addAttribute("currentlyList", currentlyList);

        // 대상자 변경전 권한
        List<AuthTransferVO> targetMgrAuthBeforeList = service.targetMgrAuthBeforeList(vo);
        model.addAttribute("targetMgrAuthBeforeList", targetMgrAuthBeforeList);

        // 대상자 변경후 권한
        List<AuthTransferVO> targetMgrAuthAfterList = service.targetMgrAuthAfterList(vo);
        model.addAttribute("targetMgrAuthAfterList", targetMgrAuthAfterList);

        // 실제 이양시킨 권한
        List<AuthTransferVO> authTrasferList = service.authTrasferList(vo);
        model.addAttribute("authTrasferList", authTrasferList);
    }

    /**
     * 권한이양 처리결과 - 반려
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_resultViewC.do")
    public void resultViewC(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {

        // 권한 이양 신청자, 대상자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicantDirector(vo));

        // 신청자 변경전 권한
        List<AuthTransferVO> mgrAuthBeforeList = service.mgrAuthBeforeList(vo);
        model.addAttribute("mgrAuthBeforeList", mgrAuthBeforeList);

        // 대상자 변경전 권한
        List<AuthTransferVO> targetMgrAuthBeforeList = service.targetMgrAuthBeforeList(vo);
        model.addAttribute("targetMgrAuthBeforeList", targetMgrAuthBeforeList);
    }

    /**
     * 권한 상세정보
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_assignment.do")
    public void assignment(ModelMap model, HttpServletRequest request, @ModelAttribute AuthTransferVO vo) throws Exception {
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount(vo));
    }

}
