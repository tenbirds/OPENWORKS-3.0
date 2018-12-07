/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.register.RegisterUserVO;

/**
 * 사용자단 공통 컨트롤러
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
public class WebController extends GeneralController {

    /**
     * <code>HttpServletRequest</code>에서 사용자 세션정보 얻기
     */
    public static UserLoginVO getLoginSession(HttpServletRequest request) {
        return OpHelper.getUserSession(request);
    }

    /* 판매하기 권한 코드 */
    protected static final List<Integer> ORDER_AUTH_CODE;
    static {
      List<Integer> orderCode = new ArrayList<Integer>();
      orderCode.add(1002); //개인 판매 코드
      orderCode.add(2002); //기업 판매 코드
      orderCode.add(3002); //공공 판매 코드
      ORDER_AUTH_CODE = orderCode;
    }

    protected String getLangCode(String pathLang){
        String langCode = "00";
        if(pathLang.equals("korean")){
            langCode = "00";
        }else if(pathLang.equals("english")){
            langCode = "01";
        }else if(pathLang.equals("spanish")){
            langCode = "06";
        }
        return langCode;
    }

    /**
     *  "**" Url 처리 하기 위해 만듬
     *
     * @param request
     * @return
     */
    protected  String getBaseUrl(ModelMap model, String pathLang){

        model.addAttribute("_pathLang",pathLang);

        StringBuffer sb = new StringBuffer();
        int SpCt = 2;

        String[] sp = baseUrl.split("[/]");
        sb.append("/").append(pathLang);

        if(sp.length >= SpCt){
            for (int i = SpCt; i < sp.length; i++) {
                sb.append("/").append(sp[i]);
            }
        }
        return sb.toString();
    }

    @RequestMapping(value = "DummyGet.do", method=RequestMethod.POST)
    public String DummyGet(HttpServletRequest request, ModelMap model, RegisterUserVO vo) {
        return responseText(model, "true");
    }
}