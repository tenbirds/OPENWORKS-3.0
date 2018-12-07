/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.analyze.tracking;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import zes.openworks.common.controller.WebController;


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
 * 2014. 11. 3.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/webtracking")
public class WebTrackingController extends WebController {
    @Resource(name = "webTrackingService")
    private WebTrackingService service;

    /**
     * 권한할당 관리 페이지
     * return 값이 void 인 경우 spring controller가 INC_analyzeTracking.jsp를 찾으므로 그냥
     * 결과를 빈 텍스트 처리 했음.
     */
    @RequestMapping(value = "INC_analyzeTracking.do")
    public String analyzeTracking(WebTrackingVO vo, HttpServletRequest request, HttpSession session) {
                
        setAnalyzeTrackingValues(vo, request, session);
        service.analyzeTracking(vo);

        return responseText(new ModelMap());
    }

    private void setAnalyzeTrackingValues(WebTrackingVO vo, HttpServletRequest request, HttpSession session) {
        vo.setAnlzSessionId(session.getId());
        vo.setAnlzIp(request.getLocalAddr());
        vo.setServerName(request.getServerName());
    }
}
