/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.store;

import zes.openworks.intra.store.goods.GoodsManageVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2014. 11. 7.    이슬버미       신규
 * </pre>
 * @see
 */
public class StoreincVO extends GoodsManageVO {

    public enum MSG {
        LOGIN_FAIL, INSERT_OK, INSERT_CHK, UPDATE_OK, DELETE_OK
    }

    public static final int ASC_WAIT = 1001;
    public static final int ASC_COMPLET = 1002;
    
    public static final String ACCUSE_INQRY = "1001";
    public static final String ACCUSE_ANSWER = "1002";

    /**  */
    private static final long serialVersionUID = -655559714871413199L;

    /* 페이지 이름 */
    private String pageUrlNm;

    // ** 서비스평 **

    /* 평가글 일련번호 */
    private Integer goodsEvlSeq;
    /* 총서비스등록수 */
    private Integer evlTotal;
    /* 서비스평점 */
    private float evlScore;
    /* 1점 카운트 */
    private Integer evlScore1;
    /* 2점 카운트 */
    private Integer evlScore2;
    /* 3점 카운트 */
    private Integer evlScore3;
    /* 4점 카운트 */
    private Integer evlScore4;
    /* 5점 카운트 */
    private Integer evlScore5;
    /* 평가글 */
    private String evlSntnc;
    /* 원본ID */
    private String orgRegistId;
    /* 작성자 이름 */
    private String registNm;
    /* 작성자 아이피 */
    private String registIp;

    // ** 서비스문의 **

    /* 서비스 문의번호 */
    private Integer goodsInqryNo;
    /* 답변상태코드 */
    private String answerSttusCd;
    /* 답변상태이름 */
    private String answerSttusNm;
    /* 문의제목 */
    private String inqrySj;
    /* 작성자 ID */
    private String inqrId;
    /* 원본 작성자 ID */
    private String orgInqrId;    
    /* 작성자 이름 */
    private String inqrNm;
    /* 공개여부 */
    private String othbcAt;
    /* 문의 내용 */
    private String inqryCn;
    /* 답변수신메일 */
    private String answerRecptnEmail;
    /* 문의 답변내용 */
    private String inqryAnswerCn;
    /* 답변일시 */
    private String answerDt;
    
    
    /* 신고여부코드 */
    private String accuseAtCd;
    /* 신고사유코드 */
    private String accuseResnCd;
    /* 신고사유기타내용 */
    private String accuseResnEtcCn;
    
    private String inqryAccuseResnCd; 
    private String answerAccuseResnCd;
    private String inqryAccuseEtcCn; 
    private String answerAccuseEtcCn;
    
    
    /* 문의신고자아이디 */
    private String inqryAplcntId;
    /* 답변신고자아이디 */
    private String answerAplcntId;
    /* 답변수정일시 */
    private String answerUpdateDt;
    /* 신고일시 */
    private String accuseDt;
    
    
    /* 화면 이동 타입 */
    private String scrollMoveTy;
    
    /*판매자 명*/
    private String goodsChargerNm;
    /*판매자 이메일*/
    private String goodsChargerEmail;
    /*문의 신고자 명*/
    private String inqryAplcntNm;
    /*문의 신고자 이메일*/
    private String inqryAplcntEmail;
    /*문의 신고자 연락처*/
    private String inqryAplcntPhoen;
    /*답변 신고자 명*/
    private String answerAplcntNm;
    /*답변 신고자 이메일*/
    private String answerAplcntEmail;
    /*답변 신고자 연락처*/
    private String answerAplcntPhoen;
    
    private String fileUrl;
    private String localOrginlNm;
    private String mngrEmail;
    private String mngrNm;

 
    /**
     * String mngrNm을 반환
     * @return String mngrNm
     */
    public String getMngrNm() {
        return mngrNm;
    }


