/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2018. 03.      이홍석       신규
 * </pre>
 * @see
 */
public class SuplerCeartPaas2VO extends PaggingVO {

    private static final long serialVersionUID = 1L;

    private String notifyNum;       /** 공고번호 */    
    private int notifySeq;          /** 공고순번 */    
    private String endsUserId;      /** 수요자아이디 */    
    private String suplerId;        /** 공급자아이디 */    
    private String consumerYn;      /** 수요자여부 */    
    private String applyGbn;        /** 답변여부 */
    
/////////////////////////////////////////////////////    
    
    private String hostingMethod;   /** 호스팅방식 */
    private String hostingMethodNm; /** 호스팅방식Nm */
    private String scaling;         /** 스케일링 */
    private String scalingNm;       /** 스케일링Nm */
    private String platform;        /** 플랫폼 */
    private String platformNm;      /** 플랫폼Nm */
    private String runtimes;        /** 런타임 */
    private String runtimesNm;      /** 런타임Nm */
    private String middlewares;     /** 미들웨어 */
    private String middlewaresNm;   /** 미들웨어Nm */
    private String frameworks;      /** 프레임웍 */
    private String frameworksNm;    /** 프레임웍Nm */
    private String services;        /** 서비스 */
    private String servicesNm;      /** 서비스Nm */
    private String addons;          /** 애드온 */
    private String addonsNm;        /** 애드온Nm */
    private String extendFunction;  /** 확장기능여부 */
    private String geolocations;    /** 위치 */    
    private String geolocationsNm;  /** 위치Nm */
    
