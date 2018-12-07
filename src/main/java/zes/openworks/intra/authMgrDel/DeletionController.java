package zes.openworks.intra.authMgrDel;

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
import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.intra.authMgrAdd.AdditionalService;
import zes.openworks.intra.authMgrAdd.AdditionalVO;
import zes.openworks.intra.login.LoginVO;

@Controller
@RequestMapping(value = "/intra/authMgrDelReq")
public class DeletionController extends GeneralController {

    @Autowired
    private AdditionalService service;
    @Autowired
    private DeletionService service2;

    /**
     * 권한 삭제 요청 관리(관리자)
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView list(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {

        OpHelper.bindSearchMap(vo, request);
        vo.setReqTypeCd("D");

        view.addObject(GlobalConfig.KEY_PAGER, service.list(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.listCount2(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.listCount3(vo));

        return view;
    }

    /**
     * 권한 삭제 요청 자세히 보기
     * 
     * @param model
     * @param request
     * @param vo
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_view.do", method = RequestMethod.POST)
    public void view(ModelMap model, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        // 삭제 요청한 정보
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service2.delList(vo, request));
        model.addAttribute(GlobalConfig.KEY_BASE_VO, service2.delList2(vo, request));
        // 권한 삭제 신청자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
    }

    /**
     * 권한 그룹(세부 목록 보기)
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "PD_assignment.do", method = RequestMethod.GET)
    public ModelAndView assignment2(ModelAndView view, HttpServletRequest request, @ModelAttribute AdditionalVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        view.addObject(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount(vo));

        return view;
    }

    /**
     * @param vo
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_DeleteAction.do", method = RequestMethod.POST)
    public String approve(AdditionalVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        service2.delete(vo, request);
        return responseText(model, Messages.TRUE);
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

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_retrocession.do", method = RequestMethod.POST)
    public String retrocession(AdditionalVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setPrcMgrId(loginVo.getMngrId());

        int affected = service.retrocession(vo);
        if(affected == StringUtil.ONE) {
            service.retrocession2(vo);
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

}