    /**
     * mngrNm을 설정
     * @param mngrNm 을(를) String mngrNm로 설정
     */
    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }
    
    
    /**
     * String mngrEmail을 반환
     * @return String mngrEmail
     */
    public String getMngrEmail() {
        return mngrEmail;
    }


    /**
     * mngrEmail을 설정
     * @param mngrEmail 을(를) String mngrEmail로 설정
     */
    public void setMngrEmail(String mngrEmail) {
        this.mngrEmail = mngrEmail;
    }


    /**
     * String pageUrlNm을 반환
     * 
     * @return String pageUrlNm
     */
    public String getPageUrlNm() {
        return pageUrlNm;
    }

    /**
     * pageUrlNm을 설정
     * 
     * @param pageUrlNm 을(를) String pageUrlNm로 설정
     */
    public void setPageUrlNm(String pageUrlNm) {
        this.pageUrlNm = pageUrlNm;
    }

    /**
     * String scrollMoveTy을 반환
     * 
     * @return String scrollMoveTy
     */
    public String getScrollMoveTy() {
        return scrollMoveTy;
    }

    /**
     * scrollMoveTy을 설정
     * 
     * @param scrollMoveTy 을(를) String scrollMoveTy로 설정
     */
    public void setScrollMoveTy(String scrollMoveTy) {
        this.scrollMoveTy = scrollMoveTy;
    }

    /**
     * Integer goodsEvlSeq을 반환
     * 
     * @return Integer goodsEvlSeq
     */
    public Integer getGoodsEvlSeq() {
        return goodsEvlSeq;
    }

    /**
     * goodsEvlSeq을 설정
     * 
     * @param goodsEvlSeq 을(를) Integer goodsEvlSeq로 설정
     */
    public void setGoodsEvlSeq(Integer goodsEvlSeq) {
        this.goodsEvlSeq = goodsEvlSeq;
    }

    /**
     * Integer evlTotal을 반환
     * 
     * @return Integer evlTotal
     */
    public Integer getEvlTotal() {
        return evlTotal;
    }

    /**
     * evlTotal을 설정
     * 
     * @param evlTotal 을(를) Integer evlTotal로 설정
     */
    public void setEvlTotal(Integer evlTotal) {
        this.evlTotal = evlTotal;
    }

    /**
     * float evlScore을 반환
     * 
     * @return float evlScore
     */
    public float getEvlScore() {
        return evlScore;
    }

    /**
     * evlScore을 설정
     * 
     * @param evlScore 을(를) float evlScore로 설정
     */
    public void setEvlScore(float evlScore) {
        this.evlScore = evlScore;
    }

    /**
     * Integer evlScore1을 반환
     * 
     * @return Integer evlScore1
     */
    public Integer getEvlScore1() {
        return evlScore1;
    }

    /**
     * evlScore1을 설정
     * 
     * @param evlScore1 을(를) Integer evlScore1로 설정
     */
    public void setEvlScore1(Integer evlScore1) {
        this.evlScore1 = evlScore1;
    }

    /**
     * Integer evlScore2을 반환
     * 
     * @return Integer evlScore2
     */
    public Integer getEvlScore2() {
        return evlScore2;
    }

    /**
     * evlScore2을 설정
     * 
     * @param evlScore2 을(를) Integer evlScore2로 설정
     */
    public void setEvlScore2(Integer evlScore2) {
        this.evlScore2 = evlScore2;
    }

    /**
     * Integer evlScore3을 반환
     * 
     * @return Integer evlScore3
     */
    public Integer getEvlScore3() {
        return evlScore3;
    }

    /**
     * evlScore3을 설정
     * 
     * @param evlScore3 을(를) Integer evlScore3로 설정
     */
    public void setEvlScore3(Integer evlScore3) {
        this.evlScore3 = evlScore3;
    }

    /**
     * Integer evlScore4을 반환
     * 
     * @return Integer evlScore4
     */
    public Integer getEvlScore4() {
        return evlScore4;
    }

    /**
     * evlScore4을 설정
     * 
     * @param evlScore4 을(를) Integer evlScore4로 설정
     */
    public void setEvlScore4(Integer evlScore4) {
        this.evlScore4 = evlScore4;
    }

    /**
     * Integer evlScore5을 반환
     * 
     * @return Integer evlScore5
     */
    public Integer getEvlScore5() {
        return evlScore5;
    }

    /**
     * evlScore5을 설정
     * 
     * @param evlScore5 을(를) Integer evlScore5로 설정
     */
    public void setEvlScore5(Integer evlScore5) {
        this.evlScore5 = evlScore5;
    }

    /**
     * String evlSntnc을 반환
     * 
     * @return String evlSntnc
     */
    public String getEvlSntnc() {
        return evlSntnc;
    }

    /**
     * evlSntnc을 설정
     * 
     * @param evlSntnc 을(를) String evlSntnc로 설정
     */
    public void setEvlSntnc(String evlSntnc) {
        this.evlSntnc = evlSntnc;
    }

    /**
     * String orgRegistId을 반환
     * 
     * @return String orgRegistId
     */
    public String getOrgRegistId() {
        return orgRegistId;
    }

    /**
     * orgRegistId을 설정
     * 
     * @param orgRegistId 을(를) String orgRegistId로 설정
     */
    public void setOrgRegistId(String orgRegistId) {
        this.orgRegistId = orgRegistId;
    }

    /**
     * String registNm을 반환
     * 
     * @return String registNm
     */
    public String getRegistNm() {
        return registNm;
    }

    /**
     * registNm을 설정
     * 
     * @param registNm 을(를) String registNm로 설정
     */
    public void setRegistNm(String registNm) {
        this.registNm = registNm;
    }

    /**
     * String registIp을 반환
     * 
     * @return String registIp
     */
    public String getRegistIp() {
        return registIp;
    }

    /**
     * registIp을 설정
     * 
     * @param registIp 을(를) String registIp로 설정
     */
    public void setRegistIp(String registIp) {
        this.registIp = registIp;
    }

    /**
     * Integer goodsInqryNo을 반환
     * 
     * @return Integer goodsInqryNo
     */
    public Integer getGoodsInqryNo() {
        return goodsInqryNo;
    }

    /**
     * goodsInqryNo을 설정
     * 
     * @param goodsInqryNo 을(를) Integer goodsInqryNo로 설정
     */
    public void setGoodsInqryNo(Integer goodsInqryNo) {
        this.goodsInqryNo = goodsInqryNo;
    }

    /**
     * String answerSttusCd을 반환
     * 
     * @return String answerSttusCd
     */
    public String getAnswerSttusCd() {
        return answerSttusCd;
    }

    /**
     * answerSttusCd을 설정
     * 
     * @param answerSttusCd 을(를) String answerSttusCd로 설정
     */
    public void setAnswerSttusCd(String answerSttusCd) {
        this.answerSttusCd = answerSttusCd;
    }

    /**
     * String answerSttusNm을 반환
     * 
     * @return String answerSttusNm
     */
    public String getAnswerSttusNm() {
        return answerSttusNm;
    }

    /**
     * answerSttusNm을 설정
     * 
     * @param answerSttusNm 을(를) String answerSttusNm로 설정
     */
    public void setAnswerSttusNm(String answerSttusNm) {
        this.answerSttusNm = answerSttusNm;
    }

    /**
     * String inqrySj을 반환
     * 
     * @return String inqrySj
     */
    public String getInqrySj() {
        return inqrySj;
    }

    /**
     * inqrySj을 설정
     * 
     * @param inqrySj 을(를) String inqrySj로 설정
     */
    public void setInqrySj(String inqrySj) {
        this.inqrySj = inqrySj;
    }

    /**
     * String inqrId을 반환
     * 
     * @return String inqrId
     */
    public String getInqrId() {
        return inqrId;
    }

    /**
     * inqrId을 설정
     * 
     * @param inqrId 을(를) String inqrId로 설정
     */
    public void setInqrId(String inqrId) {
        this.inqrId = inqrId;
    }

    /**
     * String inqrNm을 반환
     * 
     * @return String inqrNm
     */
    public String getInqrNm() {
        return inqrNm;
    }

    /**
     * inqrNm을 설정
     * 
     * @param inqrNm 을(를) String inqrNm로 설정
     */
    public void setInqrNm(String inqrNm) {
        this.inqrNm = inqrNm;
    }

    /**
     * String othbcAt을 반환
     * 
     * @return String othbcAt
     */
    public String getOthbcAt() {
        return othbcAt;
    }

    /**
     * othbcAt을 설정
     * 
     * @param othbcAt 을(를) String othbcAt로 설정
     */
    public void setOthbcAt(String othbcAt) {
        this.othbcAt = othbcAt;
    }

    /**
     * String inqryCn을 반환
     * 
     * @return String inqryCn
     */
    public String getInqryCn() {
        return inqryCn;
    }

    /**
     * inqryCn을 설정
     * 
     * @param inqryCn 을(를) String inqryCn로 설정
     */
    public void setInqryCn(String inqryCn) {
        this.inqryCn = inqryCn;
    }

    /**
     * String answerRecptnEmail을 반환
     * 
     * @return String answerRecptnEmail
     */
    public String getAnswerRecptnEmail() {
        return answerRecptnEmail;
    }

    /**
     * answerRecptnEmail을 설정
     * 
     * @param answerRecptnEmail 을(를) String answerRecptnEmail로 설정
     */
    public void setAnswerRecptnEmail(String answerRecptnEmail) {
        this.answerRecptnEmail = answerRecptnEmail;
    }

    /**
     * String inqryAnswerCn을 반환
     * 
     * @return String inqryAnswerCn
     */
    public String getInqryAnswerCn() {
        return inqryAnswerCn;
    }

    /**
     * inqryAnswerCn을 설정
     * 
     * @param inqryAnswerCn 을(를) String inqryAnswerCn로 설정
     */
    public void setInqryAnswerCn(String inqryAnswerCn) {
        this.inqryAnswerCn = inqryAnswerCn;
    }

    /**
     * String answerDt을 반환
     * 
     * @return String answerDt
     */
    public String getAnswerDt() {
        return answerDt;
    }

    /**
     * answerDt을 설정
     * 
     * @param answerDt 을(를) String answerDt로 설정
     */
    public void setAnswerDt(String answerDt) {
        this.answerDt = answerDt;
    }

    /**
     * String accuseAtCd을 반환
     * 
     * @return String accuseAtCd
     */
    public String getAccuseAtCd() {
        return accuseAtCd;
    }

    /**
     * accuseAtCd을 설정
     * 
     * @param accuseAtCd 을(를) String accuseAtCd로 설정
     */
    public void setAccuseAtCd(String accuseAtCd) {
        this.accuseAtCd = accuseAtCd;
    }

    /**
     * String accuseResnCd을 반환
     * 
     * @return String accuseResnCd
     */
    public String getAccuseResnCd() {
        return accuseResnCd;
    }

    /**
     * accuseResnCd을 설정
     * 
     * @param accuseResnCd 을(를) String accuseResnCd로 설정
     */
    public void setAccuseResnCd(String accuseResnCd) {
        this.accuseResnCd = accuseResnCd;
    }

    /**
     * String accuseResnEtcCn을 반환
     * 
     * @return String accuseResnEtcCn
     */
    public String getAccuseResnEtcCn() {
        return accuseResnEtcCn;
    }

    /**
     * accuseResnEtcCn을 설정
     * 
     * @param accuseResnEtcCn 을(를) String accuseResnEtcCn로 설정
     */
    public void setAccuseResnEtcCn(String accuseResnEtcCn) {
        this.accuseResnEtcCn = accuseResnEtcCn;
    }

    /**
     * String inqryAplcntId을 반환
     * 
     * @return String inqryAplcntId
     */
    public String getInqryAplcntId() {
        return inqryAplcntId;
    }

    /**
     * inqryAplcntId을 설정
     * 
     * @param inqryAplcntId 을(를) String inqryAplcntId로 설정
     */
    public void setInqryAplcntId(String inqryAplcntId) {
        this.inqryAplcntId = inqryAplcntId;
    }

    /**
     * String answerUpdateDt을 반환
     * 
     * @return String answerUpdateDt
     */
    public String getAnswerUpdateDt() {
        return answerUpdateDt;
    }

    /**
     * answerUpdateDt을 설정
     * 
     * @param answerUpdateDt 을(를) String answerUpdateDt로 설정
     */
    public void setAnswerUpdateDt(String answerUpdateDt) {
        this.answerUpdateDt = answerUpdateDt;
    }

    /**
     * String accuseDt을 반환
     * 
     * @return String accuseDt
     */
    public String getAccuseDt() {
        return accuseDt;
    }

    /**
     * accuseDt을 설정
     * 
     * @param accuseDt 을(를) String accuseDt로 설정
     */
    public void setAccuseDt(String accuseDt) {
        this.accuseDt = accuseDt;
    }

    
    /**
     * String answerAplcntId을 반환
     * @return String answerAplcntId
     */
    public String getAnswerAplcntId() {
        return answerAplcntId;
    }

    
    /**
     * answerAplcntId을 설정
     * @param answerAplcntId 을(를) String answerAplcntId로 설정
     */
    public void setAnswerAplcntId(String answerAplcntId) {
        this.answerAplcntId = answerAplcntId;
    }

    
    /**
     * String inqryAccuseResnCd을 반환
     * @return String inqryAccuseResnCd
     */
    public String getInqryAccuseResnCd() {
        return inqryAccuseResnCd;
    }

    
    /**
     * inqryAccuseResnCd을 설정
     * @param inqryAccuseResnCd 을(를) String inqryAccuseResnCd로 설정
     */
    public void setInqryAccuseResnCd(String inqryAccuseResnCd) {
        this.inqryAccuseResnCd = inqryAccuseResnCd;
    }

    
    /**
     * String answerAccuseResnCd을 반환
     * @return String answerAccuseResnCd
     */
    public String getAnswerAccuseResnCd() {
        return answerAccuseResnCd;
    }

    
    /**
     * answerAccuseResnCd을 설정
     * @param answerAccuseResnCd 을(를) String answerAccuseResnCd로 설정
     */
    public void setAnswerAccuseResnCd(String answerAccuseResnCd) {
        this.answerAccuseResnCd = answerAccuseResnCd;
    }

    
    /**
     * String inqryAccuseEtcCn을 반환
     * @return String inqryAccuseEtcCn
     */
    public String getInqryAccuseEtcCn() {
        return inqryAccuseEtcCn;
    }

    
    /**
     * inqryAccuseEtcCn을 설정
     * @param inqryAccuseEtcCn 을(를) String inqryAccuseEtcCn로 설정
     */
    public void setInqryAccuseEtcCn(String inqryAccuseEtcCn) {
        this.inqryAccuseEtcCn = inqryAccuseEtcCn;
    }

    
    /**
     * String answerAccuseEtcCn을 반환
     * @return String answerAccuseEtcCn
     */
    public String getAnswerAccuseEtcCn() {
        return answerAccuseEtcCn;
    }

    
    /**
     * answerAccuseEtcCn을 설정
     * @param answerAccuseEtcCn 을(를) String answerAccuseEtcCn로 설정
     */
    public void setAnswerAccuseEtcCn(String answerAccuseEtcCn) {
        this.answerAccuseEtcCn = answerAccuseEtcCn;
    }

    
    /**
     * String orgInqrId을 반환
     * @return String orgInqrId
     */
    public String getOrgInqrId() {
        return orgInqrId;
    }

    
    /**
     * orgInqrId을 설정
     * @param orgInqrId 을(를) String orgInqrId로 설정
     */
    public void setOrgInqrId(String orgInqrId) {
        this.orgInqrId = orgInqrId;
    }

    
    /**
     * String goodsChargerNm을 반환
     * @return String goodsChargerNm
     */
    public String getGoodsChargerNm() {
        return goodsChargerNm;
    }

    
    /**
     * goodsChargerNm을 설정
     * @param goodsChargerNm 을(를) String goodsChargerNm로 설정
     */
    public void setGoodsChargerNm(String goodsChargerNm) {
        this.goodsChargerNm = goodsChargerNm;
    }

    
    /**
     * String goodsChargerEmail을 반환
     * @return String goodsChargerEmail
     */
    public String getGoodsChargerEmail() {
        return goodsChargerEmail;
    }

    
    /**
     * goodsChargerEmail을 설정
     * @param goodsChargerEmail 을(를) String goodsChargerEmail로 설정
     */
    public void setGoodsChargerEmail(String goodsChargerEmail) {
        this.goodsChargerEmail = goodsChargerEmail;
    }

    
    /**
     * String inqryAplcntNm을 반환
     * @return String inqryAplcntNm
     */
    public String getInqryAplcntNm() {
        return inqryAplcntNm;
    }

    
    /**
     * inqryAplcntNm을 설정
     * @param inqryAplcntNm 을(를) String inqryAplcntNm로 설정
     */
    public void setInqryAplcntNm(String inqryAplcntNm) {
        this.inqryAplcntNm = inqryAplcntNm;
    }

    
    /**
     * String inqryAplcntEmail을 반환
     * @return String inqryAplcntEmail
     */
    public String getInqryAplcntEmail() {
        return inqryAplcntEmail;
    }

    
    /**
     * inqryAplcntEmail을 설정
     * @param inqryAplcntEmail 을(를) String inqryAplcntEmail로 설정
     */
    public void setInqryAplcntEmail(String inqryAplcntEmail) {
        this.inqryAplcntEmail = inqryAplcntEmail;
    }

    
    /**
     * String answerAplcntNm을 반환
     * @return String answerAplcntNm
     */
    public String getAnswerAplcntNm() {
        return answerAplcntNm;
    }

    
    /**
     * answerAplcntNm을 설정
     * @param answerAplcntNm 을(를) String answerAplcntNm로 설정
     */
    public void setAnswerAplcntNm(String answerAplcntNm) {
        this.answerAplcntNm = answerAplcntNm;
    }

    
    /**
     * String answerAplcntEmail을 반환
     * @return String answerAplcntEmail
     */
    public String getAnswerAplcntEmail() {
        return answerAplcntEmail;
    }

    
    /**
     * answerAplcntEmail을 설정
     * @param answerAplcntEmail 을(를) String answerAplcntEmail로 설정
     */
    public void setAnswerAplcntEmail(String answerAplcntEmail) {
        this.answerAplcntEmail = answerAplcntEmail;
    }

    
    /**
     * String fileUrl을 반환
     * @return String fileUrl
     */
    public String getFileUrl() {
        return fileUrl;
    }

    
    /**
     * fileUrl을 설정
     * @param fileUrl 을(를) String fileUrl로 설정
     */
    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    
    /**
     * String localOrginlNm을 반환
     * @return String localOrginlNm
     */
    public String getLocalOrginlNm() {
        return localOrginlNm;
    }

    
    /**
     * localOrginlNm을 설정
     * @param localOrginlNm 을(를) String localOrginlNm로 설정
     */
    public void setLocalOrginlNm(String localOrginlNm) {
        this.localOrginlNm = localOrginlNm;
    }

    
    /**
     * String inqryAplcntPhoen을 반환
     * @return String inqryAplcntPhoen
     */
    public String getInqryAplcntPhoen() {
        return inqryAplcntPhoen;
    }

    
    /**
     * inqryAplcntPhoen을 설정
     * @param inqryAplcntPhoen 을(를) String inqryAplcntPhoen로 설정
     */
    public void setInqryAplcntPhoen(String inqryAplcntPhoen) {
        this.inqryAplcntPhoen = inqryAplcntPhoen;
    }

    
    /**
     * String answerAplcntPhoen을 반환
     * @return String answerAplcntPhoen
     */
    public String getAnswerAplcntPhoen() {
        return answerAplcntPhoen;
    }

    
    /**
     * answerAplcntPhoen을 설정
     * @param answerAplcntPhoen 을(를) String answerAplcntPhoen로 설정
     */
    public void setAnswerAplcntPhoen(String answerAplcntPhoen) {
        this.answerAplcntPhoen = answerAplcntPhoen;
    }

    
    
}
