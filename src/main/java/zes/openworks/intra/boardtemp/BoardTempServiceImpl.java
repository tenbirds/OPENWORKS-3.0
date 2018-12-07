/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardtemp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * 게시판 템플릿 관리 서비스 구현
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
@Service("boardTempService")
public class BoardTempServiceImpl extends AbstractServiceImpl implements BoardTempService {

    @Resource
    private BoardTempDao dao;

    /**
     * 게시판 템플릿 목록 조회 (페이징)
     */
    @Override
    public Pager<BoardTempVO> boardTempPager(BoardTempVO vo) {
        List<BoardTempVO> dataList = dao.boardTempList(vo);
        vo.setTotalNum(dao.boardTempListCount(vo));
        return new Pager<BoardTempVO>(dataList, vo);
    }

    /**
     * 게시판 템플릿 목록 조회
     */
    @Override
    public List<BoardTempVO> boardTempList(BoardTempVO vo) {
        return dao.boardTempList(vo);
    }

    /**
     * 게시판 템플릿 상세 조회
     */
    @Override
    public BoardTempVO boardTempView(BoardTempVO vo){
        return dao.boardTempView(vo);
    }

    /**
     * 게시판 템플릿 사용여부 체크
     */
    @Override
    public int checkTemplateUsed(BoardTempVO vo){
        return dao.checkTemplateUsed(vo);
    }

    /**
     * 게시판 템플릿 ID 중복체크
     */
    @Override
    public int dupCheckTemplateId(BoardTempVO vo){
        return dao.dupCheckTemplateId(vo);
    }

    /**
     * 게시판 템플릿 등록
     */
    @Override
    public Object insertBoardTemplate(BoardTempVO vo){
        return dao.insertBoardTemplate(vo);
    }

    /**
     * 게시판 템플릿 수정
     */
    @Override
    public int updateBoardTemplate(BoardTempVO vo){
        return dao.updateBoardTemplate(vo);
    }

    /**
     * 게시판 템플릿 삭제
     */
    @Override
    public int deleteBoardTemplate(BoardTempVO vo){
        return dao.deleteBoardTemplate(vo);
    }
}