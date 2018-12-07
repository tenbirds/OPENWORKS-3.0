/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.poll;

import java.util.List;

import zes.base.vo.PaggingVO;

/**
 * 도메인 관리 VO
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OW 1.0
 */
public class WebPollDomainVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -4766266534985367753L;

    /** 도메인코드 */
    private Integer domainCd;
    /** 도메인명(FULL) */
    private String domainNm;
    /** 도메인 포트 */
    private Integer portNo;
    /** 도메인 그룹 IP */
    private List<String> groupIpAddr;
    /** 도메인 그룹 PORT */
    private List<Integer> groupPortNo;
    /** 도메인 설명 */
    private String domainDesc;
    /** 사용여부 */
    private String useYn;
    /** 등록자아이디 */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록일 */
    private String regDt;
    /** 수정자 아이디 */
    private String modId;
    /** 수정자명 */
    private String modNm;
    /** 수정일시 */
    private String modDt;

    /**
     * Integer domainCd을 반환
     * 
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * domainCd을 설정
     * 
     * @param domainCd
     *        을(를) Integer domainCd로 설정
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
     * Integer portNo을 반환
     * 
     * @return Integer portNo
     */
    public Integer getPortNo() {
        return portNo;
    }

    /**
     * portNo을 설정
     * 
     * @param portNo
     *        을(를) Integer portNo로 설정
     */
    public void setPortNo(Integer portNo) {
        this.portNo = portNo;
    }

    /**
     * List<String> groupIpAddr을 반환
     * 
     * @return List<String> groupIpAddr
     */
    public List<String> getGroupIpAddr() {
        return groupIpAddr;
    }

    /**
     * groupIpAddr을 설정
     * 
     * @param groupIpAddr
     *        을(를) List<String> groupIpAddr로 설정
     */
    public void setGroupIpAddr(List<String> groupIpAddr) {
        this.groupIpAddr = groupIpAddr;
    }

    /**
     * List<Integer> groupPortNo을 반환
     * 
     * @return List<Integer> groupPortNo
     */
    public List<Integer> getGroupPortNo() {
        return groupPortNo;
    }

    /**
     * groupPortNo을 설정
     * 
     * @param groupPortNo
     *        을(를) List<Integer> groupPortNo로 설정
     */
    public void setGroupPortNo(List<Integer> groupPortNo) {
        this.groupPortNo = groupPortNo;
    }

    /**
     * String domainDesc을 반환
     * 
     * @return String domainDesc
     */
    public String getDomainDesc() {
        return domainDesc;
    }

    /**
     * domainDesc을 설정
     * 
     * @param domainDesc
     *        을(를) String domainDesc로 설정
     */
    public void setDomainDesc(String domainDesc) {
        this.domainDesc = domainDesc;
    }

    /**
     * String useYn을 반환
     * 
     * @return String useYn
     */
    public String getUseYn() {
        return useYn;
    }

    /**
     * useYn을 설정
     * 
     * @param useYn
     *        을(를) String useYn로 설정
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * String regId을 반환
     * 
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * regId을 설정
     * 
     * @param regId
     *        을(를) String regId로 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * String regNm을 반환
     * 
     * @return String regNm
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * regNm을 설정
     * 
     * @param regNm
     *        을(를) String regNm로 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

    /**
     * String regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * regDt을 설정
     * 
     * @param regDt
     *        을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    /**
     * String modId을 반환
     * 
     * @return String modId
     */
    public String getModId() {
        return modId;
    }

    /**
     * modId을 설정
     * 
     * @param modId
     *        을(를) String modId로 설정
     */
    public void setModId(String modId) {
        this.modId = modId;
    }

    /**
     * String modNm을 반환
     * 
     * @return String modNm
     */
    public String getModNm() {
        return modNm;
    }

    /**
     * modNm을 설정
     * 
     * @param modNm
     *        을(를) String modNm로 설정
     */
    public void setModNm(String modNm) {
        this.modNm = modNm;
    }

    /**
     * String modDt을 반환
     * 
     * @return String modDt
     */
    public String getModDt() {
        return modDt;
    }

    /**
     * modDt을 설정
     * 
     * @param modDt
     *        을(를) String modDt로 설정
     */
    public void setModDt(String modDt) {
        this.modDt = modDt;
    }

}
