/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMenu;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;


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
 * 2014. 11. 13.    		 boseok       	신규
 *</pre>
 * @see
 */
public interface CmUserMenuService {
    
    /**
     *  커뮤니티 사용자 왼쪽 메뉴
     * @param vo
     * @return  
     */
     List<CmManageVO> cmUserMenuList(CmManageVO vo);
     
     /**
      *  커뮤니티 사용자 왼쪽메뉴 상세
      * @param vo
      * @return  
      */
      CmManageVO cmUserMenuView(CmManageVO vo);
     /**
      *  커뮤니티 회원 정보
      * @param vo
      * @return  
      */
      CmManageVO cmUserMberInfo(CmManageVO vo);
      
      /**
       *  커뮤니티 회원 작성글
       * @param vo
       * @return  
       */
       int cmUserCmmntyBBSCount(CmManageVO vo);
      
       /**
        *  커뮤니티 회원 댓글
        * @param vo
        * @return  
        */
        int cmUserCmmntyBBSCmtCount(CmManageVO vo);
        
        /**
         *  커뮤니티 방문 횟수
         * @param vo
         * @return  
         */
         int cmUserCmmntyVisitLogCount(CmManageVO vo);
        
         /**
         *  커뮤니티 회원 본인 탈퇴
         * @param vo
         * @return  
         */
        String cmMemberShipSecedeUpdate(CmManageVO vo);
        
        /**
         *  커뮤니티 로그
         * @param vo
         * @return  
         */
        CmManageVO cmUserCmmntyVisitLogSelete(CmManageVO vo);
        
        /**  
         * 커뮤니티 가입 작성글 목록
         * @param vo
         * @return pager  
        */
        Pager<CmManageBoardVO> cmUserWriteReplyList(CmManageBoardVO vo);
        
        
        /**
         * 사용자  커뮤니티 로그 저장
         * @param vo
         * @return  
         */ 
        
        void cmUserVsitLogInsert(CmManageVO vo);
        
        
        /**
         * 사용자  커뮤니티별페이지로그분석통계 저장
         * @param vo
         * @return  
         */ 
        
        void cmUserPgeAnalInsert(CmManageVO vo);

}
