/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMenu;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
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
 * 2014. 11. 13.    		 boseok       	신규
 *</pre>
 * @see
 */
@Repository
public class CmUserMenuDAO   extends EgovAbstractMapper {

    /**
     *  커뮤니티 사용자 왼쪽 메뉴
     * @param vo
     * @return  
     */
    @SuppressWarnings("unchecked")
    public List<CmManageVO> cmUserMenuList(CmManageVO vo){
        
        return list("_cmUserMenu.cmUserMenuList", vo);
    }
    
    /**
     *  커뮤니티 사용자 왼쪽메뉴 상세
     * @param vo
     * @return  
     */
     public CmManageVO cmUserMenuView(CmManageVO vo){
         return (CmManageVO) selectByPk("_cmUserMenu.cmUserMenuView", vo);
     }   

    /**
     *  커뮤니티 회원 정보
     * @param vo
     * @return  
     */
     public CmManageVO cmUserMberInfo(CmManageVO vo){
         return (CmManageVO) selectByPk("_cmUserMenu.cmUserMberInfo", vo);
     }   
     
     /**
      *  커뮤니티 회원 작성글
      * @param vo
      * @return  
      */
      public int cmUserCmmntyBBSCount(CmManageVO vo){
          return (Integer) selectByPk("_cmUserMenu.cmUserCmmntyBBSCount", vo);
      }   
     
      /**
       *  커뮤니티 회원 댓글
       * @param vo
       * @return  
       */
       public int cmUserCmmntyBBSCmtCount(CmManageVO vo){
           return (Integer) selectByPk("_cmUserMenu.cmUserCmmntyBBSCmtCount", vo);
       }   
       
       /**
        *  커뮤니티 방문 횟수
        * @param vo
        * @return  
        */
        public int cmUserCmmntyVisitLogCount(CmManageVO vo){
            return (Integer) selectByPk("_cmUserMenu.cmUserCmmntyVisitLogCount", vo);
        } 
        
        /**
         *  커뮤니티 회원 정보
         * @param vo
         * @return  
         */
         public CmManageVO cmUserCmmntyVisitLogSelete(CmManageVO vo){
             return (CmManageVO) selectByPk("_cmUserMenu.cmUserCmmntyVisitLogSelete", vo);
         }   
        
         /**  
          * 커뮤니티 가입 작성글 목록
          * @param vo
          * @return pager  
         */
         @SuppressWarnings("unchecked")
         public Pager<CmManageBoardVO> cmUserWriteReplyList(CmManageBoardVO vo){
            Map<String, Object> paraMap = vo.getDataMap();
            
            paraMap.put("cmmntyId", vo.getCmmntyId());
            paraMap.put("langCode", vo.getLangCode());
            paraMap.put("userId", vo.getUserId());
            paraMap.put("writeReplyChk", vo.getWriteReplyChk());
            paraMap.put("registId", vo.getRegistId());
            
            List<CmManageBoardVO> cmUserWriteReplyList = list("_cmUserMenu.cmUserWriteReplyList", paraMap);
            vo.setTotalNum((Integer)selectByPk("_cmUserMenu.cmUserWriteReplyListCount",paraMap));
            return new Pager<CmManageBoardVO>(cmUserWriteReplyList, vo);  
         }
         
         
         /**
          * 사용자  커뮤니티 로그 저장
          * @param vo
          * @return  
          */ 
         
         public int cmUserVsitAnalInsert(CmManageVO vo){
             return (Integer) insert("_cmUserMenu.cmUserVsitAnalInsert",vo);
         }
         
         /** 사용자 커뮤니티 로그 중복체크
          * @param vo
          * @return  
          */ 
         
         public int cmUserVsitAnalSelect(CmManageVO vo){
             return (Integer) selectByPk("_cmUserMenu.cmUserVsitAnalSelect",vo);
         }
         
         
         /**
          * 사용자  커뮤니티별페이지로그분석통계 저장
          * @param vo
          * @return  
          */ 
         
         public int cmUserPgeAnalInsert(CmManageVO vo){
             return (Integer) insert("_cmUserMenu.cmUserPgeAnalInsert",vo);
         }
}
