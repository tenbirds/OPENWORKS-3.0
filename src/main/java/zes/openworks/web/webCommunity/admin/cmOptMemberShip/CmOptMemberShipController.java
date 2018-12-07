/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptMemberShip;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

//import zes.base.auth.AuthType;
//import zes.base.auth.anotation.AuthIntra;
import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService;
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
 * 2014. 11. 3.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/admin/cmOptMemberShip")
public class CmOptMemberShipController extends WebController {
    
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
     * 커뮤니티 회원 현황 조회
     * @return 
     */
    @RequestMapping(value = "BD_index.do")
    public String cmOptMemberShipList(HttpServletRequest request, ModelMap model, CmManageVO vo, CodeVO cvo){
        
        //referer 체크
        if(requestRefererChk(request)){
            return alertAndRedirect(model, "직접접근이 불가능한 페이지 입니다.", "");
        }
        
        OpHelper.bindSearchMap(vo, request);
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        
        String strMberStateTab = request.getParameter("q_mberStateTab") != null ? request.getParameter("q_mberStateTab").toString() : "1001";

        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setUserId(userLoginVo.getUserId()); // cmson36
        vo.setCmmntyId(strCmmntyId);
        
        
        /* {{ 2016.05.09 일반 사용자들의 커뮤티니 관리자모드 URL접근 차단 로직 추가 */
        CmManageVO dataVo1 = cmManageService.CmOptMainInfo(vo); // 커뮤니티 개설자 아이디
        String AdminId = dataVo1.getEstblReqstId();
        String LoginId = userLoginVo.getUserId();
        
        if(!LoginId.equals(AdminId)){
            return alertAndBack(model,"접근권한이 없습니다.");
         }
        /* }} */
        
        model.addAttribute("mberStateTab", strMberStateTab);
        model.addAttribute("openCmUserView", cmManageService.openCmManageView(vo)); // 기본정보
        model.addAttribute(GlobalConfig.KEY_PAGER, cmManageService.cmMberInfoList(vo));
        
        return requestUrl(request) + "/BD_index";
    }
    
    
    /**
     *   커뮤니티 회원 정보 조회 팝업 (PD_cmOptMemberShipView.do) 
     * 
     */
    @RequestMapping(value = "PD_cmOptMemberShipView.do")
    public void cmMemberShipInfoViewPopUp( HttpServletRequest request, ModelMap model, CmManageVO vo){
         
         OpHelper.bindSearchMap(vo, request);

//         String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
//         String strLangCode = request.getParameter("langCode") != null ? request.getParameter("langCode").toString() : "00";
//         String strCmmntyMberId = request.getParameter("cmmntyMberId") != null ? request.getParameter("cmmntyMberId").toString() : "";
//         String strMberStateCd = request.getParameter("mberStateCd") != null ? request.getParameter("mberStateCd").toString() : "";

         
         vo.setUserId(vo.getCmmntyMberId()); // 회원 아이디
         
         model.addAttribute("userEntrprsOption", cmManageService.userEntrprsOptionSelect(vo)); // 기업회원 추가 정보 // 2001    기업회원     2002    기업판매회원
         model.addAttribute("userOption", cmManageService.userOptionSelect(vo)); // 일반회원 추가 정보 //  1001 개인회원     1002 개인판매회원 
         
         model.addAttribute("cmOptMemberShipInfoView", cmManageService.cmMemberShipInfoView(vo)); // 기본회원정보
         model.addAttribute("userDefaultInfo", cmManageService.userInfoOptionSelect(vo)); // 사용자 기본 정보
         model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
         
    }
    
    /**
     *  커뮤니티 가입 승인, 가입 거절 , 강제 탈퇴
     * 
     */
    @RequestMapping(value = "INC_cmOptMemberShipInfoUpdate.do")
    public String  cmOptMemberShipInfoUpdate( HttpServletRequest request, ModelMap model ,CmManageVO vo)  {
        
        String mberState =  request.getParameter("mberState") != null ? request.getParameter("mberState").toString() : "1001";
        
        String StrResult1 = ""; 
        
        
         UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        vo.setUpdtId(userLoginVo.getUserId());
        //커뮤니티회원강제탈퇴 : >>1001:운영자강제탈퇴        1002:관리자강제탈퇴
        // 커뮤니티회원상태 :>>>1001:가입중        1002:가입거절       1003:정상     1004:탈퇴
        vo.setMberStateCd(Integer.parseInt(mberState));
        if("1003".equals(mberState)){
            StrResult1 = cmManageService.cmMemberShipInfoUpdate(request, vo); // 1003:정상 
        }else if("1002".equals(mberState)){
            StrResult1 = cmManageService.cmMemberShipInfoUpdate(request, vo); // 1002:가입거절 
        }else if("1004".equals(mberState)){
            vo.setEnfrcSecsnCd(1001); // 강제탈퇴코드 1001:운영자강제탈퇴    1002:관리자강제탈퇴
            StrResult1 = cmManageService.cmMemberShipInfoUpdate(request, vo); // 1004:탈퇴 
        }
        if("Y".equals(StrResult1)){
            return responseText(model, Messages.TRUE );
        }else{
            return responseText(model,Messages.FALSE );
        }
        
    } 

}
