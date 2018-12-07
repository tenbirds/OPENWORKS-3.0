/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.user;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.spring.GeneralController;
import zes.base.vo.IExcelVO;
import zes.core.lang.Validate;
import zes.core.utils.RequestUtil;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.analyze.statistic.common.ExcelVO;
import zes.openworks.intra.analyze.statistic.common.ResultVO;

@Controller
@RequestMapping(value = "/intra/analyze/statistic/user")
public class UserStatsController extends GeneralController {

    @Resource
    UserStatsService service;
    
    @RequestMapping(value = "BD_index.do")
    public void index(HttpServletRequest request, ModelMap model) throws Exception {

        Map<String, Object> searchMap = RequestUtil.getSearchMap(request);
        if(Validate.isEmpty(searchMap.get("q_startDate")) && Validate.isEmpty(searchMap.get("q_endDate"))) {
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            searchMap.put("q_endDate", sdf.format(cal.getTime()));
            cal.set(Calendar.MONTH, -1);
            searchMap.put("q_startDate", sdf.format(cal.getTime()));
        }

        Map<String, Object> resultMap = service.userList(searchMap);

        model.addAttribute(GlobalConfig.KEY_SEARCH_MAP, searchMap);
        model.addAttribute(GlobalConfig.KEY_DATA_LIST, resultMap.get("list"));
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "INC_EXCEL.do")
    public String favoritePageExcel(HttpServletRequest request, ModelMap model) throws Exception {

        Map<String, Object> searchMap = RequestUtil.getSearchMap(request);
        Map<String, Object> resultMap = service.userList(searchMap);
        List<Map<String, Object>> result = (List<Map<String, Object>>) resultMap.get("list");
        List<ResultVO> list = new ArrayList<ResultVO>();

        for(int i = 0;  i < result.size(); ++i){
            if(i == result.size() -1 || (Validate.isNotEmpty(result.get(i).get("NATION")) && Validate.isNotEmpty(result.get(i).get("USERTYNM")))){
                ResultVO resultVo = new ResultVO();

                if(i == result.size() -1){
                    resultVo.setTitle("합계");
                } else {
                    resultVo.setTitle(result.get(i).get("NATION").toString()+result.get(i).get("USERTYNM").toString());
                }
                resultVo.setValue((Integer)result.get(i).get("CNT"));
                resultVo.setTextValue(result.get(i).get("RATE").toString()+"%");
                list.add(resultVo);
            }
        }
        
        
        String[] headers = {
            "회원유형",
            "회원수",
            "전체회원대비 비율"
        };
        String[] items = {
            "Title",
            "Value",
            "TextValue"
        };

        model.put("_list", list);
        model.put("_headers", headers);
        model.put("_items", items);

        IExcelVO excel = new ExcelVO("회원통계");
        return responseExcel(model, excel);
    }
}
