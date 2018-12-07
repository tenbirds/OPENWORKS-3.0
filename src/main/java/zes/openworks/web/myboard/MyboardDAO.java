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

import org.springframework.stereotype.Repository;

import zes.core.bind.VoBinder;
import zes.core.lang.Validate;
import zes.core.utils.DateFormatUtil;
import zes.openworks.component.file.FileDAO;
import zes.openworks.intra.board.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 나의 게시글 관리 DAO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일               수정자                     수정내용
 * --------------  --------  --------------------------------
 *  2012. 7. 23.     홍길동      JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
@Repository
public class MyboardDAO extends EgovAbstractMapper {

    @Resource
    private FileDAO fileDao;

    /**
     * 나의 게시글 목록
     * 
     * @param
     * @return List<BoardVO>
     */
    @SuppressWarnings({ "unchecked" })
    public List<BoardVO> totalboardList(BoardVO boardVO) {
        
        Map<String, Object> parameterMap = boardVO.getDataMap();
        VoBinder.methodBind(parameterMap, boardVO);
        List<BoardVO> dataList = list("_myboard.totalboardList", parameterMap);
        
        return dataList;
    }
    
    /**
     * 나의 게시글 목록
     * 
     * @param
     * @return List<BoardVO>
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<BoardVO> myboardList(Map parameterMap) {
        return list("_myboard.myboardList", parameterMap);
    }

    /**
     * 나의 게시글 목록 갯수
     * 
     * @param
     * @return Integer
     */
    @SuppressWarnings("rawtypes")
    public int myboardListCount(Map parameterMap) {
        return (Integer) selectByPk("_myboard.myboardListCount", parameterMap);
    }

    /**
     * 나의 게시글 목록 선택 삭제
     * 
     * @param
     * @return Integer
     */
    public int myBoardListDelete(BoardVO boardVO) {
        int result = 0;
        for(String seq : boardVO.getBbscttSeqs()) {
            BoardVO dataVO = new BoardVO();
            String[] temp = seq.split(":");
            dataVO.setBbsCd(new Integer(temp[0]));
            dataVO.setBbscttSeq(temp[1]);
            result += boardDelete(dataVO);
        }
        return result;
    }

    /**
     * 게시물 삭제 액션
     */
    private int boardDelete(BoardVO boardVO) {
        BoardVO deleteVO = (BoardVO) selectByPk("_boardWeb.boardView", boardVO);
        if(Validate.isEmpty(deleteVO.getBbscttSeq())) {
            return 0;
        }

        int affected = 0;
        deleteVO.setDelDt(DateFormatUtil.getToday());
        deleteVO.setDelDesc("나의 게시글 목록 삭제");
        deleteVO.setCmtSeq(null);

        insert("_boardWeb.trashBoardInsert", deleteVO);
        insert("_boardWeb.trashTagInsert", deleteVO);
        insert("_boardWeb.trashCommentInsert", deleteVO);

        fileDao.removeFile(deleteVO.getFileSeq());

        delete("_boardWeb.commentDeleteAll", deleteVO);
        delete("_boardWeb.boardTagDeleteAll", deleteVO);

        affected += delete("_boardWeb.boardDelete", deleteVO);

        return affected;
    }
}
