package zes.openworks.intra.user;

import java.util.List;
import java.util.Map;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.Email;

public class UserVO extends PaggingVO {

    static final long serialVersionUID = -844244739945971999L;

    /** 사용자아이디 */
    private String userId;
    /** 언어코드 */
    private String langCode = "00";
    /** 언어명 */
    private String langNm;
    /** 국가코드 */
    private String nationCode;
    /** 사용자비밀번호 */
    private String userPassword;
    /** 이전비밀번호 */
    private String newPassword;
    /** 사용자명 */
    private String userNm;
    /** 이메일 */
    @Email
    private String email;
    /** 가입유형코드 */
    private Integer sbscrbTyCd;
    /** 가입유형이름 */
    private String sbscrbTyNm;
    /** 국제전화번호 */
    private String intrlTelno;
    /** 전화번호 */
    private String telno;
    /** 내선번호 */
    private String lxtnTelno;
    /** 우편번호 */
    private String zip;
    /** 기본주소 */
    private String bassAdres;
    /** 상세주소 */
    private String detailAdres;
    /** 등록자아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정자아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 최근로그인일시 */
    private String recentLoginDt;
    /** 로그인카운트 */
    private Integer loginCnt;
    /** 사용자유형코드 */
    private Integer userTyCd;
    /** 사용자유형이름 */
    private String userTyNm;
    /** 사용자등급코드 */
    private String userGradCode;
    /** 사용자등급명 */
    private String userGradNm;
    /** 사용자상태 */
    private Integer userSttusCd = 1001;
    /** 사용자상태명 */
    private String userSttusNm;
    /** 비밀번호수정일자 */
    private String passwordChangeDe;
    /** 사용자KEY */
    private String userKey;
    /** 중복가입방지키 */
    private String dplctSbscrbIndvdlznKey;
    /** 휴대폰번호 */
    private String mbtlnum;
    /** 생년월일 */
    private String brthdy;
    /** 성별코드 */
    private Integer sexdstnCd;
    private String sexdstnNm;
    /** 양력음력윤달코드 */
    private Integer slrcldLrrLpnhCd;
    /** 가입사이트구분코드 */
    private Integer sbscrbSiteSeCd;
    /** 활동레벨코드 */
    private Integer actLevelCd;
    /** 활동레벨이름 */
    private String actLevelNm;
    /** 탈퇴일 */
    private String secsnDt;
    
    /** 공급자 신청 상태 코드 **/
    private int agremStatCd;
    
    /** SMS수신동의가부 */
    private Integer smsRecptnAgreCd;
    private String smsRecptnAgreNm;
    /** 이메일수신동의가부 */
    private Integer emailRecptnAgreCd;
    private String emailRecptnAgreNm;

    /** 이메일수신동의코드(뉴스레터/세미나) 추가. 2015-10-23 */
    private Integer nsletRecptnAgreCd;
    private String  nsletRecptnAgreNm;
    /** 이메일수신동의코드(입찰공고) 추가. 2015-10-23 */
    private Integer bidRecptnAgreCd;
    private String  bidRecptnAgreNm;

    /** 회사명 */
    private String cmpnyNm;
    /** 회사우편번호 */
    private String cmpnyZip;
    /** 회사기본주소 */
    private String cmpnyBassAdres;
    /** 회사상세주소 */
    private String cmpnyDetailAdres;
    /** 회사전화번호 */
    private String cmpnyTelno;
    /** 회사대표자명 */
    private String cmpnyRprsntvNm;
    /** 사업자등록번호 */
    private String bizrno;
    /** 회사대표전화번호 */
    private String cmpnyReprsntTelno;
    /** 회사팩스번호 */
    private String cmpnyFaxnum;
    /** 회사이메일 */
    private String cmpnyEmail;
    /** 회사URL */
    private String cmpnyUrl;
    /** 회사내선전화번호 */
    private Integer cmpnyLxtnTelno;
    /** FAX수신동의가부 */
    private Integer faxRecptnAgreCd;
    private String faxRecptnAgreNm;
    /** 회사 이메일 수신동의가부 */
    private String cmpnyEmailRecptnAgreCd;

