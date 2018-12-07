/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.web.webCommunity.admin.cmOptBoardMenu;

//import java.util.List;

import zes.base.vo.TreeVO;


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
 * 2014. 11. 5.    		 boseok       	신규
 *</pre>
 * @see
 */
public class CmOptBoardMenuVO  extends TreeVO {
    
    /**  */
    private static final long serialVersionUID = 7204424920291938847L;
    
    /**  커뮤니티아이디  */
    private String cmmntyId;
    /**  언어코드  */
    private String langCode;
    /**  언어명  */
    private String langNm;
    
    /**  커뮤니티메뉴코드  */
    private String cmmntyMenuCode;
    private String cmmntyUpMenuCode;
    /**  메뉴게시판구분  */
    private String menuBbsSe;
    /**  필수메뉴가부  */
    private String essntlMenuAt;
    /**  정렬순서  */
    private Integer sortOrdr;
    /**  커뮤니티메뉴폴더명  */
    private String cmmntyMenuFolderNm;
    /**  커뮤니티메뉴URL  */
    private String cmmntyMenuUrl;
    /**  커뮤니티메뉴명  */
    private String cmmntyMenuNm;
    
    /**  메뉴성격코드  */
    private Integer menuCharctCd;
    /**  메뉴성격 명  */
    private String menuCharctNm;
    /**  커뮤니티게시판유형코드  */
    private Integer cmmntyBbsTyCd;
    /**  커뮤니티게시판유형 명  */
    private String cmmntyBbsTyNm;
    /**  커뮤니티게시판코드  */
    private Integer cmmntyBbsCd;
    /**  커뮤니티 메뉴설명  */
    private String cmmntyMenuDc;
    /**
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }
    
    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
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
    
    /**
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }
    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }
    
    /**
     * String cmmntyMenuCode을 반환
     * @return String cmmntyMenuCode
     */
    public String getCmmntyMenuCode() {
        return cmmntyMenuCode;
    }
    
    /**
     * cmmntyMenuCode을 설정
     * @param cmmntyMenuCode 을(를) String cmmntyMenuCode로 설정
     */
    public void setCmmntyMenuCode(String cmmntyMenuCode) {
        this.cmmntyMenuCode = cmmntyMenuCode;
    }
    
    /**
     * String menuBbsSe을 반환
     * @return String menuBbsSe
     */
    public String getMenuBbsSe() {
        return menuBbsSe;
    }
    
    /**
     * menuBbsSe을 설정
     * @param menuBbsSe 을(를) String menuBbsSe로 설정
     */
    public void setMenuBbsSe(String menuBbsSe) {
        this.menuBbsSe = menuBbsSe;
    }
    
    /**
     * String essntlMenuAt을 반환
     * @return String essntlMenuAt
     */
    public String getEssntlMenuAt() {
        return essntlMenuAt;
    }
    
