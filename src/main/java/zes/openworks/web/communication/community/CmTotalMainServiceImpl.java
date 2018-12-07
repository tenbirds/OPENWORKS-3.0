/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.communication.community;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageDAO;
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
 * 2014. 11. 11.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmTotalMainService") 
public class CmTotalMainServiceImpl extends AbstractServiceImpl implements CmTotalMainService{

    
    @Resource
    private CmTotalMainDAO dao;
    
    @Resource
    private CmManageDAO cmManageDAO;
    
    @Resource 
    private FileDAO fileDao;
    /* (non-Javadoc)
     * @see zes.openworks.web.communication.community.CmTotalMainService#cmTotalMainList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageVO> cmTotalMainList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmTotalMainList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.communication.community.CmTotalMainService#openCmUserInsert(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String openCmUserInsert(HttpServletRequest request, CmManageVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        String logoYN = vo.getLogoDirectRegistAt();
        vo.setCmmntySttusCd(1001); //  1001:신청     1002:승인     1003:승인보류    1004: 폐쇄
        
        int logoFileSeq = 1;
        
        if("Y".equals(logoYN)){ // LogoDirectRegistAt 
            List<FileVO> fileList  = UploadHelper.upload( request, "cmmntylogo");
            if(fileList.size()> 0){
                logoFileSeq = fileDao.saveFile(fileList);
            }
            vo.setLogoFileSeq(logoFileSeq);
            // 기본값으로 등록
            vo.setLogoTitleWidthLc(100); 
            vo.setLogoTitleVrticlLc(100);
            vo.setLogoTitleFont("batang");
            vo.setLogoTitleColor("000000");
            vo.setLogoTitle("Open Market Place");
            vo.setLogoTitleFontSize(40);
        }else if("N".equals(logoYN)){
            vo.setLogoFileSeq(1);
        }
        intResult1 = cmManageDAO.openCmManageUserInsert(vo);

        if(intResult1>0){
            strResult = "Y";
        }
        return strResult;
    }

}
