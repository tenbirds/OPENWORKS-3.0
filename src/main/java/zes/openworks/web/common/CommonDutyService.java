/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.common;

import java.util.List;

import zes.base.vo.TreeVO;
import zes.openworks.intra.banner.BannerVO;
import zes.openworks.intra.popup.PopupVO;
import zes.openworks.intra.store.category.CategoryVO;
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
public interface CommonDutyService {
    /**
     * 국가코드정보 가져오기
     * @return
     */
    @SuppressWarnings("rawtypes")
    List countryList(String langCode);

    /**
     * 도메인코드로 서비스언어코드 가져오기
     */
    String getLangCd(Integer domCd);
    
    
    /**
     * serviceLangList
     * @return
     */
    @SuppressWarnings("rawtypes")
    List serviceLangList();
    
    /**
     * 서비스언어로 URL 가져오기(http://subdomain.domain.com/eng/형태)
     */
    String getLangToUrl(String langCd);
    
    
    void categoryIndex(CategoryVO vo);
    

    List<TreeVO> categoryList(CategoryVO vo);
    
    /**
     * eventList 설명
     * @param evo
     * @return
     */
    List<WebEventVO> eventList(WebEventVO evo);

    /**
     * ctgryList 설명
     * @param cVo
     * @return
     */
    List<TreeVO> ctgryList(CategoryVO cvo);

    /**
     * getCtgryUpperCd 설명
     * @param cvo
     * @return
     */
    String getCtgryUpperCd(CategoryVO cvo);

    Integer popupShowCount(PopupVO vo);

    Integer bannerClickCount(BannerVO vo);
}
