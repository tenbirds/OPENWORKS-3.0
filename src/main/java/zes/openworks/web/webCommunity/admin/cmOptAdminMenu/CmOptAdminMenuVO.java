/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptAdminMenu;

import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 11. 3.    		 boseok       	신규
 *</pre>
 * @see
 */
public class CmOptAdminMenuVO extends PaggingVO {
    
    /**  */
    private static final long serialVersionUID = 1L;
    
    /**  언어코드  */
    private String langCode;
    
    
    /**  도메인코드  */
    private Integer domainCd;
    /**  메뉴코드  */
    private String menuCode;
    /**  사용자메뉴명  */
    private String userMenuNm;
    /**  메뉴타이틀  */
    private String menuTitle;
    /**  기본경로  */
    private String basePath;
    /**  메뉴경로  */
    private String menuPath;
    /**  최고메뉴코드  */
    private String topMenuCode;
    /**  부모메뉴코드  */
    private String parntsMenuCode;
    /**  메뉴깊이  */
    private Integer menuDp;
    /**  정렬순서  */
    private Integer sortOrdr;
    /**  사용자메뉴URL  */
    private String userMenuUrl;
    /**  레이아웃코드  */
    private String layoutCode;
    /**  부모레이아웃사용가부  */
    private String parntsLayoutUseYn;
    /**  메뉴유형  */
    private String menuTy;
    /**  링크유형  */
    private String linkTy;
    /**  승인가부  */
    private String approvalYn;
    /**  통계사용가부  */
    private String statisticsUseYn;
    /**  담당자표시가부  */
    private String chargerShowYn;
    /**  표시가부  */
    private String showYn;
    /**  사용가부  */
    private String useYn;
    
    /**
     * Integer domainCd을 반환
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }
    
    /**
     * domainCd을 설정
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }
    
    /**
     * String menuCode을 반환
     * @return String menuCode
     */
    public String getMenuCode() {
        return menuCode;
    }
    
    /**
     * menuCode을 설정
     * @param menuCode 을(를) String menuCode로 설정
     */
    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
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
    
    /**
     * String menuTitle을 반환
     * @return String menuTitle
     */
    public String getMenuTitle() {
        return menuTitle;
    }
    
    /**
     * menuTitle을 설정
     * @param menuTitle 을(를) String menuTitle로 설정
     */
    public void setMenuTitle(String menuTitle) {
        this.menuTitle = menuTitle;
    }
    
    /**
     * String basePath을 반환
     * @return String basePath
     */
    public String getBasePath() {
        return basePath;
    }
    
