package zes.openworks.intra.auth;

import zes.base.vo.BaseVO;

public class AuthVO extends BaseVO {

    private static final long serialVersionUID = -2898348011340429430L;

    private String authCode;
    private String upperAuthCode;
    private String authTyCode;
    private String authNm;
    private String authDc;
    private String useYn;
    private String registDt;
    private String registId;
    private String updtDt;
    private String updtId;

    private String regNm;
    private String modiNm;

    private Integer authPCnt;

    private String oldAuthCd;

    private String mngrId;
    private String mngrNm;

    private String mgrAssign;

    private String langCd;
    
    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public String getUpperAuthCode() {
        return upperAuthCode;
    }

    public void setUpperAuthCode(String upperAuthCode) {
        this.upperAuthCode = upperAuthCode;
    }

    public String getAuthTyCode() {
        return authTyCode;
    }

    public void setAuthTyCode(String authTyCode) {
        this.authTyCode = authTyCode;
    }

    public String getAuthNm() {
        return authNm;
    }

    public void setAuthNm(String authNm) {
        this.authNm = authNm;
    }

    public String getAuthDc() {
        return authDc;
    }

    public void setAuthDc(String authDc) {
        this.authDc = authDc;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegDtm() {
        return registDt;
    }

    public void setRegDtm(String registDt) {
        this.registDt = registDt;
    }

    public String getRegId() {
        return registId;
    }

    public void setRegId(String registId) {
        this.registId = registId;
    }

    public String getModiDtm() {
        return updtDt;
    }

    public void setModiDtm(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getModiId() {
        return updtId;
    }

    public void setModiId(String updtId) {
        this.updtId = updtId;
    }

    public String getRegNm() {
        return regNm;
    }

    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

    public String getModiNm() {
        return modiNm;
    }

    public void setModiNm(String modiNm) {
        this.modiNm = modiNm;
    }

    public Integer getAuthPCnt() {
        return authPCnt;
    }

    public void setAuthPCnt(Integer authPCnt) {
        this.authPCnt = authPCnt;
    }

    public String getOldAuthCd() {
        return oldAuthCd;
    }

    public void setOldAuthCd(String oldAuthCd) {
        this.oldAuthCd = oldAuthCd;
    }

    public String getMgrId() {
        return mngrId;
    }

    public void setMgrId(String mngrId) {
        this.mngrId = mngrId;
    }

    public String getMgrNm() {
        return mngrNm;
    }

    public void setMgrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    public String getMgrAssign() {
        return mgrAssign;
    }

    public void setMgrAssign(String mgrAssign) {
        this.mgrAssign = mgrAssign;
    }

    
    /**
     * String langCd을 반환
     * @return String langCd
     */
    public String getLangCd() {
        return langCd;
    }

    
    /**
     * langCd을 설정
     * @param langCd 을(를) String langCd로 설정
     */
    public void setLangCd(String langCd) {
        this.langCd = langCd;
    }

    @Override
    public String toString() {
        return "AuthVO [authCode=" + authCode + ", upperAuthCode=" + upperAuthCode
                + ", authTyCode=" + authTyCode + ", authNm=" + authNm
                + ", authDc=" + authDc + ", useYn=" + useYn + ", registDt="
                + registDt + ", registId=" + registId + ", updtDt=" + updtDt
                + ", updtId=" + updtId + ", regNm=" + regNm + ", modiNm="
                + modiNm + ", authPCnt=" + authPCnt + ", oldAuthCd="
                + oldAuthCd + ", mngrId=" + mngrId + ", mngrNm=" + mngrNm
                + ", mgrAssign=" + mgrAssign + "]";
    }

}
