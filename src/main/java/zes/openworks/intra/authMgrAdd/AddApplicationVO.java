package zes.openworks.intra.authMgrAdd;

import zes.base.vo.PaggingVO;

public class AddApplicationVO extends PaggingVO {

    private static final long serialVersionUID = 7265943153538831539L;

    /** 요청자 ID */
    private String mngrId;
    /** 요청자 명 */
    private String mngrNm;
    /** 요청일 */
    private String reqModiDtm;
    /** 상태 */
    private String resTypeCd;
    /** 처리일 */
    private String prcModiDtm;
    /** 일련번호 */
    private Integer seqNo;
    /** 요청구분코드 */
    private String reqTypeCd;
    /** 부서명 */
    private String deptNm;
    /** 권한그룹코드 */
    private String authTypeCd;
    /** 권한 명 */
    private String authNm;
    /** 요청 사유 */
    private String reqConts;
    /** 반려사유 */
    private String resConts;
    /** 현재할당권한 구분 */
    private String checkYn;
    /** 권한 코드 */
    private String authCd;
    /** 메뉴 코드 */
    private String menuCd;
    /** 권한 할당 코드 */
    private String assignTypeCd;
    /** 할당메뉴 건수 */
    private String authMenuAssignCount;
    /***/
    private String menuNm;
    /***/
    private String menuLevel;
    /***/
    private String assignMenu;
    /***/
    private String assignPCnt;
    /***/
    private String mgrAssign;
    /** 사용 여부 */
    private String useYn;
    /** 권한 설명 */
    private String authDesc;
    /** 권한정보 등록 ID */
    private String regId;
    /** 권한 정보 수정 ID */
    private String modiId;

    private String searchKey2;

    private String gradeNm;

    /**
     * @return the searchKey2
     */
    public String getSearchKey2() {
        return searchKey2;
    }

    /**
     * @param searchKey2 the searchKey2 to set
     */
    public void setSearchKey2(String searchKey2) {
        this.searchKey2 = searchKey2;
    }

    /**
     * @return the regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * @return the modiId
     */
    public String getModiId() {
        return modiId;
    }

    /**
     * @param regId the regId to set
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * @param modiId the modiId to set
     */
    public void setModiId(String modiId) {
        this.modiId = modiId;
    }

    /**
     * @return the authDesc
     */
    public String getAuthDesc() {
        return authDesc;
    }

    /**
     * @param authDesc the authDesc to set
     */
    public void setAuthDesc(String authDesc) {
        this.authDesc = authDesc;
    }

    /**
     * @return the useYn
     */
    public String getUseYn() {
        return useYn;
    }

    /**
     * @param useYn the useYn to set
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    /**
     * @return the menuNm
     */
    public String getMenuNm() {
        return menuNm;
    }

    /**
     * @return the menuLevel
     */
    public String getMenuLevel() {
        return menuLevel;
    }

    /**
     * @return the assignMenu
     */
    public String getAssignMenu() {
        return assignMenu;
    }

    /**
     * @return the assignPCnt
     */
    public String getAssignPCnt() {
        return assignPCnt;
    }

    /**
     * @return the mgrAssign
     */
    public String getMgrAssign() {
        return mgrAssign;
    }

    /**
     * @param menuNm the menuNm to set
     */
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    /**
     * @param menuLevel the menuLevel to set
     */
    public void setMenuLevel(String menuLevel) {
        this.menuLevel = menuLevel;
    }

    /**
     * @param assignMenu the assignMenu to set
     */
    public void setAssignMenu(String assignMenu) {
        this.assignMenu = assignMenu;
    }

    /**
     * @param assignPCnt the assignPCnt to set
     */
    public void setAssignPCnt(String assignPCnt) {
        this.assignPCnt = assignPCnt;
    }

    /**
     * @param mgrAssign the mgrAssign to set
     */
    public void setMgrAssign(String mgrAssign) {
        this.mgrAssign = mgrAssign;
    }

    /**
     * @return the authMenuAssignCount
     */
    public String getAuthMenuAssignCount() {
        return authMenuAssignCount;
    }

    /**
     * @param authMenuAssignCount the authMenuAssignCount to set
     */
    public void setAuthMenuAssignCount(String authMenuAssignCount) {
        this.authMenuAssignCount = authMenuAssignCount;
    }

