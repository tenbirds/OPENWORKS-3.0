/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.userGuide;

import java.util.List;
import org.springframework.stereotype.Repository;
import zes.openworks.intra.cms.CmsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import java.util.Map;
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
@Repository
public class UserGuideDAO extends EgovAbstractMapper {
    /**
     * getMenuList 설명
     * @param cmsVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<CmsVO> getMenuList(CmsVO cmsVo) {
        return list("_userguide.getAllMenuList", cmsVo);
    }
    
    
    /**
     * getCtgryList 설명
     * @param cmsVo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<CmsVO> getCtgryList(Map map) {
        return list("_userguide.getCtgryList", map);
    }
    
}
