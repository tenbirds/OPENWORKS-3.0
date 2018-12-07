/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserMenu;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;
import zes.openworks.intra.cmMgmt.cmManage.CmManageDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
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
 * 2014. 11. 13.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmUserMenuService") 
public class CmUserMenuServiceImpl extends AbstractServiceImpl implements CmUserMenuService{

    @Resource
    private CmUserMenuDAO dao;
    
    @Resource
    private CmManageDAO cmManageDAO;
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmOptAdminMenuList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public List<CmManageVO> cmUserMenuList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserMenuList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserMberInfo(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO cmUserMberInfo(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserMberInfo(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserCmmntyBBSCount(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public int cmUserCmmntyBBSCount(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserCmmntyBBSCount(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserCmmntyBBSCmtCount(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public int cmUserCmmntyBBSCmtCount(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserCmmntyBBSCmtCount(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmMemberShipSecedeUpdate(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public String cmMemberShipSecedeUpdate(CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;

       intResult1 = cmManageDAO.cmMemberShipInfoUpdate(vo);
        
        if(intResult1>0){
            strResult = "Y";
        }
        
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserCmmntyVisitLogCount(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public int cmUserCmmntyVisitLogCount(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserCmmntyVisitLogCount(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserCmmntyVisitLogSelete(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO cmUserCmmntyVisitLogSelete(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserCmmntyVisitLogSelete(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserMenuView(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public CmManageVO cmUserMenuView(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserMenuView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserWriteReplyList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageBoardVO> cmUserWriteReplyList(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserWriteReplyList(vo);
    }


    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMain.CmUserMainService#cmUserVsitLogInsert(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cmUserVsitLogInsert(CmManageVO vo) {
        // TODO Auto-generated method stub
        int logCnt = dao.cmUserVsitAnalSelect(vo);
        
        if(logCnt ==0){
            dao.cmUserVsitAnalInsert(vo);
        }
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuService#cmUserPgeAnalInsert(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cmUserPgeAnalInsert(CmManageVO vo) {
        // TODO Auto-generated method stub
        dao.cmUserPgeAnalInsert(vo); 
    }
    

}