    /**
     * basePath을 설정
     * @param basePath 을(를) String basePath로 설정
     */
    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }
    
    /**
     * String menuPath을 반환
     * @return String menuPath
     */
    public String getMenuPath() {
        return menuPath;
    }
    
    /**
     * menuPath을 설정
     * @param menuPath 을(를) String menuPath로 설정
     */
    public void setMenuPath(String menuPath) {
        this.menuPath = menuPath;
    }
    
    /**
     * String topMenuCode을 반환
     * @return String topMenuCode
     */
    public String getTopMenuCode() {
        return topMenuCode;
    }
    
    /**
     * topMenuCode을 설정
     * @param topMenuCode 을(를) String topMenuCode로 설정
     */
    public void setTopMenuCode(String topMenuCode) {
        this.topMenuCode = topMenuCode;
    }
    
    /**
     * String parntsMenuCode을 반환
     * @return String parntsMenuCode
     */
    public String getParntsMenuCode() {
        return parntsMenuCode;
    }
    
    /**
     * parntsMenuCode을 설정
     * @param parntsMenuCode 을(를) String parntsMenuCode로 설정
     */
    public void setParntsMenuCode(String parntsMenuCode) {
        this.parntsMenuCode = parntsMenuCode;
    }
    
    /**
     * Integer menuDp을 반환
     * @return Integer menuDp
     */
    public Integer getMenuDp() {
        return menuDp;
    }
    
    /**
     * menuDp을 설정
     * @param menuDp 을(를) Integer menuDp로 설정
     */
    public void setMenuDp(Integer menuDp) {
        this.menuDp = menuDp;
    }
    
    /**
     * Integer sortOrdr을 반환
     * @return Integer sortOrdr
     */
    public Integer getSortOrdr() {
        return sortOrdr;
    }
    
    /**
     * sortOrdr을 설정
     * @param sortOrdr 을(를) Integer sortOrdr로 설정
     */
    public void setSortOrdr(Integer sortOrdr) {
        this.sortOrdr = sortOrdr;
    }
    
    /**
     * String userMenuUrl을 반환
     * @return String userMenuUrl
     */
    public String getUserMenuUrl() {
        return userMenuUrl;
    }
    
    /**
     * userMenuUrl을 설정
     * @param userMenuUrl 을(를) String userMenuUrl로 설정
     */
    public void setUserMenuUrl(String userMenuUrl) {
        this.userMenuUrl = userMenuUrl;
    }
    
    /**
     * String layoutCode을 반환
     * @return String layoutCode
     */
    public String getLayoutCode() {
        return layoutCode;
    }
    
    /**
     * layoutCode을 설정
     * @param layoutCode 을(를) String layoutCode로 설정
     */
    public void setLayoutCode(String layoutCode) {
        this.layoutCode = layoutCode;
    }
    
    /**
     * String parntsLayoutUseYn을 반환
     * @return String parntsLayoutUseYn
     */
    public String getParntsLayoutUseYn() {
        return parntsLayoutUseYn;
    }
    
    /**
     * parntsLayoutUseYn을 설정
     * @param parntsLayoutUseYn 을(를) String parntsLayoutUseYn로 설정
     */
    public void setParntsLayoutUseYn(String parntsLayoutUseYn) {
        this.parntsLayoutUseYn = parntsLayoutUseYn;
    }
    
    /**
     * String menuTy을 반환
     * @return String menuTy
     */
    public String getMenuTy() {
        return menuTy;
    }
    
    /**
     * menuTy을 설정
     * @param menuTy 을(를) String menuTy로 설정
     */
    public void setMenuTy(String menuTy) {
        this.menuTy = menuTy;
    }
    
    /**
     * String linkTy을 반환
     * @return String linkTy
     */
    public String getLinkTy() {
        return linkTy;
    }
    
    /**
     * linkTy을 설정
     * @param linkTy 을(를) String linkTy로 설정
     */
    public void setLinkTy(String linkTy) {
        this.linkTy = linkTy;
    }
    
    /**
     * String approvalYn을 반환
     * @return String approvalYn
     */
    public String getApprovalYn() {
        return approvalYn;
    }
    
    /**
     * approvalYn을 설정
     * @param approvalYn 을(를) String approvalYn로 설정
     */
    public void setApprovalYn(String approvalYn) {
        this.approvalYn = approvalYn;
    }
    
    /**
     * String statisticsUseYn을 반환
     * @return String statisticsUseYn
     */
    public String getStatisticsUseYn() {
        return statisticsUseYn;
    }
    
    /**
     * statisticsUseYn을 설정
     * @param statisticsUseYn 을(를) String statisticsUseYn로 설정
     */
    public void setStatisticsUseYn(String statisticsUseYn) {
        this.statisticsUseYn = statisticsUseYn;
    }
    
    /**
     * String chargerShowYn을 반환
     * @return String chargerShowYn
     */
    public String getChargerShowYn() {
        return chargerShowYn;
    }
    
    /**
     * chargerShowYn을 설정
     * @param chargerShowYn 을(를) String chargerShowYn로 설정
     */
    public void setChargerShowYn(String chargerShowYn) {
        this.chargerShowYn = chargerShowYn;
    }
    
    /**
     * String showYn을 반환
     * @return String showYn
     */
    public String getShowYn() {
        return showYn;
    }
    
    /**
     * showYn을 설정
     * @param showYn 을(를) String showYn로 설정
     */
    public void setShowYn(String showYn) {
        this.showYn = showYn;
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
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode() {
        return langCode;
    }

    
    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }
    
    
}
