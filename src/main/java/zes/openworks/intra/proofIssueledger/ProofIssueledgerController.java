/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueledger;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2017. 1. 12.    방기배       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/proofIssueledger")
public class ProofIssueledgerController extends IntraController {
    @Autowired private ProofIssueledgerService service; 
    
    @Autowired private CodeService codeService; 
    /**
     * 실적증명발급 관리 Controller
     * @param request
     * @param model
     * @param vo
     */
    
    @RequestMapping(value = "BD_index.do")
    public String proofIssueledgerList(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) {
        
        OpHelper.bindSearchMap(vo, request,15);        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.poofIssueledgerList(vo, request.getParameter("q_searchVal")));
        
        
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2045);
        codeVO.setLangCode("00");
        codeVO.setUseYn("Y");

        model.addAttribute(GlobalConfig.KEY_CODE_LIST,  codeService.codeList(codeVO));

        return "/intra/proofIssueledger/BD_index";
    }
    
    /**
     * 실적증명발급 관리 증명서 발급 업데이트
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "BD_upDate.do", method = RequestMethod.POST)
    public String goodsCdUpdateAction(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) {
       
        OpHelper.bindSearchMap(vo, request);
        
        /* 선택된 데이터를 cntrctSnArray에 저정하고 그것을 q_cntrctSn에 배열로 저장 */
        String[] q_cntrctSn = vo.getCntrctSnArray().split(",");

        vo.getDataMap().put("q_certResultCode", vo.getCertResultCode());
        /* q_cntrctSn에 저장된 만큼 해당 cntrctSn로 업데이트 시작*/
        for(int i = 0; i < q_cntrctSn.length; i++){
         vo.getDataMap().put("q_cntrctSn", q_cntrctSn[i]);
         /* 업데이트 시작*/
         service.poofIssueledgerCodeUpdate(vo);
        }
        return responseJson(model, true);
    }  
    
}
