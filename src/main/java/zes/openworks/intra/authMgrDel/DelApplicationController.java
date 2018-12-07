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
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.intra.authMgrAdd.AddApplicationService;
import zes.openworks.intra.authMgrAdd.AddApplicationVO;
import zes.openworks.intra.authMgrAdd.AdditionalService;
import zes.openworks.intra.login.LoginVO;

@Controller
@RequestMapping(value = "/intra/authMgrDelAp")
public class DelApplicationController extends GeneralController {

    @Autowired
    private AddApplicationService service;
    @Autowired
    private DelApplicationService service2;
    @Autowired
    private AdditionalService service3;

    /**
     * 권한 삭제 리스트 페이지(신청자)
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_index.do")
    public ModelAndView list(ModelAndView view, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(Validate.isNotEmpty(loginVo)) {
            vo.setMngrId(loginVo.getMngrId());
        }
        OpHelper.bindSearchMap(vo, request);
        vo.setReqTypeCd("D");
        view.addObject(GlobalConfig.KEY_PAGER, service.list(vo));

        view.addObject(GlobalConfig.KEY_DATA_VO, service3.listCount2(null));
        view.addObject(GlobalConfig.KEY_BASE_VO, service3.listCount3(null));

        return view;
    }

    /**
     * 권한 삭제 신청하기
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_delView.do", method = RequestMethod.GET)
    public void addView(ModelMap model, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(Validate.isNotEmpty(loginVo)) {
            vo.setMngrId(loginVo.getMngrId());
        }
        // 권한 추가 요청 신청자 정보
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service2.applicant(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service2.currentlyList(vo));
        vo.setAuthCd("P_AUTH_" + loginVo.getMngrId());
        model.addAttribute(GlobalConfig.KEY_BASE_VO, service2.currentlyList2(vo));
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_InsertAction.do", method = RequestMethod.POST)
    public String insert(HttpServletRequest request, ModelMap model, @ModelAttribute AddApplicationVO vo) {
        service2.insert(vo, request);
        return responseText(model, Messages.TRUE);
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_assignment.do", method = RequestMethod.GET)
    public ModelAndView assignment(ModelAndView view, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        view.addObject(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount(vo));
        return view;
    }

    /**
     * 권한 삭제 요청 승인시 팝업
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_resultPop.do", method = RequestMethod.GET)
    public ModelAndView resultPop(ModelAndView view, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(Validate.isNotEmpty(loginVo)) {
            vo.setMngrId(loginVo.getMngrId());
        }
        view.addObject(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        view.addObject(GlobalConfig.KEY_DATA_LIST, service2.currentlyList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.addList2(vo));
        return view;
    }

    /**
     * 권한 삭제 요청 반려시 팝업
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_returnPop.do", method = RequestMethod.GET)
    public ModelAndView returnPop(ModelAndView view, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(Validate.isNotEmpty(loginVo)) {
            vo.setMngrId(loginVo.getMngrId());
        }
        view.addObject(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        view.addObject(GlobalConfig.KEY_DATA_LIST, service2.currentlyList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.addList2(vo));
        view.addObject(GlobalConfig.KEY_VIEW_OBJECT, service.addList3(vo));
        return view;
    }
}
