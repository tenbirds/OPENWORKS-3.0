/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.Converter;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.store.premium.PremiumService;
import zes.openworks.web.store.premium.PremiumVO;


/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 7.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/store/inc")
public class StoreincController extends WebController{

    @Autowired StoreincService service;
    @Autowired PremiumService  premiumService;
    @Autowired CodeService     codeService;
    @Autowired AutoMailService amservice;

    /**
     * dstbStoreView (상세 화면 분배)
     *
     * goodsCode (필수)
     * pageUrlNm (선택 = C : 서비스평, I : 문의하기, RE : 리뷰, RT : 연관 ) 지정 이동
     * => SKYOU 2015.12.16 디자인 변경됨 : tab (inquiry :Q&A, review:리뷰 , :사용화면, cntrct:납품실적, vodplay:소개영상, relation:연관서비스)
     * @param request
     * @param model
     * @param vo
     * @param boardVO
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "/BD_storeView.do" , method = {RequestMethod.GET, RequestMethod.POST})
    public String dstbStoreView (HttpServletRequest request, ModelMap model, StoreincVO vo ,@PathVariable String pathLang) {

        getBaseUrl(model,pathLang) ;

        StringBuffer returnUrl = new StringBuffer();
        String domainNm = service.dstbStoreView(vo);
        if(Validate.isEmpty(domainNm)){
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsHidden"));
        }

        if(service.dstbStoreStatus(vo) == StringUtil.ZERO){
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsHidden"));
        }

        //null로 인한 서비스 분류 안나오는것 처리
        String goodsCode = vo.getGoodsCode() != null ? vo.getGoodsCode(): "";
        String pageUrlNm = vo.getPageUrlNm() != null ? vo.getPageUrlNm(): "";
        String ctgryPath = vo.getCtgryPath() != null ? vo.getCtgryPath(): "";
        String ctgryCode = vo.getCtgryCode() != null ? vo.getCtgryCode(): "";
        
        returnUrl.append("redirect:/");
        returnUrl.append(pathLang);
        returnUrl.append("/pt/store/software");
       // returnUrl.append( domainNm);
        returnUrl.append("/BD_view.do");
        returnUrl.append("?goodsCode=" + goodsCode);
        returnUrl.append("&pageUrlNm=" + pageUrlNm);//vo.getPageUrlNm());
        returnUrl.append("&goodsTyCd=" + domainNm);
        returnUrl.append("&ctgryPath=" + ctgryPath);
        returnUrl.append("&ctgryCode=" + ctgryCode);

        return returnUrl.toString();
    }

    /**
     * dstbStoreView (상세 화면 분배)
     *
     * goodsCode (필수)
     * pageUrlNm (선택 = C : 서비스평, I : 문의하기, RE : 리뷰, RT : 연관 ) 지정 이동
     * => SKYOU 2015.12.16 디자인 변경됨 : tab (inquiry :Q&A, review:리뷰 , :사용화면, cntrct:납품실적, vodplay:소개영상, relation:연관서비스)
     * @param request
     * @param model
     * @param vo
     * @param boardVO
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "/BD_storeView_v2.do" , method = {RequestMethod.GET, RequestMethod.POST})
    public String dstbStoreView_v2 (HttpServletRequest request, ModelMap model, StoreincVO vo ,@PathVariable String pathLang) {

        getBaseUrl(model,pathLang) ;

        StringBuffer returnUrl = new StringBuffer();
        String domainNm = service.dstbStoreView(vo);
        if(Validate.isEmpty(domainNm)){
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsHidden"));
        }

        if(service.dstbStoreStatus(vo) == StringUtil.ZERO){
            return alertAndBack(model,MessageHelper.getMsg(request, "goodsHidden"));
        }

        //null로 인한 서비스 분류 안나오는것 처리
        String goodsCode = vo.getGoodsCode() != null ? vo.getGoodsCode(): "";
        String pageUrlNm = vo.getPageUrlNm() != null ? vo.getPageUrlNm(): "";
        String ctgryPath = vo.getCtgryPath() != null ? vo.getCtgryPath(): "";
        String ctgryCode = vo.getCtgryCode() != null ? vo.getCtgryCode(): "";
        
        returnUrl.append("redirect:/");
        returnUrl.append(pathLang);
        returnUrl.append("/pt/store/software");
       // returnUrl.append( domainNm);
        returnUrl.append("/BD_view_v2.do");
        returnUrl.append("?goodsCode=" + goodsCode);
        returnUrl.append("&pageUrlNm=" + pageUrlNm);//vo.getPageUrlNm());
        returnUrl.append("&goodsTyCd=" + domainNm);
        returnUrl.append("&ctgryPath=" + ctgryPath);
        returnUrl.append("&ctgryCode=" + ctgryCode);

        return returnUrl.toString();
    }

    /**
     * review (리뷰)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/INC_review.do" , method = RequestMethod.GET)
    public String review(HttpServletRequest request, ModelMap model,StoreincVO vo, BoardVO boardVO ,@PathVariable String pathLang) {

       //언어 적용 Url
        getBaseUrl(model,pathLang) ;

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        boardVO.setBbsCd(1008); //사용스토리 게시판코드
        boardVO.setDomainCd(Integer.parseInt(domainCd));
        boardVO.setGoodsCode(request.getParameter("goodsCode"));

        List<BoardVO> dataList = service.incReview(boardVO);

        model.addAttribute("boardBaseVo", boardVO);
        model.addAttribute("reviewList", dataList);

        return "/" + pathLang + "/pt/store/INC_review";
    }


    /**
     * inquiry (문의하기 목록)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/INC_inquiry.do")
    public String inquiry(HttpServletRequest request, ModelMap model, PremiumVO vo ,@PathVariable String pathLang) {
        //언어 적용 Url
        getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request); 
        model.addAttribute(GlobalConfig.KEY_PAGER, service.incLnquiry(vo));
        if(Converter.XSS(vo.getPageUrlNm()) !=null && !Converter.XSS(vo.getPageUrlNm()).equals(""))
            model.addAttribute(GlobalConfig.KEY_PAGER+"_sn", Converter.XSS(vo.getPageUrlNm()).substring(2));
        return "/" + pathLang + "/pt/store/INC_inquiry";
    }

    /**
     * relation (연관)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @Autowired
    private CommonDutyService codService;
    @RequestMapping(value = "/INC_relation.do" , method = RequestMethod.GET)
    public String relation(HttpServletRequest request, ModelMap model, PremiumVO vo ,@PathVariable String pathLang) {

        //언어 적용 Url
        getBaseUrl(model,pathLang) ;

        OpHelper.bindSearchMap(vo, request);

        // 접속 사용자 도메인 값 불러와서 가져오기
        String hostNm = CmsUtil.getHostName(request.getServerName());
        String domainCd = new CommonDutyConstant().getDomainCode(hostNm);
        String langCd = codService.getLangCd(Integer.parseInt(domainCd));
        vo.setLangCode(langCd);

        model.addAttribute(GlobalConfig.KEY_PAGER, service.incRelation(vo));


        // 조회한 서비스별 카테고리 재조회[1개 서비스가 다수 카테고리를 가질수 있음.]
        String goodsCode = "";

        Pager<StoreincVO> goodsListVo = service.incRelation(vo);
     /*   List<StoreincVO> goodsList = goodsListVo.getList();
        for(int i=0; i < goodsList.size(); i++){
            StoreincVO goodsVo = goodsList.get(i);
            goodsCode = goodsCode + "@" + goodsVo.getGoodsCode() + "@";
        }
        goodsCode = goodsCode.replaceAll("@@", "','");
        goodsCode = goodsCode.replaceAll("@", "'");

        if(goodsCode.length() != 0 ){
            PremiumVO searchVo = new PremiumVO();
            searchVo.setGoodsCode(goodsCode);
            // 서비스별 카테고리 정보 조회
            model.addAttribute("goodsCateList", premiumService.goodsCateList(searchVo));
        }*/

