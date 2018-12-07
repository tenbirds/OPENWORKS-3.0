/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.proofIssueapply;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.component.file.FileService;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.proofIssueledger.ProofIssueledgerVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-3.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 1. 12.    이홍석       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/proofIssueapply")
public class ProofIssueapplyController extends IntraController{
    
    /** 파일 저장 경로 */
    public static final String PROOF_ISSUE_FILE = "proofIssueFile" + File.separator;

    
    @Autowired private ProofIssueapplyService service;
    /*
    @Autowired private RegisterService registerService; 
    @Autowired AutoMailService amservice;
    */
    //@Autowired SmsTransHistService smsService;
    @Autowired private CodeService codeService;
    
    @Autowired
    FileService fileService;
    
    /*
     * 이용실적증명서 발급 조회(BD_certifApplyList)
     * */
    @RequestMapping(value = "/BD_index.do")
    public void proofIssueApplyList(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) {
        
        OpHelper.bindSearchMap(vo, request,15);
        HashMap dataMap = new HashMap();
        
        vo.getDataMap().put("issuSttus", request.getParameter("issuSttus"));
        vo.getDataMap().put("q_searchVal", request.getParameter("q_searchVal"));
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.proofIssueapplyList(vo));

        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2045);
        codeVO.setLangCode("00");
        codeVO.setUseYn("Y");
        codeVO.setIssuSttus(request.getParameter("issuSttus"));
        
        model.addAttribute(GlobalConfig.KEY_CODE_LIST,  codeService.codeList(codeVO));

        //return "/intra/proofIssueapply/BD_index";
    }
    
    /**
     * 이용실적증명서 승인/반려 목록
     * proofIssueList 설명
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/BD_suppList.do")
    public void proofIssueList(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) {
        OpHelper.bindSearchMap(vo, request,15);
        
        vo.getDataMap().put("issuSttus", request.getParameter("issuSttus"));
        vo.getDataMap().put("q_searchVal", request.getParameter("q_searchVal"));
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.proofIssueapplyList(vo));
                
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2045);
        codeVO.setLangCode("00");
        codeVO.setUseYn("Y");
        codeVO.setIssuSttus(request.getParameter("issuSttus"));
        
        model.addAttribute(GlobalConfig.KEY_CODE_LIST,  codeService.codeList(codeVO));
    }
    
    /**
     * 이용실적증명서 신청 승인 목록
     * proofIssueServiceList 설명
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_reportList.do", method = RequestMethod.POST)
    public String proofIssueServiceList(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) {
        OpHelper.bindSearchMap(vo, request);
        
        String[] reqItemMap = request.getParameterValues("item[]");
        String reqSessionId = request.getParameter("sessionId");
        int reqItemMapCnt = reqItemMap.length;
        
        vo.getDataMap().put("itemList", reqItemMap);
        
        List<ProofIssueledgerVO> proofIssueReportList = service.proofIssueReportList(vo);
        vo.getDataMap().put("dataList", proofIssueReportList);
        //model.addAttribute("dataList", proofIssueReportList);
        
        return responseJson(model, vo);
    }
    
    /**
     * 이용실적증명서 신청 승인 서비스 상세 목록
     * proofServiceReportList 설명
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_serviceReportList.do")
    public void proofServiceReportList(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) 
    {
        OpHelper.bindSearchMap(vo, request);
        
        String[] reqItemMap = request.getParameter("item").split(",");  // 실제로 한개만 나온다.

        vo.getDataMap().put("itemList", reqItemMap);        
        
        model.addAttribute("proofIssueapply", service.proofIssueapply(vo));        
        
        
        List<ProofIssueledgerVO> proofIssueReportList = service.proofIssueReportList(vo);
        vo.getDataMap().put("dataList", proofIssueReportList);
        
        model.addAttribute("proofIssueReportList", proofIssueReportList);
    }    
    
    /**
     * 이용실적 증명서 출력부분을 HTML로 변경- 최성민추가
     * serviceReportWrite 설명
     * @param request
     * @param model
     * @param vo
     */
    @RequestMapping(value = "/BD_serviceReportWrite2.do")
    public void serviceReportWrite(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo) 
    {
        OpHelper.bindSearchMap(vo, request);
        
        String strRousn = request.getParameter("rousn");
        vo.setRouSn(Integer.parseInt(strRousn));        
        vo.setStrRouSn(strRousn);
        model.addAttribute("proofIssueapply", service.proofIssueapply2(vo));        
        
        
        model.addAttribute("proofIssueapply3", service.proofIssueapply3(vo));
        
        
        List<ProofIssueledgerVO> proofIssueReportList = service.proofIssueReportList2(vo);
        vo.getDataMap().put("dataList", proofIssueReportList);
        model.addAttribute("serviceReportWrite", proofIssueReportList);
    }    
    
    /**
     * 이용실적증명서 신청 승인 서비스 상세 목록
     * proofServiceReportList 설명
     * @param request
     * @param model
     * @param vo
     * @return
     */
    @RequestMapping(value = "/BD_setIssuSttus1002.do")
    public String setIssuSttus1002(HttpServletRequest request, ModelMap model,ProofIssueledgerVO vo)
    {
        OpHelper.bindSearchMap(vo, request);
        
        return responseJson(model, service.setIssuSttus1002(vo));
    }
    
    /**
     * 이용실적증명서 신청승인처리 팝업창
     * proofServiceReportList 설명
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/BD_popIssuApplyAllow.do")
    public void popIssuApplyAllow(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo)
    {
        
        model.addAttribute("rouSn",  request.getParameter("rouSn") );
    }
    
    /**
     * 이용실적증명서 신청승인처리 팝업 저장
     * proofServiceReportList 설명
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/BD_popIssuApplyAllowSave.do")
    public String  popIssuApplyAllowSave(HttpServletRequest request, ModelMap model, ProofIssueledgerVO vo)
    {
        // 파일 저장경로
        List<FileVO> uploadFile = UploadHelper.upload(request, PROOF_ISSUE_FILE);
        
        for (int i = 0 ; i < uploadFile.size() ; i++) // 어짜피 무조건 하나임.... 
        {
            String inputNm = uploadFile.get(i).getInputNm();
            
            // 이용실적증명서
            if (inputNm.startsWith("pdfProfIssuFile")) 
            {
                vo.setPdfProfIssuFileSeq( fileService.saveFile(uploadFile, -1) );                
                vo.setSndngDe( vo.getSndngDe() );
                
                service.setIssuSttus1003(vo); // 발급완료
            }
        }
        
        return responseText(model, "저장이 완료되었습니다.");       
    }

}
