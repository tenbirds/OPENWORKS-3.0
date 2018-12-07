/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.certfc.checkplus;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 15.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/common/checkplus")
public class CheckplusController {
    /**
     * 안심본인인증 샘플메인
     */
    @RequestMapping(value = "checkplus_main.do", method = RequestMethod.GET)
    public void checkPlusMain() {

    }
    
    /**
     * 안심본인인증 성공
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "checkplus_success.do")
    public void ipinProcess(HttpServletRequest request) throws UnsupportedEncodingException {

    }
    
    /**
     * 안심본인인증 실패
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "checkplus_fail.do")
    public void ipinResult(HttpServletRequest request) throws UnsupportedEncodingException {

    }
}
