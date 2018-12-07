/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.synchronize;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.support.SpringHelper;

/**
 * 컨텐츠 동기화 컨트롤러
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
 *  2012. 5. 8.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/component/synchronize")
public class SynchronizeController extends GeneralController {

    /**
     * <pre>
     * 동기화 요청 처리
     * 반드시 서비스 명을 파라미터에 포함해야 하며 이외사용하고자 하는 파라미터를 포함하여 요청
     * 필수 파라미터 : serviceName=cacheSyncService  => 서비스 클레스의 Annotation @Service("cacheSyncService")
     * impl 패키지 내의 서비스 클레스 참조
     * </pre>
     */
    @RequestMapping(value = { "ND_Synchronize.do" }, method = RequestMethod.POST)
    public String synchronize(HttpServletRequest request, ModelMap model, SynchronizeVO synchronizeVo) throws Exception {

        ServletContext svrCtx = request.getSession().getServletContext();

        SynchronizeService syncService = (SynchronizeService) SpringHelper.findService(svrCtx, synchronizeVo.getServiceName());

        syncService.synchronize(request, synchronizeVo);

        return responseText(model);
    }

}
