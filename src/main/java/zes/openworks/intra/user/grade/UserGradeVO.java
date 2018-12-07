/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.user.grade;

import zes.base.vo.BaseVO;
import zes.core.lang.validate.annotation.marker.AlphaNumeric;
import zes.core.lang.validate.annotation.marker.NotNull;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;

/**
 * 회원 등급 정보 VO
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
 *  2012. 6. 18.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserGradeVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -6173096460005781257L;
    /** 회원등급코드 */
    @NotNull
    @Required
    @AlphaNumeric
    @RangeLength(min = 4, max = 20)
    private String userGradCode;
    /** 변경전 회원등급코드 */
    private String prevUserGradCd;
    /** 회원등급명 */
    @NotNull
    @Required
    @RangeLength(min = 5, max = 25)
    private String userGradNm;
    /** 회원등급설명 */
    @RangeLength(min = 5, max = 50)
    private String userGradDc;
    /** 사용여부 */
    @NotNull
    @Required
    private String useYn;
    /** 등록자이름 */
    private String registNm;
    /** 등록자아이디 */
    private String registId;
    /** 등록 일시 */
    private String registDt;
    /** 수정자이름 */
    private String updtNm;
    /** 수정자아이디 */
    private String updtId;
    /** 수정 일시 */
    private String updtDt;

    public String getUserGradCode() {
        return userGradCode;
    }

    public void setUserGradCode(String userGradCode) {
        this.userGradCode = userGradCode;
    }

    public String getPrevUserGradCd() {
        return prevUserGradCd;
    }

    public void setPrevUserGradCd(String prevUserGradCd) {
        this.prevUserGradCd = prevUserGradCd;
    }

    public String getUserGradNm() {
        return userGradNm;
    }

    public void setUserGradNm(String userGradNm) {
        this.userGradNm = userGradNm;
    }

    
    public String getUserGradDc() {
        return userGradDc;
    }

    
    public void setUserGradDc(String userGradDc) {
        this.userGradDc = userGradDc;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getRegistDt() {
        return registDt;
    }

    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    public String getUpdtId() {
        return updtId;
    }

    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getRegistNm() {
        return registNm;
    }

    public void setRegistNm(String registNm) {
        this.registNm = registNm;
    }

    public String getUpdtNm() {
        return updtNm;
    }

    public void setUpdtNm(String updtNm) {
        this.updtNm = updtNm;
    }

}
