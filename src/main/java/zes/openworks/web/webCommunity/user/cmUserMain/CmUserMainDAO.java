/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMain;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
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
 * 2014. 11. 28.    		 boseok       	신규
 *</pre>
 * @see
 */
@Repository
public class CmUserMainDAO  extends EgovAbstractMapper {

    /**
     * 커뮤니티 사용자 메인 페이지  리스트 메뉴 (게시판 포함)
     * @param vo
     * @return  
     */
    @SuppressWarnings("unchecked")
    public List<CmManageVO> cmUserMainMenuList(CmManageVO vo){
       // logger.info("vo-->>>>>>>>>>>>>>>."+vo.getOthbcSetupCdChk());
        return list("_cmUserMain.cmUserMainMenuList", vo);
    }
}
