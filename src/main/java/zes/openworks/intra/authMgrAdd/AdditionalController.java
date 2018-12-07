package zes.openworks.intra.authMgrAdd;

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
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

/**
 * 권한 추가 요청관리 Controller
 * 
 * @author Administrator
 */
@Controller
@RequestMapping(value = "/intra/authMgrAddReq")
public class AdditionalController extends IntraController {

    @Autowired
    private AdditionalService service;

    /**
     * 권한 추가 요청관리 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView list(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);
        vo.setReqTypeCd("A");

        view.addObject(GlobalConfig.KEY_PAGER, service.list(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.listCount2(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.listCount3(vo));

        return view;
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_view.do", method = RequestMethod.POST)
    public void view(ModelMap model, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        // 권한 추가 요청 신청자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        // 현재 할당 권한 정보
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        // 추가 요청 권한 정보
        model.addAttribute(GlobalConfig.KEY_BASE_VO, service.addList(vo));
        model.addAttribute(GlobalConfig.KEY_VIEW_OBJECT, service.authCds(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.getMenuCd(vo));
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_approveAction.do", method = RequestMethod.POST)
    public String approve(AdditionalVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        LoginVO loginVo = getLoginSession(request);
        vo.setPrcMgrId(loginVo.getMngrId());

        service.approve(vo);
        service.approve2(vo);
        service.approve3(request);
        return responseText(model, Messages.TRUE);
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_retrocession.do", method = RequestMethod.POST)
    public String retrocession(ModelMap model, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        LoginVO loginVo = getLoginSession(request);
        vo.setPrcMgrId(loginVo.getMngrId());

        int affected = service.retrocession(vo);
        if(affected == StringUtil.ONE) {
            service.retrocession2(vo);
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);

    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_assignment.do", method = RequestMethod.GET, params = "authCd")
    public ModelAndView assignment(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        view.addObject(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount(vo));

        return view;
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_assignment.do", method = RequestMethod.GET, params = "seqNo")
    public ModelAndView assignment2(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        view.addObject(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu2(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount2(vo));

        return view;
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_resultPop.do", method = RequestMethod.GET)
    public ModelAndView resultPop(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        view.addObject(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        view.addObject(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.addList2(vo));

        return view;
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_returnPop.do", method = RequestMethod.GET)
    public ModelAndView returnPop(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        view.addObject(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        view.addObject(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.addList2(vo));
        view.addObject(GlobalConfig.KEY_VIEW_OBJECT, service.addList3(vo));

        return view;
    }

}
