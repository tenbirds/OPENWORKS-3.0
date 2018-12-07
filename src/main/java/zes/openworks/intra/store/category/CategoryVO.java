package zes.openworks.intra.store.category;

import zes.base.vo.TreeVO;

public class CategoryVO extends TreeVO {

    private static final long serialVersionUID = -8945045797265073657L;

    private String langCd;

    private String langNm;

    /** 메뉴코드 */
    private String menuCd = "0";
    /** 메뉴이름 */
    private String mngrMenuNm;
    /** 상위코드 */
    private String upperMenuCd = "0";
    /** 상위이름 */
    private String upperMenuNm;
    private String langCode;
    private Integer ctgryClCd;

    private String[] ctgryCodes;
    private Boolean chkBox = true;
    private String mapngCtgryCode;
    private String mapngCtgryPath;

    /** 메뉴주소 */
    private String menuUrl;
    /** 컨트롤러명 */
    private String controllerNm;

    /** 메뉴폴더명 */
    private String menuFolder;
    /** 정렬순서 */
    private Integer menuOrdrNo = 0;
    /** 사용여부 */
    private String useYn;
    /** 등록일 */
    private String registDt;
    /** 수정일 */
    private String updtDt;
    /** 메뉴 도움말 */
    private String[] help;

    /** 담당자 ID */
    private String mngrId;
    /** 할당된 메뉴 권한 */
    private String[] menuGrpNms;
    /** 할당된 메뉴 권한 */
    private String[] authNms;

    /** 원클릭 트리메뉴 펼치 */
    private String singleClickExpand = "true";

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

    public String getHighMenuCd() {
        return upperMenuCd;
    }

    public void setHighMenuCd(String upperMenuCd) {
        this.upperMenuCd = upperMenuCd;
    }

    public String getHighMenuNm() {
        return upperMenuNm;
    }

    public void setHighMenuNm(String upperMenuNm) {
        this.upperMenuNm = upperMenuNm;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public String getControllerNm() {
        return controllerNm;
    }

    public void setControllerNm(String controllerNm) {
        this.controllerNm = controllerNm;
    }

    public String getMenuFolder() {
        return menuFolder;
    }

    public void setMenuFolder(String menuFolder) {
        this.menuFolder = menuFolder;
    }

    public Integer getOrderNo() {
        return menuOrdrNo;
    }

    public void setOrderNo(Integer menuOrdrNo) {
        this.menuOrdrNo = menuOrdrNo;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegDt() {
        return registDt;
    }

    public void setRegDt(String registDt) {
        this.registDt = registDt;
    }

    public String getModiDt() {
        return updtDt;
    }

    public void setModiDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getMngrMenuNm() {
        return mngrMenuNm;
    }

    public void setMngrMenuNm(String mngrMenuNm) {
        this.mngrMenuNm = mngrMenuNm;
    }

    public String getUpperMenuCd() {
        return upperMenuCd;
    }

    public void setUpperMenuCd(String upperMenuCd) {
        this.upperMenuCd = upperMenuCd;
    }

    public Integer getMenuOrdrNo() {
        return menuOrdrNo;
    }

    public void setMenuOrdrNo(Integer menuOrdrNo) {
        this.menuOrdrNo = menuOrdrNo;
    }

    public String getMngrId() {
        return mngrId;
    }

    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    public String[] getMenuGrpNms() {
        return menuGrpNms;
    }

    public void setMenuGrpNms(String[] menuGrpNms) {
        this.menuGrpNms = menuGrpNms;
    }

    public String[] getAuthNms() {
        return authNms;
    }

    public void setAuthNms(String[] authNms) {
        this.authNms = authNms;
    }

    public String getSingleClickExpand() {
        return singleClickExpand;
    }

    public void setSingleClickExpand(String singleClickExpand) {
        this.singleClickExpand = singleClickExpand;
    }

    public String[] getHelp() {
        return help;
    }

    public void setHelp(String[] help) {
        this.help = help;
    }

    /**
     * Integer ctgryClCd을 반환
     * @return Integer ctgryClCd
     */
    public Integer getCtgryClCd() {
        return ctgryClCd;
    }

    /**
     * ctgryClCd을 설정
     * @param ctgryClCd 을(를) Integer ctgryClCd로 설정
     */
    public void setCtgryClCd(Integer ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }

    /**
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCd() {
        return langCd;
    }

    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCd(String langCd) {
        this.langCd = langCd;
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
     * String[] ctgryCodes을 반환
     * @return String[] ctgryCodes
     */
    public String[] getCtgryCodes() {
        return ctgryCodes;
    }

    /**
     * ctgryCodes을 설정
     * @param ctgryCodes 을(를) String[] ctgryCodes로 설정
     */
    public void setCtgryCodes(String[] ctgryCodes) {
        this.ctgryCodes = ctgryCodes;
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
     * Boolean chkBox을 반환
     * @return Boolean chkBox
     */
    public Boolean getChkBox() {
        return chkBox;
    }

    /**
     * chkBox을 설정
     * @param chkBox 을(를) Boolean chkBox로 설정
     */
    public void setChkBox(Boolean chkBox) {
        this.chkBox = chkBox;
    }

    /**
     * String mapngCtgryCode을 반환
     * @return String mapngCtgryCode
     */
    public String getMapngCtgryCode() {
        return mapngCtgryCode;
    }

    /**
     * mapngCtgryCode을 설정
     * @param mapngCtgryCode 을(를) String mapngCtgryCode로 설정
     */
    public void setMapngCtgryCode(String mapngCtgryCode) {
        this.mapngCtgryCode = mapngCtgryCode;
    }

    /**
     * String mapngCtgryPath을 반환
     * @return String mapngCtgryPath
     */
    public String getMapngCtgryPath() {
        return mapngCtgryPath;
    }

    /**
     * mapngCtgryPath을 설정
     * @param mapngCtgryPath 을(를) String mapngCtgryPath로 설정
     */
    public void setMapngCtgryPath(String mapngCtgryPath) {
        this.mapngCtgryPath = mapngCtgryPath;
    }

}
