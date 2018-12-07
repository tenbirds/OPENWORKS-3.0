/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.banner;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.openworks.intra.popup.PopupVO;

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
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BannerVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 8014843926882533251L;

    /** 배너구분 팝업존 */
    public static final Integer BN_TY_CD_PZ = 1001;
    /** 배너구분 광고 */
    public static final Integer BN_TY_CD_AD = 1002;

    /** 배너일련 */
    private Integer bannerSn;
    /** 배너일련 배열 */
    private String[] bannerSns;
    /** 배너유형코드 */
    private Integer bannerTyCd;
    /** 배너유형이름 */
    private String bannerTyNm;
    /** 배너타이틀 */
    private String bannerTitle;
    /** 시작일자 */
    private String beginDate;
    /** 종료일자 */
    private String endDate;
    /** 시작시점 비교 */
    private String gubun;
    /** 사용가부 */
    private String useYn;
    /** 링크유형코드 */
    private Integer linkTyCd;
    /** 링크URL */
    private String linkUrl;
    /** 이미지ALT */
    private String imageAlt;
    /** 배너설명 */
    private String bannerDc;
    /** 배너파일경로 */
    private String bannerFilePath;
    /** 등록아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 배너위치구분시퀀스 */
    private Integer lcSeSn;
    /** 배너위치구분코드 */
    private Integer bannerLcSeCd;
    /** 이벤트위치구분코드 키배열 */
    private List<BannerVO> bannerLcSeCdList;
    /** 이벤트위치구분코드 키 */
    private String bannerLcSeCds;
    /** 이벤트위치구분이름 */
    private String bannerLcSeNm;
    /** 배너삭제여부 */
    private String bannerDeleteAt;
    /** 도메인일련 */
    private Integer domainSn;
    /** 배너정렬번호 */
    private Integer bannerSortNo;
    /** 도메인코드 */
    private Integer domainCd;
    /** 이미지 삭제 여부 */
    private String flag;
    /** 배너 prvCd */
    private Integer prvCd;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 사이트코드(List) */
    private List<PopupVO> domainCdList;
    /** 사이트명(FULL) */
    private String domainNm;
    /** 사이트 설명 */
    private String domainDc;
    /** 등록된 사이트 코드들 */
    private String domainCds;

    private String checkYn;

    /* 광고의뢰인코드, */
    private Integer advrtsClientCd;
    /* 광고의뢰인명, */
    private String advrtsClientNm;
    /* 배너클릭수 */
    private Integer bannerClickCo;

    /**
     * Integer bannerSn을 반환
     * 
     * @return Integer bannerSn
     */
    public Integer getBannerSn() {
        return bannerSn;
    }

    /**
     * Integer lcSeSn을 반환
     * 
     * @return Integer lcSeSn
     */
    public Integer getLcSeSn() {
        return lcSeSn;
    }

    /**
     * lcSeSn을 설정
     * 
     * @param lcSeSn 을(를) Integer lcSeSn로 설정
     */
    public void setLcSeSn(Integer lcSeSn) {
        this.lcSeSn = lcSeSn;
    }

    /**
     * bannerSn을 설정
     * 
     * @param bannerSn 을(를) Integer bannerSn로 설정
     */
    public void setBannerSn(Integer bannerSn) {
        this.bannerSn = bannerSn;
    }

    /**
     * String[] bannerSns을 반환
     * 
     * @return String[] bannerSns
     */
    public String[] getBannerSns() {
        return bannerSns;
    }

    /**
     * bannerSns을 설정
     * 
     * @param bannerSns 을(를) String[] bannerSns로 설정
     */
    public void setBannerSns(String[] bannerSns) {
        this.bannerSns = bannerSns;
    }

    /**
     * Integer bannerTyCd을 반환
     * 
     * @return Integer bannerTyCd
     */
    public Integer getBannerTyCd() {
        return bannerTyCd;
    }

    /**
     * bannerTyCd을 설정
     * 
     * @param bannerTyCd 을(를) Integer bannerTyCd로 설정
     */
    public void setBannerTyCd(Integer bannerTyCd) {
        this.bannerTyCd = bannerTyCd;
    }

    /**
     * String bannerTyNm을 반환
     * 
     * @return String bannerTyNm
     */
    public String getBannerTyNm() {
        return bannerTyNm;
    }

    /**
     * bannerTyNm을 설정
     * 
     * @param bannerTyNm 을(를) String bannerTyNm로 설정
     */
    public void setBannerTyNm(String bannerTyNm) {
        this.bannerTyNm = bannerTyNm;
    }

    /**
     * String bannerTitle을 반환
     * 
     * @return String bannerTitle
     */
    public String getBannerTitle() {
        return bannerTitle;
    }

    /**
     * bannerTitle을 설정
     * 
     * @param bannerTitle 을(를) String bannerTitle로 설정
     */
    public void setBannerTitle(String bannerTitle) {
        this.bannerTitle = bannerTitle;
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
     * Integer linkTyCd을 반환
     * 
     * @return Integer linkTyCd
     */
    public Integer getLinkTyCd() {
        return linkTyCd;
    }

    /**
     * linkTyCd을 설정
     * 
     * @param linkTyCd 을(를) Integer linkTyCd로 설정
     */
    public void setLinkTyCd(Integer linkTyCd) {
        this.linkTyCd = linkTyCd;
    }

    /**
     * String linkUrl을 반환
     * 
     * @return String linkUrl
     */
    public String getLinkUrl() {
        return linkUrl;
    }

    /**
     * linkUrl을 설정
     * 
     * @param linkUrl 을(를) String linkUrl로 설정
     */
    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    /**
     * String imageAlt을 반환
     * 
     * @return String imageAlt
     */
    public String getImageAlt() {
        return imageAlt;
    }

    /**
     * imageAlt을 설정
     * 
     * @param imageAlt 을(를) String imageAlt로 설정
     */
    public void setImageAlt(String imageAlt) {
        this.imageAlt = imageAlt;
    }

    /**
     * String bannerDc을 반환
     * 
     * @return String bannerDc
     */
    public String getBannerDc() {
        return bannerDc;
    }

    /**
     * bannerDc을 설정
     * 
     * @param bannerDc 을(를) String bannerDc로 설정
     */
    public void setBannerDc(String bannerDc) {
        this.bannerDc = bannerDc;
    }

    /**
     * String bannerFilePath을 반환
     * 
     * @return String bannerFilePath
     */
    public String getBannerFilePath() {
        return bannerFilePath;
    }

    /**
     * bannerFilePath을 설정
     * 
     * @param bannerFilePath 을(를) String bannerFilePath로 설정
     */
    public void setBannerFilePath(String bannerFilePath) {
        this.bannerFilePath = bannerFilePath;
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
     * Integer bannerLcSeCd을 반환
     * 
     * @return Integer bannerLcSeCd
     */
    public Integer getBannerLcSeCd() {
        return bannerLcSeCd;
    }

    /**
     * bannerLcSeCd을 설정
     * 
     * @param bannerLcSeCd 을(를) Integer bannerLcSeCd로 설정
     */
    public void setBannerLcSeCd(Integer bannerLcSeCd) {
        this.bannerLcSeCd = bannerLcSeCd;
    }

    /**
     * List<BannerVO> bannerLcSeCdList을 반환
     * 
     * @return List<BannerVO> bannerLcSeCdList
     */
    public List<BannerVO> getBannerLcSeCdList() {
        return bannerLcSeCdList;
    }

    /**
     * bannerLcSeCdList을 설정
     * 
     * @param bannerLcSeCdList 을(를) List<BannerVO> bannerLcSeCdList로 설정
     */
    public void setBannerLcSeCdList(List<BannerVO> bannerLcSeCdList) {
        this.bannerLcSeCdList = bannerLcSeCdList;
    }

    /**
     * String bannerLcSeCds을 반환
     * 
     * @return String bannerLcSeCds
     */
    public String getBannerLcSeCds() {
        return bannerLcSeCds;
    }

    /**
     * bannerLcSeCds을 설정
     * 
     * @param bannerLcSeCds 을(를) String bannerLcSeCds로 설정
     */
    public void setBannerLcSeCds(String bannerLcSeCds) {
        this.bannerLcSeCds = bannerLcSeCds;
    }

    /**
     * String bannerLcSeNm을 반환
     * 
     * @return String bannerLcSeNm
     */
    public String getBannerLcSeNm() {
        return bannerLcSeNm;
    }

    /**
     * bannerLcSeNm을 설정
     * 
     * @param bannerLcSeNm 을(를) String bannerLcSeNm로 설정
     */
    public void setBannerLcSeNm(String bannerLcSeNm) {
        this.bannerLcSeNm = bannerLcSeNm;
    }

    /**
     * String bannerDeleteAt을 반환
     * 
     * @return String bannerDeleteAt
     */
    public String getBannerDeleteAt() {
        return bannerDeleteAt;
    }

    /**
     * bannerDeleteAt을 설정
     * 
     * @param bannerDeleteAt 을(를) String bannerDeleteAt로 설정
     */
    public void setBannerDeleteAt(String bannerDeleteAt) {
        this.bannerDeleteAt = bannerDeleteAt;
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
     * Integer bannerSortNo을 반환
     * 
     * @return Integer bannerSortNo
     */
    public Integer getBannerSortNo() {
        return bannerSortNo;
    }

    /**
     * bannerSortNo을 설정
     * 
     * @param bannerSortNo 을(를) Integer bannerSortNo로 설정
     */
    public void setBannerSortNo(Integer bannerSortNo) {
        this.bannerSortNo = bannerSortNo;
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
     * String flag을 반환
     * 
     * @return String flag
     */
    public String getFlag() {
        return flag;
    }

    /**
     * flag을 설정
     * 
     * @param flag 을(를) String flag로 설정
     */
    public void setFlag(String flag) {
        this.flag = flag;
    }

    /**
     * Integer prvCd을 반환
     * 
     * @return Integer prvCd
     */
    public Integer getPrvCd() {
        return prvCd;
    }

    /**
     * prvCd을 설정
     * 
     * @param prvCd 을(를) Integer prvCd로 설정
     */
    public void setPrvCd(Integer prvCd) {
        this.prvCd = prvCd;
    }

    /**
     * List<FileVO> fileList을 반환
     * 
     * @return List<FileVO> fileList
     */
    public List<FileVO> getFileList() {
        return fileList;
    }

    /**
     * fileList을 설정
     * 
     * @param fileList 을(를) List<FileVO> fileList로 설정
     */
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
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
     * String domainNm을 반환
     * 
     * @return String domainNm
     */
    public String getDomainNm() {
        return domainNm;
    }

    /**
     * domainNm을 설정
     * 
     * @param domainNm 을(를) String domainNm로 설정
     */
    public void setDomainNm(String domainNm) {
        this.domainNm = domainNm;
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
     * String domainCds을 반환
     * 
     * @return String domainCds
     */
    public String getDomainCds() {
        return domainCds;
    }

    /**
     * domainCds을 설정
     * 
     * @param domainCds 을(를) String domainCds로 설정
     */
    public void setDomainCds(String domainCds) {
        this.domainCds = domainCds;
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
    public Integer getBannerClickCo() {
        return bannerClickCo;
    }

    /**
     * bannerClickCo을 설정
     * 
     * @param bannerClickCo 을(를) Integer bannerClickCo로 설정
     */
    public void setBannerClickCo(Integer bannerClickCo) {
        this.bannerClickCo = bannerClickCo;
    }

    /**
     * String advrtsClientNm을 반환
     * 
     * @return String advrtsClientNm
     */
    public String getAdvrtsClientNm() {
        return advrtsClientNm;
    }

    /**
     * advrtsClientNm을 설정
     * 
     * @param advrtsClientNm 을(를) String advrtsClientNm로 설정
     */
    public void setAdvrtsClientNm(String advrtsClientNm) {
        this.advrtsClientNm = advrtsClientNm;
    }

}
