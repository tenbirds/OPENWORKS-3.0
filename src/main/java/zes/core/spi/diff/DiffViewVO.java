/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.spi.diff;

import zes.base.vo.BaseVO;
import difflib.DiffRow;
import difflib.DiffRow.Tag;

/**
 * 데이터 가공을 위해 자체 로직을 조금 추가한 VO 클레스를 사용한다.
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
 *  2012. 3. 20.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class DiffViewVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 5524865972082565655L;

    /** 줄 번호 */
    private Integer lineNum;
    /** 결과 유형 */
    private String tag;
    /** 결과 유형 한글명 */
    private String tagName;
    /** 신규 내용 */
    private String newLine;
    /** 이전 내용 */
    private String oldLine;

    /**
     * 결과 유형 한글명을 설정하며 초기화 한다.
     * 
     * @param row
     */
    public DiffViewVO(DiffRow row) {

        String tag = "";// all, add, delete, modify, same
        String tagName = "";

        Tag diffTag = row.getTag();
        switch(diffTag) {
            case INSERT:
                tag = "add";
                tagName = "추가";
                break;
            case CHANGE:
                tag = "modify";
                tagName = "변경";
                break;
            case DELETE:
                tag = "delete";
                tagName = "삭제";
                break;
            default:
                tag = "same";
                tagName = "동일";
                break;
        }
        this.tagName = tagName;
        this.tag = tag;
        this.newLine = row.getNewLine();
        this.oldLine = row.getOldLine();
    }

    /**
     * Integer lineNum을 반환
     * 
     * @return Integer lineNum
     */
    public Integer getLineNum() {
        return lineNum;
    }

    /**
     * lineNum을 설정
     * 
     * @param lineNum 을(를) Integer lineNum로 설정
     */
    public void setLineNum(Integer lineNum) {
        this.lineNum = lineNum;
    }

    /**
     * String tag을 반환
     * 
     * @return String tag
     */
    public String getTag() {
        return tag;
    }

    /**
     * setTag 설명
     * 
     * @param tag
     * @return <code>this</code> 자기 자신
     */
    public DiffViewVO setTag(String tag) {
        this.tag = tag;
        return this;
    }

    /**
     * String tagName을 반환
     * 
     * @return String tagName
     */
    public String getTagName() {
        return tagName;
    }

    /**
     * tagName을 설정
     * 
     * @param tagName 을(를) String tagName로 설정
     * @return <code>this</code> 자기 자신
     */
    public DiffViewVO setTagName(String tagName) {
        this.tagName = tagName;
        return this;
    }

    /**
     * String newLine을 반환
     * 
     * @return String newLine
     */
    public String getNewLine() {
        return newLine;
    }

    /**
     * newLine을 설정
     * 
     * @param newLine 을(를) String newLine로 설정
     * @return <code>this</code> 자기 자신
     */
    public DiffViewVO setNewLine(String newLine) {
        this.newLine = newLine;
        return this;
    }

    /**
     * String oldLine을 반환
     * 
     * @return String oldLine
     */
    public String getOldLine() {
        return oldLine;
    }

    /**
     * oldLine을 설정
     * 
     * @param oldLine 을(를) String oldLine로 설정
     * @return <code>this</code> 자기 자신
     */
    public DiffViewVO setOldLine(String oldLine) {
        this.oldLine = oldLine;
        return this;
    }

}
