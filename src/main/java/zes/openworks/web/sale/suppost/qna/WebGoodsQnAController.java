/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.suppost.qna;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.store.StoreincService;
import zes.openworks.web.store.StoreincVO;

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
 *  2014. 11. 14.    이슬버미       신규
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/sale/support/qna")
public class WebGoodsQnAController extends WebController {

    @Autowired StoreincService storeincService;
    @Autowired WebGoodsQnAService service;

    @Autowired
    AutoMailService amservice;


    /**
     * index (문의 목록)
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public String index(HttpServletRequest request, ModelMap model, WebGoodsQnAVO vo,@PathVariable String pathLang) {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_index.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + pathLang +  "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            vo.setUserId(userLoginVO.getUserId());
        }

        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );
            //return confirmAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth"),"/korean/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=410");
        }

        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        //언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())){
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }


        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_lang", service.langList());
        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_goodsTy", service.goodsTyList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.qnaList(vo));

        return baseURL + "/BD_index";

    }

    /**
     * commentForm (문의 내역)
     *
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "PD_insertForm.do", method = RequestMethod.GET)
    public void insertForm(HttpServletRequest request, ModelMap model, WebGoodsQnAVO vo,@PathVariable String pathLang) {

        //언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())){
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }

        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.commentView(vo));
    }

    /**
     * commentUpdateAction (문의 내역 수정)
     *
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_commentUpdateAction.do", method = RequestMethod.POST)
    public String commentUpdateAction(HttpServletRequest request, ModelMap model, WebGoodsQnAVO vo,@PathVariable String pathLang) {

        int affected = service.commentUpdateAction(vo);
        if(affected == StringUtil.ONE) {

            WebGoodsQnAVO  qnaVO = service.commentView(vo);

            //이메인 연동 부분
            if(Validate.isNotEmpty(qnaVO.getAnswerRecptnEmail())){
                commentMailSend(qnaVO,pathLang);
            }

            return responseText(model, Messages.TRUE);
            //return responseText(model, result);
        }
        return responseText(model, Messages.FALSE);

    }


    /**
     * myQnaList (서비스문의 내역)
     * @param request
     * @param model
     * @param vo
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "BD_myQnaList.do", method = RequestMethod.GET)
    public String myQnaList(HttpServletRequest request, ModelMap model, WebGoodsQnAVO vo,@PathVariable String pathLang) {

        //언어 적용 Url
        String baseURL = getBaseUrl(model,pathLang) ;

        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {

            String returnUrl = "?returnUrl=" + baseURL + "/BD_myQnaList.do";
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"), "/" + pathLang +  "/pt/login/user/BD_index.do" + returnUrl);

        } else {
            vo.setRegistId(userLoginVO.getUserId());
        }

        OpHelper.bindSearchMap(vo, request);

        //언어 추가
        vo.setLangCd(getLangCode(pathLang));
        if(Validate.isNotEmpty(vo.getDataMap())){
            vo.getDataMap().put("q_langCd", vo.getLangCd());
        }

        model.addAttribute(GlobalConfig.KEY_CODE_LIST + "_goodsTy", service.goodsTyList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.qnaList(vo));

        return baseURL + "/BD_myQnaList";

    }


    private boolean commentMailSend(WebGoodsQnAVO vo,String pathLang){



        try {
            StoreincVO storeincVO = new StoreincVO();
            storeincVO.setGoodsInqryNo(vo.getGoodsInqryNo());
            StoreincVO viewVO = storeincService.incLnquiryView(storeincVO);

            Map<String, Object> emailMap = new HashMap<String, Object>();
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();

            // 이메일 템플릿 번호
            AutoMailTemplate tempNum = null;
            if(pathLang.equals(GlobalConfig.LANG_KOREAN)){
                tempNum = AutoMailTemplate.KOR_GOOD_ANSR;
            }

            // 수신자 이름
            emailMap.put("receiverName", viewVO.getInqrNm());

            // 수신자 이메일
            emailMap.put("email", viewVO.getAnswerRecptnEmail());


            // 이메일 제목
            emailMap.put("mailTitle", viewVO.getInqrySj());

            // 치환내용 입력
            /* 2016.07.22 서비스Q&A 답변 URL 확인필요 */
            oneToOneInfoMap.put("rtnurl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/sale/support/qna/BD_myQnaList.do");
//            oneToOneInfoMap.put("rtnurl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/sale/support/qna/BD_index.do");
            oneToOneInfoMap.put("productImg", "http://"+GlobalConfig.DOMAIN_SUBNM + viewVO.getFileUrl());
            oneToOneInfoMap.put("productUrl", "http://"+GlobalConfig.DOMAIN_SUBNM +"/korean/pt/store/inc/BD_storeView.do?goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I");
            //}}
            oneToOneInfoMap.put("productTitle", viewVO.getGoodsNm());
            oneToOneInfoMap.put("productContents", viewVO.getGoodsSumry());
            oneToOneInfoMap.put("questionTitle", viewVO.getInqrySj());
            oneToOneInfoMap.put("othbcAt", viewVO.getOthbcAt());
            oneToOneInfoMap.put("questionContents", viewVO.getInqryCn());
            oneToOneInfoMap.put("replyContents", viewVO.getInqryAnswerCn());

            //메일템플릿 번호명
            emailMap.put("automailId", tempNum);
            //치환정보 맵 입력
            emailMap.put("oneToOneInfo", oneToOneInfoMap);


            return amservice.sendAutoMail(emailMap);

        } catch (Exception e) {
            e.getStackTrace();
            return false;
        }


    }

}
