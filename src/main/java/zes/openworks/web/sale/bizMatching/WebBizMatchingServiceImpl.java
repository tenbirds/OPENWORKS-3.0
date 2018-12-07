/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale.bizMatching;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.board.BoardVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("WebBizMatchingService")
public class WebBizMatchingServiceImpl extends AbstractServiceImpl implements WebBizMatchingService {

    @Resource
    private WebBizMatchingDAO bizMatchingDao;

    @Resource
    private FileDAO fileDao;

    /**
     * 나의 비즈매칭 활동내역 조회
     */
    @Override
    public Pager<BoardVO> myBizBoardList(BoardVO boardVO) {
        return bizMatchingDao.myBizBoardList(boardVO);
    }

    /**
     * 비즈매칭 신규등록내역 조회
     */
    @Override
    public List<BoardVO> newBizBoardList(BoardVO boardVO) {
        return bizMatchingDao.newBizBoardList(boardVO);
    }

    /** 
     * 비즈매칭 알림설정
     */
    @Override
    public List<BoardVO> categoryList(BoardVO boardVO) {
        return bizMatchingDao.categoryList(boardVO);
    }

    /** 
     * 비즈매칭 카테고리 등록(수정)
     */
    @Override
    public Boolean categoryInsert(BoardVO boardVO) {
        return bizMatchingDao.categoryInsert(boardVO);
    }


}
