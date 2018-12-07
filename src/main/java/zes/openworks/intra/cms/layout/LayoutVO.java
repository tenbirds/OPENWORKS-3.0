/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.layout;

import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.Alphabetic;
import zes.core.lang.validate.annotation.marker.Range;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;

/**
 * 사이트 관리 VO
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OW 1.0
 */
public class LayoutVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -4766266534985367753L;

    /** 사이트코드 */
    @Required
    @Range(min = 1, max = 4)
    private Integer domainCd;
    /** 사이트명(FULL) */
    private String domainNm;
    /** 레이아웃코드 */
    @Required
    @Alphabetic
    @RangeLength(min = 3, max = 20)
    private String layoutCode;
    /** 레이아웃 설명 */
    @Required
    @RangeLength(min = 6, max = 20)
    private String layoutDesc;
    /** 레이아웃 컨텐츠 */
    @Required
    private String layoutContent;
    /** 레이아웃 파일 경로 */
    private String filePath;
    /** 기본레이아웃 */
    private String baseLayout;
    /** 등록자아이디 */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록일 */
    private String regDt;
    /** 수정자 아이디 */
    private String modId;
    /** 수정자명 */
    private String modNm;
    /** 수정일시 */
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
     * String layoutCode을 반환
     * 
     * @return String layoutCode
     */
    public String getLayoutCode() {
        return layoutCode;
    }

    /**
     * layoutCode을 설정
     * 
     * @param layoutCode 을(를) String layoutCode로 설정
     */
    public void setLayoutCode(String layoutCode) {
        this.layoutCode = layoutCode;
    }

    /**
     * String layoutDesc을 반환
     * 
     * @return String layoutDesc
     */
    public String getLayoutDesc() {
        return layoutDesc;
    }

    /**
     * layoutDesc을 설정
     * 
     * @param layoutDesc 을(를) String layoutDesc로 설정
     */
    public void setLayoutDesc(String layoutDesc) {
        this.layoutDesc = layoutDesc;
    }

    /**
     * String layoutContent을 반환
     * 
     * @return String layoutContent
     */
    public String getLayoutContent() {
        return layoutContent;
    }

    /**
     * layoutContent을 설정
     * 
     * @param layoutContent 을(를) String layoutContent로 설정
     */
    public void setLayoutContent(String layoutContent) {
        this.layoutContent = layoutContent;
    }

    /**
     * String filePath을 반환
     * 
     * @return String filePath
     */
    public String getFilePath() {
        return filePath;
    }

    /**
     * filePath을 설정
     * 
     * @param filePath 을(를) String filePath로 설정
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    /**
     * String baseLayout을 반환
     * 
     * @return String baseLayout
     */
    public String getBaseLayout() {
        return baseLayout;
    }

    /**
     * baseLayout을 설정
     * 
     * @param baseLayout 을(를) String baseLayout로 설정
     */
    public void setBaseLayout(String baseLayout) {
        this.baseLayout = baseLayout;
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
