/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.bid;

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
public class BidPaas2InfoVO extends PaggingVO {

    private static final long serialVersionUID = 1L;

    private String notifyNum;        /** 공고번호 */   
    private int notifySeq;           /** 공고차수 */   
    private String userId;           /** 수요자ID */    
    private String applyGbn;         /** 답변여부 */
    
/////////////////////////////////////////////////////    
    
    private String hostingMethod;     /** 호스팅방식 */    
    private String scaling;           /** 스케일링 */   
    private String platform;          /** 플랫폼 */   
    private String runtimes;          /** 런타임 */   
    private String middlewares;       /** 미들웨어 */    
    private String frameworks;        /** 프레임워크 */
    private String services;          /** 서비스 */
    private String addons;            /** 애드온 */
    private String extendFunction;    /** 확장기능여부 */
    private String geolocations;      /** 위치 */
    
    
    
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
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    
    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
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
     * String extendFunction을 반환
     * @return String extendFunction
     */
    public String getExtendFunction() {
        return extendFunction;
    }


    
    /**
     * extendFunction을 설정
     * @param extendFunction 을(를) String extendFunction로 설정
     */
    public void setExtendFunction(String extendFunction) {
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

    }
