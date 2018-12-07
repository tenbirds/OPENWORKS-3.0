/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptBoardMenu;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
//import zes.base.support.OpHelper;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
//import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;
//import zes.openworks.web.login.UserLoginVO;


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
 * 2014. 11. 5.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/admin/cmOptBoardMenu")
public class CmOptBoardMenuController extends WebController {
    
    @Autowired
    CmOptBoardMenuService cmOptBoardMenuService;
    
    @Autowired
    CommonDutyService commonDutyService;
    
    @Autowired
    CmManageService cmManageService;
    
    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }
    
    
    /**
     * 메뉴관리 메인
     * @return 
     */
    @RequestMapping(value = "BD_index.do")
    public String index(HttpServletRequest request, ModelMap model,CmManageVO vo) {
        
        //referer 체크
        if(requestRefererChk(request)){
            return alertAndRedirect(model, "직접접근이 불가능한 페이지 입니다.", "");
        }
        
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        OpHelper.bindSearchMap(vo, request);
        
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";

     // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
//        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        model.addAttribute("cmmntyId", strCmmntyId );
        model.addAttribute("langCode", commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        
        /* {{ 2016.05.09 BH.YANG 일반 사용자들의 커뮤티니 관리자모드 URL접근 차단 로직 추가 */
        vo.setCmmntyId(strCmmntyId);
        CmManageVO dataVo1 = cmManageService.CmOptMainInfo(vo); // 커뮤니티 개설자 아이디
        String AdminId = dataVo1.getEstblReqstId();
        String LoginId = userLoginVo.getUserId(); // 로그인 아이디
        
        if(!LoginId.equals(AdminId)){
            return alertAndBack(model,"접근권한이 없습니다.");
         }
        /* }} */
        return requestUrl(request) + "/BD_index";
    }
    
    /**
     * 메뉴관리 목록 for TreeList
     */
    @RequestMapping(value = "INC_cmOptBoardMenuTreeList.do", method = RequestMethod.POST)
    public String cmOptBoardMenuTreeList(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model) {
        
        //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        
        return responseJson(model, cmOptBoardMenuService.cmOptBoardMenuTreeList(vo) );
    }
    
    /**
     * 커뮤니티 사용자 메뉴 상세 
     */
    @RequestMapping(value = "INC_cmOptBoardMenuTreeView.do", method = RequestMethod.POST)
    public void cmOptBoardMenuTreeView(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model){
        
//        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";

        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        vo.setCmmntyId(strCmmntyId);
        
        model.addAttribute(GlobalConfig.KEY_DATA_VO, cmOptBoardMenuService.cmOptBoardMenuTreeView(vo) );

    }
    
    
    /**
     * 커뮤니티 사용자 메뉴 등록 폼
     */
    @RequestMapping(value = "INC_cmOptBoardMenuTreeForm.do")
    public void IcmOptBoardMenuTreeForm(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model){
        
//        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";

        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));

        vo.setCmmntyId(strCmmntyId);
        model.addAttribute("cmmntyId", strCmmntyId );
    }
    
    /**
     * 커뮤니티 사용자 메뉴 수정
     */
    @RequestMapping(value = "ND_cmOptBoardMenuUpdate.do", method = RequestMethod.POST)
    public String cmOptBoardMenuUpdate(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model) {
        
        //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
        int intResult1 = 0; 

        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        
       intResult1 = cmOptBoardMenuService.cmOptBoardMenuUpdate(vo); 
       if(intResult1 == StringUtil.ONE){
           return responseText(model, Messages.TRUE );
       }else{
           return responseText(model,Messages.FALSE );
       }
    }
    
    /**
     * 커뮤니티 사용자 메뉴 등록
     */
    @RequestMapping(value = "ND_cmOptBoardMenuInsert.do", method = RequestMethod.POST)
    public String cmOptBoardMenuInsert(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model) {
        
        //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
        String strResult = ""; 

        // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        
        strResult = cmOptBoardMenuService.cmOptBoardMenuInsert(vo); 
        if("Y".equals(strResult)){
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "insertOk"));
        }else{
            return responseJson(model, Messages.FALSE, MessageHelper.getMsg(request, "processFail"));
        }
    }
    
    /**
     * 새 정렬 정보 수정
     */
    @RequestMapping(value = "ND_cmOptBoardMenuMoveUpdate.do", method = RequestMethod.POST)
    public String cmOptBoardMenuMoveUpdate(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model) {
        
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";

    // 도메인코드
       String hostNm     = CmsUtil.getHostName(request.getServerName());
       String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
       
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
         vo.setCmmntyId(strCmmntyId);
  
        int affected = cmOptBoardMenuService.cmOptBoardMenuSortOrdrUpdate(vo);
        if(affected == StringUtil.ONE) {
            return responseText(model, Messages.TRUE);
        }else  if(affected == 2){
            return responseText(model, "");
        }
        return responseText(model, Messages.FALSE);
    }
    
    /**
     * 
     */
    @RequestMapping(value = "ND_cmOptBoardMenuDelete.do", method = RequestMethod.POST)
    public String cmOptBoardMenuDelete(HttpServletRequest request, CmOptBoardMenuVO vo, ModelMap model) {
        
        //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
     // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
         vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        
        String affected = cmOptBoardMenuService.cmOptBoardMenuDelete(vo);
        if("Y".equals(affected)) {
            return responseJson(model, Messages.TRUE, MessageHelper.getMsg(request, "deleteOk"));
        }else{
            return responseJson(model, Messages.FALSE, MessageHelper.getMsg(request, "processFail"));
        }
    }
    
}
