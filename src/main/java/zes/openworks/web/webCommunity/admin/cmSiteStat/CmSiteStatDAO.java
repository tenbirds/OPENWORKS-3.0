/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmSiteStat;

import org.springframework.stereotype.Repository;

import zes.openworks.intra.analyze.statistic.common.ResultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
@Repository
public class CmSiteStatDAO  extends EgovAbstractMapper {
    
    /**
     * 커뮤니티 방문자수 통계
     */
    public ResultVO cmSiteVisitCountStat(CmSiteStatVO vo) {
        return (ResultVO)selectByPk("_cmSiteStat.cmSiteVisitCountStat", vo);
    }

    /**
     * 커뮤니티 게시글수 통계
     */
    public ResultVO cmSiteBoardCountStat(CmSiteStatVO vo) {
        return (ResultVO)selectByPk("_cmSiteStat.cmSiteBoardCountStat", vo);
    }

    /**
     * 커뮤니티  덧글수 통계 
     */
    public ResultVO cmSiteBoardCmtCountStat(CmSiteStatVO vo) {
        return (ResultVO)selectByPk("_cmSiteStat.cmSiteBoardCmtCountStat", vo);
    }
    
    
    /**
     * 커뮤니티  페이지 뷰 통계 
     */
    public ResultVO cmSitePageViewCountStat(CmSiteStatVO vo) {
        return (ResultVO)selectByPk("_cmSiteStat.cmSitePageViewCountStat", vo);
    }
    
    
}
