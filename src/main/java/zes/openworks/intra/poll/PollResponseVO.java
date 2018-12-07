/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.poll;

import zes.base.vo.PaggingVO;

/**
 * <pre>
 * 설문별 설문 참여 정보 BEAN
 * </pre>
 * 
 * @author yesno
 * @since 2010. 3. 11.
 * @version $Id: PollResponseVO.java 2010. 3. 11. yesno $
 */
public class PollResponseVO extends PaggingVO {

    private static final long serialVersionUID = -6163324745440815206L;

    /** 설문일련번호 */
    private int seq;
    /** 등록자 유형(U:회원, R:실명인증 or I-PIN, A:익명) */
    private String registerType;
    /** 등록자아이디 */
    private String regId;
    /** 등록자이름 */
    private String regNm;
    /** 등록일 */
    private String regTime;
    /** 등록자 IP */
    private String ipAddr;

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
     * @return String registerType 값을 반환
     */
    public String getRegisterType() {
        return registerType;
    }

    /**
     * @param registerType
     *        값으로 String registerType 값을 설정
     */
    public void setRegisterType(String registerType) {
        this.registerType = registerType;
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
     * @return String regNm 값을 반환
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * @param regNm
     *        값으로 String regNm 값을 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
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

    /**
     * @return String ipAddr 값을 반환
     */
    public String getIpAddr() {
        return ipAddr;
    }

    /**
     * @param ipAddr
     *        값으로 String ipAddr 값을 설정
     */
    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }

}
