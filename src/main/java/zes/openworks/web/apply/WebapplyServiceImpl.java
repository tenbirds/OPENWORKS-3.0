/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.apply;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.component.file.FileDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("WebapplyService")
public class WebapplyServiceImpl extends AbstractServiceImpl implements WebapplyService {

    @Resource
    private WebapplyDAO dao;

    @Resource
    private FileDAO fileDao;
    
    @Override
    public Pager<ApplyManageVO> applyList(ApplyManageVO vo) {
        return dao.applyList(vo);
    }

    @Override
    public ApplyManageVO bidRequestMasterInfo(ApplyManageVO vo){
        return dao.bidRequestMasterInfo(vo);
    }
    @Override
    public ApplyManageVO bidSupplierMasterInfo(ApplyManageVO vo){
        return dao.bidSupplierMasterInfo(vo);
    }   

    @Override
    public List<ApplyManageVO> bidIaaSInfoDB(ApplyManageVO vo){
        return dao.bidIaaSInfoDB(vo);
    }

    @Override
    public List<ApplyManageVO> bidIaaSInfoServer(ApplyManageVO vo){
        return dao.bidIaaSInfoServer(vo);
    }
    
    @Override
    public List<ApplyManageVO> bidIaaSInfo(ApplyManageVO vo){
        return dao.bidIaaSInfo(vo);
    }   

    @Override
    public List<ApplyManageVO> bidSaaSInfoOne(ApplyManageVO vo){
        return dao.bidSaaSInfoOne(vo);
    }

    @Override
    public ApplyManageVO bidPaaSInfoOne(ApplyManageVO vo){
        return dao.bidPaaSInfoOne(vo);
    }
    
    @Override
    public ApplyManageVO bidPaaSInfoTwo(ApplyManageVO vo) {

        return dao.bidPaaSInfoTwo(vo);
    }
    
    
    @Override
    public ApplyManageVO applycomplete(ApplyManageVO vo){
        return dao.applycomplete(vo);
    }
    @Override
    public List<ApplyManageVO> bidSaaSInfoTwo(ApplyManageVO vo){
        return dao.bidSaaSInfoTwo(vo);
    }
    
    @Override
    public int bidSaaSInsertSaaSD(ApplyManageVO vo) {
        return dao.bidSaaSInsertSaaSD(vo);
    }
    @Override
    public int bidSaaSInsertSaaSI(ApplyManageVO vo) {
        return dao.bidSaaSInsertSaaSI(vo);
    }
    @Override
    public int bidSaaSUpdateSaaSD(ApplyManageVO vo) {
        return dao.bidSaaSUpdateSaaSD(vo);
    }
    @Override
    public int bidSaaSUpdateSaaSI(ApplyManageVO vo) {
        return dao.bidSaaSUpdateSaaSI(vo);
    }
    @Override
    public int bidUpdate(ApplyManageVO vo) {
        return dao.bidUpdate(vo);
    }



    /* (non-Javadoc)
     * @see zes.openworks.web.apply.WebapplyService#bidPaaSInsert(zes.openworks.web.apply.ApplyManageVO)
     */
    @Override
    public int bidPaaSInsert(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidPaaSInsert(vo);
    }
    @Override
    public int bidPaaSUpdate(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidPaaSUpdate(vo);
    }
    @Override
    public int bidIaaSInsertIaaSI(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidIaaSInsertIaaSI(vo);
    }
    @Override
    public int bidIaaSUpdateIaaSI(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidIaaSUpdateIaaSI(vo);
    }
    @Override
    public int bidIaaSInsertIaaSDS(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidIaaSInsertIaaSDS(vo);
    }
    @Override
    public int bidIaaSInsertIaaSDD(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidIaaSInsertIaaSDD(vo);
    }
    @Override
    public int bidIaaSUpdateIaaSDS(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidIaaSUpdateIaaSDS(vo);
    }
    @Override
    public int bidIaaSUpdateIaaSDD(ApplyManageVO vo) {
        // TODO Auto-generated method stub
        return dao.bidIaaSUpdateIaaSDD(vo);
    }

    
    
    
    
    
    @Override
    public ApplyManageVO applyPopUp(ApplyManageVO vo){
        return dao.applyPopUp(vo);
    }
    @Override
    public int applyPopUpInsert(ApplyManageVO vo){
        return dao.applyPopUpInsert(vo);
    }
    @Override
    public int applyPopUpUpdate(ApplyManageVO vo){
        return dao.applyPopUpUpdate(vo);
    }
}
