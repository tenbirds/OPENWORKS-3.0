package zes.openworks.intra.mgr;

import zes.base.vo.BaseVO;

public class AdditionalVO extends BaseVO {

    private static final long serialVersionUID = 7265943153538831539L;

    /** 부서명 */
    private String deptNm;
    /** 요청자 ID */
    private String mgrId;
    /** 요청자 명 */
    private String mgrNm;
    /** 요청일 */
    private String reqModiDtm;
    /** 상태 */
    private String resTypeCd;
    /** 처리일 */
    private String prcModiDtm;
    /** 일련번호 */
    private Integer seqNo;
    /** 요청 사유 */
    private String reqConts;
    /** 반려사유 */
    private String resConts;
    /** 요청구분코드 */
    private String reqTypeCd;
    /** 메뉴 명 */
    private String menuNm;
    /** 권한 코드 */
    private String authCd;
    /** 권한 명 */
    private String authNm;

    /** 메뉴 코드 */
    private String menuCd;
    /** 권한 할당 코드 */
    private String assignTypeCd;
    private String authMenuAssignCount;
    /** 권한 구분 코드 */
    private String authTypeCd;
    /** 개별코드 유무 */
    private String mSeqNo;
    /** 등록자 */
    private String regId;
    /** 사용유무 */
    private String checkYn;
    /** 처리자 아이디 */
    private String prcMgrId;
    /** 권한 추가 요청 관리 미처리 숫자 */
    private String listCountA;
    /** 권한 삭제 요청 관리 미처리 숫자 */
    private String listCountD;
    private String searchKey2;

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
     * @return the listCountA
     */
    public String getListCountA() {
        return listCountA;
    }

    /**
     * @return the listCountD
     */
    public String getListCountD() {
        return listCountD;
    }

    /**
     * @param listCountA the listCountA to set
     */
    public void setListCountA(String listCountA) {
        this.listCountA = listCountA;
    }

    /**
     * @param listCountD the listCountD to set
     */
    public void setListCountD(String listCountD) {
        this.listCountD = listCountD;
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
     * @return the prcMgrId
     */
    public String getPrcMgrId() {
        return prcMgrId;
    }

    /**
     * @param prcMgrId the prcMgrId to set
     */
    public void setPrcMgrId(String prcMgrId) {
        this.prcMgrId = prcMgrId;
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
     * @return the regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * @param regId the regId to set
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * @return the mSeqNo
     */
    public String getmSeqNo() {
        return mSeqNo;
    }

    /**
     * @param mSeqNo the mSeqNo to set
     */
    public void setmSeqNo(String mSeqNo) {
        this.mSeqNo = mSeqNo;
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
     * @return the menuNm
     */
    public String getMenuNm() {
        return menuNm;
    }

    /**
     * @param menuNm the menuNm to set
     */
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
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
     * @return the resConts
     */
    public String getResConts() {
        return resConts;
    }

    /**
     * @param resConts the resConts to set
     */
    public void setResConts(String resConts) {
        this.resConts = resConts;
    }

    /**
     * @return the reqConts
     */
    public String getReqConts() {
        return reqConts;
    }

    /**
     * @param reqConts the reqConts to set
     */
    public void setReqConts(String reqConts) {
        this.reqConts = reqConts;
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
     * @return the seqNo
     */
    public Integer getSeqNo() {
        return seqNo;
    }

    /**
     * @param seqNo the seqNo to set
     */
    public void setSeqNo(Integer seqNo) {
        this.seqNo = seqNo;
    }

    /**
     * @return the mgrId
     */
    public String getMgrId() {
        return mgrId;
    }

    /**
     * @return the mgrNm
     */
    public String getMgrNm() {
        return mgrNm;
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
     * @param mgrId the mgrId to set
     */
    public void setMgrId(String mgrId) {
        this.mgrId = mgrId;
    }

    /**
     * @param mgrNm the mgrNm to set
     */
    public void setMgrNm(String mgrNm) {
        this.mgrNm = mgrNm;
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
}
