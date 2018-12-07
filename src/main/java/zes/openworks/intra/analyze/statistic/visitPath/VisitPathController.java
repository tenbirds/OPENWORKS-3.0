/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.visitPath;

import java.util.ArrayList;
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
import zes.core.spi.commons.configuration.Config;
import zes.core.utils.RequestUtil;
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
@RequestMapping(value = "/intra/analyze/statistic/visitPath")
public class VisitPathController extends GeneralController {

    @Autowired
    DomainService domainService;

    @Resource(name = "visitPathService")
    VisitPathService service;

    /**
     * 접속수분석 메인페이지
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 검색엔진
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_searchEngine.do")
    public void searchEngine(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("searchEngine");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 검색엔진(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_searchEngineEXCEL.do")
    public String searchEngineExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("searchEngine");

        ResultVO sumResult = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumResult);

        sumResult.setTitle("합계");
        sumResult.setRateValue(100f);

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "검색엔진",
            "검색어",
            "방문수",
            "비율"
        };
        String[] items = {
            "Title",
            "TextValue",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("검색엔진");
        return responseExcel(model, excel);
    }

    /**
     * 검색단어
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_searchWord.do")
    public void searchWord(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("searchWord");

        vo.setDomains(Config.getStringArray("analyze.search-engines.id"));

        List<ResultVO> list = service.getStatisticList(vo);

        for(ResultVO result : list) {

            String[] textValues = result.getTextValue().split("\\|");

            List<Integer> valueList = new ArrayList<Integer>();
            for(String txt : textValues) {

                valueList.add(Integer.parseInt(txt));

            }

            result.setValues(valueList);
        }

        // 합계 Row는 따로 저장
        ResultVO sumVo = null;
        if(list.size() > 0) {
            sumVo = list.get(list.size() - 1);
            list.remove(list.size() - 1);
        }

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 검색단어(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_searchWordEXCEL.do")
    public String searchWordExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("searchWord");

        String[] engines = Config.getStringArray("analyze.search-engines.id");
        vo.setDomains(engines);

        List<ResultVO> list = service.getStatisticList(vo);

        for(ResultVO result : list) {

            String[] textValues = result.getTextValue().split("\\|");

            List<Integer> valueList = new ArrayList<Integer>();
            for(String txt : textValues) {

                valueList.add(Integer.parseInt(txt));

            }

            result.setValues(valueList);
        }

        // 합계 Row는 따로 저장
        ResultVO sumVo = null;
        if(list.size() > 0) {
            sumVo = list.get(list.size() - 1);
            list.remove(list.size() - 1);
        }

        sumVo.setTitle("합계");

        list.add(sumVo);
        model.put("_list", list);

        Object[] headers = {
            "검색어",
            "검색전체",
            engines,
            "기타"
        };
        String[] items = {
            "Title",
            "Value",
            "Values",
            "Value2"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("검색단어");
        return responseExcel(model, excel);
    }

    /**
     * 유입도메인
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_inflowDomain.do")
    public void inflowDomain(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("inflowDomain");

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
     * 유입도메인(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_inflowDomainEXCEL.do")
    public String inflowDomainExcel(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("inflowDomain");

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
            "도메인",
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

        IExcelVO excel = new ExcelVO("유입도메인");
        return responseExcel(model, excel);
    }

    /**
     * 유입URL
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_inflowUrl.do")
    public void inflowUrl(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("inflowUrl");

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
     * 유입URL(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_inflowUrlEXCEL.do")
    public String inflowUrlExcel(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("inflowUrl");

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
            "URL",
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

        IExcelVO excel = new ExcelVO("유입URL");
        return responseExcel(model, excel);
    }
}
