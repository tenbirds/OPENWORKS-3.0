/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myboard;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import zes.base.pager.Pager;
import zes.core.bind.VoBinder;
import zes.openworks.intra.board.BoardVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 나의 게시글 관리 처리 구현객체
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
@Service("myboardService")
public class MyboardServiceImpl extends AbstractServiceImpl implements MyboardService {

    @Resource
    private MyboardDAO dao;

    @Override
    public Pager<BoardVO> myboardList(BoardVO vo) {

        Map<String, Object> parameterMap = vo.getDataMap();
        VoBinder.methodBind(parameterMap, vo);
        List<BoardVO> dataList = null;
        
        dataList = dao.myboardList(parameterMap);
        vo.setTotalNum(dao.myboardListCount(parameterMap));

        return new Pager<BoardVO>(dataList, vo);
    }

    /**
     * 나의 게시글 목록 선택 삭제
     */
    @Override
    public int myBoardListDelete(BoardVO vo) {
        return dao.myBoardListDelete(vo);
    }
    
    /**
     * 게시판목록
     */
    @Override
    public List<BoardVO> totalboardList(BoardVO vo) {
        return dao.totalboardList(vo);
    }
}
