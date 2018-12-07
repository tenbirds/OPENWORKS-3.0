/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.g2b.bidAno;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.web.g2b.cntrctInfo.CntrctInfoService;

/**
 *
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 17.    이슬버미       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/{pathLang}/pt/g2b/bidAno")
public class BidAnoController extends WebController{

    @Autowired BidAnoService bidAnoService;
    @Autowired CntrctInfoService cntrctInfoService;

    public boolean peerHandle()  {
        return true;
    }

    @RequestMapping(value = "/BD_index.do" , method = RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model, BidAnoVO vo,@PathVariable String pathLang) throws Exception {
        getBaseUrl(model,pathLang) ;
        if(Validate.isEmpty(vo.getsDate()) && Validate.isEmpty(vo.geteDate())){
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            vo.seteDate(sdf.format(cal.getTime()));
            cal.add(Calendar.MONTH, -3);
            vo.setsDate(sdf.format(cal.getTime()));
        }

        search(request, model, vo, pathLang);
    }

    @RequestMapping(value = "/ND_search.do" , method = RequestMethod.GET)
    public synchronized String search(HttpServletRequest request, ModelMap model, BidAnoVO vo,@PathVariable String pathLang) throws Exception {


        String BaseURL = getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);

        //조회
        if(Validate.isEmpty(vo.getFlag()) || vo.getFlag().startsWith("1001")){
            if(Validate.isEmpty(vo.getDateType())) {
                vo.setDateType("PBLANC_START_DATE");
            }

            vo.getDataMap().put("flag", vo.getFlag());
            vo.getDataMap().put("searchNmVal", vo.getSearchNmVal());
            vo.getDataMap().put("dateType", vo.getDateType());
            vo.getDataMap().put("sDate", vo.getsDate());
            vo.getDataMap().put("eDate", vo.geteDate());
            vo.getDataMap().put("searchKey", vo.getSearchKey());
            vo.getDataMap().put("searchVal", vo.getSearchVal());
            model.addAttribute(GlobalConfig.KEY_PAGER, bidAnoService.bidAnoList(vo));
        }else if(vo.getFlag().startsWith("1002")){
            if(Validate.isEmpty(vo.getDateType())) {
                vo.setDateType("CNTRCT_DATE");
            }
            vo.getDataMap().put("flag", vo.getFlag());
            vo.getDataMap().put("searchNmVal", vo.getSearchNmVal());
            vo.getDataMap().put("dateType", vo.getDateType());
            vo.getDataMap().put("sDate", vo.getsDate());
            vo.getDataMap().put("eDate", vo.geteDate());
            vo.getDataMap().put("searchKey", vo.getSearchKey());
            vo.getDataMap().put("searchVal", vo.getSearchVal());
            //model.addAttribute(GlobalConfig.KEY_PAGER, cntrctInfoService.cntrctInfoList(vo));
        }

        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        return BaseURL + "/BD_index";
    }

    @RequestMapping(value = "/ND_paging.do" , method = RequestMethod.GET)
    public String paging(HttpServletRequest request, ModelMap model, BidAnoVO vo,@PathVariable String pathLang) throws Exception {

        String BaseURL = getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);
        //조회
        if(Validate.isEmpty(vo.getFlag()) || vo.getFlag().startsWith("1001")){
            if(Validate.isEmpty(vo.getDateType())) {
                vo.setDateType("PBLANC_START_DATE");
            }

            vo.getDataMap().put("flag", vo.getFlag());
            vo.getDataMap().put("searchNmVal", vo.getSearchNmVal());
            vo.getDataMap().put("dateType", vo.getDateType());
            vo.getDataMap().put("sDate", vo.getsDate());
            vo.getDataMap().put("eDate", vo.geteDate());
            vo.getDataMap().put("searchKey", vo.getSearchKey());
            vo.getDataMap().put("searchVal", vo.getSearchVal());
            model.addAttribute(GlobalConfig.KEY_PAGER, bidAnoService.bidAnoList(vo));
        }else if(vo.getFlag().startsWith("1002")){
            if(Validate.isEmpty(vo.getDateType())) {
                vo.setDateType("CNTRCT_DATE");
            }
            vo.getDataMap().put("flag", vo.getFlag());
            vo.getDataMap().put("searchNmVal", vo.getSearchNmVal());
            vo.getDataMap().put("dateType", vo.getDateType());
            vo.getDataMap().put("sDate", vo.getsDate());
            vo.getDataMap().put("eDate", vo.geteDate());
            vo.getDataMap().put("searchKey", vo.getSearchKey());
            vo.getDataMap().put("searchVal", vo.getSearchVal());
            
        }
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);
        return BaseURL + "/BD_index";
    }
}
