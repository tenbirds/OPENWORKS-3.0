/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import zes.core.lang.Validate;
import zes.core.lang.validate.ValidateResultHolder;
import zes.core.lang.validate.ValidateUtil;
import zes.core.utils.Converter;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.email.AutoMailTemplate;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cms.support.CmsUtil;

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
 * 2015. 8. 24.    방기배       신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/**/pt/")
public class NewsLetterController extends WebController {
    @Autowired
    private NewsLetterService newsLetterService;

    @Autowired
    private AutoMailService amservice;

    /**
     * e-mail 중복 체크
     */
    @RequestMapping(value = "NewsLetterEmailDupleCheck.do")
    public String emailDupleCheck(NewsLetterVO vo, ModelMap model){
        ValidateResultHolder holder = ValidateUtil.validate(vo);
        if(holder.isValid()){
            int checkNum = newsLetterService.emailDupleCheck(vo);
            if(checkNum == 1){
                return responseText(model, "member");
            //}else if(checkNum == 2){
            //    return responseText(model, "member");
            //}else if(checkNum == 3){
            //    return responseText(model, "member");
            }else if(checkNum == 4){
                return responseText(model, "alreadyNewsLetterMember");
            }else if(checkNum == 5){
                return responseText(model, "notCrtfc");
            }else{
                return responseText(model, "true");
            }
        }

        return responseText(model, "false");
    }

    /**
     * 인증이메일 발송 액션
     */
    @RequestMapping(value = "NewsLetterEmailCrtfcAction.do")
    public String emailCrtfcAction(HttpServletRequest request, ModelMap model, NewsLetterVO vo){
        Map<String, Object> emailCrtft = newsLetterService.emailCrtfcSave(vo);
        Integer affected = (Integer)emailCrtft.get("affected");
        String cyrEnKey = Converter.URLEncode((String) emailCrtft.get("crtfcKeyValue"));
        String hostNm = ""; // 현재접속 서브도메인
        String rtnurl = ""; // 가입계속 시 들어오게 될 URL

        if(Validate.isNotEmpty(cyrEnKey) && Validate.isNotEmpty(affected)){
            if(affected == 999){
                // 인증 유효시간 10분이내 같은 정보로 이메일 발송시도 체크
                return responseText(model, "999");
            }
            boolean result = false;
            
            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가 
            // 추가소스
            HttpSession hs = request.getSession();
            String DomainName = String.valueOf(hs.getAttribute("domain_name")); 
            //}}
            Map<String, Object> autoMap = new HashMap<String, Object>();
            /*
             * 필수 입력 항목
             * ---------------------------------------------------------
             * 메일템플릿 번호
             * ---------------------------------------------------------
             * //AutoMailTemplate.java참고
             * ---------------------------------------------------------
             */
            String requestMode = vo.getRequestMode();

            if(requestMode.equals("RQST")){
                autoMap.put("automailId", AutoMailTemplate.KOR_NL_RQST_CTFC_MAL);
            }
            else if(requestMode.equals("CANCL")){
                autoMap.put("automailId", AutoMailTemplate.KOR_NL_CANCL_CTFC_MAL);
            }

            // 전송할 메일 정보 입력
            autoMap.put("receiverName", vo.getUserNm());    // 수신자명
            autoMap.put("email", vo.getEmail());            // 수신이메일주소

            /*
             * 메일 템플릿에 적용될 치환값 : name, rtnurl, cnlurl
             */
            HashMap<String, String> oneToOneInfoMap = new HashMap<String, String>();
            hostNm = CmsUtil.getHostName(request.getServerName());
            if("".equals(hostNm) || "www".equals(hostNm)){
                hostNm = "korean";
            }

            String email = vo.getEmail();
            byte[] encodeEmail = Base64.encodeBase64(email.getBytes());
            String encEmail = new String(encodeEmail);
            /*이전소스
            rtnurl = "http://" + hostNm + ".ceart.kr/" + hostNm + "/pt/" + "/NewsLetterMailCrtfcCheck.do?key=" + cyrEnKey + "&value="  + encEmail + "&requestMode=" + requestMode + "&langCode=" + vo.getLangCode();*/

            //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
            // 변경소스
            rtnurl = "http://" + DomainName + "/" + hostNm + "/pt/" + "/NewsLetterMailCrtfcCheck.do?key=" + cyrEnKey + "&value="  + encEmail + "&requestMode=" + requestMode + "&langCode=" + vo.getLangCode();
            //}}
            
            // 치환내용 입력(메일 종류에 따라 선택적으로 입력)
            oneToOneInfoMap.put("name", vo.getUserNm());
            oneToOneInfoMap.put("rtnurl", rtnurl);

            // 치환정보 맵 입력
            autoMap.put("oneToOneInfo", oneToOneInfoMap);

            // 선택 입력 항목
            autoMap.put("senderName", "ceartMarket"); // 생략시 기본 설정값 적용 : 씨앗마켓
            // autoMap.put("senderEmail", "발신자 이메일"); // 생략시 기본 설정값 적용 :
            // webmaster@ceart.kr
            // autoMap.put("mailTitle", "메일 제목"); // 생략시 기본 설정값 적용

            // EMAIL 발송
            result = amservice.sendAutoMail(autoMap);
            if(result) {
                logger.debug("########################################################");
                logger.debug("####뉴스레터 구독신청/취소 인증 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 성공#########");
                logger.debug("########################################################");
            } else {
                logger.debug("########################################################");
                logger.debug("####뉴스레터 구독신청/취소 E-MAIL : " + vo.getEmail() + "," + vo.getUserNm() + "에게 발송 실패#########");
                logger.debug("########################################################");
            }

            if(requestMode.equals("RQST")){
                return responseText(model, "rqst_ok");
            }else if(requestMode.equals("CANCL")){
                return responseText(model, "cancl_ok");
            }else{
                return responseText(model, "true");
            }
        }
        return responseText(model, "false");
    }

