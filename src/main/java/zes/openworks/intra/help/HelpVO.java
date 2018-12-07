package zes.openworks.intra.help;

import zes.base.vo.PaggingVO;

public class HelpVO extends PaggingVO {

    private static final long serialVersionUID = -9066643876847956548L;

    private String helpId;
    private String menuCd;
    private String menuNm;
    private String helpNm;
    private String contents;

    private String rn;

    public String getHelpId() {
        return helpId;
    }

    public void setHelpId(String helpId) {
        this.helpId = helpId;
    }

    public String getMenuCd() {
        return menuCd;
    }

    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getMenuNm() {
        return menuNm;
    }

    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    public String getHelpNm() {
        return helpNm;
    }

    public void setHelpNm(String helpNm) {
        this.helpNm = helpNm;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getRn() {
        return rn;
    }

    public void setRn(String rn) {
        this.rn = rn;
    }

    @Override
    public String toString() {
        return "HelpVO [helpId=" + helpId + ", menuCd=" + menuCd + ", menuNm="
            + menuNm + ", helpNm=" + helpNm + ", contents=" + contents
            + ", rn=" + rn + "]";
    }

}
