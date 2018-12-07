/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import zes.base.vo.BaseVO;

/**
 * 게시판 태그 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *      수정일		 수정자				   수정내용
 * --------------  --------  ---------------------------------
 *  2012. 5. 14.	 손재숙	 JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardTagVO extends BaseVO {

    private static final long serialVersionUID = -9078428935462207175L;

    /** 사이트 구분 코드 */
    private Integer domainCd;
    /** 게시판 코드 */
    private Integer bbsCd;
    /** 일련번호 */
    private String bbscttSeq;
    /** 태그 이름 */
    private String tagNm;
    /** 태그 갯수 */
    private Integer tagCnt;

    public BoardTagVO(Integer domainCd, Integer bbsCd, String bbscttSeq, String tagNm) {
        this.domainCd = domainCd;
        this.bbsCd = bbsCd;
        this.bbscttSeq = bbscttSeq;
        this.tagNm = tagNm;
    }

    public BoardTagVO() {
        // 기본 생성자
    }

    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    public String getBbscttSeq() {
        return bbscttSeq;
    }

    public void setBbscttSeq(String bbscttSeq) {
        this.bbscttSeq = bbscttSeq;
    }

    public String getTagNm() {
        return tagNm;
    }

    public void setTagNm(String tagNm) {
        this.tagNm = tagNm;
    }

    public Integer getTagCnt() {
        return tagCnt;
    }

    public void setTagCnt(Integer tagCnt) {
        this.tagCnt = tagCnt;
    }

    public Integer getDomainCd() {
        return domainCd;
    }

    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }
}
