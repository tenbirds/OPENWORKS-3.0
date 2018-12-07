/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.summary;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;
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
@RequestMapping(value = "/intra/analyze/statistic/summary")
public class SummaryController {

    @Autowired
    DomainService domainService;

    @Resource(name = "summaryService")
    SummaryService service;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index(ResultVO vo, HttpServletRequest request, ModelMap model) throws Exception {
        // 전체페이지뷰
        vo.setAnalyzeId("pageView");

        // 도메인 리스트 조회
        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        if(Validate.isEmpty(vo.getDomain()) && domainList.size() > 0) vo.setDomain(domainList.get(0).getDomainNm());
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        List<ResultVO> list0 = service.getStatistic(vo);
        model.addAttribute("dataList0", list0);

        // 전체 방문자수
        vo.setAnalyzeId("visiter");
        List<ResultVO> list1 = service.getStatistic(vo);
        model.addAttribute("dataList1", list1);

        // 많이 찾는 페이지
        vo.setAnalyzeId("favorite");
        ResultVO sumVo = service.getStatisticSum(vo);
        List<ResultVO> list2 = service.getTopStatisticList(vo, sumVo);
        model.addAttribute("dataList2", list2);

        // 사이트 체류시간
        vo.setAnalyzeId("browser");
        List<ResultVO> list3 = service.getStatistic(vo);
        model.addAttribute("dataList3", list3);

    }

}
