/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMenu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
//import zes.core.spi.commons.configuration.Config;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.loginCheck.LoginCheckReturn;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
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
 * 2014. 11. 13.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/user/cmUserMenu")
public class CmUserMenuController extends WebController {

    @Autowired
    CmUserMenuService cmUserMenuService;
    
    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmManageService cmManageService;
    

    /**
        *   커뮤니티 사용자 사이드 메뉴
        * 
        */
       
       @RequestMapping(value = "INC_cmUserMenuLeft.do")
       public void cmUserMenuList(HttpServletRequest request, ModelMap model, CmManageVO vo ){
           
           OpHelper.bindSearchMap(vo, request);
           
           UserLoginVO userLoginVo = OpHelper.getUserSession(request);
           String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
           String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
           // 도메인코드
           String hostNm     = CmsUtil.getHostName(request.getServerName());
           String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
           
           vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
           
           vo.setCmmntyId(strCmmntyId);
           vo.setLangCode(vo.getLangCode());
           if(userLoginVo != null){
               vo.setCmmntyMberId(userLoginVo.getUserId());
           }
           model.addAttribute("cmmntyMenuCode",strCmmntyMenuCode); //메뉴 코드
           
           model.addAttribute("userBBS", cmUserMenuService.cmUserCmmntyBBSCount(vo)); 
           model.addAttribute("userCMT", cmUserMenuService.cmUserCmmntyBBSCmtCount(vo)); 
           
           model.addAttribute("cmInfoView", cmManageService.openCmManageView(vo)); // 기본정보
           model.addAttribute("cmUserMberInfo", cmUserMenuService.cmUserMberInfo(vo)); // 회원기본정보
           model.addAttribute("cmmntyId",strCmmntyId);
           model.addAttribute("cmUserMenuList", cmUserMenuService.cmUserMenuList(vo));
       }
       
       
       
