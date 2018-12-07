/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myboard;

import java.util.List;

import zes.base.pager.Pager;
import zes.openworks.intra.board.BoardVO;

/**
 * 나의 게시글 처리 프로세스 인터페이스
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일              수정자                         수정내용
 * --------------  --------  -------------------------------
 *  2012. 7. 23.    방기배       JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface MyboardService {

    /**
     * 나의 게시글 목록
     */
    public Pager<BoardVO> myboardList(BoardVO vo);

    /**
     * 나의 게시글 목록 선택 삭제
     */
    public int myBoardListDelete(BoardVO vo);
    /**
     * 게시판목록
     */
    public List<BoardVO> totalboardList(BoardVO vo);
}
