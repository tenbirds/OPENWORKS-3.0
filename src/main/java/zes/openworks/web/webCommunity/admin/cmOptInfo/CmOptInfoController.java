/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptInfo;

import java.awt.image.BufferedImage;
import java.io.IOException;
//import java.util.Calendar;
import java.util.List;

import javax.imageio.ImageIO;
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
 * 2014. 10. 30.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/admin/cmOptInfo")
public class CmOptInfoController extends WebController {
    
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
    

    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }
    
    /**
     * 포털 커뮤니티 정보 상세
     * @return 
     */
    @RequestMapping(value = "BD_index.do")
    public String index(HttpServletRequest request, ModelMap model, CmManageVO vo, CmManageBoardVO cmbvo, CodeVO cvo){
        
        //referer 체크
        if(requestRefererChk(request)){
            return alertAndRedirect(model, "직접접근이 불가능한 페이지 입니다.", "");
        }
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmbvo, request);
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setUserId(userLoginVo.getUserId()); // cmson36
        //vo.setCmmntyId("openson36"); 
        vo.setCmmntyId(strCmmntyId);
        
       // cvo.setLangCode("");// 언어코드 모두 가져오기 위해  NULL 처리
       // model.addAttribute("langCodeList",codeService.getLangCodeList(cvo));// 언어코드 가져오기 
        
       //CmManageVO cmmanagevo = cmManageService.cmMemberShipInfoView(vo); // 커뮤니티 사용자 정보
        
        /* {{ 2016.05.09 BH.YANG 일반 사용자들의 커뮤티니 관리자모드 URL접근 차단 로직 추가 */
        CmManageVO dataVo1 = cmManageService.CmOptMainInfo(vo); // 커뮤니티 개설자 아이디
        String AdminId = dataVo1.getEstblReqstId();
        String LoginId = userLoginVo.getUserId();
       
        if(!LoginId.equals(AdminId)){
            return alertAndBack(model,"접근권한이 없습니다.");
         }
        /* }} */
        
        model.addAttribute("userEntrprsOption", cmManageService.userEntrprsOptionSelect(vo)); // 기업회원 추가 정보 // 2001    기업회원     2002    기업판매회원
        model.addAttribute("userOption", cmManageService.userOptionSelect(vo)); // 일반회원 추가 정보 //  1001 개인회원     1002 개인판매회원 
        model.addAttribute("cmUserView", cmManageService.openCmManageView(vo)); // 기본정보
        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        
        
        return requestUrl(request) + "/BD_index";
    }
    
    
    /**
     *  커뮤니티  수정 적용  , 커뮤니티 폐쇄 신청
     * @throws Exception 
     * 
     */
    @RequestMapping(value = {"INC_cmOptInfoUpdate.do","INC_closeCmOptInfoUpdate.do"})
    public String  cmOptInfoUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo) throws Exception {
        
        String applyClose =  request.getParameter("applyClose") != null ? request.getParameter("applyClose").toString() : "";
        
        String StrResult1 = ""; 
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setUserId(userLoginVo.getUserId()); 
        vo.setUpdtId(userLoginVo.getUserId());
        
        if("Y".equals(applyClose)){
            StrResult1 = cmOptInfoService.cmOptInfoUpdate(request, vo); // 커뮤니티 승인 정보 수정
        }else if("N".equals(applyClose)){
            StrResult1 = cmOptInfoService.closeCmOptInfoUpdate(request, vo) ; // 커뮤니티폐쇄 신청
        }else if("C".equals(applyClose)){
            StrResult1 = cmOptInfoService.closeCancleCmOptInfoUpdate(request, vo) ; // 커뮤니티폐쇄 취소  
        }
      
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    } 
    
    /**
     * 포털 커뮤니티 폐쇄
     */
    @RequestMapping(value = {"BD_closeIndex.do","BD_cancleIndex.do"}) 
    public void closeIndex(HttpServletRequest request, ModelMap model, CmManageVO vo, CmManageBoardVO cmbvo, CodeVO cvo){
        
        OpHelper.bindSearchMap(vo, request);
        OpHelper.bindSearchMap(cmbvo, request);
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setUserId(userLoginVo.getUserId()); // cmson36
        vo.setCmmntyId(strCmmntyId);
        
        
        model.addAttribute("cmUserView", cmManageService.openCmManageView(vo)); // 기본정보
        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        
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
        
        Float maxWidthSize = (float)Integer.parseInt(request.getParameter("maxWidthSize").isEmpty() != true ? request.getParameter("maxWidthSize") : "0");
        Float maxHeightSize = (float)Integer.parseInt(request.getParameter("maxHeightSize").isEmpty() != true ? request.getParameter("maxHeightSize") : "0");
        
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
                    
                    if(fileExtPermit.indexOf(fileType) == -1) {
                        result = 201; //허용하지 않는 파일유형(확장자)
                        break;
                    }
                    
                    Long fileSize = fileVo.getSize();
                    
                    if(maxFileSize > 0 && fileSize > maxFileSize) {                    
                        result = 200; //파일 제한용량초가
                        break;
                    }else{  
                        if(maxWidthSize > 0 || maxHeightSize > 0) { //가로나 세로 제한값이 있을 때
                            try {
                                //BufferedImage bi = ImageIO.read(new File(GlobalConfig.WEBAPP_ROOT + fileVo.getFileUrl()));
                                BufferedImage bi = ImageIO.read(fileVo.getInputStream());
                                
                                Float imgW = (float)bi.getWidth();
                                Float imgH = (float)bi.getHeight();
                                
                                if(maxWidthSize > 0 && (maxWidthSize+10) < imgW) { //가로제한 값이 있고 제한값보다 클때
                                   result = 301; //가로크기가 제한크기보다 클때  
                                }
                                
                                if(maxHeightSize > 0 && (maxHeightSize+10) < imgH) { //세로제한 값이 있고 제한값보다 클 때
                                   result = 302; //세로크기가 제한크기보다 클때                                
                                }
                                
                               // Float ratioValue1 = (float) (maxWidthSize / maxHeightSize);
                               // Float ratioValue2 = (float) (imgW / imgH);
                                
//                                //(maxWidthSize > 0 && maxHeightSize > 0 ) && !ratioValue1.equals(ratioValue2)
//                                if((maxWidthSize > 0 && maxHeightSize > 0 ) && (((ratioValue1-ratioValue2) > 0.05) || ((ratioValue2-ratioValue1) > 0.05))) {
//                                    result = 303; // 가로/세로 비율이 맞지 않음   
//                                }
                                
                            }catch (IOException e) {
                                if(logger.isDebugEnabled()) {
                                    logger.debug("file check failed : ", e);
                                }
                                
                                result = 400; // 400 : 이미지 사이즈 확인 오류발생
                                break;
                            }
                        }
                    }//End for
                }//End if
            }
        }else{
            result = 500; // 500 : 업로드된 파일이나 최대용량 파라미터 값이 없을때           
        }
        
        switch (result) {
            case 100:
                 message = "100";
                 break;
            case 200: 
                 message = "파일의 용량이 "+ (request.getParameter("maxFileSize") != null ? FileUtil.toDisplaySize(request.getParameter("maxFileSize")) : "0") +"KB를 초과하였습니다.";
                 break;
            case 201:
                message = "이미지 파일의 유형(확장자)은 jpg, png 파일만 가능합니다.";
                break;     
            case 301:
                 message = "이미지의 가로크기가 "+ maxWidthSize +" 보다 큽니다."; 
                 break;
            case 302:
                 message = "이미지의 세로크기가 "+ maxHeightSize +" 보다 큽니다."; 
                 break;
//            case 303:
//                 message = "이미지의 비율이 맞지 않습니다."; 
//                 break;
            case 400:
                 message = "파일을 확인하는데 문제가 발생하였습니다.\n파일을 다시 선택하여 주시기 바랍니다.";
                 break;
            default:
                 message = "이미지가 확인되지 않았습니다.";
                 break;
                    
        }
        
        return responseText(model, message);       
        
    }

}
