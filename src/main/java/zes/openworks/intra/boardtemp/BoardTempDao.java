/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardtemp;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


/**
 * 게시판 템플릿 관리 DAO
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
@Repository
public class BoardTempDao extends EgovAbstractMapper {

    /**
     * 게시판 템플릿 목록 (페이징)
     */
    @SuppressWarnings("unchecked")
    public List<BoardTempVO> boardTempPager(BoardTempVO vo) {
        return list("_boardtemp.boardTempPager", vo.getDataMap());
    }

    /**
     * 게시판 템플릿 목록 카운트
     */
    public Integer boardTempListCount(BoardTempVO vo) {
        return (Integer)selectByPk("_boardtemp.boardTempListCount", vo.getDataMap());
    }

    /**
     * 게시판 템플릿 목록
     */
    @SuppressWarnings("unchecked")
    public List<BoardTempVO> boardTempList(BoardTempVO vo) {
        return list("_boardtemp.boardTempList", vo);
    }

    /**
     * 게시판 템플릿 상세
     */
    public BoardTempVO boardTempView(BoardTempVO vo) {
        return (BoardTempVO)selectByPk("_boardtemp.boardTempView", vo);
    }

    /**
     * 게시판 템플릿 사용여부 체크
     */
    public int checkTemplateUsed(BoardTempVO vo){
        return (Integer)selectByPk("_boardtemp.checkTemplateUsed", vo);
    }

    /**
     * 게시판 템플릿 ID 중복체크
     */
    public int dupCheckTemplateId(BoardTempVO vo){
        return (Integer)selectByPk("_boardtemp.dupCheckTemplateId", vo);
    }

    /**
     * 게시판 템플릿 등록
     */
    public Object insertBoardTemplate(BoardTempVO vo){
        return insert("_boardtemp.boardTempInsert", vo);
    }

    /**
     * 게시판 템플릿 수정
     */
    public int updateBoardTemplate(BoardTempVO vo){
//        vo.setUpdtDt(DateFormatUtil.getToday());
        return update("_boardtemp.boardTempUpdate", vo);
    }

    /**
     * 게시판 템플릿 삭제
     */
    public int deleteBoardTemplate(BoardTempVO vo){
        return update("_boardtemp.boardTempDelete", vo);
    }
}