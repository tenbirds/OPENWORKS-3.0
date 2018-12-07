/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.poll;

import zes.base.vo.PaggingVO;

/**
 * <pre>
 * 선택형 항목중 기타의견 내용 BEAN
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 11.
 * @version $Id: WebPollCommentVO.java 2010. 3. 11. yesno $
 */
public class WebPollCommentVO extends PaggingVO {

    private static final long serialVersionUID = -7831649723729397174L;

    /** 도메인코드 */
    private Integer domainCd;
    /** 일련번호 */
    private int seq;
    /** 그룹일련번호 */
    private int groupSeq;
    /** 항목일련번호 */
    private int itemSeq;
    /** 기타의견 일련번호 */
    private int etcSeq;
    /** 기타의견 */
    private String etcComments;
    /** 등록자아이디 */
    private String regId;
    /** 등록일시 */
    private String regTime;

    /**
     * @return Integer domainCd 값을 반환
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * @param domainCd
     *        값으로 Integer domainCd 값을 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * @return int seq 값을 반환
     */
    public int getSeq() {
        return seq;
    }

    /**
     * @param seq
     *        값으로 int seq 값을 설정
     */
    public void setSeq(int seq) {
        this.seq = seq;
    }

    /**
     * @return int groupSeq 값을 반환
     */
    public int getGroupSeq() {
        return groupSeq;
    }

    /**
     * @param groupSeq
     *        값으로 int groupSeq 값을 설정
     */
    public void setGroupSeq(int groupSeq) {
        this.groupSeq = groupSeq;
    }

    /**
     * @return int itemSeq 값을 반환
     */
    public int getItemSeq() {
        return itemSeq;
    }

    /**
     * @param itemSeq
     *        값으로 int itemSeq 값을 설정
     */
    public void setItemSeq(int itemSeq) {
        this.itemSeq = itemSeq;
    }

    /**
     * @return int etcSeq 값을 반환
     */
    public int getEtcSeq() {
        return etcSeq;
    }

    /**
     * @param etcSeq
     *        값으로 int etcSeq 값을 설정
     */
    public void setEtcSeq(int etcSeq) {
        this.etcSeq = etcSeq;
    }

    /**
     * @return String etcComments 값을 반환
     */
    public String getEtcComments() {
        return etcComments;
    }

    /**
     * @param etcComments
     *        값으로 String etcComments 값을 설정
     */
    public void setEtcComments(String etcComments) {
        this.etcComments = etcComments;
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
     * @return String regTime 값을 반환
     */
    public String getRegTime() {
        return regTime;
    }

    /**
     * @param regTime
     *        값으로 String regTime 값을 설정
     */
    public void setRegTime(String regTime) {
        this.regTime = regTime;
    }

}
