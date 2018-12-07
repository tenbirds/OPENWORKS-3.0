/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms;

import zes.base.vo.BaseVO;

/**
 * CMS 메뉴별 권한 담당자 목록 정보
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 11. 15.
 * @since : OP 1.0
 */
public class CmsMgrAuthVO extends BaseVO {

    /**  */
    private static final long serialVersionUID = 1L;
    /** 사이트코드 */
    private Integer domainCd;
    /** 메뉴코드 */
    private String menuCode;
    /** 담당자아이디 */
    private String authMgrId;
    /** 담당자명 */
    private String authMgrNm;
    /** 부서코드 */
    private String deptCd;
    /** 부서명 */
    private String deptNm;
    /** 상위부서명 */
    private String highDeptNm;
    /** 등록자아이디 */
    private String regId;
    /** 등록일 */
    private String regDt;

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
     * @param menuCode 을(를) String menuCode로 설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    /**
     * String authMgrId을 반환
     * 
     * @return String authMgrId
     */
    public String getAuthMgrId() {
        return authMgrId;
    }

    /**
     * authMgrId을 설정
     * 
     * @param authMgrId 을(를) String authMgrId로 설정
     */
    public void setAuthMgrId(String authMgrId) {
        this.authMgrId = authMgrId;
    }

    /**
     * String authMgrNm을 반환
     * 
     * @return String authMgrNm
     */
    public String getAuthMgrNm() {
        return authMgrNm;
    }

    /**
     * authMgrNm을 설정
     * 
     * @param authMgrNm 을(를) String authMgrNm로 설정
     */
    public void setAuthMgrNm(String authMgrNm) {
        this.authMgrNm = authMgrNm;
    }

    /**
     * String deptCd을 반환
     * 
     * @return String deptCd
     */
    public String getDeptCd() {
        return deptCd;
    }

    /**
     * deptCd을 설정
     * 
     * @param deptCd 을(를) String deptCd로 설정
     */
    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    /**
     * String deptNm을 반환
     * 
     * @return String deptNm
     */
    public String getDeptNm() {
        return deptNm;
    }

    /**
     * deptNm을 설정
     * 
     * @param deptNm 을(를) String deptNm로 설정
     */
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    /**
     * String highDeptNm을 반환
     * 
     * @return String highDeptNm
     */
    public String getHighDeptNm() {
        return highDeptNm;
    }

    /**
     * highDeptNm을 설정
     * 
     * @param highDeptNm 을(를) String highDeptNm로 설정
     */
    public void setHighDeptNm(String highDeptNm) {
        this.highDeptNm = highDeptNm;
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

}
