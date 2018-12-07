/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.myCm;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


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
 * 2014. 11. 30.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("myCmService") 
public class MyCmServiceImpl extends AbstractServiceImpl implements MyCmService{
    
    @Resource
    private MyCmDAO dao;
    /* (non-Javadoc)
     * @see zes.openworks.web.myCm.MyCmService#cmMberInfoList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageVO> cmMberInfoList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmMberInfoList(vo);
    }
    /* (non-Javadoc)
     * @see zes.openworks.web.myCm.MyCmService#myCmOpenList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageVO> myCmOpenList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.myCmOpenList(vo);
    }

}
