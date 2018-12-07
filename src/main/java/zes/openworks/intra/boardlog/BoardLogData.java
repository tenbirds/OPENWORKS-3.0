/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardlog;

import java.util.ArrayList;
import java.util.List;

/**
 * 게시판 로그 화면 표시를 위한 Data
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
public class BoardLogData {

    /** 단일 데이터 차트용 데이터 */
    private List<List<Integer>> itemList;

    /** 셀렉트박스용 연도목록 */
    private List<BoardLogVO> yearList;
    /** 셀렉트박스용 월 목록 */
    private List<BoardLogVO> monthList;

    /** 차트 캡션 */
    private String caption;
    /** 카테고리 목록 */
    private List<String> categoryList = null;
    /** 데이터셋 목록 */
    private List<BoardDataSetVO> dataSetList = null;

    /** 게시물 등록 수 */
    private int bbsAddCnt;
    /** 게시물 삭제 수 */
    private int bbsDelCnt;
    /** 커멘트 등록 수 */
    private int commentAddCnt;
    /** 첨부파일 등록 수 */
    private int fileAddCnt;
    /** 첨부파일 다운로드 수 */
    private int fileDownCnt;
    /** 첨부파일 다운로드 사이즈 */
    private int fileDownSize;

    public String getData(int x, int y) {
        return dataSetList.get(x).getDataList().get(y).toString();
    }

    public void addDataSet(String dataSetNm, List<BoardLogVO> boardLogVOList) {
        addDataSet(dataSetNm, boardLogVOList, "", "");
    }

    public void addDataSet(String dataSetNm, List<BoardLogVO> boardLogVOList, String axisy, String color) {
        if(this.dataSetList == null) {
            this.dataSetList = new ArrayList<BoardDataSetVO>();
        }

        BoardDataSetVO boardDataSetVO = new BoardDataSetVO();
        boardDataSetVO.setDataSetNm(dataSetNm);
        boardDataSetVO.setAxisY(axisy);
        boardDataSetVO.setColor(color);

        List<Integer> integerList = new ArrayList<Integer>();
        for(BoardLogVO bean : boardLogVOList) {
            integerList.add(bean.getValue());
        }
        boardDataSetVO.setDataList(integerList, this.categoryList);
        this.dataSetList.add(boardDataSetVO);
    }

    public void addCategoryList(List<BoardLogVO> boardLogVOList) {
        if(this.categoryList == null) {
            this.categoryList = new ArrayList<String>();
        }
        for(BoardLogVO bean : boardLogVOList) {
            this.categoryList.add(bean.getLabel());
        }
    }

    public void addItemList(List<BoardLogVO> boardLogVOList) {
        if(this.itemList == null) {
            this.itemList = new ArrayList<List<Integer>>();

            for(int i = 0 ; i < boardLogVOList.size() ; i++) {
                // this.itemList
            }
        }

        for(int i = 0 ; i < boardLogVOList.size() ; i++) {

        }
    }

    public List<List<Integer>> getItemList() {
        return itemList;
    }

    public void setItemList(List<List<Integer>> itemList) {
        this.itemList = itemList;
    }

    public List<BoardLogVO> getYearList() {
        return yearList;
    }

    public void setYearList(List<BoardLogVO> yearList) {
        this.yearList = yearList;
    }

    public List<BoardLogVO> getMonthList() {
        return monthList;
    }

    public void setMonthList(List<BoardLogVO> monthList) {
        this.monthList = monthList;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public List<String> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<String> categoryList) {
        this.categoryList = categoryList;
    }

    public List<BoardDataSetVO> getDataSetList() {
        return dataSetList;
    }

    public void setDataSetList(List<BoardDataSetVO> dataSetList) {
        this.dataSetList = dataSetList;
    }

    public int getBbsAddCnt() {
        return bbsAddCnt;
    }

    public void setBbsAddCnt(int bbsAddCnt) {
        this.bbsAddCnt = bbsAddCnt;
    }

    public int getBbsDelCnt() {
        return bbsDelCnt;
    }

    public void setBbsDelCnt(int bbsDelCnt) {
        this.bbsDelCnt = bbsDelCnt;
    }

    public int getCommentAddCnt() {
        return commentAddCnt;
    }

    public void setCommentAddCnt(int commentAddCnt) {
        this.commentAddCnt = commentAddCnt;
    }

    public int getFileAddCnt() {
        return fileAddCnt;
    }

    public void setFileAddCnt(int fileAddCnt) {
        this.fileAddCnt = fileAddCnt;
    }

    public int getFileDownCnt() {
        return fileDownCnt;
    }

    public void setFileDownCnt(int fileDownCnt) {
        this.fileDownCnt = fileDownCnt;
    }

    public int getFileDownSize() {
        return fileDownSize;
    }

    public void setFileDownSize(int fileDownSize) {
        this.fileDownSize = fileDownSize;
    }
}
