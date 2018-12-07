/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmSiteStat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
//import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.web.common.CommonDutyConstant;
import zes.openworks.web.common.CommonDutyService;
//import zes.openworks.web.login.UserLoginVO;
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
 * 2014. 12. 16.    		 boseok       	신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/cm/admin/cmSiteStat")
public class CmSiteStatController  extends WebController {

    @Autowired
    CmSiteStatService cmSiteStatService;
    
    @Autowired
    CmManageService cmManageService;
    @Autowired
    CommonDutyService commonDutyService;
    
    public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }
    
    /**
     * 커뮤니티 통계 index
     * @return 
     */
    @RequestMapping(value = "BD_index.do")
    public String cmSiteStatIndex(HttpServletRequest request, ModelMap model, CmManageVO vo) {
        
        //referer 체크
        if(requestRefererChk(request)){
            return alertAndRedirect(model, "직접접근이 불가능한 페이지 입니다.", "");
        }
        
        /* {{ 2016.05.09 BH.YANG 일반 사용자들의 커뮤티니 관리자모드 URL접근 차단 로직 추가 */
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        OpHelper.bindSearchMap(vo, request);
        String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
        vo.setCmmntyId(strCmmntyId);
        
        CmManageVO dataVo1 = cmManageService.CmOptMainInfo(vo); // 커뮤니티 개설자 아이디
        String AdminId = dataVo1.getEstblReqstId();
        String LoginId = userLoginVo.getUserId(); //로그인 아이디
        
        if(!LoginId.equals(AdminId)){
            return alertAndBack(model,"접근권한이 없습니다.");
         }
        /* }} */
        return requestUrl(request) + "/BD_index";
    }
    
    /**
     * 커뮤니티 통계
     */
    @RequestMapping(value = "INC_cmSiteStatView.do")
    public void cmSiteStatView(HttpServletRequest request, ModelMap model, CmSiteStatVO vo, CmManageVO cmvo) {
        
        //UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        
        String strCmmntyId = request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId").toString() : "";
        
     // 도메인코드
        String hostNm     = CmsUtil.getHostName(request.getServerName());
        String domainCode = new CommonDutyConstant().getDomainCode(hostNm);
        
        vo.setLangCode(commonDutyService.getLangCd(Integer.parseInt(domainCode)));
        vo.setCmmntyId(strCmmntyId);
        cmvo.setCmmntyId(strCmmntyId);
        cmvo.setLangCode(vo.getLangCode());
        ResultVO dataVo1 = cmSiteStatService.cmSiteVisitCountStat(vo); // 방문자수
        ResultVO dataVo2 = cmSiteStatService.cmSiteBoardCountStat(vo); // 게시글수
        ResultVO dataVo3 = cmSiteStatService.cmSiteBoardCmtCountStat(vo); // 덧글수
        
        ResultVO dataVo4 = cmSiteStatService.cmSitePageViewCountStat(vo); // 페이지뷰
        
        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        
        model.addAttribute("VisitCount", dataVo1);
        model.addAttribute("BoardCount", dataVo2);
        model.addAttribute("CmtCount", dataVo3);
        model.addAttribute("PageViewCount", dataVo4);
        
        model.addAttribute("cmUserView", cmManageService.openCmManageView(cmvo)); // 기본정보
    }
    
}
