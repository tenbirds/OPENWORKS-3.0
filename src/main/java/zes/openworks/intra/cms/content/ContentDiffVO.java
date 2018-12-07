/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.content;

import java.util.List;

import zes.base.vo.BaseVO;

/**
 * 컨텐츠 관리 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 6. 27.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ContentDiffVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 8343026823940400185L;

    /** 사이트코드 */
    private Integer domainCd;
    /** 사이트명 */
    private String domainNm;
    /** 메뉴코드 */
    private String menuCode;
    /** 컨텐츠일련번호 */
    private List<Integer> contentSeqNos;
    /** 비교유형 */
    private Integer diffType;
    /** 비교 줄수 */
    private Integer diffLine;
    /** 좌측 컨텐츠일련번호 */
    private Integer leftContentSeqNo;
    /** 우측 컨텐츠일련번호 */
    private Integer rightContentSeqNo;
    /** 좌측 컨텐츠 정보 */
    private ContentVO leftContent;
    /** 우측 컨텐츠 정보 */
    private ContentVO rightContent;
    /** 우측 컨텐츠 정보 */
    private String diffContent;

    /**
     * @return the domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * @param domainCd the domainCd to set
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * String domainNm을 반환
     * 
     * @return String domainNm
     */
    public String getDomainNm() {
        return domainNm;
    }

    /**
     * domainNm을 설정
     * 
     * @param domainNm
     *        을(를) String domainNm로 설정
     */
    public void setDomainNm(String domainNm) {
        this.domainNm = domainNm;
    }

    /**
     * String menuCode을 반환
     * 
     * @return String menuCode
     */
    public String getMenuCode() {
        return menuCode;
    }

    /**
     * menuCode을 설정
     * 
     * @param menuCode
     *        을(를) String menuCode로 설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    /**
     * List<Integer> contentSeqNos을 반환
     * 
     * @return List<Integer> contentSeqNos
     */
    public List<Integer> getContentSeqNos() {
        return contentSeqNos;
    }

    /**
     * contentSeqNos을 설정
     * 
     * @param contentSeqNos
     *        을(를) List<Integer> contentSeqNos로 설정
     */
    public void setContentSeqNos(List<Integer> contentSeqNos) {
        this.contentSeqNos = contentSeqNos;
    }

    /**
     * Integer diffType을 반환
     * 
     * @return Integer diffType
     */
    public Integer getDiffType() {
        return diffType;
    }

    /**
     * diffType을 설정
     * 
     * @param diffType
     *        을(를) Integer diffType로 설정
     */
    public void setDiffType(Integer diffType) {
        this.diffType = diffType;
    }

    /**
     * Integer diffLine을 반환
     * 
     * @return Integer diffLine
     */
    public Integer getDiffLine() {
        return diffLine;
    }

    /**
     * diffLine을 설정
     * 
     * @param diffLine
     *        을(를) Integer diffLine로 설정
     */
    public void setDiffLine(Integer diffLine) {
        this.diffLine = diffLine;
    }

    /**
     * Integer leftContentSeqNo을 반환
     * 
     * @return Integer leftContentSeqNo
     */
    public Integer getLeftContentSeqNo() {
        return leftContentSeqNo;
    }

    /**
     * leftContentSeqNo을 설정
     * 
     * @param leftContentSeqNo
     *        을(를) Integer leftContentSeqNo로 설정
     */
    public void setLeftContentSeqNo(Integer leftContentSeqNo) {
        this.leftContentSeqNo = leftContentSeqNo;
    }

    /**
     * Integer rightContentSeqNo을 반환
     * 
     * @return Integer rightContentSeqNo
     */
    public Integer getRightContentSeqNo() {
        return rightContentSeqNo;
    }

    /**
     * rightContentSeqNo을 설정
     * 
     * @param rightContentSeqNo
     *        을(를) Integer rightContentSeqNo로 설정
     */
    public void setRightContentSeqNo(Integer rightContentSeqNo) {
        this.rightContentSeqNo = rightContentSeqNo;
    }

    /**
     * ContentVO leftContent을 반환
     * 
     * @return ContentVO leftContent
     */
    public ContentVO getLeftContent() {
        return leftContent;
    }

    /**
     * leftContent을 설정
     * 
     * @param leftContent
     *        을(를) ContentVO leftContent로 설정
     */
    public void setLeftContent(ContentVO leftContent) {
        this.leftContent = leftContent;
    }

    /**
     * ContentVO rightContent을 반환
     * 
     * @return ContentVO rightContent
     */
    public ContentVO getRightContent() {
        return rightContent;
    }

    /**
     * rightContent을 설정
     * 
     * @param rightContent
     *        을(를) ContentVO rightContent로 설정
     */
    public void setRightContent(ContentVO rightContent) {
        this.rightContent = rightContent;
    }

    /**
     * String diffContent을 반환
     * 
     * @return String diffContent
     */
    public String getDiffContent() {
        return diffContent;
    }

    /**
     * diffContent을 설정
     * 
     * @param diffContent
     *        을(를) String diffContent로 설정
     */
    public void setDiffContent(String diffContent) {
        this.diffContent = diffContent;
    }

}
