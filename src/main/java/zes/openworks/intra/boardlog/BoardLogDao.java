/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import zes.core.lang.Validate;
import zes.core.utils.DateCalcUtil;
import zes.core.utils.DateFormatUtil;
import zes.core.utils.FileUtil;
import zes.openworks.intra.boardconf.BoardConfVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 게시판 로그 DAO
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

@Repository
public class BoardLogDao extends EgovAbstractMapper {

    /**
     * 전체 통계
     */
    @SuppressWarnings("unchecked")
    public Map<String, String> overviewLog(Integer domainCd, Integer bbsCd, Integer ctgCd) {
        Map<String, String> dataMap = new HashMap<String, String>();
        Map<String, String> paramMap = new HashMap<String, String>();
        
        paramMap.put("domainCd", String.valueOf(domainCd));
        paramMap.put("bbsCd", String.valueOf(bbsCd));
        
        if(ctgCd != null && Validate.isNotEmpty(ctgCd)){
            paramMap.put("ctgCd", String.valueOf(ctgCd));
        }

        String totalLog = (String) selectByPk("_board.totalLog", paramMap);
        dataMap.put("totalCreate", totalLog);

        String deleteLog = (String) selectByPk("_board.deleteTotalLog", paramMap);
        dataMap.put("totlaDelete", deleteLog);

        Integer totalComment = (Integer) selectByPk("_board.commentListCount", paramMap);
        dataMap.put("totalComment", String.valueOf(totalComment));

        String totalFileCnt = (String) selectByPk("_board.totalFileCnt", paramMap);
        dataMap.put("totalFileCnt", totalFileCnt);

        String totalFileDownCnt = (String) selectByPk("_board.totalFileDownCnt", paramMap);
        dataMap.put("totalFileDownCnt", totalFileDownCnt);

        String totalFileDownSize = (String) selectByPk("_board.totalFileDownSize", paramMap);
        dataMap.put("totalFileDownSize", FileUtil.toDisplaySize(Long.valueOf(totalFileDownSize)));

        // 검색기간 문자열 설정
        Map<String, String> termMap = (Map<String, String>) selectByPk("_board.getTotalTerm", paramMap);

        if(Validate.isNotEmpty(termMap) && Validate.isNotEmpty(termMap.get("END_DD"))) {
            String startDd = termMap.get("START_DD").substring(0, 8);
            String endDd = termMap.get("END_DD").substring(0, 8);
            String dateTerm = DateFormatUtil.parseDateShort(String.valueOf(startDd)) + " ~ " + DateFormatUtil.parseDateShort(String.valueOf(endDd));
            int dayDiff = DateCalcUtil.getDaysDiff(endDd, startDd) + 1;
            dataMap.put("searchTermStr", dateTerm);
            dataMap.put("average", String.valueOf((Integer.parseInt(totalLog) / dayDiff)));
            dataMap.put("dayDiff", String.valueOf(dayDiff));
        } else {
            dataMap.put("searchTermStr", "해당로그 없음");
            dataMap.put("average", "해당로그 없음");
            dataMap.put("dayDiff", "해당로그 없음");
        }

        return dataMap;
    }

    /**
     * 게시판 관련 통계
     */
    @SuppressWarnings("unchecked")
    public BoardLogData boardLog(BoardLogSearchVO searchVO) {
        Map<String, Object> paramMap = BoardLogUtil.crateParameterMap(searchVO);
        BoardLogData boardLogData = new BoardLogData();

        paramMap.put("domainCd", searchVO.getDomainCd());
        paramMap.put("ctgCd", searchVO.getCtgCd());
        List<BoardLogVO> createLogList = null;
        List<BoardLogVO> deleteLogList = null;
        List<BoardLogVO> commentLogList = null;

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            createLogList = list("_boardlog.yearCreateLog", paramMap);
            deleteLogList = list("_boardlog.yearDeleteLog", paramMap);
            commentLogList = list("_boardlog.yearCmtCreateLog", paramMap);
            boardLogData.setCaption("연간 게시물 통계");
        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            createLogList = list("_boardlog.monthCreateLog", paramMap);
            deleteLogList = list("_boardlog.monthDeleteLog", paramMap);
            commentLogList = list("_boardlog.monthCmtCreateLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 월간 게시물 통계");

        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            createLogList = list("_boardlog.dayCreateLog", paramMap);
            deleteLogList = list("_boardlog.dayDeleteLog", paramMap);
            commentLogList = list("_boardlog.dayCmtCreateLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 일간 게시물 통계");

        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            createLogList = list("_boardlog.hourCreateLog", paramMap);
            deleteLogList = list("_boardlog.hourDeleteLog", paramMap);
            commentLogList = list("_boardlog.hourCmtCreateLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 " + searchVO.getSearchDay() + "일 시간별 게시물 통계");

        } else {
            return boardLogData;
        }

        boardLogData.addCategoryList(createLogList);
        boardLogData.addDataSet("게시물 등록 갯수", createLogList);
        boardLogData.addDataSet("게시물 삭제 갯수", deleteLogList);
        boardLogData.addDataSet("댓글 등록 갯수", commentLogList);

