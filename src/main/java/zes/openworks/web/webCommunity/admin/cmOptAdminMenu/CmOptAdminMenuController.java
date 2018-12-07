/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptAdminMenu;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
//import zes.base.support.OpHelper;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
//import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.login.UserLoginVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 11. 3.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/admin/cmOptAdminMenu")
public class CmOptAdminMenuController extends WebController {
    
    @Autowired
    CmOptAdminMenuService cmOptAdminMenuService;

    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmManageService cmManageService;
    
    /**
     *   커뮤니티 운영자 사이드 메뉴
     * 
     */
    
    @RequestMapping(value = "INC_cmOptAdminMenuLeft.do")
    public void cmOptAdminMenuList(HttpServletRequest request, ModelMap model, CmOptAdminMenuVO vo, CmManageVO cmvo ){
        
        //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        cmvo.setCmmntyId(strCmmntyId);
        cmvo.setLangCode(vo.getLangCode());

        model.addAttribute("cmUserMenuView", cmManageService.openCmManageView(cmvo)); // 기본정보
        model.addAttribute("cmmntyId",strCmmntyId);
        model.addAttribute("menuCode",vo.getMenuCode());
        model.addAttribute("cmOptAdminMenuList", cmOptAdminMenuService.cmOptAdminMenuList(vo));
    
        
    }
    
    
    
}
