/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.newsLetter;

/**
 * 
 *
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 * 수정일       수정자    수정내용
 * -----------  --------  -------------------------------
 * 2015. 8.24.  방기배    신규
 * 2015.10.30.  이창환    이메일종류(requestKind) 추가
 *</pre>
 * @see
 */
public class NewsLetterVO {
    private Integer emailCrtfcSeq;  //이메일인증일련번호
    private String  userNm;         //사용자명
    private String  email;          //이메일
    private String  crtfcReqstDt;   //인증신청일시
    private String  crtfcKeyValue;  //인증키값
    private Integer emailCrtfcYnCd; //이메일인증여부코드
    private String  langCode;       //언어코드
    private String  requestMode;    //RQST:뉴스레터 신청, CANCL:뉴스레터 취소
    private String  requestKind;    //EMAIL:광고홍보, NSLET:뉴스레터/세미나, BID:입찰공고

    /**
     * Integer emailCrtfcSeq을 반환
     * @return Integer emailCrtfcSeq
     */
    public Integer getEmailCrtfcSeq(){
        return emailCrtfcSeq;
    }

    /**
     * emailCrtfcSeq을 설정
     * @param emailCrtfcSeq 을(를) Integer emailCrtfcSeq로 설정
     */
    public void setEmailCrtfcSeq(Integer emailCrtfcSeq){
        this.emailCrtfcSeq = emailCrtfcSeq;
    }

    /**
     * String userNm을 반환
     * @return String userNm
     */
    public String getUserNm(){
        return userNm;
    }

    /**
     * userNm을 설정
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm){
        this.userNm = userNm;
    }

    /**
     * String email을 반환
     * @return String email
     */
    public String getEmail(){
        return email;
    }

    /**
     * email을 설정
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email){
        this.email = email;
    }

    /**
     * String crtfcReqstDt을 반환
     * @return String crtfcReqstDt
     */
    public String getCrtfcReqstDt(){
        return crtfcReqstDt;
    }

    /**
     * crtfcReqstDt을 설정
     * @param crtfcReqstDt 을(를) String crtfcReqstDt로 설정
     */
    public void setCrtfcReqstDt(String crtfcReqstDt){
        this.crtfcReqstDt = crtfcReqstDt;
    }

    /**
     * String crtfcKeyValue을 반환
     * @return String crtfcKeyValue
     */
    public String getCrtfcKeyValue(){
        return crtfcKeyValue;
    }

    /**
     * crtfcKeyValue을 설정
     * @param crtfcKeyValue 을(를) String crtfcKeyValue로 설정
     */
    public void setCrtfcKeyValue(String crtfcKeyValue){
        this.crtfcKeyValue = crtfcKeyValue;
    }

    /**
     * Integer emailCrtfcYnCd을 반환
     * @return Integer emailCrtfcYnCd
     */
    public Integer getEmailCrtfcYnCd(){
        return emailCrtfcYnCd;
    }

    /**
     * emailCrtfcYnCd을 설정
     * @param emailCrtfcYnCd 을(를) Integer emailCrtfcYnCd로 설정
     */
    public void setEmailCrtfcYnCd(Integer emailCrtfcYnCd){
        this.emailCrtfcYnCd = emailCrtfcYnCd;
    }

    /**
     * String langCode을 반환
     * @return String langCode
     */
    public String getLangCode(){
        return langCode;
    }

    /**
     * langCode을 설정
     * @param langCode 을(를) String langCode로 설정
     */
    public void setLangCode(String langCode){
        this.langCode = langCode;
    }

    /**
     * String requestMode을 반환
     * @return String requestMode
     */
    public String getRequestMode(){
        return requestMode;
    }

    /**
     * requestMode을 설정
     * @param requestMode 을(를) String requestMode로 설정
     */
    public void setRequestMode(String requestMode){
        this.requestMode = requestMode;
    }

    /**
     * String requestKind을 반환
     * @return String requestKind
     */
    public String getRequestKind(){
        return requestKind;
    }

    /**
     * requestKind을 설정
     * @param requestKind 을(를) String requestKind로 설정
     */
    public void setRequestKind(String requestKind){
        this.requestKind = requestKind;
    }
}