        return boardLogData;
    }

    /**
     * 댓글 관련 통계
     */
    @SuppressWarnings("unchecked")
    public BoardLogData commentLog(BoardLogSearchVO searchVO) {
        Map<String, Object> paramMap = BoardLogUtil.crateParameterMap(searchVO);
        BoardLogData boardLogData = new BoardLogData();

        paramMap.put("domainCd", searchVO.getDomainCd());
        paramMap.put("ctgCd", searchVO.getCtgCd());
        List<BoardLogVO> createLogList = null;
        List<BoardLogVO> deleteLogList = null;

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            createLogList = list("_boardlog.yearCmtCreateLog", paramMap);
            deleteLogList = list("_boardlog.yearCmtDeleteLog", paramMap);
            boardLogData.setCaption("연간 댓글 통계");

        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            createLogList = list("_boardlog.monthCmtCreateLog", paramMap);
            deleteLogList = list("_boardlog.monthCmtDeleteLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 월간 댓글 통계");

        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            createLogList = list("_boardlog.dayCmtCreateLog", paramMap);
            deleteLogList = list("_boardlog.dayCmtDeleteLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 일간 댓글 통계");

        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            createLogList = list("_boardlog.hourCmtCreateLog", paramMap);
            deleteLogList = list("_boardlog.hourCmtDeleteLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 " + searchVO.getSearchDay() + "일 시간별 댓글 통계");

        } else {
            return boardLogData;
        }

        boardLogData.addCategoryList(createLogList);
        boardLogData.addDataSet("댓글 등록 갯수", createLogList);
        boardLogData.addDataSet("댓글 삭제 갯수", deleteLogList);

        return boardLogData;
    }

    /**
     * 첨부파일 다운로드 통계
     */
    @SuppressWarnings("unchecked")
    public BoardLogData fileDownLog(BoardLogSearchVO searchVO) {
        Map<String, Object> paramMap = BoardLogUtil.crateParameterMap(searchVO);
        BoardLogData boardLogData = new BoardLogData();

        paramMap.put("domainCd", searchVO.getDomainCd());
        paramMap.put("ctgCd", searchVO.getCtgCd());
        
        List<BoardLogVO> downCntLogList = null;
        List<BoardLogVO> downSizeLogList = null;

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            downCntLogList = list("_boardlog.yearFileDownCntLog", paramMap);
            downSizeLogList = list("_boardlog.yearFileDownSizeLog", paramMap);
            boardLogData.setCaption("연간 파일 다운로드 통계");

        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            downCntLogList = list("_boardlog.monthFileDownCntLog", paramMap);
            downSizeLogList = list("_boardlog.monthFileDownSizeLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 월간 파일 다운로드 통계");

        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            downCntLogList = list("_boardlog.dayFileDownCntLog", paramMap);
            downSizeLogList = list("_boardlog.dayFileDownSizeLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 일간 파일 다운로드 통계");

        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            downCntLogList = list("_boardlog.hourFileDownCntLog", paramMap);
            downSizeLogList = list("_boardlog.hourFileDownSizeLog", paramMap);
            boardLogData
                .setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 " + searchVO.getSearchDay() + "일 시간별 파일 다운로드 통계");

        } else {
            return boardLogData;
        }

        boardLogData.addCategoryList(downCntLogList);
        boardLogData.addDataSet("파일 다운 횟수", downCntLogList);
        boardLogData.addDataSet("다운로드 사이즈(MB)", downSizeLogList, "S", "111111");

        return boardLogData;
    }

    /**
     * 첨부파일 업로드 통계
     */
    @SuppressWarnings("unchecked")
    public BoardLogData fileUploadLog(BoardLogSearchVO searchVO) {
        Map<String, Object> paramMap = BoardLogUtil.crateParameterMap(searchVO);
        BoardLogData boardLogData = new BoardLogData();

        paramMap.put("domainCd", searchVO.getDomainCd());
        paramMap.put("ctgCd", searchVO.getCtgCd());
        List<BoardLogVO> createLogList = null;
        List<BoardLogVO> uploadSizeLogList = null;

        Integer typeCd = searchVO.getTypeCd();

        if(BoardLogConstant.TYPE_YEAR.equals(typeCd)) {
            createLogList = list("_boardlog.yearFileCreateLog", paramMap);
            uploadSizeLogList = list("_boardlog.yearFileUploadSizeLog", paramMap);
            boardLogData.setCaption("연간 파일 업로드 통계");

        } else if(BoardLogConstant.TYPE_MONTH.equals(typeCd)) {
            createLogList = list("_boardlog.monthFileCreateLog", paramMap);
            uploadSizeLogList = list("_boardlog.monthFileUploadSizeLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 월간 파일 업로드 통계");

        } else if(BoardLogConstant.TYPE_DAY.equals(typeCd)) {
            createLogList = list("_boardlog.dayFileCreateLog", paramMap);
            uploadSizeLogList = list("_boardlog.dayFileUploadSizeLog", paramMap);
            boardLogData.setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 일간 파일 업로드 통계");

        } else if(BoardLogConstant.TYPE_HOUR.equals(typeCd)) {
            createLogList = list("_boardlog.hourFileCreateLog", paramMap);
            uploadSizeLogList = list("_boardlog.hourFileUploadSizeLog", paramMap);
            boardLogData
                .setCaption(searchVO.getSearchYear() + "년 " + searchVO.getSearchMonth() + "월 " + searchVO.getSearchDay() + " 일 시간별 파일 업로드 통계");

        } else {
            return boardLogData;
        }

        boardLogData.addCategoryList(createLogList);
        boardLogData.addDataSet("파일 등록 횟수", createLogList);
        boardLogData.addDataSet("업로드 사이즈(MB)", uploadSizeLogList, "S", "222222");

        return boardLogData;
    }
    
    /**
     * 게시판 목록 가져오기
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardConfVO> boardConfList(BoardConfVO boardConfVo) {
        List<BoardConfVO> dataList = list("_boardlog.boardConfList", boardConfVo);
        return dataList;
    }
    
    /**
     * 게시판 분류 가져오기
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BoardConfVO> boardCtgNmsList(BoardConfVO boardConfVo) {
        List<BoardConfVO> dataList = list("_boardlog.boardCtgNmsList", boardConfVo);
        return dataList;
    }
}
