/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.introduction;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2018. 3. 7.    이홍석       신규
 *</pre>
 * @see
 */

@Controller
@RequestMapping(value = "/**/introduction")
public class IntroductionController  extends WebController
{
    @Autowired
    private IntroductionService service;
    
    /**
     * 씨앗소개 > 협약기업정보 리스트 _ 페이지 단위
     */
    @RequestMapping(value = "/BD_index.do" , method = {RequestMethod.GET, RequestMethod.POST})
    public String index(HttpServletRequest request, ModelMap model, AgremManageVO vo) 
    {
        OpHelper.bindSearchMap(vo, request); // vo + request
        
        if (vo.getQ_rowPerPage()==null) 
        {
            int rowPerPage = 60 ; // 4 * 15
            
            vo.setQ_rowPerPage( rowPerPage );
            vo.getDataMap().put("q_rowPerPage", rowPerPage);
            vo.getDataMap().put("pagingEndNum", rowPerPage);
        }       
        
        Pager<AgremManageVO> agremManage =  service.agremManage(vo);
        
        model.addAttribute("q_currPage",     vo.getQ_currPage());
        model.addAttribute("q_companyName",  vo.getQ_companyName());
        
        model.addAttribute("totalCompany", agremManage.getTotalNum());
        model.addAttribute("totalService", service.totalService(vo));
        model.addAttribute(GlobalConfig.KEY_PAGER, agremManage);
        
        return "/korean/pt/introduction/BD_index";
    }
    
    /**
     * 씨앗소개 > 협약기업정보 에서 서비스 목록 팝업
     */
    @RequestMapping(value = "/BD_popup.do" , method = {RequestMethod.GET, RequestMethod.POST})
    public String popup(HttpServletRequest request, ModelMap model, AgremManageServiceVO vo) 
    {
        OpHelper.bindSearchMap(vo, request); // vo + request
        
        List<AgremManageServiceVO> listService =  service.listService(vo);
        
        model.addAttribute("totalService", service.getServiceNum(vo));
        model.addAttribute("serviceList", listService);
        
        return "/korean/pt/introduction/BD_popup";
    }

}
