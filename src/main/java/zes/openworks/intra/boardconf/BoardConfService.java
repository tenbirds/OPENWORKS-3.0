/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jxl.read.biff.BiffException;
import zes.base.pager.Pager;
import zes.openworks.intra.boardtemp.BoardTempVO;

/**
 * 게시판 관리 서비스 인터페이스
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *       수정일          수정자                 수정내용
 * --------------  --------  --------------------------------
 *  2012. 4. 25.    손재숙       JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20.    박꽃송이    DB 컬럼(사이트 구분 - SITE_DIV_CD) 추가로 인한 수정 및 추가
 * </pre>
 * @see
 */
public interface BoardConfService {

    /**
     * 게시판 목록 조회
     */
    Pager<BoardConfVO> boardConfList(BoardConfVO boardConfVO);

    /**
     * 게시판 목록 조회
     */
    List<BoardConfVO> boardConfList();

    /**
     * 게시판 상세 조회
     */
    BoardConfVO boardConfView(BoardConfVO boardConfVO);

    /**
     * 게시판 전체항목 목록
     */
    List<BoardArrangeVO> boardColumnList(BoardArrangeVO boardArrangeVO);

    /**
     * 게시판 표시항목 목록
     */
    List<BoardArrangeVO> boardDisplayColumnList(BoardArrangeVO boardArrangeVO);

    /**
     * 게시판 확장관리 목록
     */
    List<BoardExtensionVO> boardConfExtList(BoardConfVO boardConfVO);

    /**
     * 게시판 템플릿 목록
     */
    List<BoardTempVO> boardTemplateList(String type);

    /**
     * 게시판 생성시 확장 기능 등록 정보
     */
    int updateExtAction(List<BoardExtensionVO> extList);

    /**
     * 게시판 등록 액션
     */
    Object insertAction(BoardConfVO boardConfVO);

    /**
     * 게시판 수정 액션
     */
    int updateAction(BoardConfVO boardConfVO);

    /**
     * 게시판 목록/상세 배치 수정 액션
     * @param request 
     * @throws IOException 
     * @throws BiffException 
     * @throws Exception 
     */
    int arrangeUpdateAction(BoardArrangeVO boardArrangeVO,HttpServletRequest request) throws Exception;

    /**
     * 게시판 칼럼별 사용여부 수정 액션
     */
    int updateAction(BoardConfYnVO boardConfYnVO);

    /**
     * 게시판 삭제 액션
     * 현재 SeniorBbs사용 설정됨.
     * 사이트마다 참조하고 있는 게시판으로 바꿔줘야 합니다.
     */
    int deleteAction(Integer domainCd, String[] bbsCds);

    /**
     * 게시판 삭제 액션
     */
    Integer boardConfDelete(BoardConfVO boardConfVO);

    /**
     * 게시판 목록 삭제 액션
     */
    Integer boardConfListDelete(BoardConfVO boardConfVO);

    /**
     * 게시판 복사 액션
     */
    Object copyAction(String domainCd, String oldBbsCd, String newBbsNm, String newBbsDesc);

    /**
     * 게시판 확장 설정 복사
     */
    int extCopyAction(Integer oldBbsCd);

    /**
     * 게시판 설정 정보를 리로드 합니다.
     */
    void reloadBbsCache();
    
    
    /* ------------------------------ 2014. 9. 20 추가 ------------------------------*/
    
    /**
     * 도메인별 메뉴 목록 불러오기
     * @param boardConfVO
     * @return
     */
    @SuppressWarnings("rawtypes")
    List boardTypeList(BoardConfVO boardConfVO);


}
