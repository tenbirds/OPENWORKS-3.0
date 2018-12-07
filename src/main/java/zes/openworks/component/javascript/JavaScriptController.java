/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.javascript;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import zes.base.spring.GeneralController;
import zes.core.lang.Validate;
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.JsonUtil;
import zes.openworks.intra.cms.support.CmsUtil;

/**
 * Java와 JavaScript 단과 설정 등을 공유하기 위한 컨트롤러
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
 *  2012. 4. 3.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/component/javascript" })
public class JavaScriptController extends GeneralController {

    /** 최상위 키 */
    private static String[] rootKeys = { "global", "url" };
    /** 공통 JavaScript 변수명 */
    private static final String GLOBAL_NAME = "var Config = ";
    /** 메시지 JavaScript 변수명 */
    private static final String MSG_NAME = "var Message = ";
    /** 사용자 정의 JavaScript 변수명 */
    private static final String CUS_NAME = "var Custom = ";

    /**
     * 화면단에 JAVA와 동일한 환경 설정 내용을 전달한다.(데코레이터에 정의됨)
     * <p />
     * 프레임워크 기본 설정을 JSON 객체로 반환
     * <p />
     * <code>
     * &lt;script type="text/javascript" src="/component/javascript/MD_globalConfig.do"&gt;&lt;/script&gt;
     * </code>
     * 
     * @param model 반환값을 담을 리턴 객체
     * @return
     */
    @RequestMapping(value = { "MD_globalConfig.do" })
    public String getGlobalConfig(HttpServletResponse response, ModelMap model) {

        response.setContentType("text/javascript");

        Map<String, Object> globalConfig = new HashMap<String, Object>();
        for(String rootKey : rootKeys) {
            setGlobalConfig(globalConfig, rootKey, "");
        }

        String json = GLOBAL_NAME + JsonUtil.toJson(globalConfig);

        return responseText(model, json);
    }

    /**
     * 화면단에 JAVA와 동일한 환경 설정 내용을 전달한다.(데코레이터에 정의됨)
     * <p />
     * 프레임워크 기본 설정을 JSON 객체로 반환
     * <p />
     * <code>
     * &lt;script type="text/javascript" src="/component/javascript/MD_massageConfig.do"&gt;&lt;/script&gt;
     * </code>
     * 
     * @param model 반환값을 담을 리턴 객체
     * @return
     */
    @RequestMapping(value = { "MD_massageConfig.do" })
    public String getMassageConfig(HttpServletResponse response, HttpServletRequest request, ModelMap model) {

        response.setContentType("text/javascript");

        Map<String, Object> messageConfig = new HashMap<String, Object>();
        String hostNm = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        
        setGlobalConfig(messageConfig, "msg", hostNm);

        String json = MSG_NAME + JsonUtil.toJson(messageConfig);

        return responseText(model, json);
    }

    /**
     * 화면단에 JAVA와 동일한 환경 설정 내용을 전달한다.
     * <p />
     * 기능별 환경 설정 코드를 JSON 객체로 반환
     * <p />
     * <code>
     * &lt;script type="text/javascript" src="/component/javascript/MD_customConfig.do?rootKey=설정키1&rootKey=설정키2&..."&gt;&lt;/script&gt;
     * </code>
     * 
     * @param request 요청객체
     * @param model 반환값을 담을 리턴 객체
     * @return
     */
    @RequestMapping(value = { "MD_customConfig.do" })
    public String getCustomConfig(HttpServletResponse response, ModelMap model, JavaScriptConfigVO confVo) {

        response.setContentType("text/javascript");

        Map<String, Object> customConfig = new HashMap<String, Object>();
        if(Validate.isNotEmpty(confVo.getRootKey())) {
            for(String rootKey : confVo.getRootKey()) {
                setGlobalConfig(customConfig, rootKey, "");
            }
        }

        String json = CUS_NAME + JsonUtil.toJson(customConfig);

        return responseText(model, json);
    }

    /**
     * ROOT Key 를 받아 하위 키와 값을 <code>Map</code>에 설정
     * 
     * @param globalConfig
     * @param rootKey
     */
    private void setGlobalConfig(Map<String, Object> globalConfig, String rootKey, String hostNm) {

        Map<String, Object> config = new HashMap<String, Object>();
        String key, splitKey;
        
        if("msg".equals(rootKey) && !"".equals(hostNm) && !"intra".equals(hostNm) && !"korean".equals(hostNm) && !"www".equals(hostNm)){
            rootKey = hostNm+"Msg";
        }
        Iterator<String> props = Config.getKeys(rootKey);
        while(props.hasNext()) {
            key = props.next();
            splitKey = key.substring(key.lastIndexOf(".") + 1);
            config.put(splitKey, Config.getString(key, ""));
        }
        if(rootKey.indexOf("Msg") > -1){
            rootKey = "msg";
        }
        globalConfig.put(rootKey, config);
    }

}
