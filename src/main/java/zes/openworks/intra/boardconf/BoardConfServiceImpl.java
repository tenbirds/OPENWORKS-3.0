/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.intra.boardtemp.BoardTempVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 게시판 관리 서비스 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 * 	 수정일		 수정자				 수정내용
 * --------------  --------  --------------------------------
 *  2012. 4. 25.     손재숙	 JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20.    박꽃송이      DB 컬럼(사이트 구분 - SITE_DIV_CD) 추가로 인한 수정 및 추가
 * </pre>
 * @see
 */
@Service("boardConfService")
public class BoardConfServiceImpl extends AbstractServiceImpl implements BoardConfService {

    @Resource
    private BoardConfDao boardConfDao;

    @Override
    public Pager<BoardConfVO> boardConfList(BoardConfVO boardConfVO) {
        return boardConfDao.boardConfList(boardConfVO);
    }

    @Override
    public List<BoardConfVO> boardConfList() {
        return boardConfDao.boardConfList();
    }

    @Override
    public BoardConfVO boardConfView(BoardConfVO boardConfVO) {
        return boardConfDao.boardConfView(boardConfVO);
    }

    @Override
    public Object insertAction(BoardConfVO boardConfVO) {
        return boardConfDao.insertAction(boardConfVO);
    }

    @Override
    public int updateAction(BoardConfVO boardConfVO) {
        return boardConfDao.updateAction(boardConfVO);
    }

    @Override
    public int updateAction(BoardConfYnVO boardConfYnVO) {
        return boardConfDao.updateAction(boardConfYnVO);
    }

    @Override
    public List<BoardArrangeVO> boardColumnList(BoardArrangeVO boardArrangeVO) {
        return boardConfDao.boardColumnList(boardArrangeVO);
    }

    @Override
    public List<BoardArrangeVO> boardDisplayColumnList(BoardArrangeVO boardArrangeVO) {
        return boardConfDao.boardDisplayColumnList(boardArrangeVO);
    }

    @Override
    public int arrangeUpdateAction(BoardArrangeVO boardArrangeVO,HttpServletRequest request) throws  Exception {
        return boardConfDao.arrangeUpdateAction(boardArrangeVO,request);
    }

    @Override
    public List<BoardExtensionVO> boardConfExtList(BoardConfVO boardConfVO) {
        return boardConfDao.boardConfExtList(boardConfVO);
    }

    @Override
    public List<BoardTempVO> boardTemplateList(String type){
        return boardConfDao.boardTemplateList(type);
    }

    @Override
    public int updateExtAction(List<BoardExtensionVO> extList) {
        return boardConfDao.updateExtAction(extList);
    }

    @Override
    public int deleteAction(Integer domainCd, String[] bbsCds) {
        return boardConfDao.deleteAction(domainCd, bbsCds);
    }

    @Override
    public Integer boardConfDelete(BoardConfVO boardConfVO) {
        BoardConfVO delBoardConfVO = boardConfView(boardConfVO);
        delBoardConfVO.setDataMap(boardConfVO.getDataMap());

        Integer delCnt = boardConfDao.boardConfDelete(delBoardConfVO);

        return delCnt;
    }

    /* 
     * 수정일 : 2014. 9. 20 / 수정자 : 박꽃송이  
     * '게시판관리 > 게시판설정 > 게시판목록' 에서 게시판 [선택삭제] 관련 수정 
     */
    @Override
    public Integer boardConfListDelete(BoardConfVO boardConfVO) {
        Integer delCnt = 0;
        String[] bbsCds = boardConfVO.getBbsCds();
        
        Integer cnt = bbsCds.length;
        Integer domainCd = 0;
        Integer bbs_cd = 0;
        
        if(cnt > 0) {
            for(int i=0; i < cnt; i++) {
                domainCd = Integer.parseInt(bbsCds[i].split("\\|")[0]);
                bbs_cd =  Integer.parseInt(bbsCds[i].split("\\|")[1]);

                boardConfVO.setBbsCd(bbs_cd);
                boardConfVO.setDomainCd(domainCd);
                
                delCnt += boardConfDao.boardConfDelete(boardConfVO);
            }
    
            return delCnt;
        } else {
            return 0;
        }
    }

    @Override
    public Object copyAction(String domainCd, String oldBbsCd, String newBbsNm, String newBbsDc) {
        return boardConfDao.copyAction(domainCd, oldBbsCd, newBbsNm, newBbsDc);
    }

    /**
     * 게시판 확장 설정 복사
     */
    @Override
    public int extCopyAction(Integer oldBbsCd) {
        return boardConfDao.extCopyAction(oldBbsCd);
    }

    @Override
    public void reloadBbsCache() {
        boardConfDao.reloadBbsCache();
    }

    /* ------------------------------ 2014. 9. 20 추가 ------------------------------*/
    
    /* 
     * 도메인별 메뉴 목록 및 게시판 목록 불러오기
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List boardTypeList(BoardConfVO boardConfVO) {
        
        String domainCd = "";
        
        domainCd = boardConfVO.getDataMap().get("q_domainCd") != null ? boardConfVO.getDataMap().get("q_domainCd").toString() : "";

        // 쿼리에 보내는 정보 담기
        if(!"".equals(domainCd)) {
            
            boardConfVO.getDataMap().put("q_domainCd", Integer.parseInt(domainCd));
            
            return boardConfDao.boardTypeList(boardConfVO);
            
        } else {
            
            return null;
        }
    }

    
}
