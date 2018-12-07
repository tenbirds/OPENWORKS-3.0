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
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

@Controller
@RequestMapping(value = "/intra/authMgrAddAp")
public class AddApplicationController extends IntraController {

    @Autowired
    private AddApplicationService service;
    @Autowired
    private AdditionalService service2;

    /**
     * 권한 추가 요청관리 리스트(신청자)
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
        vo.setReqTypeCd("A");
        view.addObject(GlobalConfig.KEY_PAGER, service.list(vo));

        view.addObject(GlobalConfig.KEY_DATA_VO, service2.listCount2(null));
        view.addObject(GlobalConfig.KEY_BASE_VO, service2.listCount3(null));

        return view;
    }

    /**
     * 권한 추가 요청 승인시 팝업
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
        view.addObject(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.addList2(vo));

        return view;
    }

    /**
     * 권한 추가 요청 반려시 팝업
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
        vo.setMngrId(loginVo.getMngrId());

        view.addObject(GlobalConfig.KEY_DATA_VO, service.applicant(vo));
        view.addObject(GlobalConfig.KEY_DATA_LIST, service.currentlyList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.addList2(vo));
        view.addObject(GlobalConfig.KEY_VIEW_OBJECT, service.addList3(vo));

        return view;
    }

    /**
     * 권한 추가 요청 신청 페이지
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_addView.do", method = RequestMethod.GET)
    public ModelAndView addView(ModelAndView view, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setMngrId(loginVo.getMngrId());

        view.addObject(GlobalConfig.KEY_DATA_LIST, service.currentlyList1(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.authGroupList(vo));
        view.addObject(GlobalConfig.KEY_BASE_VO, service.menuAllList(vo));

        return view;
    }

    /**
     * 현재 내 할당 권한 목록
     * 
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_currentlyList.do", method = RequestMethod.POST)
    public String currentlyList(ModelMap model, @ModelAttribute AddApplicationVO vo) {
        return responseJson(model, service.currentlyList(vo));
    }

    /**
     * 할당 권한 목록 보기
     * 
     * @param view
     * @param request
     * @param vo
     * @return
     * @throws Exception
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_assignment.do", method = RequestMethod.GET)
    public ModelAndView assignment(ModelAndView view, HttpServletRequest request, @ModelAttribute AddApplicationVO vo) throws Exception {
        view.addObject(GlobalConfig.KEY_DATA_LIST, service.assignmentMenu(vo));
        view.addObject(GlobalConfig.KEY_DATA_VO, service.assignmentMenuCount(vo));

        return view;
    }

    /**
     * 권한추가 요청하기
     * 
     * @param request
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String insert(HttpServletRequest request, ModelMap model) {

        service.insert(request);

        return responseText(model, Messages.TRUE);
    }
}
