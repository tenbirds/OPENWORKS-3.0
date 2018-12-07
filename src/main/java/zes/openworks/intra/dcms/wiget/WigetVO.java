/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.dcms.wiget;

import zes.base.vo.PaggingVO;

/**
 * 컨텐츠 관리 VO 객체
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
 *  2012. 6. 27.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class WigetVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 8343026823940400185L;
    
    /** 사이트코드 */
    private Integer domainCd;
    private Integer q_domainCd;
    
    /** 
     * 위젯 화면 폼 
     **/    
    /** 화면 폼 코드 */
    private String pageFormCd;
    private String q_pageFormCd;
    /** 화면 폼 명 */
    private String pageFormName;
    /** 사용여부 */
    private String useYn;
    /** 샐서아주 */
    private String cellSize;
    /** 폼 사이즈 가로 */
    private String formSizeWidth;
    /** 폼 사이즈 세로 */
    private String formSizeHeight;
    /** 위젯간격 */
    private String wigetGrap;
    /** 등록자ID */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록일시 */
    private String regDt;
    /** 수정자ID */
    private String modId;
    /** 수정자명 */
    private String modNm;
    /** 수정일시 */
    private String modDt;
    
    /** 
     * 화면 폼 위젯 영역 
     */    
    /** 위젯 영역 코드 */
    private String wigetAreaCd;
    /** 위치 가로 */
    private String startX;
    /** 위치 세로 */
    private String startY;
    /** 사이즈 가로 */
    private String sizeWidth;
    /** 사이즈 세로 */
    private String sizeHeight;
    
    private String[] arrSizeWidth;
    private String[] arrSizeHight;
    private String[] arrStartX;
    private String[] arrStartY;
    
    /** 
     * 위젯 관련 
     */    
    /** 위젯 코드 */
    private String wigetCd;
    private String q_wigetCd;
    /** 위젯명 */
    private String wigetName;    
    /** 폼사이즈 가로 */
    private String wigetSizeWidth;
    /** 폼 사이즈 세로 */
    private String wigetSizeHeight;
    /** 위젯 타입 */
    private String wigetType;
    /** 위젯 URL */
    private String wigetUrl;
    /** 위젯 HTML */
    private String wigetHtml;
    /** 게시판코드 */
    private String bbsCd;
    private String bbsNm;
    /** 게시물수 */
    private String bbsViewNum;
    /** 마우스오버라이징 사용여부 */
    private String overRizingUseyn;
    /** 오버라이징 HTML */
    private String overRizingHtml;
    /** 오버라이징 HTML */
    private String overRizingStartX;
    /** 오버라이징 HTML */
    private String overRizingStartY;
    /** 오버라이징 HTML */
    private String overRizingWidth;
    /** 오버라이징 HTML */
    private String overRizingHeight;
    
    /** 
     * 화면 관련 
     */    
    /** 화면 코드 */
    private String pageCd;
    private String q_pageCd;    
    /** 화면명 */
    private String pageName;    
    /** 위젯 일련번호 */
    private String wigetSeq;
    /** 디플로이 타입 */
    private String deployType;
    /** 디플로이 적용 URL */
    private String deployUrl;
    /** 리로딩 타임 */
    private String deployDelay;
    /** 위젯 영역에 들어갈 위젯 정보 */
    private String[] arrPageWiget;
    

    /**
     * @return the domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * @param domainCd the domainCd to set
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * Integer q_domainCd을 반환
     * 
     * @return Integer q_domainCd
     */
    public Integer getQ_domainCd() {
        return q_domainCd;
    }

    /**
     * q_domainCd을 설정
     * 
     * @param q_domainCd 을(를) Integer q_domainCd로 설정
     */
    public void setQ_domainCd(Integer q_domainCd) {
        this.q_domainCd = q_domainCd;
    }   

    /**
     * regId을 반환
     * 
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * regId 설정
     * 
     * @param String
     *        regId을 regId에 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * regNm을 반환
     * 
     * @return String regNm
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * regNm 설정
     * 
     * @param String
     *        regNm을 regNm에 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

    /**
     * regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * regDt 설정
     * 
     * @param String
     *        regDt을 regDt에 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    /**
     * modId을 반환
     * 
     * @return String modId
     */
    public String getModId() {
        return modId;
    }

    /**
     * modId 설정
     * 
     * @param String
     *        modId을 modId에 설정
     */
    public void setModId(String modId) {
        this.modId = modId;
    }

    /**
     * modNm을 반환
     * 
     * @return String modNm
     */
    public String getModNm() {
        return modNm;
    }

    /**
     * modNm 설정
     * 
     * @param String
     *        modNm을 modNm에 설정
     */
    public void setModNm(String modNm) {
        this.modNm = modNm;
    }

    /**
     * modDt을 반환
     * 
     * @return String modDt
     */
    public String getModDt() {
        return modDt;
    }

    /**
     * modDt 설정
     * 
     * @param String
     *        modDt을 modDt에 설정
     */
    public void setModDt(String modDt) {
        this.modDt = modDt;
    }    

    /**
     * String pageFormCd을 반환
     * @return String pageFormCd
     */
    public String getPageFormCd() {
        return pageFormCd;
    }

    /**
     * pageFormCd을 설정
     * @param pageFormCd 을(를) String pageFormCd로 설정
     */
    public void setPageFormCd(String pageFormCd) {
        this.pageFormCd = pageFormCd;
    }

    /**
     * String pageFormName을 반환
     * @return String pageFormName
     */
    public String getPageFormName() {
        return pageFormName;
    }

    /**
     * pageFormName을 설정
     * @param pageFormName 을(를) String pageFormName로 설정
     */
    public void setPageFormName(String pageFormName) {
        this.pageFormName = pageFormName;
    }

    /**
     * String useYn을 반환
     * @return String useYn
     */
    public String getUseYn() {
        return useYn;
    }

    /**
     * useYn을 설정
     * @param useYn 을(를) String useYn로 설정
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * String cellSize을 반환
     * @return String cellSize
     */
    public String getCellSize() {
        return cellSize;
    }

    /**
     * cellSize을 설정
     * @param cellSize 을(를) String cellSize로 설정
     */
    public void setCellSize(String cellSize) {
        this.cellSize = cellSize;
    }

    /**
     * String formSizeWidth을 반환
     * @return String formSizeWidth
     */
    public String getFormSizeWidth() {
        return formSizeWidth;
    }

    /**
     * formSizeWidth을 설정
     * @param formSizeWidth 을(를) String formSizeWidth로 설정
     */
    public void setFormSizeWidth(String formSizeWidth) {
        this.formSizeWidth = formSizeWidth;
    }

    /**
     * String formSizeHeight을 반환
     * @return String formSizeHeight
     */
    public String getFormSizeHeight() {
        return formSizeHeight;
    }

    /**
     * formSizeHeight을 설정
     * @param formSizeHeight 을(를) String formSizeHeight로 설정
     */
    public void setFormSizeHeight(String formSizeHeight) {
        this.formSizeHeight = formSizeHeight;
    }

    /**
     * String wigetAreaCd을 반환
     * @return String wigetAreaCd
     */
    public String getWigetAreaCd() {
        return wigetAreaCd;
    }

    /**
     * wigetAreaCd을 설정
     * @param wigetAreaCd 을(를) String wigetAreaCd로 설정
     */
    public void setWigetAreaCd(String wigetAreaCd) {
        this.wigetAreaCd = wigetAreaCd;
    }

    /**
     * String startX을 반환
     * @return String startX
     */
    public String getStartX() {
        return startX;
    }

    /**
     * startX을 설정
     * @param startX 을(를) String startX로 설정
     */
    public void setStartX(String startX) {
        this.startX = startX;
    }

    /**
     * String startY을 반환
     * @return String startY
     */
    public String getStartY() {
        return startY;
    }

    /**
     * startY을 설정
     * @param startY 을(를) String startY로 설정
     */
    public void setStartY(String startY) {
        this.startY = startY;
    }

    /**
     * String sizeWidth을 반환
     * @return String sizeWidth
     */
    public String getSizeWidth() {
        return sizeWidth;
    }

    /**
     * sizeWidth을 설정
     * @param sizeWidth 을(를) String sizeWidth로 설정
     */
    public void setSizeWidth(String sizeWidth) {
        this.sizeWidth = sizeWidth;
    }

    /**
     * String sizeHeight을 반환
     * @return String sizeHeight
     */
    public String getSizeHeight() {
        return sizeHeight;
    }

    /**
     * sizeHeight을 설정
     * @param sizeHeight 을(를) String sizeHeight로 설정
     */
    public void setSizeHeight(String sizeHeight) {
        this.sizeHeight = sizeHeight;
    }

    /**
     * ArrayList arrSizeWidth을 반환
     * @return ArrayList arrSizeWidth
     */
    public String[] getArrSizeWidth() {
        return arrSizeWidth;
    }

    /**
     * arrSizeWidth을 설정
     * @param arrSizeWidth 을(를) ArrayList arrSizeWidth로 설정
     */
    public void setArrSizeWidth(String[] arrSizeWidth) {
        this.arrSizeWidth = arrSizeWidth;
    }

    /**
     * ArrayList arrSizeHight을 반환
     * @return ArrayList arrSizeHight
     */
    public String[] getArrSizeHight() {
        return arrSizeHight;
    }

    /**
     * arrSizeHight을 설정
     * @param arrSizeHight 을(를) ArrayList arrSizeHight로 설정
     */
    public void setArrSizeHight(String[] arrSizeHight) {
        this.arrSizeHight = arrSizeHight;
    }

    /**
     * ArrayList arrStartX을 반환
     * @return ArrayList arrStartX
     */
    public String[] getArrStartX() {
        return arrStartX;
    }

    /**
     * arrStartX을 설정
     * @param arrStartX 을(를) ArrayList arrStartX로 설정
     */
    public void setArrStartX(String[] arrStartX) {
        this.arrStartX = arrStartX;
    }

    /**
     * ArrayList arrStartY을 반환
     * @return ArrayList arrStartY
     */
    public String[] getArrStartY() {
        return arrStartY;
    }

    /**
     * arrStartY을 설정
     * @param arrStartY 을(를) ArrayList arrStartY로 설정
     */
    public void setArrStartY(String[] arrStartY) {
        this.arrStartY = arrStartY;
    }

    /**
     * String q_pageFormCd을 반환
     * @return String q_pageFormCd
     */
    public String getQ_pageFormCd() {
        return q_pageFormCd;
    }

    /**
     * q_pageFormCd을 설정
     * @param q_pageFormCd 을(를) String q_pageFormCd로 설정
     */
    public void setQ_pageFormCd(String q_pageFormCd) {
        this.q_pageFormCd = q_pageFormCd;
    }

    /**
     * String wigetGrap을 반환
     * @return String wigetGrap
     */
    public String getWigetGrap() {
        return wigetGrap;
    }

    /**
     * wigetGrap을 설정
     * @param wigetGrap 을(를) String wigetGrap로 설정
     */
    public void setWigetGrap(String wigetGrap) {
        this.wigetGrap = wigetGrap;
    }

    /**
     * String wigetCd을 반환
     * @return String wigetCd
     */
    public String getWigetCd() {
        return wigetCd;
    }

    /**
     * wigetCd을 설정
     * @param wigetCd 을(를) String wigetCd로 설정
     */
    public void setWigetCd(String wigetCd) {
        this.wigetCd = wigetCd;
    }

    /**
     * String wigetName을 반환
     * @return String wigetName
     */
    public String getWigetName() {
        return wigetName;
    }

    /**
     * wigetName을 설정
     * @param wigetName 을(를) String wigetName로 설정
     */
    public void setWigetName(String wigetName) {
        this.wigetName = wigetName;
    }

    /**
     * String wigetSizeWidth을 반환
     * @return String wigetSizeWidth
     */
    public String getWigetSizeWidth() {
        return wigetSizeWidth;
    }

    /**
     * wigetSizeWidth을 설정
     * @param wigetSizeWidth 을(를) String wigetSizeWidth로 설정
     */
    public void setWigetSizeWidth(String wigetSizeWidth) {
        this.wigetSizeWidth = wigetSizeWidth;
    }

    /**
     * String wigetSizeHeight을 반환
     * @return String wigetSizeHeight
     */
    public String getWigetSizeHeight() {
        return wigetSizeHeight;
    }

    /**
     * wigetSizeHeight을 설정
     * @param wigetSizeHeight 을(를) String wigetSizeHeight로 설정
     */
    public void setWigetSizeHeight(String wigetSizeHeight) {
        this.wigetSizeHeight = wigetSizeHeight;
    }

    /**
     * String wigetType을 반환
     * @return String wigetType
     */
    public String getWigetType() {
        return wigetType;
    }

    /**
     * wigetType을 설정
     * @param wigetType 을(를) String wigetType로 설정
     */
    public void setWigetType(String wigetType) {
        this.wigetType = wigetType;
    }

    /**
     * String wigetUrl을 반환
     * @return String wigetUrl
     */
    public String getWigetUrl() {
        return wigetUrl;
    }

    /**
     * wigetUrl을 설정
     * @param wigetUrl 을(를) String wigetUrl로 설정
     */
    public void setWigetUrl(String wigetUrl) {
        this.wigetUrl = wigetUrl;
    }

    /**
     * String wigetHtml을 반환
     * @return String wigetHtml
     */
    public String getWigetHtml() {
        return wigetHtml;
    }

    /**
     * wigetHtml을 설정
     * @param wigetHtml 을(를) String wigetHtml로 설정
     */
    public void setWigetHtml(String wigetHtml) {
        this.wigetHtml = wigetHtml;
    }

    /**
     * String bbsCd을 반환
     * @return String bbsCd
     */
    public String getBbsCd() {
        return bbsCd;
    }

    /**
     * bbsCd을 설정
     * @param bbsCd 을(를) String bbsCd로 설정
     */
    public void setBbsCd(String bbsCd) {
        this.bbsCd = bbsCd;
    }

    /**
     * String bbsViewNum을 반환
     * @return String bbsViewNum
     */
    public String getBbsViewNum() {
        return bbsViewNum;
    }

    /**
     * bbsViewNum을 설정
     * @param bbsViewNum 을(를) String bbsViewNum로 설정
     */
    public void setBbsViewNum(String bbsViewNum) {
        this.bbsViewNum = bbsViewNum;
    }

    /**
     * String overRizingUseyn을 반환
     * @return String overRizingUseyn
     */
    public String getOverRizingUseyn() {
        return overRizingUseyn;
    }

    /**
     * overRizingUseyn을 설정
     * @param overRizingUseyn 을(를) String overRizingUseyn로 설정
     */
    public void setOverRizingUseyn(String overRizingUseyn) {
        this.overRizingUseyn = overRizingUseyn;
    }

    /**
     * String overRizingHtml을 반환
     * @return String overRizingHtml
     */
    public String getOverRizingHtml() {
        return overRizingHtml;
    }

    /**
     * overRizingHtml을 설정
     * @param overRizingHtml 을(를) String overRizingHtml로 설정
     */
    public void setOverRizingHtml(String overRizingHtml) {
        this.overRizingHtml = overRizingHtml;
    }

    /**
     * String q_wigetCd을 반환
     * @return String q_wigetCd
     */
    public String getQ_wigetCd() {
        return q_wigetCd;
    }

    /**
     * q_wigetCd을 설정
     * @param q_wigetCd 을(를) String q_wigetCd로 설정
     */
    public void setQ_wigetCd(String q_wigetCd) {
        this.q_wigetCd = q_wigetCd;
    }

    /**
     * String bbsNm을 반환
     * @return String bbsNm
     */
    public String getBbsNm() {
        return bbsNm;
    }

    /**
     * bbsNm을 설정
     * @param bbsNm 을(를) String bbsNm로 설정
     */
    public void setBbsNm(String bbsNm) {
        this.bbsNm = bbsNm;
    }

    /**
     * String overRizingStartX을 반환
     * @return String overRizingStartX
     */
    public String getOverRizingStartX() {
        return overRizingStartX;
    }

    /**
     * overRizingStartX을 설정
     * @param overRizingStartX 을(를) String overRizingStartX로 설정
     */
    public void setOverRizingStartX(String overRizingStartX) {
        this.overRizingStartX = overRizingStartX;
    }

    /**
     * String overRizingStartY을 반환
     * @return String overRizingStartY
     */
    public String getOverRizingStartY() {
        return overRizingStartY;
    }

    /**
     * overRizingStartY을 설정
     * @param overRizingStartY 을(를) String overRizingStartY로 설정
     */
    public void setOverRizingStartY(String overRizingStartY) {
        this.overRizingStartY = overRizingStartY;
    }

    /**
     * String overRizingWidth을 반환
     * @return String overRizingWidth
     */
    public String getOverRizingWidth() {
        return overRizingWidth;
    }

    /**
     * overRizingWidth을 설정
     * @param overRizingWidth 을(를) String overRizingWidth로 설정
     */
    public void setOverRizingWidth(String overRizingWidth) {
        this.overRizingWidth = overRizingWidth;
    }

    /**
     * String overRizingHeight을 반환
     * @return String overRizingHeight
     */
    public String getOverRizingHeight() {
        return overRizingHeight;
    }

    /**
     * overRizingHeight을 설정
     * @param overRizingHeight 을(를) String overRizingHeight로 설정
     */
    public void setOverRizingHeight(String overRizingHeight) {
        this.overRizingHeight = overRizingHeight;
    }

    /**
     * String pageCd을 반환
     * @return String pageCd
     */
    public String getPageCd() {
        return pageCd;
    }

    /**
     * pageCd을 설정
     * @param pageCd 을(를) String pageCd로 설정
     */
    public void setPageCd(String pageCd) {
        this.pageCd = pageCd;
    }

    /**
     * String q_pageCd을 반환
     * @return String q_pageCd
     */
    public String getQ_pageCd() {
        return q_pageCd;
    }

    /**
     * q_pageCd을 설정
     * @param q_pageCd 을(를) String q_pageCd로 설정
     */
    public void setQ_pageCd(String q_pageCd) {
        this.q_pageCd = q_pageCd;
    }

    /**
     * String pageName을 반환
     * @return String pageName
     */
    public String getPageName() {
        return pageName;
    }

    /**
     * pageName을 설정
     * @param pageName 을(를) String pageName로 설정
     */
    public void setPageName(String pageName) {
        this.pageName = pageName;
    }

    /**
     * String wigetSeq을 반환
     * @return String wigetSeq
     */
    public String getWigetSeq() {
        return wigetSeq;
    }

    /**
     * wigetSeq을 설정
     * @param wigetSeq 을(를) String wigetSeq로 설정
     */
    public void setWigetSeq(String wigetSeq) {
        this.wigetSeq = wigetSeq;
    }

    /**
     * String deployType을 반환
     * @return String deployType
     */
    public String getDeployType() {
        return deployType;
    }

    /**
     * deployType을 설정
     * @param deployType 을(를) String deployType로 설정
     */
    public void setDeployType(String deployType) {
        this.deployType = deployType;
    }

    /**
     * String deployUrl을 반환
     * @return String deployUrl
     */
    public String getDeployUrl() {
        return deployUrl;
    }

    /**
     * deployUrl을 설정
     * @param deployUrl 을(를) String deployUrl로 설정
     */
    public void setDeployUrl(String deployUrl) {
        this.deployUrl = deployUrl;
    }

    /**
     * String deployDelay을 반환
     * @return String deployDelay
     */
    public String getDeployDelay() {
        return deployDelay;
    }

    /**
     * deployDelay을 설정
     * @param deployDelay 을(를) String deployDelay로 설정
     */
    public void setDeployDelay(String deployDelay) {
        this.deployDelay = deployDelay;
    }

    /**
     * String[] arrPageWiget을 반환
     * @return String[] arrPageWiget
     */
    public String[] getArrPageWiget() {
        return arrPageWiget;
    }

    /**
     * arrPageWiget을 설정
     * @param arrPageWiget 을(를) String[] arrPageWiget로 설정
     */
    public void setArrPageWiget(String[] arrPageWiget) {
        this.arrPageWiget = arrPageWiget;
    }

}
