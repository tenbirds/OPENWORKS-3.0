/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManageBoard;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.login.LoginVO;
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
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/cmMgmt/cmManageBoard")
public class CmManageBoardController extends IntraController{

    
    @Autowired
    CmManageBoardService cmManageBoardService;
    
    
    @Autowired
    CmManageService cmManageService;
    
    @Autowired
    CodeService codeService;
    
    @Autowired
    CmUserBoardService cmUserBoardService;
    
    @Autowired
    CmUserMenuService cmUserMenuService;
    
    /**
     * 커뮤니티 게시물 관리
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        
        
        model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageBoardService.cmManageBoardList(vo));
        
    }
    
    
    /**
     * 커뮤니티 게시판 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "PD_cmManageBBSList.do")
    public void cmManageBoardListPopUp(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmvo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmvo, request);
        
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        String strCmmntyBbsTyCd = request.getParameter("cmmntyBbsTyCd") != null ? request.getParameter("cmmntyBbsTyCd").toString() : "0";
        
        //vo.setCmmntyBbsTyCd(Integer.parseInt(strCmmntyBbsTyCd));
        cmvo.setLangCode(vo.getLangCode());
        cmvo.setCmmntyId(vo.getCmmntyId());
        //cmvo.setCmmntyMenuCode("2002");
        
        model.addAttribute("cmmntyMenuCode", strCmmntyMenuCode); // 메뉴 코드
        model.addAttribute("cmmntyBbsTyCd", Integer.parseInt(strCmmntyBbsTyCd)); // 게시판 타입   1001 기본형  1002 FAQ형  1003 갤러리형   1004 답변형
        model.addAttribute("cmMberMenuSelect",cmManageBoardService.cmMberMenuSelect(cmvo));// 선택게시판
        
        model.addAttribute("openCmManageView", cmManageService.openCmManageView(cmvo)); // 기본정보
        
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageBoardService.cmManageBBSList(vo));
        
    }
    
    /**
     * 커뮤니티 사용자 기본 게시판 상세
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = {"PD_cmManageBBSView.do","PD_cmManageBBSForm.do"})
    public void cmUserBasicBoardView(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmv, request);
        
        //cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId, cmmntyBbsTyCd
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        String strRegisId = request.getParameter("registId") != null ? request.getParameter("registId").toString() : "";
        String strCmmntyBbsTyCd =  request.getParameter("cmmntyBbsTyCd") != null ? request.getParameter("cmmntyBbsTyCd").toString() : "";
        int intMaxFileCnt = 1; 
        
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        cmv.setCmmntyMenuCode(strCmmntyMenuCode);
        
        cmv.setLangCode(vo.getLangCode());
        cmv.setCmmntyId(strCmmntyId);
        cmv.setCmmntyMberId(strRegisId);
        vo.setLangCode(strLangCode);
        vo.setCmmntyId(strCmmntyId);
        vo.setRegistId(strRegisId);
        if("1003".equals(strCmmntyBbsTyCd)){
            
            intMaxFileCnt = 5;
        }
        model.addAttribute("maxFileCnt", intMaxFileCnt); // 파일 카운트
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        
        model.addAttribute("cmUserMenuView", cmUserMenuService.cmUserMenuView(cmv));  // 메뉴 기본정보
        model.addAttribute("userBoardView", cmUserBoardService.cmUserBoardView(vo)); 
    }
    
    /**
     *  커뮤니티 관리 관리자 게시판 등록
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_cmManageBBSInsert.do")
    public String cmManageBBSInsert( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        String StrResult1 = ""; 
   
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);

        vo.setCmmntyId(strCmmntyId);
        //vo.setLangCode(vo.getLangCode());
        vo.setRegistId(loginVo.getMngrId());
        vo.setWrterNcnm("총괄 관리자");
        //vo.setCmmntyBbsTyCd();  /* 게시판 타입 1001:기본형      1002:FAQ형       1003:갤러리형       1004:답변형 */
        StrResult1 = cmUserBoardService.cmUserBoardInsert(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    
    /**
     *  커뮤니티 관리자 게시판 수정
     * 
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_cmManageBBSUpdate.do")
    public String cmManageBBSUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);

        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(strLangCode);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());
        vo.setCmmntyMenuCode(strCmmntyMenuCode);  
        StrResult1 = cmUserBoardService.cmUserBoardUpdate(request, vo); 
   
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    }
    /**
     *  커뮤니티 관리자 다중 일반 삭제
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_cmManageBBSDelUpdate.do")
    public String openCmManageDelUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        //String confirm =  request.getParameter("confirm") != null ? request.getParameter("confirm").toString() : "";
        
        String StrResult1 = ""; 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());
        vo.setMngrDeleteAt("Y");
        
        StrResult1 = cmManageBoardService.cmManageBBSDelUpdate(request, vo); //  게시물 삭제
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
    }
    
    /**
     *  커뮤니티 관리자 일반 삭제
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_cmManageBBSDelUpt.do")
    public String openCmManageDelUpt( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        //String confirm =  request.getParameter("confirm") != null ? request.getParameter("confirm").toString() : "";
        
        String StrResult1 = ""; 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        
        vo.setUpdtId(loginVo.getMngrId());
        vo.setCmtDeleteCd(1003);
        vo.setMngrDeleteAt("Y");
        vo.setCmmntyId(strCmmntyId);
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        vo.setLangCode(strLangCode);
        StrResult1 = cmUserBoardService.cmUserBoardDelUpdate(request, vo); //  게시물 삭제
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
    }
    
    
    /**
     *  커뮤니티 관리자 완전 삭제
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmManageBBSDelete.do")
    public String openCmManageDelete( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        //String confirm =  request.getParameter("confirm") != null ? request.getParameter("confirm").toString() : "";
        
        String StrResult1 = ""; 
        
        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        vo.setUpdtId(loginVo.getMngrId());

        StrResult1 = cmManageBoardService.cmManageBBSDelete(request, vo); //  게시물 완전 삭제
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
    }
    
    /**
     * 커뮤니티 사용자 파일  삭제
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_fileDelete.do")
    public String fileDelete(HttpServletRequest request, ModelMap model ,CmManageBoardVO vo){

        LoginVO loginVo = OpHelper.getMgrSession(request);
        
        String StrResult1 = ""; 
        
        vo.setUpdtId(loginVo.getMngrId());
        StrResult1 = cmUserBoardService.fileEachDelUpdate(request, vo);
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model, Messages.FALSE );
        }
        
    }
    
    /**
     *커뮤니티 게시물 관리 기본 댓글 게시판 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmManageBBSCMT.do")
    public void cmManageBBSCMTList(HttpServletRequest request, ModelMap model, CmManageBoardVO vo , CmManageVO cmv){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmv, request);
        LoginVO loginVo = OpHelper.getMgrSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        vo.setLangCode(strLangCode);
        vo.setCmmntyId(strCmmntyId);
        vo.setRegistId(loginVo.getMngrId());
        cmv.setCmmntyId(strCmmntyId);
        cmv.setLangCode(strLangCode);
        cmv.setCmmntyMenuCode(strCmmntyMenuCode);
        cmv.setCmmntyMberId(loginVo.getMngrId());
        
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        model.addAttribute(GlobalConfig.KEY_PAGER, cmUserBoardService.cmUserBoardCmtList(vo)); 
    }
    
    /**
     *  커뮤니티 게시물 관리 기본 게시판 댓글 등록
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmManageBBSCMTInsert.do")
    public String cmManageBBSCMTInsert( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        LoginVO loginVo = OpHelper.getMgrSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(strLangCode);
        vo.setRegistId(loginVo.getMngrId());
        vo.setWrterNcnm("총괄 관리자");
        StrResult1 = cmUserBoardService.cmUserBoardCmtInsert(request, vo); 
       
        if("Y".equals(StrResult1)){
            return responseJson(model, Messages.TRUE, "", Messages.COMMON_INSERT_OK);
        }else{
            return responseJson(model, Messages.FALSE, "", Messages.COMMON_PROCESS_FAIL);
       }
    }
    
    /**
     * 커뮤니티 게시물 관리 기본 게시판 댓글 수정폼
     * return true/false
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmManageBBSCMTForm.do")
    public String cmManageBBSCMTForm(ModelMap model, HttpServletRequest request, CmManageBoardVO vo) throws Exception {

        LoginVO loginVo = OpHelper.getMgrSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        
        vo.setCmmntyId(strCmmntyId);
        vo.setLangCode(strLangCode);
        vo.setRegistId(loginVo.getMngrId());
        
        CmManageBoardVO  cmbvo = cmUserBoardService.cmUserBoardCmtView(vo);
        return responseJson(model, Messages.TRUE, cmbvo, Messages.COMMON_PROCESS_FAIL);
    }
    
    /**
     *  커뮤니티 게시물 관리 기본 게시판 댓글 수정
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmManageBBSCMTUpdate.do")
    public String cmManageBBSCMTUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        String StrResult1 = ""; 
   
        LoginVO loginVo = OpHelper.getMgrSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";

        vo.setLangCode(strLangCode);
        vo.setCmmntyId(strCmmntyId);
        vo.setRegistId(loginVo.getMngrId());
        vo.setUpdtId(loginVo.getMngrId());
        StrResult1 = cmUserBoardService.cmUserBoardCmtUpdate(request, vo); 
           
       if("Y".equals(StrResult1)){
        return responseJson(model, Messages.TRUE, "", Messages.COMMON_UPDATE_OK);
       }else{
        return responseJson(model, Messages.FALSE, "", Messages.COMMON_PROCESS_FAIL);
       }
     
    }
    
    /**
     *  커뮤니티 게시물 관리 기본 게시판 댓글 삭제
     * 
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "INC_cmManageBBSCMTDelete.do")
    public String cmManageBBSCMTDelete( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        String StrResult1 = ""; 
   
        LoginVO loginVo = OpHelper.getMgrSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
        
        vo.setLangCode(strLangCode);
        vo.setCmmntyId(strCmmntyId);
        vo.setRegistId(loginVo.getMngrId());
        StrResult1 = cmUserBoardService.cmUserBoardCmtReplyDelete(request, vo); 
           
        if("Y".equals(StrResult1)){
            return responseJson(model, Messages.TRUE, "", Messages.COMMON_DELETE_OK);
        }else{
            return responseJson(model, Messages.FALSE, "", Messages.COMMON_PROCESS_FAIL);
        }
   
    }
    
}
