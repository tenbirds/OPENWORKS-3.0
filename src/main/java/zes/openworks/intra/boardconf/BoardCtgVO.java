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

/**
 * 게시판 부류 VO 객체
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
 *  2012. 4. 25.    손재숙         JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 10.10.    박꽃송이      DB 컬럼 추가 및 수정
 * </pre>
 * @see
 */
public class BoardCtgVO extends BaseVO {

    private static final long serialVersionUID = -1468565720003089340L;

    /** 카테고리 목록(1Depth) */
    private List<BoardCtgVO> ctgList;
    /** 카테고리 목록(2Depth) */
    private List<BoardCtgVO> aditCtgList;

    /** 도메인 코드 */
    private Integer domainCd;
    /** 게시판 코드 */
    private Integer bbsCd = 0;
    /** 부류 코드(1depth 와 2depth ctgCd구별 ) */
    private Integer aCtgCd = 0;
    /** 부류 코드(1depth) */
    private Integer ctgCd = 0;
    /** 부류 코드(2depth) */
    private Integer aditCtgCd = 0;
    /** 부류명(1depth) */
    private String ctgNm;
    /** 부류명(2depth) */
    private String aditCtgNm;
    /** 부류순서번호 */
    private Integer ctgOrdrNo = 0;
    /** 사용가부 */
    private String useYn;


    public List<BoardCtgVO> getCtgList() {
        return ctgList;
    }

    public void setCtgList(List<BoardCtgVO> ctgList) {
        this.ctgList = ctgList;
    }

    public List<BoardCtgVO> getAditCtgList() {
        return aditCtgList;
    }

    public void setAditCtgList(List<BoardCtgVO> aditCtgList) {
        this.aditCtgList = aditCtgList;
    }

    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    public Integer getaCtgCd() {
        return aCtgCd;
    }

    
    public void setaCtgCd(Integer aCtgCd) {
        this.aCtgCd = aCtgCd;
    }

    public Integer getCtgCd() {
        return ctgCd;
    }

    public void setCtgCd(Integer ctgCd) {
        this.ctgCd = ctgCd;
    }

    public Integer getAditCtgCd() {
        return aditCtgCd;
    }

    public void setAditCtgCd(Integer aditCtgCd) {
        this.aditCtgCd = aditCtgCd;
    }

    public String getCtgNm() {
        return ctgNm;
    }
    
    public void setCtgNm(String ctgNm) {
        this.ctgNm = ctgNm;
    }

    
    public String getAditCtgNm() {
        return aditCtgNm;
    }

    
    public void setAditCtgNm(String aditCtgNm) {
        this.aditCtgNm = aditCtgNm;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public Integer getCtgOrdrNo() {
        return ctgOrdrNo;
    }

    public void setCtgOrdrNo(Integer ctgOrdrNo) {
        this.ctgOrdrNo = ctgOrdrNo;
    }

    public Integer getDomainCd() {
        return domainCd;
    }


    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }
}
