/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.user.cmUserBoard;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import zes.base.pager.Pager;
import zes.openworks.component.file.FileDAO;
//import zes.openworks.intra.cmMgmt.cmManage.CmManageVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


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
@Repository
public class CmUserBoardDAO   extends EgovAbstractMapper {
    
    @Resource
    private FileDAO fileDao;
    
    /**  
     * 커뮤니티  사용자 게시판 목록
     * @param vo
     * @return pager  
    */
   @SuppressWarnings("unchecked")
    public Pager<CmManageBoardVO> cmUserBoardList(CmManageBoardVO vo){
       Map<String, Object> paraMap = vo.getDataMap();
       paraMap.put("langCode",vo.getLangCode()); 
       paraMap.put("cmmntyId",vo.getCmmntyId()); 
       paraMap.put("cmmntyMenuCode",vo.getCmmntyMenuCode()); 
       
       paraMap.put("othbcSetupCdChk",vo.getOthbcSetupCdChk()); 
       
       paraMap.put("cmmntyBbsTyCd",vo.getCmmntyBbsTyCd()); 
       
       List<CmManageBoardVO> cmUserBoardList = list("_cmUserBoard.cmUserBoardList", paraMap);
       vo.setTotalNum((Integer)selectByPk("_cmUserBoard.cmUserBoardListCount",paraMap));
       
       for(int i = 0 ; i < cmUserBoardList.size() ; i++) {
           if( !"-1".equals(cmUserBoardList.get(i).getAtchFileSeq()) ){
               cmUserBoardList.get(i).setFileList(fileDao.getFiles(cmUserBoardList.get(i).getAtchFileSeq()));
           }
      }
       return new Pager<CmManageBoardVO>(cmUserBoardList, vo);  
   }
   
   /**
    * 커뮤니티 사용자게시판 상세
    */
   public CmManageBoardVO cmUserBoardView(CmManageBoardVO vo) {
       CmManageBoardVO cmbvo = (CmManageBoardVO) selectByPk("_cmUserBoard.cmUserBoardView", vo); // collection cmUserBoardFileList 포함
       //logger.info(":::>>>>getCmUserBoardFileCollection getCmUserBoardFileCollection getCmUserBoardFileCollection>>>>>>>>"+cmbvo.getCmUserBoardFileCollection().size());
       if(cmbvo != null) {
           cmbvo.setPrevVO((CmManageBoardVO) selectByPk("_cmUserBoard.cmUserBoardRrevView", vo)); // 이전글
           cmbvo.setNextVO((CmManageBoardVO) selectByPk("_cmUserBoard.cmUserBoardNextView", vo)); // 다음글
           cmbvo.setFileCnt(cmbvo.getCmUserBoardFileCollection().size());
       }
       
       return cmbvo;
   }

   
    /**
     * 커뮤니티 게시판 등록
     * @param vo
     * @return  
     */ 
    
    public int cmUserBoardInsert(CmManageBoardVO vo){
        return (Integer) insert("_cmUserBoard.cmUserBoardInsert",vo);
    }
    
    /**
     * 커뮤니티 게시판 수정
     * @param vo
     * @return  
     */ 
    public int cmUserBoardUpdate(CmManageBoardVO vo){
        return (Integer) update("_cmUserBoard.cmUserBoardUpdate",vo);
    }
    
    /**
     * 커뮤니티 게시판 파일 삭제 수정
     * @param vo
     * @return  
     */ 
    public int cmUserBoardFileUpdate(CmManageBoardVO vo){
        return (Integer) update("_cmUserBoard.cmUserBoardFileUpdate",vo);
    }
    
    /**
     * 커뮤니티 게시판 수정 삭제
     * @param vo
     * @return  
     */ 
    public int cmUserBoardDelUpdate(CmManageBoardVO vo){
        return (Integer) update("_cmUserBoard.cmUserBoardDelUpdate",vo);
    }
    
    /**
     * 커뮤니티 게시판 삭제시 댓글/답글 수정 삭제
     * @param vo
     * @return  
     */ 
    public int cmUserBoardCmtDelUpdate(CmManageBoardVO vo){
        return (Integer) update("_cmUserBoard.cmUserBoardCmtDelUpdate",vo);
    }
    
    /**
     * 커뮤니티 게시판 조회 카운트
     * @param vo
     * @return  
     */ 
    public int cmUserBoardRDCNTUpdate(CmManageBoardVO vo){
        return (Integer) update("_cmUserBoard.cmUserBoardRDCNTUpdate",vo);
    }
    
//    /**
//     *  커뮤니티 게시판 태그 조회
//     * @param vo
//     * @return  
//     */
//    @SuppressWarnings("unchecked")
//    public List<CmManageBoardVO> cmUserBoardTagList(CmManageBoardVO vo){
//        
//        return list("_cmUserMenu.cmUserBoardTagList", vo);
//    }

