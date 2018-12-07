package zes.openworks.intra.menugrp;

import zes.base.vo.BaseVO;

/**
 * 메뉴 ITEM VO
 * 
 * @author wisepms
 * @version $Id: MenuItemVO.java 25 2011-07-13 05:32:06Z oworks $
 */
public class MenuItemVO extends BaseVO {

    private static final long serialVersionUID = -1723789753632774768L;

    /** 메뉴그룹 코드 */
    private Integer menuGrpCd = 0;
    /** 메뉴코드 */
    private Integer menuCd = 0;
    /** 메뉴명 */
    private String mngrMenuNm;
    /** 메뉴아이템 상세 */
    private String menuItemDesc;
    /** 컨트롤러명 */
    private String controllerNm;
    /** 권한할당코드 */
    private String asgnTyCode;

    /** 메뉴레벨 */
    private Integer level = 0;
    /** 체크여부 */
    private String checked;

    /** 메뉴주소 : Using by login-sqlmap.xml's permissionList */
    private String menuUrl;
    /** 메뉴폴더명 : Using by login-sqlmap.xml's permissionList */
    private String menuFolder;

    public Integer getMenuCd() {
        return menuCd;
    }

    public void setMenuCd(Integer menuCd) {
        this.menuCd = menuCd;
    }

    public Integer getMenuGrpCd() {
        return menuGrpCd;
    }

    public void setMenuGrpCd(Integer menuGrpCd) {
        this.menuGrpCd = menuGrpCd;
    }

    public String getMenuItemDesc() {
        return menuItemDesc;
    }

    public void setMenuItemDesc(String menuItemDesc) {
        this.menuItemDesc = menuItemDesc;
    }

    public String getControllerNm() {
        return controllerNm;
    }

    public void setControllerNm(String controllerNm) {
        this.controllerNm = controllerNm;
    }

    public String getAssignTyCode() {
        return asgnTyCode;
    }

    public void setAssignTyCode(String asgnTyCode) {
        this.asgnTyCode = asgnTyCode;
    }

    public String getChecked() {
        return checked;
    }

    public void setChecked(String checked) {
        this.checked = checked;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public String getMenuFolder() {
        return menuFolder;
    }

    public void setMenuFolder(String menuFolder) {
        this.menuFolder = menuFolder;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getMenuNm() {
        return mngrMenuNm;
    }

    public void setMenuNm(String mngrMenuNm) {
        this.mngrMenuNm = mngrMenuNm;
    }
}
