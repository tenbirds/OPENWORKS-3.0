/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.List;
import java.util.Map;

import zes.openworks.intra.boardconf.BoardConfVO;

/**
 * 게시판 로그 Service
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일               수정자                         수정내용
 * --------------  --------  --------------------------------
 *  2012. 6. 25.     홍길동      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public interface BoardLogService {

    /**
     * 전체 통계
     */
    Map<String, String> overviewLog(Integer domainCd, Integer bbsCd, Integer ctgCd);

    /**
     * 게시판 관련 통계
     */
    BoardLogData boardLog(BoardLogSearchVO searchVO);

    /**
     * 덧글 관련 통계
     */
    BoardLogData commentLog(BoardLogSearchVO searchVO);

    /**
     * 첨부파일 다운로드 통계
     */
    BoardLogData fileDownLog(BoardLogSearchVO searchVO);

    /**
     * 첨부파일 업로드 통계
     */
    BoardLogData fileUploadLog(BoardLogSearchVO searchVO);
    
    /**
     * 게시판 목록 가져오기
     */
    List<BoardConfVO> boardConfList(BoardConfVO boardConfVo);
    
    /**
     * 게시판 분류 가져오기
     */
    List<BoardConfVO> boardCtgNmsList(BoardConfVO boardConfVo);
}
