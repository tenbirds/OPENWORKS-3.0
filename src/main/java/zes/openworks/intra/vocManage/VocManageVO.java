/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.vocManage;

import zes.base.vo.PaggingVO;

/**
*
*
* @version 1.0
* @since
* @author
*<pre>
*<< 개정이력(Modification Information) >>
*
*    수정일       수정자   수정내용
*--------------  --------  -------------------------------
* 2017. 10. 23.   이준범   신규
*</pre>
* @see
*/
@SuppressWarnings("serial")
public class VocManageVO extends PaggingVO {
    /** voc 게시글 순번 */
    private Integer vocBbscttSn;
    
    /** 회원여부 */
    private String memberAt;

    /** 사용자명 */
    private String userNm;

    /** 기관 유형 이름 */
    private String insttTyNm;

    /** 소속기관 이름 */
    private String pstinstNm;

    /** 전화번호 */
    private String telno;

    /** voc 문의유형 */
    private String vocInqryTy;

    /** voc 진행상태 */
    private String vocProgressSttus;

    /** voc 문의내용 */
    private String vocInqryCn;

    /** voc 답변내용 */
    private String vocAnswerCn;

    /** 담당자 */
    private String vocCharger;

    /** 접수일자 */
    private String recptDe;

    /** 등록자 */
    private String registId;

    /** 등록일시 */
    private String registDt;

    /** 최근 수정자 */
    private String recentUpdtId;

    /** 최근 수정 일시 */
    private String recentUpdtDt;

    
    // auto make getter setter
    
    /**
     * Integer vocBbscttSn을 반환
     * @return Integer vocBbscttSn
     */
    public Integer getVocBbscttSn() {
        return vocBbscttSn;
    }

    
    /**
     * vocBbscttSn을 설정
     * @param vocBbscttSn 을(를) Integer vocBbscttSn로 설정
     */
    public void setVocBbscttSn(Integer vocBbscttSn) {
        this.vocBbscttSn = vocBbscttSn;
    }

    
    /**
     * String memberAt을 반환
     * @return String memberAt
     */
    public String getMemberAt() {
        return memberAt;
    }

    
    /**
     * memberAt을 설정
     * @param memberAt 을(를) String memberAt로 설정
     */
    public void setMemberAt(String memberAt) {
        this.memberAt = memberAt;
    }

    
    /**
     * String userNm을 반환
     * @return String userNm
     */
    public String getUserNm() {
        return userNm;
    }

    
    /**
     * userNm을 설정
     * @param userNm 을(를) String userNm로 설정
     */
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    
    /**
     * String insttTyNm을 반환
     * @return String insttTyNm
     */
    public String getInsttTyNm() {
        return insttTyNm;
    }

    
    /**
     * insttTyNm을 설정
     * @param insttTyNm 을(를) String insttTyNm로 설정
     */
    public void setInsttTyNm(String insttTyNm) {
        this.insttTyNm = insttTyNm;
    }

    
    /**
     * String pstinstNm을 반환
     * @return String pstinstNm
     */
    public String getPstinstNm() {
        return pstinstNm;
    }

    
    /**
     * pstinstNm을 설정
     * @param pstinstNm 을(를) String pstinstNm로 설정
     */
    public void setPstinstNm(String pstinstNm) {
        this.pstinstNm = pstinstNm;
    }

    
    /**
     * String telno을 반환
     * @return String telno
     */
    public String getTelno() {
        return telno;
    }

    
    /**
     * telno을 설정
     * @param telno 을(를) String telno로 설정
     */
    public void setTelno(String telno) {
        this.telno = telno;
    }

    
    /**
     * String vocInqryTy을 반환
     * @return String vocInqryTy
     */
    public String getVocInqryTy() {
        return vocInqryTy;
    }

    
    /**
     * vocInqryTy을 설정
     * @param vocInqryTy 을(를) String vocInqryTy로 설정
     */
    public void setVocInqryTy(String vocInqryTy) {
        this.vocInqryTy = vocInqryTy;
    }

    
    /**
     * String vocProgressSttus을 반환
     * @return String vocProgressSttus
     */
    public String getVocProgressSttus() {
        return vocProgressSttus;
    }

    
    /**
     * vocProgressSttus을 설정
     * @param vocProgressSttus 을(를) String vocProgressSttus로 설정
     */
    public void setVocProgressSttus(String vocProgressSttus) {
        this.vocProgressSttus = vocProgressSttus;
    }

    
    /**
     * String vocInqryCn을 반환
     * @return String vocInqryCn
     */
    public String getVocInqryCn() {
        return vocInqryCn;
    }

    
    /**
     * vocInqryCn을 설정
     * @param vocInqryCn 을(를) String vocInqryCn로 설정
     */
    public void setVocInqryCn(String vocInqryCn) {
        this.vocInqryCn = vocInqryCn;
    }

    
    /**
     * String vocAnswerCn을 반환
     * @return String vocAnswerCn
     */
    public String getVocAnswerCn() {
        return vocAnswerCn;
    }

    
    /**
     * vocAnswerCn을 설정
     * @param vocAnswerCn 을(를) String vocAnswerCn로 설정
     */
    public void setVocAnswerCn(String vocAnswerCn) {
        this.vocAnswerCn = vocAnswerCn;
    }

    
    /**
     * String vocCharger을 반환
     * @return String vocCharger
     */
    public String getVocCharger() {
        return vocCharger;
    }

    
    /**
     * vocCharger을 설정
     * @param vocCharger 을(를) String vocCharger로 설정
     */
    public void setVocCharger(String vocCharger) {
        this.vocCharger = vocCharger;
    }

    
    /**
     * String recptDe을 반환
     * @return String recptDe
     */
    public String getRecptDe() {
        return recptDe;
    }

    
    /**
     * recptDe을 설정
     * @param recptDe 을(를) String recptDe로 설정
     */
    public void setRecptDe(String recptDe) {
        this.recptDe = recptDe;
    }

    
    /**
     * String registId을 반환
     * @return String registId
     */
    public String getRegistId() {
        return registId;
    }

    
    /**
     * registId을 설정
     * @param registId 을(를) String registId로 설정
     */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    
    /**
     * String registDt을 반환
     * @return String registDt
     */
    public String getRegistDt() {
        return registDt;
    }

    
    /**
     * registDt을 설정
     * @param registDt 을(를) String registDt로 설정
     */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    
    /**
     * String recentUpdtId을 반환
     * @return String recentUpdtId
     */
    public String getRecentUpdtId() {
        return recentUpdtId;
    }

    
    /**
     * recentUpdtId을 설정
     * @param recentUpdtId 을(를) String recentUpdtId로 설정
     */
    public void setRecentUpdtId(String recentUpdtId) {
        this.recentUpdtId = recentUpdtId;
    }

    
    /**
     * String recentUpdtDt을 반환
     * @return String recentUpdtDt
     */
    public String getRecentUpdtDt() {
        return recentUpdtDt;
    }

    
    /**
     * recentUpdtDt을 설정
     * @param recentUpdtDt 을(를) String recentUpdtDt로 설정
     */
    public void setRecentUpdtDt(String recentUpdtDt) {
        this.recentUpdtDt = recentUpdtDt;
    }
}