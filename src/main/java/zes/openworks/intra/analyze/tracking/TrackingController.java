/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.tracking;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.core.spi.oscache.Cache;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;

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
 *  2012. 5. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Controller
@RequestMapping(value = "/analyze/tracking")
public class TrackingController extends IntraController {

    @Autowired
    DomainService domainService;

    @Resource(name = "trackingService")
    private TrackingService service;

    /**
     * 권한할당 관리 페이지
     * return 값이 void 인 경우 spring controller가 INC_analyzeTracking.jsp를 찾으므로 그냥
     * 결과를 빈 텍스트 처리 했음.
     * @throws Exception 
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "INC_analyzeTracking.do")
    public String analyzeTracking(TrackingVO vo, HttpServletRequest request, HttpSession session) {
        List<DomainVO> domainList = (List<DomainVO>)Cache.get(GlobalConfig.KEY_DOMAIN_LIST);
        for(DomainVO map : domainList){
            if(request.getServerName().equals(map.getDomainNm())){
                setAnalyzeTrackingValues(vo, request, session);
                service.analyzeTracking(vo);
            }
        }

        return responseText(new ModelMap());
    }

    private void setAnalyzeTrackingValues(TrackingVO vo, HttpServletRequest request, HttpSession session) {
        vo.setAnlzSessionId(session.getId());
        vo.setAnlzIp(request.getLocalAddr());
        vo.setServerName(request.getServerName());
    }
}
