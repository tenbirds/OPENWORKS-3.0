/*
 * Copyright (c) 2010 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.domain;

import java.util.List;

import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;

/**
 * 사이트 관리 VO
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
 *  2013. 5 .15     구선모   snsDelYn 변수추가
 *  2012. 6. 18.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class DomainVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -4766266534985367753L;

    /** 사이트코드 */
    @Required
    private Integer domainCd;
    /** 사이트명(FULL) */
    @Required
    @RangeLength(min = 3, max = 50)
    private String domainNm;
    /** 사이트 포트 */
    @Required
    @RangeLength(min = 2, max = 5)
    private Integer portNo;
    /** 컨텍스트 */
    private String contextPath;
    /** 사이트 그룹 */
    private List<DomainGroupVO> domainGroup;
    /** 사이트 그룹 IP */
    private List<String> groupIpAddr;
    /** 사이트 그룹 PORT */
    private List<Integer> groupPortNo;
    /** 사이트 설명 */
    @Required
    @RangeLength(min = 5, max = 50)
    private String domainDesc;
    /** 담당자부서코드 */
    private String chargeDeptCode;
    /** 담당자부서명 */
    private String chargeDeptNm;
    /** 담당자ID */
    private String chargerId;
    /** 담당자명 */
    private String chargerNm;
    /** 사용여부 */
    @Required
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
     * @param domainCd 을(를) Integer domainCd로 설정
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
     * @param domainNm 을(를) String domainNm로 설정
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
     * @param portNo 을(를) Integer portNo로 설정
     */
    public void setPortNo(Integer portNo) {
        this.portNo = portNo;
    }

    /**
     * String contextPath을 반환
     * 
     * @return String contextPath
     */
    public String getContextPath() {
        return contextPath;
    }

    /**
     * contextPath을 설정
     * 
     * @param contextPath 을(를) String contextPath로 설정
     */
    public void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

    /**
     * List<DomainGroupVO> domainGroup을 반환
     * 
     * @return List<DomainGroupVO> domainGroup
     */
    public List<DomainGroupVO> getDomainGroup() {
        return domainGroup;
    }

    /**
     * domainGroup을 설정
     * 
     * @param domainGroup 을(를) List<DomainGroupVO> domainGroup로 설정
     */
    public void setDomainGroup(List<DomainGroupVO> domainGroup) {
        this.domainGroup = domainGroup;
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
     * @param groupIpAddr 을(를) List<String> groupIpAddr로 설정
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
     * @param groupPortNo 을(를) List<Integer> groupPortNo로 설정
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
     * @param domainDesc 을(를) String domainDesc로 설정
     */
    public void setDomainDesc(String domainDesc) {
        this.domainDesc = domainDesc;
    }

    /**
     * String chargeDeptCode을 반환
     * 
     * @return String chargeDeptCode
     */
    public String getChargeDeptCode() {
        return chargeDeptCode;
    }

    /**
     * chargeDeptCode을 설정
     * 
     * @param chargeDeptCode 을(를) String chargeDeptCode로 설정
     */
    public void setChargeDeptCode(String chargeDeptCode) {
        this.chargeDeptCode = chargeDeptCode;
    }

    /**
     * String chargeDeptNm을 반환
     * 
     * @return String chargeDeptNm
     */
    public String getChargeDeptNm() {
        return chargeDeptNm;
    }

    /**
     * chargeDeptNm을 설정
     * 
     * @param chargeDeptNm 을(를) String chargeDeptNm로 설정
     */
    public void setChargeDeptNm(String chargeDeptNm) {
        this.chargeDeptNm = chargeDeptNm;
    }

    /**
     * String chargerId을 반환
     * 
     * @return String chargerId
     */
    public String getChargerId() {
        return chargerId;
    }

    /**
     * chargerId을 설정
     * 
     * @param chargerId 을(를) String chargerId로 설정
     */
    public void setChargerId(String chargerId) {
        this.chargerId = chargerId;
    }

    /**
     * String chargerNm을 반환
     * 
     * @return String chargerNm
     */
    public String getChargerNm() {
        return chargerNm;
    }

    /**
     * chargerNm을 설정
     * 
     * @param chargerNm 을(를) String chargerNm로 설정
     */
    public void setChargerNm(String chargerNm) {
        this.chargerNm = chargerNm;
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
     * @param useYn 을(를) String useYn로 설정
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
     * @param regId 을(를) String regId로 설정
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
     * @param regNm 을(를) String regNm로 설정
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
     * @param regDt 을(를) String regDt로 설정
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
     * @param modId 을(를) String modId로 설정
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
     * @param modNm 을(를) String modNm로 설정
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
     * @param modDt 을(를) String modDt로 설정
     */
    public void setModDt(String modDt) {
        this.modDt = modDt;
    }

}
