/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.openworks.common;

import zes.base.BaseConfig;
import zes.core.spi.commons.configuration.CommonsConfigurationListener;
import zes.core.spi.commons.configuration.Config;

/**
 * <p>
 * BaseConfig 내에 기본 설정을 가지고 있으며 확장이 필요한 경우 본 클레스에 추가 하여 사용하도록 한다.<br /> 
 * 전역 공통설정 파일이므로 개별적인 기능등에 사용되는 설정은 별도로 구현하여야 한다.
 * <p />
 * config/common/global-config.xml 파일 내용 참조
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
 *  2012. 3. 1.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see CommonsConfigurationListener
 * @see Config
 */
public class GlobalConfig extends BaseConfig {
    /** 서비스 모드 (dev: 개발 모드, real: 운영모드) */
    public static final String SERVICE_MODE = Config.getString("global.serviceMode", "real");
    /** 모바일 URL prefix */
    public static final String MOBILE_URL_PREFIX = Config.getString("url.mobileUrlPrefix", "/m/");
    /** 포털 URL prefix */
    public static final String PORTAL_URL_PREFIX = Config.getString("url.portalUrlPrefix", "/pt/");
    /** 커뮤니티 URL prefix */
    public static final String CM_URL_PREFIX = Config.getString("url.cmUrlPrefix", "/cm/");
    
    public static final String CONFIRM_AND_REDIRECT_POPUP = Config.getString("jspView.confirmAndRedirectPopup");

    /* ----------------------------------------------------------- */
    /* --------------------------- NARA KEY --------------------- */
    /* ----------------------------------------------------------- */
    public static final String NARA_SERVICE_KEY = Config.getString("openAPI.serviceKey");
    
    /* ----------------------------------------------------------- */
    /* --------------------------- LANG TYPE --------------------- */
    /* ----------------------------------------------------------- */
    public static final String LANG_KOREAN  =  "korean";
    public static final String LANG_ENGLISH =  "english";
    public static final String LANG_SPANISH =  "spanish";
}