    /**
     * 뉴스레터 신청/취소 인증메일에서 확인
     */
    @RequestMapping(value = "NewsLetterMailCrtfcCheck.do")
    public String emailCrtfcCheck(HttpServletRequest request, ModelMap model,
                      @RequestParam(value = "key", required = false) String cryEnKey,
                      @RequestParam(value = "value", required = false) String email,
                      @RequestParam(value = "requestMode", required = false) String requestMode,
                      @RequestParam(value = "langCode", required = false) String langCode){

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("crtfcKeyValue", cryEnKey);
        parameterMap.put("email", new String(Base64.decodeBase64(email)));
        parameterMap.put("requestMode", requestMode);
        parameterMap.put("langCode", langCode);

        if(Validate.isNotEmpty(cryEnKey) && Validate.isNotEmpty(email)){
            int cnt = newsLetterService.emailCrtfcCheck(parameterMap);
            if(cnt > 0){
                String msg = "";
                parameterMap.put("emailCrtfcYnCd", 1001);

                if(requestMode.equals("RQST")){
                    newsLetterService.newsLetterRequestComplete(parameterMap);
                    msg = MessageHelper.getMsg(request, "newsLetterRequestIsOk");
                }else if(requestMode.equals("CANCL")){
                    newsLetterService.newsLetterCancelComplete(parameterMap);
                    msg = MessageHelper.getMsg(request, "newsLetterCancelIsOk");
                }

                return alertAndRedirect(model, msg, requestUrl(request) + "index.do");
            }else{
                String msg = "";

                if(requestMode.equals("RQST")){
                    newsLetterService.newsLetterCancelComplete(parameterMap);
                    msg = MessageHelper.getMsg(request, "newsLetterCrtfcExpired");
                }else if(requestMode.equals("CANCL")){
                    msg = MessageHelper.getMsg(request, "newsLetterCrtfcExpired");
                }

                return alertAndRedirect(model, msg, requestUrl(request) + "index.do");
            }
        }

        if(requestMode.equals("RQST")){
            return alertAndRedirect(model, MessageHelper.getMsg(request, "unknownErrorRequest"), requestUrl(request));
        }else if(requestMode.equals("CANCL")){
            return alertAndRedirect(model, MessageHelper.getMsg(request, "unknownErrorCancel"), requestUrl(request));
        }else{
            return alertAndRedirect(model, MessageHelper.getMsg(request, "processError"), requestUrl(request));
        }
    }

