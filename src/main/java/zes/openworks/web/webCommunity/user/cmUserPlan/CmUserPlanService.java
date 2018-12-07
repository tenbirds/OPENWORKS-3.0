/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserPlan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


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
 * 2014. 12. 2.    		 boseok       	신규
 *</pre>
 * @see
 */
public interface CmUserPlanService {

    /**
    *  일정관리 달력
    * @param vo
    * @return  
    */
    List<CmUserPlanVO> cmUserPlanCalList(CmUserPlanVO vo);
    
    /**
     *  일정관리 달력 상세
     * 
     * @param vo
     * @return
     */
    CmUserPlanVO cmUserPlanCalView(CmUserPlanVO vo);
    
    /**
     * 일정관리 달력 등록
     * @param vo
     * @return  
     */ 
    
    String cmUserPlanCalInsert(HttpServletRequest request, CmUserPlanVO vo);
    
    /**
     * 일정관리 달력 수정
     * @param vo
     * @return  
     */ 
    
    String cmUserPlanCalUpdate(HttpServletRequest request, CmUserPlanVO vo);
    
    /**
     * 일정관리 달력 삭제
     * @param vo
     * @return  
     */ 
    
    String cmUserPlanCalDelete(HttpServletRequest request, CmUserPlanVO vo);
    
}
