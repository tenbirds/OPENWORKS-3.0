/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserInfo;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.webCommunity.admin.cmOptInfo.CmOptInfoService;


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
@RequestMapping(value = "/**/cm/user/cmUserInfo")
public class CmUserInfoController extends WebController {
    
    @Autowired
    CmOptInfoService cmOptInfoService;
    @Autowired
    CmManageBoardService cmManageBoardService;
    
    @Autowired
    CmManageService cmManageService;
    
    @Autowired
    CodeService codeService;
    
    @Autowired
    CommonDutyService commonDutyService;
    /**
     * 포털 커뮤니티 사용자 커뮤니티 정보
     */
    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, CmManageVO vo, CmManageBoardVO cmbvo, CodeVO cvo){
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        if(userLoginVo != null){
            vo.setUserId(userLoginVo.getUserId()); // cmson36
        }
        //vo.setCmmntyId("openson36"); 
        vo.setCmmntyId(strCmmntyId);
        
        model.addAttribute("userEntrprsOption", cmManageService.userEntrprsOptionSelect(vo)); // 기업회원 추가 정보 // 2001    기업회원     2002    기업판매회원
        model.addAttribute("userOption", cmManageService.userOptionSelect(vo)); // 일반회원 추가 정보 //  1001 개인회원     1002 개인판매회원 
        
        model.addAttribute("cmUserView", cmManageService.openCmManageView(vo)); // 기본정보
        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        
    }
    
  

}
