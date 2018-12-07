/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.board;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import zes.base.vo.IExcelVO;
import zes.core.utils.DateFormatUtil;
import zes.openworks.intra.board.BoardConvertOptionVO;
import zes.openworks.intra.board.BoardVO;
import zes.openworks.intra.boardconf.BoardConfConstant;
import zes.openworks.intra.boardconf.BoardConfVO;

/**
 * EXCEL 파일 생성 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 * 	수정일	            수정자                          수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 14.	      손재숙       JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardExcelVO implements IExcelVO {

    /** 데이타 목록 */
    private List<BoardVO> itemList;

    /** 데이타 목록 */
    private BoardConvertOptionVO boardConvertOptionVO;

    /** 데이타 목록 */
    private BoardConfVO boardConfVO;

    public List<BoardVO> getItemList() {
        return itemList;
    }

    public void setItemList(List<BoardVO> itemList) {
        this.itemList = itemList;
    }

    public BoardConvertOptionVO getBbsConvertOptionVO() {
        return boardConvertOptionVO;
    }

    public void setBbsConvertOptionVO(BoardConvertOptionVO boardConvertOptionVO) {
        this.boardConvertOptionVO = boardConvertOptionVO;
    }

    public BoardConfVO getBbsConfVO() {
        return boardConfVO;
    }

    public void setBbsConfVO(BoardConfVO boardConfVO) {
        this.boardConfVO = boardConfVO;
    }

    /**
     * 엑셀파일 생성
     */
    @Override
    public void createExcelDocument(HSSFWorkbook workbook, @SuppressWarnings("rawtypes") Map model) {
        HSSFSheet sheet = workbook.createSheet();

        HSSFRow title = sheet.createRow(0);
        title.createCell(0).setCellValue(boardConfVO.getBbsNm());

        HSSFRow header = sheet.createRow(1);
        int colNum = 0;
        header.createCell(colNum++).setCellValue(
            String.valueOf("공지 : ") + String.valueOf(("Y".equals(boardConvertOptionVO.getNoticeBbscttUseYn())) ? "표 시" : "미표시"));
        header.createCell(colNum++).setCellValue(
            String.valueOf("말머리 : ") + String.valueOf(("Y".equals(boardConvertOptionVO.getCtgCdYn())) ? boardConvertOptionVO.getQ_ctgCd() : "미사용"));
        header.createCell(colNum++).setCellValue(
            String.valueOf("검색주제 : ") + String.valueOf(boardConvertOptionVO.getQ_searchKey()));
        header.createCell(colNum++).setCellValue(
            String.valueOf("검색어 : ") + String.valueOf(boardConvertOptionVO.getQ_searchVal()));
        header.createCell(colNum++).setCellValue(
            String.valueOf("정렬기준 : ") + String.valueOf(boardConvertOptionVO.getQ_sortName()));
        header.createCell(colNum++).setCellValue(
            String.valueOf("정렬순서 : ") + String.valueOf(("ASC".equals(boardConvertOptionVO.getQ_sortOrder())) ? "오름차순" : "내림차순"));
        header = sheet.createRow(2);
        colNum = 0;
        header.createCell(colNum++).setCellValue(
            String.valueOf("검색시작일 : ") + String.valueOf(boardConvertOptionVO.getQ_startDt()));
        header.createCell(colNum++).setCellValue(
            String.valueOf("검색종료일: ") + String.valueOf(boardConvertOptionVO.getQ_endDt()));

        colNum = 0;
        HSSFRow rw = sheet.createRow(5);
        rw.createCell(colNum++).setCellValue("순서");
        if("Y".equals(boardConvertOptionVO.getNoticeBbscttUseYn())) {
            rw.createCell(colNum++).setCellValue("종류");
        }
        if("Y".equals(boardConvertOptionVO.getBbscttSjYn())) {
            rw.createCell(colNum++).setCellValue("제목");
        }
        if("Y".equals(boardConvertOptionVO.getCnSumryYn())) {
            rw.createCell(colNum++).setCellValue("요약");
        }
        if("Y".equals(boardConvertOptionVO.getRegistDtYn())) {
            rw.createCell(colNum++).setCellValue("등록일");
        }
        if("Y".equals(boardConvertOptionVO.getUpdtDtYn())) {
            rw.createCell(colNum++).setCellValue("수정일");
        }
        if("Y".equals(boardConvertOptionVO.getRegisterNmYn())) {
            rw.createCell(colNum++).setCellValue("작성자");
        }
        if("Y".equals(boardConvertOptionVO.getMngrIdYn())) {
            rw.createCell(colNum++).setCellValue("매니저ID");
        }
        if("Y".equals(boardConvertOptionVO.getUserKeyYn())) {
            rw.createCell(colNum++).setCellValue("유저ID");
        }
        if("Y".equals(boardConvertOptionVO.getRdcntYn())) {
            rw.createCell(colNum++).setCellValue("조회수");
        }
        if("Y".equals(boardConvertOptionVO.getAccuseCntYn())) {
            rw.createCell(colNum++).setCellValue("신고");
        }
        if("Y".equals(boardConvertOptionVO.getRecomendCntYn())) {
            rw.createCell(colNum++).setCellValue("추천");
        }

        // 출력할 목록을 순회하면서 로우를 만들어낸다.
        int rowNum = 6;
        for(BoardVO boardVO : itemList) {
            colNum = 0;
            HSSFRow row = sheet.createRow(rowNum++);
            row.createCell(colNum++).setCellValue(rowNum - 6);
            if("Y".equals(boardConvertOptionVO.getNoticeBbscttUseYn())) {
                row.createCell(colNum++).setCellValue("Y".equals(boardVO.getNoticeBbscttAt()) ? "공지" : "게시글");
            }
            if("Y".equals(boardConvertOptionVO.getBbscttSjYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getBbscttSj());
            }
            if("Y".equals(boardConvertOptionVO.getCnSumryYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getCnSumry());
            }
            if("Y".equals(boardConvertOptionVO.getRegistDtYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getRegistDt());
            }
            if("Y".equals(boardConvertOptionVO.getUpdtDtYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getUpdtDt());
            }
            if("Y".equals(boardConvertOptionVO.getRegisterNmYn())) {
                int viewCd = boardConfVO.getRegisterIndictCd().intValue();
                switch(viewCd) {
                    case BoardConfConstant.GUBUN_SHOW_NM:
                        row.createCell(colNum++).setCellValue(
                            boardVO.getMngrNm() + boardVO.getUserNm() + boardVO.getRegisterNm());
                        break;
                    case BoardConfConstant.GUBUN_SHOW_ID:
                        row.createCell(colNum++).setCellValue(
                            boardVO.getMngrId() + boardVO.getRegistId() + boardVO.getRegisterNm());
                        break;
                    case BoardConfConstant.GUBUN_SHOW_DEPT_NM:
                        row.createCell(colNum++).setCellValue(boardVO.getDeptNm());
                        break;
                    default:
                        row.createCell(colNum++).setCellValue(boardVO.getRegisterNm());
                        break;
                }
            }
            if("Y".equals(boardConvertOptionVO.getMngrIdYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getMngrId());
            }
            if("Y".equals(boardConvertOptionVO.getUserKeyYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getUserKey());
            }
            if("Y".equals(boardConvertOptionVO.getRdcntYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getRdcnt());
            }
            if("Y".equals(boardConvertOptionVO.getAccuseCntYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getAccuseCnt());
            }
            if("Y".equals(boardConvertOptionVO.getRecomendCntYn())) {
                row.createCell(colNum++).setCellValue(boardVO.getRecomendCnt());
            }
        }
    }

    /**
     * 저장파일명
     */
    @Override
    public String getFileName() {
        return (boardConfVO.getBbsNm() + "_" + DateFormatUtil.getTodayFull());
    }
}
