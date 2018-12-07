/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.banner;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.core.lang.Validate;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.component.domain.DomainService;
import zes.openworks.component.domain.DomainVO;

@Controller
@RequestMapping(value = "/intra/analyze/statistic/banner")
public class BannerStatsController extends GeneralController {

    @Resource
    BannerStatsService service;

    @Autowired
    DomainService domainService;

    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model) throws Exception {

        DomainVO domainVO = new DomainVO();
        List<DomainVO> domainList = domainService.getDomainList(domainVO);
        model.addAttribute(GlobalConfig.KEY_DOMAIN_LIST, domainList);

        Map<String, Object> searchMap = RequestUtil.getSearchMap(request);
        if(Validate.isEmpty(searchMap.get("q_startDate")) && Validate.isEmpty(searchMap.get("q_endDate"))) {
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            searchMap.put("q_endDate", sdf.format(cal.getTime()));
            cal.set(Calendar.MONTH, -1);
            searchMap.put("q_startDate", sdf.format(cal.getTime()));
        }
        if(Validate.isEmpty(searchMap.get("q_domainCd"))){
            searchMap.put("q_domainCd", 2);
        }

        Map<String, Object> resultMap = service.statsList(searchMap);

        model.addAttribute(GlobalConfig.KEY_SEARCH_MAP, searchMap);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, resultMap.get("list"));
    }
}
