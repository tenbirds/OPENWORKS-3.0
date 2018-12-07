/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserPlan;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
 * 2014. 12. 2.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmUserPlanService") 
public class CmUserPlanServiceImpl  extends AbstractServiceImpl implements CmUserPlanService{
    
    @Resource
    private CmUserPlanDAO dao;

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanService#cmUserPlanCalList(zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanVO)
     */
    @Override
    public List<CmUserPlanVO> cmUserPlanCalList(CmUserPlanVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserPlanCalList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanService#cmUserPlanCalView(zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanVO)
     */
    @Override
    public CmUserPlanVO cmUserPlanCalView(CmUserPlanVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserPlanCalView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanService#cmUserPlanCalInsert(javax.servlet.http.HttpServletRequest, zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserPlanCalInsert(HttpServletRequest request, CmUserPlanVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        try{
        intResult1 = dao.cmUserPlanCalInsert(vo);
        if(intResult1>0){
            strResult = "Y";
        } 
        }catch(Exception e){
          
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanService#cmUserPlanUpdate(zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanVO)
     */
    @Override
    public String cmUserPlanCalUpdate(HttpServletRequest request, CmUserPlanVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        try{
        intResult1 = dao.cmUserPlanCalUpdate(vo);
        if(intResult1>0){
            strResult = "Y";
        } 
        }catch(Exception e){
           
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanService#cmUserPlanDelete(javax.servlet.http.HttpServletRequest, zes.openworks.web.webCommunity.user.cmUserPlan.CmUserPlanVO)
     */
    @Override
    public String cmUserPlanCalDelete(HttpServletRequest request, CmUserPlanVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        try{
        intResult1 = dao.cmUserPlanCalDelete(vo);
        if(intResult1>0){
            strResult = "Y";
        } 
        }catch(Exception e){
            
        }
        return strResult;
    }
}
