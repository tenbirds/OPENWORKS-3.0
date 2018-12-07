/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.myCm;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
//import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
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
 * 2014. 11. 30.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "**/pt/myCm")
public class MyCmController extends WebController {
    
    @Autowired
    MyCmService myCmService;
    
    @Autowired
    CommonDutyService commonDutyService;

    @Autowired
    CmManageService cmManageService;
    
    @Autowired
    CmUserMenuService cmUserMenuService;
    /**
     * 커뮤니케이션 마이페이지 커뮤니티 가입 목록
     */
    @RequestMapping(value = "BD_myCmJoinList.do")
    public void myCmJoinIndex(HttpServletRequest request, ModelMap model, CmManageVO vo){

        OpHelper.bindSearchMap(vo, request);

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        if(userLoginVo != null){
           vo.setUserId(userLoginVo.getUserId());
        }



        model.addAttribute("cmInfo", cmManageService.openCmManageView(vo));  // 기본정보

        model.addAttribute(GlobalConfig.KEY_PAGER, myCmService.cmMberInfoList(vo));

    }
    
    
    /**
     *  커뮤니티 회원 탈퇴
     * 
     */
    @RequestMapping(value = "INC_cmMemberShipSecedeUpdate.do")
    public String  cmMemberShipSecedeUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo)  {
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";    
        
        String StrResult1 = ""; 
        
         UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
         // 도메인코드
         String hostNm     = CmsUtil.getHostName(request.getServerName());
         String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
         
         vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
         
         if(userLoginVo != null){
             vo.setCmmntyId(strCmmntyId);
             vo.setCmmntyMberId(userLoginVo.getUserId());     
         }
         
        //커뮤니티회원강제탈퇴 : >>1001:운영자강제탈퇴        1002:관리자강제탈퇴
        // 커뮤니티회원상태 :>>>1001:가입중        1002:가입거절       1003:정상     1004:탈퇴
        vo.setMberStateCd(1004);
        vo.setEnfrcSecsnCd(1003); // 강제탈퇴코드 1001:운영자강제탈퇴    1002:관리자강제탈퇴 1003:본인탈퇴
        StrResult1 = cmUserMenuService.cmMemberShipSecedeUpdate(vo); // 1004:탈퇴 
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    
    /**
     *  커뮤니티 회원 신청 취소
     * 
     */
    @RequestMapping(value = "INC_cmMemberShipCancelDelete.do")
    public String cmMemberShipCancelDelete( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";     
        //String mmntySbscrbMthd
        String StrResult1 = ""; 
        
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        if(userLoginVo != null){
            vo.setCmmntyId(strCmmntyId);
            vo.setCmmntyMberId(userLoginVo.getUserId());     
        }
        
        StrResult1 = cmManageService.cmMemberShipCancelDelete(request, vo); // 커뮤니티 회원 신청 취소
        
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    
    /**
     * 커뮤니케이션 마이페이지 개설 커뮤니티 목록
     */
    @RequestMapping(value = "BD_myCmOpenList.do")
    public void myCmOpenList(HttpServletRequest request, ModelMap model, CmManageVO vo){

        OpHelper.bindSearchMap(vo, request);

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        if(userLoginVo != null){
           vo.setUserId(userLoginVo.getUserId());
        }

        model.addAttribute("cmInfo", cmManageService.openCmManageView(vo));  // 기본정보

        model.addAttribute(GlobalConfig.KEY_PAGER, myCmService.myCmOpenList(vo));

    }

}
