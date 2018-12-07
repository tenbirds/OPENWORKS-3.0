package zes.openworks.intra.store.category;

import java.util.List;
import java.util.Map;

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
import zes.openworks.intra.store.goods.GoodsManageService;
import zes.openworks.intra.store.goods.GoodsManageVO;

@Controller
@RequestMapping(value = "/intra/store/category")
public class CategoryController extends IntraController {

    @Autowired
    private CategoryService service;
    @Autowired
    private GoodsManageService gmservice;

    /**
     * 카테고리 관리 메인
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_index.do")
    public void index(CategoryVO vo, ModelMap model, HttpServletRequest request) {
        model.addAttribute(GlobalConfig.KEY_BASE_VO, service.index(vo));
        model.addAttribute("langVo", service.langList(vo) );
    }

    /**
     * 카테고리 관리 목록 for TreeList
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_categoryList.do")
    public String categoryList(CategoryVO vo, ModelMap model, HttpServletRequest request) {
        return responseJson(model, service.categoryList(vo));
    }

    /**
     * 카테고리 관리 상세
     */
    @RequestMapping(value = "INC_categoryView.do")
    public void categoryView(CategoryVO vo, ModelMap model, HttpServletRequest request) {
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo.getCtgryClCd());
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.categoryView(vo));
    }

    /**
     * 메뉴관리 목록 (전체 for MGR_ID)
     *//*
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "INC_myMenuListAll.do", method = RequestMethod.POST)
    public String myMenuListAll(CategoryVO vo, HttpServletRequest request, ModelMap model) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(loginVo != null) {
            vo.setMngrId(loginVo.getMngrId());
        }
        return responseJson(model, service.myMenuListAll(vo));
    }
    */
    /**
     * 카테고리 관리 등록 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_insertAction.do", method = RequestMethod.POST)
    public String insertAction(CategoryVO vo, ModelMap model, HttpServletRequest request) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(loginVo == null){
            responseJson(model, Messages.FALSE, Messages.LOGIN_NO_SESSION);
        }

        vo.setMngrId(loginVo.getMngrId());
        Object newSeq = service.insertAction(vo);

        if(newSeq != null) {
            return responseJson(model, Messages.TRUE, newSeq, Messages.COMMON_INSERT_OK);
        }

        return responseJson(model, Messages.FALSE, Messages.COMMON_PROCESS_FAIL);
    }

    /**
     * 카테고리 관리 수정 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_updateAction.do", method = RequestMethod.POST)
    public String updateAction(CategoryVO vo, ModelMap model, HttpServletRequest request) {
        LoginVO loginVo = OpHelper.getMgrSession(request);
        if(loginVo == null){
            responseJson(model, Messages.FALSE, Messages.LOGIN_NO_SESSION);
        }

        vo.setMngrId(loginVo.getMngrId());
        int affected = service.updateAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        } else if (affected == -1) {
            return responseText(model, "-1");
        } else if (affected > 1) {
            List<Map<String,String>> goodsChkList = service.goodsChk(vo);
            int maxGoods = goodsChkList.size();
            if (maxGoods > 5) {
                maxGoods = 5;
            }
            String goodsChk = "";
            for (int i=0 ;  i < maxGoods ; i++ ) {
                goodsChk += goodsChkList.get(i).get("GOODS_NM") + "(" + goodsChkList.get(i).get("GOODS_CODE") + ") ";
            }
            goodsChk += Integer.toString((affected - 1));
            return responseText(model, goodsChk);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * 메뉴관리 삭제 액션
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "ND_deleteAction.do", method = RequestMethod.POST)
    public String deleteAction(CategoryVO vo, ModelMap model) {
        int affected = service.deleteAction(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * ctgrySelect (카테고리 선택)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_ctgrySelect.do", method=RequestMethod.POST)
    public String ctgrySelect(GoodsManageVO vo, ModelMap model) {

        return responseJson(model, gmservice.ctgrySelect(vo));
    }
}