     /**
     * 커뮤니티 게시판 태그 등록
     * @param vo
     * @return  
     */ 
    
    public int cmUserBoardTagInsert(CmManageBoardVO vo){
        return (Integer) insert("_cmUserBoard.cmUserBoardTagInsert",vo);
    }

      /**
     * 커뮤니티 게시판 태그 삭제
     * @param vo
     * @return  
     */ 
    
    public int cmUserBoardTagDelete(CmManageBoardVO vo){
        return (Integer) delete("_cmUserBoard.cmUserBoardTagDelete",vo);
    }
    
   /** 커뮤니티 게시판 순번
    * @param vo
    * @return  
    */ 
   
   public int cmUserBoardBBSseq(CmManageBoardVO vo){
       return (Integer) selectByPk("_cmUserBoard.cmUserBoardBBSseq",vo);
   }
    
   /**
    * 커뮤니티 게시판 댓글 삭제
    * @param vo
    * @return  
    */ 
   
   public int cmUserBoardCmtDelete(CmManageBoardVO vo){
       return (Integer) delete("_cmUserBoard.cmUserBoardCmtDelete",vo);
   }
   
   /**  
    * 커뮤니티 게시판 댓글 목록
    * @param vo
    * @return pager  
   */
  @SuppressWarnings("unchecked")
   public Pager<CmManageBoardVO> cmUserBoardCmtList(CmManageBoardVO vo){
      Map<String, Object> paraMap = vo.getDataMap();

      paraMap.put("langCode",vo.getLangCode()); 
      paraMap.put("cmmntyId",vo.getCmmntyId()); 
      paraMap.put("cmmntyMenuCode",vo.getCmmntyMenuCode()); 
      paraMap.put("cmmntyBbsSeq",vo.getCmmntyBbsSeq()); 
      
      List<CmManageBoardVO> cmUserBoardCmtList = list("_cmUserBoard.cmUserBoardCmtList", paraMap);
      vo.setTotalNum((Integer)selectByPk("_cmUserBoard.cmUserBoardCmtListCount",paraMap));
      return new Pager<CmManageBoardVO>(cmUserBoardCmtList, vo);  
  }
   
  /**
   * 커뮤니티 게시판 댓글 등록
   * @param vo
   * @return  
   */ 
  
  public int cmUserBoardCmtInsert(CmManageBoardVO vo){
      return (Integer) insert("_cmUserBoard.cmUserBoardCmtInsert",vo);
  }
  
  
 /** 커뮤니티 사용자 게시판 댓글 정렬번호
  * @param vo
  * @return  
  */ 
 
 public int cmUserBoardCmtMaxOrderNo(CmManageBoardVO vo){
     return (Integer) selectByPk("_cmUserBoard.cmUserBoardCmtMaxOrderNo",vo);
 }
 
 /**
  * 커뮤니티 게시판 댓글 수정
  * @param vo
  * @return  
  */ 
 public int cmUserBoardCmtUpdate(CmManageBoardVO vo){
     return (Integer) update("_cmUserBoard.cmUserBoardCmtUpdate",vo);
 }
 
 /**
  * 커뮤니티 게시판 댓글 삭제
  * @param vo
  * @return  
  */ 
 public int cmUserBoardCmtReplyDelete(CmManageBoardVO vo){
     return (Integer) delete("_cmUserBoard.cmUserBoardCmtReplyDelete",vo);
 }
 /**
  * 커뮤니티 게시판 댓글 폼 조회
  * @param vo
  * @return  
  */ 
 public CmManageBoardVO cmUserBoardCmtView(CmManageBoardVO vo){
     return (CmManageBoardVO) selectByPk("_cmUserBoard.cmUserBoardCmtView", vo);
 }
 
 /**
  * 커뮤니티 게시판 본인 작성 글 카운트
  * @param vo
  * @return  
  */ 
 public int cmUserWriteBoardListCount(CmManageBoardVO vo ){
     return (Integer) selectByPk("_cmUserBoard.cmUserWriteBoardListCount", vo);
 }
 
 /**
  * 커뮤니티 게시판 답변
  * @param vo
  * @return  
  */ 
 public int cmUserBoardAnswerUpdate(CmManageBoardVO vo){
     return (Integer) update("_cmUserBoard.cmUserBoardAnswerUpdate",vo);
 }
 
 
}
