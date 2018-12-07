/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.masub;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.web.login.UserLoginVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *		 <pre>
 * << 개정이력(Modification Information) >>
 *
 *	 수정일			   수정자						 수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 13.	 홍길동	 JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = { "/**/masub" })
public class MasterSubController extends WebController {

	@Autowired
	private MasterSubService masterSubService;

	public String requestUrl(HttpServletRequest request) {
        String responseUrl = request.getRequestURI();
        return responseUrl.substring(0, responseUrl.lastIndexOf("/"));
    }

    public String serverNm(HttpServletRequest request) {

        /* 이전소스
         * String serverNm = request.getServerName();       
        return "/" + serverNm.substring(0, serverNm.indexOf("."));*/
      //{{  2015.11.23, 도메인관리삭제로 인한 소스변경
      //변경소스
        String serverNm = "korean";
       return "/" + serverNm ;
      //}}
    }
    
	/**
     * 마스터/서브관리 의견공유 리스트
     */
    @RequestMapping(value = "BD_subBoardList.do")
    public String subBoardList(HttpServletRequest request, ModelMap model, MasterSubVO vo) {
        //변경소스
        String hostNm = "korean";
        // 로그인 회원 체크
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_subBoardList.do"; 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
            vo.setMasterId(userLoginVO.getMasterId());
        }
       
        // 판매하기 권한 체크 20170111
        if(!ORDER_AUTH_CODE.contains(userLoginVO.getUserTyCd())) {
            return alertAndRedirect(model, MessageHelper.getMsg(request, "noCeartAuth1"), "/korean/pt/index.do" );          
        }        
        
        int rpp = 20;
        if(Validate.isNotEmpty(vo.getQ_rowPerPage())) {
            rpp = vo.getQ_rowPerPage();
        }

        OpHelper.bindSearchMap(vo, request, rpp);

        model.addAttribute(GlobalConfig.KEY_PAGER, masterSubService.subBoardList(vo));
        return requestUrl(request) + "/BD_subBoardList";
    }
    

    /**
     * 마스터/서브관리 의견공유 상세
     */
    @RequestMapping(value = "BD_subBoardForm.do")
    public String subBoardForm(HttpServletRequest request, ModelMap model, MasterSubVO vo) {
        String hostNm = "korean";
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        // 로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_subBoardAction.do"; 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
            vo.setMasterId(userLoginVO.getMasterId());
        }
        if(vo.getMasubNum() != null){
            vo.setMasterId(userLoginVO.getMasterId());
            model.addAttribute("cotent", masterSubService.subBoardDetail(vo));
            model.addAttribute("reply", masterSubService.subBoardReplyDetail(vo));
        }
        return requestUrl(request) + "/BD_subBoardForm";
    }
    
    /**
     * 마스터/서브관리 등록
     */
    @RequestMapping(value = "BD_subBoardAction.do")
    public String subBoardAction(HttpServletRequest request, ModelMap model, MasterSubVO vo) {
        String hostNm = "korean";
        UserLoginVO userLoginVO = OpHelper.getUserSession(request);
        // 로그인 회원 체크
        if(Validate.isEmpty(userLoginVO)) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_subBoardAction.do"; 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "userLoginCheck"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }else{
            vo.setMasterId(userLoginVO.getMasterId());
        }
        
        if(vo.getStatus().equals("d")||vo.getStatus().equals("u")){
            if(!vo.getWriteUserId().equals(userLoginVO.getUserId())){
                return responseText(model, "본인이 작성한 게시글만 수정/삭제할 수 있습니다");
            }
            
            if(vo.getReplyCnt()>0){
                return responseText(model, "댓글이 있는 게시글은 수정/삭제할 수 없습니다");
            } 
        }else if(vo.getStatus().equals("r_d")||vo.getStatus().equals("r_u")){
            if(!vo.getReplyUserId().equals(userLoginVO.getUserId())){
                return responseText(model, "본인이 작성한 댓글만 수정/삭제할 수 있습니다");
            }
        }
        
        vo.setMasterId(userLoginVO.getMasterId());
        vo.setUserId(userLoginVO.getUserId());
        
        int result  = masterSubService.subBoardAction(vo, request);
        
        if (result != StringUtil.ONE) {
            String returnUrl = "?returnUrl=" + requestUrl(request) + "/BD_subBoardForm.do"; 
            return alertAndRedirect(model, MessageHelper.getMsg(request, "등록에 실패했습니다"),"/" + hostNm + "/pt/login/user/BD_index.do" + returnUrl);
        }
        return responseText(model, Messages.TRUE);
    }
    
}