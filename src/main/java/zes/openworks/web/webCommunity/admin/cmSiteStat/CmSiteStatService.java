/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmSiteStat;

import zes.openworks.intra.analyze.statistic.common.ResultVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 12. 16.    		 boseok       	신규
 *</pre>
 * @see
 */
public interface CmSiteStatService {

    /**
     * 커뮤니티 방문자수 통계
     */
    ResultVO cmSiteVisitCountStat(CmSiteStatVO vo);

    /**
     * 커뮤니티 게시글수 통계
     */
    ResultVO cmSiteBoardCountStat(CmSiteStatVO vo);

    /**
     * 커뮤니티  덧글수 통계 
     */
    ResultVO cmSiteBoardCmtCountStat(CmSiteStatVO vo);
    
    
    
    /**
     * 커뮤니티  페이지뷰 통계 
     */
    ResultVO  cmSitePageViewCountStat(CmSiteStatVO vo);
}
