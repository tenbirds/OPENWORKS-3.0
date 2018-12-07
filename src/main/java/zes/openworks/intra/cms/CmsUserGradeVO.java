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
 * CMS 메뉴별 회원유형 목록 정보
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 11. 15.
 * @since : OP 1.0
 */
public class CmsUserGradeVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 7974177580024968228L;
    /** 사이트코드 */
    private Integer domainCd;
    /** 메뉴코드 */
    private String menuCode;
    /** 회원등급코드 */
    private String userGradeCd;
    /** 회원등급명 */
    private String userGradeNm;
    /** 회원등급설명 */
    private String userGradeDesc;
    /** 사용여부 */
    private String useYn;
    /** 등록자명 */
    private String regNm;
    /** 등록자아이디 */
    private String regId;
    /** 등록 일시 */
    private String regDt;
    /** 수정자명 */
    private String modNm;
    /** 수정자아이디 */
    private String modId;
    /** 수정 일시 */
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
     * String userGradeCd을 반환
     * 
     * @return String userGradeCd
     */
    public String getUserGradeCd() {
        return userGradeCd;
    }

    /**
     * userGradeCd을 설정
     * 
     * @param userGradeCd 을(를) String userGradeCd로 설정
     */
    public void setUserGradeCd(String userGradeCd) {
        this.userGradeCd = userGradeCd;
    }

    /**
     * String userGradeNm을 반환
     * 
     * @return String userGradeNm
     */
    public String getUserGradeNm() {
        return userGradeNm;
    }

    /**
     * userGradeNm을 설정
     * 
     * @param userGradeNm 을(를) String userGradeNm로 설정
     */
    public void setUserGradeNm(String userGradeNm) {
        this.userGradeNm = userGradeNm;
    }

    /**
     * String userGradeDesc을 반환
     * 
     * @return String userGradeDesc
     */
    public String getUserGradeDesc() {
        return userGradeDesc;
    }

    /**
     * userGradeDesc을 설정
     * 
     * @param userGradeDesc 을(를) String userGradeDesc로 설정
     */
    public void setUserGradeDesc(String userGradeDesc) {
        this.userGradeDesc = userGradeDesc;
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
