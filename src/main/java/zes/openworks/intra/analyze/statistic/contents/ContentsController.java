/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.contents;

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
@RequestMapping(value = "/intra/analyze/statistic/contents")
public class ContentsController extends GeneralController {

    @Autowired
    DomainService domainService;

    @Resource(name = "contentsService")
    ContentsService service;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 페이지 체류시간
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_residensePage.do")
    public void residensePage(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("residensePage");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        // CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 페이지 체류시간(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_residensePageEXCEL.do")
    public String residensePageExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("residensePage");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "페이지명",
            "페이지뷰",
            "3초 미만",
            "15초 미만",
            "30초 미만",
            "1분 미만",
            "5분 미만",
            "5분 이상",
            "총시간",
            "페이지뷰당 평균"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "Value3",
            "Value4",
            "Value5",
            "Value6",
            "Value7",
            "TextValue",
            "TextValue2"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("페이지 체류시간");
        return responseExcel(model, excel);
    }

    /**
     * 사이트 체류시간
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_residenseSite.do")
    public void residenseSite(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("residenseSite");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 사이트 체류시간(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_residenseSiteEXCEL.do")
    public String residenseSiteExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("residenseSite");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "일자",
            "페이지뷰",
            "방문수",
            "1분 미만",
            "3분 미만",
            "7분 미만",
            "15분 미만",
            "20분 미만",
            "30분 미만",
            "1시간 미만",
            "1시간 이상",
            "총시간",
            "페이지뷰당 평균",
            "방문당 평균"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "Value3",
            "Value4",
            "Value5",
            "Value6",
            "Value7",
            "Value8",
            "Value9",
            "Value10",
            "TextValue",
            "TextValue2",
            "TextValue3"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("사이트 체류시간");
        return responseExcel(model, excel);
    }

}
