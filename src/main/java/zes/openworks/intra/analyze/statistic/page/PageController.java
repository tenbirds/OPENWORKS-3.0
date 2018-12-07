/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.page;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.spring.GeneralController;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
import zes.openworks.intra.analyze.statistic.common.ExcelVO;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

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
@RequestMapping(value = "/intra/analyze/statistic/page")
public class PageController extends GeneralController {

    @Autowired
    DomainService domainService;

    @Resource(name = "pageService")
    PageService service;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 많이 찾는 페이지
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_favoritePage.do")
    public void favoritePage(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("favorite");

        // 합계데이터 및 Top 통계데이터는 검색단어와는 관계없이 조회되어야 하므로
        // 검색단어를 지워줘야 함.
        String tempSearchText = vo.getSearchText();
        vo.setSearchText("");
        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> topList = service.getTopStatisticList(vo, sumVo);
        vo.setSearchText(tempSearchText);

        Pager<ResultVO> list = service.getStatisticPageList(vo, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_SEARCH_MAP, RequestUtil.getSearchMap(request));
        model.addAttribute(GlobalConfig.KEY_PAGER, list);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, topList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 많이 찾는 페이지(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_favoritePageEXCEL.do")
    public String favoritePageExcel(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("favorite");

        vo.setQ_currPage(1);
        vo.setQ_rowPerPage(1048576); // excel 2007 이상 프로그램에서 표현할수 있는 최대 RowNum

        // 합계데이터 및 Top 통계데이터는 검색단어와는 관계없이 조회되어야 하므로
        // 검색단어를 지워줘야 함.
        String tempSearchText = vo.getSearchText();
        vo.setSearchText("");
        ResultVO sumVo = service.getStatisticSum(vo);

        vo.setSearchText(tempSearchText);

        List<ResultVO> list = service.getStatisticPageList(vo, sumVo).getList();

        sumVo.setTitle("합계");
        sumVo.setRateValue(100f);

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "페이지명",
            "페이지뷰",
            "방문자수",
            "비율",
            "방문자당 PV"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "RateValue",
            "RateValue2"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("많이 찾는 페이지");
        return responseExcel(model, excel);
    }

    /**
     * 시작 페이지
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_startPage.do")
    public void startPage(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("start");

        // 합계데이터 및 Top 통계데이터는 검색단어와는 관계없이 조회되어야 하므로
        // 검색단어를 지워줘야 함.
        String tempSearchText = vo.getSearchText();
        vo.setSearchText("");
        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> topList = service.getTopStatisticList(vo, sumVo);
        vo.setSearchText(tempSearchText);

        Pager<ResultVO> list = service.getStatisticPageList(vo, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_SEARCH_MAP, RequestUtil.getSearchMap(request));
        model.addAttribute(GlobalConfig.KEY_PAGER, list);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, topList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 시작 페이지(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_startPageEXCEL.do")
    public String startPageExcel(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("start");

        vo.setQ_currPage(1);
        vo.setQ_rowPerPage(1048576); // excel 2007 이상 프로그램에서 표현할수 있는 최대 RowNum

        // 합계데이터 및 Top 통계데이터는 검색단어와는 관계없이 조회되어야 하므로
        // 검색단어를 지워줘야 함.
        String tempSearchText = vo.getSearchText();
        vo.setSearchText("");
        ResultVO sumVo = service.getStatisticSum(vo);

        vo.setSearchText(tempSearchText);

        List<ResultVO> list = service.getStatisticPageList(vo, sumVo).getList();

        sumVo.setTitle("합계");
        sumVo.setRateValue(100f);

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "페이지명",
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

        IExcelVO excel = new ExcelVO("많이 찾는 페이지");
        return responseExcel(model, excel);
    }

    /**
     * 종료 페이지
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_endPage.do")
    public void endPage(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("end");

        // 합계데이터 및 Top 통계데이터는 검색단어와는 관계없이 조회되어야 하므로
        // 검색단어를 지워줘야 함.
        String tempSearchText = vo.getSearchText();
        vo.setSearchText("");
        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> topList = service.getTopStatisticList(vo, sumVo);
        vo.setSearchText(tempSearchText);

        Pager<ResultVO> list = service.getStatisticPageList(vo, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_SEARCH_MAP, RequestUtil.getSearchMap(request));
        model.addAttribute(GlobalConfig.KEY_PAGER, list);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, topList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 종료 페이지(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_endPageEXCEL.do")
    public String endPageExcel(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("end");

        vo.setQ_currPage(1);
        vo.setQ_rowPerPage(1048576); // excel 2007 이상 프로그램에서 표현할수 있는 최대 RowNum

        // 합계데이터 및 Top 통계데이터는 검색단어와는 관계없이 조회되어야 하므로
        // 검색단어를 지워줘야 함.
        String tempSearchText = vo.getSearchText();
        vo.setSearchText("");
        ResultVO sumVo = service.getStatisticSum(vo);

        vo.setSearchText(tempSearchText);

        List<ResultVO> list = service.getStatisticPageList(vo, sumVo).getList();

        sumVo.setTitle("합계");
        sumVo.setRateValue(100f);

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "페이지명",
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

        IExcelVO excel = new ExcelVO("많이 찾는 페이지");
        return responseExcel(model, excel);
    }
}
