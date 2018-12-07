/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.content;

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
public class ContentVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 8343026823940400185L;

    /** 사이트코드 */
    private Integer domainCd;
    private Integer q_domainCd;
    /** 사이트명 */
    private String domainNm;
    /** 메뉴코드 */
    private String menuCode;
    private String q_menuCode;
    /** 메뉴명 */
    private String menuNm;
    /** 메뉴경로 */
    private String menuPath;
    /** 컨텐츠일련번호 */
    private Integer contentSeqNo;
    private String q_contentSeqNo;
    /** 레이아웃코드 */
    private String layoutCode;
    /** HEAD 컨텐츠(<head></head> 태그 사이에 들어갈 css, js 등) */
    private String headContent;
    /** BODY 컨텐츠(<body></body> 태그 사이에 들어갈 내용) */
    private String bodyContent;
    /** 적용여부 */
    private String applyYn;
    /** 승인상태 */
    private String approvalSt;
    /** 요청사유 */
    private String publishReason;
    /** 승인/반려사유 */
    private String approvalReason;
    /** 승인상태 */
    private String approvalStNm;
    /** 승인자ID */
    private String approvalId;
    /** 승인자명 */
    private String approvalNm;
    /** 승인일시 */
    private String approvalDt;
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

    /** 사용자단 URL 컨텐츠 미리보기 주소용 */
    private String userMenuUrl;

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
     * domainNm을 반환
     * 
     * @return String domainNm
     */
    public String getDomainNm() {
        return domainNm;
    }

    /**
     * domainNm 설정
     * 
     * @param String
     *        domainNm을 domainNm에 설정
     */
    public void setDomainNm(String domainNm) {
        this.domainNm = domainNm;
    }

    /**
     * menuCode을 반환
     * 
     * @return String menuCode
     */
    public String getMenuCode() {
        return menuCode;
    }

    /**
     * menuCode 설정
     * 
     * @param String
     *        menuCode을 menuCode에 설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    /**
     * String q_menuCode을 반환
     * 
     * @return String q_menuCode
     */
    public String getQ_menuCode() {
        return q_menuCode;
    }

    /**
     * q_menuCode을 설정
     * 
     * @param q_menuCode 을(를) String q_menuCode로 설정
     */
    public void setQ_menuCode(String q_menuCode) {
        this.q_menuCode = q_menuCode;
    }

    /**
     * String menuNm을 반환
     * 
     * @return String menuNm
     */
    public String getMenuNm() {
        return menuNm;
    }

    /**
     * menuNm을 설정
     * 
     * @param menuNm 을(를) String menuNm로 설정
     */
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    /**
     * String menuPath을 반환
     * 
     * @return String menuPath
     */
    public String getMenuPath() {
        return menuPath;
    }

    /**
     * menuPath을 설정
     * 
     * @param menuPath 을(를) String menuPath로 설정
     */
    public void setMenuPath(String menuPath) {
        this.menuPath = menuPath;
    }

    /**
     * contentSeqNo을 반환
     * 
     * @return Integer contentSeqNo
     */
    public Integer getContentSeqNo() {
        return contentSeqNo;
    }

    /**
     * contentSeqNo 설정
     * 
     * @param Integer
     *        contentSeqNo을 contentSeqNo에 설정
     */
    public void setContentSeqNo(Integer contentSeqNo) {
        this.contentSeqNo = contentSeqNo;
    }

    /**
     * String q_contentSeqNo을 반환
     * 
     * @return String q_contentSeqNo
     */
    public String getQ_contentSeqNo() {
        return q_contentSeqNo;
    }

    /**
     * q_contentSeqNo을 설정
     * 
     * @param q_contentSeqNo 을(를) String q_contentSeqNo로 설정
     */
    public void setQ_contentSeqNo(String q_contentSeqNo) {
        this.q_contentSeqNo = q_contentSeqNo;
    }

    /**
     * layoutCode을 반환
     * 
     * @return String layoutCode
     */
    public String getLayoutCode() {
        return layoutCode;
    }

    /**
     * layoutCode 설정
     * 
     * @param String
     *        layoutCode을 layoutCode에 설정
     */
    public void setLayoutCode(String layoutCode) {
        this.layoutCode = layoutCode;
    }

    /**
     * String headContent을 반환
     * 
     * @return String headContent
     */
    public String getHeadContent() {
        return headContent;
    }

    /**
     * headContent을 설정
     * 
     * @param headContent
     *        을(를) String headContent로 설정
     */
    public void setHeadContent(String headContent) {
        this.headContent = headContent;
    }

    /**
     * String bodyContent을 반환
     * 
     * @return String bodyContent
     */
    public String getBodyContent() {
        return bodyContent;
    }

    /**
     * bodyContent을 설정
     * 
     * @param bodyContent
     *        을(를) String bodyContent로 설정
     */
    public void setBodyContent(String bodyContent) {
        this.bodyContent = bodyContent;
    }

    /**
     * applyYn을 반환
     * 
     * @return String applyYn
     */
    public String getApplyYn() {
        return applyYn;
    }

    /**
     * applyYn 설정
     * 
     * @param String
     *        applyYn을 applyYn에 설정
     */
    public void setApplyYn(String applyYn) {
        this.applyYn = applyYn;
    }

    /**
     * approvalSt을 반환
     * 
     * @return String approvalSt
     */
    public String getApprovalSt() {
        return approvalSt;
    }

    /**
     * approvalSt 설정
     * 
     * @param String
     *        approvalSt을 approvalSt에 설정
     */
    public void setApprovalSt(String approvalSt) {
        this.approvalSt = approvalSt;
    }

    /**
     * @return the publishReason
     */
    public String getPublishReason() {
        return publishReason;
    }

    /**
     * @param publishReason the publishReason to set
     */
    public void setPublishReason(String publishReason) {
        this.publishReason = publishReason;
    }

    /**
     * String approvalReason을 반환
     * 
     * @return String approvalReason
     */
    public String getApprovalReason() {
        return approvalReason;
    }

    /**
     * approvalReason을 설정
     * 
     * @param approvalReason
     *        을(를) String approvalReason로 설정
     */
    public void setApprovalReason(String approvalReason) {
        this.approvalReason = approvalReason;
    }

    /**
     * approvalStNm을 반환
     * 
     * @return String approvalStNm
     */
    public String getApprovalStNm() {
        return approvalStNm;
    }

    /**
     * String approvalStNm 설정
     * 
     * @param approvalStNm
     *        설정
     */
    public void setApprovalStNm(String approvalStNm) {
        this.approvalStNm = approvalStNm;
    }

    /**
     * approvalId을 반환
     * 
     * @return String approvalId
     */
    public String getApprovalId() {
        return approvalId;
    }

    /**
     * approvalId 설정
     * 
     * @param String
     *        approvalId을 approvalId에 설정
     */
    public void setApprovalId(String approvalId) {
        this.approvalId = approvalId;
    }

    /**
     * approvalNm을 반환
     * 
     * @return String approvalNm
     */
    public String getApprovalNm() {
        return approvalNm;
    }

    /**
     * approvalNm 설정
     * 
     * @param String
     *        approvalNm을 approvalNm에 설정
     */
    public void setApprovalNm(String approvalNm) {
        this.approvalNm = approvalNm;
    }

    /**
     * approvalDt을 반환
     * 
     * @return String approvalDt
     */
    public String getApprovalDt() {
        return approvalDt;
    }

    /**
     * approvalDt 설정
     * 
     * @param String
     *        approvalDt을 approvalDt에 설정
     */
    public void setApprovalDt(String approvalDt) {
        this.approvalDt = approvalDt;
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
     * String userMenuUrl을 반환
     * 
     * @return String userMenuUrl
     */
    public String getUserMenuUrl() {
        return userMenuUrl;
    }

    /**
     * userMenuUrl을 설정
     * 
     * @param userMenuUrl 을(를) String userMenuUrl로 설정
     */
    public void setUserMenuUrl(String userMenuUrl) {
        this.userMenuUrl = userMenuUrl;
    }

}
