/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.myCm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
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
 * 2014. 11. 30.    		 boseok       	신규
 *</pre>
 * @see
 */
@Repository
public class MyCmDAO extends EgovAbstractMapper {

    
    /**  
     * 커뮤니티 가입 회원 목록
     * @param vo
     * @return pager  
    */
    @SuppressWarnings("unchecked")
    public Pager<CmManageVO> cmMberInfoList(CmManageVO vo){
       Map<String, Object> paraMap = vo.getDataMap();
       
       paraMap.put("cmmntyId", vo.getCmmntyId());
       paraMap.put("langCode", vo.getLangCode());
       paraMap.put("userId", vo.getUserId());
       
       
       List<CmManageVO> myCmJoinList = list("_myCm.myCmJoinList", paraMap);
       vo.setTotalNum((Integer)selectByPk("_myCm.myCmJoinListCount",paraMap));
       return new Pager<CmManageVO>(myCmJoinList, vo);  
    }
    
    /**  
     * 커뮤니티 개설 커뮤니티 
     * @param vo
     * @return pager  
    */
    @SuppressWarnings("unchecked")
    public Pager<CmManageVO> myCmOpenList(CmManageVO vo){
       Map<String, Object> paraMap = vo.getDataMap();
       
       paraMap.put("cmmntyId", vo.getCmmntyId());
       paraMap.put("langCode", vo.getLangCode());
       paraMap.put("userId", vo.getUserId());
       
       
       List<CmManageVO> myCmJoinList = list("_myCm.myCmOpenList", paraMap);
       vo.setTotalNum((Integer)selectByPk("_myCm.myCmOpenListCount",paraMap));
       return new Pager<CmManageVO>(myCmJoinList, vo);  
    }
    
    
}
