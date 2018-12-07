package zes.openworks.intra.auth;

import zes.base.vo.BaseVO;

public class AuthMenuVO extends BaseVO {

    private static final long serialVersionUID = -7951801690908427806L;

    private String menuCd;
    private String mngrMenuNm;
    private String menuUrl;
    private String menuLevel;

    private String asgnTyCode;

    private String assignMenu;

    private Integer assignPCnt;

    private String mgrAssign;

    public String getMenuCd() {
        return menuCd;
    }

    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getMenuNm() {
        return mngrMenuNm;
    }

    public void setMenuNm(String mngrMenuNm) {
        this.mngrMenuNm = mngrMenuNm;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public String getMenuLevel() {
        return menuLevel;
    }

    public void setMenuLevel(String menuLevel) {
        this.menuLevel = menuLevel;
    }

    public String getAssignTypeCd() {
        return asgnTyCode;
    }

    public void setAssignTypeCd(String asgnTyCode) {
        this.asgnTyCode = asgnTyCode;
    }

    public String getAssignMenu() {
        return assignMenu;
    }

    public void setAssignMenu(String assignMenu) {
        this.assignMenu = assignMenu;
    }

    public Integer getAssignPCnt() {
        return assignPCnt;
    }

    public void setAssignPCnt(Integer assignPCnt) {
        this.assignPCnt = assignPCnt;
    }

    public String getMgrAssign() {
        return mgrAssign;
    }

    public void setMgrAssign(String mgrAssign) {
        this.mgrAssign = mgrAssign;
    }

    @Override
    public String toString() {
        return "AuthMenuVO [menuCd=" + menuCd + ", mngrMenuNm=" + mngrMenuNm
            + ", menuUrl=" + menuUrl + ", menuLevel=" + menuLevel
            + ", asgnTyCode=" + asgnTyCode + ", assignMenu="
            + assignMenu + ", assignPCnt=" + assignPCnt + ", mgrAssign="
            + mgrAssign + "]";
    }
}
