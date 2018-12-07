/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.connectCnt;

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
@RequestMapping(value = "/intra/analyze/statistic/connectCnt")
public class ConnectCntController extends GeneralController {

    @Autowired
    DomainService domainService;

    @Resource(name = "connectCntService")
    ConnectCntService service;

    /**
     * 접속수분석 메인페이지
     */
    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 전체 페이지뷰
     * 
     * @param vo
     * @param request
     * @param model
     * @throws Exception 
     */
    @RequestMapping(value = "INC_pageView.do")
    public void pageView(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("pageView");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 전체 페이지뷰(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     * @throws Exception 
     */
    @RequestMapping(value = "INC_pageViewEXCEL.do")
    public String pageViewExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("pageView");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);
        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "페이지뷰",
            vo.getCompareFlag().equals("1") ? "전일 비교" :
                vo.getCompareFlag().equals("7") ? "1주일 비교" :
                    vo.getCompareFlag().equals("30") ? "1개월(30일) 비교" : "",
            "증감"
        };
        String[] items = {
            "Title",
            "Value",
            "Values",
            "Variation"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("전체 페이지뷰");
        return responseExcel(model, excel);
    }

    /**
     * 전체 방문자 수
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_visiter.do")
    public void visiter(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("visiter");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 전체 방문자 수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_visiterEXCEL.do")
    public String visiterExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("visiter");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);
        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "전체방문",
            "처음방문",
            "재방문",
            vo.getCompareFlag().equals("1") ? "전일 비교" :
                vo.getCompareFlag().equals("7") ? "1주일 비교" :
                    vo.getCompareFlag().equals("30") ? "1개월(30일) 비교" : "",
            "증감"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "Value3",
            "Values",
            "Variation"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("전체 방문자 수");
        return responseExcel(model, excel);
    }

    /**
     * 순 방문자 수
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_originalVisiter.do")
    public void originalVisiter(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("originalVisiter");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 순 방문자 수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_originalVisiterEXCEL.do")
    public String originalVisiterExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("originalVisiter");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);
        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "전체방문",
            "순 방문수",
            "재 방문수",
            vo.getCompareFlag().equals("1") ? "전일 비교" :
                vo.getCompareFlag().equals("7") ? "1주일 비교" :
                    vo.getCompareFlag().equals("30") ? "1개월(30일) 비교" : "",
            "증감"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "Value3",
            "Values",
            "Variation"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("순 방문자 수");
        return responseExcel(model, excel);
    }

    /**
     * 재 방문자 수
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_returnVisiter.do")
    public void returnVisiter(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("visiter");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);

        sumResult.setRateValue(CalcUtil.getRateValue(sumResult.getValue3(), sumResult.getValue()));
        sumResult.setRateMobileValue(CalcUtil.getRateValue(sumResult.getMobileValue3(), sumResult.getMobileValue()));

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 재 방문자 수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_returnVisiterEXCEL.do")
    public String returnVisiterExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("visiter");
        List<ResultVO> list = service.getStatistic(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);
        CalcUtil.setSumValuesVariation(sumResult, 0);

        sumResult.setRateValue(CalcUtil.getRateValue(sumResult.getValue3(), sumResult.getValue()));
        sumResult.setRateMobileValue(CalcUtil.getRateValue(sumResult.getMobileValue3(), sumResult.getMobileValue()));
        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "전체방문",
            "재방문",
            "재방문률",
            vo.getCompareFlag().equals("1") ? "전일 비교" :
                vo.getCompareFlag().equals("7") ? "1주일 비교" :
                    vo.getCompareFlag().equals("30") ? "1개월(30일) 비교" : "",
            "증감"
        };
        String[] items = {
            "Title",
            "Value",
            "Value3",
            "RateValue",
            "Values",
            "Variation"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("재 방문자 수");
        return responseExcel(model, excel);
    }

    /**
     * 같은시간 방문자 수
     * timeGroup 설명
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_timeGroup.do")
    public void timeGroup(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("timeGroup");
        List<ResultVO> list = service.getStatisticTimeGroup(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        CalcUtil.getRateList(list, sumResult);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 같은시간 방문자 수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_timeGroupEXCEL.do")
    public String timeGroupExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("timeGroup");
        List<ResultVO> list = service.getStatisticTimeGroup(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        CalcUtil.getRateList(list, sumResult);

        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "방문자",
            "비율"
        };
        String[] items = {
            "Title",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("같은시간 방문자 수");
        return responseExcel(model, excel);
    }

    /**
     * 같은요일 방문자 수
     * timeGroup 설명
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_weekDateGroup.do")
    public void weekDateGroup(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("weekDateGroup");
        List<ResultVO> list = service.getStatisticWeekDateGroup(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        CalcUtil.getRateList(list, sumResult);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 같은요일 방문자 수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_weekDateGroupEXCEL.do")
    public String weekDateGroupExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("weekDateGroup");
        List<ResultVO> list = service.getStatisticWeekDateGroup(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        CalcUtil.getRateList(list, sumResult);

        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "방문자",
            "비율"
        };
        String[] items = {
            "Title",
            "Value",
            "RateValue"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("같은요일 방문자 수");
        return responseExcel(model, excel);
    }

    /**
     * 시간대별 평균 접속수
     * timeGroup 설명
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_time.do")
    public void time(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("time");
        List<ResultVO> list = service.getStatisticTime(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 시간대별 평균 접속수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_timeEXCEL.do")
    public String timeExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("time");
        List<ResultVO> list = service.getStatisticTime(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "페이지뷰",
            "전체방문자수",
            "순방문수",
            "처음방문수",
            "재방문수"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "Value3",
            "Value4",
            "Value5"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("시간대별 평균 접속수");
        return responseExcel(model, excel);
    }

    /**
     * 요일별 평균 접속수
     * timeGroup 설명
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_weekDate.do")
    public void weekDate(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("weekDate");
        List<ResultVO> list = service.getStatisticWeekDate(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

    /**
     * 요일별 평균 접속수(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_weekDateEXCEL.do")
    public String weekDateExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("weekDate");
        List<ResultVO> list = service.getStatisticWeekDate(vo);

        ResultVO sumResult = CalcUtil.setSumValues(list);

        sumResult.setTitle("합계");

        list.add(sumResult);
        model.put("_list", list);

        String[] headers = {
            "일시",
            "페이지뷰",
            "전체방문자수",
            "순방문수",
            "처음방문수",
            "재방문수"
        };
        String[] items = {
            "Title",
            "Value",
            "Value2",
            "Value3",
            "Value4",
            "Value5"
        };

        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("요일별 평균 접속수");
        return responseExcel(model, excel);
    }
}