    /**
     * essntlMenuAt을 설정
     * @param essntlMenuAt 을(를) String essntlMenuAt로 설정
     */
    public void setEssntlMenuAt(String essntlMenuAt) {
        this.essntlMenuAt = essntlMenuAt;
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
     * String cmmntyMenuFolderNm을 반환
     * @return String cmmntyMenuFolderNm
     */
    public String getCmmntyMenuFolderNm() {
        return cmmntyMenuFolderNm;
    }
    
    /**
     * cmmntyMenuFolderNm을 설정
     * @param cmmntyMenuFolderNm 을(를) String cmmntyMenuFolderNm로 설정
     */
    public void setCmmntyMenuFolderNm(String cmmntyMenuFolderNm) {
        this.cmmntyMenuFolderNm = cmmntyMenuFolderNm;
    }
    
    /**
     * String cmmntyMenuUrl을 반환
     * @return String cmmntyMenuUrl
     */
    public String getCmmntyMenuUrl() {
        return cmmntyMenuUrl;
    }
    
    /**
     * cmmntyMenuUrl을 설정
     * @param cmmntyMenuUrl 을(를) String cmmntyMenuUrl로 설정
     */
    public void setCmmntyMenuUrl(String cmmntyMenuUrl) {
        this.cmmntyMenuUrl = cmmntyMenuUrl;
    }
    
    /**
     * String cmmntyMenuNm을 반환
     * @return String cmmntyMenuNm
     */
    public String getCmmntyMenuNm() {
        return cmmntyMenuNm;
    }
    
    /**
     * cmmntyMenuNm을 설정
     * @param cmmntyMenuNm 을(를) String cmmntyMenuNm로 설정
     */
    public void setCmmntyMenuNm(String cmmntyMenuNm) {
        this.cmmntyMenuNm = cmmntyMenuNm;
    }
    
    /**
     * Integer menuCharctCd을 반환
     * @return Integer menuCharctCd
     */
    public Integer getMenuCharctCd() {
        return menuCharctCd;
    }
    
    /**
     * menuCharctCd을 설정
     * @param menuCharctCd 을(를) Integer menuCharctCd로 설정
     */
    public void setMenuCharctCd(Integer menuCharctCd) {
        this.menuCharctCd = menuCharctCd;
    }
    
    /**
     * String menuCharctNm을 반환
     * @return String menuCharctNm
     */
    public String getMenuCharctNm() {
        return menuCharctNm;
    }
    
    /**
     * menuCharctNm을 설정
     * @param menuCharctNm 을(를) String menuCharctNm로 설정
     */
    public void setMenuCharctNm(String menuCharctNm) {
        this.menuCharctNm = menuCharctNm;
    }
    
    /**
     * Integer cmmntyBbsTyCd을 반환
     * @return Integer cmmntyBbsTyCd
     */
    public Integer getCmmntyBbsTyCd() {
        return cmmntyBbsTyCd;
    }
    
    /**
     * cmmntyBbsTyCd을 설정
     * @param cmmntyBbsTyCd 을(를) Integer cmmntyBbsTyCd로 설정
     */
    public void setCmmntyBbsTyCd(Integer cmmntyBbsTyCd) {
        this.cmmntyBbsTyCd = cmmntyBbsTyCd;
    }
    
    /**
     * String cmmntyBbsTyNm을 반환
     * @return String cmmntyBbsTyNm
     */
    public String getCmmntyBbsTyNm() {
        return cmmntyBbsTyNm;
    }
    
    /**
     * cmmntyBbsTyNm을 설정
     * @param cmmntyBbsTyNm 을(를) String cmmntyBbsTyNm로 설정
     */
    public void setCmmntyBbsTyNm(String cmmntyBbsTyNm) {
        this.cmmntyBbsTyNm = cmmntyBbsTyNm;
    }
    
    /**
     * Integer cmmntyBbsCd을 반환
     * @return Integer cmmntyBbsCd
     */
    public Integer getCmmntyBbsCd() {
        return cmmntyBbsCd;
    }
    
    /**
     * cmmntyBbsCd을 설정
     * @param cmmntyBbsCd 을(를) Integer cmmntyBbsCd로 설정
     */
    public void setCmmntyBbsCd(Integer cmmntyBbsCd) {
        this.cmmntyBbsCd = cmmntyBbsCd;
    }

    
    /**
     * String cmmntyMenuDc을 반환
     * @return String cmmntyMenuDc
     */
    public String getCmmntyMenuDc() {
        return cmmntyMenuDc;
    }

    
    /**
     * cmmntyMenuDc을 설정
     * @param cmmntyMenuDc 을(를) String cmmntyMenuDc로 설정
     */
    public void setCmmntyMenuDc(String cmmntyMenuDc) {
        this.cmmntyMenuDc = cmmntyMenuDc;
    }

    
    /**
     * String cmmntyUpMenuCode을 반환
     * @return String cmmntyUpMenuCode
     */
    public String getCmmntyUpMenuCode() {
        return cmmntyUpMenuCode;
    }

    
    /**
     * cmmntyUpMenuCode을 설정
     * @param cmmntyUpMenuCode 을(를) String cmmntyUpMenuCode로 설정
     */
    public void setCmmntyUpMenuCode(String cmmntyUpMenuCode) {
        this.cmmntyUpMenuCode = cmmntyUpMenuCode;
    }
    
    
    

}
