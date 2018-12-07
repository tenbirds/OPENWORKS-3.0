/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserBoard.cmPhotoBoard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import zes.base.support.OpHelper;
import zes.core.utils.FileUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
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
 * 2014. 11. 26.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/user/cmUserBoard/cmPhotoBoard")
public class CmPhotoBoardController extends WebController {
    
    @Autowired
    CmUserBoardService cmUserBoardService;
    
    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmUserMenuService cmUserMenuService;
    
    @Autowired
    CmManageService cmManageService;
    
    /**
     * 커뮤니티 사용자 사진 게시판 
     */
    @RequestMapping(value = "BD_cmPhotoBoardList.do")
    public void cmUserPicBoardList(HttpServletRequest request, ModelMap model, CmManageBoardVO vo , CmManageVO cmv){
        
        OpHelper.bindSearchMap(vo, request, 8); // 갤러리는 8개
        OpHelper.bindSearchMap(cmv, request);
        
        CmManageVO cmmanageVO = new CmManageVO();
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strOptUserId = "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
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
           vo.setOthbcSetupCdChk("2"); //1001 전체공개 1002 멤버공개 1003 작성자만 체크 벨류 운영자일 때는 검색조건 빠진다 4
           cmv.setCmmntyMberId(userLoginVo.getUserId());
           
           if(strOptUserId.equals(userLoginVo.getUserId())){ // 운영자는 모든 리스트 볼수 있음. 
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
     * 커뮤니티 사용자 사진 게시판 상세
     */
    @RequestMapping(value = "BD_cmPhotoBoardView.do")
    public void cmUserPhotoBoardView(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv){
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
     * 커뮤니티 사용자 사진 등록 폼 
     */
    @RequestMapping(value = "BD_cmPhotoBoardForm.do")
    public void cmUserPhotoBoardForm(HttpServletRequest request, ModelMap model, CmManageBoardVO vo, CmManageVO cmv){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmv, request);
        
//        CmManageBoardVO cmMVO = new CmManageBoardVO();
        
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
     *  커뮤니티 사용자 사진 게시판 등록
     * 
     */
    @RequestMapping(value = "INC_cmPhotoBoardInsert.do")
    public String cmUserPhotoBoardInsert( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

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
     *  커뮤니티 사용자 사진 게시판 수정
     * 
     */
    @RequestMapping(value = "INC_cmPhotoBoardUpdate.do")
    public String cmUserPhotoBoardUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

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
     *  커뮤니티 사용자 사진 게시판 삭제
     * 
     */
    @RequestMapping(value = "INC_cmPhotoBoardDelete.do")
    public String cmUserPhotoBoardDelete( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo, CmManageVO cmv) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        String strCmmntyMenuCode = request.getParameter("cmmntyMenuCode") != null ? request.getParameter("cmmntyMenuCode").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        String strNoticeBbscttAt = vo.getNoticeBbscttAt() !=  null ? vo.getNoticeBbscttAt() : "N";
        
        vo.setNoticeBbscttAt(strNoticeBbscttAt);
  
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
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
     * 커뮤니티 사용자 사진 댓글 게시판 
     */
    @RequestMapping(value = "INC_cmPhotoBoardCMT.do")
    public void cmPhotoBoardCMTList(HttpServletRequest request, ModelMap model, CmManageBoardVO vo , CmManageVO cmv){
        
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
       
        vo.setCmmntyId(strCmmntyId);
        cmv.setCmmntyId(strCmmntyId);
        cmv.setLangCode(vo.getLangCode());
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           cmv.setCmmntyMberId(userLoginVo.getUserId());
        }
        model.addAttribute("cmInfo", cmManageService.openCmManageView(cmv)); // 기본정보
        model.addAttribute("cmMberInfo", cmUserMenuService.cmUserMberInfo(cmv)); // 회원기본정보
        model.addAttribute(GlobalConfig.KEY_PAGER, cmUserBoardService.cmUserBoardCmtList(vo)); 
    }
    
    /**
     *  커뮤니티 사용자 사진 게시판 댓글 등록
     * 
     */
    @RequestMapping(value = "INC_cmPhotoBoardCMTInsert.do")
    public String cmPhotoBoardCMTInsert( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //String strBbsCmt = request.getParameter("bbsCmt") != null ? request.getParameter("bbsCmt").toString() : "";
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           StrResult1 = cmUserBoardService.cmUserBoardCmtInsert(request, vo); 
           
           if("Y".equals(StrResult1)){
                return responseJson(model, Messages.TRUE, "", MessageHelper.getMsg(request, "insertOk"));
           }else{
                return responseJson(model, Messages.FALSE, "", MessageHelper.getMsg(request, "processFail"));
           }
        }else{
            return responseJson(model, Messages.FALSE, "notLogin" ,MessageHelper.getMsg(request, "processFail"));
        }
    }
    /**
     * 커뮤니티 사용자 사진 게시판 댓글 수정폼
     * return true/false
     */
    @RequestMapping(value = "INC_cmPhotoBoardCMTForm.do")
    public String cmPhotoBoardCMTForm(ModelMap model, HttpServletRequest request, CmManageBoardVO vo) throws Exception {

//        //HTML제거
//        dataVO.setNttCmtCn(Converter.cleanHtml(dataVO.getNttCmtCn()));

        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);

        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
        }
        
        CmManageBoardVO  cmbvo = cmUserBoardService.cmUserBoardCmtView(vo);
        return responseJson(model, Messages.TRUE, cmbvo, MessageHelper.getMsg(request, "processFail"));
    }
    /**
     *  커뮤니티 사용자 기본 게시판 댓글 수정
     * 
     */
    @RequestMapping(value = "INC_cmPhotoBoardCMTUpdate.do")
    public String cmPhotoBoardCMTUpdate( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //String strBbsCmt = request.getParameter("bbsCmt") != null ? request.getParameter("bbsCmt").toString() : "";
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        if(userLoginVo != null){
           //vo.setRegistId(userLoginVo.getUserId());
           vo.setUpdtId(userLoginVo.getUserId());
           StrResult1 = cmUserBoardService.cmUserBoardCmtUpdate(request, vo); 
           
           if("Y".equals(StrResult1)){
                return responseJson(model, Messages.TRUE, "",MessageHelper.getMsg(request, "updateOk"));
           }else{
                return responseJson(model, Messages.FALSE, "", MessageHelper.getMsg(request, "processFail"));
           }
        }else{
            return responseJson(model, Messages.FALSE, "notLogin" ,MessageHelper.getMsg(request, "processFail"));
        }
    }
    
