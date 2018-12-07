/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMain;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
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

@Service("cmUserMainServiceService")
public class CmUserMainServiceImpl extends AbstractServiceImpl implements CmUserMainService{

    @Resource
    private CmUserMainDAO dao;

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMain.CmUserMainService#cmUserMainMenuList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public List<CmManageVO> cmUserMainMenuList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserMainMenuList(vo);
    }
}