    /**
     * String notifyNum을 반환
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }

    
    /**
     * notifyNum을 설정
     * @param notifyNum 을(를) String notifyNum로 설정
     */
    public void setNotifyNum(String notifyNum) {
        this.notifyNum = notifyNum;
    }

    
    /**
     * int notifySeq을 반환
     * @return int notifySeq
     */
    public int getNotifySeq() {
        return notifySeq;
    }

    
    /**
     * notifySeq을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
    }

    
    /**
     * String endsUserId을 반환
     * @return String endsUserId
     */
    public String getEndsUserId() {
        return endsUserId;
    }

    
    /**
     * endsUserId을 설정
     * @param endsUserId 을(를) String endsUserId로 설정
     */
    public void setEndsUserId(String endsUserId) {
        this.endsUserId = endsUserId;
    }

    
    /**
     * String suplerId을 반환
     * @return String suplerId
     */
    public String getSuplerId() {
        return suplerId;
    }

    
    /**
     * suplerId을 설정
     * @param suplerId 을(를) String suplerId로 설정
     */
    public void setSuplerId(String suplerId) {
        this.suplerId = suplerId;
    }

    
    /**
     * String consumerYn을 반환
     * @return String consumerYn
     */
    public String getConsumerYn() {
        return consumerYn;
    }

    
    /**
     * consumerYn을 설정
     * @param consumerYn 을(를) String consumerYn로 설정
     */
    public void setConsumerYn(String consumerYn) {
        this.consumerYn = consumerYn;
    }

    
    /**
     * String applyGbn을 반환
     * @return String applyGbn
     */
    public String getApplyGbn() {
        return applyGbn;
    }

    
    /**
     * applyGbn을 설정
     * @param applyGbn 을(를) String applyGbn로 설정
     */
    public void setApplyGbn(String applyGbn) {
        this.applyGbn = applyGbn;
    }


    
    /**
     * String hostingMethod을 반환
     * @return String hostingMethod
     */
    public String getHostingMethod() {
        return hostingMethod;
    }


    
    /**
     * hostingMethod을 설정
     * @param hostingMethod 을(를) String hostingMethod로 설정
     */
    public void setHostingMethod(String hostingMethod) {
        this.hostingMethod = hostingMethod;
    }


    
    /**
     * String hostingMethodNm을 반환
     * @return String hostingMethodNm
     */
    public String getHostingMethodNm() {
        return hostingMethodNm;
    }


    
    /**
     * hostingMethodNm을 설정
     * @param hostingMethodNm 을(를) String hostingMethodNm로 설정
     */
    public void setHostingMethodNm(String hostingMethodNm) {
        this.hostingMethodNm = hostingMethodNm;
    }


    
    /**
     * String scaling을 반환
     * @return String scaling
     */
    public String getScaling() {
        return scaling;
    }


    
    /**
     * scaling을 설정
     * @param scaling 을(를) String scaling로 설정
     */
    public void setScaling(String scaling) {
        this.scaling = scaling;
    }


    
    /**
     * String scalingNm을 반환
     * @return String scalingNm
     */
    public String getScalingNm() {
        return scalingNm;
    }


    
    /**
     * scalingNm을 설정
     * @param scalingNm 을(를) String scalingNm로 설정
     */
    public void setScalingNm(String scalingNm) {
        this.scalingNm = scalingNm;
    }


    
    /**
     * String platform을 반환
     * @return String platform
     */
    public String getPlatform() {
        return platform;
    }


    
    /**
     * platform을 설정
     * @param platform 을(를) String platform로 설정
     */
    public void setPlatform(String platform) {
        this.platform = platform;
    }


    
    /**
     * String platformNm을 반환
     * @return String platformNm
     */
    public String getPlatformNm() {
        return platformNm;
    }


    
    /**
     * platformNm을 설정
     * @param platformNm 을(를) String platformNm로 설정
     */
    public void setPlatformNm(String platformNm) {
        this.platformNm = platformNm;
    }


    
    /**
     * String runtimes을 반환
     * @return String runtimes
     */
    public String getRuntimes() {
        return runtimes;
    }


    
    /**
     * runtimes을 설정
     * @param runtimes 을(를) String runtimes로 설정
     */
    public void setRuntimes(String runtimes) {
        this.runtimes = runtimes;
    }


    
    /**
     * String runtimesNm을 반환
     * @return String runtimesNm
     */
    public String getRuntimesNm() {
        return runtimesNm;
    }


    
    /**
     * runtimesNm을 설정
     * @param runtimesNm 을(를) String runtimesNm로 설정
     */
    public void setRuntimesNm(String runtimesNm) {
        this.runtimesNm = runtimesNm;
    }


    
    /**
     * String middlewares을 반환
     * @return String middlewares
     */
    public String getMiddlewares() {
        return middlewares;
    }


    
    /**
     * middlewares을 설정
     * @param middlewares 을(를) String middlewares로 설정
     */
    public void setMiddlewares(String middlewares) {
        this.middlewares = middlewares;
    }


    
    /**
     * String middlewaresNm을 반환
     * @return String middlewaresNm
     */
    public String getMiddlewaresNm() {
        return middlewaresNm;
    }


    
    /**
     * middlewaresNm을 설정
     * @param middlewaresNm 을(를) String middlewaresNm로 설정
     */
    public void setMiddlewaresNm(String middlewaresNm) {
        this.middlewaresNm = middlewaresNm;
    }


    
    /**
     * String frameworks을 반환
     * @return String frameworks
     */
    public String getFrameworks() {
        return frameworks;
    }


    
    /**
     * frameworks을 설정
     * @param frameworks 을(를) String frameworks로 설정
     */
    public void setFrameworks(String frameworks) {
        this.frameworks = frameworks;
    }


    
    /**
     * String frameworksNm을 반환
     * @return String frameworksNm
     */
    public String getFrameworksNm() {
        return frameworksNm;
    }


    
    /**
     * frameworksNm을 설정
     * @param frameworksNm 을(를) String frameworksNm로 설정
     */
    public void setFrameworksNm(String frameworksNm) {
        this.frameworksNm = frameworksNm;
    }


    
    /**
     * String services을 반환
     * @return String services
     */
    public String getServices() {
        return services;
    }


    
    /**
     * services을 설정
     * @param services 을(를) String services로 설정
     */
    public void setServices(String services) {
        this.services = services;
    }


    
    /**
     * String servicesNm을 반환
     * @return String servicesNm
     */
    public String getServicesNm() {
        return servicesNm;
    }


    
    /**
     * servicesNm을 설정
     * @param servicesNm 을(를) String servicesNm로 설정
     */
    public void setServicesNm(String servicesNm) {
        this.servicesNm = servicesNm;
    }


    
    /**
     * String addons을 반환
     * @return String addons
     */
    public String getAddons() {
        return addons;
    }


    
    /**
     * addons을 설정
     * @param addons 을(를) String addons로 설정
     */
    public void setAddons(String addons) {
        this.addons = addons;
    }


    
    /**
     * String addonsNm을 반환
     * @return String addonsNm
     */
    public String getAddonsNm() {
        return addonsNm;
    }


    
    /**
     * addonsNm을 설정
     * @param addonsNm 을(를) String addonsNm로 설정
     */
    public void setAddonsNm(String addonsNm) {
        this.addonsNm = addonsNm;
    }


    
    /**
     * String extendFunction을 반환
     * @return String extendFunction
     */
    public String getextendFunction() {
        return extendFunction;
    }


    
    /**
     * extendFunction을 설정
     * @param extendFunction 을(를) String extendFunction로 설정
     */
    public void setextendFunction(String extendFunction) {
        this.extendFunction = extendFunction;
    }


    
    /**
     * String geolocations을 반환
     * @return String geolocations
     */
    public String getGeolocations() {
        return geolocations;
    }


    
    /**
     * geolocations을 설정
     * @param geolocations 을(를) String geolocations로 설정
     */
    public void setGeolocations(String geolocations) {
        this.geolocations = geolocations;
    }


    
    /**
     * String geolocationsNm을 반환
     * @return String geolocationsNm
     */
    public String getGeolocationsNm() {
        return geolocationsNm;
    }


    
    /**
     * geolocationsNm을 설정
     * @param geolocationsNm 을(를) String geolocationsNm로 설정
     */
    public void setGeolocationsNm(String geolocationsNm) {
        this.geolocationsNm = geolocationsNm;
    }

    
}
