/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.board;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.board.BoardCmtVO;
import zes.openworks.intra.board.BoardConvertOptionVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.mgr.MgrVO;
import zes.openworks.intra.orderManage.consult.ConsultOrderVO;
import zes.openworks.web.register.RegisterUserVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 민원형 게시판 서비스 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *   수정일                  수정자                   수정내용
 * --------------  --------  ---------------------------------
 *  2012. 6. 14.      손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Service("petitionBoardWebService")
public class PetitionBoardServiceImpl extends AbstractServiceImpl implements BoardService {

    @Resource
    private BoardDao boardWebDao;

    @Resource
    private FileDAO fileDao;

    /**
     * 게시물 목록 조회
     */
    @Override
    public Pager<BoardVO> boardList(BoardVO boardVO, String listSkin) {
        return boardWebDao.boardList(boardVO, listSkin);
    }

    /**
     * 게시물 목록 조회(컨버전 다운로드용)
     */
    @Override
    public Pager<BoardVO> boardAllList(BoardConvertOptionVO boardConvertOptionVO) {
        return boardWebDao.boardAllList(boardConvertOptionVO);
    }

    /**
     * 게시물 공지 목록 조회
     */
    @Override
    public List<BoardVO> noticeList(BoardVO boardVO, String listSkin) {
        return boardWebDao.noticeList(boardVO, listSkin);
    }

    /**
     * 게시물 상세 조회
     */
    @Override
    public BoardVO boardView(BoardVO boardVO) {
        return boardWebDao.boardView(boardVO);
    }

    /**
     * 게시물 상세 조회 카운트를 증가시킨다.
     */
    @Override
    public Object incReadCount(BoardVO boardVO) {
        return boardWebDao.incReadCount(boardVO);
    }

    /**
     * 게시물 평가 액션
     */
    @Override
    public Object scoreAction(BoardVO boardVO) {
        return boardWebDao.scoreAction(boardVO);
    }

    /**
     * 게시물 추천 액션
     */
    @Override
    public Object recommAction(BoardVO boardVO) {
        return boardWebDao.recommAction(boardVO);
    }

    /**
     * 게시물 신고 액션
     */
    @Override
    public Object accuseAction(BoardVO boardVO) {
        return boardWebDao.accuseAction(boardVO);
    }

    /**
     * 게시물 등록 액션
     */
    @Override
    public Object boardInsert(BoardVO boardVO) {
        return boardWebDao.boardInsert(boardVO);
    }

    /**
     * 게시물 수정 액션
     */
    @Override
    public int boardUpdate(BoardVO boardVO) {
        return boardWebDao.boardUpdate(boardVO);
    }

    /**
     * 첨부파일 개별 삭제 액션
     */
    @Override
    public int fileDelete(FileVO fileVO) {
        int affected = fileDao.removeFile(fileVO.getFileSeq(), fileVO.getFileId());
        return affected;
    }

    /**
     * 게시물 삭제 액션
     */
    @Override
    public int boardDelete(BoardVO boardVO, boolean useTrash) {
        return boardWebDao.boardDelete(boardVO, boardVO.getDelDesc(), useTrash);
    }

    /**
     * 덧글 목록 조회
     */
    @Override
    public Pager<BoardCmtVO> commentList(BoardCmtVO boardCmtVO) {
        return boardWebDao.commentList(boardCmtVO);
    }

    /**
     * 덧글 등록 액션
     */
    @Override
    public Object insertComment(BoardCmtVO boardCmtVO) {
        return boardWebDao.insertComment(boardCmtVO);
    }

    /**
     * 덧글 상세 보기
     */
    @Override
    public BoardCmtVO viewComment(BoardCmtVO boardCmtVO) {
        return boardWebDao.viewComment(boardCmtVO);
    }

    /**
     * 덧글 수정 액션
     */
    @Override
    public Object updateComment(BoardCmtVO boardCmtVO) {
        return boardWebDao.updateComment(boardCmtVO);
    }
    
    /**
     * 덧글 플래그 삭제 액션
     */
    @Override
    public int cmtFlagDelete(BoardCmtVO boardCmtVO) {
        return boardWebDao.cmtFlagDelete(boardCmtVO);
    }

    /**
     * 덧글 삭제 액션
     */
    @Override
    public String deleteComment(BoardCmtVO boardCmtVO) {
        return boardWebDao.deleteComment(boardCmtVO);
    }

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    @Override
    public boolean fileDelete(List<FileVO> fileList) {
        return boardWebDao.fileDelete(fileList);
    }

    /**
     * 게시판에 대한 클라우드 태그 목록을 가져온다.
     */
    @Override
    public String tagCloud(Integer domainCd, Integer bbsCd) {
        return boardWebDao.tagCloud(domainCd, bbsCd);
    }
    

    /**
     * 서비스 선택 리스트 
     */
    public Pager<ConsultOrderVO> popProduct(ConsultOrderVO consultOrderVO, BoardVO boardVO) {
        return boardWebDao.popProduct(consultOrderVO, boardVO);
    }
    
    /**
     * 게시판 비즈매칭 선정여부 
     */
    @Override
    public int selectionUpdate(BoardVO boardVo) {
        return  boardWebDao.selectionUpdate(boardVo);
    }
    
    /** 
     * 비즈매칭 댓글 상세 게시판정보
     */
    @Override
    public BoardCmtVO cmtBoardView(BoardCmtVO boardCmtVO) {
        return boardWebDao.cmtBoardView(boardCmtVO);
    }
    
    /** 
     * 비즈매칭 댓글 중복체크
     */
    @Override
    public Object bizCommentCheck(BoardCmtVO boardCmtVO) {
        return boardWebDao.bizCommentCheck(boardCmtVO);
    }
    
    /**
     * 서비스 갯수 체크
     */
    @Override
    public int productView(BoardVO boardVO) {
        return boardWebDao.productView(boardVO);
    }
    
    /**
     * 카테고리에 등록된 서비스의 담당자 리스트정보 조회
     */
    @Override
    public List<RegisterUserVO> categoryUserList(BoardVO boardVO) {
        return boardWebDao.categoryUserList(boardVO);
    }
    
    /**
     * 희망 답변자 유저정보 조회
     */
    @Override
    public List<RegisterUserVO> selectCtgryUserList(BoardVO boardVO) {
        return boardWebDao.selectCtgryUserList(boardVO);
    }

    /**
     * 게시믈 등록자 정보조회
     */
    @Override
    public BoardVO userBoardSelect(BoardVO boardVO) {
        return boardWebDao.userBoardSelect(boardVO);
    }
    
    /**
     * 관리자(총괄) 정보조회
     */
    @Override
    public List<MgrVO>  mgrInfo() {
        return boardWebDao.mgrInfo();
    }
    
    /**
     * 부류코드 2Depth목록을 가져온다.
     */
    @Override
    public List<BoardVO> boardAditCtgList(BoardVO boardVO) {
        return boardWebDao.boardAditCtgList(boardVO);
    }
}
