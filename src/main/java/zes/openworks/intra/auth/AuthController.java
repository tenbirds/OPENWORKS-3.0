package zes.openworks.intra.auth;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.login.LoginVO;

@Controller
@RequestMapping(value = "/intra/auth")
public class AuthController extends IntraController {

    @Resource(name = "authService")
    private AuthService service;

    /**
     * 권한정보 관리 페이지
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {
    }

    /**
     * 권한그룹 목록 BOX
     */
    @RequestMapping(value = "ND_groupAuthList.do", method = RequestMethod.POST)
    public String authAllList(AuthVO vo, ModelMap model) {
        return responseJson(model, service.groupAuthList(vo));
    }

    /**
     * 관리자권한 수정 폼
     */
    @RequestMapping(value = "ND_authForm.do", method = RequestMethod.POST)
    public void authFrom(AuthVO vo, ModelMap model) {
        if(vo == null || vo.getAuthCode() == null || "".equals(vo.getAuthCode())) {
        } else {
            model.addAttribute(GlobalConfig.KEY_DATA_VO, service.authView(vo));
        }
    }

    /**
     * 관리자권한 폼 저장
     */
    @RequestMapping(value = "ND_authSaveAction.do", method = RequestMethod.POST)
    public String authSaveAction(AuthVO vo, HttpServletRequest request, ModelMap model) {
        // 사용자 정보 설정
        LoginVO loginVo = getLoginSession(request);
        if(Validate.isNotEmpty(loginVo)) {
            vo.setRegId(loginVo.getMngrId());
            vo.setModiId(loginVo.getMngrId());
        }

        String returnMessage = "";
        if("".equals(vo.getOldAuthCd())) {
            service.insertAuth(vo);
            returnMessage = Messages.COMMON_INSERT_OK;
        } else {
            service.updateAuth(vo);
            returnMessage = Messages.COMMON_UPDATE_OK;

        }
        return responseJson(model, Boolean.TRUE, returnMessage);
    }

    /**
     * 관리자권한 폼 삭제
     */
    @RequestMapping(value = "ND_authDeleteAction.do", method = RequestMethod.POST)
    public String authSaveDelete(AuthVO vo, ModelMap model) {
        service.deleteAuth(vo);
        
        return responseText(model, Messages.TRUE);
    }

    /**
     * 관리자권한 폼 중복확인
     */
    @RequestMapping(value = "ND_authDupCheck.do", method = RequestMethod.POST)
    public String authDupCheck(AuthVO vo, ModelMap model) {
        return responseText(model, service.dupCheckAuth(vo));
    }

    /**
     * 권한그룹 목록 > 담당자 목록 팝업
     */
    @RequestMapping(value = "PD_mgrList.do", method = RequestMethod.GET)
    public void mgrList(AuthMgrVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.mgrList4Auth(vo));
    }

    /**
     * 메뉴 목록
     */
    @RequestMapping(value = "ND_authMenuList.do", method = RequestMethod.POST)
    public void authView(AuthVO vo, ModelMap model) {
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.menuList(vo));
    }

    /**
     * 권한 메뉴 할당 정보 저장
     * 
     * @return
     */
    @RequestMapping(value = "ND_assignMenuSaveAction.do", method = RequestMethod.POST)
    public String assignMenuSaveAction(HttpServletRequest request, ModelMap model) {

        service.saveAssignMenu(request);

        return responseText(model, Messages.COMMON_UPDATE_OK);
    }
}
