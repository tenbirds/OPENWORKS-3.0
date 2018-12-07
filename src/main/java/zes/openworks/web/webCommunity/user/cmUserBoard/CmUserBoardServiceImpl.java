/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserBoard;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import zes.base.pager.Pager;
import zes.base.support.UploadHelper;
import zes.base.vo.FileVO;
import zes.core.utils.Converter;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.StringUtil;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageDAO;
import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
//import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardDAO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import zes.openworks.web.webCommunity.user.cmUserMenu.CmUserMenuDAO;
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
 * 2014. 11. 17.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmUserBoardService") 
public class CmUserBoardServiceImpl extends AbstractServiceImpl implements CmUserBoardService{

    @Resource
    private CmUserBoardDAO dao;

    
    @Resource
    private CmManageDAO cmManageDAO;
    
    @Resource
    private CmUserMenuDAO cmUserMenuDAO;
    
//    @Resource
//    private CmManageBoardDAO cmManageBoardDAO;
    
    @Resource 
    private FileDAO fileDao;
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardList(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public Pager<CmManageBoardVO> cmUserBoardList(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserBoardList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardView(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public CmManageBoardVO cmUserBoardView(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        dao.cmUserBoardRDCNTUpdate(vo);
        return dao.cmUserBoardView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardInsert(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardInsert(HttpServletRequest request , CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        CmManageVO  cmmVo  = new CmManageVO();
        //CmManageVO  cmmVo2  = new CmManageVO();
        String strResult ="N";
        int intResult1 = 0;
        //int intResult2 = 0;
        String strUserId = "";
        String strCnSumry=StringUtil.omit(Converter.cleanHtml(StringUtil.replace(vo.getBbscttCn(), "\"", "'")), 900);
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        
        String strAccesIpAdres = request.getRemoteAddr();
        int intBoardBBSseq = 0;
        cmmVo.setLangCode(vo.getLangCode());
        cmmVo.setCmmntyId(vo.getCmmntyId());
        cmmVo.setCmmntyMberId(vo.getRegistId());
        cmmVo = cmManageDAO.openCmManageView(cmmVo);
        if(vo.getWrterNcnm() == null) {
            if(cmmVo != null){
                strUserId =  cmmVo.getUserId();
                if(strUserId.equals(vo.getRegistId())){
                    vo.setWrterNcnm("운영자");
                }else{
                    
                    cmmVo.setLangCode(vo.getLangCode());
                    cmmVo.setCmmntyId(vo.getCmmntyId());
                    cmmVo.setCmmntyMberId(vo.getRegistId());
                    cmmVo = cmUserMenuDAO.cmUserMberInfo(cmmVo);
                    vo.setWrterNcnm(cmmVo.getNcnm());
                }
            }
        }
        int intAtchFileSeq = -1;
        
        List<FileVO> fileList  = UploadHelper.upload( request, "cmBasicBoard");
        if(fileList.size()> 0){
            intAtchFileSeq = fileDao.saveFile(fileList);
        }
        
        intBoardBBSseq = dao.cmUserBoardBBSseq(vo);
        String[] strSplit1;
        String ckTagNm =vo.getTagNm();
      
         
        vo.setCmmntyBbsSeq(intBoardBBSseq);
        vo.setCnSumry(strCnSumry);
        vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
        vo.setAccessIpAdres(strAccesIpAdres);
        vo.setAtchFileSeq(intAtchFileSeq);
        intResult1 = dao.cmUserBoardInsert(vo);
        if(ckTagNm != null){
            strSplit1 = ckTagNm.split(",");
            if(strSplit1 != null){
                log.info("strSplit1.length::::::????????>>>>>>>>>>>"+strSplit1.length);
                for(int i=0; i<strSplit1.length; i++ ){
                    CmManageBoardVO cmbvo = new CmManageBoardVO();
                    log.info("strSplit1[i]::::::????????>>>>>>>>>>>"+strSplit1[i]);
                    if(strSplit1[i] != null ){
                        cmbvo.setCmmntyBbsSeq(intBoardBBSseq);
                        cmbvo.setLangCode(vo.getLangCode());
                        cmbvo.setCmmntyId(vo.getCmmntyId());
                        cmbvo.setCmmntyMenuCode(vo.getCmmntyMenuCode());
                        cmbvo.setTagNm(strSplit1[i].trim());
                        dao.cmUserBoardTagInsert(cmbvo);
                    }
                }
            }
        }
        
        if(intResult1>0){
            strResult = "Y";
        } 
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardUpdate(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;

        String StrUploadFileCnt = request.getParameter("uploadFileCnt") != null ? request.getParameter("uploadFileCnt").toString() : "0";
        String strCnSumry=StringUtil.omit(Converter.cleanHtml(StringUtil.replace(vo.getBbscttCn(), "\"", "'")), 900);
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        
        int intFileCnt = Integer.parseInt(StrUploadFileCnt);
        String strAccesIpAdres = request.getRemoteAddr();
//        int intBoardBBSseq = 0;

        int intAtchFileSeq = -1;
        
        List<FileVO> fileList  = UploadHelper.upload( request, "cmUserBoard");
        if(intFileCnt > 0){
            if(fileList.size()> 0){
                intAtchFileSeq = fileDao.saveFile(fileList, vo.getAtchFileSeq()); // 다중 파일 업로드 시 추가 파일이 있을때 (사진게시판)
            }else{
                intAtchFileSeq = vo.getAtchFileSeq(); // 추가파일 업로드가 없을때
            }
        }else{
            if(fileList.size()> 0){
                intAtchFileSeq = fileDao.saveFile(fileList);  // 모든 파일 삭제 후 업로드 , 파일 처음 업로드 시
            }else{
                intAtchFileSeq = vo.getAtchFileSeq(); // 기존 파일이 있을때!
            }
        }
        
//        intBoardBBSseq = vo.getCmmntyBbsSeq();
        String[] strSplit1;
        String ckTagNm =vo.getTagNm();
        log.info("ckTagNm::::::????????>>>>>>>>>>>"+ckTagNm);
      
//        vo.setCmmntyBbsSeq(intBoardBBSseq);
        vo.setCnSumry(strCnSumry);
        vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
        vo.setAccessIpAdres(strAccesIpAdres);
        vo.setAtchFileSeq(intAtchFileSeq);
        intResult1 = dao.cmUserBoardUpdate(vo);
        if(ckTagNm != null){
            strSplit1 = ckTagNm.split(",");
            if(strSplit1 != null){
                log.info("strSplit1.length::::::????????>>>>>>>>>>>"+strSplit1.length);
                 dao.cmUserBoardTagDelete(vo); // 태그 삭제 후 입력
                for(int i=0; i<strSplit1.length; i++ ){
                    CmManageBoardVO cmbvo = new CmManageBoardVO();
                    log.info("strSplit1[i]::::::????????>>>>>>>>>>>"+strSplit1[i]);
                    if(strSplit1[i] != null ){
                        cmbvo.setCmmntyBbsSeq(vo.getCmmntyBbsSeq());
                        cmbvo.setLangCode(vo.getLangCode());
                        cmbvo.setCmmntyId(vo.getCmmntyId());
                        cmbvo.setCmmntyMenuCode(vo.getCmmntyMenuCode());
                        cmbvo.setTagNm(strSplit1[i].trim());
                        dao.cmUserBoardTagInsert(cmbvo);
                    }
                }
            }
        }
        
        if(intResult1>0){
            strResult = "Y";
        } 
        return strResult;
    }
    
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardDelUpdate(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     * 커뮤니티 게시판 삭제 업데이트로 플래그 처리
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardDelUpdate(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        CmManageVO  cmmVo  = new CmManageVO();
        CmManageVO  cmmVo2  = new CmManageVO();
        String strResult ="N";
        int intResult1 = 0;
        String strUserId = "";
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        
        String strAccesIpAdres = request.getRemoteAddr();
        
        //fileDao.removeFile(vo.getAtchFileSeq()); 파일삭제 않함
       // vo.setAtchFileSeq(-1);
        vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
        vo.setAccessIpAdres(strAccesIpAdres);
        vo.setWrterIpAdres(strAccesIpAdres);
        cmmVo.setLangCode(vo.getLangCode());
        cmmVo.setCmmntyId(vo.getCmmntyId());
        cmmVo.setCmmntyMberId(vo.getRegistId());
        cmmVo = cmManageDAO.openCmManageView(cmmVo);
       // log.info("getCmtDeleteCd >>>>>>>getCmtDeleteCd>>>getCmtDeleteCd>>>>>>>>>>>>>"+vo.getCmtDeleteCd());
        if( vo.getCmtDeleteCd()  == null ){
            if(cmmVo != null){
                strUserId =  cmmVo.getUserId();
                if(strUserId.equals(vo.getRegistId())){
                   vo.setCmtDeleteCd(1002); //운영자 삭제
                }else{
                    //cmmVo = null;
                    cmmVo2.setLangCode(vo.getLangCode());
                    cmmVo2.setCmmntyId(vo.getCmmntyId());
                    cmmVo2.setCmmntyMberId(vo.getRegistId());
                    cmmVo2 = cmUserMenuDAO.cmUserMberInfo(cmmVo2);
                    if(cmmVo2 !=null){
                        vo.setCmtDeleteCd(1001); // 작성자 삭제
                    }
                }
            }
        }
        
        log.info("getCmmntyMenuCode >>>>>>>getCmmntyMenuCode>>>getCmmntyMenuCode>>>>>>>>>>>>>"+vo.getCmmntyMenuCode());
        // dao.cmUserBoardTagDelete(vo);  완전 삭제 시 적용
        // dao.cmUserBoardCmtDelete(vo);  완전 삭제 시 적용 
        
         dao.cmUserBoardCmtDelUpdate(vo);
         intResult1 = dao.cmUserBoardDelUpdate(vo);
        if(intResult1>0){
            strResult = "Y";
        } 
        return strResult;
    }

    
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#fileDelUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     * 커뮤니티 첨부 파일 삭제
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String fileDelUpdate(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult = ""; 
        int inCnt  = 0;
        
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        String strAccesIpAdres = request.getRemoteAddr();
        
        //log.debug("fileId:>>>>>>>>>>>>>>>>>>>>>>>>>>>>손해석>>>."+vo.getFileId());
        inCnt =  fileDao.removeFile(vo.getAtchFileSeq());

        if(inCnt >0){
            
            vo.setAtchFileSeq(-1);
            vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
            vo.setAccessIpAdres(strAccesIpAdres);
            
            inCnt = dao.cmUserBoardFileUpdate(vo);
            
            strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardCmtList(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public Pager<CmManageBoardVO> cmUserBoardCmtList(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserBoardCmtList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardCmtInsert(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     * 커뮤니티 댓글/답글 입력
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardCmtInsert(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        CmManageVO  cmmVo  = new CmManageVO();
        String strResult = ""; 
        int inCnt  = 0;
        
        String strBbsCmt = request.getParameter("bbsCmt") != null ? request.getParameter("bbsCmt").toString() : "";
        String toDate = DateFormatUtil.getTodayMsec();
        String strUserId = "";
        String strWrterIpAdres = request.getRemoteAddr();
        
        cmmVo.setLangCode(vo.getLangCode());
        cmmVo.setCmmntyId(vo.getCmmntyId());
        cmmVo.setCmmntyMberId(vo.getRegistId());
        cmmVo = cmManageDAO.openCmManageView(cmmVo);
        if(vo.getWrterNcnm() == null) {
            if(cmmVo != null){
                strUserId =  cmmVo.getUserId();
                if(strUserId.equals(vo.getRegistId())){
                    vo.setWrterNcnm("운영자");
                }else{
                    cmmVo.setLangCode(vo.getLangCode());
                    cmmVo.setCmmntyId(vo.getCmmntyId());
                    cmmVo.setCmmntyMberId(vo.getRegistId());
                    cmmVo = cmUserMenuDAO.cmUserMberInfo(cmmVo);
                    vo.setWrterNcnm(cmmVo.getNcnm());
                }
            }
        }
        
        vo.setWrterIpAdres(strWrterIpAdres);
        
        if(strBbsCmt.equals("comment")){    
            vo.setCmtSortOrdr(0);
            vo.setCmtDp(0);
            vo.setRefrnCmtSeq(toDate);
            vo.setCmmntyCmtSeq(toDate);  
            inCnt = dao.cmUserBoardCmtInsert(vo);
            
        }else if(strBbsCmt.equals("reply")){
            
            int intCmtSortOrdr = dao.cmUserBoardCmtMaxOrderNo(vo);
            
            vo.setCmtSortOrdr(intCmtSortOrdr+1);
            vo.setCmtDp(vo.getCmtDp()+1);
            vo.setRefrnCmtSeq(vo.getCmmntyCmtSeq());
            vo.setCmmntyCmtSeq(toDate);
            
            inCnt = dao.cmUserBoardCmtInsert(vo);
        }
        if(inCnt>0){
            strResult = "Y";
        }
        
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardCmtUpdate(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     * 커뮤니티 댓글/답글 수정
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardCmtUpdate(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult = ""; 
        int inCnt  = 0;
       // String strBbsCmt = request.getParameter("bbsCmt") != null ? request.getParameter("bbsCmt").toString() : "";
        String strWrterIpAdres = request.getRemoteAddr();
        //vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
        vo.setWrterIpAdres(strWrterIpAdres);
            
        inCnt = dao.cmUserBoardCmtUpdate(vo);
 

        if(inCnt>0){
            strResult = "Y";
        }
        
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardCmtReplyDelete(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     * 커뮤니티 사용자 게시판 댓글/답글 삭제
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardCmtReplyDelete(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult = ""; 
        int inCnt  = 0;
        
        inCnt = dao.cmUserBoardCmtReplyDelete(vo);
        

        if(inCnt>0){
            strResult = "Y";
        }
        
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardCmtView(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public CmManageBoardVO cmUserBoardCmtView(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserBoardCmtView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserWriteBoardListCount(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public int cmUserWriteBoardListCount(CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        return dao.cmUserWriteBoardListCount(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#cmUserBoardAnswerUpdate(zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     * QnA 답글 등록
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmUserBoardAnswerUpdate(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult ="N";
        int intResult1 = 0;
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        String strAccesIpAdres = request.getRemoteAddr();
        vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
        vo.setAccessIpAdres(strAccesIpAdres);
        
        intResult1 = dao.cmUserBoardAnswerUpdate(vo);
        
        if(intResult1>0){
            strResult = "Y";
        } 
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.user.cmUserBoard.CmUserBoardService#fileEachDelUpdate(javax.servlet.http.HttpServletRequest, zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO)
     */
    @Override
    public String fileEachDelUpdate(HttpServletRequest request, CmManageBoardVO vo) {
        // TODO Auto-generated method stub
        String strResult = ""; 
        int inCnt  = 0;
        
        String strAccesBrwsrAgent =  request.getParameter("browserType") != null ? request.getParameter("browserType").toString() : "";
        String strAccesIpAdres = request.getRemoteAddr();
        String fileLength = request.getParameter("fileLength") != null ? request.getParameter("fileLength").toString() : "0";
        log.debug("fileId:>>>>>>>>>>>>>>>>>>>>>>>>>>>>손해석>>>."+vo.getFileId());
        inCnt =  fileDao.removeFile(vo.getAtchFileSeq(),vo.getFileId());
        int intFileLength = 0;
        intFileLength =  Integer.parseInt(fileLength);
        if(inCnt >0){
            if(intFileLength == 1){ 
                vo.setAtchFileSeq(-1);
                vo.setAccessBrwsrAgent(strAccesBrwsrAgent);
                vo.setAccessIpAdres(strAccesIpAdres);
                
                inCnt = dao.cmUserBoardFileUpdate(vo);
            }
            strResult = "Y";
        }
        return strResult;
    }
  
}
