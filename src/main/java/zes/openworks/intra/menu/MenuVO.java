package zes.openworks.intra.menu;

import zes.base.vo.TreeVO;

public class MenuVO extends TreeVO {

    private static final long serialVersionUID = -1918788144794628188L;

    /** 메뉴코드 */
    private Integer menuCd = 0;
    /** 메뉴이름 */
    private String mngrMenuNm;
    /** 상위코드 */
    private Integer upperMenuCd = 0;
    /** 상위이름 */
    private String upperMenuNm;

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

    public Integer getMenuCd() {
        return menuCd;
    }

    public void setMenuCd(Integer menuCd) {
        this.menuCd = menuCd;
    }

    public String getMenuNm() {
        return mngrMenuNm;
    }

    public void setMenuNm(String mngrMenuNm) {
        this.mngrMenuNm = mngrMenuNm;
    }

    public Integer getHighMenuCd() {
        return upperMenuCd;
    }

    public void setHighMenuCd(Integer upperMenuCd) {
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

    public Integer getUpperMenuCd() {
        return upperMenuCd;
    }

    public void setUpperMenuCd(Integer upperMenuCd) {
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
}
