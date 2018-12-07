/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.board;

import java.util.List;

import zes.base.pager.Pager;
import zes.base.vo.FileVO;
import zes.openworks.intra.board.BoardCmtVO;
import zes.openworks.intra.board.BoardConvertOptionVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.mgr.MgrVO;
import zes.openworks.intra.orderManage.consult.ConsultOrderVO;
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
 *  2012. 6. 14.     손재숙      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
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
     * 부류코드 2Depth 조회
     * @param boardConfVO
     * @return
     */
    List<BoardVO> boardAditCtgList(BoardVO boardVO);
    
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
     */
    Object boardInsert(BoardVO boardVO);

    /**
     * 게시물 수정 액션
     */
    int boardUpdate(BoardVO boardVO);

    /**
     * 개별 파일 삭제 액션
     */
    int fileDelete(FileVO fileVO);

    /**
     * 게시물 삭제 액션
     */
    int boardDelete(BoardVO boardVO, boolean useTrash);

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
     * 용량이 오버된 첨부파일을 삭제한다.
     */
    boolean fileDelete(List<FileVO> fileList);

    /**
     * 게시판에 대한 클라우드 태그 목록을 가져온다.
     */
    String tagCloud(Integer domainCd, Integer bbsCd);

    /**
     * 덧글 플래그 삭제 액션
     */
    int cmtFlagDelete(BoardCmtVO boardCmtVO);

    /**
     * 서비스 선택 리스트
     */
    Pager<ConsultOrderVO> popProduct(ConsultOrderVO consultOrderVO,  BoardVO boardVO);

    /**
     * 게시판 비즈매칭 선정여부 
     */
    int selectionUpdate(BoardVO boardVo);

    /**
     * cmtBoardView 설명
     * @param boardCmtVO
     * @return
     */
    BoardCmtVO cmtBoardView(BoardCmtVO boardCmtVO);

    /**
     * 덧글 중복체크 (비즈매칭)
     */
    Object bizCommentCheck(BoardCmtVO boardCmtVO);

    /**
     * productView 설명
     * @param boardVO
     * @return
     */
    int productView(BoardVO boardVO);

    /**
     * 카테고리에 등록된 서비스의 담당자 리스트정보 조회
     * @param boardVO
     * @return
     */
    List<RegisterUserVO> categoryUserList(BoardVO boardVO);
    
    /**
     * 희망 답변자 유저정보 조회
     * @param boardVO
     * @return
     */
    List<RegisterUserVO> selectCtgryUserList(BoardVO boardVO);

    /**
     * 게시믈 등록자 정보조회
     * @param boardVO
     * @return
     */
    BoardVO userBoardSelect(BoardVO boardVO);

    /**
     * 관리자 정보조회
     * @return
     */
    List<MgrVO>  mgrInfo();
}