    /** 스토어 언어코드 */
    private String storeLangCode;
    /** 스토어 언어코드 배열 */
    private String[] storeLangCodes;
    /** 언어별상점명 */
    private String langStoreNm;
    /** 언어별상점명 배열 */
    private String[] langStoreNms;
    /** 언어별상점소개 */
    private String langStoreIntrcn;
    /** 언어별상점소개 배열 */
    private String[] langStoreIntrcns;
    /** 상점URL */
    private String storeUrl;
    /** 상점URL 배열 */
    private String[] storeUrls;
    /** 대표전화번호 */
    private String reprsntTelno;
    /** 대표전화번호 배열 */
    private String[] reprsntTelnos;
    /** 대표이메일 */
    private String reprsntEmail;
    /** 대표이메일 배열 */
    private String[] reprsntEmails;
    /** 상점담당자명 */
    private String storeChargerNm;
    /** 상점담당자명 배열 */
    private String[] storeChargerNms;
    /** 상점이미지파일일련 */
    private Integer storeImageFileSeq = -1;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 상점활성여부(Y:활성,N:비활성) */
    private String storeActvtyAt;
    private String[] storeActvtyAts;

    /** 전체회원수 */
    private Integer totalUserCnt;
    /** 금일가입회원수 */
    private Integer todayRegUserCnt;
    /** 전체탈퇴회원수 */
    private Integer totalUserStateNCnt;

    /** 관심항목고유번호 */
    private Integer seq;

    /** UserVO List */
    private List<UserVO> userList;

    /** int Type 검색인자 */
    private Integer[] q_searchKey0;
    private Integer[] q_searchKey1;

    /** 목록에서 쓸 스토어목록담을 배열 */
    /* 20150728 스토어 이름과 함께 조회 하도록 수정 시작 */
    private List<Map<String, Object>> userstore;
    /* 20150728 스토어 이름과 함께 조회 하도록 수정 끝 */

    /** 문의하기게시판 신고건수 */
    private Integer accuseAtCdCnt;

    /** 관심카테고리 */
    private String ctgryCode;
    private String[] ctgryCodes;
    private List<Map<String, String>> ctgryList;

    /*============= 수요조사 담당자 여부 추가 START =================*/
    private String dmandExaminChargerAt;
    /*============= 수요조사 담당자 여부 추가 END =================*/

    /*============= 공공기관 옵션 추가 START =================*/
    /** 공공기관 코드 */
    private Integer pblinsttCd;
    /** 공공기관 명 */
    private String pblinsttNm;
    /** 공공기관 홈페이지URL */
    private String pblinsttUrl;
    /** 공공기관 우편번호 */
    private String pblinsttZip;
    /** 공공기관 기본주소 */
    private String pblinsttBassAdres;
    /** 공공기관 상세주소 */
    private String pblinsttDetailAdres;
    /** 공공기관 코드 : 기관정보 이름 */
    private String orgnNm;
    /** 공공기관 코드 : 기관정보 부서*/
    private String orgnNmSt;
    /** 공공기관 담당자 전호 */
    private String pblinsttTelno;
    /*============= 공공기관 옵션 추가 END =================*/

    public String getUserId() {
        return userId;
    }

    
    /**
     * String dmandExaminChargerAt을 반환
     * @return String dmandExaminChargerAt
     */
    public String getDmandExaminChargerAt() {
        return dmandExaminChargerAt;
    }


    /**
     * dmandExaminChargerAt을 설정
     * @param dmandExaminChargerAt 을(를) String dmandExaminChargerAt로 설정
     */
    public void setDmandExaminChargerAt(String dmandExaminChargerAt) {
        this.dmandExaminChargerAt = dmandExaminChargerAt;
    }


    /**
     * Integer pblinsttCd을 반환
     * @return Integer pblinsttCd
     */
    public Integer getPblinsttCd() {
        return pblinsttCd;
    }


