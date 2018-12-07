/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.vo.TreeVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.popup.PopupVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.main.MainConstant;
import zes.openworks.web.webevent.WebEventVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
@Repository
@SuppressWarnings("unchecked")
public class CommonDutyDAO extends EgovAbstractMapper {

    /**
     * countryList 설명
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List countryList(String langCode) {
        HashMap<String, String> langMap = new HashMap<String, String>();
        langMap.put("langCode", langCode);
        List dataList = list("_commonduty.getNationList", langMap);
        return dataList;
    }

    /**
     * getLangCd 설명
     * @param domCd
     * @return
     */
    public String getLangCd(Integer domCd) {
        String rtnCd = (String) selectByPk("_commonduty.getLangCd", domCd);
        return rtnCd;
    }
    
    /**
     * serviceLangList 설명
     * @param tvo
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List serviceLangList() {
        
        List dataList = list("_commonduty.getServiceLangList", null);
        return dataList;
        
    }

    /**
     * getLangToUrl 설명
     * @param langCd
     * @return langCd
     */
    public String getLangToUrl(String langCd) {
        HashMap<String, Object> langMap = new HashMap<String, Object>();
        String rtn = "";
        langMap.put("langCd", langCd);
        String data = selectByPk("_commonduty.getLangToUrl", langMap) != null ? (String)selectByPk("_commonduty.getLangToUrl", langMap) : "";
        if(Validate.isNotEmpty(data)){
            rtn = "http://" + data;
        }
        return rtn;
    }

    private final String HIGH_TREE_CD = String.valueOf(GlobalConfig.HIGH_TREE_CD);
    
    /**
     * categoryList 설명
     * @param request
     * @return
     */
    public List<TreeVO> categoryList(CategoryVO vo) {
        if(Validate.isEmpty(vo.getUpperMenuCd())) {
            vo.setUpperMenuCd(HIGH_TREE_CD);            
        }
        
        return list("_commonduty.treeList", vo);
    }
    
    /**
     * eventList 설명
     * @param evo
     * @return
     */
    public List<WebEventVO> eventList(WebEventVO evo) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("cutTitleEventNum", MainConstant.CUT_TITLE_EVENT_NUM);    // 제목이 길 경우 자를 글자수
        parameterMap.put("rowNum", MainConstant.RECENT_EVENT_COUNT);               // 최근 게시물 가져올 갯수
        parameterMap.put("domainCd", evo.getDomainCd());
        parameterMap.put("ctgryClCd", evo.getCtgryClCd());
        return list("_commonduty.eventRecentList", parameterMap);
    }

    /**
     * ctgryList 설명
     * @param cVo
     * @return
     */
    public List<TreeVO> ctgryList(CategoryVO cvo) {
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("ctgryClCd", cvo.getCtgryClCd());          // 카테고리분류코드
        parameterMap.put("upperMenuCd", cvo.getUpperMenuCd());      // 상위카테고리코드
        parameterMap.put("langCd", cvo.getLangCd());                // 언어코드
        return list("_commonduty.getCtgryList", parameterMap);
    }

    /**
     * getCtgryUpperCd 설명
     * @param cvo
     * @return
     */
    public String getCtgryUpperCd(CategoryVO cvo) {
        HashMap<String,Object> ccMap = new HashMap<String,Object>();
        ccMap.put("ctgryClCd", cvo.getCtgryClCd());          // 카테고리분류코드
        ccMap.put("langCd", cvo.getLangCd());                // 언어코드
        return (String) selectByPk("_commonduty.getCtgry2DpList", ccMap);
    }

    public Integer popupShowCount(PopupVO vo) {
        return update("_commonduty.expsrCoUp", vo);
    }

    public Integer bannerClickCount(BannerVO vo) {
        return update("_commonduty.bannerClickCoUp", vo);
    }
}