        return "/" + pathLang + "/pt/store/INC_relation";
    }

    /**
     * incCommentUpdateAction (서비스평 수정)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_incCommentUpdateAction.do" , method = RequestMethod.POST)
    public String incCommentUpdateAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang) {

        //로그인 사용자 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){
          return  responseText(model, StoreincVO.MSG.LOGIN_FAIL);
        }else{
            vo.setRegistId(userLoginVO.getUserId());
        }

        //IP 체크
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null){
            ip = request.getRemoteAddr();
        }
        vo.setRegistIp(ip);


        int affected = service.incCommentUpdateAction(vo);
        if(affected == StringUtil.ONE) {
            return  responseText(model,  StoreincVO.MSG.UPDATE_OK);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * inquiryInsertForm (문의하기 등록 폼)
     * @param model
     * @param request
     * @param vo
     */
    @RequestMapping(value = "PD_inquiryInsertForm.do" , method = RequestMethod.GET)
    public String inquiryInsertForm(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        //언어 적용 Url
        //String domainNm = service.dstbStoreView(vo);
        getBaseUrl(model,pathLang) ;

        //로그인 사용자 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){

            String returnUrl = "?returnUrl=/" +pathLang + "/pt/store/software/BD_view.do";
            String returnParam = "&returnParam=goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I&goodsTyCd="+vo.getGoodsTyCd() ;
            String returnMethod = "&returnMethod=post";

            return confirmAndRedirectPopup(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + pathLang + "/pt/login/user/BD_index.do" + returnUrl + returnParam + returnMethod);
        }
        return "/" +pathLang + "/pt/store/PD_inquiryInsertForm";
    }

    /**
     * inquiryInsertAction (문의하기 등록)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_inquiryInsertAction.do" , method = RequestMethod.POST)
    public String inquiryInsertAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        int affected = service.inquiryInsertAction(vo);
        if(affected >= StringUtil.ONE) {
            //이메인 연동 부분
            vo.setGoodsInqryNo(affected);
            commentMailSend(vo,1001,pathLang,request);
            return  responseText(model,  StoreincVO.MSG.INSERT_OK);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * inquiryUpdateAction (문의하기 수정)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_inquiryUpdateAction.do" , method = RequestMethod.POST)
    public String inquiryUpdateAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        int affected = service.inquiryUpdateAction(vo);
        if(affected == StringUtil.ONE) {
            return  responseText(model,  StoreincVO.MSG.UPDATE_OK);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * inquiryDeleteAction (문의하기 삭제)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_inquiryDeleteAction.do" , method = RequestMethod.POST)
    public String inquiryDeleteAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        int affected = service.inquiryDeleteAction(vo);
        if(affected == StringUtil.ONE) {
            return  responseText(model,  StoreincVO.MSG.DELETE_OK);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * accuseInsertForm (신고하기 화면)
     * @param model
     * @param request
     * @param vo
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "PD_accuseInsertForm.do" , method = RequestMethod.GET)
    public String accuseInsertForm(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        String domainNm = service.dstbStoreView(vo);
        //언어 적용 Url
        getBaseUrl(model,pathLang) ;

      //로그인 사용자 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){

            String returnUrl = "?returnUrl=/" +pathLang + "/pt/store/" + domainNm + "/BD_view.do";
            String returnParam = "&returnParam=goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I" ;
            String returnMethod = "&returnMethod=post";

            return confirmAndRedirectPopup(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + pathLang + "/pt/login/user/BD_index.do" + returnUrl + returnParam + returnMethod);
        }

        //신고하기 체크
        StoreincVO inquriyVO = service.inquiryCheck(vo);
        if(Validate.isNotEmpty(inquriyVO)){
            int accuseCnt = 0;
            if(vo.getAccuseAtCd().toString().equals(StoreincVO.ACCUSE_INQRY)){

                if(Validate.isNotEmpty(inquriyVO.getInqryAccuseEtcCn())){
                    accuseCnt = accuseCnt + 1;
                }
                if(Validate.isNotEmpty(inquriyVO.getInqryAccuseResnCd())){
                    accuseCnt = accuseCnt + 1;
                }
            }else if(vo.getAccuseAtCd().toString().equals(StoreincVO.ACCUSE_ANSWER)){

                if(Validate.isNotEmpty(inquriyVO.getAnswerAccuseEtcCn())){
                    accuseCnt = accuseCnt + 1;
                }
                if(Validate.isNotEmpty(inquriyVO.getAnswerAccuseResnCd())){
                    accuseCnt = accuseCnt + 1;
                }
            }

            if(accuseCnt > 0){
                return alertAndClose(model,MessageHelper.getMsg(request, "incInquiryCheck"));
            }
        }


        //코드
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1014);
        List<CodeVO> codeList = new ArrayList<CodeVO>();

        //구매,판매 구분
        for(CodeVO list : codeService.codeList(codeVO)) {
            if(vo.getAccuseAtCd().equals(StoreincVO.ACCUSE_INQRY) && list.getPrvCd().toString().startsWith("1")){
               codeList.add(list);
            }else if(vo.getAccuseAtCd().equals(StoreincVO.ACCUSE_ANSWER) && list.getPrvCd().toString().startsWith("2")){
               codeList.add(list);
            }
        }
        model.addAttribute(GlobalConfig.KEY_BASE_VO,vo);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST ,codeList);
        return "/" +pathLang + "/pt/store/PD_accuseInsertForm";
    }

    /**
     * accuseView (신고하기 상세)
     * @param model
     * @param request
     * @param vo
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "PD_accuseView.do" , method = RequestMethod.GET)
    public String accuseView(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        StoreincVO inquriyVO = service.inquiryCheck(vo);

        //코드
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(1014);
        List<CodeVO> codeList = new ArrayList<CodeVO>();

        //구매,판매 구분
        for(CodeVO list : codeService.codeList(codeVO)) {
            if(vo.getAccuseAtCd().equals(StoreincVO.ACCUSE_INQRY) && list.getPrvCd().toString().startsWith("1")){
               codeList.add(list);
            }else if(vo.getAccuseAtCd().equals(StoreincVO.ACCUSE_ANSWER) && list.getPrvCd().toString().startsWith("2")){
               codeList.add(list);
            }
        }

        model.addAttribute(GlobalConfig.KEY_VALIDATE_RESULT_KEY, Messages.TRUE);
        model.addAttribute(GlobalConfig.KEY_BASE_VO,inquriyVO);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST ,codeList);
        return "/" +pathLang + "/pt/store/PD_accuseInsertForm";
    }

    /**
     * accuseInsertAction (신고하기 등록)
     * @param model
     * @param request
     * @param vo
     * @param pathLang
     * @return
     */
    @RequestMapping(value = "ND_accuseInsertAction.do" , method = RequestMethod.POST)
    public String accuseInsertAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang){

        int affected = service.accuseInsertAction(vo);
        if(affected == StringUtil.ONE) {

            //이메인 연동 부분
            if(vo.getAccuseAtCd().equals(StoreincVO.ACCUSE_INQRY)){
                commentMailSend(vo,1003,pathLang,request);
             }else if(vo.getAccuseAtCd().equals(StoreincVO.ACCUSE_ANSWER)){
                commentMailSend(vo,1004,pathLang,request);
             }

            return  responseText(model,  Messages.TRUE);
        }

        return responseText(model, Messages.FALSE);
    }


    private boolean commentMailSend(StoreincVO vo,int type,String pathLang, HttpServletRequest request){
        try {
            StoreincVO viewVO = service.incLnquiryView(vo);


            if(Validate.isEmpty(viewVO)){
                return false;
            }

            //관리자 이메일 항목
            List<StoreincVO> adminEmailList = null;


            // 이메일 템플릿 번호
            AutoMailTemplate tempNum = null;
            Map<String, Object> emailMap = new HashMap<String, Object>();
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();



            switch(type) {
                case 1001: //서비스 문의

                    if(pathLang.equals(GlobalConfig.LANG_KOREAN)){
                        tempNum = AutoMailTemplate.KOR_GOOD_IQRY;
                    }

                    // 수신자 이름
                    emailMap.put("receiverName", viewVO.getGoodsChargerNm());

                    // 수신자 이메일
                    emailMap.put("email", viewVO.getGoodsChargerEmail());

                    // 발송자 이름
                    emailMap.put("senderName", viewVO.getInqrNm());

                    // 발송자 이메일
                    emailMap.put("senderEmail", viewVO.getAnswerRecptnEmail());

                    // 이메일 제목
                    emailMap.put("mailTitle", viewVO.getInqrySj());
                    
                    oneToOneInfoMap.put("rtnurl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/sale/support/qna/BD_index.do");
                    oneToOneInfoMap.put("productImg", "http://"+GlobalConfig.DOMAIN_SUBNM+viewVO.getFileUrl());
                    oneToOneInfoMap.put("productUrl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/store/inc/BD_storeView.do?goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I");
                    
                    oneToOneInfoMap.put("productTitle", viewVO.getGoodsNm());
                    oneToOneInfoMap.put("productContents", viewVO.getGoodsSumry());
                    oneToOneInfoMap.put("questionTitle", viewVO.getInqrySj());
                    oneToOneInfoMap.put("othbcAt", viewVO.getOthbcAt());
                    oneToOneInfoMap.put("questionContents", viewVO.getInqryCn());
                    oneToOneInfoMap.put("email", viewVO.getAnswerRecptnEmail());

                    break;
                case 1002: //서비스 답변
                    /* 2016.07.22 확인결과 답변은 ND_commentUpdateAction.do에서 수행 */
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
                    oneToOneInfoMap.put("rtnurl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/sale/support/qna/BD_index.do");
                    oneToOneInfoMap.put("productImg", "http://"+GlobalConfig.DOMAIN_SUBNM+viewVO.getFileUrl());
                    oneToOneInfoMap.put("productUrl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/store/inc/BD_storeView.do?goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I");
                 
                    oneToOneInfoMap.put("productTitle", viewVO.getGoodsNm());
                    oneToOneInfoMap.put("productContents", viewVO.getGoodsSumry());
                    oneToOneInfoMap.put("questionTitle", viewVO.getInqrySj());
                    oneToOneInfoMap.put("othbcAt", viewVO.getOthbcAt());
                    oneToOneInfoMap.put("questionContents", viewVO.getInqryCn());
                    oneToOneInfoMap.put("replyContents", viewVO.getInqryAnswerCn());

                    break;
                case 1003: //서비스 문의 신고

                    if(pathLang.equals(GlobalConfig.LANG_KOREAN)){
                        tempNum = AutoMailTemplate.KOR_GOOD_ACUS;
                    }

                    adminEmailList = service.adminEmailList();

                    // 발신자 이름
                    emailMap.put("senderName", viewVO.getInqryAplcntNm());

                    // 발신자 이메일
                    emailMap.put("senderEmail", viewVO.getInqryAplcntEmail());

                    // 이메일 제목
                    emailMap.put("mailTitle", viewVO.getInqrySj());

                    // 이전소스
                    oneToOneInfoMap.put("rtnurl", "http://"+GlobalConfig.DOMAIN_ADMNM+"/login/mgr/ND_index.do");
                    oneToOneInfoMap.put("productImg", "http://"+GlobalConfig.DOMAIN_SUBNM+viewVO.getFileUrl());
                    oneToOneInfoMap.put("productUrl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/store/inc/BD_storeView.do?goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I");
                  
                    oneToOneInfoMap.put("productTitle", viewVO.getGoodsNm());
                    oneToOneInfoMap.put("productContents", viewVO.getGoodsSumry());
                    oneToOneInfoMap.put("name", viewVO.getInqryAplcntNm());
                    oneToOneInfoMap.put("phone", viewVO.getInqryAplcntPhoen());
                    oneToOneInfoMap.put("email", viewVO.getInqryAplcntEmail());
                    oneToOneInfoMap.put("accuseContents", viewVO.getAnswerAccuseEtcCn());
                    oneToOneInfoMap.put("questionTitle", viewVO.getInqrySj());
                    oneToOneInfoMap.put("othbcAt", viewVO.getOthbcAt());
                    oneToOneInfoMap.put("questionContents", viewVO.getInqryCn());
                    oneToOneInfoMap.put("replyContents", viewVO.getInqryAnswerCn());

                    break;
                case 1004: //서비스 답변 신고

                    if(pathLang.equals(GlobalConfig.LANG_KOREAN)){
                        tempNum = AutoMailTemplate.KOR_GOOD_ACUS;
                    }

                    adminEmailList = service.adminEmailList();

                    // 발신자 이름
                    emailMap.put("senderName", viewVO.getAnswerAplcntNm());

                    // 발신자 이메일
                    emailMap.put("senderEmail", viewVO.getAnswerAplcntEmail());

                    // 이메일 제목
                    emailMap.put("mailTitle", viewVO.getInqrySj());

                    oneToOneInfoMap.put("rtnurl", "http://"+GlobalConfig.DOMAIN_ADMNM+"/login/mgr/ND_index.do");
                    oneToOneInfoMap.put("productImg", "http://"+GlobalConfig.DOMAIN_SUBNM+ viewVO.getFileUrl());
                    oneToOneInfoMap.put("productUrl", "http://"+GlobalConfig.DOMAIN_SUBNM+"/korean/pt/store/inc/BD_storeView.do?goodsCode=" + vo.getGoodsCode() + "&pageUrlNm=I");
                  
                    oneToOneInfoMap.put("productTitle", viewVO.getGoodsNm());
                    oneToOneInfoMap.put("productContents", viewVO.getGoodsSumry());
                    oneToOneInfoMap.put("name", viewVO.getAnswerAplcntNm());
                    oneToOneInfoMap.put("phone", viewVO.getAnswerAplcntPhoen());
                    oneToOneInfoMap.put("email", viewVO.getAnswerAplcntEmail());
                    oneToOneInfoMap.put("accuseContents", viewVO.getAnswerAccuseEtcCn());
                    oneToOneInfoMap.put("questionTitle", viewVO.getInqrySj());
                    oneToOneInfoMap.put("othbcAt", viewVO.getOthbcAt());
                    oneToOneInfoMap.put("questionContents", viewVO.getInqryCn());
                    oneToOneInfoMap.put("replyContents", viewVO.getInqryAnswerCn());

                    break;
                default:
                    break;
            }

            //메일템플릿 번호명
            emailMap.put("automailId", tempNum);
            //치환정보 맵 입력
            emailMap.put("oneToOneInfo", oneToOneInfoMap);


            if(Validate.isEmpty(adminEmailList)){

                amservice.sendAutoMail(emailMap);
            }else{
                for(StoreincVO emailVO : adminEmailList) {
                    emailMap.put("receiverName", emailVO.getMngrNm());
                    emailMap.put("email", emailVO.getMngrEmail());
                    amservice.sendAutoMail(emailMap);
                }

            }

            return true;

        } catch (Exception e) {
            e.getStackTrace();
            return false;
        }
    }



    /**
     * inquiry (사용화면)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/INC_screen.do" , method = RequestMethod.GET)
    public String screen(HttpServletRequest request, ModelMap model, PremiumVO vo ,@PathVariable String pathLang) {

        //언어 적용 Url
        getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, service.goodUserImgList(vo));

        return "/korean/pt/store/INC_screen";
    }

    /**
     * inquiry (동영상재생)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/INC_vodplay.do" , method = RequestMethod.GET)
    public String vodplay(HttpServletRequest request, ModelMap model, PremiumVO vo ,@PathVariable String pathLang) {

        //언어 적용 Url
        getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);

       // model.addAttribute(GlobalConfig.KEY_PAGER, service.incLnquiry(vo));

        return "/korean/pt/store/INC_vodplay";
    }



    /**
     * incCommentInsertAction (서비스평 등록)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_incCommentInsertAction.do" , method = RequestMethod.POST)
    public String incCommentInsertAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang) {

        //로그인 사용자 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){


//            String returnUrl = "?returnUrl="+requestUrl(request)+"/BD_index.do";
//            return alertAndRedirect(model,MessageHelper.getMsg(request, "userLoginCheck"), serverNm(request) + "/pt/login/user/BD_index.do" + returnUrl);

          return  responseText(model, StoreincVO.MSG.LOGIN_FAIL);
        }else{
            vo.setRegistId(userLoginVO.getUserId());
        }

        //IP 체크
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null){
            ip = request.getRemoteAddr();
        }
        vo.setRegistIp(ip);

        //중복 댓글 체크
        if(StringUtil.ZERO < service.incCommentCheck(vo)){
            return  responseText(model,  StoreincVO.MSG.INSERT_CHK);
        }

        int affected = service.incCommentInsertAction(vo);

        if(affected == StringUtil.ONE) {
            return  responseText(model,  StoreincVO.MSG.INSERT_OK);
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * incCommentDeleteAction (서비스평 삭제)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_incCommentDeleteAction.do" , method = RequestMethod.POST)
    public String incCommentDeleteAction(ModelMap model, HttpServletRequest request, StoreincVO vo ,@PathVariable String pathLang) {

        int affected = service.incCommentDeleteAction(vo);
        if(affected == StringUtil.ONE) {
            return  responseText(model,  StoreincVO.MSG.DELETE_OK);
        }

        return responseText(model, Messages.FALSE);
    }

    /**
     * comment (서비스평 목록)
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/INC_comment.do" , method = RequestMethod.GET)
    public String comment(HttpServletRequest request, ModelMap model, PremiumVO vo ,@PathVariable String pathLang) {

        //언어 적용 Url
        getBaseUrl(model,pathLang) ;

        OpHelper.bindSearchMap(vo, request);

        //서비스평 점수
        model.addAttribute("incCommentAvg", service.incCommentAvg(vo));

        //서비스평 목록
        model.addAttribute(GlobalConfig.KEY_PAGER, service.incCommentList(vo));


        return "/" + pathLang + "/pt/store/INC_comment";
    }
}
