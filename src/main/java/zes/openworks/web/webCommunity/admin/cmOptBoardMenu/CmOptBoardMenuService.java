/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptBoardMenu;

import java.util.List;

import zes.base.vo.TreeVO;


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
public interface CmOptBoardMenuService {

    /**
     *  커뮤니티 사용자 메뉴 리스트
     * @param vo
     * @return  
     */
    List<TreeVO> cmOptBoardMenuTreeList(CmOptBoardMenuVO vo);
    
    /**
     *  커뮤니티 사용자 메뉴 상세
     * @param vo
     * @return  
     */
    CmOptBoardMenuVO cmOptBoardMenuTreeView(CmOptBoardMenuVO vo);
    
    /**
     *  커뮤니티 사용자 메뉴 추가 
       * @param vo
       * @return  
       */
       String cmOptBoardMenuInsert(CmOptBoardMenuVO vo);
    /**
   *  커뮤니티 사용자 메뉴 수정 
     * @param vo
     * @return  
     */
    int cmOptBoardMenuUpdate(CmOptBoardMenuVO vo);

    /**
     * 새 정렬 정보 수정.
     */
    int cmOptBoardMenuSortOrdrUpdate(CmOptBoardMenuVO vo);
    
    
    /**
     * 메뉴 삭제 
     */
    String cmOptBoardMenuDelete(CmOptBoardMenuVO vo);
}
