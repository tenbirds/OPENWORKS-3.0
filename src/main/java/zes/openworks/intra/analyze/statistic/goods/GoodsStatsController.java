/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.goods;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

@Controller
@RequestMapping(value = "/intra/analyze/statistic/goods")
public class GoodsStatsController extends GeneralController {

    @Resource
    GoodsStatsService service;

    /* 서비스등록 통계 */
    @RequestMapping(value = "BD_registStat.do")
    public void registStat(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(null));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.registStatList(vo));
    }

    /* 서비스구매문의통계 */
    @RequestMapping(value = "BD_purchStat.do")
    public void purchStat(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(null));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.purchStatList(vo));

    }

    /* 관심서비스 통계 */
    @RequestMapping(value = "BD_intrStat.do")
    public void intrStat(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);

        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(null));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.intrStatList(vo));
    }
   
    /* 서비스구매 통계 */
    @RequestMapping(value = "BD_goodsPpsStat.do")
    public void goodsPpsStat(HttpServletRequest request, ModelMap model, ResultVO vo) throws Exception {
        OpHelper.bindSearchMap(vo, request);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, service.langList(null));
        model.addAttribute(GlobalConfig.KEY_DATA_VO, service.goodsPpsStatList(vo));

    }
}