    /**
     * pblinsttCd을 설정
     * @param pblinsttCd 을(를) Integer pblinsttCd로 설정
     */
    public void setPblinsttCd(Integer pblinsttCd) {
        this.pblinsttCd = pblinsttCd;
    }


    /**
     * String pblinsttNm을 반환
     * @return String pblinsttNm
     */
    public String getPblinsttNm() {
        return pblinsttNm;
    }


    /**
     * pblinsttNm을 설정
     * @param pblinsttNm 을(를) String pblinsttNm로 설정
     */
    public void setPblinsttNm(String pblinsttNm) {
        this.pblinsttNm = pblinsttNm;
    }


    /**
     * String pblinsttUrl을 반환
     * @return String pblinsttUrl
     */
    public String getPblinsttUrl() {
        return pblinsttUrl;
    }


    /**
     * pblinsttUrl을 설정
     * @param pblinsttUrl 을(를) String pblinsttUrl로 설정
     */
    public void setPblinsttUrl(String pblinsttUrl) {
        this.pblinsttUrl = pblinsttUrl;
    }


    /**
     * String pblinsttZip을 반환
     * @return String pblinsttZip
     */
    public String getPblinsttZip() {
        return pblinsttZip;
    }


    /**
     * pblinsttZip을 설정
     * @param pblinsttZip 을(를) String pblinsttZip로 설정
     */
    public void setPblinsttZip(String pblinsttZip) {
        this.pblinsttZip = pblinsttZip;
    }


    /**
     * String pblinsttBassAdres을 반환
     * @return String pblinsttBassAdres
     */
    public String getPblinsttBassAdres() {
        return pblinsttBassAdres;
    }


    /**
     * pblinsttBassAdres을 설정
     * @param pblinsttBassAdres 을(를) String pblinsttBassAdres로 설정
     */
    public void setPblinsttBassAdres(String pblinsttBassAdres) {
        this.pblinsttBassAdres = pblinsttBassAdres;
    }


    /**
     * String pblinsttDetailAdres을 반환
     * @return String pblinsttDetailAdres
     */
    public String getPblinsttDetailAdres() {
        return pblinsttDetailAdres;
    }


