package zes.openworks.intra.mgr;

import java.util.List;

import zes.base.vo.PaggingVO;
import zes.openworks.intra.menugrp.MenuGrpVO;

public class MgrVO extends PaggingVO {

    private static final long serialVersionUID = 8830653007672410142L;
    
    /** 담당자 ID */
    private String mngrId;
    /** 담당자 이름 */
    private String mngrNm;
    /** 담당자 비밀번호 */
    private String mngrPassword;
    /** 담당자 직위코드 */
    private Integer ofcpsCd = 0;
    /** 담당자 직위코드 */
    private String ofcpsCds;
    /** 담당자 직위명 */
    private String gradeNm;
    /** 언어코드 */
    private String langCode;
    /** 담당자 부서 코드 */
    private String deptCode;
    /** 담당자 부서 이름 */
    private String deptNm;
    /** 담당자 전화 번호 */
    private String telno;
    /** 담당자 팩스 번호 */
    private String fxnum;
    /** 담당자 핸드폰 번호 */
    private String mbtlnum;
    /** 담당자 이메일 주소 */
    private String email;
    /** 담당자 주요 업무 */
    private String chrgJob;

    /** 담당자 로그인 건수 */
    private Integer loginCnt = 0;
    /** 담당자 최종 로그인 일시 */
    private String loginDt;

    /** 할당 권한 */
    private List<MenuGrpVO> menuGrpCds;
    private String[] menuGrpCd;

    /** 사용 여부 - 미사용시 시스템 로그인이 거부됩니다. */
    private String useYn;
    /** 등록아이디 */
    private String regId;
    /** 담당자 등록일시 */
    private String regDt;
    /** 담당자 수정일시 */
    private String modiDt;
    /** 담당자 권한 코드 */
    private String authCode;
    /** 담당자 권한 코드s */
    private String authCds;
    /** 담당자 권한 명 */
    private String authNm;
    /** 담당자 권한 명s */
    private String[] authNms;
    /** 담당자 권한 구분 코드 */
    private String authTyCode;
    /** 담당자 권한 수 */
    private String authCnt;
    /** 할당 권한 명 */
    private String mngrMenuNm;
    /** 권한 구분 코드 */
    private String assignTyCode;

    private String modiId;

    /** Jquery Autocomplite 표시문자 설정 */
    private String label;
    /** Jquery Autocomplite 항목 선택시 설정값 */
    private String value;

    /**
     * String label을 반환
     * 
     * @return String label
     */
    public String getLabel() {
        return label;
    }

    /**
     * label을 설정
     * 
     * @param label 을(를) String label로 설정
     */
    public void setLabel(String label) {
        this.label = label;
    }

    /**
     * String value을 반환
     * 
     * @return String value
     */
    public String getValue() {
        return value;
    }

    /**
     * value을 설정
     * 
     * @param value 을(를) String value로 설정
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     * String authCds을 반환
     * 
     * @return String authCds
     */
    public String getAuthCds() {
        return authCds;
    }

    /**
     * authCds을 설정
     * 
     * @param authCds 을(를) String authCds로 설정
     */
    public void setAuthCds(String authCds) {
        this.authCds = authCds;
    }

    public String getMngrId() {
        return mngrId;
    }

    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    public String getMngrNm() {
        return mngrNm;
    }

    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    public String getGradeNm() {
        return gradeNm;
    }

    public void setGradeNm(String gradeNm) {
        this.gradeNm = gradeNm;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getLoginCnt() {
        return loginCnt;
    }

    public void setLoginCnt(Integer loginCnt) {
        this.loginCnt = loginCnt;
    }

    public String getLoginDt() {
        return loginDt;
    }

    public void setLoginDt(String loginDt) {
        this.loginDt = loginDt;
    }

    public List<MenuGrpVO> getMenuGrpCds() {
        return menuGrpCds;
    }

    public String getMngrMenuNm() {
        return mngrMenuNm;
    }

    public void setMngrMenuNm(String mngrMenuNm) {
        this.mngrMenuNm = mngrMenuNm;
    }

    public String getAssignTyCode() {
        return assignTyCode;
    }

    public void setAssignTyCode(String assignTyCode) {
        this.assignTyCode = assignTyCode;
    }

    public String getAuthCnt() {
        return authCnt;
    }

    public void setAuthCnt(String authCnt) {
        this.authCnt = authCnt;
    }

    public void setMenuGrpCds(List<MenuGrpVO> menuGrpCds) {
        this.menuGrpCds = menuGrpCds;
    }

    public String[] getMenuGrpCd() {
        return menuGrpCd;
    }

    public void setMenuGrpCd(String[] menuGrpCd) {
        this.menuGrpCd = menuGrpCd;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getModiDt() {
        return modiDt;
    }

    public void setModiDt(String modiDt) {
        this.modiDt = modiDt;
    }

    public String getAuthNm() {
        return authNm;
    }

    public void setAuthNm(String authNm) {
        this.authNm = authNm;
    }

    public String getModiId() {
        return modiId;
    }

    public void setModiId(String modiId) {
        this.modiId = modiId;
    }

    public String getMngrPassword() {
        return mngrPassword;
    }

    public void setMngrPassword(String mngrPassword) {
        this.mngrPassword = mngrPassword;
    }

    public Integer getOfcpsCd() {
        return ofcpsCd;
    }

    public void setOfcpsCd(Integer ofcpsCd) {
        this.ofcpsCd = ofcpsCd;
    }

    public String getOfcpsCds() {
        return ofcpsCds;
    }

    public void setOfcpsCds(String ofcpsCds) {
        this.ofcpsCds = ofcpsCds;
    }

    public String getDeptCode() {
        return deptCode;
    }

    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }

    public String getTelno() {
        return telno;
    }

    public void setTelno(String telno) {
        this.telno = telno;
    }

    public String getFxnum() {
        return fxnum;
    }

    public void setFxnum(String fxnum) {
        this.fxnum = fxnum;
    }

    public String getMbtlnum() {
        return mbtlnum;
    }

    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    public String getChrgJob() {
        return chrgJob;
    }

    public void setChrgJob(String chrgJob) {
        this.chrgJob = chrgJob;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public String getAuthTyCode() {
        return authTyCode;
    }

    public void setAuthTyCode(String authTyCode) {
        this.authTyCode = authTyCode;
    }

    /**
     * String[] authNms을 반환
     * 
     * @return String[] authNms
     */
    public String[] getAuthNms() {
        return authNms;
    }

    /**
     * authNms을 설정
     * 
     * @param authNms 을(를) String[] authNms로 설정
     */
    public void setAuthNms(String[] authNms) {
        this.authNms = authNms;
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
     * String regId을 반환
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * regId을 설정
     * @param regId 을(를) String regId로 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }
}
