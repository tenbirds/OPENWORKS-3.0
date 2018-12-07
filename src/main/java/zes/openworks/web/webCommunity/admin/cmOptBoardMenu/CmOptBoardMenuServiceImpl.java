/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptBoardMenu;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import zes.base.vo.TreeVO;
import zes.core.utils.StringUtil;
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
 * 2014. 11. 5.    		 boseok       	신규
 *</pre>
 * @see
 */
@Service("cmOptBoardMenuService") 
public class CmOptBoardMenuServiceImpl extends AbstractServiceImpl implements CmOptBoardMenuService{

    @Resource
    private CmOptBoardMenuDAO dao;
    
    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuService#cmOptMberMenuTreeList(zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptMberMenuVO)
     */
    @Override
    public List<TreeVO> cmOptBoardMenuTreeList(CmOptBoardMenuVO vo) {
        // TODO Auto-generated method stub
        return dao.cmOptBoardMenuTreeList(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuService#cmOptBoardMenuTreeView(zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuVO)
     */
    @Override
    public CmOptBoardMenuVO cmOptBoardMenuTreeView(CmOptBoardMenuVO vo) {
        // TODO Auto-generated method stub
        return dao.cmOptBoardMenuTreeView(vo);
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuService#cmOptBoardMenuUpdate(zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuVO)
     */
    @Override
    public int cmOptBoardMenuUpdate(CmOptBoardMenuVO vo) {
        // TODO Auto-generated method stub
        //String strResult ="N";
        int intResult1 = 0;
        
        intResult1 = dao.cmOptBoardMenuUpdate(vo);
        
       // if(intResult1>0){
          //  strResult = "Y";
       // }
        return intResult1;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuService#cmOptBoardMenuInsert(zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuVO)
     */
    @Override
    public String cmOptBoardMenuInsert(CmOptBoardMenuVO vo) {
        // TODO Auto-generated method stub
        String strResult = "";
        int intResult = 0;
        String strCmmntyMenuCode = dao.getCmmntyMberMenuCode(vo);
        String strCmmntyMenuFolderNm = "";
        String strCmmntyMenuUrl = "";
        int intCmmntyBbsTyCd = vo.getCmmntyBbsTyCd();
        int intCmmntyBBSCd = dao.getCmmntyBBSCd(vo);
        
        /* 커뮤니티게시판유형코드  1001 기본형, 1002 FAQ형, 1003 갤러리형, 1004 답변형 */ 
        if(intCmmntyBbsTyCd == 1001){
            strCmmntyMenuUrl = "/cm/user/cmUserBoard/cmBasicBoard/BD_cmBasicBoardList.do";
            strCmmntyMenuFolderNm = "cmBasicBoard";
        }else if(intCmmntyBbsTyCd == 1002){
            strCmmntyMenuUrl = "/cm/user/cmUserBoard/cmFaqBoard/BD_cmFaqBoardList.do";
            strCmmntyMenuFolderNm = "cmFaqBoard";
        }else if(intCmmntyBbsTyCd == 1003){
            strCmmntyMenuUrl = "/cm/user/cmUserBoard/cmPhotoBoard/BD_cmPhotoBoardList.do";
            strCmmntyMenuFolderNm = "cmPhotoBoard";
        }else if(intCmmntyBbsTyCd == 1004){
            strCmmntyMenuUrl = "/cm/user/cmUserBoard/cmQnABoard/BD_cmQnABoardList.do";
            strCmmntyMenuFolderNm = "cmQnABoard";
        }
        vo.setCmmntyMenuCode(strCmmntyMenuCode);
        vo.setCmmntyBbsCd(intCmmntyBBSCd);
        vo.setMenuBbsSe("2");
        vo.setEssntlMenuAt("2");
        vo.setMenuCharctCd(1002);
        vo.setCmmntyMenuUrl(strCmmntyMenuUrl);
        vo.setCmmntyMenuFolderNm(strCmmntyMenuFolderNm);
        
        intResult = dao.cmOptBoardMenuInsert(vo);
        
        if(intResult > 0){
          strResult = "Y";
        }
        return strResult;
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuService#cmOptBoardMenuSortOrdrUpdate(zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int cmOptBoardMenuSortOrdrUpdate(CmOptBoardMenuVO vo) {
        // TODO Auto-generated method stub
        int result = 0;
        log.debug("cmmntyUpMenuCode:::>>>>"+vo.getCmmntyUpMenuCode());
        log.debug("cmmntyMenuCode:::>>>>"+vo.getCmmntyMenuCode());
        log.debug("sortOrdr:::>>>>"+vo.getSortOrdr());
        
        //String strCmmntyMenuCode = vo.getCmmntyMenuCode();
        String upMenuCode =  vo.getCmmntyUpMenuCode();

        List<CmOptBoardMenuVO> sortOrdrList = dao.cmOptBoardMenuSortOrdrList(vo);
        int sortOrdrListLength = sortOrdrList.size();
        
        //String updateMenuDepth = msMenuLevelList.get(0).getMsUserMenuDepth(); // 부모였던 메뉴 자식으로 들어갈때 사용.
        //int msMenuNodeCnt = dao.msMenuNodeCnt(vo); // 자식 노드가 있는지 체크
        
        int newSortOrdr = vo.getSortOrdr();

        if(newSortOrdr <= StringUtil.ZERO) {
            newSortOrdr = 1;
        }
        if(newSortOrdr > sortOrdrListLength) {
            newSortOrdr = sortOrdrListLength + 1;
        }
        
        sortOrdrList.add(newSortOrdr - 1, vo);
        sortOrdrListLength++;
        //log.debug("--------------newSortOrdr--------------"+newSortOrdr);
       // log.debug("--------------sortOrdrListLength--------------"+sortOrdrListLength);
        result = StringUtil.ZERO;

        if(!"0".equals(upMenuCode)){
            log.debug("--------------자식노드로 이동 안됩니다!!!--------------");
            return 2;
        }else{
            
            for(int i = 0 ; i < sortOrdrListLength ; i++) {
                CmOptBoardMenuVO cmOptBoardMenuVO = sortOrdrList.get(i);
                
               // cmOptBoardMenuVO.setCmmntyMenuCode(vo.getCmmntyMenuCode());
                cmOptBoardMenuVO.setCmmntyId(vo.getCmmntyId());
                cmOptBoardMenuVO.setLangCode(vo.getLangCode());
                cmOptBoardMenuVO.setSortOrdr(i + 1);
                //log.debug("--------------cmOptBoardMenuVO.getSortOrdr("+i + 1+")--------------"+cmOptBoardMenuVO.getSortOrdr());
                result += dao.cmOptBoardMenuSortOrdrUpdate(cmOptBoardMenuVO);
            }
            
            if(result == sortOrdrListLength) {
                return StringUtil.ONE;
            } else {
                return StringUtil.ZERO;
            }
           
       }
    }

    /* (non-Javadoc)
     * @see zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuService#cmOptBoardMenuDelete(zes.openworks.web.webCommunity.admin.cmOptBoardMenu.CmOptBoardMenuVO)
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String cmOptBoardMenuDelete(CmOptBoardMenuVO vo) {
        // TODO Auto-generated method stub
        String strResult = "";
        int result = 0;
        log.debug("cmmntyMenuCode:::>>>>"+vo.getCmmntyMenuCode());
        result = dao.cmOptBoardCMTDelete(vo); 
        result = dao.cmOptBoardBBSDelete(vo);
        result = dao.cmOptBoardMenuDelete(vo);
        if(result >0 ){
            strResult = "Y";
        }
        return strResult;
    }

}
