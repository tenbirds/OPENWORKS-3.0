/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.visiter;

import java.util.ArrayList;
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
@RequestMapping(value = "/intra/analyze/statistic/visiter")
public class VisiterController extends GeneralController {

    @Autowired
    DomainService domainService;

    @Resource(name = "visiterService")
    VisiterService service;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 방문횟수별 분석
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_visitNum.do")
    public void browser(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("visitNum");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);

        List<ResultVO> pivotList = new ArrayList<ResultVO>();

        if(list != null) {
            for(int i = 0 ; i < list.size() ; i++) {
                ResultVO _vo = list.get(i);
                ResultVO _vo01 = new ResultVO();
                ResultVO _vo02 = new ResultVO();
                ResultVO _vo03 = new ResultVO();
                ResultVO _vo04 = new ResultVO();
                ResultVO _vo06 = new ResultVO();
                ResultVO _vo10 = new ResultVO();

                _vo01.setTitle("1회 방문");
                _vo01.setValue(_vo.getValue() == null ? 0 : _vo.getValue());
                pivotList.add(_vo01);
                _vo02.setTitle("2회 방문");
                _vo02.setValue(_vo.getValue2() == null ? 0 : _vo.getValue2());
                pivotList.add(_vo02);
                _vo03.setTitle("3회 방문");
                _vo03.setValue(_vo.getValue3() == null ? 0 : _vo.getValue3());
                pivotList.add(_vo03);
                _vo04.setTitle("4~5회 방문");
                _vo04.setValue(_vo.getValue4() == null ? 0 : _vo.getValue4());
                pivotList.add(_vo04);
                _vo06.setTitle("6~9회 방문");
                _vo06.setValue(_vo.getValue6() == null ? 0 : _vo.getValue6());
                pivotList.add(_vo06);
                _vo10.setTitle("10회 이상 방문");
                _vo10.setValue(_vo.getValue10() == null ? 0 : _vo.getValue10());
                pivotList.add(_vo10);
            }
        }

        CalcUtil.getRateList(pivotList, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, pivotList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 방문횟수별 분석(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_visitNumEXCEL.do")
    public String visitNumExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("visitNum");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);

        List<ResultVO> pivotList = new ArrayList<ResultVO>();

        if(list != null) {
            for(int i = 0 ; i < list.size() ; i++) {
                ResultVO _vo = list.get(i);
                ResultVO _vo01 = new ResultVO();
                ResultVO _vo02 = new ResultVO();
                ResultVO _vo03 = new ResultVO();
                ResultVO _vo04 = new ResultVO();
                ResultVO _vo06 = new ResultVO();
                ResultVO _vo10 = new ResultVO();

                _vo01.setTitle("1회 방문");
                _vo01.setValue(_vo.getValue() == null ? 0 : _vo.getValue());
                pivotList.add(_vo01);
                _vo02.setTitle("2회 방문");
                _vo02.setValue(_vo.getValue2() == null ? 0 : _vo.getValue2());
                pivotList.add(_vo02);
                _vo03.setTitle("3회 방문");
                _vo03.setValue(_vo.getValue3() == null ? 0 : _vo.getValue3());
                pivotList.add(_vo03);
                _vo04.setTitle("4~5회 방문");
                _vo04.setValue(_vo.getValue4() == null ? 0 : _vo.getValue4());
                pivotList.add(_vo04);
                _vo06.setTitle("6~9회 방문");
                _vo06.setValue(_vo.getValue6() == null ? 0 : _vo.getValue6());
                pivotList.add(_vo06);
                _vo10.setTitle("10회 이상 방문");
                _vo10.setValue(_vo.getValue10() == null ? 0 : _vo.getValue10());
                pivotList.add(_vo10);
            }
        }

        CalcUtil.getRateList(pivotList, sumVo);

        sumVo.setTitle("합계");
        sumVo.setRateValue(100f);

        pivotList.add(sumVo);
        model.put("_list", pivotList);

        String[] headers = {
            "방문횟수",
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

        IExcelVO excel = new ExcelVO("방문횟수별 분석");
        return responseExcel(model, excel);
    }

    /**
     * 재방문 기간 분석
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_revisitPeriod.do")
    public void revisitPeriod(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("revisitPeriod");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 재방문 기간 분석(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_revisitPeriodEXCEL.do")
    public String revisitPeriodExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("revisitPeriod");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        sumVo.setTitle("합계");
        sumVo.setRateValue(100f);

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "방문횟수",
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

        IExcelVO excel = new ExcelVO("재방문 기간 분석");
        return responseExcel(model, excel);
    }

    /**
     * 1회 방문페이지뷰
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_pageViewNum.do")
    public void pageViewNum(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("pageViewNum");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);

    }

    /**
     * 1회 방문페이지뷰(Excel저장)
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_pageViewNumEXCEL.do")
    public String pageViewNumExcel(SearchVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        vo.setAnalyzeId("pageViewNum");

        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list = service.getStatisticList(vo);
        CalcUtil.getRateList(list, sumVo);

        sumVo.setTitle("합계");
        sumVo.setRateValue(100f);

        list.add(sumVo);
        model.put("_list", list);

        String[] headers = {
            "방문횟수",
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

        IExcelVO excel = new ExcelVO("1회 방문페이지뷰");
        return responseExcel(model, excel);
    }
}
