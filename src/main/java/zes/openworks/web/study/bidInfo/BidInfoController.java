/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.study.bidInfo;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import zes.base.pager.Pager;
import zes.base.support.OpHelper;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.common.controller.WebController;
import zes.openworks.common.rest.g2b.G2bService;
import zes.openworks.common.rest.g2b.vo.G2bItemVO;
import zes.openworks.common.rest.g2b.vo.G2bResponseVO;
import zes.openworks.web.study.bidInfo.BidInfoPaging.ItemList;


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
 * 2014. 12. 12.    이슬버미       신규
 *</pre>
 * @see
 */
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
//@Controller
@RequestMapping(value = "/{pathLang}/pt/study/bidInfo")
public class BidInfoController extends WebController{

    @Autowired G2bService g2bService;

    public boolean peerHandle()  {


        return true;
    }

    @RequestMapping(value = "/BD_index.do" , method = RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model, BidInfoVO vo,@PathVariable String pathLang) throws Exception {
        getBaseUrl(model,pathLang) ;
        if(Validate.isEmpty(vo.getsDate()) && Validate.isEmpty(vo.geteDate())){
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            vo.seteDate(sdf.format(cal.getTime()));
            cal.add(Calendar.DATE, -1);
            vo.setsDate(sdf.format(cal.getTime()));
        }
        search(request, model, vo, pathLang);
    }

    @RequestMapping(value = "/ND_search.do" , method = RequestMethod.GET)
    public synchronized String search(HttpServletRequest request, ModelMap model, BidInfoVO vo,@PathVariable String pathLang) throws Exception {


        String BaseURL = getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);

        //조회
        G2bResponseVO g2bResponseVO = null ;
        if(Validate.isEmpty(vo.getFlag()) || vo.getFlag().startsWith("1001")){
            g2bResponseVO =  g2bService.getInsttAcctoBidPblancListServc(vo);

        }else if(vo.getFlag().startsWith("1002")){
            g2bResponseVO =  g2bService.getInsttCntrctInfoListServcCntrctSttus(vo);
        }


        List<G2bItemVO> dataList = null;
        if(Validate.isNotEmpty(g2bResponseVO)){

            //저장
            dataList = g2bResponseVO.getG2bBodyVO().getItems().getItem();
        }


        if(Validate.isNotEmpty(dataList)){
            getFindMatches(request.getSession().getId(),dataList,vo.getPblancNm(),vo.getFlag());
            getMemoryList(request.getSession().getId(),model,vo);
        }

        return BaseURL + "/BD_index";
    }

    @RequestMapping(value = "/ND_paging.do" , method = RequestMethod.GET)
    public String paging(HttpServletRequest request, ModelMap model, BidInfoVO vo,@PathVariable String pathLang) throws Exception {

        String BaseURL = getBaseUrl(model,pathLang) ;
        OpHelper.bindSearchMap(vo, request);
        getMemoryList(request.getSession().getId(),model,vo);
        return BaseURL + "/BD_index";
    }


    /**
     * getFindMatches 검색 결과 정보를 필터를 걸어봐요
     * @param itemVO
     * @param searchTerm
     * @return
     */
    private  void getFindMatches(String key,List<G2bItemVO> itemVO, String searchTerm, String flag) {



        List<G2bItemVO> result = new ArrayList<G2bItemVO>();
        String[] likeSearch = null;
        if(Validate.isEmpty(searchTerm)){
            likeSearch = new String[]{"포털", "시스템", "정보화", "모바일"};
        }else{
            likeSearch  = new String[]{searchTerm};
        }

        //용역명
        if(Validate.isEmpty(flag) || flag.startsWith("1001")){

            for(G2bItemVO vo : itemVO) {
                for(String like : likeSearch) {
                    if(Validate.isNotEmpty(vo.getObj09())){
                        if(vo.getObj09().contains(like)){
                            result.add(vo);
                        }
                    }
                }
            }

        //계약용역
        }else{

            for(G2bItemVO vo : itemVO) {
                for(String like : likeSearch) {
                    if(Validate.isNotEmpty(vo.getObj78())){
                        if(vo.getObj78().contains(like)){
                            result.add(vo);
                        }
                    }
                }
            }
        }

        ItemList list = new ItemList();
        list.list = result;
        list.totalCount = result.size();
        list.dateTime = new Date();

        BidInfoPaging.HM_list.put(key, list);

    }


    /**
     * getMemoryList 메모리 조회
     * @param model
     * @param vo
     */
    private void getMemoryList(String key,ModelMap model,BidInfoVO vo){

        int currPage =  Integer.valueOf((Integer) vo.getDataMap().get("q_currPage"));
        int rowPerPage =  Integer.valueOf((Integer) vo.getDataMap().get("q_rowPerPage"));

        List<G2bItemVO> list = BidInfoPaging.setPager(key,currPage ,rowPerPage);
        ItemList item  = BidInfoPaging.HM_list.get(key);
        if(Validate.isNotEmpty(item)){
            vo.setTotalNum(item.totalCount);
            item.dateTime = new Date();
        }else{
            vo.setTotalNum(0);
        }

        model.addAttribute(GlobalConfig.KEY_PAGER, new Pager<G2bItemVO>(list, vo));
        model.addAttribute(GlobalConfig.KEY_BASE_VO, vo);

    }


}
