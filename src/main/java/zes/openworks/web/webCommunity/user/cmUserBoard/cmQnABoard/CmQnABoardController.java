/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserBoard.cmQnABoard;

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
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
import zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService;
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
 * 2014. 11. 25.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/user/cmUserBoard/cmQnABoard")
public class CmQnABoardController extends WebController {
    
    @Autowired
    CmUserBoardService cmUserBoardService;
    
    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmUserMenuService cmUserMenuService;
    
    @Autowired
    CmManageService cmManageService;

    
    /**
     * 커뮤니티 사용자 QnA 게시판 
     */
    @RequestMapping(value = "BD_cmQnABoardList.do")
    public void cmUserQnABoardList(HttpServletRequest request, ModelMap model, CmManageBoardVO vo , CmManageVO cmv){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmv, request);
        
        CmManageVO cmmanageVO = new CmManageVO();
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strOptUserId = "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        int intWriteChk = 0;
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        cmv.setCmmntyMenuCode(strCmmntyMenuCode);
        
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
       
        vo.setCmmntyId(strCmmntyId);
        cmv.setCmmntyId(strCmmntyId);
        cmv.setLangCode(vo.getLangCode());
        cmmanageVO = cmManageService.openCmManageView(cmv);
        if(cmmanageVO !=null){
            
            strOptUserId = cmmanageVO.getUserId();
        }
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setOthbcSetupCdChk("2"); //1001 전체공개 1002 멤버공개 1003 작성자만 체크 벨류
           cmv.setCmmntyMberId(userLoginVo.getUserId());
           intWriteChk = cmUserBoardService.cmUserWriteBoardListCount(vo); 
           if(intWriteChk > 0){
               vo.setOthbcSetupCdChk("3");
           }
           if(strOptUserId.equals(userLoginVo.getUserId())){ // 운영자는 모든 리스트 볼수 있음. 1003 QnA만 해당.
               vo.setOthbcSetupCdChk("4"); // 검색조건에서 빠짐.. 모든 내용 출력
           }
        }else{
            vo.setOthbcSetupCdChk("1");
        }
        model.addAttribute("cmInfo", cmmanageVO); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv)); 
        model.addAttribute(GlobalConfig.KEY_PAGER, cmUserBoardService.cmUserBoardList(vo)); 
    }
    
    /**
     * 커뮤니티 사용자 QnA 게시판 상세
     */
    @RequestMapping( value = {"BD_cmQnABoardView.do", "BD_cmQnABoardAnsWerView.do" } )
    public void cmUserQnABoardView(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv){
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
           vo.setRegistId(userLoginVo.getUserId());
           cmv.setCmmntyMberId(userLoginVo.getUserId());
        }
        
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv));  // 메뉴 기본정보
        model.addAttribute("userBoardView", cmUserBoardService.cmUserBoardView(vo)); 
    }
    
    /**
     * 커뮤니티 사용자 QnA 등록 폼 
     */
    @RequestMapping(value = "BD_cmQnABoardForm.do")
    public void cmUserQnABoardForm(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv){
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
       
        cmv.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
       
        cmv.setCmmntyId(strCmmntyId);
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(cmv.getLangCode());
        
        if(userLoginVo != null){
            cmv.setCmmntyMberId(userLoginVo.getUserId());
            vo.setRegistId(userLoginVo.getUserId());
        }
        
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv));  // 메뉴 기본정보
        model.addAttribute("userBoardView", cmUserBoardService.cmUserBoardView(vo)); 
    }
    /**
     *  커뮤니티 사용자 QnA 게시판 등록
     * 
     */
    @RequestMapping(value = "INC_cmQnABoardInsert.do")
    public String cmUserQnABoardInsert( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);
  
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
        }
        //vo.setCmmntyBbsTyCd();  /* 게시판 타입 1001:기본형      1002:FAQ형       1003:갤러리형       1004:답변형 */
        StrResult1 = cmUserBoardService.cmUserBoardInsert(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    /**
     *  커뮤니티 사용자 QnA 게시판 수정
     * 
     */
    @RequestMapping(value = "INC_cmQnABoardUpdate.do")
    public String cmUserQnABoardUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);
  
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setUpdtId(userLoginVo.getUserId());
        }
        //vo.setCmmntyBbsTyCd();  /* 게시판 타입 1001:기본형      1002:FAQ형       1003:갤러리형       1004:답변형 */
        StrResult1 = cmUserBoardService.cmUserBoardUpdate(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    /**
     *  커뮤니티 사용자 QnA 답변 등록
     * 
     */
    @RequestMapping(value = "INC_cmQnABoardAnswerUpdate.do")
    public String cmUserQnABoardAnswerUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strDelAnswer = request.getParameter("delAnswer") != null ? request.getParameter("delAnswer").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);
  
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setAnswerId(userLoginVo.getUserId());
        }
        if("N".equals(strDelAnswer)){ // 답변 삭제시 업데이트
            
            vo.setAnswerId("");
            vo.setAnswerCn("");
        }
        //vo.setCmmntyBbsTyCd();  /* 게시판 타입 1001:기본형      1002:FAQ형       1003:갤러리형       1004:답변형 */
        StrResult1 = cmUserBoardService.cmUserBoardAnswerUpdate(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    /**
     *  커뮤니티 사용자 QnA 게시판 삭제
     * 
     */
    @RequestMapping(value = "INC_cmQnABoardDelete.do")
    public String cmUserQnABoardDelete( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);
  
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(vo.getLangCode());
        vo.setWrterDeleteAt("Y"); //  작성자 및 운영자 삭제 Y
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           vo.setUpdtId(userLoginVo.getUserId());
        }
        //vo.setCmmntyBbsTyCd();  /* 게시판 타입 1001:기본형      1002:FAQ형       1003:갤러리형       1004:답변형 */
        StrResult1 = cmUserBoardService.cmUserBoardDelUpdate(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    /**
     * 커뮤니티 사용자 파일  삭제
     */
    @RequestMapping(value = "ND_fileDelete.do")
    public String fileDelete(HttpServletRequest request, ModelMap model ,CmManageBoardVO vo){

        UserLoginVO loginVo = OpHelper.getUserSession(request);
        
        String StrResult1 = ""; 
    
    // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        if(loginVo !=null){
            vo.setUpdtId(loginVo.getUserId());
        }
        StrResult1 = cmUserBoardService.fileDelUpdate(request, vo);
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model, Messages.FALSE );
        }
        
    }
}
