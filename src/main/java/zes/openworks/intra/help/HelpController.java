package zes.openworks.intra.help;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

/**
 * 관리자단 메뉴별 도움말 관리
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 7. 10.    방기배       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/help")
public class HelpController extends IntraController {

    @Resource(name = "helpService")
    private HelpService service;

    /**
     * 도움말 관리 페이지
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void index(HelpVO vo, HttpServletRequest request, ModelMap model) {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.getHelpList(vo));
    }

    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_menuList.do")
    public String menuList(ModelMap model) {

        return responseJson(model, service.getMenuList());
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "PD_helpAddForm.do")
    public void helpAddForm(ModelMap model) {
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_saveHelpAction.do", method = RequestMethod.POST)
    public String saveHelp(HelpVO vo, ModelMap model) {
        int affected = service.saveHelpItem(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "INC_deleteHelpAction.do", method = RequestMethod.POST)
    public String deleteHelp(HelpVO vo, ModelMap model) {

        int affected = service.deleteHelpItem(vo);

        if(affected >= StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }

}