    /**
     * pblinsttDetailAdres을 설정
     * @param pblinsttDetailAdres 을(를) String pblinsttDetailAdres로 설정
     */
    public void setPblinsttDetailAdres(String pblinsttDetailAdres) {
        this.pblinsttDetailAdres = pblinsttDetailAdres;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public String getLangNm() {
        return langNm;
    }

    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    public String getNationCode() {
        return nationCode;
    }

    public void setNationCode(String nationCode) {
        this.nationCode = nationCode;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getSbscrbTyCd() {
        return sbscrbTyCd;
    }

    public void setSbscrbTyCd(Integer sbscrbTyCd) {
        this.sbscrbTyCd = sbscrbTyCd;
    }

    public String getSbscrbTyNm() {
        return sbscrbTyNm;
    }

    public void setSbscrbTyNm(String sbscrbTyNm) {
        this.sbscrbTyNm = sbscrbTyNm;
    }

    public String getIntrlTelno() {
        return intrlTelno;
    }

    public void setIntrlTelno(String intrlTelno) {
        this.intrlTelno = intrlTelno;
    }

    public String getTelno() {
        return telno;
    }

    public void setTelno(String telno) {
        this.telno = telno;
    }

    public String getLxtnTelno() {
        return lxtnTelno;
    }

    public void setLxtnTelno(String lxtnTelno) {
        this.lxtnTelno = lxtnTelno;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    public String getBassAdres() {
        return bassAdres;
    }

    public void setBassAdres(String bassAdres) {
        this.bassAdres = bassAdres;
    }

    public String getDetailAdres() {
        return detailAdres;
    }

    public void setDetailAdres(String detailAdres) {
        this.detailAdres = detailAdres;
    }

    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getRegistDt() {
        return registDt;
    }

    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    public String getUpdtId() {
        return updtId;
    }

    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    public String getRecentLoginDt() {
        return recentLoginDt;
    }

    public void setRecentLoginDt(String recentLoginDt) {
        this.recentLoginDt = recentLoginDt;
    }

    public Integer getLoginCnt() {
        return loginCnt;
    }

    public void setLoginCnt(Integer loginCnt) {
        this.loginCnt = loginCnt;
    }

    public Integer getUserTyCd() {
        return userTyCd;
    }

    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }

    public String getUserTyNm() {
        return userTyNm;
    }

    public void setUserTyNm(String userTyNm) {
        this.userTyNm = userTyNm;
    }

    public String getUserGradCode() {
        return userGradCode;
    }

    public void setUserGradCode(String userGradCode) {
        this.userGradCode = userGradCode;
    }

    public String getUserGradNm() {
        return userGradNm;
    }

    public void setUserGradNm(String userGradNm) {
        this.userGradNm = userGradNm;
    }

    public Integer getUserSttusCd() {
        return userSttusCd;
    }

    public void setUserSttusCd(Integer userSttusCd) {
        this.userSttusCd = userSttusCd;
    }

    public String getUserSttusNm() {
        return userSttusNm;
    }

    public void setUserSttusNm(String userSttusNm) {
        this.userSttusNm = userSttusNm;
    }

    public String getPasswordChangeDe() {
        return passwordChangeDe;
    }

    public void setPasswordChangeDe(String passwordChangeDe) {
        this.passwordChangeDe = passwordChangeDe;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getDplctSbscrbIndvdlznKey() {
        return dplctSbscrbIndvdlznKey;
    }

    public void setDplctSbscrbIndvdlznKey(String dplctSbscrbIndvdlznKey) {
        this.dplctSbscrbIndvdlznKey = dplctSbscrbIndvdlznKey;
    }

    public String getMbtlnum() {
        return mbtlnum;
    }

    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }

    public String getBrthdy() {
        return brthdy;
    }

    public void setBrthdy(String brthdy) {
        this.brthdy = brthdy;
    }

    public Integer getSexdstnCd() {
        return sexdstnCd;
    }

    public void setSexdstnCd(Integer sexdstnCd) {
        this.sexdstnCd = sexdstnCd;
    }

    public Integer getSlrcldLrrLpnhCd() {
        return slrcldLrrLpnhCd;
    }

    public void setSlrcldLrrLpnhCd(Integer slrcldLrrLpnhCd) {
        this.slrcldLrrLpnhCd = slrcldLrrLpnhCd;
    }

    public Integer getSbscrbSiteSeCd() {
        return sbscrbSiteSeCd;
    }

    public void setSbscrbSiteSeCd(Integer sbscrbSiteSeCd) {
        this.sbscrbSiteSeCd = sbscrbSiteSeCd;
    }

    public Integer getActLevelCd() {
        return actLevelCd;
    }

    public void setActLevelCd(Integer actLevelCd) {
        this.actLevelCd = actLevelCd;
    }

    public String getActLevelNm() {
        return actLevelNm;
    }

    public void setActLevelNm(String actLevelNm) {
        this.actLevelNm = actLevelNm;
    }

    public String getSecsnDt() {
        return secsnDt;
    }

    public void setSecsnDt(String secsnDt) {
        this.secsnDt = secsnDt;
    }

    public Integer getSmsRecptnAgreCd() {
        return smsRecptnAgreCd;
    }

    public void setSmsRecptnAgreCd(Integer smsRecptnAgreCd) {
        this.smsRecptnAgreCd = smsRecptnAgreCd;
    }

    public Integer getEmailRecptnAgreCd() {
        return emailRecptnAgreCd;
    }

    public void setEmailRecptnAgreCd(Integer emailRecptnAgreCd) {
        this.emailRecptnAgreCd = emailRecptnAgreCd;
    }

    /** 2015-10-23 추가 */
    public Integer getNsletRecptnAgreCd() {
        return nsletRecptnAgreCd;
    }

    public void setNsletRecptnAgreCd(Integer nsletRecptnAgreCd) {
        this.nsletRecptnAgreCd = nsletRecptnAgreCd;
    }

    public Integer getBidRecptnAgreCd() {
        return bidRecptnAgreCd;
    }

    public void setBidRecptnAgreCd(Integer bidRecptnAgreCd) {
        this.bidRecptnAgreCd = bidRecptnAgreCd;
    }
    /** 2015-10-23 추가 끝 */

    public String getCmpnyNm() {
        return cmpnyNm;
    }

    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    public String getCmpnyZip() {
        return cmpnyZip;
    }

    public void setCmpnyZip(String cmpnyZip) {
        this.cmpnyZip = cmpnyZip;
    }

    public String getCmpnyBassAdres() {
        return cmpnyBassAdres;
    }

    public void setCmpnyBassAdres(String cmpnyBassAdres) {
        this.cmpnyBassAdres = cmpnyBassAdres;
    }

    public String getCmpnyDetailAdres() {
        return cmpnyDetailAdres;
    }

    public void setCmpnyDetailAdres(String cmpnyDetailAdres) {
        this.cmpnyDetailAdres = cmpnyDetailAdres;
    }

    public String getCmpnyTelno() {
        return cmpnyTelno;
    }

    public void setCmpnyTelno(String cmpnyTelno) {
        this.cmpnyTelno = cmpnyTelno;
    }

    public String getCmpnyRprsntvNm() {
        return cmpnyRprsntvNm;
    }

    public void setCmpnyRprsntvNm(String cmpnyRprsntvNm) {
        this.cmpnyRprsntvNm = cmpnyRprsntvNm;
    }

    public String getBizrno() {
        return bizrno;
    }

    public void setBizrno(String bizrno) {
        this.bizrno = bizrno;
    }

    public String getCmpnyReprsntTelno() {
        return cmpnyReprsntTelno;
    }

    public void setCmpnyReprsntTelno(String cmpnyReprsntTelno) {
        this.cmpnyReprsntTelno = cmpnyReprsntTelno;
    }

    public String getCmpnyFaxnum() {
        return cmpnyFaxnum;
    }

    public void setCmpnyFaxnum(String cmpnyFaxnum) {
        this.cmpnyFaxnum = cmpnyFaxnum;
    }

    public String getCmpnyEmail() {
        return cmpnyEmail;
    }

    public void setCmpnyEmail(String cmpnyEmail) {
        this.cmpnyEmail = cmpnyEmail;
    }

    public String getCmpnyUrl() {
        return cmpnyUrl;
    }

    public void setCmpnyUrl(String cmpnyUrl) {
        this.cmpnyUrl = cmpnyUrl;
    }

    public Integer getCmpnyLxtnTelno() {
        return cmpnyLxtnTelno;
    }

    public void setCmpnyLxtnTelno(Integer cmpnyLxtnTelno) {
        this.cmpnyLxtnTelno = cmpnyLxtnTelno;
    }

    public Integer getFaxRecptnAgreCd() {
        return faxRecptnAgreCd;
    }

    public void setFaxRecptnAgreCd(Integer faxRecptnAgreCd) {
        this.faxRecptnAgreCd = faxRecptnAgreCd;
    }

    public String getCmpnyEmailRecptnAgreCd() {
        return cmpnyEmailRecptnAgreCd;
    }

    public void setCmpnyEmailRecptnAgreCd(String cmpnyEmailRecptnAgreCd) {
        this.cmpnyEmailRecptnAgreCd = cmpnyEmailRecptnAgreCd;
    }

    public String getStoreLangCode() {
        return storeLangCode;
    }

    public void setStoreLangCode(String storeLangCode) {
        this.storeLangCode = storeLangCode;
    }

    public String[] getStoreLangCodes() {
        return storeLangCodes;
    }

    public void setStoreLangCodes(String[] storeLangCodes) {
        this.storeLangCodes = storeLangCodes;
    }

    public String getLangStoreNm() {
        return langStoreNm;
    }

    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    public String[] getLangStoreNms() {
        return langStoreNms;
    }

    public void setLangStoreNms(String[] langStoreNms) {
        this.langStoreNms = langStoreNms;
    }

    public String getLangStoreIntrcn() {
        return langStoreIntrcn;
    }

    public void setLangStoreIntrcn(String langStoreIntrcn) {
        this.langStoreIntrcn = langStoreIntrcn;
    }

    public String[] getLangStoreIntrcns() {
        return langStoreIntrcns;
    }

    public void setLangStoreIntrcns(String[] langStoreIntrcns) {
        this.langStoreIntrcns = langStoreIntrcns;
    }

    public String getStoreUrl() {
        return storeUrl;
    }

    public void setStoreUrl(String storeUrl) {
        this.storeUrl = storeUrl;
    }

    public String[] getStoreUrls() {
        return storeUrls;
    }

    public void setStoreUrls(String[] storeUrls) {
        this.storeUrls = storeUrls;
    }

    public String getReprsntTelno() {
        return reprsntTelno;
    }

    public void setReprsntTelno(String reprsntTelno) {
        this.reprsntTelno = reprsntTelno;
    }

    public String[] getReprsntTelnos() {
        return reprsntTelnos;
    }

    public void setReprsntTelnos(String[] reprsntTelnos) {
        this.reprsntTelnos = reprsntTelnos;
    }

    public String getReprsntEmail() {
        return reprsntEmail;
    }

    public void setReprsntEmail(String reprsntEmail) {
        this.reprsntEmail = reprsntEmail;
    }

    public String[] getReprsntEmails() {
        return reprsntEmails;
    }

    public void setReprsntEmails(String[] reprsntEmails) {
        this.reprsntEmails = reprsntEmails;
    }

    public String getStoreChargerNm() {
        return storeChargerNm;
    }

    public void setStoreChargerNm(String storeChargerNm) {
        this.storeChargerNm = storeChargerNm;
    }

    public String[] getStoreChargerNms() {
        return storeChargerNms;
    }

    public void setStoreChargerNms(String[] storeChargerNms) {
        this.storeChargerNms = storeChargerNms;
    }

    public Integer getStoreImageFileSeq() {
        return storeImageFileSeq;
    }

    public void setStoreImageFileSeq(Integer storeImageFileSeq) {
        this.storeImageFileSeq = storeImageFileSeq;
    }

    public List<FileVO> getFileList() {
        return fileList;
    }

    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    public String getStoreActvtyAt() {
        return storeActvtyAt;
    }

    public void setStoreActvtyAt(String storeActvtyAt) {
        this.storeActvtyAt = storeActvtyAt;
    }

    public String[] getStoreActvtyAts() {
        return storeActvtyAts;
    }

    public void setStoreActvtyAts(String[] storeActvtyAts) {
        this.storeActvtyAts = storeActvtyAts;
    }

    public Integer getTotalUserCnt() {
        return totalUserCnt;
    }

    public void setTotalUserCnt(Integer totalUserCnt) {
        this.totalUserCnt = totalUserCnt;
    }

    public Integer getTodayRegUserCnt() {
        return todayRegUserCnt;
    }

    public void setTodayRegUserCnt(Integer todayRegUserCnt) {
        this.todayRegUserCnt = todayRegUserCnt;
    }

    public Integer getTotalUserStateNCnt() {
        return totalUserStateNCnt;
    }

    public void setTotalUserStateNCnt(Integer totalUserStateNCnt) {
        this.totalUserStateNCnt = totalUserStateNCnt;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public List<UserVO> getUserList() {
        return userList;
    }

    public void setUserList(List<UserVO> userList) {
        this.userList = userList;
    }

    public Integer[] getQ_searchKey0() {
        return q_searchKey0;
    }

    public void setQ_searchKey0(Integer[] q_searchKey0) {
        this.q_searchKey0 = q_searchKey0;
    }

    public Integer[] getQ_searchKey1() {
        return q_searchKey1;
    }

    public void setQ_searchKey1(Integer[] q_searchKey1) {
        this.q_searchKey1 = q_searchKey1;
    }

    /* 20150728 스토어 이름과 함께 조회 하도록 수정 시작 */
    public List<Map<String, Object>> getUserstore() {
        return userstore;
    }

    public void setUserstore(List<Map<String, Object>> userstore) {
        this.userstore = userstore;
    }
    /* 20150728 스토어 이름과 함께 조회 하도록 수정 끝 */

    public Integer getAccuseAtCdCnt() {
        return accuseAtCdCnt;
    }

    public void setAccuseAtCdCnt(Integer accuseAtCdCnt) {
        this.accuseAtCdCnt = accuseAtCdCnt;
    }

    public String getCtgryCode() {
        return ctgryCode;
    }

    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }

    public String[] getCtgryCodes() {
        return ctgryCodes;
    }

    public void setCtgryCodes(String[] ctgryCodes) {
        this.ctgryCodes = ctgryCodes;
    }

    public List<Map<String, String>> getCtgryList() {
        return ctgryList;
    }

    public void setCtgryList(List<Map<String, String>> ctgryList) {
        this.ctgryList = ctgryList;
    }

    public String getSexdstnNm() {
        return sexdstnNm;
    }

    public void setSexdstnNm(String sexdstnNm) {
        this.sexdstnNm = sexdstnNm;
    }

    public String getSmsRecptnAgreNm() {
        return smsRecptnAgreNm;
    }

    public void setSmsRecptnAgreNm(String smsRecptnAgreNm) {
        this.smsRecptnAgreNm = smsRecptnAgreNm;
    }

    public String getEmailRecptnAgreNm() {
        return emailRecptnAgreNm;
    }

    public void setEmailRecptnAgreNm(String emailRecptnAgreNm) {
        this.emailRecptnAgreNm = emailRecptnAgreNm;
    }

    /** 2015-10-23 추가 */
    public String getNsletRecptnAgreNm() {
        return nsletRecptnAgreNm;
    }

    public void setNsletRecptnAgreNm(String nsletRecptnAgreNm) {
        this.nsletRecptnAgreNm = nsletRecptnAgreNm;
    }

    public String getBidRecptnAgreNm() {
        return bidRecptnAgreNm;
    }

    public void setBidRecptnAgreNm(String bidRecptnAgreNm) {
        this.bidRecptnAgreNm = bidRecptnAgreNm;
    }
    /** 2015-10-23 추가 끝 */

    public String getFaxRecptnAgreNm() {
        return faxRecptnAgreNm;
    }

    public void setFaxRecptnAgreNm(String faxRecptnAgreNm) {
        this.faxRecptnAgreNm = faxRecptnAgreNm;
    }


    /**
     * int agremStatCd을 반환
     * @return int agremStatCd
     */
    public int getAgremStatCd() {
        return agremStatCd;
    }


    /**
     * agremStatCd을 설정
     * @param agremStatCd 을(를) int agremStatCd로 설정
     */
    public void setAgremStatCd(int agremStatCd) {
        this.agremStatCd = agremStatCd;
    }


    
    /**
     * String orgnNm을 반환
     * @return String orgnNm
     */
    public String getOrgnNm() {
        return orgnNm;
    }


    
    /**
     * orgnNm을 설정
     * @param orgnNm 을(를) String orgnNm로 설정
     */
    public void setOrgnNm(String orgnNm) {
        this.orgnNm = orgnNm;
    }


    
    /**
     * String orgnNmSt을 반환
     * @return String orgnNmSt
     */
    public String getOrgnNmSt() {
        return orgnNmSt;
    }


    
    /**
     * orgnNmSt을 설정
     * @param orgnNmSt 을(를) String orgnNmSt로 설정
     */
    public void setOrgnNmSt(String orgnNmSt) {
        this.orgnNmSt = orgnNmSt;
    }


    
    /**
     * String pblinsttTelno을 반환
     * @return String pblinsttTelno
     */
    public String getPblinsttTelno() {
        return pblinsttTelno;
    }


    
    /**
     * pblinsttTelno을 설정
     * @param pblinsttTelno 을(를) String pblinsttTelno로 설정
     */
    public void setPblinsttTelno(String pblinsttTelno) {
        this.pblinsttTelno = pblinsttTelno;
    }

}
