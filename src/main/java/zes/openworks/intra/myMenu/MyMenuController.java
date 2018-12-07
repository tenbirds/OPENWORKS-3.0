package zes.openworks.intra.myMenu;

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
import zes.core.utils.StringUtil;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.menu.MenuVO;

/**
 * 내 메뉴관리 (내부) Controller
 * 
 * @author wisepms
 * @version $Id: MyMenuController.java 382 2010-02-16 11:10:05Z wisepms $
 */
@Controller
@RequestMapping(value = "/intra/myMenu")
public class MyMenuController extends IntraController {

    @Autowired
    MyMenuService myMenuService;

    /**
     * 내 메뉴정보 관리 페이지
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     * Explorer 내 메뉴 목록에서 사용함
     */
    @RequestMapping(value = "INC_myAssignMenuListAll.do", method = RequestMethod.POST)
    public String myAssignMenuListAll(ModelMap model, HttpServletRequest request,
        @ModelAttribute MenuVO menuBean) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        if(loginVo != null) {
            menuBean.setMngrId(loginVo.getMngrId());
        }

        return responseJson(model, myMenuService.myAssignMenuListAll(menuBean));
    }

    /**
     * 메뉴정보 목록 조회 (로그인 담당자에 해당하는 전체 Tree 조회)
     */
    @RequestMapping(value = "INC_myMenuListAll.do", method = RequestMethod.POST)
    public String myMenuListAll(ModelMap model, HttpServletRequest request,
        @ModelAttribute MenuVO menuBean) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        if(loginVo != null) {
            menuBean.setMngrId(loginVo.getMngrId());
        }

        return responseJson(model, myMenuService.myMenuListAll(menuBean));
    }

    /**
     * 내 메뉴정보 목록 조회 (로그인 담당자가 설정한 메뉴 조회)
     */
    @RequestMapping(value = "INC_myAssignMenuList.do", method = RequestMethod.GET)
    public String myAssignMenuList(ModelMap model, HttpServletRequest request,
        @ModelAttribute MenuVO menuBean) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        if(loginVo != null) {
            menuBean.setMngrId(loginVo.getMngrId());
        }

        List<MenuVO> menuList = myMenuService.myAssignMenuList(menuBean);

        return responseJson(model, menuList);
    }

    /**
     * 내 메뉴정보 수정 액션
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_updateAction.do", method = RequestMethod.POST)
    public String updateAction(ModelMap model, HttpServletRequest request) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);

        String[] menuCds = request.getParameter("menuCds").split(",");

        int affected = myMenuService.updateAction(loginVo.getMngrId(), menuCds);

        if(affected == StringUtil.ZERO) {
            responseText(model, Messages.FALSE);
        }

        return responseText(model, Messages.TRUE);
    }
}