    /**
     *  커뮤니티 사용자 기본 게시판 댓글 삭제
     * 
     */
    @RequestMapping(value = "INC_cmPhotoBoardCMTDelete.do")
    public String cmPhotoBoardCMTDelete( HttpServletRequest request, ModelMap model ,CmManageBoardVO vo) {

        String StrResult1 = ""; 
   
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        //String strBbsCmt = request.getParameter("bbsCmt") != null ? request.getParameter("bbsCmt").toString() : "";
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        if(userLoginVo != null){
           vo.setRegistId(userLoginVo.getUserId());
           StrResult1 = cmUserBoardService.cmUserBoardCmtReplyDelete(request, vo); 
           
           if("Y".equals(StrResult1)){
                return responseJson(model, Messages.TRUE, "", MessageHelper.getMsg(request, "deleteOk"));
           }else{
                return responseJson(model, Messages.FALSE, "", MessageHelper.getMsg(request, "processFail"));
           }
        }else{
            return responseJson(model, Messages.FALSE, "notLogin" ,MessageHelper.getMsg(request, "processFail"));
        }
    }
    
    /**
     * 커뮤니티 사용자 개별 파일  삭제
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
        StrResult1 = cmUserBoardService.fileEachDelUpdate(request, vo);
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model, Messages.FALSE );
        }
        
    }
    
    /**
     * 업로드 이미지 픽셀 및 크기 체크
     */
    @RequestMapping(value = "ND_uploadImgChk.do", method = RequestMethod.POST)
    public String uploadIMGCheck(HttpServletRequest request, ModelMap model){
        String inputName = request.getParameter("inputName");
        String fileExtPermit = request.getParameter("fileExt");
        //킬로바이트(kilobyte)로 넘어온 값을1024를 곱해서 byte 단위로 만들어준다. 
        long maxFileSize = (long) (Integer.parseInt(request.getParameter("maxFileSize").isEmpty() != true ? request.getParameter("maxFileSize") : "0")*1024); 
        
        //Float maxWidthSize = (float)Integer.parseInt(request.getParameter("maxWidthSize").isEmpty() != true ? request.getParameter("maxWidthSize") : "0");
        //Float maxHeightSize = (float)Integer.parseInt(request.getParameter("maxHeightSize").isEmpty() != true ? request.getParameter("maxHeightSize") : "0");
        
        int result = 100;   // 100 : 패스
        String message = new String(); //retrun 메시지
        
        // 이미지 파일 체크
        @SuppressWarnings("unchecked")
        List<MultipartFile> files = (List<MultipartFile>) request.getAttribute(GlobalConfig.FILE_LIST_KEY);
        if(files != null && !request.getParameter("maxFileSize").isEmpty()) {
            for(int i=0; i < files.size(); i++){
                MultipartFile fileVo = files.get(i);
                if(fileVo.getName().equals(inputName)) {
                    
                    String fileType = FileUtil.extension(fileVo.getOriginalFilename());
                    
                    if(fileExtPermit.indexOf(fileType.toLowerCase()) == -1) {
                        result = 201; //허용하지 않는 파일유형(확장자)
                        break;
                    }
                    
                    Long fileSize = fileVo.getSize();
                    
                    if(maxFileSize > 0 && fileSize > maxFileSize) {                    
                        result = 200; //파일 제한용량초가
                        break;
                    }
                }//End if
            } // End for
        }else{
            result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때           
        }
        
        switch (result) {
            case 100:
                 message = "100";
                 break;
            case 200: 
                 message = "200";
                 break;
            case 201:
                message = "파일의 유형(확장자)은 "+fileExtPermit+" 파일만 가능합니다.";
                break;     
            default:
                 message = "파일이 확인되지 않았습니다.";
                 break;
        }
        
        return responseText(model, message);       
        
    }
}
