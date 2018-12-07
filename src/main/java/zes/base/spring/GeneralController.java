/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.spring;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import zes.base.support.OpHelper;
import zes.base.vo.JsonVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.login.LoginVO;

/**
 * 일반적인 응답 메소드 모음
 * <p />
 * 파일 다운로드, TEXT, JSON, JavaScript 기반 응답
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
 *  2012. 3. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class GeneralController {

    /** Contrroller 로깅 */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    /** 기본 URI */
    protected String baseUrl;
   
    /**
     * 컨트롤러단 공통 초기화
     * 기본 URI 경로를 설정한다.
     */
    public GeneralController() {
        RequestMapping rm = this.getClass().getAnnotation(RequestMapping.class);
        if(rm != null) {
            this.baseUrl = rm.value()[0];
        }
    }
    
    /**
     * <code>Object</code>를 JSON 타입으로 변경하여 응답
     * 인자가 없이 호출되었기 때문에 기본 응답 "true" 문자열이 전송됨.
     * (content type = application/json)
     * 
     * @param model
     * @return "true" 문자열 반환
     */
    protected String responseJson(ModelMap model) {

        JsonVO jsonVo = new JsonVO().setResult(Boolean.TRUE);

        return responseJson(model, jsonVo);
    }

    /**
     * 파라미터로 전달되는 항목을 json VO 객체에 담아서 응답
     * (content type = application/json)
     * 
     * @param model
     * @param result 처리결과
     * @return
     */
    protected String responseJson(ModelMap model, Boolean result) {

        JsonVO jsonVo = new JsonVO().setResult(result);

        return responseJson(model, jsonVo);
    }

    /**
     * 파라미터로 전달되는 항목을 json VO 객체에 담아서 응답
     * (content type = application/json)
     * 
     * @param model
     * @param result 처리결과
     * @param message 응답메시지
     * @return
     */
    protected String responseJson(ModelMap model, Boolean result, String message) {

        JsonVO jsonVo = new JsonVO().setResult(result).setMessage(message);

        return responseJson(model, jsonVo);
    }

    /**
     * 파라미터로 전달되는 항목을 json VO 객체에 담아서 응답
     * (content type = application/json)
     * 
     * @param model
     * @param key 주요키
     * @param value 주요키에 해당하는 값
     * @param message 응답메시지
     * @return
     */
    protected String responseJson(ModelMap model, Object value, String message) {

        JsonVO jsonVo = new JsonVO().setValue(value).setMessage(message);

        return responseJson(model, jsonVo);
    }

    /**
     * 파라미터로 전달되는 항목을 json VO 객체에 담아서 응답
     * (content type = application/json)
     * 
     * @param model
     * @param result 처리결과
     * @param key 주요키
     * @param value 주요키에 해당하는 값
     * @param message 응답메시지
     * @return
     */
    protected String responseJson(ModelMap model, Boolean result, Object value, String message) {

        JsonVO jsonVo = new JsonVO().setResult(result).setValue(value).setMessage(message);

        return responseJson(model, jsonVo);
    }

    /**
     * <code>Object</code>를 JSON 타입으로 변경하여 응답
     * (content type = application/json)
     * 
     * @param model
     * @param target
     * @return
     * @see zes.base.spring.view.JsonView
     */
    protected String responseJson(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.JSON_DATA_KEY, target);

        return GlobalConfig.JSON_VIEW_NAME;
    }

    /**
     * textView를 통한 문자열 응답 (응답 문자열 없음)
     * 인자가 없이 호출되었기 때문에 기본 응답 "true" 문자열이 전송됨.
     * (content type = text/plain)
     * 
     * @param model
     * @return "true" 문자열 반환
     * @see #responseText(ModelMap, Object)
     */
    protected String responseText(ModelMap model) {
        return responseText(model, Boolean.TRUE);
    }

    /**
     * textView를 통한 문자열 응답 (<code>Object.toString()</code> 값이 응답문자열로 생성됨)
     * (content type = text/plain)
     * 
     * @param model
     * @param target
     * @return
     * @see zes.base.spring.view.TextView
     */
    protected String responseText(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.TEXT_DATA_KEY, target);

        return GlobalConfig.TEXT_VIEW_NAME;
    }

    /**
     * htmlView를 통한 HTML 응답 (<code>Object.toString()</code> 값이 응답문자열로 생성됨)
     * (content type = text/html)
     * 
     * @param model
     * @param target
     * @return
     * @see zes.base.spring.view.HtmlView
     */
    protected String responseHtml(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.HTML_DATA_KEY, target);

        return GlobalConfig.HTML_VIEW_NAME;
    }

    /**
     * downloadView를 통한 파일 다운로드
     * (content type = application/octet-stream)
     * 
     * @param model
     * @param target
     * @return
     * @see zes.base.spring.view.DownloadView
     */
    protected String responseDownload(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.FILE_DATA_KEY, target);

        return GlobalConfig.DOWNLOAD_VIEW_NAME;
    }

    /**
     * rssFeedView를 통한 RSS 서비스
     * (content type = application/rss+xml)
     * 
     * @param model
     * @param target
     * @return
     */
    protected String responseRSS(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.OBJ_DATA_KEY, target);

        return GlobalConfig.RSS_VIEW_NAME;
    }

    /**
     * atomFeedView를 통한 Atom 서비스
     * (content type = application/atom+xml)
     * 
     * @param model
     * @param target
     * @return
     */
    protected String responseAtom(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.OBJ_DATA_KEY, target);

        return GlobalConfig.ATOM_VIEW_NAME;
    }

    /**
     * excelView를 통한 excel 파일 다운로드
     * (content type = application/vnd.ms-excel)
     * 
     * @param model
     * @param target
     * @return
     */
    protected String responseExcel(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.OBJ_DATA_KEY, target);

        return GlobalConfig.EXCEL_VIEW_NAME;
    }

    /**
     * pdfView를 통한 pdf 파일 다운로드
     * (content type = application/pdf)
     * 
     * @param model
     * @param target
     * @return
     */
    protected String responsePDF(ModelMap model, Object target) {

        model.addAttribute(GlobalConfig.OBJ_DATA_KEY, target);

        return GlobalConfig.PDF_VIEW_NAME;
    }

    /**
     * JavaScript 기반 메시지 및 창 닫기
     * <p />
     * alert("message"); history.back();
     * 
     * @param model
     * @param message
     * @return
     */
    protected String alertAndBack(ModelMap model, String message) {
        if(Validate.isEmpty(message)) {
            message = "이전 페이지로 이동합니다.";
        }

        model.addAttribute("message", message);

        return GlobalConfig.ALERT_AND_BACK;
    }

    /**
     * JavaScript 기반 메시지(alert) 및 창 닫기
     * <p />
     * alert("message"); self.close(); or $.fn.colorbox.close();
     * 
     * @param model
     * @param message
     * @return
     */
    protected String alertAndClose(ModelMap model, String message) {
        if(Validate.isEmpty(message)) {
            message = "현재 창을 닫습니다.";
        }

        model.addAttribute("message", message);

        return GlobalConfig.ALERT_AND_CLOSE;
    }

    /**
     * JavaScript 기반 메시지(alert) 및 페이지 이동
     * <p />
     * alert("message"); self.location.href("url");
     * 
     * @param model
     * @param message
     * @param url
     * @return
     */
    protected String alertAndRedirect(ModelMap model, String message, String url) {
        if(Validate.isEmpty(message)) {
            message = "현재 창을 닫습니다.";
        }

        if(Validate.isEmpty(url)) {
            url = "/";
        }

        model.addAttribute("message", message);
        model.addAttribute("url", url);

        return GlobalConfig.ALERT_AND_REDIRECT; // common/actions/ND_AlertAndRedirect.jsp
    }
    
    /**
     * JavaScript 기반 메시지(alert) 및 페이지 이동
     * <p />
     * alert("message"); 'target'.location.href("url");
     * 
     * @param model
     * @param message
     * @param url
     * @return
     */
    protected String alertAndRedirectTarget(ModelMap model, String message, String url, String target) {
        if(Validate.isEmpty(message)) {
            message = "현재 창을 닫습니다.";
        }

        if(Validate.isEmpty(url)) {
            url = "/";
        }
        
        if(Validate.isEmpty(target)) {
            url = "self";
        }

        model.addAttribute("message", message);
        model.addAttribute("url", url);
        model.addAttribute("target", target);

        return GlobalConfig.ALERT_AND_REDIRECT; // common/actions/ND_AlertAndRedirect.jsp
    }

    /**
     * JavaScript 기반 메시지 확인(confirm) 및 페이지 이동
     * 
     * <pre>
     * confirm("message"); 
     * true : self.location.href("url");
     * false : history.back();
     * </pre>
     * 
     * @param model
     * @param message
     * @param url
     * @return
     */
    protected String confirmAndRedirect(ModelMap model, String message, String url) {
        if(Validate.isEmpty(message)) {
            message = "현재 창을 닫습니다.";
        }

        if(Validate.isEmpty(url)) {
            url = "/";
        }

        model.addAttribute("message", message);
        model.addAttribute("url", url);

        return GlobalConfig.CONFIRM_AND_REDIRECT;
    }

    /**
     * JavaScript 기반 메시지 확인(confirm) 및 페이지 이동
     * 
     * <pre>
     * confirm("message"); 
     * true  : parent.parent.location.href("url");
     * false : parent.$.fn.colorbox.close();
     * </pre>
     * 
     * @param model
     * @param message
     * @param url
     * @return
     */
    protected String confirmAndRedirectPopup(ModelMap model, String message, String url) {
        if(Validate.isEmpty(message)) {
            message = "현재 팝업창을 닫습니다.";
        }

        if(Validate.isEmpty(url)) {
            url = "/";
        }

        model.addAttribute("message", message);
        model.addAttribute("url", url);

        return GlobalConfig.CONFIRM_AND_REDIRECT_POPUP;
    }
    
    /**
     * JavaScript 코드를 실행한다.
     * <p />
     * 화면내에 <script /> 태그는 작성되어 있으므로 실 코드만 작성한다.<br />
     * 예: alert("HelloWorld");
     * 
     * @param model
     * @param scriptCode
     * @return
     */
    protected String sendScript(ModelMap model, String scriptCode) {

        model.addAttribute("scriptCode", scriptCode);

        return GlobalConfig.SEND_SCRIPT;
    }
    
    /**
     * 담당자 권한정보 확인하기  
     */
    @SuppressWarnings("rawtypes")
    public static HashMap getLoginAuth(LoginVO vo ) {
        return OpHelper.getMgrAuth(vo);
    }
    
    /**
     * referer 체크
     */
    public Boolean requestRefererChk(HttpServletRequest request) {
        Boolean returnVal = false;
        if(Validate.isEmpty(request.getHeader("referer"))){
            //값이 없으면
            returnVal = true;
        } else {
            String referer = request.getHeader("referer");
            referer = referer.replaceAll("(?i:https?://([^/]+)/.*)", "$1");

            if(referer.indexOf(GlobalConfig.DOMAIN_SUBNM) == -1){
                returnVal = true;
            } else {
                returnVal = false;
            }
        }
        return returnVal;
    }
}
