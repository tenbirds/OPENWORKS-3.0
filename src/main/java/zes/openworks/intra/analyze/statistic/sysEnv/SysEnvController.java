/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.sysEnv;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.spring.GeneralController;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.analyze.statistic.common.ExcelVO;
import zes.openworks.intra.analyze.statistic.common.ResultVO;
import zes.openworks.intra.analyze.statistic.common.SearchVO;
import zes.openworks.intra.analyze.util.CalcUtil;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/analyze/statistic/sysEnv")
public class SysEnvController extends GeneralController {

    @Autowired
    DomainService domainService;

    @Resource(name = "sysEnvService")
    SysEnvService service;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 브라우저
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_browser.do")
    public void browser(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("browser");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 브라우저(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_browserEXCEL.do")
    public String browserExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("browser");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "브라우저",
            "횟수",
            "비율"
        };
        String[] items = {
            "Title",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("브라우저");
        return responseExcel(model, excel);
    }

    /**
     * OS
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_os.do")
    public void os(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("os");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * OS(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_osEXCEL.do")
    public String osExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("os");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "운영체제",
            "횟수",
            "비율"
        };
        String[] items = {
            "Title",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("운영체제");
        return responseExcel(model, excel);
    }

    /**
     * 해상도
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_resolution.do")
    public void resolution(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("resolution");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 해상도(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_resolutionEXCEL.do")
    public String resolutionExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("resolution");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "해상도",
            "횟수",
            "비율"
        };
        String[] items = {
            "Title",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("해상도");
        return responseExcel(model, excel);
    }

    /**
     * 색상수
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_colorDepth.do")
    public void colorDepth(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("colorDepth");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 색상수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_colorDepthEXCEL.do")
    public String colorDepthExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("colorDepth");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "색상수(Bit)",
            "횟수",
            "비율"
        };
        String[] items = {
            "Title",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("해상도");
        return responseExcel(model, excel);
    }

}
