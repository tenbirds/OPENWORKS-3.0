/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.cms;

import java.util.List;

import zes.base.vo.BaseVO;
import zes.base.vo.FileVO;
import zes.openworks.intra.mgr.MgrVO;

/**
 * 메뉴 관리 VO
 * 
 * @author : xanadu
 * @version : 0.1, JDK 1.5 later, 2011. 3. 3.
 * @since : OP 1.0
 */
public class CmsVO extends BaseVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -5305849399507078803L;

    /** 사이트코드 */
    private Integer domainCd;
    private Integer q_domainCd;
    /** 사이트명 */
    private String domainNm;
    /** 포트번호 */
    private Integer portNo;
    /** 메뉴코드 */
    private String menuCode;
    private String q_menuCode;
    /** 메뉴명 */
    private String menuNm;
    /** 최상위 메뉴명 */
    private String topMenuNm;
    /** 최상위 메뉴이미지 */
    private String topMenuImg;
    /** 제목 */
    private String title;
    /** 기본경로(URL 또는 jsp 컨텐츠 저장경로 */
    private String basePath;
    /** 메뉴경로 */
    private String menuPath;
    /** 최상위메뉴코드 */
    private String topMenuCode;
    /** 상위메뉴코드 */
    private String parentMenuCode;
    private String q_parentMenuCode;
    /** 메뉴깊이 */
    private Integer menuDepth;
    /** 최소메뉴깊이 */
    private Integer minMenuDepth;
    /** 최대메뉴깊이 */
    private Integer maxMenuDepth;
    /** 정렬순서 */
    private Integer sortOrder;
    /** 관리자URL */
    private String adminMenuUrl;
    /** 사용자URL */
    private String userMenuUrl;
    /** 사용자서브URL */
    private List<String> subMenuUrl;
    /** 표시여부 */
    private String showYn;
    /** 사용여부 */
    private String useYn;
    /** 통계사용여부 */
    private String statisticsUseYn;
    /** 메뉴유형 */
    private String menuType;
    /** 링크유형 */
    private String linkType;
    /** 컨텐츠유형 */
    private String contentType;
    /** 컨트롤명(적용할 응용프로그램명) */
    private String controlNm;
    /** 컨트롤함수명 */
    private String methodNm;
    /** 관리유형 (컨텐츠 수정시 관리자 승인이 필요지 여부) */
    private String approvalYn;
    /** 담당자표시여부 */
    private String chargerShowYn;
    /** 담당자부서코드 */
    private String chargeDeptCode;
    /** 담당자부서명 */
    private String chargeDeptNm;
    /** 담당자ID */
    private String chargerId;
    /** 담당자명 */
    private String chargerNm;
    /** 권한유형 */
    private String authType;
    /** 권한부서코드 */
    private String authDeptCd;
    /** 권한부서명 */
    private String authDeptNm;
    /** 사용자권한 유형 코드 목록 */
    private List<CmsUserGradeVO> userGradeCd;
    /** 만족도표시여부 */
    private String satisfyShowYn;
    /** SNS사용여부 */
    private String snsUseYn;
    /** 레이아웃유형 */
    private String layoutCode;
    /** 이전레이아웃유형(변경여부에 따라서 하위 메뉴 레이아웃을 재설정) */
    private String preLayoutCode;
    /** 상위메뉴레이아웃사용여부 */
    private String parentLayoutUseYn;
    /** 컨텐츠일련번호 */
    private Integer contentSeqNo;
    /** 상단컨텐츠 */
    private String headContents;
    /** 하단컨텐츠 */
    private String footContents;
    /** 제목이미지 */
    private String titleImg;
    /** 메뉴제목이미지 */
    private String menuTitleImg;
    /** 메뉴ON 이미지 */
    private String menuOnImg;
    /** 메뉴OFF 이미지 */
    private String menuOffImg;
    /** 첨부파일 일련번호 */
    private Integer fileSeqNo;
    /** 자식노드여부 */
    private String leaf;
    /** 등록자ID */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록일 */
    private String regDt;
    /** 수정자ID */
    private String modId;
    /** 수정자명 */
    private String modNm;
    /** 수정일 */
    private String modDt;
    /** 적용여부 */
    private String applyYn;
    /** 담당자 정보 */
    private MgrVO chargerInfo;
    /** 첨부파일목록 */
    private List<FileVO> fileList;

    /** 자식메뉴 목록 */
    private List<CmsVO> childList;
    /** 부모메뉴 정보 */
    private CmsVO parentVo;

    /** 메뉴권한담당자목록 */
    private List<String> authMgrId;
    /** 메뉴권한담당자목록 */
    private List<CmsMgrAuthVO> authMgrIdList;

    /** 컨텐츠 담당자 메뉴 목록 조회용 담당자ID */
    private String mgrId;
    /** 컨텐츠 담당자 메뉴 목록 조회용 담당자부서코드 */
    private String deptCd;
    /** 컨텐츠 평균 */
    private String scoreAvg;
    /** 카테고리 코드 */
    private String categoryCd;

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
     * Integer portNo을 반환
     * 
     * @return Integer portNo
     */
    public Integer getPortNo() {
        return portNo;
    }

    /**
     * portNo을 설정
     * 
     * @param portNo 을(를) Integer portNo로 설정
     */
    public void setPortNo(Integer portNo) {
        this.portNo = portNo;
    }

    /**
     * String menuCode을 반환
     * 
     * @return String menuCode
     */
    public String getMenuCode() {
        return menuCode;
    }

    /**
     * menuCode을 설정
     * 
     * @param menuCode 을(를) String menuCode로 설정
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
     * String topMenuNm을 반환
     * 
     * @return String topMenuNm
     */
    public String getTopMenuNm() {
        return topMenuNm;
    }

    /**
     * topMenuNm을 설정
     * 
     * @param topMenuNm 을(를) String topMenuNm로 설정
     */
    public void setTopMenuNm(String topMenuNm) {
        this.topMenuNm = topMenuNm;
    }

    /**
     * String topMenuImg을 반환
     * 
     * @return String topMenuImg
     */
    public String getTopMenuImg() {
        return topMenuImg;
    }

    /**
     * topMenuImg을 설정
     * 
     * @param topMenuImg 을(를) String topMenuImg로 설정
     */
    public void setTopMenuImg(String topMenuImg) {
        this.topMenuImg = topMenuImg;
    }

    /**
     * String title을 반환
     * 
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    /**
     * title을 설정
     * 
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * String basePath을 반환
     * 
     * @return String basePath
     */
    public String getBasePath() {
        return basePath;
    }

    /**
     * basePath을 설정
     * 
     * @param basePath 을(를) String basePath로 설정
     */
    public void setBasePath(String basePath) {
        this.basePath = basePath;
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
     * String topMenuCode을 반환
     * 
     * @return String topMenuCode
     */
    public String getTopMenuCode() {
        return topMenuCode;
    }

    /**
     * topMenuCode을 설정
     * 
     * @param topMenuCode 을(를) String topMenuCode로 설정
     */
    public void setTopMenuCode(String topMenuCode) {
        this.topMenuCode = topMenuCode;
    }

    /**
     * String parentMenuCode을 반환
     * 
     * @return String parentMenuCode
     */
    public String getParentMenuCode() {
        return parentMenuCode;
    }

    /**
     * parentMenuCode을 설정
     * 
     * @param parentMenuCode 을(를) String parentMenuCode로 설정
     */
    public void setParentMenuCode(String parentMenuCode) {
        this.parentMenuCode = parentMenuCode;
    }

    /**
     * String q_parentMenuCode을 반환
     * 
     * @return String q_parentMenuCode
     */
    public String getQ_parentMenuCode() {
        return q_parentMenuCode;
    }

    /**
     * q_parentMenuCode을 설정
     * 
     * @param q_parentMenuCode 을(를) String q_parentMenuCode로 설정
     */
    public void setQ_parentMenuCode(String q_parentMenuCode) {
        this.q_parentMenuCode = q_parentMenuCode;
    }

    /**
     * Integer menuDepth을 반환
     * 
     * @return Integer menuDepth
     */
    public Integer getMenuDepth() {
        return menuDepth;
    }

    /**
     * menuDepth을 설정
     * 
     * @param menuDepth 을(를) Integer menuDepth로 설정
     */
    public void setMenuDepth(Integer menuDepth) {
        this.menuDepth = menuDepth;
    }

    /**
     * Integer minMenuDepth을 반환
     * 
     * @return Integer minMenuDepth
     */
    public Integer getMinMenuDepth() {
        return minMenuDepth;
    }

    /**
     * minMenuDepth을 설정
     * 
     * @param minMenuDepth 을(를) Integer minMenuDepth로 설정
     */
    public void setMinMenuDepth(Integer minMenuDepth) {
        this.minMenuDepth = minMenuDepth;
    }

    /**
     * Integer maxMenuDepth을 반환
     * 
     * @return Integer maxMenuDepth
     */
    public Integer getMaxMenuDepth() {
        return maxMenuDepth;
    }

    /**
     * maxMenuDepth을 설정
     * 
     * @param maxMenuDepth 을(를) Integer maxMenuDepth로 설정
     */
    public void setMaxMenuDepth(Integer maxMenuDepth) {
        this.maxMenuDepth = maxMenuDepth;
    }

    /**
     * Integer sortOrder을 반환
     * 
     * @return Integer sortOrder
     */
    public Integer getSortOrder() {
        return sortOrder;
    }

    /**
     * sortOrder을 설정
     * 
     * @param sortOrder 을(를) Integer sortOrder로 설정
     */
    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    /**
     * String adminMenuUrl을 반환
     * 
     * @return String adminMenuUrl
     */
    public String getAdminMenuUrl() {
        return adminMenuUrl;
    }

    /**
     * adminMenuUrl을 설정
     * 
     * @param adminMenuUrl 을(를) String adminMenuUrl로 설정
     */
    public void setAdminMenuUrl(String adminMenuUrl) {
        this.adminMenuUrl = adminMenuUrl;
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

    /**
     * List<String> subMenuUrl을 반환
     * 
     * @return List<String> subMenuUrl
     */
    public List<String> getSubMenuUrl() {
        return subMenuUrl;
    }

    /**
     * subMenuUrl을 설정
     * 
     * @param subMenuUrl 을(를) List<String> subMenuUrl로 설정
     */
    public void setSubMenuUrl(List<String> subMenuUrl) {
        this.subMenuUrl = subMenuUrl;
    }

    /**
     * String showYn을 반환
     * 
     * @return String showYn
     */
    public String getShowYn() {
        return showYn;
    }

    /**
     * showYn을 설정
     * 
     * @param showYn 을(를) String showYn로 설정
     */
    public void setShowYn(String showYn) {
        this.showYn = showYn;
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
     * String statisticsUseYn을 반환
     * 
     * @return String statisticsUseYn
     */
    public String getStatisticsUseYn() {
        return statisticsUseYn;
    }

    /**
     * statisticsUseYn을 설정
     * 
     * @param statisticsUseYn 을(를) String statisticsUseYn로 설정
     */
    public void setStatisticsUseYn(String statisticsUseYn) {
        this.statisticsUseYn = statisticsUseYn;
    }

    /**
     * String snsUseYn을 반환
     * 
     * @return String snsUseYn
     */
    public String getSnsUseYn() {
        return snsUseYn;
    }

    /**
     * snsUseYn을 설정
     * 
     * @param snsUseYn 을(를) String snsUseYn로 설정
     */
    public void setSnsUseYn(String snsUseYn) {
        this.snsUseYn = snsUseYn;
    }

    /**
     * String menuType을 반환
     * 
     * @return String menuType
     */
    public String getMenuType() {
        return menuType;
    }

    /**
     * menuType을 설정
     * 
     * @param menuType 을(를) String menuType로 설정
     */
    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }

    /**
     * String linkType을 반환
     * 
     * @return String linkType
     */
    public String getLinkType() {
        return linkType;
    }

    /**
     * linkType을 설정
     * 
     * @param linkType 을(를) String linkType로 설정
     */
    public void setLinkType(String linkType) {
        this.linkType = linkType;
    }

    /**
     * String contentType을 반환
     * 
     * @return String contentType
     */
    public String getContentType() {
        return contentType;
    }

    /**
     * contentType을 설정
     * 
     * @param contentType 을(를) String contentType로 설정
     */
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    /**
     * String controlNm을 반환
     * 
     * @return String controlNm
     */
    public String getControlNm() {
        return controlNm;
    }

    /**
     * controlNm을 설정
     * 
     * @param controlNm 을(를) String controlNm로 설정
     */
    public void setControlNm(String controlNm) {
        this.controlNm = controlNm;
    }

    /**
     * String methodNm을 반환
     * 
     * @return String methodNm
     */
    public String getMethodNm() {
        return methodNm;
    }

    /**
     * methodNm을 설정
     * 
     * @param methodNm 을(를) String methodNm로 설정
     */
    public void setMethodNm(String methodNm) {
        this.methodNm = methodNm;
    }

    /**
     * String approvalYn을 반환
     * 
     * @return String approvalYn
     */
    public String getApprovalYn() {
        return approvalYn;
    }

    /**
     * approvalYn을 설정
     * 
     * @param approvalYn 을(를) String approvalYn로 설정
     */
    public void setApprovalYn(String approvalYn) {
        this.approvalYn = approvalYn;
    }

    /**
     * String chargerShowYn을 반환
     * 
     * @return String chargerShowYn
     */
    public String getChargerShowYn() {
        return chargerShowYn;
    }

    /**
     * chargerShowYn을 설정
     * 
     * @param chargerShowYn 을(를) String chargerShowYn로 설정
     */
    public void setChargerShowYn(String chargerShowYn) {
        this.chargerShowYn = chargerShowYn;
    }

    /**
     * String chargeDeptCode을 반환
     * 
     * @return String chargeDeptCode
     */
    public String getChargeDeptCode() {
        return chargeDeptCode;
    }

    /**
     * chargeDeptCode을 설정
     * 
     * @param chargeDeptCode 을(를) String chargeDeptCode로 설정
     */
    public void setChargeDeptCode(String chargeDeptCode) {
        this.chargeDeptCode = chargeDeptCode;
    }

    /**
     * String chargeDeptNm을 반환
     * 
     * @return String chargeDeptNm
     */
    public String getChargeDeptNm() {
        return chargeDeptNm;
    }

    /**
     * chargeDeptNm을 설정
     * 
     * @param chargeDeptNm 을(를) String chargeDeptNm로 설정
     */
    public void setChargeDeptNm(String chargeDeptNm) {
        this.chargeDeptNm = chargeDeptNm;
    }

    /**
     * String chargerId을 반환
     * 
     * @return String chargerId
     */
    public String getChargerId() {
        return chargerId;
    }

    /**
     * chargerId을 설정
     * 
     * @param chargerId 을(를) String chargerId로 설정
     */
    public void setChargerId(String chargerId) {
        this.chargerId = chargerId;
    }

    /**
     * String chargerNm을 반환
     * 
     * @return String chargerNm
     */
    public String getChargerNm() {
        return chargerNm;
    }

    /**
     * chargerNm을 설정
     * 
     * @param chargerNm 을(를) String chargerNm로 설정
     */
    public void setChargerNm(String chargerNm) {
        this.chargerNm = chargerNm;
    }

    /**
     * String authType을 반환
     * 
     * @return String authType
     */
    public String getAuthType() {
        return authType;
    }

    /**
     * authType을 설정
     * 
     * @param authType 을(를) String authType로 설정
     */
    public void setAuthType(String authType) {
        this.authType = authType;
    }

    /**
     * String authDeptCd을 반환
     * 
     * @return String authDeptCd
     */
    public String getAuthDeptCd() {
        return authDeptCd;
    }

    /**
     * authDeptCd을 설정
     * 
     * @param authDeptCd 을(를) String authDeptCd로 설정
     */
    public void setAuthDeptCd(String authDeptCd) {
        this.authDeptCd = authDeptCd;
    }

    /**
     * String authDeptNm을 반환
     * 
     * @return String authDeptNm
     */
    public String getAuthDeptNm() {
        return authDeptNm;
    }

    /**
     * authDeptNm을 설정
     * 
     * @param authDeptNm 을(를) String authDeptNm로 설정
     */
    public void setAuthDeptNm(String authDeptNm) {
        this.authDeptNm = authDeptNm;
    }

    /**
     * List<CmsUserGradeVO> userGradeCd을 반환
     * 
     * @return List<CmsUserGradeVO> userGradeCd
     */
    public List<CmsUserGradeVO> getUserGradeCd() {
        return userGradeCd;
    }

    /**
     * userGradeCd을 설정
     * 
     * @param userGradeCd 을(를) List<CmsUserGradeVO> userGradeCd로 설정
     */
    public void setUserGradeCd(List<CmsUserGradeVO> userGradeCd) {
        this.userGradeCd = userGradeCd;
    }

    /**
     * String satisfyShowYn을 반환
     * 
     * @return String satisfyShowYn
     */
    public String getSatisfyShowYn() {
        return satisfyShowYn;
    }

    /**
     * satisfyShowYn을 설정
     * 
     * @param satisfyShowYn 을(를) String satisfyShowYn로 설정
     */
    public void setSatisfyShowYn(String satisfyShowYn) {
        this.satisfyShowYn = satisfyShowYn;
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
     * String preLayoutCode을 반환
     * 
     * @return String preLayoutCode
     */
    public String getPreLayoutCode() {
        return preLayoutCode;
    }

    /**
     * preLayoutCode을 설정
     * 
     * @param preLayoutCode 을(를) String preLayoutCode로 설정
     */
    public void setPreLayoutCode(String preLayoutCode) {
        this.preLayoutCode = preLayoutCode;
    }

    /**
     * String parentLayoutUseYn을 반환
     * 
     * @return String parentLayoutUseYn
     */
    public String getParentLayoutUseYn() {
        return parentLayoutUseYn;
    }

    /**
     * parentLayoutUseYn을 설정
     * 
     * @param parentLayoutUseYn 을(를) String parentLayoutUseYn로 설정
     */
    public void setParentLayoutUseYn(String parentLayoutUseYn) {
        this.parentLayoutUseYn = parentLayoutUseYn;
    }

    /**
     * Integer contentSeqNo을 반환
     * 
     * @return Integer contentSeqNo
     */
    public Integer getContentSeqNo() {
        return contentSeqNo;
    }

    /**
     * contentSeqNo을 설정
     * 
     * @param contentSeqNo 을(를) Integer contentSeqNo로 설정
     */
    public void setContentSeqNo(Integer contentSeqNo) {
        this.contentSeqNo = contentSeqNo;
    }

    /**
     * String headContents을 반환
     * 
     * @return String headContents
     */
    public String getHeadContents() {
        return headContents;
    }

    /**
     * headContents을 설정
     * 
     * @param headContents 을(를) String headContents로 설정
     */
    public void setHeadContents(String headContents) {
        this.headContents = headContents;
    }

    /**
     * String footContents을 반환
     * 
     * @return String footContents
     */
    public String getFootContents() {
        return footContents;
    }

    /**
     * footContents을 설정
     * 
     * @param footContents 을(를) String footContents로 설정
     */
    public void setFootContents(String footContents) {
        this.footContents = footContents;
    }

    /**
     * String titleImg을 반환
     * 
     * @return String titleImg
     */
    public String getTitleImg() {
        return titleImg;
    }

    /**
     * titleImg을 설정
     * 
     * @param titleImg 을(를) String titleImg로 설정
     */
    public void setTitleImg(String titleImg) {
        this.titleImg = titleImg;
    }

    /**
     * String menuTitleImg을 반환
     * 
     * @return String menuTitleImg
     */
    public String getMenuTitleImg() {
        return menuTitleImg;
    }

    /**
     * menuTitleImg을 설정
     * 
     * @param menuTitleImg 을(를) String menuTitleImg로 설정
     */
    public void setMenuTitleImg(String menuTitleImg) {
        this.menuTitleImg = menuTitleImg;
    }

    /**
     * String menuOnImg을 반환
     * 
     * @return String menuOnImg
     */
    public String getMenuOnImg() {
        return menuOnImg;
    }

    /**
     * menuOnImg을 설정
     * 
     * @param menuOnImg 을(를) String menuOnImg로 설정
     */
    public void setMenuOnImg(String menuOnImg) {
        this.menuOnImg = menuOnImg;
    }

    /**
     * String menuOffImg을 반환
     * 
     * @return String menuOffImg
     */
    public String getMenuOffImg() {
        return menuOffImg;
    }

    /**
     * menuOffImg을 설정
     * 
     * @param menuOffImg 을(를) String menuOffImg로 설정
     */
    public void setMenuOffImg(String menuOffImg) {
        this.menuOffImg = menuOffImg;
    }

    /**
     * Integer fileSeqNo을 반환
     * 
     * @return Integer fileSeqNo
     */
    public Integer getFileSeqNo() {
        return fileSeqNo;
    }

    /**
     * fileSeqNo을 설정
     * 
     * @param fileSeqNo 을(를) Integer fileSeqNo로 설정
     */
    public void setFileSeqNo(Integer fileSeqNo) {
        this.fileSeqNo = fileSeqNo;
    }

    /**
     * String leaf을 반환
     * 
     * @return String leaf
     */
    public String getLeaf() {
        return leaf;
    }

    /**
     * leaf을 설정
     * 
     * @param leaf 을(를) String leaf로 설정
     */
    public void setLeaf(String leaf) {
        this.leaf = leaf;
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

    /**
     * String applyYn을 반환
     * 
     * @return String applyYn
     */
    public String getApplyYn() {
        return applyYn;
    }

    /**
     * applyYn을 설정
     * 
     * @param applyYn 을(를) String applyYn로 설정
     */
    public void setApplyYn(String applyYn) {
        this.applyYn = applyYn;
    }

    /**
     * MgrVO chargerInfo을 반환
     * 
     * @return MgrVO chargerInfo
     */
    public MgrVO getChargerInfo() {
        return chargerInfo;
    }

    /**
     * chargerInfo을 설정
     * 
     * @param chargerInfo 을(를) MgrVO chargerInfo로 설정
     */
    public void setChargerInfo(MgrVO chargerInfo) {
        this.chargerInfo = chargerInfo;
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
     * List<CmsVO> childList을 반환
     * 
     * @return List<CmsVO> childList
     */
    public List<CmsVO> getChildList() {
        return childList;
    }

    /**
     * childList을 설정
     * 
     * @param childList 을(를) List<CmsVO> childList로 설정
     */
    public void setChildList(List<CmsVO> childList) {
        this.childList = childList;
    }

    /**
     * CmsVO parentVo을 반환
     * 
     * @return CmsVO parentVo
     */
    public CmsVO getParentVo() {
        return parentVo;
    }

    /**
     * parentVo을 설정
     * 
     * @param parentVo 을(를) CmsVO parentVo로 설정
     */
    public void setParentVo(CmsVO parentVo) {
        this.parentVo = parentVo;
    }

    /**
     * List<String> authMgrId을 반환
     * 
     * @return List<String> authMgrId
     */
    public List<String> getAuthMgrId() {
        return authMgrId;
    }

    /**
     * authMgrId을 설정
     * 
     * @param authMgrId 을(를) List<String> authMgrId로 설정
     */
    public void setAuthMgrId(List<String> authMgrId) {
        this.authMgrId = authMgrId;
    }

    /**
     * List<CmsMenuAuthVO> authMgrIdList을 반환
     * 
     * @return List<CmsMenuAuthVO> authMgrIdList
     */
    public List<CmsMgrAuthVO> getAuthMgrIdList() {
        return authMgrIdList;
    }

    /**
     * authMgrIdList을 설정
     * 
     * @param authMgrIdList 을(를) List<CmsMenuAuthVO> authMgrIdList로 설정
     */
    public void setAuthMgrIdList(List<CmsMgrAuthVO> authMgrIdList) {
        this.authMgrIdList = authMgrIdList;
    }

    /**
     * String mgrId을 반환
     * 
     * @return String mgrId
     */
    public String getMgrId() {
        return mgrId;
    }

    /**
     * mgrId을 설정
     * 
     * @param mgrId 을(를) String mgrId로 설정
     */
    public void setMgrId(String mgrId) {
        this.mgrId = mgrId;
    }

    /**
     * String deptCd을 반환
     * 
     * @return String deptCd
     */
    public String getDeptCd() {
        return deptCd;
    }

    /**
     * deptCd을 설정
     * 
     * @param deptCd 을(를) String deptCd로 설정
     */
    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }

    /**
     * String scoreAvg을 반환
     * 
     * @return String scoreAvg
     */
    public String getScoreAvg() {
        return scoreAvg;
    }

    /**
     * scoreAvg을 설정
     * 
     * @param scoreAvg 을(를) String scoreAvg로 설정
     */
    public void setScoreAvg(String scoreAvg) {
        this.scoreAvg = scoreAvg;
    }

    /**
     * String categoryCd을 반환
     * 
     * @return String categoryCd
     */
    public String getCategoryCd() {
        return categoryCd;
    }

    /**
     * categoryCd을 설정
     * 
     * @param categoryCd 을(를) String categoryCd로 설정
     */
    public void setCategoryCd(String categoryCd) {
        this.categoryCd = categoryCd;
    }

}
