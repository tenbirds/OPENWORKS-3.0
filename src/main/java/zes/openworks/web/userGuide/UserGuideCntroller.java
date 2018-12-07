/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.userGuide;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cms.CmsVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.main.MainConstant;

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
 * 2014. 12. 13.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/userguide")
public class UserGuideCntroller extends WebController {
    @Autowired
    UserGuideService userGuideService;
    
    /**
     * 사이트맵
     * @throws Exception 
     */
    @RequestMapping(value = "/BD_sitemap.do", method = RequestMethod.GET)
    public void siteguide(HttpServletRequest request, ModelMap model) throws Exception {
        String domainNm = CmsUtil.getHostName(request.getServerName());
        String strDomCd = ""; 
        CmsVO cmsVo = new CmsVO();
        strDomCd = new MainConstant().getDomainCode(domainNm);
        cmsVo.setDomainCd(Integer.parseInt(strDomCd));
        List<CmsVO> menuList = userGuideService.getMenuList(cmsVo);
        model.addAttribute("CmsMenuList", menuList);
        
        //SKYYOU {{
        Map<String, Object> vo = new HashMap<String, Object>();
        vo.put("ctgryCode", "0");        
        model.addAttribute("ctgryList", userGuideService.getCtgryList(vo));
        //}}
    }

}