    /**
     * @return the assignTypeCd
     */
    public String getAssignTypeCd() {
        return assignTypeCd;
    }

    /**
     * @param assignTypeCd the assignTypeCd to set
     */
    public void setAssignTypeCd(String assignTypeCd) {
        this.assignTypeCd = assignTypeCd;
    }

    /**
     * @return the menuCd
     */
    public String getMenuCd() {
        return menuCd;
    }

    /**
     * @param menuCd the menuCd to set
     */
    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }

    /**
     * @return the authCd
     */
    public String getAuthCd() {
        return authCd;
    }

    /**
     * @param authCd the authCd to set
     */
    public void setAuthCd(String authCd) {
        this.authCd = authCd;
    }

    /**
     * @return the checkYn
     */
    public String getCheckYn() {
        return checkYn;
    }

    /**
     * @param checkYn the checkYn to set
     */
    public void setCheckYn(String checkYn) {
        this.checkYn = checkYn;
    }

    /**
     * @return the reqConts
     */
    public String getReqConts() {
        return reqConts;
    }

    /**
     * @return the resConts
     */
    public String getResConts() {
        return resConts;
    }

    /**
     * @param reqConts the reqConts to set
     */
    public void setReqConts(String reqConts) {
        this.reqConts = reqConts;
    }

    /**
     * @param resConts the resConts to set
     */
    public void setResConts(String resConts) {
        this.resConts = resConts;
    }

    /**
     * @return the authNm
     */
    public String getAuthNm() {
        return authNm;
    }

    /**
     * @param authNm the authNm to set
     */
    public void setAuthNm(String authNm) {
        this.authNm = authNm;
    }

    /**
     * @return the authTypeCd
     */
    public String getAuthTypeCd() {
        return authTypeCd;
    }

    /**
     * @param authTypeCd the authTypeCd to set
     */
    public void setAuthTypeCd(String authTypeCd) {
        this.authTypeCd = authTypeCd;
    }

    /**
     * @return the deptNm
     */
    public String getDeptNm() {
        return deptNm;
    }

    /**
     * @param deptNm the deptNm to set
     */
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    /**
     * @return the reqTypeCd
     */
    public String getReqTypeCd() {
        return reqTypeCd;
    }

    /**
     * @param reqTypeCd the reqTypeCd to set
     */
    public void setReqTypeCd(String reqTypeCd) {
        this.reqTypeCd = reqTypeCd;
    }

    /**
     * @return the prcModiDtm
     */
    public String getPrcModiDtm() {
        return prcModiDtm;
    }

    /**
     * @param prcModiDtm the prcModiDtm to set
     */
    public void setPrcModiDtm(String prcModiDtm) {
        this.prcModiDtm = prcModiDtm;
    }

    /**
     * String mngrId을 반환
     * 
     * @return String mngrId
     */
    public String getMngrId() {
        return mngrId;
    }

    /**
     * mngrId을 설정
     * 
     * @param mngrId 을(를) String mngrId로 설정
     */
    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    /**
     * @return the reqModiDtm
     */
    public String getReqModiDtm() {
        return reqModiDtm;
    }

    /**
     * @return the resTypeCd
     */
    public String getResTypeCd() {
        return resTypeCd;
    }

    /**
     * @return the seqNo
     */
    public Integer getSeqNo() {
        return seqNo;
    }

    /**
     * String mngrNm을 반환
     * 
     * @return String mngrNm
     */
    public String getMngrNm() {
        return mngrNm;
    }

    /**
     * mngrNm을 설정
     * 
     * @param mngrNm 을(를) String mngrNm로 설정
     */
    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    /**
     * @param reqModiDtm the reqModiDtm to set
     */
    public void setReqModiDtm(String reqModiDtm) {
        this.reqModiDtm = reqModiDtm;
    }

    /**
     * @param resTypeCd the resTypeCd to set
     */
    public void setResTypeCd(String resTypeCd) {
        this.resTypeCd = resTypeCd;
    }

    /**
     * @param prcmMdiDtm the prcmMdiDtm to set
     */

    /**
     * @param seqNo the seqNo to set
     */
    public void setSeqNo(Integer seqNo) {
        this.seqNo = seqNo;
    }

    public String getGradeNm() {
        return gradeNm;
    }

    public void setGradeNm(String gradeNm) {
        this.gradeNm = gradeNm;
    }

}
