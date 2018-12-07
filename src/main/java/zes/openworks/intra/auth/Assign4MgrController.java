package zes.openworks.intra.auth;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;

@Controller
@RequestMapping(value = "/intra/authAssign4Mgr")
public class Assign4MgrController extends IntraController {

    @Resource(name = "authService")
    private AuthService service;

    /**
     * 권한할당 관리 페이지
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * 개인별 권한 목록
     */
    @RequestMapping(value = "ND_mgrAuthList.do", method = RequestMethod.POST)
    public String mgrAuthList(AuthVO vo, ModelMap model) {
        return responseJson(model, service.mgrAuthList(vo));
    }

    /**
     * 권한그룹 목록
     */
    @RequestMapping(value = "ND_groupAuthList.do", method = RequestMethod.POST)
    public String authList(AuthVO vo, ModelMap model) {
        return responseJson(model, service.groupAuthList(vo));
    }

    /**
     * 메뉴 목록
     */
    @RequestMapping(value = "ND_authMenuList.do", method = RequestMethod.POST)
    public void authView(AuthVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.menuList(vo));
    }

    /**
     * 부서별 할당권한 목록
     */
    @RequestMapping(value = "PD_authMenuList.do", method = RequestMethod.GET)
    public void authMenuList(AuthVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.authMenuList(vo));
    }

    /**
     * 개인별 권한 할당 저장
     */
    @RequestMapping(value = "ND_assign4MgrSaveAction.do", method = RequestMethod.POST)
    public String assign4MgrSaveAction(HttpServletRequest request, ModelMap model) {
        service.saveAssign4Mgr(request);
        return responseText(model, Messages.COMMON_UPDATE_OK);
    }

    /**
     * 부서별 할당권한 목록
     */
    @RequestMapping(value = "PD_mgrAddFrom.do")
    public void mgrList(AuthMgrVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.mgrList(vo));
    }

}
