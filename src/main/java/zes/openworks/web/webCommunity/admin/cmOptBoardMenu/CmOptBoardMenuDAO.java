/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptBoardMenu;

import java.util.List;

import org.springframework.stereotype.Repository;

import zes.base.vo.TreeVO;
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
 * 2014. 11. 5.    		 boseok       	신규
 *</pre>
 * @see
 */
@Repository
public class CmOptBoardMenuDAO  extends EgovAbstractMapper {
    
    /**
     *  커뮤니티 사용자 메뉴 리스트
     * @param vo
     * @return  
     */
    @SuppressWarnings("unchecked")
    public List<TreeVO> cmOptBoardMenuTreeList(CmOptBoardMenuVO vo) {
        
        return list("_cmOptBoardMenu.cmOptBoardMenuTreeList", vo);
    }
    
    /**
     *  커뮤니티 사용자 메뉴 상세
     * @param vo
     * @return  
     */
    public CmOptBoardMenuVO cmOptBoardMenuTreeView(CmOptBoardMenuVO vo){
        return (CmOptBoardMenuVO) selectByPk("_cmOptBoardMenu.cmOptBoardMenuTreeView", vo);
    }
    
    
    /**
   *  커뮤니티 사용자 메뉴 수정 
     * @param vo
     * @return  
     */
    public int cmOptBoardMenuUpdate(CmOptBoardMenuVO vo){
        return (Integer) update("_cmOptBoardMenu.cmOptBoardMenuUpdate", vo);
    }
    
    /**
     *  커뮤니티 사용자 메뉴 추가 
       * @param vo
       * @return  
       */
      public int cmOptBoardMenuInsert(CmOptBoardMenuVO vo){
          return (Integer) insert("_cmOptBoardMenu.cmOptBoardMenuInsert", vo);
      }
      
      /**
       *  커뮤니티 사용자 코드 추가 
         * @param vo
         * @return  
         */
    public int getCmmntyBBSCd(CmOptBoardMenuVO vo){
        return (Integer) selectByPk("_cmOptBoardMenu.getCmmntyBBSCd", vo);
    }
    /**
     *  커뮤니티 메뉴 코드 추가
     * @param vo
     * @return  
     */
    public String  getCmmntyMberMenuCode(CmOptBoardMenuVO vo){
        return (String) selectByPk("_cmOptBoardMenu.getCmmntyMberMenuCode", vo);
    }
    
    /**
     * 정렬 정보 목록 리스트
     */
    @SuppressWarnings("unchecked")
    public List<CmOptBoardMenuVO> cmOptBoardMenuSortOrdrList(CmOptBoardMenuVO vo){
        return list("_cmOptBoardMenu.cmOptBoardMenuSortOrdrList", vo);
    }
    /**
     * 새 정렬 정보 수정.
     */
    public int cmOptBoardMenuSortOrdrUpdate(CmOptBoardMenuVO vo){
        return (Integer) update("_cmOptBoardMenu.cmOptBoardMenuSortOrdrUpdate", vo);
    }
    
    
    /**
     * 메뉴 삭제 
     */
    public int cmOptBoardMenuDelete(CmOptBoardMenuVO vo){
        return (Integer) delete("_cmOptBoardMenu.cmOptBoardMenuDelete", vo);
    }
    
    
    /**
     * 메뉴 게시판 글 삭제 
     */
    public int cmOptBoardBBSDelete(CmOptBoardMenuVO vo){
        return (Integer) delete("_cmOptBoardMenu.cmOptBoardBBSDelete", vo);
    }
    
    
    /**
     * 메뉴 게시판 댓글 삭제
     */
    public int cmOptBoardCMTDelete(CmOptBoardMenuVO vo){
        return (Integer) delete("_cmOptBoardMenu.cmOptBoardCMTDelete", vo);
    }
}
