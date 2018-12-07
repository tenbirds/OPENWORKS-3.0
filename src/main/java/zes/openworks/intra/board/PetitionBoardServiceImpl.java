/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.boardconf.BoardConfVO;
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
 *  2012. 6. 7.      손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

@Service("petitionBoardService")
public class PetitionBoardServiceImpl extends AbstractServiceImpl implements BoardService {

    @Resource
    private BoardDao boardDao;

    @Resource
    private FileDAO fileDao;

    /**
     * 게시물 목록 조회
     */
    @Override
    public Pager<BoardVO> boardList(BoardVO boardVO, String listSkin) {
        return boardDao.boardList(boardVO, listSkin);
    }

    /**
     * 게시물 목록 조회(컨버전 다운로드용)
     */
    @Override
    public Pager<BoardVO> boardAllList(BoardConvertOptionVO boardConvertOptionVO) {
        return boardDao.boardAllList(boardConvertOptionVO);
    }

    /**
     * 게시물 공지 목록 조회
     */
    @Override
    public List<BoardVO> noticeList(BoardVO boardVO, String listSkin) {
        return boardDao.noticeList(boardVO, listSkin);
    }

    /**
     * 게시물 상세 조회
     */
    @Override
    public BoardVO boardView(BoardVO boardVO) {
        return boardDao.boardView(boardVO);
    }

    /**
     * 게시물 상세 조회 카운트를 증가시킨다.
     */
    @Override
    public Object incReadCount(BoardVO boardVO) {
        return boardDao.incReadCount(boardVO);
    }

    /**
     * 게시물 평가 액션
     */
    @Override
    public Object scoreAction(BoardVO boardVO) {
        return boardDao.scoreAction(boardVO);
    }

    /**
     * 게시물 추천 액션
     */
    @Override
    public Object recommAction(BoardVO boardVO) {
        return boardDao.recommAction(boardVO);
    }

    /**
     * 게시물 신고 액션
     */
    @Override
    public Object accuseAction(BoardVO boardVO) {
        return boardDao.accuseAction(boardVO);
    }

    /**
     * 게시물 등록 액션
     */
    @Override
    public Object boardInsert(BoardVO boardVO) {
        return boardDao.boardInsert(boardVO);
    }

    /**
     * 민원형 게시물 답변등록
     */
    @Override
    public int boardAnswer(BoardVO boardVO) {
        return boardDao.boardAnswer(boardVO);
    }

    /**
     * 게시물 수정 액션
     */
    @Override
    public int boardUpdate(BoardVO boardVO) {
        return boardDao.boardUpdate(boardVO);
    }

    /**
     * 게시물 수정 액션
     */
    /*
     * @Override
     * public int updateActionYn(BoardVO boardVO){
     * return boardDao.updateActionYn(boardVO);
     * }
     */

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
        return boardDao.boardDelete(boardVO, boardVO.getDelDesc(), useTrash);
    }

    /**
     * 게시물 삭제 액션(목록에서 여러개 삭제시)
     */
    @Override
    public int boardListDelete(BoardVO boardVO, boolean useTrash) {
        return boardDao.boardListDelete(boardVO, boardVO.getDelDesc(), useTrash);
    }

    /**
     * 게시물 플래그 삭제 액션
     */
    @Override
    public int boardFlagDelete(BoardVO boardVO) {
        return boardDao.boardFlagDelete(boardVO);
    }

    /**
     * 게시물 플래그 삭제 액션(목록에서 여러개 삭제시)
     */
    @Override
    public int boardListFlagDelete(BoardVO boardVO) {
        return boardDao.boardListFlagDelete(boardVO);
    }

    /**
     * 덧글 목록 조회
     */
    @Override
    public Pager<BoardCmtVO> commentList(BoardCmtVO boardCmtVO) {
        return boardDao.commentList(boardCmtVO);
    }

    /**
     * 덧글 등록 액션
     */
    @Override
    public Object insertComment(BoardCmtVO boardCmtVO) {
        return boardDao.insertComment(boardCmtVO);
    }

    /**
     * 덧글 상세 보기
     */
    @Override
    public BoardCmtVO viewComment(BoardCmtVO boardCmtVO) {
        return boardDao.viewComment(boardCmtVO);
    }

    /**
     * 덧글 수정 액션
     */
    @Override
    public Object updateComment(BoardCmtVO boardCmtVO) {
        return boardDao.updateComment(boardCmtVO);
    }

    /**
     * 덧글 삭제 액션
     */
    @Override
    public String deleteComment(BoardCmtVO boardCmtVO) {
        return boardDao.deleteComment(boardCmtVO);
    }

    /**
     * 덧글 플래그 삭제 액션
     */
    @Override
    public int cmtFlagDelete(BoardCmtVO boardCmtVO) {
        return boardDao.cmtFlagDelete(boardCmtVO);
    }

    /**
     * 게시판 목록들(선택한 게시판이 아닌 다른 모든 게시판목록)
     */
    @Override
    public List<BoardConfVO> boardConfList(Integer domainCd, Integer bbsCd) {
        return boardDao.boardConfList(domainCd, bbsCd);
    }

    /**
     * 목록보기에서 게시물 복사 & 이동
     */
    @Override
    public Integer listTransfer(Integer domainCd, String bbsCd, Integer[] toBbsCds, String[] seqs, String isMove, Integer[] newCtg) {
        return boardDao.listTransfer(domainCd, bbsCd, toBbsCds, seqs, isMove, newCtg);
    }

    /**
     * 상세보기에서 게시물 복사 & 이동
     */
    @Override
    public Integer articleTransfer(Integer domainCd, String bbsCd, Integer toBbsCd, String seq, String isMove, Integer newCtg) {
        return boardDao.articleTransfer(domainCd, bbsCd, toBbsCd, seq, isMove, newCtg);
    }

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    @Override
    public boolean fileDelete(List<FileVO> fileList) {
        return boardDao.fileDelete(fileList);
    }

    /**
     * 게시판에 대한 클라우드 태그 목록을 가져온다.
     */
    @Override
    public String tagCloud(Integer domainCd, Integer bbsCd) {
        return boardDao.tagCloud(domainCd, bbsCd);
    }
    
    /**
     * 게시판 상세에서 추천이 제일 많은 게시물 5개 목록을 가져온다.
     */
    @Override
    public List<BoardVO> recomList(BoardVO boardVO) {
        return boardDao.recomList(boardVO);
    }
    
    /**
     * 부류코드 2Depth목록을 가져온다.
     */
    @Override
    public List<BoardConfVO> boardAditCtgList(BoardConfVO boardConfVO) {
        return boardDao.boardAditCtgList(boardConfVO);
    }
    /**
     * 게시판 공개비공개 여부 수정 액션
     */
    @Override
    public int othbcAtUpdateAction(BoardVO boardVo) {
        return boardDao.othbcAtUpdateAction(boardVo);
    }
    
    /**
     * 게시판 비즈매칭 선정여부 
     */
    @Override
    public int selectionUpdate(BoardVO boardVo) {
        return  boardDao.selectionUpdate(boardVo);
    }
    
    /**
     * 게시판 등록자 정보조회
     */
    @Override
    public RegisterUserVO userBoardSelect(BoardVO boardEmailVO) {
        return  boardDao.userBoardSelect(boardEmailVO);
    }
}
