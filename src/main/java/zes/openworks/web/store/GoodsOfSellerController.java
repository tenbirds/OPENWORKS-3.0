/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.store.premium.PremiumService;
import zes.openworks.web.store.premium.PremiumVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 11. 6.    이슬버미       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/store")
public class GoodsOfSellerController extends GeneralController {

    @Autowired
    PremiumService service;
    @Autowired
    StoreincService storeService;
    @Autowired
    private CommonDutyService codService;

    @RequestMapping(value = "/BD_goodsOfSeller.do")
    public void index(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

//        vo.setGoodsTyCd(1001);
//        if  (Validate.isEmpty(vo.getCtgryCode())) {
//            vo.setCtgryCode(service.ctgryNull(vo));
//        }
//        model.addAttribute("ctgry", service.ctgry(vo));
//
//        String ctgryInit = service.ctgryInit(vo);
//        vo.setCtgryCode(ctgryInit);
//        model.addAttribute("ctgryInit", ctgryInit);
//        model.addAttribute("ctgryPath", service.ctgryPath(vo).split(","));
//        model.addAttribute("ctgryList", service.ctgryList(vo));
//        model.addAttribute("bestList", service.bestList(vo));
//        model.addAttribute("rcmdList", service.rcmdList(vo));
//        model.addAttribute("bestSellerList", service.bestSellverList(vo));

        vo.getDataMap().put("langCode", vo.getLangCode());
        vo.getDataMap().put("userId", vo.getUserId());
//        vo.getDataMap().put("ctgryCode", vo.getCtgryCode());
//        vo.getDataMap().put("goodsTyCd", vo.getGoodsTyCd());

        model.addAttribute("store", service.goodsStore(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.goodsListOfSeller(vo));
        
        // 조회한 서비스별 카테고리 재조회[1개 서비스가 다수 카테고리를 가질수 있음.]
        String goodsCode = "";

        Pager<PremiumVO> goodsListVo = service.goodsListOfSeller(vo);
      /*  List<PremiumVO> goodsList = goodsListVo.getList();
        for(int i=0; i < goodsList.size(); i++){
            PremiumVO goodsVo = goodsList.get(i);
            goodsCode = goodsCode + "@" + goodsVo.getGoodsCode() + "@";
        }
        goodsCode = goodsCode.replaceAll("@@", "','");
        goodsCode = goodsCode.replaceAll("@", "'");

        if(goodsCode.length() != 0 ){
            PremiumVO searchVo = new PremiumVO();
            searchVo.setGoodsCode(goodsCode);
            // 서비스별 카테고리 정보 조회
            model.addAttribute("goodsCateList", service.goodsCateList(searchVo));
        }*/
    }

    @RequestMapping(value = "/BD_view.do")
    public ModelMap view(HttpServletRequest request, ModelMap model, PremiumVO vo, HttpServletResponse response) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);

        OpHelper.bindSearchMap(vo, request);

        // 조회수 증가를 위한 쿠키 체크
        // if(CookieUtil.isIncreateReadCnt(vo.getGoodsCode(), 2, request,
        // response)) {
        service.rdcntUpdate(vo);
        // }

        if(Validate.isNotEmpty(userLoginVo)) {
            vo.setLoginUserId(userLoginVo.getUserId());
            service.rcntUpdate(vo);
        }

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        vo.setGoodsTyCd(1001);
        vo.setBbsCd(1008); //사용스토리 게시판코드
        vo.setDomainCd(Integer.parseInt(domainCd));

        model.addAttribute("ctgryPath", service.ctgryPath(vo));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsView(vo));
        return model;
    }

    @RequestMapping(value = "/ND_purch.do", method = RequestMethod.POST)
    public String purchInsert(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        vo.setLoginUserId(userLoginVo.getUserId());
        if(service.purchInsert(vo) == StringUtil.ONE) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "orderhOk"));
        }
        return responseText(model, Messages.FALSE);
    }

    @RequestMapping(value = "/ND_itst.do", method = RequestMethod.POST)
    public String itstUpdate(HttpServletRequest request, ModelMap model, PremiumVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVo)) {
            return responseJson(model, Boolean.FALSE, "requiredLogin");
        }
        vo.setLoginUserId(userLoginVo.getUserId());
        if(service.itstUpdate(vo) == StringUtil.ONE) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "watchOk"));
        }
        return responseJson(model, Messages.FALSE, "watchFail");
    }
}
