/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.resource.statistic;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import zes.base.spring.GeneralController;
import zes.openworks.common.GlobalConfig;

// import org.eclipse.jetty.util.log.Log;

/**
 * @version 1.0
 * @since openworks-openapi 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2013. 5. 2.    boseok   신규 생성
 * </pre>
 * @see
 */
@Controller
@RequestMapping(value = "/intra/resource/statistic")
public class RscCntController extends GeneralController {

    /** SL4J 로깅 */
    //private static Logger logger = LoggerFactory.getLogger(RscCntController.class);

    @Resource(name = "rscCntService")
    RscCntService service;

    @RequestMapping(value = "BD_index.do", method = RequestMethod.GET)
    public void index() {

    }

    /**
     * 분야 별
     * 
     * @param vo
     * @param request
     * @param model
     */

    @RequestMapping(value = "INC_resourceField.do")
    public void resourceField(RscCntResultVO vo, HttpServletRequest request, ModelMap model) {
        vo.setAnalyzeId("resourceField");

        // List<RscCntResultVO> list = service.getResourceFieldStatistic(vo);
        //
        // RscCntResultVO sumResult = CalcUtil.setSumValues(list);
        // //CalcUtil.setSumValuesVariation(sumResult, 0);
        // //Log.info(":>>>>>>>>>>resourceField>>!!!!!!!!!!!!~~~~~~~getEndDateFmt~~~"+vo.getEndDateFmt());
        // model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        // model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        // model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);
        /*
         * ResultVO sumVo = service.getStatisticSum(vo);
         * List<ResultVO> topList = service.getTopStatisticList(vo, sumVo);
         * vo.setSearchText(tempSearchText);
         * Pager<ResultVO> list = service.getStatisticPageList(vo, sumVo);
         * model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
         * model.addAttribute(GlobalConfig.KEY_SEARCH_MAP,
         * RequestUtil.getSearchMap(request) );
         * model.addAttribute(GlobalConfig.KEY_PAGER, list);
         * model.addAttribute(GlobalConfig.KEY_DATA_LIST, topList);
         * model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);
         */
        RscCntResultVO sumVo = service.getResourceFieldStatisticCnt(vo);
        int strValue = sumVo.getValue();
        if(strValue == 0) {
            sumVo.setValue(null);
        }
        List<RscCntResultVO> list = service.getResourceFieldStatisticChart(vo, sumVo);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumVo);
    }

    /**
     * 주제 별
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_resourceTheme.do")
    public void resourceTheme(RscCntSearchVO vo, HttpServletRequest request, ModelMap model) {
        vo.setAnalyzeId("resourceTheme");

        //String PrvCode = vo.getPrvCode();
        List<RscCntResultVO> list = service.getResourceThemeStatistic(vo);

        List<RscCntResultVO> codeList = service.getOpCodeList(vo);
        RscCntResultVO sumResult = CalcUtil.setSumValues(list);
        // CalcUtil.setSumValuesVariation(sumResult, 0);
        // Log.info(":>>>>>>>>>>resourceField>>!!!!!!!!!!!!~~~~~~~getEndDateFmt~~~"+vo.getEndDateFmt());
        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_CODE_LIST, codeList);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);
    }

    /**
     * 사용자 별
     * 
     * @param vo
     * @param request
     * @param model
     */
    @RequestMapping(value = "INC_resourceUser.do")
    public void resourceUser(RscCntSearchVO vo, HttpServletRequest request, ModelMap model) {
        vo.setAnalyzeId("resourceUser");
        String searchText = vo.getSearchText();
        List<RscCntResultVO> list = null;

        if(!searchText.equals("")) {
            list = service.getResourceUserStatisticPersonal(vo);
        } else {
            list = service.getResourceUserStatistic(vo);
        }
        RscCntResultVO sumResult = CalcUtil.setSumValues(list);

        model.addAttribute(GlobalConfig.KEY_SEARCH_VO, vo);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, list);
        model.addAttribute(GlobalConfig.KEY_DATA_VO, sumResult);

    }

}
