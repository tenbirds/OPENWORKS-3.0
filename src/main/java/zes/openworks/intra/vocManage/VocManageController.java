/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.vocManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.core.utils.MakeExcel;
import zes.core.utils.StringUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.orderManage.cntrctManage.CntrctManageVO;
import zes.openworks.intra.vocManage.VocManageVO;


/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2017. 10. 23.   이준범   신규
*</pre>
* @see
*/
@Controller
@RequestMapping(value = "/intra/vocManage")
public class VocManageController extends IntraController {
    /*관리자페이지 - voc관리 */
    @Autowired VocManageService service;
    @Autowired CodeService codeService;
    /**
     * voc 목록
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "BD_vocBoard.list.do", method = RequestMethod.GET)
    public void vocList(HttpServletRequest request, ModelMap model, VocManageVO vo) {
        /* voc 목록 가져오기 */
        model.addAttribute("vocList", service.vocManageList(vo));
    }
    
    /**
     * voc 상세보기
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "BD_vocBoard.view.do", method = RequestMethod.GET)
    public void vocDetail(HttpServletRequest request, ModelMap model, VocManageVO vo) {
        /* voc 상세보기 */
        String seq = request.getParameter("vocBbscttSn");
        model.addAttribute("vocView", service.vocManageView(vo));
    }
    
    /**
     * voc 등록하기
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.GENERALIZE)
    @RequestMapping(value = "BD_vocBoard.form.do", method = RequestMethod.GET)
    public void vocInsert(HttpServletRequest request, ModelMap model, VocManageVO vo) {
        /* voc 상세보기 */
        String testvalue1 = request.getParameter("testvalue1");
        System.out.println("testvalue1 : "+testvalue1);
        
        // 등록시 가져올게 없으면 삭제
        model.addAttribute("vocView", service.vocManageView(vo));
    }
    
    /**
     * 게시물 등록 폼 & (domainCd, bbsCd, bbscttSeq=null, refrnSeq=null)
     * 답글 등록 폼 & (domainCd, bbsCd, refrnSeq, bbscttSeq)
     * 게시물 수정 폼 (domainCd, bbsCd, bbscttSeq, refrnSeq=null)
     * 게시물 등록 당사자나 관리자만 가능하다.
     */
    @AuthIntra(authType = AuthType.BASIC, authParams = { "domainCd", "bbsCd" })
    @RequestMapping(value = { "BD_board.insert.form.do", "BD_board.update.form.do", "BD_board.reply.form.do" })
    public String insertForm(ModelMap model, HttpServletRequest request, @ModelAttribute BoardVO boardVO, @RequestParam(value = "pageType", required = true) String pageType) throws Exception {
        
        return "1";
        //setBoardService(request, "F"); // 게시판 유형 서비스 설정
    }
    
    /**
     * voc 목록 삭제하기
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @AuthIntra(authType = AuthType.BASIC)
    @RequestMapping(value = "ND_vocDelete.do", method = RequestMethod.POST)
    public String vocDelete(ModelMap model, VocManageVO vo) {
        // 삭제로직 추가
        // service.vocDelete(vo);
        System.out.print("ddd");
        return responseText(model, Messages.TRUE);

    }
    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_insttStatsList.do", method = RequestMethod.GET)
    public void insttStatsList(HttpServletRequest request, ModelMap model, VocManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);

    }
    
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_typeStatsList.do", method = RequestMethod.GET)
    public void typeStatsList(HttpServletRequest request, ModelMap model, VocManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);

    }
}
