/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import zes.base.vo.BaseVO;
import zes.core.lang.validate.annotation.marker.Required;

/**
 * 게시판 확장 관리 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *   수정일                 수정자                    수정내용
 * --------------  --------  ---------------------------------
 *  2012. 4. 25.     손재숙       JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20.    박꽃송이      DB 컬럼(사이트 구분 - SITE_DIV_CD) 추가 관련 소스 수정
 * </pre>
 * @see
 */
public class BoardExtensionVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 5107498923052754886L;
    
    /** 도메인 코드 */
    private Integer domainCd;
    /** 게시판코드 */
    private Integer bbsCd;
    /** 컬럼 */
    @Required
    private String columnId;
    /** 컬럼명 */
    @Required
    private String columnNm;
    /** 컬럼유형 */
    private String columnTy;
    /** 컬럼주석 */
    private String columnCm;
    /** 컬럼명에 따른 Bean 멤버명 */
    private String beanName;
    /** 검색조건가부 */
    private String searchCndYn;
    /** 검색유형 */
    private String searchTy;
    /** 필요가부 */
    private String essntlYn;
    /** 사용가부 */
    @Required
    private String useYn;
    /** 언어별 열명 */
    private String langColumnNm;
    

    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
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

    public String getColumnTy() {
        return columnTy;
    }

    public void setColumnTy(String columnTy) {
        this.columnTy = columnTy;
    }

    public String getColumnCm() {
        return columnCm;
    }

    public void setColumnCm(String columnCm) {
        this.columnCm = columnCm;
    }

    public String getBeanName() {
        return beanName;
    }

    public void setBeanName(String beanName) {
        this.beanName = beanName;
    }
    
    public String getSearchCndYn() {
        return searchCndYn;
    }

    public void setSearchCndYn(String searchCndYn) {
        this.searchCndYn = searchCndYn;
    }

    public String getSearchTy() {
        return searchTy;
    }

    public void setSearchTy(String searchTy) {
        this.searchTy = searchTy;
    }

    public String getEssntlYn() {
        return essntlYn;
    }

    public void setEssntlYn(String essntlYn) {
        this.essntlYn = essntlYn;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
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

}
