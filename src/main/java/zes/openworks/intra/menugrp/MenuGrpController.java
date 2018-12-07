package zes.openworks.intra.menugrp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.vo.JsonVO;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;

@Controller
@RequestMapping(value = "/intra/menugrp")
public class MenuGrpController extends GeneralController {

    @Autowired
    private MenuGrpService service;

    /**
     * 메뉴그룹정보 목록 조회
     */
    @RequestMapping(value = "BD_menuGrpList.do", method = RequestMethod.GET)
    public void menuGrpList(ModelMap model) {

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.menuGrpList());
    }

    /**
     * 메뉴그룹정보 상세 조회
     * 
     * @RequestMapping(value="ND_menuGrpView.do", method=RequestMethod.GET)
     *                                            public ModelAndView
     *                                            menuGrpView(ModelAndView view,
     * @ModelAttribute MenuGrpVO vo) {
     *                 MenuGrpVO dataVo = service.menuGrpView(vo);
     *                 view.addObject(KEY_DATA_VO, dataVo);
     *                 return view;
     *                 }
     */

    /**
     * 메뉴그룹정보 등록 폼
     */
    @RequestMapping(value = "ND_menuGrpInsertForm.do", method = RequestMethod.GET)
    public void menuGrpInsertForm() {
    }

    /**
     * 메뉴그룹정보 등록 액션
     */
    @RequestMapping(value = "ND_menuGrpInsertAction.do", method = RequestMethod.POST)
    public String menuGrpInsertAction(MenuGrpVO vo, ModelMap model) {

        Object newSeq = service.menuGrpInsertAction(vo);

        String message;
        if(newSeq != null) {
            message = Messages.COMMON_INSERT_OK;
        } else {
            message = Messages.COMMON_PROCESS_FAIL;
        }

        JsonVO jsonVo = new JsonVO().setValue(newSeq.toString()).setMessage(message);

        return responseJson(model, jsonVo);
    }

    /**
     * 메뉴그룹정보 수정 폼
     */
    @RequestMapping(value = "ND_menuGrpUpdateForm.do", method = RequestMethod.POST)
    public void menuGrpUpdateForm(MenuGrpVO vo, ModelMap model) {

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.menuGrpView(vo));
    }

    /**
     * 메뉴그룹정보 수정 액션
     */
    @RequestMapping(value = "ND_menuGrpUpdateAction.do", method = RequestMethod.POST)
    public String menuGrpUpdateAction(MenuGrpVO vo, ModelMap model) {

        int affected = service.menuGrpUpdateAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.COMMON_UPDATE_OK);
        }
        return responseText(model, Messages.COMMON_PROCESS_FAIL);
    }

    /**
     * 메뉴그룹정보 삭제 액션
     */
    @RequestMapping(value = "ND_menuGrpDeleteAction.do", method = RequestMethod.POST)
    public String menuGrpDeleteAction(MenuGrpVO vo, ModelMap model) {

        int affected = service.menuGrpDeleteAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.COMMON_DELETE_OK);
        }
        return responseText(model, Messages.COMMON_PROCESS_FAIL);
    }

    /**
     * 메뉴그룹 아이템 목록 조회
     */
    @RequestMapping(value = "ND_menuItemList.do", method = RequestMethod.POST)
    public void menuItemList(MenuGrpVO vo, ModelMap model) {

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.menuItemList(vo));
    }

    /**
     * 선택 메뉴에 대한 메뉴그룹 아이템정보 목록 조회
     * 
     * @RequestMapping(value="menuItemListWithMenuCd", method=RequestMethod.GET)
     *                                                 public ModelAndView
     *                                                 menuItemListWithMenuCd
     *                                                 (ModelAndView view,
     *                                                 HttpServletRequest
     *                                                 request,
     * @ModelAttribute MenuItemVO menuItemVo) {
     *                 List<MenuItemVO> dataList =
     *                 service.menuItemListWithMenuCd(menuItemVo);
     *                 view.addObject(KEY_DATA_LIST, dataList);
     *                 return view;
     *                 }
     */

    /**
     * 메뉴그룹 아이템 수정 액션
     */
    @RequestMapping(value = "ND_menuItemUpdateAction.do", method = RequestMethod.POST)
    public String menuItemUpdateAction(MenuItemVO menuItemVo, ModelMap model) {

        return responseText(model, service.menuItemUpdateAction(menuItemVo));
    }

    /**
     * 메뉴그룹 아이템 조회
     */
    @RequestMapping(value = "PD_menuGrpView.do", method = RequestMethod.GET)
    public void menuGrpView(MenuGrpVO vo, ModelMap model) {

        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.menuGroupView(vo));
    }
}
