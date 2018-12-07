/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.userGuide;

import java.util.List;
import java.util.Map;

import zes.openworks.intra.cms.CmsVO;

/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 12. 13.    김영상       신규
 *</pre>
 * @see
 */
public interface UserGuideService {
    /**
     * 메뉴정보 목록 조회    
     * 
     * @param CmsVO cmsVo
     * @return
     */
    List<CmsVO> getMenuList(CmsVO cmsVo) throws Exception;
    
    /**
     * 캍ㅔ고리 목록 조회    
     * 
     * @param CmsVO cmsVo
     * @return
     */
    List<CmsVO> getCtgryList( Map map) throws Exception;
}
