/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.popup;

import java.util.List;

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
 *  2012. 5. 17.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class PopupVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 2002441908273848060L;

    /** 팝업일련 */
    private Integer popupSn;
    /** 팝업일련 배열 */
    private String[] popupSns;
    /** 팝업유형코드 */
    private Integer popupTyCd;
    /** 팝업타이틀 */
    private String popupTitle;
    /** 시작일자 */
    private String beginDate;
    /** 시작시점 비교 */
    private String gubun;
    /** 종료일자 */
    private String endDate;
    /** 가로사이즈 */
    private Integer widthSize;
    /** 세로사이즈 */
    private Integer heightSize;
    /** TOP위치 */
    private Integer topLc;
    /** LEFT위치 */
    private Integer leftLc;
    /** 스크롤가부 */
    private String scrlYn;
    /** 리사이징가부 */
    private String resizingYn;
    /** 쿠키가부 */
    private String cookieYn;
    /** 쿠키일자수 */
    private Integer cookieDeCo;
    /** 작성유형코드 */
    private Integer makeTyCd;
    /** HTML내용 */
    private String cnHtml;
    /** 사용가부 */
    private String useYn;
    /** URL내용 */
    private String cnUrl;
    /** 등록아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 팝업파일경로 */
    private String popupFilePath;
    /** 파일명 */
    private String fileNm;
    /** 팝업삭제여부 */
    private String popupDeleteAt;
    /** 도메인일련 */
    private Integer domainSn;
    /** 도메인코드 */
    private Integer domainCd;
    /** 사이트코드(List) */
    private List<PopupVO> domainCdList;
    /** 도메인설명 */
    private String domainDc;

    private String checkYn;
    /* 광고의뢰인코드, */
    private Integer advrtsClientCd;
    /* 광고의뢰인명, */
    private String advrtsClientNm;
    /* 배너클릭수 */
    private Integer popupClickCo;

    /**
     * Integer popupSn을 반환
     * 
     * @return Integer popupSn
     */
    public Integer getPopupSn() {
        return popupSn;
    }

    /**
     * popupSn을 설정
     * 
     * @param popupSn 을(를) Integer popupSn로 설정
     */
    public void setPopupSn(Integer popupSn) {
        this.popupSn = popupSn;
    }

    /**
     * String[] popupSns을 반환
     * 
     * @return String[] popupSns
     */
    public String[] getPopupSns() {
        return popupSns;
    }

    /**
     * popupSns을 설정
     * 
     * @param popupSns 을(를) String[] popupSns로 설정
     */
    public void setPopupSns(String[] popupSns) {
        this.popupSns = popupSns;
    }

    /**
     * Integer popupTyCd을 반환
     * 
     * @return Integer popupTyCd
     */
    public Integer getPopupTyCd() {
        return popupTyCd;
    }

    /**
     * popupTyCd을 설정
     * 
     * @param popupTyCd 을(를) Integer popupTyCd로 설정
     */
    public void setPopupTyCd(Integer popupTyCd) {
        this.popupTyCd = popupTyCd;
    }

    /**
     * String popupTitle을 반환
     * 
     * @return String popupTitle
     */
    public String getPopupTitle() {
        return popupTitle;
    }

    /**
     * popupTitle을 설정
     * 
     * @param popupTitle 을(를) String popupTitle로 설정
     */
    public void setPopupTitle(String popupTitle) {
        this.popupTitle = popupTitle;
    }

    /**
     * String beginDate을 반환
     * 
     * @return String beginDate
     */
    public String getBeginDate() {
        return beginDate;
    }

    /**
     * beginDate을 설정
     * 
     * @param beginDate 을(를) String beginDate로 설정
     */
    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    /**
     * String gubun을 반환
     * 
     * @return String gubun
     */
    public String getGubun() {
        return gubun;
    }

    /**
     * gubun을 설정
     * 
     * @param gubun 을(를) String gubun로 설정
     */
    public void setGubun(String gubun) {
        this.gubun = gubun;
    }

    /**
     * String endDate을 반환
     * 
     * @return String endDate
     */
    public String getEndDate() {
        return endDate;
    }

    /**
     * endDate을 설정
     * 
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    /**
     * Integer widthSize을 반환
     * 
     * @return Integer widthSize
     */
    public Integer getWidthSize() {
        return widthSize;
    }

    /**
     * widthSize을 설정
     * 
     * @param widthSize 을(를) Integer widthSize로 설정
     */
    public void setWidthSize(Integer widthSize) {
        this.widthSize = widthSize;
    }

    /**
     * Integer heightSize을 반환
     * 
     * @return Integer heightSize
     */
    public Integer getHeightSize() {
        return heightSize;
    }

    /**
     * heightSize을 설정
     * 
     * @param heightSize 을(를) Integer heightSize로 설정
     */
    public void setHeightSize(Integer heightSize) {
        this.heightSize = heightSize;
    }

    /**
     * Integer topLc을 반환
     * 
     * @return Integer topLc
     */
    public Integer getTopLc() {
        return topLc;
    }

    /**
     * topLc을 설정
     * 
     * @param topLc 을(를) Integer topLc로 설정
     */
    public void setTopLc(Integer topLc) {
        this.topLc = topLc;
    }

    /**
     * Integer leftLc을 반환
     * 
     * @return Integer leftLc
     */
    public Integer getLeftLc() {
        return leftLc;
    }

    /**
     * leftLc을 설정
     * 
     * @param leftLc 을(를) Integer leftLc로 설정
     */
    public void setLeftLc(Integer leftLc) {
        this.leftLc = leftLc;
    }

    /**
     * String scrlYn을 반환
     * 
     * @return String scrlYn
     */
    public String getScrlYn() {
        return scrlYn;
    }

    /**
     * scrlYn을 설정
     * 
     * @param scrlYn 을(를) String scrlYn로 설정
     */
    public void setScrlYn(String scrlYn) {
        this.scrlYn = scrlYn;
    }

    /**
     * String resizingYn을 반환
     * 
     * @return String resizingYn
     */
    public String getResizingYn() {
        return resizingYn;
    }

    /**
     * resizingYn을 설정
     * 
     * @param resizingYn 을(를) String resizingYn로 설정
     */
    public void setResizingYn(String resizingYn) {
        this.resizingYn = resizingYn;
    }

    /**
     * String cookieYn을 반환
     * 
     * @return String cookieYn
     */
    public String getCookieYn() {
        return cookieYn;
    }

    /**
     * cookieYn을 설정
     * 
     * @param cookieYn 을(를) String cookieYn로 설정
     */
    public void setCookieYn(String cookieYn) {
        this.cookieYn = cookieYn;
    }

    /**
     * Integer cookieDeCo을 반환
     * 
     * @return Integer cookieDeCo
     */
    public Integer getCookieDeCo() {
        return cookieDeCo;
    }

    /**
     * cookieDeCo을 설정
     * 
     * @param cookieDeCo 을(를) Integer cookieDeCo로 설정
     */
    public void setCookieDeCo(Integer cookieDeCo) {
        this.cookieDeCo = cookieDeCo;
    }

    /**
     * Integer makeTyCd을 반환
     * 
     * @return Integer makeTyCd
     */
    public Integer getMakeTyCd() {
        return makeTyCd;
    }

    /**
     * makeTyCd을 설정
     * 
     * @param makeTyCd 을(를) Integer makeTyCd로 설정
     */
    public void setMakeTyCd(Integer makeTyCd) {
        this.makeTyCd = makeTyCd;
    }

    /**
     * String cnHtml을 반환
     * 
     * @return String cnHtml
     */
    public String getCnHtml() {
        return cnHtml;
    }

    /**
     * cnHtml을 설정
     * 
     * @param cnHtml 을(를) String cnHtml로 설정
     */
    public void setCnHtml(String cnHtml) {
        this.cnHtml = cnHtml;
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
     * String cnUrl을 반환
     * 
     * @return String cnUrl
     */
    public String getCnUrl() {
        return cnUrl;
    }

    /**
     * cnUrl을 설정
     * 
     * @param cnUrl 을(를) String cnUrl로 설정
     */
    public void setCnUrl(String cnUrl) {
        this.cnUrl = cnUrl;
    }

    /**
     * String registId을 반환
     * 
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    /**
     * registId을 설정
     * 
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /**
     * String registDt을 반환
     * 
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }

    /**
     * registDt을 설정
     * 
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    /**
     * String updtId을 반환
     * 
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }

    /**
     * updtId을 설정
     * 
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    /**
     * String updtDt을 반환
     * 
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }

    /**
     * updtDt을 설정
     * 
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    /**
     * String popupFilePath을 반환
     * 
     * @return String popupFilePath
     */
    public String getPopupFilePath() {
        return popupFilePath;
    }

    /**
     * popupFilePath을 설정
     * 
     * @param popupFilePath 을(를) String popupFilePath로 설정
     */
    public void setPopupFilePath(String popupFilePath) {
        this.popupFilePath = popupFilePath;
    }

    /**
     * String fileNm을 반환
     * 
     * @return String fileNm
     */
    public String getFileNm() {
        return fileNm;
    }

    /**
     * fileNm을 설정
     * 
     * @param fileNm 을(를) String fileNm로 설정
     */
    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }

    /**
     * String popupDeleteAt을 반환
     * 
     * @return String popupDeleteAt
     */
    public String getPopupDeleteAt() {
        return popupDeleteAt;
    }

    /**
     * popupDeleteAt을 설정
     * 
     * @param popupDeleteAt 을(를) String popupDeleteAt로 설정
     */
    public void setPopupDeleteAt(String popupDeleteAt) {
        this.popupDeleteAt = popupDeleteAt;
    }

    /**
     * Integer domainSn을 반환
     * 
     * @return Integer domainSn
     */
    public Integer getDomainSn() {
        return domainSn;
    }

    /**
     * domainSn을 설정
     * 
     * @param domainSn 을(를) Integer domainSn로 설정
     */
    public void setDomainSn(Integer domainSn) {
        this.domainSn = domainSn;
    }

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
     * List<PopupVO> domainCdList을 반환
     * 
     * @return List<PopupVO> domainCdList
     */
    public List<PopupVO> getDomainCdList() {
        return domainCdList;
    }

    /**
     * domainCdList을 설정
     * 
     * @param domainCdList 을(를) List<PopupVO> domainCdList로 설정
     */
    public void setDomainCdList(List<PopupVO> domainCdList) {
        this.domainCdList = domainCdList;
    }

    /**
     * String domainDc을 반환
     * 
     * @return String domainDc
     */
    public String getDomainDc() {
        return domainDc;
    }

    /**
     * domainDc을 설정
     * 
     * @param domainDc 을(를) String domainDc로 설정
     */
    public void setDomainDc(String domainDc) {
        this.domainDc = domainDc;
    }

    /**
     * String checkYn을 반환
     * 
     * @return String checkYn
     */
    public String getCheckYn() {
        return checkYn;
    }

    /**
     * checkYn을 설정
     * 
     * @param checkYn 을(를) String checkYn로 설정
     */
    public void setCheckYn(String checkYn) {
        this.checkYn = checkYn;
    }

    /**
     * Integer advrtsClientCd을 반환
     * 
     * @return Integer advrtsClientCd
     */
    public Integer getAdvrtsClientCd() {
        return advrtsClientCd;
    }

    /**
     * advrtsClientCd을 설정
     * 
     * @param advrtsClientCd 을(를) Integer advrtsClientCd로 설정
     */
    public void setAdvrtsClientCd(Integer advrtsClientCd) {
        this.advrtsClientCd = advrtsClientCd;
    }

    /**
     * Integer bannerClickCo을 반환
     * 
     * @return Integer bannerClickCo
     */
    public Integer getPopupClickCo() {
        return popupClickCo;
    }

    /**
     * bannerClickCo을 설정
     * popupClickCo
     * @param popupClickCo 을(를) Integer popupClickCo로 설정
     */
    public void setPopupClickCo(Integer popupClickCo) {
        this.popupClickCo = popupClickCo;
    }

    
    /**
     * String advrtsClientNm을 반환
     * @return String advrtsClientNm
     */
    public String getAdvrtsClientNm() {
        return advrtsClientNm;
    }

    
    /**
     * advrtsClientNm을 설정
     * @param advrtsClientNm 을(를) String advrtsClientNm로 설정
     */
    public void setAdvrtsClientNm(String advrtsClientNm) {
        this.advrtsClientNm = advrtsClientNm;
    }
    

}
