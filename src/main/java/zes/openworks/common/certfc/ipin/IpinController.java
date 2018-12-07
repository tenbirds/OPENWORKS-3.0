/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.common.certfc.ipin;

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
 * 2014. 10. 17.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/common/ipin")
public class IpinController {
    /**
     * Ipin인증 샘플메인
     */
    @RequestMapping(value = "ipin_main.do", method = RequestMethod.GET)
    public void ipinMain() {

    }
    
    /**
     * Ipin인증 처리
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "ipin_process.do")
    public void ipinProcess(HttpServletRequest request) throws UnsupportedEncodingException {

    }
    
    /**
     * Ipin인증 결과
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "ipin_result.do")
    public void ipinResult(HttpServletRequest request) throws UnsupportedEncodingException {

    }
}