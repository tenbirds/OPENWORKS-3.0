/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.util.List;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.web.register.RegisterUserVO;

/**
 * 게시판 Service
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
 *  2012. 5. 14.     손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */

public interface BoardService {

    /**
     * 게시물 목록 조회
     */
    Pager<BoardVO> boardList(BoardVO boardVO, String listSkin);

    /**
     * 게시물 목록 조회(컨버전 다운로드용)
     */
    Pager<BoardVO> boardAllList(BoardConvertOptionVO boardConvertOptionVO);

    /**
     * 게시물 공지 목록 조회
     */
    List<BoardVO> noticeList(BoardVO boardVO, String listSkin);

    /**
     * 게시물 상세 조회
     */
    BoardVO boardView(BoardVO boardVO);

    /**
     * 게시물 상세 조회 카운트를 증가시킨다.
     */
    Object incReadCount(BoardVO boardVO);

    /**
     * 게시물 평가 액션
     */
    Object scoreAction(BoardVO boardVO);

    /**
     * 게시물 추천 액션
     */
    Object recommAction(BoardVO boardVO);

    /**
     * 게시물 신고 액션
     */
    Object accuseAction(BoardVO boardVO);

    /**
     * 게시물 등록 액션
     * bbscttSeq == 1부터 시작한다.
     * highBbsCd == 0이면 등록, 아니면 답글
     */
    Object boardInsert(BoardVO boardVO);

    /**
     * 민원형 게시물 답변등록
     */
    int boardAnswer(BoardVO boardVO);

    /**
     * 게시물 수정 액션
     */
    int boardUpdate(BoardVO boardVO);

    /**
     * 게시물 수정 액션
     */
    // int updateActionYn(BoardVO boardVO);

    /**
     * 개별 파일 삭제 액션
     */
    int fileDelete(FileVO fileVO);

    /**
     * 게시물 삭제 액션
     */
    int boardDelete(BoardVO boardVO, boolean useTrash);

    /**
     * 게시물 삭제 액션(목록에서 여러개 삭제시)
     */
    int boardListDelete(BoardVO boardVO, boolean useTrash);

    /**
     * 게시물 플래그 삭제 액션
     */
    int boardFlagDelete(BoardVO boardVO);

    /**
     * 게시물 플래그 삭제 액션(목록에서 여러개 삭제시)
     */
    int boardListFlagDelete(BoardVO boardVO);

    /**
     * 덧글 목록 조회
     */
    Pager<BoardCmtVO> commentList(BoardCmtVO boardCmtVO);

    /**
     * 덧글 등록 액션
     */
    Object insertComment(BoardCmtVO boardCmtVO);

    /**
     * 덧글 상세 보기
     */
    BoardCmtVO viewComment(BoardCmtVO boardCmtVO);

    /**
     * 덧글 수정 액션
     */
    Object updateComment(BoardCmtVO boardCmtVO);

    /**
     * 덧글 삭제 액션
     */
    String deleteComment(BoardCmtVO boardCmtVO);

    /**
     * 덧글 플래그 삭제 액션
     */
    int cmtFlagDelete(BoardCmtVO boardCmtVO);

    /**
     * 게시판 목록들(선택한 게시판이 아닌 다른 모든 게시판목록)
     */
    List<BoardConfVO> boardConfList(Integer domainCd, Integer bbsCd);

    /**
     * 목록보기에서 게시물 복사 & 이동
     */
    Integer listTransfer(Integer domainCd, String bbsCd, Integer[] toBbsCds, String[] seqs, String isMove, Integer[] newCtg);

    /**
     * 상세보기에서 게시물 복사 & 이동
     */
    Integer articleTransfer(Integer domainCd, String bbsCd, Integer toBbsCd, String bbscttSeq, String isMove, Integer newCtg);

    /**
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    boolean fileDelete(List<FileVO> fileList);

    /**
     * 게시판에 대한 클라우드 태그 목록을 가져온다.
     */
    String tagCloud(Integer domainCd, Integer bbsCd);

    /**
     * 최대 추천수 목록
     * @param boardVO
     * @return
     */
    List<BoardVO> recomList(BoardVO boardVO);

    /**
     * 부류코드 2Depth 조회
     * @param boardConfVO
     * @return
     */
    List<BoardConfVO> boardAditCtgList(BoardConfVO boardConfVO);

    /**
     * 게시판 공개비공개 여부 수정 액션
     * @param boardVo
     * @return
     */
    int othbcAtUpdateAction(BoardVO boardVo);

    /**
     * 게시판 비즈매칭 선정여부 
     * @param boardVo
     * @return
     */
    int selectionUpdate(BoardVO boardVo);

    /**
     * 게시물 등록자 정보조회
     * @param boardEmailVO
     * @return
     */
    RegisterUserVO userBoardSelect(BoardVO boardEmailVO);

    
}
