/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.core.spi.commons.configuration;

import java.net.URL;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.DefaultConfigurationBuilder;

/**
 * 환경설정 파일 로드
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
 *  2012. 4. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ConfigManager {

    private static String configFile = "config/commons/config.xml";

    /**
     * 환경설정을 로드한다.
     * 환경설정은 xml 파일 사용을 기본으로 하며, 패키지의 폴더에
     * 위치하는 것을 기본으로 한다.
     */
    public static Configuration getConfig() {

        return getConfig(configFile);
    }

    /**
     * 환경설정을 로드한다.
     * 환경설정은 xml 파일 사용을 기본으로 하며, 패키지의 폴더에
     * 위치하는 것을 기본으로 한다.
     */
    public static Configuration getConfig(String config) {

        try {

            URL resource = getDefaultClassLoader().getResource(configFile);

            DefaultConfigurationBuilder builder = new DefaultConfigurationBuilder(resource);

            return builder.getConfiguration(true);

        } catch (ConfigurationException e) {
            throw new RuntimeException(
                "환경설정 경로를 확인하세요. Root cause: " + e);
        }
    }

    /**
     * 현재 스레드의 <code>ClassLoader</code>를 구한다.
     * 오류발생시 현재 클레스의 기본 <code>ClassLoader</code>를 호출하여 반환한다.
     * 
     * @return ClassLoader
     */
    private static ClassLoader getDefaultClassLoader() {
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        if(cl == null) {
            cl = ConfigManager.class.getClassLoader();
        }
        return cl;
    }

}
