/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserPlan;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cms.support.CmsUtil;
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
 * 2014. 11. 28.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/user/cmUserPlan")
public class CmUserPlanController extends WebController {
    
    @Autowired
    CmUserPlanService cmUserPlanService;
    
    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmManageService cmManageService;
    
    @Autowired
    CmUserMenuService cmUserMenuService;
    
    /**
     * 커뮤니티 사용자 일정 게시판
     */
    @RequestMapping(value = "BD_cmUserPlanList.do")
    public void cmUserPlanList(HttpServletRequest request, ModelMap model, CmManageVO cmv){
        
        OpHelper.bindSearchMap(cmv, request);
        
//        CmManageVO cmv = new CmManageVO();
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
//        String strOptUserId = "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
//        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        
        
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        cmv.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
       
        cmv.setCmmntyId(strCmmntyId);
        cmv.setCmmntyMenuCode(strCmmntyMenuCode);

        if(userLoginVo != null){
            cmv.setCmmntyMberId(userLoginVo.getUserId());
            cmv.setUserId(userLoginVo.getUserId());
        }
        model.addAttribute("cmInfo",  cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv)); 
//        model.addAttribute(GlobalConfig.KEY_PAGER, cmUserPlanService.cmUserPlanCalList(vo)); 
    }
    
    /**
     * 커뮤니티 사용자 일정 게시판 달력 
     */
    @RequestMapping(value = "ND_cmUserPlanCalList.do")
    public String cmCalList(HttpServletRequest request, ModelMap model, CmUserPlanVO vo) {

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        vo.setCmmntyId(strCmmntyId);

     // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);

        Calendar cal = Calendar.getInstance();

        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
        }

        int a = cal.get(Calendar.YEAR);
        int b = vo.getStartYear();
        int c = cal.get(Calendar.MONTH);
        int d = vo.getStartMonth();

        // 현재 년도와 이동년도의 차이를 구해 세팅
        vo.setStartY(b - a);
        // 현재 년도와 이동달의 차이를 구해세팅
        vo.setStartM(d - c);

        return responseJson(model, cmUserPlanService.cmUserPlanCalList(vo));
    }
    
    /**
     * 커뮤니티 사용자 일정 등록/수정 폼 
     */
    @RequestMapping(value = {"BD_cmUserPlanForm.do","BD_cmUserPlanView.do"})
    public void cmUserPlanForm(HttpServletRequest request, ModelMap model,  CmUserPlanVO vo, CmManageVO cmv){
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmv, request);
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        cmv.setCmmntyMenuCode(strCmmntyMenuCode);
        
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        cmv.setLangCode(vo.getLangCode()); 
        cmv.setCmmntyId(strCmmntyId);
        vo.setCmmntyId(strCmmntyId);
        
        
        if(userLoginVo != null){
            cmv.setCmmntyMberId(userLoginVo.getUserId());
            vo.setRegistId(userLoginVo.getUserId());
        }
        
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv));  // 메뉴 기본정보
        model.addAttribute("cmUserPlanView", cmUserPlanService.cmUserPlanCalView(vo));  // 달력 상세 페이지
    }
    
    /**
     *  커뮤니티 사용자 일정관리 등록
     * 
     */
    @RequestMapping(value = "INC_cmUserPlanInsert.do")
    public String cmUserPlanInsert( HttpServletRequest request, ModelMap model, CmUserPlanVO vo) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
        }
        StrResult1 = cmUserPlanService.cmUserPlanCalInsert(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    /**
     *  커뮤니티 사용자 일정관리 수정
     * 
     */
    @RequestMapping(value = "INC_cmUserPlanUpdate.do")
    public String cmUserPlanUpdate( HttpServletRequest request, ModelMap model ,CmUserPlanVO vo ) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        

        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setUpdtId(userLoginVo.getUserId());
        }
        StrResult1 = cmUserPlanService.cmUserPlanCalUpdate(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    /**
     *  커뮤니티 사용자 일정관리 삭제
     * 
     */
    @RequestMapping(value = "INC_cmUserPlanDelete.do")
    public String cmUserPlanDelete( HttpServletRequest request, ModelMap model, CmUserPlanVO vo ) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
  
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setUpdtId(userLoginVo.getUserId());
        }
        StrResult1 = cmUserPlanService.cmUserPlanCalDelete(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
}
