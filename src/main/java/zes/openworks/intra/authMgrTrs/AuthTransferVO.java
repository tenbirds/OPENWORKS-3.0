package zes.openworks.intra.authMgrTrs;

import zes.base.vo.PaggingVO;

public class AuthTransferVO extends PaggingVO {

    private static final long serialVersionUID = 7265943153538831539L;

    private String str = "";

    /** 요청자 부서명 */
    private String deptNm;
    /** 요청자 ID */
    private String mngrId;
    /** 요청자 명 */
    private String mngrNm;
    /** 요청자 직급명 */
    private String gradeNm;
    /** 대상자 부서명 */
    private String targetDeptNm;
    /** 대상자 ID */
    private String targetMgrId;
    /** 대상자 명 */
    private String targetMgrNm;
    /** 대상자 직급명 */
    private String targetGradeNm;
    /** 대상자 직위명 */
    private String targetTitleNm;
    /** 요청일 */
    private String reqRegDtm;
    /** 요청수정일 */
    private String reqModiDtm;
    /** 상태 */
    private String resTypeCd;
    /** 상태 */
    private String resTypeCds;
    /** 처리일 */
    private String prcmRegDtm;
    /** 처리수정일 */
    private String prcmMdiDtm;
    /** 일련번호 */
    private Integer seqNo;
    /** 요청 사유 */
    private String reqConts;
    /** 수정승인 및 반려사유 */
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
    /** 권한 구분 코드 */
    private String authTypeCd;
    /** 권한 할당 코드 */
    private String assignTypeCd;

    /** 권한 할당 코드 수 */
    private String assignCount;

    /** 권한 할당 코드 메뉴수 */
    private String authMenuAssignCount;

    /** 사용여부 */
    private String useYn;

    /** 권한코드 목록 */
    private String authCds;

    /** 처리자 아이디 */
    private String prcMgrId;

    /** 등록자 아이디 */
    private String regId;

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
     * @return the prcmMdiDtm
     */
    public String getPrcmMdiDtm() {
        return prcmMdiDtm;
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
    public void setPrcmMdiDtm(String prcmMdiDtm) {
        this.prcmMdiDtm = prcmMdiDtm;
    }

    public String getTargetMgrNm() {
        return targetMgrNm;
    }

    public void setTargetMgrNm(String targetMgrNm) {
        this.targetMgrNm = targetMgrNm;
    }

    public String getTargetMgrId() {
        return targetMgrId;
    }

    public void setTargetMgrId(String targetMgrId) {
        this.targetMgrId = targetMgrId;
    }

    public String getTargetDeptNm() {
        return targetDeptNm;
    }

    public void setTargetDeptNm(String targetDeptNm) {
        this.targetDeptNm = targetDeptNm;
    }

    public String getGradeNm() {
        return gradeNm;
    }

    public void setGradeNm(String gradeNm) {
        this.gradeNm = gradeNm;
    }

    public String getAssignTypeCd() {
        return assignTypeCd;
    }

    public void setAssignTypeCd(String assignTypeCd) {
        this.assignTypeCd = assignTypeCd;
    }

    public String getTargetGradeNm() {
        return targetGradeNm;
    }

    public void setTargetGradeNm(String targetGradeNm) {
        this.targetGradeNm = targetGradeNm;
    }

    public String getTargetTitleNm() {
        return targetTitleNm;
    }

    public void setTargetTitleNm(String targetTitleNm) {
        this.targetTitleNm = targetTitleNm;
    }

    public String getAssignCount() {
        return assignCount;
    }

    public void setAssignCount(String assignCount) {
        this.assignCount = assignCount;
    }

    public String getAuthNm() {
        return authNm;
    }

    public void setAuthNm(String authNm) {
        this.authNm = authNm;
    }

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public String getReqRegDtm() {
        return reqRegDtm;
    }

    public void setReqRegDtm(String reqRegDtm) {
        this.reqRegDtm = reqRegDtm;
    }

    public String getPrcmRegDtm() {
        return prcmRegDtm;
    }

    public void setPrcmRegDtm(String prcmRegDtm) {
        this.prcmRegDtm = prcmRegDtm;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getAuthCds() {
        return authCds;
    }

    public void setAuthCds(String authCds) {
        this.authCds = authCds;
    }

    public String getPrcMgrId() {
        return prcMgrId;
    }

    public void setPrcMgrId(String prcMgrId) {
        this.prcMgrId = prcMgrId;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public String getAuthMenuAssignCount() {
        return authMenuAssignCount;
    }

    public void setAuthMenuAssignCount(String authMenuAssignCount) {
        this.authMenuAssignCount = authMenuAssignCount;
    }

    public String getResTypeCds() {
        return resTypeCds;
    }

    public void setResTypeCds(String resTypeCds) {
        this.resTypeCds = resTypeCds;
    }
}
