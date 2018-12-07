/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserBoard;

//import java.util.List;

import javax.servlet.http.HttpServletRequest;

import zes.base.pager.Pager;
//import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
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
 * 2014. 11. 17.    		 boseok       	신규
 *</pre>
 * @see
 */
public interface CmUserBoardService {

    
    /**  
     * 커뮤니티  사용자 게시판 목록
     * @param vo
     * @return pager  
    */
    Pager<CmManageBoardVO> cmUserBoardList(CmManageBoardVO vo);
    

    /**
     * 커뮤니티 사용자게시판 상세
     */
    CmManageBoardVO cmUserBoardView(CmManageBoardVO vo);
    
    /**
     * 커뮤니티 게시판 등록
     * @param vo
     * @return  
     */ 
    String cmUserBoardInsert(HttpServletRequest request, CmManageBoardVO vo);
    
    /**
     * 커뮤니티 게시판 수정
     * @param vo
     * @return  
     */ 
    String cmUserBoardUpdate(HttpServletRequest request, CmManageBoardVO vo);
    
    
    /**
     * 커뮤니티 게시판 수정 삭제
     * @param vo
     * @return  
     */ 
    String cmUserBoardDelUpdate(HttpServletRequest request, CmManageBoardVO vo);
    
    /**
     *  커뮤니티 게시판 파일 삭제
     * @param vo
     * @return   
     */
    String fileDelUpdate(HttpServletRequest request, CmManageBoardVO vo);
    

    /**
     *  커뮤니티 게시판 개별 삭제 처리
     * @param vo
     * @return   
     */
    String fileEachDelUpdate(HttpServletRequest request, CmManageBoardVO vo);
    
    /**  
     * 커뮤니티 게시판 댓글 목록
     * @param vo
     * @return pager  
    */
   Pager<CmManageBoardVO> cmUserBoardCmtList(CmManageBoardVO vo);
   
   /**
    * 커뮤니티 게시판 댓글 등록
    * @param vo
    * @return  
    */ 
   
   String cmUserBoardCmtInsert(HttpServletRequest request, CmManageBoardVO vo);
   
   /**
    * 커뮤니티 게시판 댓글 수정
    * @param vo
    * @return  
    */ 
   String  cmUserBoardCmtUpdate(HttpServletRequest request, CmManageBoardVO vo);
   
   /**
    * 커뮤니티 게시판 댓글 삭제
    * @param vo
    * @return  
    */ 
   String cmUserBoardCmtReplyDelete(HttpServletRequest request, CmManageBoardVO vo);
   
   /**
    * 커뮤니티 게시판 댓글 폼 조회
    * @param vo
    * @return  
    */ 
   CmManageBoardVO cmUserBoardCmtView(CmManageBoardVO vo);
   
   /**
    * 커뮤니티 게시판 본인 작성 글 카운트
    * @param vo
    * @return  
    */ 
   int cmUserWriteBoardListCount(CmManageBoardVO vo );
   
   /**
    * 커뮤니티 게시판 답변
    * @param vo
    * @return  
    */ 
   String  cmUserBoardAnswerUpdate(HttpServletRequest request, CmManageBoardVO vo);
}
