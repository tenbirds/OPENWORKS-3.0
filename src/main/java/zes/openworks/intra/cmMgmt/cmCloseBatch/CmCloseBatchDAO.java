/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmCloseBatch;

import org.springframework.stereotype.Repository;

import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
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
public class CmCloseBatchDAO extends EgovAbstractMapper {

    
    
    public int cmCloseBatchCount(CmManageVO vo){
        return (Integer) selectByPk("_cmManage.cmCloseBatchCount",vo);
    }
    /**
     * 커뮤니티 완전 폐쇄 업데이트
     * @param vo
     * @return  
     */
    public int cmCloseBatchUpdate(CmManageVO vo){
        return (Integer) update("_cmManage.cmCloseBatchUpdate",vo);
    }
}
