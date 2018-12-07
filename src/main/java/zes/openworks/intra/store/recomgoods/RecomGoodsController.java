package zes.openworks.intra.store.recomgoods;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.login.LoginVO;
import zes.openworks.intra.store.goods.GoodsManageVO;
import zes.openworks.web.pop.PopService;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *  서비스관리 > 서비스관리
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 10. 21.   김병욱     신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/intra/store/recomgoods")
public class RecomGoodsController extends IntraController  {


    @Autowired RecomGoodsService service;
    @Autowired PopService popService;

    /**
     * 전체서비스목록
     * GoodsList 설명
     *
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = {"BD_index.do", "BD_recomPremium.do", "BD_recomSolution.do", "BD_recomConsult.do"})
    public void recomGoodsList(HttpServletRequest request, ModelMap model, RecomGoodsVO vo) {
        String recomIndex = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(vo));
        OpHelper.bindSearchMap(vo, request);
        String langCode = (String) vo.getDataMap().get("q_langCodes");

        if(Validate.isEmpty(langCode))
        {
            vo.setLangCode("00");
        }
        else
        {
            vo.setLangCode(langCode);
        }

        vo.getDataMap().put("q_langCodes",vo.getLangCode());

        if (recomIndex.equals("BD_index.do")) {
                vo.setRecomendLcSeCd(1001);
                vo.setRecomendSeCd(1002);
                model.addAttribute("recomMainS", service.recomGoodsList2(vo));
                vo.setRecomendSeCd(1001);
                model.addAttribute("recomMainP", service.recomGoodsList(vo));
        } else if (recomIndex.equals("BD_recomPremium.do")) {
                vo.setRecomendLcSeCd(1002);
                vo.setRecomendSeCd(1001);
                vo.getDataMap().put("q_goodsTyCd", "1001");
                model.addAttribute("recomSubP", service.recomGoodsList(vo));
        } else if (recomIndex.equals("BD_recomSolution.do")) {
                vo.setRecomendLcSeCd(1002);
                vo.setRecomendSeCd(1002);
                vo.getDataMap().put("q_goodsTyCd", "1002");
                model.addAttribute("recomSubS", service.recomGoodsList(vo));
        } else if (recomIndex.equals("BD_recomConsult.do")) {
                vo.setRecomendLcSeCd(1002);
                vo.setRecomendSeCd(1003);
                vo.getDataMap().put("q_goodsTyCd", "1003");
                model.addAttribute("recomSubC", service.recomGoodsList(vo));
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsList(vo));

    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value ={"ND_recomInsertAction.do", "ND_recomInsertAction2.do","ND_recomInsertApply.do", "ND_recomInsertApply2.do"}, method = RequestMethod.POST)
    public String recomGoodsInsertAction(HttpServletRequest request, ModelMap model, RecomGoodsVO vo) {
        String recomIndex = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1);

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());
        int affected = 0;
        if (recomIndex.equals("ND_recomInsertAction.do")) {
            affected = service.recomGoodsInsert(vo, false);
        } else if (recomIndex.equals("ND_recomInsertAction2.do")) {
            affected = service.recomGoodsInsert2(vo, false);
        } else if (recomIndex.equals("ND_recomInsertApply.do")) {
            affected = service.recomGoodsInsert(vo, true);
        } else if (recomIndex.equals("ND_recomInsertApply2.do")) {
            affected = service.recomGoodsInsert2(vo, true);
        }
        if(affected == StringUtil.ZERO) {
            return responseJson(model, Boolean.FALSE, MessageHelper.getMsg(request, "processError"));
        } else if(affected == 999) {
            return responseJson(model, Boolean.FALSE, "지정된 갯수가 초과되었습니다.");
        } else if(affected == 998) {
            return responseJson(model, Boolean.FALSE, "선택된 서비스와 카테고리가 맞지않습니다.");
        }
        return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "processOk"));
    }

    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_recomDeleteAction.do", method = RequestMethod.POST)
    public String recomGoodsDeleteAction(HttpServletRequest request, ModelMap model, RecomGoodsVO vo) {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        vo.setUpdtId(loginVo.getMngrId());

        int affected = service.recomGoodsDelete(vo);
        if(affected == StringUtil.ZERO) {
            return responseText(model, Messages.FALSE);
        }
        return responseText(model, Messages.TRUE);
    }

    /**
     * ctgryList (카테고리 목록)
     * @param vo
     * @param model
     * @return
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "ND_ctgryList.do", method=RequestMethod.POST)
    public String ctgryList(GoodsManageVO vo, ModelMap model){

        return responseJson(model, service.ctgryList(vo));
    }
}