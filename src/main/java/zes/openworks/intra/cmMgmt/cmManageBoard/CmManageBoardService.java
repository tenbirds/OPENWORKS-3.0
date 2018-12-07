/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManageBoard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
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
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
public interface CmManageBoardService {
    
    /**
     *  커뮤니티 게시물 관리 목록
     * @param vo
     * @return pager  
     */
    Pager<CmManageVO> cmManageBoardList(CmManageVO vo);
    
    
    
    /**  
     * 커뮤니티  게시판 목록
     * @param vo
     * @return pager  
    */
  Pager<CmManageBoardVO> cmManageBBSList(CmManageBoardVO vo);
  
  
  /**  
   * 사용자 게시판 리스트
   * @param vo
   * @return pager  
  */
  List<CmManageVO> cmMberMenuSelect(CmManageVO vo);
 
  /**
   * 커뮤니티 게시판 관리자 완전 삭제
   * @param vo
   * @return  
   */ 
   String cmManageBBSDelete(HttpServletRequest request, CmManageBoardVO vo);
 
   /**
    * 커뮤니티 게시판 관리자 일반 삭제
    * @param vo
    * @return  
    */ 
    String cmManageBBSDelUpdate(HttpServletRequest request, CmManageBoardVO vo);

}
