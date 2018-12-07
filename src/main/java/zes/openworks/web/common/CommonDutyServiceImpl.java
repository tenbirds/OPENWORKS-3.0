/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.common;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.vo.TreeVO;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.popup.PopupVO;
import zes.openworks.intra.store.category.CategoryVO;
import zes.openworks.web.webevent.WebEventVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

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
@Service("CommonDutyService")
public class CommonDutyServiceImpl extends AbstractServiceImpl implements CommonDutyService {

    @Resource
    private CommonDutyDAO dao;
    
    @SuppressWarnings("rawtypes")
    @Override
    public List countryList(String langCode) {

        return dao.countryList(langCode);
    }

    @Override
    public String getLangCd(Integer domCd) {
        return dao.getLangCd(domCd);
    }

    @Override
    @SuppressWarnings("rawtypes")
    public List serviceLangList() {
        return dao.serviceLangList();
    }
    
    @Override
    public String getLangToUrl(String langCd) {
        return dao.getLangToUrl(langCd);
    }

    @Override
    public void categoryIndex(CategoryVO vo) {
    }
    
    @Override
    public List<TreeVO> categoryList(CategoryVO vo) {
        return dao.categoryList(vo);
    }
    
    @Override
    public List<WebEventVO> eventList(WebEventVO evo) {

        return dao.eventList(evo);
    }

    @Override
    public List<TreeVO> ctgryList(CategoryVO cvo) {

        return dao.ctgryList(cvo);
    }

    @Override
    public String getCtgryUpperCd(CategoryVO cvo) {
        
        return dao.getCtgryUpperCd(cvo);
    }

    @Override
    public Integer popupShowCount(PopupVO vo) {
        return dao.popupShowCount(vo);
    }

    @Override
    public Integer bannerClickCount(BannerVO vo) {
        return dao.bannerClickCount(vo);
    }
}
