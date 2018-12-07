/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc.
 */
package zes.openworks.web.wiki;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.loginCheck.LoginCheckReturn;
import zes.openworks.common.transmit.sender.email.AutoMailService;
import zes.openworks.common.transmit.sender.sms.SmsTransHistService;
import zes.openworks.common.util.message.MessageHelper;
import zes.openworks.intra.cmMgmt.cmManage.CmManageService;
import zes.openworks.intra.code.CodeService;
import zes.openworks.web.common.CommonDutyService;
import zes.openworks.web.login.UserLoginVO;

/**
 *
 * @Class Name : WikiController
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 * @Description : 씨앗마켓 위키 공통 Controller
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       	      수정자   	         수정내용
 *--------------    ----------    -------------------------------
 * 2016. 01. 04.    (주)엔키소프트      신규
 * @see
 */


@Controller
@RequestMapping(value = "**/pt/wiki")
public class WikiController extends WebController {

	@Autowired
	WikiService wikiService;

	@Autowired
	CmManageService cmManageService;

	@Autowired
	CodeService codeService;

	@Autowired
	CommonDutyService commonDutyService;

	@Autowired
	SmsTransHistService smsService;
	@Autowired
	AutoMailService amservice;

    /**
     * wikiIndex (위키 대문 호출)
     * @return korean/pt/wiki/BD_index
     */
	@RequestMapping(value = "/BD_index.do")
	public void  wikiIndex (HttpServletRequest request, ModelMap model){

        // 호출할 위키 순번
        String p_wikiSn = request.getParameter("p_wikiSn");

        // 위키순번이 null 일 경우 보정
        if(p_wikiSn == null){
            p_wikiSn = "";
        }

        //최신 등록 위키 상세 조회
        Map searchMap = new HashMap();
        searchMap.put("p_wikiSn", p_wikiSn);
        model.addAttribute("wikiWiew", wikiService.wikiView(searchMap));
	}

    /**
     * wikiWrite (위키 등록/수정 화면 호출)
     * @return korean/pt/wiki/BD_write
     */
    @RequestMapping(value = "/BD_write.do")
    public String  wikiWrite (HttpServletRequest request, ModelMap model){

        String p_procDiv = request.getParameter("p_procDiv");

        //로그인이 안되어 있으면 로그인 화면으로 가기(등록 화면시에만 적용 되도록 되어 있음)
        UserLoginVO userLoginVo = OpHelper.getUserSession(request);
        LoginCheckReturn loginchk = new LoginCheckReturn();
        //String hostNm = CmsUtil.getHostName(request.getServerName());

        if(userLoginVo == null) {

            String loginUrl = loginchk.LoginCheckRtn(request);
            String returnUrl="/korean/pt/wiki/BD_write.do";
            String message = MessageHelper.getMsg(request, "requiredLogin");
            String returnParam = "p_procDiv="+p_procDiv;
            return alertAndRedirect(model, message, loginUrl+"?returnUrl="+returnUrl+"&returnParam="+returnParam);
        }

        // 수정일 경우 기존 본문내용 가져가기
        if(p_procDiv.equals("U")){
            //최신 등록 위키 상세 조회
            Map searchMap = new HashMap();
            searchMap.put("p_wikiSn", "");
            model.addAttribute("wikiWiew", wikiService.wikiView(searchMap));
        }

        model.addAttribute("p_procDiv", p_procDiv); // 등록/수정 구분값(I:등록/U:수정)

        return "/korean/pt/wiki/BD_write";
    }


    /**
     * wikiRegist (위키 등록/수정 처리)
     * @return korean/pt/wiki/BD_regist
     */
    @RequestMapping(value = "/BD_regist.do")
    public String  wikiRegist (HttpServletRequest request, ModelMap model){

        // 화면 전달 파라미터
        String p_wikiCn  = request.getParameter("p_wikiCn");  //등록 내용
        String p_procDiv = request.getParameter("p_procDiv"); //처리구분
        String p_wikiSn  = request.getParameter("p_wikiSn");  //처리할 위키순번[수정일 경우]
        String p_userId  = request.getParameter("p_userId");  //되돌리기할 wiki 순번

        // 처리 파리미터 바인딩
        Map procMap = new HashMap();
        procMap.put("p_wikiCn",  p_wikiCn);   //등록 내용
        procMap.put("p_procDiv", p_procDiv);  //처리구분
        procMap.put("p_wikiSn",  p_wikiSn);   //처리할 위키순번[수정일 경우]
        procMap.put("p_userId",  p_userId);   //되돌리기할 wiki 순번

        // 위키 내용 등록 처리
        wikiService.wikiRegist(procMap);

        // 결과값 반환
        String message = new String(); //retrun 메시지
        message = "정상적으로 처리되었습니다.";

        return responseText(model, message);
    }

    /**
     * wikiPreview (위키 미리보기)
     * @param request
     * @param model
     */
    @RequestMapping(value = {"/BD_wikiPreview.do"})
    public String wikiPreview(HttpServletRequest request, ModelMap model) {

        return "/korean/pt/wiki/BD_wikiPreview";
    }


    /**
     * 위키 항목 작성이력 조회
     * @return korean/pt/wiki/BD_history
     */
    @RequestMapping(value = "/BD_history.do")
    public ModelMap  wikiHistory (HttpServletRequest request, ModelMap model, WikiVO wikiVO){
        //최신 등록 위키 상세 조회
        Pager<WikiVO> pager = null;
        pager = wikiService.wikiHistoryList(wikiVO);
        model.addAttribute(GlobalConfig.KEY_PAGER, pager);

        return model;
    }

    /**
     * 위키 되돌리기 처리
     * @return korean/pt/wiki/BD_undoContents
     */
    @RequestMapping(value = "/BD_undoContents.do")
    public String  undoContents (HttpServletRequest request, ModelMap model){

        // 화면 전달 파라미터
        String p_userId = request.getParameter("p_userId"); //되돌리기 처리자 ID
        String p_wikiSn = request.getParameter("p_wikiSn"); //되돌리기할 wiki 순번

        // 되돌리기 처리
        Map procMap = new HashMap();
        procMap.put("p_userId", p_userId);
        procMap.put("p_wikiSn", p_wikiSn);

        int result = wikiService.wikiUndoContents(procMap);

        // 결과값 반환
        String message = new String(); //retrun 메시지
        message = "정상적으로 처리되었습니다.";

        return responseText(model, message);
    }


}
