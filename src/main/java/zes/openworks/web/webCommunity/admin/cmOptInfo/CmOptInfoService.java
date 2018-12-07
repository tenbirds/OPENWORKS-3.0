/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptInfo;

import javax.servlet.http.HttpServletRequest;

import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;


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
 * 2014. 11. 4.    		 boseok       	신규
 *</pre>
 * @see
 */
public interface CmOptInfoService {
    
    /**
     *  커뮤니티 정보 수정 및 폐쇄
     * @param vo
     * @return  
     */
    String cmOptInfoUpdate(HttpServletRequest request , CmManageVO vo);
    
    
    /**
     * 커뮤니티 폐쇄 처리
     * @param vo
     * @return  
     */
    String closeCmOptInfoUpdate(HttpServletRequest request, CmManageVO vo) throws Exception;
    
    /**
     * 커뮤니티 폐쇄 취소
     * @param vo
     * @return  
     */
    String closeCancleCmOptInfoUpdate(HttpServletRequest request, CmManageVO vo) throws Exception;

}
