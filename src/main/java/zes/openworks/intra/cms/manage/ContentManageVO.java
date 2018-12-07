/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms.manage;

import zes.base.vo.PaggingVO;

/**
 * 사용자 컨텐츠 승인/반려 관리 VO
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
 *  2012. 6. 21.    홍길동   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ContentManageVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 8343026823940400185L;

    /** 사이트코드 */
    private Integer domainCd;
    /** 사이트명 */
    private String domainNm;
    /** 메뉴코드 */
    private String menuCode;

    /** 메뉴경로 */
    private String menuPath;
    /** 컨텐츠일련번호 */
//    private Integer contentSeqNo;
    /** 레이아웃코드 */
    private String layoutCode;
    /** HEAD 컨텐츠(<head></head> 태그 사이에 들어갈 css, js 등) */
//    private String headContent;
    /** BODY 컨텐츠(<body></body> 태그 사이에 들어갈 내용) */
//    private String bodyContent;
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


    /******** 이름이 바뀐 컬럼명 추가 table OP_USER_MENU_CONTENTS *****/

    /**  사용자메뉴명  */
    private String userMenuNm;
    
    /**  컨텐츠일련  */
    private Integer cntntsSeq;

    /**  헤드컨텐츠  */
    private String headCntnts;
    /**  바디컨텐츠  */
    private String bodyCntnts;

    /**  등록자아이디  */
    private String registId;
    /**  등록일시  */
    private String registDt;
    /**  수정자아이디  */
    private String updtId;
    /**  수정일시  */
    private String updtDt;

    /**  등록자명   */
    private String registNm;
    /**  수정자명  */
    private String updtNm;
    
    /******** 이름이 바뀐 컬럼명 추가 table OP_USER_MENU_CONTENTS *****/
    
    
    
    
    
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
     * domainNm을 반환
     * 
     * @return String domainNm
     */
    public String getDomainNm() {
        return domainNm;
    }

    /**
     * String domainNm 설정
     * 
     * @param domainNm
     *        설정
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
     * String menuCode 설정
     * 
     * @param menuCode
     *        설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }


    /**
     * menuPath 반환
     * 
     * @return String menuPath
     */
    public String getMenuPath() {
        return menuPath;
    }

    /**
     * String menuPath 설정
     * 
     * @param menuPath
     *        설정
     */
    public void setMenuPath(String menuPath) {
        this.menuPath = menuPath;
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
     * String layoutCode 설정
     * 
     * @param layoutCode
     *        설정
     */
    public void setLayoutCode(String layoutCode) {
        this.layoutCode = layoutCode;
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
     * String applyYn 설정
     * 
     * @param applyYn
     *        설정
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
     * String approvalSt 설정
     * 
     * @param approvalSt
     *        설정
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
     * String approvalId 설정
     * 
     * @param approvalId
     *        설정
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
     * String approvalNm 설정
     * 
     * @param approvalNm
     *        설정
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
     * String approvalDt 설정
     * 
     * @param approvalDt
     *        설정
     */
    public void setApprovalDt(String approvalDt) {
        this.approvalDt = approvalDt;
    }
    
    /**
     * Integer cntntsSeq을 반환
     * @return Integer cntntsSeq
     */
    public Integer getCntntsSeq() {
        return cntntsSeq;
    }

    
    /**
     * cntntsSeq을 설정
     * @param cntntsSeq 을(를) Integer cntntsSeq로 설정
     */
    public void setCntntsSeq(Integer cntntsSeq) {
        this.cntntsSeq = cntntsSeq;
    }

    
    /**
     * String headCntnts을 반환
     * @return String headCntnts
     */
    public String getHeadCntnts() {
        return headCntnts;
    }

    
    /**
     * headCntnts을 설정
     * @param headCntnts 을(를) String headCntnts로 설정
     */
    public void setHeadCntnts(String headCntnts) {
        this.headCntnts = headCntnts;
    }

    
    /**
     * String bodyCntnts을 반환
     * @return String bodyCntnts
     */
    public String getBodyCntnts() {
        return bodyCntnts;
    }

    
    /**
     * bodyCntnts을 설정
     * @param bodyCntnts 을(를) String bodyCntnts로 설정
     */
    public void setBodyCntnts(String bodyCntnts) {
        this.bodyCntnts = bodyCntnts;
    }

    
    /**
     * String registId을 반환
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    
    /**
     * registId을 설정
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    
    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }

    
    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    
    /**
     * String updtId을 반환
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }

    
    /**
     * updtId을 설정
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    
    /**
     * String updtDt을 반환
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }

    
    /**
     * updtDt을 설정
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    
    /**
     * String registNm을 반환
     * @return String registNm
     */
    public String getRegistNm() {
        return registNm;
    }

    
    /**
     * registNm을 설정
     * @param registNm 을(를) String registNm로 설정
     */
    public void setRegistNm(String registNm) {
        this.registNm = registNm;
    }

    
    /**
     * String updtNm을 반환
     * @return String updtNm
     */
    public String getUpdtNm() {
        return updtNm;
    }

    
    /**
     * updtNm을 설정
     * @param updtNm 을(를) String updtNm로 설정
     */
    public void setUpdtNm(String updtNm) {
        this.updtNm = updtNm;
    }

    
    /**
     * String userMenuNm을 반환
     * @return String userMenuNm
     */
    public String getUserMenuNm() {
        return userMenuNm;
    }

    
    /**
     * userMenuNm을 설정
     * @param userMenuNm 을(를) String userMenuNm로 설정
     */
    public void setUserMenuNm(String userMenuNm) {
        this.userMenuNm = userMenuNm;
    }

    
}
