/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManageBoard;

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
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
@Repository
public class CmManageBoardDAO extends EgovAbstractMapper {

      /**  
         * 커뮤니티  게시물 관리 목록
         * @param vo
         * @return pager  
        */
       @SuppressWarnings("unchecked")
        public Pager<CmManageVO> cmManageBoardList(CmManageVO vo){
           Map<String, Object> paraMap = vo.getDataMap();
           paraMap.put("cmmntyMenuCode","2002"); 
           List<CmManageVO> cmManageBoardList = list("_cmManageBoard.cmManageBoardList", paraMap);
           vo.setTotalNum((Integer)selectByPk("_cmManageBoard.cmManageBoardListCount",paraMap));
           return new Pager<CmManageVO>(cmManageBoardList, vo);  
       }
   
       /**
        * 커뮤니티 게시판 등록
        * @param vo
        * @return  
        */ 
       
       public int cmManageBBSInsert(CmManageBoardVO vo){
           return (Integer) insert("_cmManageBoard.cmManageBBSInsert",vo);
       }
   
       /**  
        * 커뮤니티  게시판 목록
        * @param vo
        * @return pager  
       */
      @SuppressWarnings("unchecked")
       public Pager<CmManageBoardVO> cmManageBBSList(CmManageBoardVO vo){
          Map<String, Object> paraMap = vo.getDataMap();
          paraMap.put("langCode",vo.getLangCode()); 
          paraMap.put("cmmntyId",vo.getCmmntyId()); 
          paraMap.put("cmmntyMenuCode",vo.getCmmntyMenuCode()); 
          List<CmManageBoardVO> cmManageBBSList = list("_cmManageBoard.cmManageBBSList", paraMap);
          vo.setTotalNum((Integer)selectByPk("_cmManageBoard.cmManageBBSListCount",paraMap));
          return new Pager<CmManageBoardVO>(cmManageBBSList, vo);  
      }
  
      /**  
       * 사용자 게시판 리스트
       * @param vo
       * @return pager  
      */
     @SuppressWarnings("unchecked")
      public List<CmManageVO> cmMberMenuSelect(CmManageVO vo){
         Map<String, Object> paraMap = vo.getDataMap();
         paraMap.put("langCode",vo.getLangCode());
         paraMap.put("cmmntyId",vo.getCmmntyId());
         paraMap.put("cmmntyMenuCode",vo.getCmmntyMenuCode()); // 일정관리 제외
         return  list("_cmManageBoard.cmMberMenuSelect", paraMap);
     }
     
     /**
      * 커뮤니티 게시판 관리자 완전 삭제
      * @param vo
      * @return  
      */ 
     
     public int cmManageBBSDelete(CmManageBoardVO vo){
         return (Integer) insert("_cmManageBoard.cmManageBBSDelete",vo);
     }
     
     /**
      * 커뮤니티 게시판 관리자 댓글 완전 삭제
      * @param vo
      * @return  
      */ 
     
     public int cmManageBBSCmtDelete(CmManageBoardVO vo){
         return (Integer) insert("_cmManageBoard.cmManageBBSCmtDelete",vo);
     }
 
}
