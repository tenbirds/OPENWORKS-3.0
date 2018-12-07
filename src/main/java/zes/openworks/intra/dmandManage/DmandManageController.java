/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dmandManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.auth.AuthType;
import zes.base.auth.anotation.AuthIntra;
import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.core.utils.MakeExcel;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.IntraController;
import zes.openworks.intra.code.CodeService;
import zes.openworks.intra.code.CodeVO;
import zes.openworks.intra.dmandExaminDtls.DmandExaminDtlsVO;


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
* 2017. 09. 07.   손은국   신규
*</pre>
* @see
*/
@Controller
@RequestMapping(value = "/intra/dmandManage")
public class DmandManageController extends IntraController {
    /*관리자페이지 - 수요조사관리 */
    @Autowired DmandManageService service;
    @Autowired CodeService codeService;
    /**
     * 수요조사 목록
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_dmandList.do", method = RequestMethod.GET)
    public void dmandList(HttpServletRequest request, ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /* 수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /* 수요조사 년도 저장 */
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandManageList(vo));
    }
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_dmandList_2018.do", method = RequestMethod.GET)
    public void dmandList_2018(HttpServletRequest request, ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /* 수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /* 수요조사 년도 저장 */
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandManageList2018(vo));
    }
    
    /**
     * 제출현황
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_presentnList.do", method = RequestMethod.GET)
    public void presentnList(HttpServletRequest request, ModelMap model, DmandManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /*통계 전체 갯수를 구하기 위한 조건*/
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());

        vo.getDataMap().put("q_beginDate", request.getParameter("q_beginDate"));
        vo.getDataMap().put("q_endDate", request.getParameter("q_endDate"));
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*수요조사 통계 전체 갯수*/
        List<DmandManageVO> totalCount = service.presentnTotalCount(vo);
 
        /*백분률 구하기 위하여 DataMap put*/
        vo.getDataMap().put("subMissionCount", totalCount.get(0).getSubMissionCount());
        vo.getDataMap().put("orgnCount", totalCount.get(0).getOrgnCount());
        
        /*화면에 뿌릴 수요조사 통계 전체 갯수*/
        model.addAttribute("subMissionCount",totalCount.get(0).getSubMissionCount());
        model.addAttribute("orgnCount",totalCount.get(0).getOrgnCount());
        
        /*기준 날짜*/
        model.addAttribute("registBeginDate",regusMngr.get(0).getRegistBeginDate());
        model.addAttribute("registEndDate",regusMngr.get(0).getRegistEndDate());
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandPresentnList(vo));
    }
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_presentnList2018.do", method = RequestMethod.GET)
    public void presentnList_2018(HttpServletRequest request, ModelMap model, DmandManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /*통계 전체 갯수를 구하기 위한 조건*/
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());

        vo.getDataMap().put("q_beginDate", request.getParameter("q_beginDate"));
        vo.getDataMap().put("q_endDate", request.getParameter("q_endDate"));
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*수요조사 통계 전체 갯수*/
        List<DmandManageVO> totalCount = service.presentnTotalCount2018(vo);
 
        /*백분률 구하기 위하여 DataMap put*/
        vo.getDataMap().put("subMissionCount", totalCount.get(0).getSubMissionCount());
        vo.getDataMap().put("orgnCount", totalCount.get(0).getOrgnCount());
        
        /*화면에 뿌릴 수요조사 통계 전체 갯수*/
        model.addAttribute("subMissionCount",totalCount.get(0).getSubMissionCount());
        model.addAttribute("orgnCount",totalCount.get(0).getOrgnCount());
        
        /*기준 날짜*/
        model.addAttribute("registBeginDate",regusMngr.get(0).getRegistBeginDate());
        model.addAttribute("registEndDate",regusMngr.get(0).getRegistEndDate());
        
        //model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandPresentnList(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandPresentnList2018(vo));        
    }
    
    /**
     * 수요조사 통계
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_dmandStatsList.do", method = RequestMethod.GET)
    public void dmandStatsList(HttpServletRequest request, ModelMap model, DmandManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);

        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*기준 날짜*/
        model.addAttribute("registBeginDate",regusMngr.get(0).getRegistBeginDate());
        model.addAttribute("registEndDate",regusMngr.get(0).getRegistEndDate());
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandStatsList(vo));
    }
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_dmandStatsList_2018.do", method = RequestMethod.GET)
    public void dmandStatsList_2018(HttpServletRequest request, ModelMap model, DmandManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);

        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*기준 날짜*/
        model.addAttribute("registBeginDate",regusMngr.get(0).getRegistBeginDate());
        model.addAttribute("registEndDate",regusMngr.get(0).getRegistEndDate());
        
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandStatsList(vo));
    }
    /**
     * 수요조사 통계(기관유형)
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value = "BD_dmandNsttList.do", method = RequestMethod.GET)
    public void dmandNsttList(HttpServletRequest request, ModelMap model, DmandManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        String searchKey = vo.getQ_searchKey();
        String title = null;

        /* 그룹 코드 설정*/
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2051);
        codeVO.setLangCode("00");
        codeVO.setUseYn("Y");
        List<CodeVO> codeList = codeService.codeList(codeVO);
        
        /*통계(기관유형) 테이블 상단 텍스트를 위한 초기 설정*/
        if(searchKey == null || searchKey.equals("")){
            title = "전체";
        }else{
            for(int i = 0; i < codeList.size() ; i++){
                if(String.valueOf(codeList.get(i).getPrvCd()).equals(searchKey)){
                   title = codeList.get(i).getPrvNm();
                   break;
                }
            }
        }
         
        /*최근 등록한 수요조사 년도 저장*/
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*기준 날짜*/
        model.addAttribute("registBeginDate",regusMngr.get(0).getRegistBeginDate());
        model.addAttribute("registEndDate",regusMngr.get(0).getRegistEndDate());
        /*통계(기관유형) 테이블 상단 텍스트를 위한 초기 설정*/
        model.addAttribute("title",title);
        
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, codeList);
        model.addAttribute(GlobalConfig.KEY_PAGER, service.dmandNsttList(vo));
    }
    
    /**
     * 수요조서 통계(요약) 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_presentnExcel.do", method=RequestMethod.GET)
    public void presentnExcel(HttpServletRequest request, ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /*통계 전체 갯수를 구하기 위한 조건*/
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*수요조사 통계 전체 갯수*/
        List<DmandManageVO> totalCount = service.presentnTotalCount(vo);
        /*백분률 구하기 위하여 DataMap put*/
        vo.getDataMap().put("subMissionCount", totalCount.get(0).getSubMissionCount());
        vo.getDataMap().put("orgnCount", totalCount.get(0).getOrgnCount());
        
        model.addAttribute("ExcelList", service.dmandPresentnList(vo));

    }
    /**
     * 수요조서 통계(요약) 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_presentnExcel2.do", method=RequestMethod.GET)
    public void presentnExcel2018(HttpServletRequest request, ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /*통계 전체 갯수를 구하기 위한 조건*/
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        /*수요조사 통계 전체 갯수*/
        List<DmandManageVO> totalCount = service.presentnTotalCount2018(vo);
        /*백분률 구하기 위하여 DataMap put*/
        vo.getDataMap().put("subMissionCount", totalCount.get(0).getSubMissionCount());
        vo.getDataMap().put("orgnCount", totalCount.get(0).getOrgnCount());
        
        model.addAttribute("ExcelList", service.dmandPresentnList2018(vo));

    }
    
    /**
     * 수요조서 통계(요약) 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_presentnExcelUnsubMission.do", method=RequestMethod.GET)
    public String presentnExcelUnsubMission(HttpServletRequest request, HttpServletResponse response , ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /* 수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /* 수요조사 년도 저장 */
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        List<DmandManageVO> unsubMissionList = service.dmandPresentnUnsubMission(vo);
        Map<String , Object> beans = new HashMap<String , Object>();
      
        beans.put("list" , unsubMissionList);
        
        MakeExcel me = new MakeExcel();
        me.download(request, response, beans, "미제출_기관목록", "dmandPresentnUnSubMission_sample.xlsx");
        return null;

    }
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_presentnExcelUnsubMission2018.do", method=RequestMethod.GET)
    public String presentnExcelUnsubMission2018(HttpServletRequest request, HttpServletResponse response , ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /* 수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        /* 수요조사 년도 저장 */
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        List<DmandManageVO> unsubMissionList = service.dmandPresentnUnsubMission2018(vo);
        Map<String , Object> beans = new HashMap<String , Object>();
      
        beans.put("list" , unsubMissionList);
        
        MakeExcel me = new MakeExcel();
        me.download(request, response, beans, "미제출_기관목록", "dmandPresentnUnSubMission_sample.xlsx");
        return null;

    }
    
    /**
     * 수요조서 통계(요약) 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_statsExcel.do", method=RequestMethod.GET)
    public void statsExcel(HttpServletRequest request, ModelMap model, DmandManageVO vo) {

        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        
        model.addAttribute("ExcelList", service.dmandStatsList(vo));

    }
    
    /**
     * 수요조서 통계(기관유형) 엑셀다운로드
     * @param request
     * @param model
     * @param vo
     */
    @AuthIntra(authType = AuthType.READ)
    @RequestMapping(value="BD_nsttExcel.do", method=RequestMethod.GET)
    public void nsttExcel(HttpServletRequest request, ModelMap model, DmandManageVO vo) {
        
        OpHelper.bindSearchMap(vo, request);
        
        /*수요조사 날짜*/
        List<DmandManageVO> regusMngr = service.dmandRegustMngr(vo);
        String searchKey = vo.getQ_searchKey();
        /*엑셀 파일 기본 파일 명*/
        String title = "";
        
        vo.setDmandExaminOprtnYear(regusMngr.get(0).getDmandExaminOprtnYear());
        vo.getDataMap().put("Year", vo.getDmandExaminOprtnYear());
        /*통계(기관유형) 테이블 상단 텍스트를 위한 초기 설정*/
        
        CodeVO codeVO = new CodeVO();
        codeVO.setGrpCd(2051);
        codeVO.setLangCode("00");
        codeVO.setUseYn("Y");
        List<CodeVO> codeList = codeService.codeList(codeVO);
        
        if(searchKey == null || searchKey.equals("")){
            title = "_전체";
        }else{
            for(int i = 0; i < codeList.size() ; i++){
                if(String.valueOf(codeList.get(i).getPrvCd()).equals(searchKey)){
                   title = codeList.get(i).getPrvNm().replace(" ", "_");
                   break;
                }
            }
        }
        request.setAttribute("Title", title);
        model.addAttribute("ExcelList", service.dmandNsttList(vo));
    }
}
