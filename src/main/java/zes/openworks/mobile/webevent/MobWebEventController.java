/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.mobile.webevent;

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
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.webevent.WebEventMessages;
import zes.openworks.web.webevent.WebEventService;
import zes.openworks.web.webevent.WebEventVO;


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
 * 2014. 10. 27.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/m/webevent")
public class MobWebEventController extends WebController{

    @Autowired WebEventService service;


    /**
     * index (이벤트 목록)
     * @param request
     * @param model
     */
    @RequestMapping(value = "/BD_index.do" , method = RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model, WebEventVO vo,@PathVariable String pathLang) {

        getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request, 20);

        if(pathLang.equals("korean")){
            vo.getDataMap().put("q_domainCd", 2);
        }else if(pathLang.equals("english")){
            vo.getDataMap().put("q_domainCd", 3);
        }else if(pathLang.equals("spanish")){
            vo.getDataMap().put("q_domainCd", 4);
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, service.webEventList(vo));

    }

    /**
     * index (이벤트 응모 목록)
     * @param request
     * @param model
     */
    @RequestMapping(value = "/BD_eventList.do" , method = RequestMethod.GET)
    public String eventEntryList(HttpServletRequest request, ModelMap model, WebEventVO vo,@PathVariable String pathLang) {
        getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){
            return responseJson(model, new WebEventMessages(WebEventMessages.ST_LOGIN_CK,MessageHelper.getMsg(request, "userLoginCheck")));
        }else{
          vo.setWrterId(userLoginVO.getUserId());
        }
        model.addAttribute(GlobalConfig.KEY_PAGER, service.eventEntryList(vo));
        return requestUrl(request) + "/BD_eventList";
    }

    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    /**
     * RdcntUpdateAction (조회수 누적)
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "ND_rcntUpdateAction.do", method = RequestMethod.POST)
    public String RdcntUpdateAction(HttpServletRequest request, ModelMap model,WebEventVO vo,@PathVariable String pathLang){

        //이벤트 조회수 누적
        int affected = service.eventRdcntUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Messages.FALSE);

    }


    /**
     * progressEvent (상세)
     * @param request
     * @param model
     */
    @RequestMapping(value = "/BD_eventView.do", method = {RequestMethod.POST,RequestMethod.GET})
    public void view(HttpServletRequest request, ModelMap model,WebEventVO vo,@PathVariable String pathLang){

    	//언어 적용 Url
        String hostNm = CmsUtil.getHostName(request.getServerName());
        getBaseUrl(model,pathLang) ;

        OpHelper.bindSearchMap(vo, request);

        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        vo.setDomainCd(Integer.parseInt(domainCode));

        //이벤트 상세 화면
        model.addAttribute(GlobalConfig.KEY_DATA_VO,service.eventView(vo));

        //이벤트 댓글 목록
        model.addAttribute(GlobalConfig.KEY_PAGER,service.eventAnswerList(vo));

    }

    /**
     * answerInsertAction (댓글 등록)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_answerInsertAction.do" , method = RequestMethod.POST)
    public String answerInsertAction(ModelMap model, HttpServletRequest request, WebEventVO vo,@PathVariable String pathLang) {

        //로그인 사용자 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){
            if(vo.getEventTyCd() == 1002){
                return  responseJson(model, new WebEventMessages(WebEventMessages.ST_LOGIN_CK,MessageHelper.getMsg(request, "userLoginCheck")));
            }else{
                vo.setWrterId("guest");
            }
        }else{
            vo.setWrterId(userLoginVO.getUserId());
        }

        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null){
            ip = request.getRemoteAddr();
        }
        vo.setWrterIp(ip);

        //중복 댓글 체크
        if(Validate.isNotEmpty(userLoginVO) && StringUtil.ZERO < service.answerCheck(vo)){
            logger.info("중복 댓글 체크");
            return  responseJson(model, new WebEventMessages(WebEventMessages.ST_ANSWER_CK,MessageHelper.getMsg(request, "chkEventAnswer")));
        }

        int affected = service.answerInsertAction(vo);

        if(affected == StringUtil.ONE) {
            return  responseJson(model, new WebEventMessages(WebEventMessages.SUCCESS,MessageHelper.getMsg(request, "eventApplcn")));
        }
        return responseText(model, Messages.FALSE);
    }

    /**
     * answerUpdateAction (댓글 수정)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_answerUpdateAction.do" , method = RequestMethod.POST)
    public String answerUpdateAction(ModelMap model, HttpServletRequest request, WebEventVO vo,@PathVariable String pathLang) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){
          //return responseJson(model, new WebEventMessages(WebEventMessages.ST_LOGIN_CK,MessageHelper.getMsg(request, "userLoginCheck")));
          vo.setWrterId("guest");

          if(StringUtil.ZERO == service.passwordCheck(vo)){
              logger.info("비회원 비밀번호 체크");
              return  responseJson(model, new WebEventMessages(WebEventMessages.ST_ANSWER_CK,MessageHelper.getMsg(request, "chkEventPassword")));
          }

        }else{
            vo.setWrterId(userLoginVO.getUserId());
        }

        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null){
            ip = request.getRemoteAddr();
        }
        vo.setWrterIp(ip);

        int affected = service.answerUpdateAction(vo);

        if(affected == StringUtil.ONE) {
            return  responseJson(model, new WebEventMessages(WebEventMessages.SUCCESS,MessageHelper.getMsg(request, "eventModi")));
        }
        return responseText(model, Messages.FALSE);

    }

    /**
     * answerDelteAction (댓글 삭제)
     * @param model
     * @param request
     * @param vo
     * @return
     */
    @RequestMapping(value = "ND_answerDeleteAction.do" , method = RequestMethod.POST)
    public String answerDelteAction(ModelMap model, HttpServletRequest request, WebEventVO vo,@PathVariable String pathLang) {

        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)){
          vo.setWrterId("guest");

          if(StringUtil.ZERO == service.passwordCheck(vo)){
              logger.info("비회원 비밀번호 체크");
              return  responseJson(model, new WebEventMessages(WebEventMessages.ST_ANSWER_CK,MessageHelper.getMsg(request, "chkEventPassword")));
          }

        }else{
            vo.setWrterId(userLoginVO.getUserId());
        }

        int affected = service.answerDeleteAction(vo);

        if(affected == StringUtil.ONE) {
            return  responseJson(model, new WebEventMessages(WebEventMessages.SUCCESS,MessageHelper.getMsg(request, "eventDel")));
        }
        return responseText(model, Messages.FALSE);
    }


}
