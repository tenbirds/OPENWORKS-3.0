/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.component.sns.provider;

import zes.base.vo.BaseVO;

/**
 * SNS 서비스 제공자 연계 정보
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
 *  2013. 8. 14.    방기배       신규
 * </pre>
 * @see
 */
public class ProviderVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -1014554959706910101L;

    /** 서비스아이디 */
    private String serviceId;
    /** 서비스명 */
    private String serviceNm;
    /** 서비스아이콘 */
    private String serviceIcon;
    /** 인증유형 */
    private String oauthType;
    /** 인증토큰주소 */
    private String requestTokenUrl;
    /** 회신주소 */
    private String callbackUrl;
    /** 사용인증주소 */
    private String authorizationUrl;
    /** 사용허가토큰주소 */
    private String accessTokenUrl;
    /** 프로필주소 */
    private String profileUrl;
    /** SNS등록주소 */
    private String updateStatusUrl;
    /** 사용여부 */
    private String useYn;
    /** 등록자아이디 */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록 일시 */
    private String regDt;
    /** 수정자아이디 */
    private String modId;
    /** 수정자명 */
    private String modNm;
    /** 수정 일시 */
    private String modDt;

    /**
     * String serviceId을 반환
     * 
     * @return String serviceId
     */
    public String getServiceId() {
        return serviceId;
    }

    /**
     * serviceId을 설정
     * 
     * @param serviceId 을(를) String serviceId로 설정
     */
    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    /**
     * String serviceNm을 반환
     * 
     * @return String serviceNm
     */
    public String getServiceNm() {
        return serviceNm;
    }

    /**
     * serviceNm을 설정
     * 
     * @param serviceNm 을(를) String serviceNm로 설정
     */
    public void setServiceNm(String serviceNm) {
        this.serviceNm = serviceNm;
    }

    /**
     * String serviceIcon을 반환
     * 
     * @return String serviceIcon
     */
    public String getServiceIcon() {
        return serviceIcon;
    }

    /**
     * serviceIcon을 설정
     * 
     * @param serviceIcon 을(를) String serviceIcon로 설정
     */
    public void setServiceIcon(String serviceIcon) {
        this.serviceIcon = serviceIcon;
    }

    /**
     * String oauthType을 반환
     * 
     * @return String oauthType
     */
    public String getOauthType() {
        return oauthType;
    }

    /**
     * oauthType을 설정
     * 
     * @param oauthType 을(를) String oauthType로 설정
     */
    public void setOauthType(String oauthType) {
        this.oauthType = oauthType;
    }

    /**
     * String requestTokenUrl을 반환
     * 
     * @return String requestTokenUrl
     */
    public String getRequestTokenUrl() {
        return requestTokenUrl;
    }

    /**
     * requestTokenUrl을 설정
     * 
     * @param requestTokenUrl 을(를) String requestTokenUrl로 설정
     */
    public void setRequestTokenUrl(String requestTokenUrl) {
        this.requestTokenUrl = requestTokenUrl;
    }

    /**
     * String callbackUrl을 반환
     * 
     * @return String callbackUrl
     */
    public String getCallbackUrl() {
        return callbackUrl;
    }

    /**
     * callbackUrl을 설정
     * 
     * @param callbackUrl 을(를) String callbackUrl로 설정
     */
    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    /**
     * String authorizationUrl을 반환
     * 
     * @return String authorizationUrl
     */
    public String getAuthorizationUrl() {
        return authorizationUrl;
    }

    /**
     * authorizationUrl을 설정
     * 
     * @param authorizationUrl 을(를) String authorizationUrl로 설정
     */
    public void setAuthorizationUrl(String authorizationUrl) {
        this.authorizationUrl = authorizationUrl;
    }

    /**
     * String accessTokenUrl을 반환
     * 
     * @return String accessTokenUrl
     */
    public String getAccessTokenUrl() {
        return accessTokenUrl;
    }

    /**
     * accessTokenUrl을 설정
     * 
     * @param accessTokenUrl 을(를) String accessTokenUrl로 설정
     */
    public void setAccessTokenUrl(String accessTokenUrl) {
        this.accessTokenUrl = accessTokenUrl;
    }

    /**
     * String profileUrl을 반환
     * 
     * @return String profileUrl
     */
    public String getProfileUrl() {
        return profileUrl;
    }

    /**
     * profileUrl을 설정
     * 
     * @param profileUrl 을(를) String profileUrl로 설정
     */
    public void setProfileUrl(String profileUrl) {
        this.profileUrl = profileUrl;
    }

    /**
     * String updateStatusUrl을 반환
     * 
     * @return String updateStatusUrl
     */
    public String getUpdateStatusUrl() {
        return updateStatusUrl;
    }

    /**
     * updateStatusUrl을 설정
     * 
     * @param updateStatusUrl 을(를) String updateStatusUrl로 설정
     */
    public void setUpdateStatusUrl(String updateStatusUrl) {
        this.updateStatusUrl = updateStatusUrl;
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
