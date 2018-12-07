/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import java.util.List;

import zes.base.vo.BaseVO;
import zes.base.vo.FileVO;

/**
 * 게시판 목록/상세 배치 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *   수정일			  수정자					수정내용
 * --------------  --------  ---------------------------------
 *  2012. 5. 9.      손재숙	  JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20.     박꽃송이      DB 컬럼(사이트 구분 - DOMAIN_CD) 추가 관련 소스 수정
 * </pre>
 * @see
 */
public class BoardArrangeVO extends BaseVO {

    private static final long serialVersionUID = 3146240459147309647L;

    /** 도메인 코드 */
    private Integer domainCd;
    /** 표시항목 목록 */
    private String[] displayColumns;

    /** 게시판 코드 */
    private Integer bbsCd = 0;
    /** 목록 상세화면 구분 */
    private String listViewSe;
    /** 컬럼 아이디 ID */
    private String columnId;
    /** 컬럼명 */
    private String columnNm;
    /** 항목정리순서번호 */
    private Integer arrangeOrdrNo = 0;
    /** JAVABEAN명 */
    private String beanNm;
    
    /** 언어별 컬럼명 */
    private String langColumnNm;
    
    /** 언어별 엑셀파일 */
    private List<FileVO> fileList;

    public String[] getDisplayColumns() {
        return displayColumns;
    }

    public void setDisplayColumns(String[] displayColumns) {
        this.displayColumns = displayColumns;
    }

    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    public String getListViewSe() {
        return listViewSe;
    }

    public void setListViewSe(String listViewSe) {
        this.listViewSe = listViewSe;
    }

    public String getColumnId() {
        return columnId;
    }

    public void setColumnId(String columnId) {
        this.columnId = columnId;
    }

    public String getColumnNm() {
        return columnNm;
    }

    public void setColumnNm(String columnNm) {
        this.columnNm = columnNm;
    }

    public Integer getArrangeOrdrNo() {
        return arrangeOrdrNo;
    }

    public void setArrangeOrdrNo(Integer arrangeOrdrNo) {
        this.arrangeOrdrNo = arrangeOrdrNo;
    }

    public String getBeanNm() {
        return beanNm;
    }

    public void setBeanNm(String beanNm) {
        this.beanNm = beanNm;
    }


    public Integer getDomainCd() {
        return domainCd;
    }


    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }


    public String getLangColumnNm() {
        return langColumnNm;
    }


    public void setLangColumnNm(String langColumnNm) {
        this.langColumnNm = langColumnNm;
    }

    
    public List<FileVO> getFileList() {
        return fileList;
    }

    
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    
}
