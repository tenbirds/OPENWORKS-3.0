/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.login;

import java.util.List;

import zes.base.vo.SessVO;

/**
 * 관리자 로그인 정보 VO 객체
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 4. 30.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class UserLoginVO extends SessVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -1251326348198211677L;

    /** 사용자아이디 */
    private String userId;
    /** 언어코드 */
    private String langCode;
    /** 국가코드 */
    private String nationCode;
    /** 사용자비밀번호 */
    private String userPassword;
    /** 이전비밀번호 */
    private String beforePassword;
    /** 사용자명 */
    private String userNm;
    /** 이메일 */
    private String email;
    /** 가입유형 */
    private Integer sbscrbTyCd;
    /** 국제전화번호 */
    private String intrlTelno;
    /** 전화번호 */
    private String telno;
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
    /** 사용자등급코드 */
    private String userGradCode;
    /** 사용자상태 */
    private Integer userSttusCd;
    /** 비밀번호수정일자 */
    private String passwordChangeDe;
    /** 사용자KEY */
    private String userKey;
    /** 중복가입방지키 */
    private String dplctSbscrbPrvnKey;
    /** 가입사이트구분코드 */
    private Integer sbscrbSiteSeCd;
    /** 휴대폰번호 */
    private String mbtlnum;
    /** 생년월일 */
    private String brthdy;
    /** 성별코드 */
    private Integer sexdstnCd;
    /** 양력음력윤달코드 */
    private Integer slrcldLrrLpnhCd;
    /** 사업자등록번호 */
    private String bizrno;
    /** 커뮤니티운영자여부 */
    private String cmAdmYn;
    /** 커뮤니티목록 */
    @SuppressWarnings("rawtypes")
    private List cmInfoList;
    /** 아이디찾기타입 */
    private String idFindTy;
    /** 아이디찾기회원유형 */
    private String idUserTy;
    /** 유효한 ID 여부 */
    private boolean isValidId = false;
    /** 유효한 비밀번호 여부 */
    private boolean isValidPwd = false;
    /** 사업자번호인증 회사명 */
    private String cmpnyNm;
    /** 약관등록여부(Y/N) */
    private String stplatAgreAt;
    /** 약관등록일시 */
    private String stplatAgreDt;
    
    private String buseoCode;


    /** 구매기록 체크값 */
    private String memChk;

    /** 수요조사담당자여부 */
    private String dmandExaminChargerAt;

    /** 공급자 신청 상태 코드 **/
    private int agremStatCd;
    
    private String masterId;
    
    /* 기관담당자 기관정보 업데이트 여부 : 기관회원옵션의 기관코드가 기관정보테이블의 정보와 맞지 않으면 Y 를 반환 정보수정을 하도록 유도 */
    private String pblinsttUpdtAt;

    /**
     * String stplatAgreAt을 반환
     * @return String stplatAgreAt
     */
    public String getStplatAgreAt() {
        return stplatAgreAt;
    }


    /**
     * stplatAgreAt을 설정
     * @param stplatAgreAt 을(를) String stplatAgreAt로 설정
     */
    public void setStplatAgreAt(String stplatAgreAt) {
        this.stplatAgreAt = stplatAgreAt;
    }


    /**
     * String stplatAgreDt을 반환
     * @return String stplatAgreDt
     */
    public String getStplatAgreDt() {
        return stplatAgreDt;
    }


    /**
     * stplatAgreDt을 설정
     * @param stplatAgreDt 을(를) String stplatAgreDt로 설정
     */
    public void setStplatAgreDt(String stplatAgreDt) {
        this.stplatAgreDt = stplatAgreDt;
    }

    public String getUserId() {
        return cleanScript(userId);
    }

    public void setUserId(String userId) {
        this.userId = cleanScript(userId);
    }

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
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

    public String getUserNm() {
        return cleanScript(userNm);
    }

    public void setUserNm(String userNm) {
        this.userNm = cleanScript(userNm);
    }

    public String getEmail() {
        return cleanScript(email);
    }

    public void setEmail(String email) {
        this.email = cleanScript(email);
    }

    public Integer getSbscrbTyCd() {
        return sbscrbTyCd;
    }

    public void setSbscrbTyCd(Integer sbscrbTyCd) {
        this.sbscrbTyCd = sbscrbTyCd;
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
        return cleanScript(registDt);
    }

    public void setRegistDt(String registDt) {
        this.registDt = cleanScript(registDt);
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

    public String getUserGradCode() {
        return userGradCode;
    }

    public void setUserGradCode(String userGradCode) {
        this.userGradCode = userGradCode;
    }

    public Integer getUserSttusCd() {
        return userSttusCd;
    }

    public void setUserSttusCd(Integer userSttusCd) {
        this.userSttusCd = userSttusCd;
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

    public String getDplctSbscrbPrvnKey() {
        return dplctSbscrbPrvnKey;
    }

    public void setDplctSbscrbPrvnKey(String dplctSbscrbPrvnKey) {
        this.dplctSbscrbPrvnKey = dplctSbscrbPrvnKey;
    }

    public Integer getSbscrbSiteSeCd() {
        return sbscrbSiteSeCd;
    }

    public void setSbscrbSiteSeCd(Integer sbscrbSiteSeCd) {
        this.sbscrbSiteSeCd = sbscrbSiteSeCd;
    }

    public boolean isValidId() {
        return isValidId;
    }

    public void setValidId(boolean isValidId) {
        this.isValidId = isValidId;
    }

    public boolean isValidPwd() {
        return isValidPwd;
    }

    public void setValidPwd(boolean isValidPwd) {
        this.isValidPwd = isValidPwd;
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
        this.brthdy = cleanScript(brthdy);
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

    /**
     * String bizrno을 반환
     * @return String bizrno
     */
    public String getBizrno() {
        return bizrno;
    }

    /**
     * bizrno을 설정
     * @param bizrno 을(를) String bizrno로 설정
     */
    public void setBizrno(String bizrno) {
        this.bizrno = bizrno;
    }

    /**
     * String cmAdmYn을 반환
     * @return String cmAdmYn
     */
    public String getCmAdmYn() {
        return cmAdmYn;
    }

    /**
     * cmAdmYn을 설정
     * @param cmAdmYn 을(를) String cmAdmYn로 설정
     */
    public void setCmAdmYn(String cmAdmYn) {
        this.cmAdmYn = cmAdmYn;
    }

    /**
     * List cmInfoList을 반환
     * @return List cmInfoList
     */
    @SuppressWarnings("rawtypes")
    public List getCmInfoList() {
        return cmInfoList;
    }

    /**
     * cmInfoList을 설정
     * @param cmInfoList 을(를) List cmInfoList로 설정
     */
    @SuppressWarnings("rawtypes")
    public void setCmInfoList(List cmInfoList) {
        this.cmInfoList = cmInfoList;
    }

    /**
     * String idFindTy을 반환
     * @return String idFindTy
     */
    public String getIdFindTy() {
        return idFindTy;
    }

    /**
     * idFindTy을 설정
     * @param idFindTy 을(를) String idFindTy로 설정
     */
    public void setIdFindTy(String idFindTy) {
        this.idFindTy = idFindTy;
    }

    /**
     * String beforePassword을 반환
     * @return String beforePassword
     */
    public String getBeforePassword() {
        return beforePassword;
    }

    /**
     * beforePassword을 설정
     * @param beforePassword 을(를) String beforePassword로 설정
     */
    public void setBeforePassword(String beforePassword) {
        this.beforePassword = beforePassword;
    }

    /**
     * String idUserTy을 반환
     * @return String idUserTy
     */
    public String getIdUserTy() {
        return idUserTy;
    }

    /**
     * idUserTy을 설정
     * @param idUserTy 을(를) String idUserTy로 설정
     */
    public void setIdUserTy(String idUserTy) {
        this.idUserTy = idUserTy;
    }

    /**
     * String cmpnyNm을 반환
     * @return String cmpnyNm
     */
    public String getCmpnyNm() {
        return cmpnyNm;
    }

    /**
     * cmpnyNm을 설정
     * @param cmpnyNm 을(를) String cmpnyNm로 설정
     */
    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }




    /**
     * String memChk을 반환
     * @return String memChk
     */
    public String getMemChk() {
        return memChk;
    }



    /**
     * memChk을 설정
     * @param memChk 을(를) String memChk로 설정
     */
    public void setMemChk(String memChk) {
        this.memChk = memChk;
    }



    /**
     * JavaScript를 구동 시킬수 있는 <script /> 태그를 치환
     *
     * @param content
     * @param target
     * @param replace
     * @return
     */
    private static String[] SCRIPT = new String[] { "script", "</script>" };
    private static String[] NO_SCRIPT = new String[] { "ncript", "</ncript>" };

    private static String cleanScript(String content) {

        String cont = content.toLowerCase();
        int scriptCnt = SCRIPT.length;
        for(int i = 0 ; i < scriptCnt ; i++) {

            String target = SCRIPT[i];
            String replace = NO_SCRIPT[i];

            StringBuilder sb = new StringBuilder();

            int prePos = 0;
            int nxtPos = 0;
            int targetLength = target.length();
            while(nxtPos > -1) {
                nxtPos = cont.indexOf(target, prePos);

                if(nxtPos > -1) {
                    sb.append(content.substring(prePos, nxtPos));
                    sb.append(replace);

                    prePos = nxtPos + targetLength;
                }
            }

            int contLen = cont.length();
            if(prePos < contLen) {
                sb.append(content.substring(prePos));
            }

            content = sb.toString();
        }

        return content;
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
     * String masterId을 반환
     * @return String masterId
     */
    public String getMasterId() {
        return masterId;
    }


    
    /**
     * masterId을 설정
     * @param masterId 을(를) String masterId로 설정
     */
    public void setMasterId(String masterId) {
        this.masterId = masterId;
    }


    
    /**
     * String pblinsttUpdtAt을 반환
     * @return String pblinsttUpdtAt
     */
    public String getPblinsttUpdtAt() {
        return pblinsttUpdtAt;
    }


    
    /**
     * pblinsttUpdtAt을 설정
     * @param pblinsttUpdtAt 을(를) String pblinsttUpdtAt로 설정
     */
    public void setPblinsttUpdtAt(String pblinsttUpdtAt) {
        this.pblinsttUpdtAt = pblinsttUpdtAt;
    }


    /**
     * String buseoCode을 반환
     * @return String buseoCode
     */
    public String getBuseoCode() {
        return buseoCode;
    }


    /**
     * buseoCode을 설정
     * @param buseoCode 을(를) String buseoCode로 설정
     */
    public void setBuseoCode(String buseoCode) {
        this.buseoCode = buseoCode;
    }

    
    
}
