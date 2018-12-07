/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserPlan;

import java.util.List;

import org.springframework.stereotype.Repository;

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
 * 2014. 12. 2.    		 boseok       	신규
 *</pre>
 * @see
 */
@Repository
public class CmUserPlanDAO extends EgovAbstractMapper {
    /**
     *  일정관리 달력
     * 
     * @param vo
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<CmUserPlanVO> cmUserPlanCalList(CmUserPlanVO vo) {
        return list("_cmUserPlan.cmUserPlanCalList", vo);
    }
    
    /**
     *  일정관리 달력 상세
     * 
     * @param vo
     * @return
     */
    public CmUserPlanVO cmUserPlanCalView(CmUserPlanVO vo) {
        return (CmUserPlanVO)selectByPk("_cmUserPlan.cmUserPlanCalView", vo);
    }
    
    /**
     * 일정관리 달력 등록
     * @param vo
     * @return  
     */ 
    
    public int cmUserPlanCalInsert(CmUserPlanVO vo){
        return (Integer) insert("_cmUserPlan.cmUserPlanCalInsert",vo);
    }
    
    /**
     * 일정관리 달력 수정
     * @param vo
     * @return  
     */ 
    
    public int cmUserPlanCalUpdate(CmUserPlanVO vo){
        return (Integer) update("_cmUserPlan.cmUserPlanCalUpdate",vo);
    }
    
    /**
     * 일정관리 달력 삭제
     * @param vo
     * @return  
     */ 
    
    public int cmUserPlanCalDelete(CmUserPlanVO vo){
        return (Integer) delete("_cmUserPlan.cmUserPlanCalDelete",vo);
    }
    
    
}
