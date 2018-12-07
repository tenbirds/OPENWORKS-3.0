package zes.openworks.intra.auth;

import zes.base.vo.PaggingVO;

public class AuthMgrVO extends PaggingVO {

    private static final long serialVersionUID = 3192324699637581399L;

    private String searchType;
    private String searchText;

    private String upperDeptCode;
    private String deptCode;

    private String authCode;
    private String menuCd;

   // private String assignTypeCd;
    
    private String asgnTyCode;

    private String mngrId;
    private String deptNm;
    private String gradeNm;
    private String mngrNm;

    private String authListString;

    private String rn;
    private String useYn;

    private String langCode;
    
    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }

    public String getUpperDeptCode() {
        return upperDeptCode;
    }

    public void setUpperDeptCode(String upperDeptCode) {
        this.upperDeptCode = upperDeptCode;
    }

    public String getDeptCode() {
        return deptCode;
    }

    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public String getMenuCd() {
        return menuCd;
    }

    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getAsgnTyCode() {
        return asgnTyCode;
    }

    public void setAsgnTyCode(String asgnTyCode) {
        this.asgnTyCode = asgnTyCode;
    }

    public String getMngrId() {
        return mngrId;
    }

    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getGradeNm() {
        return gradeNm;
    }

    public void setGradeNm(String gradeNm) {
        this.gradeNm = gradeNm;
    }

    public String getMngrNm() {
        return mngrNm;
    }

    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    public String getAuthListString() {
        return authListString;
    }

    public void setAuthListString(String authListString) {
        this.authListString = authListString;
    }

    public String getRn() {
        return rn;
    }

    public void setRn(String rn) {
        this.rn = rn;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    
    /**
     * String langCd을 반환
     * @return String langCd
     */
    public String getLangCode() {
        return langCode;
    }

    
    /**
     * langCode을 설정
     * @param langCode 을(를) String langCd로 설정
     */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    @Override
    public String toString() {
        return "AuthMgrVO [searchType=" + searchType + ", searchText="
            + searchText + ", upperDeptCode=" + upperDeptCode + ", deptCode="
            + deptCode + ", authCode=" + authCode + ", menuCd=" + menuCd
            + ", asgnTyCode=" + asgnTyCode + ", mngrId=" + mngrId
            + ", deptNm=" + deptNm + ", gradeNm=" + gradeNm + ", mngrNm="
            + mngrNm + ", authListString=" + authListString + ", rn=" + rn
            + ", useYn=" + useYn + "]";
    }

}
