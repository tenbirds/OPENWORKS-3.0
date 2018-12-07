/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptAdminMenu;

import java.util.List;


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
 * 2014. 11. 3.    		 boseok       	신규
 *</pre>
 * @see
 */
public interface CmOptAdminMenuService {

    /**
     *  커뮤니티 운영자 왼쪽 메뉴
     * @param vo
     * @return  
     */
   List<CmOptAdminMenuVO> cmOptAdminMenuList(CmOptAdminMenuVO vo);
}