    /**
     * 뉴스레터 메일 안에서 수신거부
     */
    @RequestMapping(value = "NewsLetterRejectFromEmail.do")
    public void rejectNewsLetter(HttpServletRequest request, ModelMap model, HttpServletResponse response,
                                 @RequestParam(value = "key", required = false) String key,
                                 @RequestParam(value = "value", required = false) String email,
                                 @RequestParam(value = "requestKind", required = false) String requestKind){

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("crtfcKeyValue", key);
        parameterMap.put("email", email);
        parameterMap.put("requestKind", requestKind);
        
        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스추가 
        // 추가소스
        String DomainName = GlobalConfig.DOMAIN_SUBNM;
        //}}

        if(Validate.isNotEmpty(email)){
            NewsLetterVO vo = new NewsLetterVO();
            vo.setCrtfcKeyValue(key);
            vo.setEmail(email);
            vo.setRequestKind(requestKind);

            ValidateResultHolder holder = ValidateUtil.validate(vo);

            if(holder.isValid()){
                PrintWriter writer = null;

                try{
                    writer = response.getWriter();
                    response.setCharacterEncoding("UTF-8");
                    response.setContentType("text/html; charset=UTF-8");
                }catch(IOException e){
                    logger.debug(e.toString());
                }

                int checkNum = newsLetterService.emailDupleCheck(vo);

                if(checkNum == 1 || checkNum == 2 || checkNum == 3){
                    //씨앗마켓 회원입니다. 회원정보 변경에서 뉴스레터 구독을 취소하시기 바랍니다.
                    writer.println("<script>confirm('" + MessageHelper.getMsg(request, "alreadyMemberCancel") + "') ? location.href = 'http://"+DomainName+"/korean/pt/login/user/BD_index.do' : location.href='http://www.ceart.kr';</script>");
                }else{
                    if(Validate.isEmpty(key)){
                        //올바른 경로가 아닙니다. 정상적인 경로를 이용해 주십시오.
                        writer.println("<script>alert('" + MessageHelper.getMsg(request, "isNotValidLink") + "');location.href='http://"+DomainName+"/korean/pt/index.do';</script>");
                    }else{
                        int chkCnt = newsLetterService.newsLetterRejectFromEmailCheck(parameterMap);

                        if(chkCnt == 0){
                            //올바른 경로가 아닙니다. 정상적인 경로를 이용해 주십시오.
                            writer.println("<script>alert('" + MessageHelper.getMsg(request, "isNotValidLink") + "');location.href='http://"+DomainName+"/korean/pt/index.do';</script>");
                        }else{
                            int affectedRow = newsLetterService.newsLetterRejectFromEmail(parameterMap);

                            if(affectedRow == 0){
                                //뉴스레터 구독자가 아닙니다.
                                writer.println("<script>alert('" + MessageHelper.getMsg(request, "notNewsLetterMember") + "');location.href='http://"+DomainName+"/korean/pt/index.do';</script>");
                            }else{
                                //뉴스레터 수신 거부가 정상적으로 처리되었습니다.
                                writer.println("<script>alert('" + MessageHelper.getMsg(request, "newsLetterRejectIsOk") + "');location.href='http://"+DomainName+"/korean/pt/index.do';</script>");
                            }
                        }
                    }
                }

                writer.flush();
                writer.close();
            }
        }
    }

    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }
}
