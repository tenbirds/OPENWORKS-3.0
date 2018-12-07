/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMain;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
//import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService;


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
 * 2014. 11. 13.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/user/cmUserMain")
public class CmUserMainController extends WebController {
    
    @Autowired
    CmUserMainService  cmUserMainService;
    
    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmUserMenuService cmUserMenuService;
    
    @Autowired
    CmManageService cmManageService;
    
    
    /**
     * 포털 커뮤니티 사용자 메인
     */
    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, CmManageBoardVO vo , CmManageVO cmv){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmv, request);
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        vo.setCmmntyId(strCmmntyId);
        cmv.setCmmntyId(strCmmntyId);
        cmv.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setOthbcSetupCdChk("2"); //1001 전체공개 1002 멤버공개 1003 작성자만 체크 벨류
           cmv.setCmmntyMberId(userLoginVo.getUserId());
           cmv.setOthbcSetupCdChk("2");
        }else{
            vo.setOthbcSetupCdChk("1");
            cmv.setOthbcSetupCdChk("1");
        }
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv)); 
        
        model.addAttribute("cmUserMainMenu", cmUserMainService.cmUserMainMenuList(cmv)); // 메인 리스트 메뉴 
        
    }

}
