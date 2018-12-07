package zes.openworks.intra.menu;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

@Controller
@RequestMapping(value = "/intra/menu")
public class MenuController extends IntraController {

    @Autowired
    private MenuService service;

    /**
     * 메뉴관리 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * 메뉴관리 목록 for TreeList
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_menuList.do", method = RequestMethod.POST)
    public String menuList(MenuVO vo, ModelMap model) {
        return responseJson(model, service.menuList(vo));
    }

    /**
     * 메뉴관리 목록 (전체 for MGR_ID)
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_myMenuListAll.do", method = RequestMethod.POST)
    public String myMenuListAll(MenuVO vo, HttpServletRequest request, ModelMap model) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(loginVo != null) {
            vo.setMngrId(loginVo.getMngrId());
        }
        return responseJson(model, service.myMenuListAll(vo));
    }

    /**
     * 메뉴관리 상세
     */
    @RequestMapping(value = "INC_menuView.do", method = RequestMethod.POST)
    public void menuView(MenuVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.menuView(vo));
    }

    /**
     * 메뉴관리 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String insertAction(MenuVO vo, ModelMap model) {
        Object newSeq = service.insertAction(vo);

        if(newSeq != null) {
            return responseJson(model, Messages.TRUE, newSeq, Messages.COMMON_INSERT_OK);
        }

        return responseJson(model, Messages.FALSE, Messages.COMMON_PROCESS_FAIL);
    }

    /**
     * 메뉴관리 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String updateAction(MenuVO vo, ModelMap model) {
        int affected = service.updateAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 메뉴관리 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(MenuVO vo, ModelMap model) {
        int affected = service.deleteAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }else if(affected == StringUtil.ZERO){
            return responseText(model, Messages.DEL_MENU_AUTH_ASGN);
        }else{
            return responseText(model, Messages.FALSE);
        }
    }
}