       /**
        *   커뮤니티 가입 정보 팝업 
        * 
        */
       @RequestMapping(value = "PD_cmUserJoinInfoView.do")
       public void cmUserJoinInfoViewPopUp( HttpServletRequest request, ModelMap model, CmManageVO vo){
            
            OpHelper.bindSearchMap(vo, request);
            UserLoginVO userLoginVo = OpHelper.getUserSession(request);
            String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
            String strCmmntySbscrbMthd = request.getParameter("cmmntySbscrbMthd") != null ? request.getParameter("cmmntySbscrbMthd").toString() : "";
            String strMberStateCd = request.getParameter("mberStateCd") != null ? request.getParameter("mberStateCd").toString() : "";
            // 도메인코드
            String hostNm     = CmsUtil.getHostName(request.getServerName());
            String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
            
            vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
            //vo.setCmmntyId(strCmmntyId);
            //model.addAttribute("cmInfoView", cmManageService.openCmManageView(vo)); // 기본정보
            //vo.setCmmntyId(strCmmntyId);
            model.addAttribute("cmmntyId", strCmmntyId );   
            model.addAttribute("cmmntySbscrbMthd", strCmmntySbscrbMthd);   
            model.addAttribute("mberStateCd", strMberStateCd);   
            
            if(userLoginVo != null){
            vo.setUserId(userLoginVo.getUserId()); // 회원 아이디
            vo.setUserTyCd(userLoginVo.getUserTyCd());
            if("1003".equals(strMberStateCd) || "1004".equals(strMberStateCd)){
                vo.setCmmntyMberId(userLoginVo.getUserId());
                model.addAttribute("cmUserMberInfo", cmUserMenuService.cmUserMberInfo(vo)); // 회원기본정보
            }
            if("1003".equals(strMberStateCd) || "1000".equals(strMberStateCd)){
                model.addAttribute("userBBS", cmUserMenuService.cmUserCmmntyBBSCount(vo)); 
                model.addAttribute("userCMT", cmUserMenuService.cmUserCmmntyBBSCmtCount(vo)); 
                model.addAttribute("userVisitSelete", cmUserMenuService.cmUserCmmntyVisitLogSelete(vo)); 
                model.addAttribute("userVisitCount",cmUserMenuService.cmUserCmmntyVisitLogCount(vo));
            }
            model.addAttribute("userDefaultInfo", cmManageService.userInfoOptionSelect(vo)); // 사용자 기본 정보
            model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);   
           }
       }
       
       /**
        *  커뮤니티 닉네임 중복 체크
        * 
        */
       @RequestMapping(value = "INC_cmNcnmCheck.do" )
       public String getOpenCmManageCheck(HttpServletRequest request, CmManageVO vo, ModelMap model){

           // 도메인코드
           String hostNm     = CmsUtil.getHostName(request.getServerName());
           String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
           
           vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
           
           return responseText(model, cmManageService.getCmNcnmCheck(vo));
       }

       /**
          *  커뮤니티 회원 가입
          * 
          */
         @RequestMapping(value = "INC_cmMemberShipJoinInsert.do")
         public String cmMemberShipJoinInsert( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

             UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";     
             //String mmntySbscrbMthd
             String StrResult1 = ""; 
             
             // 도메인코드
             String hostNm     = CmsUtil.getHostName(request.getServerName());
             String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
             
             vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
             
             // 기본은 비공개로 설정 (N)
             if("".equals(vo.getIdOthbcAt()) || vo.getIdOthbcAt() ==null){
                 vo.setIdOthbcAt("Y");
             }
             if("".equals(vo.getNmOthbcAt()) || vo.getNmOthbcAt() == null){
                 vo.setNmOthbcAt("Y");
             }
             if("".equals(vo.getTelnoOthbcAt()) || vo.getTelnoOthbcAt() == null){
                 vo.setTelnoOthbcAt("Y");
             }
             if("".equals(vo.getMbtlnumOthbcAt()) || vo.getMbtlnumOthbcAt() == null){
                 vo.setMbtlnumOthbcAt("Y");
             }
             if("".equals(vo.getEmailOthbcAt()) || vo.getEmailOthbcAt() == null){
                 vo.setEmailOthbcAt("Y");
             }
             if("".equals(vo.getCmpnyNmOthbcAt()) || vo.getCmpnyNmOthbcAt() == null){
                 vo.setCmpnyNmOthbcAt("Y");
             }
             if("".equals(vo.getReprsntTelnoOthbcAt()) || vo.getReprsntTelnoOthbcAt() ==null){
                 vo.setReprsntTelnoOthbcAt("Y");
             }
             if("".equals(vo.getCmpnyEmailOthbcAt()) || vo.getCmpnyEmailOthbcAt() ==null){
                 vo.setCmpnyEmailOthbcAt("Y");
             }
            
             if(userLoginVo != null){
                String cmmntySbscrbMthd =  vo.getCmmntySbscrbMthd();
                 vo.setCmmntyId(strCmmntyId);
                 vo.setCmmntyMberId(userLoginVo.getUserId());
                 if("1".equals(cmmntySbscrbMthd)){
                     vo.setMberStateCd(1003);
                 }else{
                     vo.setMberStateCd(1001);
                 }
             }
             
             StrResult1 = cmManageService.cmMemberShipJoinInsert(request, vo); // 커뮤니티 회원가입
             
             if("Y".equals(StrResult1)){
                 return responseText(model, Messages.TRUE );
             }else{
                 return responseText(model,Messages.FALSE );
             }
             
         }
         
         /**
          *  커뮤니티 회원 재가입
          * 
          */
         @RequestMapping(value = "INC_cmMemberShipJoinUpdate.do")
         public String cmMemberShipJoinUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) {

             UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";     
             String strMberStateCd  = request.getParameter("mberStateCd") != null ? request.getParameter("mberStateCd").toString() : "";  
             String StrResult1 = ""; 
             
             // 도메인코드
             String hostNm     = CmsUtil.getHostName(request.getServerName());
             String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
             
             vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
             
             // 기본은 비공개로 설정 (N)
             if("".equals(vo.getIdOthbcAt()) || vo.getIdOthbcAt() ==null){
                 vo.setIdOthbcAt("Y");
             }
             if("".equals(vo.getNmOthbcAt()) || vo.getNmOthbcAt() == null){
                 vo.setNmOthbcAt("Y");
             }
             if("".equals(vo.getTelnoOthbcAt()) || vo.getTelnoOthbcAt() == null){
                 vo.setTelnoOthbcAt("Y");
             }
             if("".equals(vo.getMbtlnumOthbcAt()) || vo.getMbtlnumOthbcAt() == null){
                 vo.setMbtlnumOthbcAt("Y");
             }
             if("".equals(vo.getEmailOthbcAt()) || vo.getEmailOthbcAt() == null){
                 vo.setEmailOthbcAt("Y");
             }
             if("".equals(vo.getCmpnyNmOthbcAt()) || vo.getCmpnyNmOthbcAt() == null){
                 vo.setCmpnyNmOthbcAt("Y");
             }
             if("".equals(vo.getReprsntTelnoOthbcAt()) || vo.getReprsntTelnoOthbcAt() ==null){
                 vo.setReprsntTelnoOthbcAt("Y");
             }
             if("".equals(vo.getCmpnyEmailOthbcAt()) || vo.getCmpnyEmailOthbcAt() ==null){
                 vo.setCmpnyEmailOthbcAt("Y");
             }
             
             if(userLoginVo != null){
                String cmmntySbscrbMthd =  vo.getCmmntySbscrbMthd();
                 vo.setCmmntyId(strCmmntyId);
                 vo.setCmmntyMberId(userLoginVo.getUserId());
                 if("1003".equals(strMberStateCd)){
                     vo.setCmmntySbscrbMthd("3"); // 가상으로 3으로 설정 // 회원 정보 수정 조건 사용
                 }else{
                     if("1".equals(cmmntySbscrbMthd)){
                         vo.setMberStateCd(1003);
                     }else if("2".equals(cmmntySbscrbMthd)){
                         vo.setMberStateCd(1001);
                     }
                 }
             }
             
             StrResult1 = cmManageService.cmMemberShipJoinUpdate(request, vo); // 커뮤니티 회원가입
             
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
          *  커뮤니티 회원 탈퇴
          * 
          */
         @RequestMapping(value = "INC_cmMemberShipSecedeUpdate.do")
         public String  cmMemberShipSecedeUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo)  {
             
             //String mberState =  request.getParameter("mberState") != null ? request.getParameter("mberState").toString() : "1004";
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
          * 로그인 체크
          */
         @RequestMapping(value = "ND_loginCheckURL.do") 
         public String goLoginUrl(HttpServletRequest request, ModelMap model){
             
             //String hostNm = CmsUtil.getHostName(request.getServerName());
             
             String returnUri = request.getParameter("nowURL") != null ? request.getParameter("nowURL") : "";
             String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
             String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode") : "";
             String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode") : "";
             String strCmmntyBbsSeq =  request.getParameter("cmmntyBbsSeq") != null ? request.getParameter("cmmntyBbsSeq") : "";
             String strSchdulSeq =  request.getParameter("schdulSeq") != null ? request.getParameter("schdulSeq").toString() : "";
             String returnUrl = returnUri.replaceAll("/WEB-INF/pages/","");
             returnUrl = returnUrl.replaceAll(".jsp",".do");
             /** 로그인 리다이렉트 체크 부분 **/
             //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             LoginCheckReturn loginchk = new LoginCheckReturn();
             //String rtnUrl = new CommonDutyConstant().getRedirectUrl(request);
             
//             if(rtnUrl.indexOf(Config.getString("url.mobileUrlPrefix")) > -1) {
//                 rtnUrl = "/" + hostNm + Config.getString("url.mobileUrlPrefix");  //모바일
//             } else {
//                 rtnUrl = "/" + hostNm + Config.getString("url.portalUrlPrefix");
//             }
             
             //String url =returnUrl+"?cmmntyId="+strCmmntyId+"&langCode="+strLangCode;
             String returnParam = "?cmmntyId="+strCmmntyId+"&cmmntyMenuCode="+strCmmntyMenuCode+"&langCode="+strLangCode+"&cmmntyBbsSeq="+strCmmntyBbsSeq+"&schdulSeq="+strSchdulSeq;
             String loginUrl = loginchk.LoginCheckRtn(request);
             loginUrl= loginUrl.replaceAll("cm", "pt");
             String message = MessageHelper.getMsg(request, "requiredLogin");
             return responseJson(model, true, loginUrl+"?returnUrl=/"+returnUrl+"&returnParam=" + returnParam, message);            
         }
         
         /**
          * 커뮤니티 사용자 작성 글 게시판 
          */
         @RequestMapping(value = "BD_cmUserWriteList.do")
         public void cmUserWriteList(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv ){
             
             OpHelper.bindSearchMap(vo, request);
             OpHelper.bindSearchMap(cmv, request);

             UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
             String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
             vo.setCmmntyMenuCode(strCmmntyMenuCode);
             
             // 도메인코드
             String hostNm     = CmsUtil.getHostName(request.getServerName());
             String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
            
             vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
            
             vo.setCmmntyId(strCmmntyId);
             cmv.setCmmntyId(strCmmntyId);
             cmv.setLangCode(vo.getLangCode());
             if(userLoginVo != null){
                vo.setRegistId(userLoginVo.getUserId());
            cmv.setCmmntyMberId(userLoginVo.getUserId());
             }

             model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
             model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
             
             model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv)); 
             model.addAttribute(GlobalConfig.KEY_PAGER, cmUserMenuService.cmUserWriteReplyList(vo)); 
         }
       
         /**
          * 커뮤니티 사용자 작성 댓글 게시판 
          */
         @RequestMapping(value = {"BD_cmUserWriteList.do","BD_cmUserReplyList.do"})
         public void cmUserReplyList(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv ){
             
             OpHelper.bindSearchMap(vo, request);
             OpHelper.bindSearchMap(cmv, request);

             UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
             String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
             vo.setCmmntyMenuCode(strCmmntyMenuCode);
             
             String strWriteReplyChk =request.getParameter("writeReplyChk") != null ? request.getParameter("writeReplyChk").toString() : ""; 
             
             // 도메인코드
             String hostNm     = CmsUtil.getHostName(request.getServerName());
             String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
            
             vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
            
             vo.setCmmntyId(strCmmntyId);
             cmv.setCmmntyId(strCmmntyId);
             cmv.setLangCode(vo.getLangCode());
             
             vo.setWriteReplyChk(strWriteReplyChk);
             
             if(userLoginVo != null){
                vo.setRegistId(userLoginVo.getUserId());
                cmv.setCmmntyMberId(userLoginVo.getUserId());
             }

             model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
             model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
             
             model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv)); 
             model.addAttribute(GlobalConfig.KEY_PAGER, cmUserMenuService.cmUserWriteReplyList(vo)); 
         }
 
         
         /**
          * 사용자 커뮤니티 방문 로그 저장
          */
         @RequestMapping(value = "ND_cmUserVisitLog.do")
         public void cmUserVisitLog(HttpServletRequest request, HttpSession session, CmManageVO vo) {
             
             UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
             String strVisitIp =  request.getParameter("visitIp") != null ? request.getParameter("visitIp") : "";
       
             // 도메인코드
             String hostNm     = CmsUtil.getHostName(request.getServerName());
             String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
             
             if(userLoginVo != null ){
                 
                 vo.setVisitSesionId(session.getId());
                 vo.setCmmntyId(strCmmntyId);
                 
                 vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

                 vo.setVisitIp(strVisitIp);
                 vo.setUserId(userLoginVo.getUserId());
                 cmUserMenuService.cmUserVsitLogInsert(vo);
             }
          
         }
         
         /**
          * 사용자  커뮤니티별페이지로그분석통계 저장
          */
         @RequestMapping(value = "ND_cmPageTracking.do")
         public void cmUserPageTracking(HttpServletRequest request, HttpSession session, CmManageVO vo) {
             
             UserLoginVO userLoginVo = OpHelper.getUserSession(request);
             String strCmmntyId = request.getParameter("anlzCmmntyId") != null ? request.getParameter("anlzCmmntyId").toString() : "";
             //String strVisitIp =  request.getParameter("visitIp") != null ? request.getParameter("visitIp") : "";
       
             setCmUserTrackingValues(vo,request,session);
             // 도메인코드
             String hostNm     = CmsUtil.getHostName(request.getServerName());
             String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
             
             if(userLoginVo != null ){
                 
                 //vo.setVisitSesionId(session.getId());
                 vo.setCmmntyId(strCmmntyId);
                 
                 vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

                 //vo.setVisitIp(strVisitIp);
                 vo.setUserId(userLoginVo.getUserId());
                 cmUserMenuService.cmUserPgeAnalInsert(vo);
             }
          /**
           *    #{conectSesionId} 
                        , #{userId} 
                        , #{langCode} 
                        , #{cmmntyId} 
                        , SYSDATETIME
                        , #{conectIp} 
                        , SUBSTR(#{conectUrl}, 1, 4000)
                        , #{pgeTitle} 
                        , #{pgeRdcnt} 
           */
         }
         
        private void setCmUserTrackingValues(CmManageVO vo, HttpServletRequest request, HttpSession session) {
             vo.setConectSesionId(session.getId());
             vo.setConectIp(request.getRemoteAddr());
         }
}
