/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.poll;

import java.util.List;

import zes.base.vo.PaggingVO;

/**
 * <pre>
 * 설문 그룹(설문 항목) BEAN
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 11.
 * @version $Id: PollGroupVO.java 2010. 3. 11. yesno $
 */
public class PollGroupVO extends PaggingVO {

    private static final long serialVersionUID = -1370884484850266111L;

    /** 일련번호 */
    private Integer seq;
    /** 그룹일련번호 */
    private Integer groupSeq;
    /** 부모일련번호(분기형 생성시를 제외하고 그룹일련번호와 동일하게 설정) */
    private Integer parentSeq;
    /** 그룹제목 */
    private String groupTitle;
    /** 항목수 */
    private Integer itemCnt;
    /** 설문유형(I:단답형, R:단일선택형 C:복수선택형) */
    private String type;
    /** 복수항목선택수 */
    private int multiChoiceCnt;
    /** 의견사용여부 */
    private String commentUseYn;
    /** 등록자아이디 */
    private String regId;
    /** 항목일련번호 */
    private Integer itemSeq;
    /** 항목명 */
    private String item;
    /** 항목명들 */
    private List<String> items;
    /** 기타의견 여부 */
    private String etcYn;
    /** 총선택수(항목별로 선택 합계를 저장) */
    private Integer choiceCnt;

    /** 엑션정보(ADD : 항목추가, DEL : 항목삭제 */
    private String addOrDel;

    /**
     * @return Integer seq 값을 반환
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * @param seq
     *        값으로 Integer seq 값을 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * @return Integer parentSeq 값을 반환
     */
    public Integer getParentSeq() {
        return parentSeq;
    }

    /**
     * @param parentSeq
     *        값으로 Integer parentSeq 값을 설정
     */
    public void setParentSeq(Integer parentSeq) {
        this.parentSeq = parentSeq;
    }

    /**
     * @return Integer groupSeq 값을 반환
     */
    public Integer getGroupSeq() {
        return groupSeq;
    }

    /**
     * @param groupSeq
     *        값으로 Integer groupSeq 값을 설정
     */
    public void setGroupSeq(Integer groupSeq) {
        this.groupSeq = groupSeq;
    }

    /**
     * @return String groupTitle 값을 반환
     */
    public String getGroupTitle() {
        return groupTitle;
    }

    /**
     * @param groupTitle
     *        값으로 String groupTitle 값을 설정
     */
    public void setGroupTitle(String groupTitle) {
        this.groupTitle = groupTitle;
    }

    /**
     * @return Integer itemCnt 값을 반환
     */
    public Integer getItemCnt() {
        return itemCnt;
    }

    /**
     * @param itemCnt
     *        값으로 Integer itemCnt 값을 설정
     */
    public void setItemCnt(Integer itemCnt) {
        this.itemCnt = itemCnt;
    }

    /**
     * @return String type 값을 반환
     */
    public String getType() {
        return type;
    }

    /**
     * @param type
     *        값으로 String type 값을 설정
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return Integer multiChoiceCnt 값을 반환
     */
    public Integer getMultiChoiceCnt() {
        return multiChoiceCnt;
    }

    /**
     * @param multiChoiceCnt
     *        값으로 Integer multiChoiceCnt 값을 설정
     */
    public void setMultiChoiceCnt(Integer multiChoiceCnt) {
        this.multiChoiceCnt = multiChoiceCnt;
    }

    /**
     * @return String commentUseYn 값을 반환
     */
    public String getCommentUseYn() {
        return commentUseYn;
    }

    /**
     * @param commentUseYn
     *        값으로 String commentUseYn 값을 설정
     */
    public void setCommentUseYn(String commentUseYn) {
        this.commentUseYn = commentUseYn;
    }

    /**
     * @return String regId 값을 반환
     */
    public String getRegId() {
        return regId;
    }

    /**
     * @param regId
     *        값으로 String regId 값을 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * @return Integer itemSeq 값을 반환
     */
    public Integer getItemSeq() {
        return itemSeq;
    }

    /**
     * @param itemSeq
     *        값으로 Integer itemSeq 값을 설정
     */
    public void setItemSeq(Integer itemSeq) {
        this.itemSeq = itemSeq;
    }

    /**
     * @return List item 값을 반환
     */
    public String getItem() {
        return item;
    }

    /**
     * @return List<String> items 값을 반환
     */
    public List<String> getItems() {
        return items;
    }

    /**
     * @param items
     *        값으로 List<String> items 값을 설정
     */
    public void setItems(List<String> items) {
        this.items = items;
    }

    /**
     * @param item
     *        값으로 String item 값을 설정
     */
    public void setItem(String item) {
        this.item = item;
    }

    /**
     * @return Integer choiceCnt 값을 반환
     */
    public Integer getChoiceCnt() {
        return choiceCnt;
    }

    /**
     * @param choiceCnt
     *        값으로 Integer choiceCnt 값을 설정
     */
    public void setChoiceCnt(Integer choiceCnt) {
        this.choiceCnt = choiceCnt;
    }

    /**
     * @return String etcYn 값을 반환
     */
    public String getEtcYn() {
        return etcYn;
    }

    /**
     * @param etcYn
     *        값으로 String etcYn 값을 설정
     */
    public void setEtcYn(String etcYn) {
        this.etcYn = etcYn;
    }

    /**
     * @return String addOrDel 값을 반환
     */
    public String getAddOrDel() {
        return addOrDel;
    }

    /**
     * @param addOrDel
     *        값으로 String addOrDel 값을 설정
     */
    public void setAddOrDel(String addOrDel) {
        this.addOrDel = addOrDel;
    }

}
