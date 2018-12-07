/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManageBoard;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardDAO;
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
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
@Service("cmManageBoardService") 
public class CmManageBoardServiceImpl extends AbstractServiceImpl implements CmManageBoardService{
    
    @Resource
    private CmUserBoardDAO cmUserBoardDao;
    
    @Resource
    private CmManageBoardDAO dao;
    
    @Resource 
    private FileDAO fileDao;
    

    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService#cmManageBoardList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageVO> cmManageBoardList(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmManageBoardList(vo); 
    }


    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService#cmManageBBSList(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public Pager<CmManageBoardVO> cmManageBBSList(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        return dao.cmManageBBSList(vo); 
    }


    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService#cmMberMenuSelect(zes.openworks.intra.cmMgmt.cmManage.CmManageVO)
     */
    @Override
    public List<CmManageVO> cmMberMenuSelect(CmManageVO vo) {
        // TODO Auto-generated method stub
        return dao.cmMberMenuSelect(vo); 
    }


    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService#cmManageBBSDelete(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public String cmManageBBSDelete(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult = 0;
        String[] strSplit1;
        String[] strSplit2;
        String ckMultiBoxValue = vo.getMultiCheck();

        strSplit1 = ckMultiBoxValue.split(",");
       // int intMberStateCd = vo.getMberStateCd();

        /**
         *  DELETE FROM 
                TCM_NTT_TAG_I 
            WHERE 
                LANG_CODE               = #{langCode}  
                AND CMMNTY_ID           = #{cmmntyId} 
                AND CMMNTY_MENU_CODE    = #{cmmntyMenuCode}   
                AND CMMNTY_BBS_SEQ      = #{cmmntyBbsSeq} 
         */
        if(strSplit1 != null){
            for(int i=0; i<strSplit1.length; i++ ){
                CmManageBoardVO cmbvo = new CmManageBoardVO();
                
              
                strSplit2 = strSplit1[i].split("_"); // <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMenuCode}'/>_<c:out value='${data.cmmntyBbsSeq}'/>_<c:out value='${data.registId}'/>"/>     
                log.info("strSplit2.[0]::::::????--cmmntyId--???>>>>>>>>>>>"+strSplit2[0]);
                log.info("strSplit2.[1]::::::????--langCode--???>>>>>>>>>>>"+strSplit2[1]);
                log.info("strSplit2.[2]::::::????--cmmntyMberId--???>>>>>>>>"+strSplit2[2]);

                cmbvo.setCmmntyId(strSplit2[0]);
                cmbvo.setLangCode(strSplit2[1]);
                cmbvo.setCmmntyMenuCode(strSplit2[2]);
                cmbvo.setCmmntyBbsSeq(Integer.parseInt(strSplit2[3]));
                
                intResult = cmUserBoardDao.cmUserBoardTagDelete(cmbvo); // 태그 삭제
                intResult = dao.cmManageBBSCmtDelete(cmbvo);
                if(intResult == 0 || intResult >0){
                    intResult =dao.cmManageBBSDelete(cmbvo);
                }
            }
            
            if(intResult > 0){
                strResult = "Y";
            }
        }
        return strResult;
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardService#cmManageBBSDelete(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public String cmManageBBSDelUpdate( HttpServletRequest request,  CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult = 0;
        String[] strSplit1;
        String[] strSplit2;
        String ckMultiBoxValue = vo.getMultiCheck();
        strSplit1 = ckMultiBoxValue.split(",");
       // int intMberStateCd = vo.getMberStateCd();
        
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        String strAccesIpAdres = request.getRemoteAddr();
        
       
        
        if(strSplit1 != null){
            for(int i=0; i<strSplit1.length; i++ ){
                CmManageBoardVO cmbvo = new CmManageBoardVO();
                
              
                strSplit2 = strSplit1[i].split("_"); // <c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMenuCode}'/>_<c:out value='${data.cmmntyBbsSeq}'/>_<c:out value='${data.registId}'/>"/>     
                log.info("strSplit2.[0]::::::????--cmmntyId--???>>>>>>>>>>>"+strSplit2[0]);
                log.info("strSplit2.[1]::::::????--langCode--???>>>>>>>>>>>"+strSplit2[1]);
                log.info("strSplit2.[2]::::::????--cmmntyMberId--???>>>>>>>>"+strSplit2[2]);
                log.info("strSplit2.[2]::::::????--cmmntyBbsSeq--???>>>>>>>>"+strSplit2[3]);
                log.info("strSplit2.[2]::::::????--registId--???>>>>>>>>"+strSplit2[4]);
                
                cmbvo.setAccessBrwsrAgent(strAccesBrwsrAgent);
                cmbvo.setAccessIpAdres(strAccesIpAdres);
                cmbvo.setWrterIpAdres(strAccesIpAdres);
                cmbvo.setUpdtId(vo.getUpdtId());
                
                cmbvo.setCmmntyId(strSplit2[0]);
                cmbvo.setLangCode(strSplit2[1]);
                cmbvo.setCmmntyMenuCode(strSplit2[2]);
                cmbvo.setCmmntyBbsSeq(Integer.parseInt(strSplit2[3]));
                cmbvo.setMngrDeleteAt(vo.getMngrDeleteAt());
                cmbvo.setCmtDeleteCd(1003); //댓글삭제코드   1001 작성자삭제 1002 운영자삭제 1003 관리자삭제
                intResult =  cmUserBoardDao.cmUserBoardCmtDelUpdate(cmbvo);
                
                if(intResult == 0 || intResult >0){
                    intResult = cmUserBoardDao.cmUserBoardDelUpdate(cmbvo);
                }
            }
            
            if(intResult > 0){
                strResult = "Y";
            }
        }
        return strResult;
    }
}
