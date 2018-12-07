/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.bridge.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import zes.base.vo.TreeVO;
import zes.core.utils.StringUtil;
import zes.openworks.common.Messages;
import zes.openworks.common.controller.WebController;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.cms.support.CmsUtil;
import zes.openworks.intra.popup.PopupVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.main.MainConstant;
import zes.openworks.web.main.MainService;
import zes.openworks.web.webevent.WebEventVO;

/**
 * 
 *
 * @version 1.0
 * @since visitkorea 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 4. 17.    김영상       신규
 *</pre>
 * @see
 */
@Controller
@RequestMapping(value = "/**/common/commonduty")
public class CommonDutyController extends WebController {
    @Autowired
    private CommonDutyService service;
    
    @Autowired
    private MainService mnservice;
    
    /**
     * 광고배너
     */
    @RequestMapping(value = "ND_getBannerList.do")
    public String getBannerList(HttpServletRequest request, ModelMap model) {
        //도메인별 도메인코드를 설정
        String userPaMenu = "";
        userPaMenu = request.getParameter("userPaMenu") != null ? request.getParameter("userPaMenu").toString() : "";
        String hostNm = "";
        String domainCd = "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        if(!"".equals(hostNm)){
            domainCd = new MainConstant().getDomainCode(hostNm);
            if(domainCd == null){
                domainCd = "2";
            }
        } else {
            domainCd = "2"; //기본 한국어로 세팅
        }
        //광고_배너
        BannerVO bannerVO = new BannerVO();
        bannerVO.setDomainCd(new Integer(domainCd));    //도메인코드 세팅
        List<BannerVO> banner = new ArrayList<BannerVO>();
        @SuppressWarnings({ "unchecked", "rawtypes" })
        HashMap<String,Object> map = new HashMap();
        //커뮤니티배너
        if("community".equals(userPaMenu)){
            bannerVO.setBannerLcSeCd(1002);
            banner = mnservice.bannerListToday(bannerVO);
            map.put("banner", banner);
        }else{  //스터디 & 스토리
            bannerVO.setBannerLcSeCd(1001);
            banner = mnservice.bannerListToday(bannerVO);
            map.put("banner", banner);
        }
        return responseJson(model, map);
    }
    
    @RequestMapping(value = "ND_ctgryView.do")
    public String ctgryViewList(HttpServletRequest request, ModelMap model) {
        
        //도메인별 도메인코드를 설정
        String hostNm = "";
        String domainCd = "";
        String ctgryClCd = request.getParameter("ctgryClCd") != null ? (String)request.getParameter("ctgryClCd") : "";
        String upperMenuCd = request.getParameter("upperMenuCd") != null ? (String)request.getParameter("upperMenuCd") : "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        if(!"".equals(hostNm)){
            domainCd = new MainConstant().getDomainCode(hostNm);
            if(domainCd == null){
                domainCd = "2";
            }
        } else {
            domainCd = "2"; //기본 한국어로 세팅
        }
        String langCd = "00"; //기본 한국어로 세팅
        WebEventVO evo = new WebEventVO();
        //언어코드
        langCd = service.getLangCd(Integer.parseInt(domainCd));
        //카테고리 목록 가져오기
        CategoryVO cvo = new CategoryVO();
        cvo.setLangCd(langCd);
        if(!"".equals(ctgryClCd)){
            evo.setCtgryClCd(Integer.parseInt(ctgryClCd));
            cvo.setCtgryClCd(Integer.parseInt(ctgryClCd));
        }
        cvo.setUpperMenuCd(upperMenuCd);

        //이벤트 목록
        evo.setDomainCd(Integer.parseInt(domainCd));
        List<WebEventVO> eventList = service.eventList(evo);
        //카테고리 목록
        List<TreeVO> ctgryList = service.ctgryList(cvo);

        //첫번째 카테고리의 2Depth 카테고리 목록
        String ctgryUpperCd = "";
        ctgryUpperCd = service.getCtgryUpperCd(cvo);
        cvo.setUpperMenuCd(ctgryUpperCd);
        List<TreeVO> ctgry2List = service.ctgryList(cvo);
        //이벤트사이즈 세팅
        model.addAttribute("eventSize", eventList.size());

        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("eventList", eventList);
        map.put("ctgryList", ctgryList);
        map.put("ctgry2List", ctgry2List);
        return responseJson(model, map);
    }
    
    @RequestMapping(value = "ND_ctgry2dView.do")
    public String ctgry2dList(HttpServletRequest request, ModelMap model) {
        
        //도메인별 도메인코드를 설정
        String hostNm = "";
        String domainCd = "";
        String ctgryClCd = request.getParameter("ctgryClCd") != null ? (String)request.getParameter("ctgryClCd") : "";
        String upperMenuCd = request.getParameter("upperMenuCd") != null ? (String)request.getParameter("upperMenuCd") : "";
        hostNm = CmsUtil.getHostName(request.getServerName());
        if(!"".equals(hostNm)){
            domainCd = new MainConstant().getDomainCode(hostNm);
            if(domainCd == null){
                domainCd = "2";
            }
        } else {
            domainCd = "2"; //기본 한국어로 세팅
        }
        String langCd = "00"; //기본 한국어로 세팅

        //언어코드
        langCd = service.getLangCd(Integer.parseInt(domainCd));
        //카테고리 목록 가져오기
        CategoryVO cvo = new CategoryVO();
        cvo.setLangCd(langCd);
        if(!"".equals(ctgryClCd)){
            cvo.setCtgryClCd(Integer.parseInt(ctgryClCd));
        }
        cvo.setUpperMenuCd(upperMenuCd);

        //2Depth카테고리 목록
        List<TreeVO> ctgryList = service.ctgryList(cvo);
        @SuppressWarnings({ "unchecked", "rawtypes" })
        HashMap<String,Object> map = new HashMap();
        map.put("ctgryList", ctgryList);
        return responseJson(model, map);
    }

    /**
     * 
     * showCount 팝업 노출수 증가
     * @param request
     * @param vo
     * @param model
     * @return
     */
    @RequestMapping(value="ND_popupShowCount.do")
    public String popupShowCount(HttpServletRequest request, PopupVO vo, ModelMap model) {
        if(service.popupShowCount(vo) == StringUtil.ONE){
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Message.FAIL);
    }

    
    @RequestMapping(value="ND_bannerClickCount.do")
    public String bannerClickCount(HttpServletRequest request, BannerVO vo, ModelMap model) {
        if(service.bannerClickCount(vo) == StringUtil.ONE){
            return responseText(model, Messages.TRUE);
        }
        return responseText(model, Message.FAIL);
    }
}
