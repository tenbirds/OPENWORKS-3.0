/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardtemp;

import java.util.List;

import zes.base.pager.Pager;


/**
 * 게시판 템플릿 관리 서비스 인터페이스
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2013. 6. 7.    Administrator   신규 생성
 *</pre>
 * @see
 */
public interface BoardTempService {

    /**
     * 게시판 템플릿 목록 조회 (페이징)
     */
    Pager<BoardTempVO> boardTempPager(BoardTempVO vo);

    /**
     * 게시판 템플릿 목록 조회
     */
    List<BoardTempVO> boardTempList(BoardTempVO vo);

    /**
     * 게시판 템플릿 상세 조회
     */
    BoardTempVO boardTempView(BoardTempVO vo);

    /**
     * 게시판 템플릿 사용여부 체크
     */
    int checkTemplateUsed(BoardTempVO vo);

    /**
     * 게시판 템플릿 ID 중복체크
     */
    int dupCheckTemplateId(BoardTempVO vo);

    /**
     * 게시판 템플릿 등록
     */
    Object insertBoardTemplate(BoardTempVO vo);

    /**
     * 게시판 템플릿 수정
     */
    int updateBoardTemplate(BoardTempVO vo);

    /**
     * 게시판 템플릿 삭제
     */
    int deleteBoardTemplate(BoardTempVO vo);
}