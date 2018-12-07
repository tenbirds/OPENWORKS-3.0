/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.explorer;

import java.text.DecimalFormat;
import java.util.List;

import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  ------------------------------- *  
 *  2015. 1.  15.    김영상  
 * </pre>
 * @see
 */
public class ExplorerVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -2752894012936007780L;
    /** 조회 시작일자 */
    private String startDate = "";
    /** 조회 종료일자 */
    private String endDate = "";

    /** 문자 1 */
    private String textValue1 = "";
    /** 문자 2 */
    private String textValue2 = "";
    /** 문자 3 */
    private String textValue3 = "";
    /** 문자 4 */
    private String textValue4 = "";
    /** 문자 5 */
    private String textValue5 = "";
    /** 문자 6 */
    private String textValue6 = "";
    /** 문자 7 */
    private String textValue7 = "";
    /** 문자 8 */
    private String textValue8 = "";
    /** 문자 9 */
    private String textValue9 = "";
    /** 문자 10 */
    private String textValue10 = "";
    /** 문자 11 */
    private String textValue11 = "";
    /** 문자 12 */
    private String textValue12 = "";
    /** 문자 13 */
    private String textValue13 = "";
    /** 문자 14 */
    private String textValue14 = "";
    /** 문자 15 */
    private String textValue15 = "";
    
    private String section = "";
    private String nationTy = "";
    private String userTyNm = "";
    private Integer userCnt;
    private Integer totUserCnt;
    private Integer ctgryCd;
    private String ctgryNm = "";
    private String langNm = "";
    private Integer goodsCnt;
    private Integer totGoodsCnt;
    
    /* 2016.05.18 대시보드 서비스현황 변경으로 인한 추가*/
    private Integer dspyCnt; // 전시서비스갯수
    private Integer nondspyCnt; // 비전시서비스갯수
    private Integer csCnt; // 승인대기서비스갯수
    private Integer esCnt; // 검토대기서비스갯수
    /* }} */
    
    /* 2017.01.18 대시보드 - 계약 일 동향 총 합계*/
    /** 계약 일동향 - 총 건수 */
    private Integer cntrTotCnt;
    /** 계약 일동향 - 총 금액 */
    private Integer cntrTotAmount;

    /* 2017.01.18 대시보드 - 계약 일 동향 */
    /** 계약 일동향 - 날짜 */
    private String cntrDt     = "";
    /** 계약 일동향 - 요일 */
    private String cntrSw     = "";
    /** 계약 일동향 - 건수 */
    private String cntrCnt    = "";
    /** 계약 일동향 - 금액 */
    private Integer cntrAmount;
    /** 계약 일동향 - 금일 여부 */
    private String todayYn    = "";
    
    /* 2017.01.18 대시보드 - 구매활동 일동향*/
    /** 구매활동 일동향 - 상세정보(견적) 건수 */
    private Integer buyTrendBuyReqCnt;
    /** 구매활동 일동향 - 입찰공고 건수 */
    private Integer buyTrendBidCnt;
    /** 구매활동 일동향 - 종합쇼핑몰 건수 */
    private Integer buyTrendCntrCnt;
    /** 구매활동 일동향 - 계약체결 건수 */
    private Integer buyTrendIssueCnt;
    /** 구매활동 일동향 - 전체 동향 건수 */
    private Integer buyTrendTotCnt;
    /** 구매활동 일동향 - 상세정보(견적) 비율 (50px기준) */
    private Integer buyTrendBuyReqRate;
    /** 구매활동 일동향 - 입찰공고 비율 (50px기준) */
    private Integer buyTrendBidRate;
    /** 구매활동 일동향 - 종합쇼핑몰 비율 (50px기준) */
    private Integer buyTrendCntrRate;
    /** 구매활동 일동향 - 계약체결 비율 (50px기준) */
    private Integer buyTrendIssueRate;

    /* 2017.01.18 대시보드 - 회원현황*/
    /** 회원현황 - 금일 가입 일반회원 */
    private Integer todayGnrlMmbCnt;
    /** 회원현황 - 전체 일반회원 */
    private Integer totGnrlMmbCnt;
    /** 회원현황 - 금일 가입 공공회원 */
    private Integer todayPbMmbCnt;
    /** 회원현황 - 전체 공공회원 */
    private Integer totPbMmbCnt;
    /** 회원현황 - 금일 가입 공급자회원 */
    private Integer todaySuplerMmbCnt;
    /** 회원현황 - 전체 공급자회원 */
    private Integer totSuplerMmbCnt;

    /* 2017.01.18 대시보드 - 오늘의 할 일*/
    /** 체결대기 협약 건수 */
    private Integer cnclsWaitCnt;
    /** 승인대기 게시물 수 */
    private Integer confmWaitCnt;
    /** 답변대기 게시물 수 */
    private Integer replyWaitCnt;

    /* 2017.01.20 대시보드 - 오늘의 서비스변동(전일대비)*/
    /** 전일대비 PaaS 전시 건수 */
    private Integer dispPaasCnt;
    /** 전일대비 PaaS 비전시 건수 */
    private Integer nonDispPaasCnt;
    /** 전일대비 SaaS 전시 건수 */
    private Integer dispSaasCnt;
    /** 전일대비 SaaS 비전시 건수 */
    private Integer nonDispSaasCnt;
    /** 전일대비 IaaS 전시 건수 */
    private Integer dispIaasCnt;
    /** 전일대비 IaaS 비전시 건수 */
    private Integer nonDispIaasCnt;

    /* 2017.01.20 대시보드 - 서비스전시 총동향*/
    /** 서비스전시 PaaS 전시 건수 */
    private Integer paasCnt;
    /** 서비스전시 SaaS 전시 건수 */
    private Integer saasCnt;
    /** 서비스전시 IaaS 전시 건수 */
    private Integer iaasCnt;
    /** 서비스전시 SCS 전시 건수 */
    private Integer scsCnt;
    /** 서비스전시 전체건수 */
    private Integer totCnt;
    /** 서비스전시 PaaS 비율(150px기준) */
    private Integer paasRate;
    /** 서비스전시 SaaS 비율(150px기준) */
    private Integer saasRate;
    /** 서비스전시 IaaS 비율(150px기준) */
    private Integer iaasRate;
    /** 서비스전시 SCS 비율(150px기준) */
    private Integer scsRate;
    
    
    private String basicDate;
    private String beforeDate;
    private String formatDate;
    private String nowDate;
    
    
    //전시
    private String  goods_stats;
    private String  aGoods_regist_sttus;
    private Integer aSaasCnt;
    private Integer aPaasCnt;
    private Integer aIaasCnt;
    private Integer aScsCnt;
    private Integer aGoodsCnt;
    
    //비전시
    private String  bGoods_regist_sttus;
    private Integer bSaasCnt;
    private Integer bPaasCnt;
    private Integer bIaasCnt;
    private Integer bScsCnt;
    private Integer bGoodsCnt;
    private String  goodsDate;
    private String  issueDate;

    //회원 통계
    private String  mGoods_regist_sttus;
    private Integer mSaasCnt;
    private Integer mPaasCnt;
    private Integer mIaasCnt;
    private Integer mScsCnt;
    private Integer mGoodsCnt;
    
    //협약 통계
    private String bsGoods_regist_sttus;
    private Integer bsSaasCnt;
    private Integer bsPaasCnt;
    private Integer bsIaasCnt;
    private Integer bsScsCnt;
    private Integer bsGoodsCnt;
    
    private String goodsServiceState;
    private String goods_code;
    private String lang_code;
    private String goods_knd_cd;
    private String goods_nm;
    private String goods_monitor_url;
    
    //체결승인
    private String  workContract;
    private Integer workContractCnt;
    
    //검토(운영팀) 
    private String  workExam;
    private Integer workExamCnt;
    
    //승인(NIA)
    private String  workApproval;
    private Integer workApprovalCnt;
    
    //발급요청
    private String  workReq;
    private Integer workReqCnt;
    
    private String  qnaState;
    private Integer qnaStateCnt;
    private String  bizState;
    private Integer bizStateCnt;
    
    private String cntrctAmount;
    private Integer cntrctSnCnt;
    
    private String purchsInsttNm;
    
    private List dataList;
    
    private Integer cntSum;
    
    double saasRatio;
    double paasRatio;
    double iaasRatio;
    double scsRatio;
    
    private String flag;
    
    private List cntrDataList;
    private List cntrTpList;

    
    private Integer aDifSaasCnt;
    private Integer aDifPaasCnt;
    private Integer aDifIaasCnt;
    private Integer aDifScsCnt;
    private Integer aDifGoodsCnt;
    private Integer bDifSaasCnt;
    private Integer bDifPaasCnt;
    private Integer bDifIaasCnt;
    private Integer bDifScsCnt;
    private Integer bDifGoodsCnt;
    private Integer mDifSaasCnt;
    private Integer mDifPaasCnt;
    private Integer mDifIaasCnt;
    private Integer mDifScsCnt;
    private Integer mDifGoodsCnt;
    private Integer bsDifSaasCnt;
    private Integer bsDifPaasCnt;
    private Integer bsDifIaasCnt;
    private Integer bsDifScsCnt;
    private Integer bsDifGoodsCnt;
    
    private String difCntrctAmount;
    private Integer difCntrctSnCnt;
    
    private String goodsQnaState;
    private Integer goodsQnaStateCnt;
    
    /**
     * String startDate을 반환
     * @return String startDate
     */
    public String getStartDate() {
        return startDate;
    }
    
    /**
     * startDate을 설정
     * @param startDate 을(를) String startDate로 설정
     */
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    
    /**
     * String endDate을 반환
     * @return String endDate
     */
    public String getEndDate() {
        return endDate;
    }
    
    /**
     * endDate을 설정
     * @param endDate 을(를) String endDate로 설정
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    
    /**
     * String textValue1을 반환
     * @return String textValue1
     */
    public String getTextValue1() {
        return textValue1;
    }
    
    /**
     * textValue1을 설정
     * @param textValue1 을(를) String textValue1로 설정
     */
    public void setTextValue1(String textValue1) {
        this.textValue1 = textValue1;
    }
    
    /**
     * String textValue2을 반환
     * @return String textValue2
     */
    public String getTextValue2() {
        return textValue2;
    }
    
    /**
     * textValue2을 설정
     * @param textValue2 을(를) String textValue2로 설정
     */
    public void setTextValue2(String textValue2) {
        this.textValue2 = textValue2;
    }
    
    /**
     * String textValue3을 반환
     * @return String textValue3
     */
    public String getTextValue3() {
        return textValue3;
    }
    
    /**
     * textValue3을 설정
     * @param textValue3 을(를) String textValue3로 설정
     */
    public void setTextValue3(String textValue3) {
        this.textValue3 = textValue3;
    }
    
    /**
     * String textValue4을 반환
     * @return String textValue4
     */
    public String getTextValue4() {
        return textValue4;
    }
    
    /**
     * textValue4을 설정
     * @param textValue4 을(를) String textValue4로 설정
     */
    public void setTextValue4(String textValue4) {
        this.textValue4 = textValue4;
    }
    
    /**
     * String textValue5을 반환
     * @return String textValue5
     */
    public String getTextValue5() {
        return textValue5;
    }
    
    /**
     * textValue5을 설정
     * @param textValue5 을(를) String textValue5로 설정
     */
    public void setTextValue5(String textValue5) {
        this.textValue5 = textValue5;
    }
    
    /**
     * String textValue6을 반환
     * @return String textValue6
     */
    public String getTextValue6() {
        return textValue6;
    }
    
    /**
     * textValue6을 설정
     * @param textValue6 을(를) String textValue6로 설정
     */
    public void setTextValue6(String textValue6) {
        this.textValue6 = textValue6;
    }
    
    /**
     * String textValue7을 반환
     * @return String textValue7
     */
    public String getTextValue7() {
        return textValue7;
    }
    
    /**
     * textValue7을 설정
     * @param textValue7 을(를) String textValue7로 설정
     */
    public void setTextValue7(String textValue7) {
        this.textValue7 = textValue7;
    }
    
    /**
     * String textValue8을 반환
     * @return String textValue8
     */
    public String getTextValue8() {
        return textValue8;
    }
    
    /**
     * textValue8을 설정
     * @param textValue8 을(를) String textValue8로 설정
     */
    public void setTextValue8(String textValue8) {
        this.textValue8 = textValue8;
    }
    
    /**
     * String textValue9을 반환
     * @return String textValue9
     */
    public String getTextValue9() {
        return textValue9;
    }
    
    /**
     * textValue9을 설정
     * @param textValue9 을(를) String textValue9로 설정
     */
    public void setTextValue9(String textValue9) {
        this.textValue9 = textValue9;
    }
    
    /**
     * String textValue10을 반환
     * @return String textValue10
     */
    public String getTextValue10() {
        return textValue10;
    }
    
    /**
     * textValue10을 설정
     * @param textValue10 을(를) String textValue10로 설정
     */
    public void setTextValue10(String textValue10) {
        this.textValue10 = textValue10;
    }
    
    /**
     * String textValue11을 반환
     * @return String textValue11
     */
    public String getTextValue11() {
        return textValue11;
    }
    
    /**
     * textValue11을 설정
     * @param textValue11 을(를) String textValue11로 설정
     */
    public void setTextValue11(String textValue11) {
        this.textValue11 = textValue11;
    }
    
    /**
     * String textValue12을 반환
     * @return String textValue12
     */
    public String getTextValue12() {
        return textValue12;
    }
    
    /**
     * textValue12을 설정
     * @param textValue12 을(를) String textValue12로 설정
     */
    public void setTextValue12(String textValue12) {
        this.textValue12 = textValue12;
    }
    
    /**
     * String textValue13을 반환
     * @return String textValue13
     */
    public String getTextValue13() {
        return textValue13;
    }
    
    /**
     * textValue13을 설정
     * @param textValue13 을(를) String textValue13로 설정
     */
    public void setTextValue13(String textValue13) {
        this.textValue13 = textValue13;
    }
    
    /**
     * String textValue14을 반환
     * @return String textValue14
     */
    public String getTextValue14() {
        return textValue14;
    }
    
    /**
     * textValue14을 설정
     * @param textValue14 을(를) String textValue14로 설정
     */
    public void setTextValue14(String textValue14) {
        this.textValue14 = textValue14;
    }
    
    /**
     * String textValue15을 반환
     * @return String textValue15
     */
    public String getTextValue15() {
        return textValue15;
    }
    
    /**
     * textValue15을 설정
     * @param textValue15 을(를) String textValue15로 설정
     */
    public void setTextValue15(String textValue15) {
        this.textValue15 = textValue15;
    }
    
    /**
     * String section을 반환
     * @return String section
     */
    public String getSection() {
        return section;
    }
    
    /**
     * section을 설정
     * @param section 을(를) String section로 설정
     */
    public void setSection(String section) {
        this.section = section;
    }
    
    /**
     * String nationTy을 반환
     * @return String nationTy
     */
    public String getNationTy() {
        return nationTy;
    }
    
    /**
     * nationTy을 설정
     * @param nationTy 을(를) String nationTy로 설정
     */
    public void setNationTy(String nationTy) {
        this.nationTy = nationTy;
    }
    
    /**
     * String userTyNm을 반환
     * @return String userTyNm
     */
    public String getUserTyNm() {
        return userTyNm;
    }
    
    /**
     * userTyNm을 설정
     * @param userTyNm 을(를) String userTyNm로 설정
     */
    public void setUserTyNm(String userTyNm) {
        this.userTyNm = userTyNm;
    }
    
    /**
     * Integer userCnt을 반환
     * @return Integer userCnt
     */
    public Integer getUserCnt() {
        return userCnt;
    }
    
    /**
     * userCnt을 설정
     * @param userCnt 을(를) Integer userCnt로 설정
     */
    public void setUserCnt(Integer userCnt) {
        this.userCnt = userCnt;
    }
    
    /**
     * Integer totUserCnt을 반환
     * @return Integer totUserCnt
     */
    public Integer getTotUserCnt() {
        return totUserCnt;
    }
    
    /**
     * totUserCnt을 설정
     * @param totUserCnt 을(를) Integer totUserCnt로 설정
     */
    public void setTotUserCnt(Integer totUserCnt) {
        this.totUserCnt = totUserCnt;
    }
    
    /**
     * Integer ctgryCd을 반환
     * @return Integer ctgryCd
     */
    public Integer getCtgryCd() {
        return ctgryCd;
    }
    
    /**
     * ctgryCd을 설정
     * @param ctgryCd 을(를) Integer ctgryCd로 설정
     */
    public void setCtgryCd(Integer ctgryCd) {
        this.ctgryCd = ctgryCd;
    }
    
    /**
     * String ctgryNm을 반환
     * @return String ctgryNm
     */
    public String getCtgryNm() {
        return ctgryNm;
    }
    
    /**
     * ctgryNm을 설정
     * @param ctgryNm 을(를) String ctgryNm로 설정
     */
    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }
    
    /**
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }
    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }
    
    /**
     * Integer goodsCnt을 반환
     * @return Integer goodsCnt
     */
    public Integer getGoodsCnt() {
        return goodsCnt;
    }
    
    /**
     * goodsCnt을 설정
     * @param goodsCnt 을(를) Integer goodsCnt로 설정
     */
    public void setGoodsCnt(Integer goodsCnt) {
        this.goodsCnt = goodsCnt;
    }
    
    /**
     * Integer totGoodsCnt을 반환
     * @return Integer totGoodsCnt
     */
    public Integer getTotGoodsCnt() {
        return totGoodsCnt;
    }
    
    /**
     * totGoodsCnt을 설정
     * @param totGoodsCnt 을(를) Integer totGoodsCnt로 설정
     */
    public void setTotGoodsCnt(Integer totGoodsCnt) {
        this.totGoodsCnt = totGoodsCnt;
    }
    
    /**
     * Integer dspyCnt을 반환
     * @return Integer dspyCnt
     */
    public Integer getDspyCnt() {
        return dspyCnt;
    }
    
    /**
     * dspyCnt을 설정
     * @param dspyCnt 을(를) Integer dspyCnt로 설정
     */
    public void setDspyCnt(Integer dspyCnt) {
        this.dspyCnt = dspyCnt;
    }
    
    /**
     * Integer nondspyCnt을 반환
     * @return Integer nondspyCnt
     */
    public Integer getNondspyCnt() {
        return nondspyCnt;
    }
    
    /**
     * nondspyCnt을 설정
     * @param nondspyCnt 을(를) Integer nondspyCnt로 설정
     */
    public void setNondspyCnt(Integer nondspyCnt) {
        this.nondspyCnt = nondspyCnt;
    }
    
    /**
     * Integer csCnt을 반환
     * @return Integer csCnt
     */
    public Integer getCsCnt() {
        return csCnt;
    }
    
    /**
     * csCnt을 설정
     * @param csCnt 을(를) Integer csCnt로 설정
     */
    public void setCsCnt(Integer csCnt) {
        this.csCnt = csCnt;
    }
    
    /**
     * Integer esCnt을 반환
     * @return Integer esCnt
     */
    public Integer getEsCnt() {
        return esCnt;
    }
    
    /**
     * esCnt을 설정
     * @param esCnt 을(를) Integer esCnt로 설정
     */
    public void setEsCnt(Integer esCnt) {
        this.esCnt = esCnt;
    }
    
    /**
     * Integer cntrTotCnt을 반환
     * @return Integer cntrTotCnt
     */
    public Integer getCntrTotCnt() {
        return cntrTotCnt;
    }
    
    /**
     * cntrTotCnt을 설정
     * @param cntrTotCnt 을(를) Integer cntrTotCnt로 설정
     */
    public void setCntrTotCnt(Integer cntrTotCnt) {
        this.cntrTotCnt = cntrTotCnt;
    }
    
    /**
     * Integer cntrTotAmount을 반환
     * @return Integer cntrTotAmount
     */
    public Integer getCntrTotAmount() {
        return cntrTotAmount;
    }
    
    /**
     * cntrTotAmount을 설정
     * @param cntrTotAmount 을(를) Integer cntrTotAmount로 설정
     */
    public void setCntrTotAmount(Integer cntrTotAmount) {
        this.cntrTotAmount = cntrTotAmount;
    }
    
    /**
     * String cntrDt을 반환
     * @return String cntrDt
     */
    public String getCntrDt() {
        return cntrDt;
    }
    
    /**
     * cntrDt을 설정
     * @param cntrDt 을(를) String cntrDt로 설정
     */
    public void setCntrDt(String cntrDt) {
        this.cntrDt = cntrDt;
    }
    
    /**
     * String cntrSw을 반환
     * @return String cntrSw
     */
    public String getCntrSw() {
        return cntrSw;
    }
    
    /**
     * cntrSw을 설정
     * @param cntrSw 을(를) String cntrSw로 설정
     */
    public void setCntrSw(String cntrSw) {
        this.cntrSw = cntrSw;
    }
    
    /**
     * String cntrCnt을 반환
     * @return String cntrCnt
     */
    public String getCntrCnt() {
        return cntrCnt;
    }
    
    /**
     * cntrCnt을 설정
     * @param cntrCnt 을(를) String cntrCnt로 설정
     */
    public void setCntrCnt(String cntrCnt) {
        this.cntrCnt = cntrCnt;
    }
    
    /**
     * String cntrAmount을 반환
     * @return String cntrAmount
     */
    public Integer getCntrAmount() {
        return cntrAmount;
    }
    
    /**
     * cntrAmount을 설정
     * @param cntrAmount 을(를) String cntrAmount로 설정
     */
    public void setCntrAmount(Integer cntrAmount) {
        this.cntrAmount = cntrAmount;
    }
    
    /**
     * String todayYn을 반환
     * @return String todayYn
     */
    public String getTodayYn() {
        return todayYn;
    }
    
    /**
     * todayYn을 설정
     * @param todayYn 을(를) String todayYn로 설정
     */
    public void setTodayYn(String todayYn) {
        this.todayYn = todayYn;
    }
    
    /**
     * Integer buyTrendBuyReqCnt을 반환
     * @return Integer buyTrendBuyReqCnt
     */
    public Integer getBuyTrendBuyReqCnt() {
        return buyTrendBuyReqCnt;
    }
    
    /**
     * buyTrendBuyReqCnt을 설정
     * @param buyTrendBuyReqCnt 을(를) Integer buyTrendBuyReqCnt로 설정
     */
    public void setBuyTrendBuyReqCnt(Integer buyTrendBuyReqCnt) {
        this.buyTrendBuyReqCnt = buyTrendBuyReqCnt;
    }
    
    /**
     * Integer buyTrendBidCnt을 반환
     * @return Integer buyTrendBidCnt
     */
    public Integer getBuyTrendBidCnt() {
        return buyTrendBidCnt;
    }
    
    /**
     * buyTrendBidCnt을 설정
     * @param buyTrendBidCnt 을(를) Integer buyTrendBidCnt로 설정
     */
    public void setBuyTrendBidCnt(Integer buyTrendBidCnt) {
        this.buyTrendBidCnt = buyTrendBidCnt;
    }
    
    /**
     * Integer buyTrendCntrCnt을 반환
     * @return Integer buyTrendCntrCnt
     */
    public Integer getBuyTrendCntrCnt() {
        return buyTrendCntrCnt;
    }
    
    /**
     * buyTrendCntrCnt을 설정
     * @param buyTrendCntrCnt 을(를) Integer buyTrendCntrCnt로 설정
     */
    public void setBuyTrendCntrCnt(Integer buyTrendCntrCnt) {
        this.buyTrendCntrCnt = buyTrendCntrCnt;
    }
    
    /**
     * Integer buyTrendIssueCnt을 반환
     * @return Integer buyTrendIssueCnt
     */
    public Integer getBuyTrendIssueCnt() {
        return buyTrendIssueCnt;
    }
    
    /**
     * buyTrendIssueCnt을 설정
     * @param buyTrendIssueCnt 을(를) Integer buyTrendIssueCnt로 설정
     */
    public void setBuyTrendIssueCnt(Integer buyTrendIssueCnt) {
        this.buyTrendIssueCnt = buyTrendIssueCnt;
    }
    
    /**
     * Integer buyTrendTotCnt을 반환
     * @return Integer buyTrendTotCnt
     */
    public Integer getBuyTrendTotCnt() {
        return buyTrendTotCnt;
    }
    
    /**
     * buyTrendTotCnt을 설정
     * @param buyTrendTotCnt 을(를) Integer buyTrendTotCnt로 설정
     */
    public void setBuyTrendTotCnt(Integer buyTrendTotCnt) {
        this.buyTrendTotCnt = buyTrendTotCnt;
    }
    
    /**
     * Integer buyTrendBuyReqRate을 반환
     * @return Integer buyTrendBuyReqRate
     */
    public Integer getBuyTrendBuyReqRate() {
        return buyTrendBuyReqRate;
    }
    
    /**
     * buyTrendBuyReqRate을 설정
     * @param buyTrendBuyReqRate 을(를) Integer buyTrendBuyReqRate로 설정
     */
    public void setBuyTrendBuyReqRate(Integer buyTrendBuyReqRate) {
        this.buyTrendBuyReqRate = buyTrendBuyReqRate;
    }
    
    /**
     * Integer buyTrendBidRate을 반환
     * @return Integer buyTrendBidRate
     */
    public Integer getBuyTrendBidRate() {
        return buyTrendBidRate;
    }
    
    /**
     * buyTrendBidRate을 설정
     * @param buyTrendBidRate 을(를) Integer buyTrendBidRate로 설정
     */
    public void setBuyTrendBidRate(Integer buyTrendBidRate) {
        this.buyTrendBidRate = buyTrendBidRate;
    }
    
    /**
     * Integer buyTrendCntrRate을 반환
     * @return Integer buyTrendCntrRate
     */
    public Integer getBuyTrendCntrRate() {
        return buyTrendCntrRate;
    }
    
    /**
     * buyTrendCntrRate을 설정
     * @param buyTrendCntrRate 을(를) Integer buyTrendCntrRate로 설정
     */
    public void setBuyTrendCntrRate(Integer buyTrendCntrRate) {
        this.buyTrendCntrRate = buyTrendCntrRate;
    }
    
    /**
     * Integer buyTrendIssueRate을 반환
     * @return Integer buyTrendIssueRate
     */
    public Integer getBuyTrendIssueRate() {
        return buyTrendIssueRate;
    }
    
    /**
     * buyTrendIssueRate을 설정
     * @param buyTrendIssueRate 을(를) Integer buyTrendIssueRate로 설정
     */
    public void setBuyTrendIssueRate(Integer buyTrendIssueRate) {
        this.buyTrendIssueRate = buyTrendIssueRate;
    }
    
    /**
     * Integer todayGnrlMmbCnt을 반환
     * @return Integer todayGnrlMmbCnt
     */
    public Integer getTodayGnrlMmbCnt() {
        return todayGnrlMmbCnt;
    }
    
    /**
     * todayGnrlMmbCnt을 설정
     * @param todayGnrlMmbCnt 을(를) Integer todayGnrlMmbCnt로 설정
     */
    public void setTodayGnrlMmbCnt(Integer todayGnrlMmbCnt) {
        this.todayGnrlMmbCnt = todayGnrlMmbCnt;
    }
    
    /**
     * Integer totGnrlMmbCnt을 반환
     * @return Integer totGnrlMmbCnt
     */
    public Integer getTotGnrlMmbCnt() {
        return totGnrlMmbCnt;
    }
    
    /**
     * totGnrlMmbCnt을 설정
     * @param totGnrlMmbCnt 을(를) Integer totGnrlMmbCnt로 설정
     */
    public void setTotGnrlMmbCnt(Integer totGnrlMmbCnt) {
        this.totGnrlMmbCnt = totGnrlMmbCnt;
    }
    
    /**
     * Integer todayPbMmbCnt을 반환
     * @return Integer todayPbMmbCnt
     */
    public Integer getTodayPbMmbCnt() {
        return todayPbMmbCnt;
    }
    
    /**
     * todayPbMmbCnt을 설정
     * @param todayPbMmbCnt 을(를) Integer todayPbMmbCnt로 설정
     */
    public void setTodayPbMmbCnt(Integer todayPbMmbCnt) {
        this.todayPbMmbCnt = todayPbMmbCnt;
    }
    
    /**
     * Integer totPbMmbCnt을 반환
     * @return Integer totPbMmbCnt
     */
    public Integer getTotPbMmbCnt() {
        return totPbMmbCnt;
    }
    
    /**
     * totPbMmbCnt을 설정
     * @param totPbMmbCnt 을(를) Integer totPbMmbCnt로 설정
     */
    public void setTotPbMmbCnt(Integer totPbMmbCnt) {
        this.totPbMmbCnt = totPbMmbCnt;
    }
    
    /**
     * Integer todaySuplerMmbCnt을 반환
     * @return Integer todaySuplerMmbCnt
     */
    public Integer getTodaySuplerMmbCnt() {
        return todaySuplerMmbCnt;
    }
    
    /**
     * todaySuplerMmbCnt을 설정
     * @param todaySuplerMmbCnt 을(를) Integer todaySuplerMmbCnt로 설정
     */
    public void setTodaySuplerMmbCnt(Integer todaySuplerMmbCnt) {
        this.todaySuplerMmbCnt = todaySuplerMmbCnt;
    }
    
    /**
     * Integer totSuplerMmbCnt을 반환
     * @return Integer totSuplerMmbCnt
     */
    public Integer getTotSuplerMmbCnt() {
        return totSuplerMmbCnt;
    }
    
    /**
     * totSuplerMmbCnt을 설정
     * @param totSuplerMmbCnt 을(를) Integer totSuplerMmbCnt로 설정
     */
    public void setTotSuplerMmbCnt(Integer totSuplerMmbCnt) {
        this.totSuplerMmbCnt = totSuplerMmbCnt;
    }
    
    /**
     * Integer cnclsWaitCnt을 반환
     * @return Integer cnclsWaitCnt
     */
    public Integer getCnclsWaitCnt() {
        return cnclsWaitCnt;
    }
    
    /**
     * cnclsWaitCnt을 설정
     * @param cnclsWaitCnt 을(를) Integer cnclsWaitCnt로 설정
     */
    public void setCnclsWaitCnt(Integer cnclsWaitCnt) {
        this.cnclsWaitCnt = cnclsWaitCnt;
    }
    
    /**
     * Integer confmWaitCnt을 반환
     * @return Integer confmWaitCnt
     */
    public Integer getConfmWaitCnt() {
        return confmWaitCnt;
    }
    
    /**
     * confmWaitCnt을 설정
     * @param confmWaitCnt 을(를) Integer confmWaitCnt로 설정
     */
    public void setConfmWaitCnt(Integer confmWaitCnt) {
        this.confmWaitCnt = confmWaitCnt;
    }
    
    /**
     * Integer replyWaitCnt을 반환
     * @return Integer replyWaitCnt
     */
    public Integer getReplyWaitCnt() {
        return replyWaitCnt;
    }
    
    /**
     * replyWaitCnt을 설정
     * @param replyWaitCnt 을(를) Integer replyWaitCnt로 설정
     */
    public void setReplyWaitCnt(Integer replyWaitCnt) {
        this.replyWaitCnt = replyWaitCnt;
    }
    
    /**
     * Integer dispPaasCnt을 반환
     * @return Integer dispPaasCnt
     */
    public Integer getDispPaasCnt() {
        return dispPaasCnt;
    }
    
    /**
     * dispPaasCnt을 설정
     * @param dispPaasCnt 을(를) Integer dispPaasCnt로 설정
     */
    public void setDispPaasCnt(Integer dispPaasCnt) {
        this.dispPaasCnt = dispPaasCnt;
    }
    
    /**
     * Integer nonDispPaasCnt을 반환
     * @return Integer nonDispPaasCnt
     */
    public Integer getNonDispPaasCnt() {
        return nonDispPaasCnt;
    }
    
    /**
     * nonDispPaasCnt을 설정
     * @param nonDispPaasCnt 을(를) Integer nonDispPaasCnt로 설정
     */
    public void setNonDispPaasCnt(Integer nonDispPaasCnt) {
        this.nonDispPaasCnt = nonDispPaasCnt;
    }
    
    /**
     * Integer dispSaasCnt을 반환
     * @return Integer dispSaasCnt
     */
    public Integer getDispSaasCnt() {
        return dispSaasCnt;
    }
    
    /**
     * dispSaasCnt을 설정
     * @param dispSaasCnt 을(를) Integer dispSaasCnt로 설정
     */
    public void setDispSaasCnt(Integer dispSaasCnt) {
        this.dispSaasCnt = dispSaasCnt;
    }
    
    /**
     * Integer nonDispSaasCnt을 반환
     * @return Integer nonDispSaasCnt
     */
    public Integer getNonDispSaasCnt() {
        return nonDispSaasCnt;
    }
    
    /**
     * nonDispSaasCnt을 설정
     * @param nonDispSaasCnt 을(를) Integer nonDispSaasCnt로 설정
     */
    public void setNonDispSaasCnt(Integer nonDispSaasCnt) {
        this.nonDispSaasCnt = nonDispSaasCnt;
    }
    
    /**
     * Integer dispIaasCnt을 반환
     * @return Integer dispIaasCnt
     */
    public Integer getDispIaasCnt() {
        return dispIaasCnt;
    }
    
    /**
     * dispIaasCnt을 설정
     * @param dispIaasCnt 을(를) Integer dispIaasCnt로 설정
     */
    public void setDispIaasCnt(Integer dispIaasCnt) {
        this.dispIaasCnt = dispIaasCnt;
    }
    
    /**
     * Integer nonDispIaasCnt을 반환
     * @return Integer nonDispIaasCnt
     */
    public Integer getNonDispIaasCnt() {
        return nonDispIaasCnt;
    }
    
    /**
     * nonDispIaasCnt을 설정
     * @param nonDispIaasCnt 을(를) Integer nonDispIaasCnt로 설정
     */
    public void setNonDispIaasCnt(Integer nonDispIaasCnt) {
        this.nonDispIaasCnt = nonDispIaasCnt;
    }
    
    /**
     * Integer paasCnt을 반환
     * @return Integer paasCnt
     */
    public Integer getPaasCnt() {
        return paasCnt;
    }
    
    /**
     * paasCnt을 설정
     * @param paasCnt 을(를) Integer paasCnt로 설정
     */
    public void setPaasCnt(Integer paasCnt) {
        this.paasCnt = paasCnt;
    }
    
    /**
     * Integer saasCnt을 반환
     * @return Integer saasCnt
     */
    public Integer getSaasCnt() {
        return saasCnt;
    }
    
    /**
     * saasCnt을 설정
     * @param saasCnt 을(를) Integer saasCnt로 설정
     */
    public void setSaasCnt(Integer saasCnt) {
        this.saasCnt = saasCnt;
    }
    
    /**
     * Integer iaasCnt을 반환
     * @return Integer iaasCnt
     */
    public Integer getIaasCnt() {
        return iaasCnt;
    }
    
    /**
     * iaasCnt을 설정
     * @param iaasCnt 을(를) Integer iaasCnt로 설정
     */
    public void setIaasCnt(Integer iaasCnt) {
        this.iaasCnt = iaasCnt;
    }
    
    /**
     * Integer totCnt을 반환
     * @return Integer totCnt
     */
    public Integer getTotCnt() {
        return totCnt;
    }
    
    /**
     * totCnt을 설정
     * @param totCnt 을(를) Integer totCnt로 설정
     */
    public void setTotCnt(Integer totCnt) {
        this.totCnt = totCnt;
    }
    
    /**
     * Integer paasRate을 반환
     * @return Integer paasRate
     */
    public Integer getPaasRate() {
        return paasRate;
    }
    
    /**
     * paasRate을 설정
     * @param paasRate 을(를) Integer paasRate로 설정
     */
    public void setPaasRate(Integer paasRate) {
        this.paasRate = paasRate;
    }
    
    /**
     * Integer saasRate을 반환
     * @return Integer saasRate
     */
    public Integer getSaasRate() {
        return saasRate;
    }
    
    /**
     * saasRate을 설정
     * @param saasRate 을(를) Integer saasRate로 설정
     */
    public void setSaasRate(Integer saasRate) {
        this.saasRate = saasRate;
    }
    
    /**
     * Integer iaasRate을 반환
     * @return Integer iaasRate
     */
    public Integer getIaasRate() {
        return iaasRate;
    }
    
    /**
     * iaasRate을 설정
     * @param iaasRate 을(를) Integer iaasRate로 설정
     */
    public void setIaasRate(Integer iaasRate) {
        this.iaasRate = iaasRate;
    }
    
    /**
     * String basicDate을 반환
     * @return String basicDate
     */
    public String getBasicDate() {
        return basicDate;
    }
    
    /**
     * basicDate을 설정
     * @param basicDate 을(를) String basicDate로 설정
     */
    public void setBasicDate(String basicDate) {
        this.basicDate = basicDate;
    }
    
    /**
     * String beforeDate을 반환
     * @return String beforeDate
     */
    public String getBeforeDate() {
        return beforeDate;
    }
    
    /**
     * beforeDate을 설정
     * @param beforeDate 을(를) String beforeDate로 설정
     */
    public void setBeforeDate(String beforeDate) {
        this.beforeDate = beforeDate;
    }
    
    /**
     * String formatDate을 반환
     * @return String formatDate
     */
    public String getFormatDate() {
        return formatDate;
    }
    
    /**
     * formatDate을 설정
     * @param formatDate 을(를) String formatDate로 설정
     */
    public void setFormatDate(String formatDate) {
        this.formatDate = formatDate;
    }
    
    /**
     * String nowDate을 반환
     * @return String nowDate
     */
    public String getNowDate() {
        return nowDate;
    }
    
    /**
     * nowDate을 설정
     * @param nowDate 을(를) String nowDate로 설정
     */
    public void setNowDate(String nowDate) {
        this.nowDate = nowDate;
    }
    
    /**
     * String goods_stats을 반환
     * @return String goods_stats
     */
    public String getGoods_stats() {
        return goods_stats;
    }
    
    /**
     * goods_stats을 설정
     * @param goods_stats 을(를) String goods_stats로 설정
     */
    public void setGoods_stats(String goods_stats) {
        this.goods_stats = goods_stats;
    }
    
    /**
     * String aGoods_regist_sttus을 반환
     * @return String aGoods_regist_sttus
     */
    public String getaGoods_regist_sttus() {
        return aGoods_regist_sttus;
    }
    
    /**
     * aGoods_regist_sttus을 설정
     * @param aGoods_regist_sttus 을(를) String aGoods_regist_sttus로 설정
     */
    public void setaGoods_regist_sttus(String aGoods_regist_sttus) {
        this.aGoods_regist_sttus = aGoods_regist_sttus;
    }
    
    /**
     * Integer aSaasCnt을 반환
     * @return Integer aSaasCnt
     */
    public Integer getaSaasCnt() {
        return aSaasCnt;
    }
    
    /**
     * aSaasCnt을 설정
     * @param aSaasCnt 을(를) Integer aSaasCnt로 설정
     */
    public void setaSaasCnt(Integer aSaasCnt) {
        this.aSaasCnt = aSaasCnt;
    }
    
    /**
     * Integer aPaasCnt을 반환
     * @return Integer aPaasCnt
     */
    public Integer getaPaasCnt() {
        return aPaasCnt;
    }
    
    /**
     * aPaasCnt을 설정
     * @param aPaasCnt 을(를) Integer aPaasCnt로 설정
     */
    public void setaPaasCnt(Integer aPaasCnt) {
        this.aPaasCnt = aPaasCnt;
    }
    
    /**
     * Integer aIaasCnt을 반환
     * @return Integer aIaasCnt
     */
    public Integer getaIaasCnt() {
        return aIaasCnt;
    }
    
    /**
     * aIaasCnt을 설정
     * @param aIaasCnt 을(를) Integer aIaasCnt로 설정
     */
    public void setaIaasCnt(Integer aIaasCnt) {
        this.aIaasCnt = aIaasCnt;
    }
    
    /**
     * Integer aGoodsCnt을 반환
     * @return Integer aGoodsCnt
     */
    public Integer getaGoodsCnt() {
        return aGoodsCnt;
    }
    
    /**
     * aGoodsCnt을 설정
     * @param aGoodsCnt 을(를) Integer aGoodsCnt로 설정
     */
    public void setaGoodsCnt(Integer aGoodsCnt) {
        this.aGoodsCnt = aGoodsCnt;
    }
    
    /**
     * String bGoods_regist_sttus을 반환
     * @return String bGoods_regist_sttus
     */
    public String getbGoods_regist_sttus() {
        return bGoods_regist_sttus;
    }
    
    /**
     * bGoods_regist_sttus을 설정
     * @param bGoods_regist_sttus 을(를) String bGoods_regist_sttus로 설정
     */
    public void setbGoods_regist_sttus(String bGoods_regist_sttus) {
        this.bGoods_regist_sttus = bGoods_regist_sttus;
    }
    
    /**
     * Integer bSaasCnt을 반환
     * @return Integer bSaasCnt
     */
    public Integer getbSaasCnt() {
        return bSaasCnt;
    }
    
    /**
     * bSaasCnt을 설정
     * @param bSaasCnt 을(를) Integer bSaasCnt로 설정
     */
    public void setbSaasCnt(Integer bSaasCnt) {
        this.bSaasCnt = bSaasCnt;
    }
    
    /**
     * Integer bPaasCnt을 반환
     * @return Integer bPaasCnt
     */
    public Integer getbPaasCnt() {
        return bPaasCnt;
    }
    
    /**
     * bPaasCnt을 설정
     * @param bPaasCnt 을(를) Integer bPaasCnt로 설정
     */
    public void setbPaasCnt(Integer bPaasCnt) {
        this.bPaasCnt = bPaasCnt;
    }
    
    /**
     * Integer bIaasCnt을 반환
     * @return Integer bIaasCnt
     */
    public Integer getbIaasCnt() {
        return bIaasCnt;
    }
    
    /**
     * bIaasCnt을 설정
     * @param bIaasCnt 을(를) Integer bIaasCnt로 설정
     */
    public void setbIaasCnt(Integer bIaasCnt) {
        this.bIaasCnt = bIaasCnt;
    }
    
    /**
     * Integer bGoodsCnt을 반환
     * @return Integer bGoodsCnt
     */
    public Integer getbGoodsCnt() {
        return bGoodsCnt;
    }
    
    /**
     * bGoodsCnt을 설정
     * @param bGoodsCnt 을(를) Integer bGoodsCnt로 설정
     */
    public void setbGoodsCnt(Integer bGoodsCnt) {
        this.bGoodsCnt = bGoodsCnt;
    }
    
    /**
     * String goodsDate을 반환
     * @return String goodsDate
     */
    public String getGoodsDate() {
        return goodsDate;
    }
    
    /**
     * goodsDate을 설정
     * @param goodsDate 을(를) String goodsDate로 설정
     */
    public void setGoodsDate(String goodsDate) {
        this.goodsDate = goodsDate;
    }
    
    /**
     * String issueDate을 반환
     * @return String issueDate
     */
    public String getIssueDate() {
        return issueDate;
    }
    
    /**
     * issueDate을 설정
     * @param issueDate 을(를) String issueDate로 설정
     */
    public void setIssueDate(String issueDate) {
        this.issueDate = issueDate;
    }
    
    /**
     * String mGoods_regist_sttus을 반환
     * @return String mGoods_regist_sttus
     */
    public String getmGoods_regist_sttus() {
        return mGoods_regist_sttus;
    }
    
    /**
     * mGoods_regist_sttus을 설정
     * @param mGoods_regist_sttus 을(를) String mGoods_regist_sttus로 설정
     */
    public void setmGoods_regist_sttus(String mGoods_regist_sttus) {
        this.mGoods_regist_sttus = mGoods_regist_sttus;
    }
    
    /**
     * Integer mSaasCnt을 반환
     * @return Integer mSaasCnt
     */
    public Integer getmSaasCnt() {
        return mSaasCnt;
    }
    
    /**
     * mSaasCnt을 설정
     * @param mSaasCnt 을(를) Integer mSaasCnt로 설정
     */
    public void setmSaasCnt(Integer mSaasCnt) {
        this.mSaasCnt = mSaasCnt;
    }
    
    /**
     * Integer mPaasCnt을 반환
     * @return Integer mPaasCnt
     */
    public Integer getmPaasCnt() {
        return mPaasCnt;
    }
    
    /**
     * mPaasCnt을 설정
     * @param mPaasCnt 을(를) Integer mPaasCnt로 설정
     */
    public void setmPaasCnt(Integer mPaasCnt) {
        this.mPaasCnt = mPaasCnt;
    }
    
    /**
     * Integer mIaasCnt을 반환
     * @return Integer mIaasCnt
     */
    public Integer getmIaasCnt() {
        return mIaasCnt;
    }
    
    /**
     * mIaasCnt을 설정
     * @param mIaasCnt 을(를) Integer mIaasCnt로 설정
     */
    public void setmIaasCnt(Integer mIaasCnt) {
        this.mIaasCnt = mIaasCnt;
    }
    
    /**
     * Integer mGoodsCnt을 반환
     * @return Integer mGoodsCnt
     */
    public Integer getmGoodsCnt() {
        return mGoodsCnt;
    }
    
    /**
     * mGoodsCnt을 설정
     * @param mGoodsCnt 을(를) Integer mGoodsCnt로 설정
     */
    public void setmGoodsCnt(Integer mGoodsCnt) {
        this.mGoodsCnt = mGoodsCnt;
    }
    
    /**
     * String bsGoods_regist_sttus을 반환
     * @return String bsGoods_regist_sttus
     */
    public String getBsGoods_regist_sttus() {
        return bsGoods_regist_sttus;
    }
    
    /**
     * bsGoods_regist_sttus을 설정
     * @param bsGoods_regist_sttus 을(를) String bsGoods_regist_sttus로 설정
     */
    public void setBsGoods_regist_sttus(String bsGoods_regist_sttus) {
        this.bsGoods_regist_sttus = bsGoods_regist_sttus;
    }
    
    /**
     * Integer bsSaasCnt을 반환
     * @return Integer bsSaasCnt
     */
    public Integer getBsSaasCnt() {
        return bsSaasCnt;
    }
    
    /**
     * bsSaasCnt을 설정
     * @param bsSaasCnt 을(를) Integer bsSaasCnt로 설정
     */
    public void setBsSaasCnt(Integer bsSaasCnt) {
        this.bsSaasCnt = bsSaasCnt;
    }
    
    /**
     * Integer bsPaasCnt을 반환
     * @return Integer bsPaasCnt
     */
    public Integer getBsPaasCnt() {
        return bsPaasCnt;
    }
    
    /**
     * bsPaasCnt을 설정
     * @param bsPaasCnt 을(를) Integer bsPaasCnt로 설정
     */
    public void setBsPaasCnt(Integer bsPaasCnt) {
        this.bsPaasCnt = bsPaasCnt;
    }
    
    /**
     * Integer bsIaasCnt을 반환
     * @return Integer bsIaasCnt
     */
    public Integer getBsIaasCnt() {
        return bsIaasCnt;
    }
    
    /**
     * bsIaasCnt을 설정
     * @param bsIaasCnt 을(를) Integer bsIaasCnt로 설정
     */
    public void setBsIaasCnt(Integer bsIaasCnt) {
        this.bsIaasCnt = bsIaasCnt;
    }
    
    /**
     * Integer bsGoodsCnt을 반환
     * @return Integer bsGoodsCnt
     */
    public Integer getBsGoodsCnt() {
        return bsGoodsCnt;
    }
    
    /**
     * bsGoodsCnt을 설정
     * @param bsGoodsCnt 을(를) Integer bsGoodsCnt로 설정
     */
    public void setBsGoodsCnt(Integer bsGoodsCnt) {
        this.bsGoodsCnt = bsGoodsCnt;
    }
    
    /**
     * String goodsServiceState을 반환
     * @return String goodsServiceState
     */
    public String getGoodsServiceState() {
        return goodsServiceState;
    }
    
    /**
     * goodsServiceState을 설정
     * @param goodsServiceState 을(를) String goodsServiceState로 설정
     */
    public void setGoodsServiceState(String goodsServiceState) {
        this.goodsServiceState = goodsServiceState;
    }
    
    /**
     * String goods_code을 반환
     * @return String goods_code
     */
    public String getGoods_code() {
        return goods_code;
    }
    
    /**
     * goods_code을 설정
     * @param goods_code 을(를) String goods_code로 설정
     */
    public void setGoods_code(String goods_code) {
        this.goods_code = goods_code;
    }
    
    /**
     * String lang_code을 반환
     * @return String lang_code
     */
    public String getLang_code() {
        return lang_code;
    }
    
    /**
     * lang_code을 설정
     * @param lang_code 을(를) String lang_code로 설정
     */
    public void setLang_code(String lang_code) {
        this.lang_code = lang_code;
    }
    
    /**
     * String goods_knd_cd을 반환
     * @return String goods_knd_cd
     */
    public String getGoods_knd_cd() {
        return goods_knd_cd;
    }
    
    /**
     * goods_knd_cd을 설정
     * @param goods_knd_cd 을(를) String goods_knd_cd로 설정
     */
    public void setGoods_knd_cd(String goods_knd_cd) {
        this.goods_knd_cd = goods_knd_cd;
    }
    
    /**
     * String goods_nm을 반환
     * @return String goods_nm
     */
    public String getGoods_nm() {
        return goods_nm;
    }
    
    /**
     * goods_nm을 설정
     * @param goods_nm 을(를) String goods_nm로 설정
     */
    public void setGoods_nm(String goods_nm) {
        this.goods_nm = goods_nm;
    }
    
    /**
     * String goods_monitor_url을 반환
     * @return String goods_monitor_url
     */
    public String getGoods_monitor_url() {
        return goods_monitor_url;
    }
    
    /**
     * goods_monitor_url을 설정
     * @param goods_monitor_url 을(를) String goods_monitor_url로 설정
     */
    public void setGoods_monitor_url(String goods_monitor_url) {
        this.goods_monitor_url = goods_monitor_url;
    }
    
    /**
     * String workContract을 반환
     * @return String workContract
     */
    public String getWorkContract() {
        return workContract;
    }
    
    /**
     * workContract을 설정
     * @param workContract 을(를) String workContract로 설정
     */
    public void setWorkContract(String workContract) {
        this.workContract = workContract;
    }
    
    /**
     * Integer workContractCnt을 반환
     * @return Integer workContractCnt
     */
    public Integer getWorkContractCnt() {
        return workContractCnt;
    }
    
    /**
     * workContractCnt을 설정
     * @param workContractCnt 을(를) Integer workContractCnt로 설정
     */
    public void setWorkContractCnt(Integer workContractCnt) {
        this.workContractCnt = workContractCnt;
    }
    
    /**
     * String workExam을 반환
     * @return String workExam
     */
    public String getWorkExam() {
        return workExam;
    }
    
    /**
     * workExam을 설정
     * @param workExam 을(를) String workExam로 설정
     */
    public void setWorkExam(String workExam) {
        this.workExam = workExam;
    }
    
    /**
     * Integer workExamCnt을 반환
     * @return Integer workExamCnt
     */
    public Integer getWorkExamCnt() {
        return workExamCnt;
    }
    
    /**
     * workExamCnt을 설정
     * @param workExamCnt 을(를) Integer workExamCnt로 설정
     */
    public void setWorkExamCnt(Integer workExamCnt) {
        this.workExamCnt = workExamCnt;
    }
    
    /**
     * String workApproval을 반환
     * @return String workApproval
     */
    public String getWorkApproval() {
        return workApproval;
    }
    
    /**
     * workApproval을 설정
     * @param workApproval 을(를) String workApproval로 설정
     */
    public void setWorkApproval(String workApproval) {
        this.workApproval = workApproval;
    }
    
    /**
     * Integer workApprovalCnt을 반환
     * @return Integer workApprovalCnt
     */
    public Integer getWorkApprovalCnt() {
        return workApprovalCnt;
    }
    
    /**
     * workApprovalCnt을 설정
     * @param workApprovalCnt 을(를) Integer workApprovalCnt로 설정
     */
    public void setWorkApprovalCnt(Integer workApprovalCnt) {
        this.workApprovalCnt = workApprovalCnt;
    }
    
    /**
     * String workReq을 반환
     * @return String workReq
     */
    public String getWorkReq() {
        return workReq;
    }
    
    /**
     * workReq을 설정
     * @param workReq 을(를) String workReq로 설정
     */
    public void setWorkReq(String workReq) {
        this.workReq = workReq;
    }
    
    /**
     * Integer workReqCnt을 반환
     * @return Integer workReqCnt
     */
    public Integer getWorkReqCnt() {
        return workReqCnt;
    }
    
    /**
     * workReqCnt을 설정
     * @param workReqCnt 을(를) Integer workReqCnt로 설정
     */
    public void setWorkReqCnt(Integer workReqCnt) {
        this.workReqCnt = workReqCnt;
    }
    
    /**
     * Integer cntrctAmount을 반환
     * @return Integer cntrctAmount
     */
    public String getCntrctAmount() {
        return cntrctAmount;
    }
    
    /**
     * cntrctAmount을 설정
     * @param cntrctAmount 을(를) Integer cntrctAmount로 설정
     */
    public void setCntrctAmount(String cntrctAmount) {
        this.cntrctAmount = cntrctAmount;
    }
    
    /**
     * Integer cntrctSnCnt을 반환
     * @return Integer cntrctSnCnt
     */
    public Integer getCntrctSnCnt() {
        return cntrctSnCnt;
    }
    
    /**
     * cntrctSnCnt을 설정
     * @param cntrctSnCnt 을(를) Integer cntrctSnCnt로 설정
     */
    public void setCntrctSnCnt(Integer cntrctSnCnt) {
        this.cntrctSnCnt = cntrctSnCnt;
    }
    
    /**
     * String purchsInsttNm을 반환
     * @return String purchsInsttNm
     */
    public String getPurchsInsttNm() {
        return purchsInsttNm;
    }
    
    /**
     * purchsInsttNm을 설정
     * @param purchsInsttNm 을(를) String purchsInsttNm로 설정
     */
    public void setPurchsInsttNm(String purchsInsttNm) {
        this.purchsInsttNm = purchsInsttNm;
    }
    
    /**
     * List dataList을 반환
     * @return List dataList
     */
    public List getDataList() {
        return dataList;
    }
    
    /**
     * dataList을 설정
     * @param dataList 을(를) List dataList로 설정
     */
    public void setDataList(List dataList) {
        this.dataList = dataList;
    }
    
    /**
     * Integer cntSum을 반환
     * @return Integer cntSum
     */
    public Integer getCntSum() {
        return cntSum;
    }
    
    /**
     * cntSum을 설정
     * @param cntSum 을(를) Integer cntSum로 설정
     */
    public void setCntSum(Integer cntSum) {
        this.cntSum = cntSum;
    }
    
    /**
     * int saasRatio을 반환
     * @return int saasRatio
     */
    public double getSaasRatio() {
        return saasRatio;
    }
    
    /**
     * saasRatio을 설정
     * @param saasRatio 을(를) int saasRatio로 설정
     */
    public void setSaasRatio(double saasRatio) {
        this.saasRatio = saasRatio;
    }
    
    /**
     * int paasRatio을 반환
     * @return int paasRatio
     */
    public double getPaasRatio() {
        return paasRatio;
    }
    
    /**
     * paasRatio을 설정
     * @param paasRatio 을(를) int paasRatio로 설정
     */
    public void setPaasRatio(double paasRatio) {
        this.paasRatio = paasRatio;
    }
    
    /**
     * int iaasRatio을 반환
     * @return int iaasRatio
     */
    public double getIaasRatio() {
        return iaasRatio;
    }
    
    /**
     * iaasRatio을 설정
     * @param iaasRatio 을(를) int iaasRatio로 설정
     */
    public void setIaasRatio(double iaasRatio) {
        this.iaasRatio = iaasRatio;
    }
    
    /**
     * String flag을 반환
     * @return String flag
     */
    public String getFlag() {
        return flag;
    }
    
    /**
     * flag을 설정
     * @param flag 을(를) String flag로 설정
     */
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    /**
     * List cntrDataList을 반환
     * @return List cntrDataList
     */
    public List getCntrDataList() {
        return cntrDataList;
    }
    
    /**
     * cntrDataList을 설정
     * @param cntrDataList 을(를) List cntrDataList로 설정
     */
    public void setCntrDataList(List cntrDataList) {
        this.cntrDataList = cntrDataList;
    }
    
    /**
     * List cntrTpList을 반환
     * @return List cntrTpList
     */
    public List getCntrTpList() {
        return cntrTpList;
    }
    
    /**
     * cntrTpList을 설정
     * @param cntrTpList 을(를) List cntrTpList로 설정
     */
    public void setCntrTpList(List cntrTpList) {
        this.cntrTpList = cntrTpList;
    }
    
    /**
     * Integer aDifSaasCnt을 반환
     * @return Integer aDifSaasCnt
     */
    public Integer getaDifSaasCnt() {
        return aDifSaasCnt;
    }
    
    /**
     * aDifSaasCnt을 설정
     * @param aDifSaasCnt 을(를) Integer aDifSaasCnt로 설정
     */
    public void setaDifSaasCnt(Integer aDifSaasCnt) {
        this.aDifSaasCnt = aDifSaasCnt;
    }
    
    /**
     * Integer aDifPaasCnt을 반환
     * @return Integer aDifPaasCnt
     */
    public Integer getaDifPaasCnt() {
        return aDifPaasCnt;
    }
    
    /**
     * aDifPaasCnt을 설정
     * @param aDifPaasCnt 을(를) Integer aDifPaasCnt로 설정
     */
    public void setaDifPaasCnt(Integer aDifPaasCnt) {
        this.aDifPaasCnt = aDifPaasCnt;
    }
    
    /**
     * Integer aDifIaasCnt을 반환
     * @return Integer aDifIaasCnt
     */
    public Integer getaDifIaasCnt() {
        return aDifIaasCnt;
    }
    
    /**
     * aDifIaasCnt을 설정
     * @param aDifIaasCnt 을(를) Integer aDifIaasCnt로 설정
     */
    public void setaDifIaasCnt(Integer aDifIaasCnt) {
        this.aDifIaasCnt = aDifIaasCnt;
    }
    
    /**
     * Integer aDifGoodsCnt을 반환
     * @return Integer aDifGoodsCnt
     */
    public Integer getaDifGoodsCnt() {
        return aDifGoodsCnt;
    }
    
    /**
     * aDifGoodsCnt을 설정
     * @param aDifGoodsCnt 을(를) Integer aDifGoodsCnt로 설정
     */
    public void setaDifGoodsCnt(Integer aDifGoodsCnt) {
        this.aDifGoodsCnt = aDifGoodsCnt;
    }
    
    /**
     * Integer bDifSaasCnt을 반환
     * @return Integer bDifSaasCnt
     */
    public Integer getbDifSaasCnt() {
        return bDifSaasCnt;
    }
    
    /**
     * bDifSaasCnt을 설정
     * @param bDifSaasCnt 을(를) Integer bDifSaasCnt로 설정
     */
    public void setbDifSaasCnt(Integer bDifSaasCnt) {
        this.bDifSaasCnt = bDifSaasCnt;
    }
    
    /**
     * Integer bDifPaasCnt을 반환
     * @return Integer bDifPaasCnt
     */
    public Integer getbDifPaasCnt() {
        return bDifPaasCnt;
    }
    
    /**
     * bDifPaasCnt을 설정
     * @param bDifPaasCnt 을(를) Integer bDifPaasCnt로 설정
     */
    public void setbDifPaasCnt(Integer bDifPaasCnt) {
        this.bDifPaasCnt = bDifPaasCnt;
    }
    
    /**
     * Integer bDifIaasCnt을 반환
     * @return Integer bDifIaasCnt
     */
    public Integer getbDifIaasCnt() {
        return bDifIaasCnt;
    }
    
    /**
     * bDifIaasCnt을 설정
     * @param bDifIaasCnt 을(를) Integer bDifIaasCnt로 설정
     */
    public void setbDifIaasCnt(Integer bDifIaasCnt) {
        this.bDifIaasCnt = bDifIaasCnt;
    }
    
    /**
     * Integer bDifGoodsCnt을 반환
     * @return Integer bDifGoodsCnt
     */
    public Integer getbDifGoodsCnt() {
        return bDifGoodsCnt;
    }
    
    /**
     * bDifGoodsCnt을 설정
     * @param bDifGoodsCnt 을(를) Integer bDifGoodsCnt로 설정
     */
    public void setbDifGoodsCnt(Integer bDifGoodsCnt) {
        this.bDifGoodsCnt = bDifGoodsCnt;
    }
    
    /**
     * Integer mDifSaasCnt을 반환
     * @return Integer mDifSaasCnt
     */
    public Integer getmDifSaasCnt() {
        return mDifSaasCnt;
    }
    
    /**
     * mDifSaasCnt을 설정
     * @param mDifSaasCnt 을(를) Integer mDifSaasCnt로 설정
     */
    public void setmDifSaasCnt(Integer mDifSaasCnt) {
        this.mDifSaasCnt = mDifSaasCnt;
    }
    
    /**
     * Integer mDifPaasCnt을 반환
     * @return Integer mDifPaasCnt
     */
    public Integer getmDifPaasCnt() {
        return mDifPaasCnt;
    }
    
    /**
     * mDifPaasCnt을 설정
     * @param mDifPaasCnt 을(를) Integer mDifPaasCnt로 설정
     */
    public void setmDifPaasCnt(Integer mDifPaasCnt) {
        this.mDifPaasCnt = mDifPaasCnt;
    }
    
    /**
     * Integer mDifIaasCnt을 반환
     * @return Integer mDifIaasCnt
     */
    public Integer getmDifIaasCnt() {
        return mDifIaasCnt;
    }
    
    /**
     * mDifIaasCnt을 설정
     * @param mDifIaasCnt 을(를) Integer mDifIaasCnt로 설정
     */
    public void setmDifIaasCnt(Integer mDifIaasCnt) {
        this.mDifIaasCnt = mDifIaasCnt;
    }
    
    /**
     * Integer mDifGoodsCnt을 반환
     * @return Integer mDifGoodsCnt
     */
    public Integer getmDifGoodsCnt() {
        return mDifGoodsCnt;
    }
    
    /**
     * mDifGoodsCnt을 설정
     * @param mDifGoodsCnt 을(를) Integer mDifGoodsCnt로 설정
     */
    public void setmDifGoodsCnt(Integer mDifGoodsCnt) {
        this.mDifGoodsCnt = mDifGoodsCnt;
    }
    
    /**
     * Integer bsDifSaasCnt을 반환
     * @return Integer bsDifSaasCnt
     */
    public Integer getBsDifSaasCnt() {
        return bsDifSaasCnt;
    }
    
    /**
     * bsDifSaasCnt을 설정
     * @param bsDifSaasCnt 을(를) Integer bsDifSaasCnt로 설정
     */
    public void setBsDifSaasCnt(Integer bsDifSaasCnt) {
        this.bsDifSaasCnt = bsDifSaasCnt;
    }
    
    /**
     * Integer bsDifPaasCnt을 반환
     * @return Integer bsDifPaasCnt
     */
    public Integer getBsDifPaasCnt() {
        return bsDifPaasCnt;
    }
    
    /**
     * bsDifPaasCnt을 설정
     * @param bsDifPaasCnt 을(를) Integer bsDifPaasCnt로 설정
     */
    public void setBsDifPaasCnt(Integer bsDifPaasCnt) {
        this.bsDifPaasCnt = bsDifPaasCnt;
    }
    
    /**
     * Integer bsDifIaasCnt을 반환
     * @return Integer bsDifIaasCnt
     */
    public Integer getBsDifIaasCnt() {
        return bsDifIaasCnt;
    }
    
    /**
     * bsDifIaasCnt을 설정
     * @param bsDifIaasCnt 을(를) Integer bsDifIaasCnt로 설정
     */
    public void setBsDifIaasCnt(Integer bsDifIaasCnt) {
        this.bsDifIaasCnt = bsDifIaasCnt;
    }
    
    /**
     * Integer bsDifGoodsCnt을 반환
     * @return Integer bsDifGoodsCnt
     */
    public Integer getBsDifGoodsCnt() {
        return bsDifGoodsCnt;
    }
    
    /**
     * bsDifGoodsCnt을 설정
     * @param bsDifGoodsCnt 을(를) Integer bsDifGoodsCnt로 설정
     */
    public void setBsDifGoodsCnt(Integer bsDifGoodsCnt) {
        this.bsDifGoodsCnt = bsDifGoodsCnt;
    }

    
    /**
     * Integer difCntrctAmount을 반환
     * @return Integer difCntrctAmount
     */
    public String getDifCntrctAmount() {
        return difCntrctAmount;
    }

    
    /**
     * difCntrctAmount을 설정
     * @param difCntrctAmount 을(를) Integer difCntrctAmount로 설정
     */
    public void setDifCntrctAmount(String difCntrctAmount) {
        this.difCntrctAmount = difCntrctAmount;
    }

    
    /**
     * Integer difCntrctSnCnt을 반환
     * @return Integer difCntrctSnCnt
     */
    public Integer getDifCntrctSnCnt() {
        return difCntrctSnCnt;
    }

    
    /**
     * difCntrctSnCnt을 설정
     * @param difCntrctSnCnt 을(를) Integer difCntrctSnCnt로 설정
     */
    public void setDifCntrctSnCnt(Integer difCntrctSnCnt) {
        this.difCntrctSnCnt = difCntrctSnCnt;
    }

    
    /**
     * String qnaState을 반환
     * @return String qnaState
     */
    public String getQnaState() {
        return qnaState;
    }

    
    /**
     * qnaState을 설정
     * @param qnaState 을(를) String qnaState로 설정
     */
    public void setQnaState(String qnaState) {
        this.qnaState = qnaState;
    }

    
    /**
     * Integer qnaStateCnt을 반환
     * @return Integer qnaStateCnt
     */
    public Integer getQnaStateCnt() {
        return qnaStateCnt;
    }

    
    /**
     * qnaStateCnt을 설정
     * @param qnaStateCnt 을(를) Integer qnaStateCnt로 설정
     */
    public void setQnaStateCnt(Integer qnaStateCnt) {
        this.qnaStateCnt = qnaStateCnt;
    }

    
    /**
     * String bizState을 반환
     * @return String bizState
     */
    public String getBizState() {
        return bizState;
    }

    
    /**
     * bizState을 설정
     * @param bizState 을(를) String bizState로 설정
     */
    public void setBizState(String bizState) {
        this.bizState = bizState;
    }

    
    /**
     * Integer bizStateCnt을 반환
     * @return Integer bizStateCnt
     */
    public Integer getBizStateCnt() {
        return bizStateCnt;
    }

    
    /**
     * bizStateCnt을 설정
     * @param bizStateCnt 을(를) Integer bizStateCnt로 설정
     */
    public void setBizStateCnt(Integer bizStateCnt) {
        this.bizStateCnt = bizStateCnt;
    }

    
    /**
     * String goodsQnaState을 반환
     * @return String goodsQnaState
     */
    public String getGoodsQnaState() {
        return goodsQnaState;
    }

    
    /**
     * goodsQnaState을 설정
     * @param goodsQnaState 을(를) String goodsQnaState로 설정
     */
    public void setGoodsQnaState(String goodsQnaState) {
        this.goodsQnaState = goodsQnaState;
    }

    
    /**
     * Integer goodsQnaStateCnt을 반환
     * @return Integer goodsQnaStateCnt
     */
    public Integer getGoodsQnaStateCnt() {
        return goodsQnaStateCnt;
    }

    
    /**
     * goodsQnaStateCnt을 설정
     * @param goodsQnaStateCnt 을(를) Integer goodsQnaStateCnt로 설정
     */
    public void setGoodsQnaStateCnt(Integer goodsQnaStateCnt) {
        this.goodsQnaStateCnt = goodsQnaStateCnt;
    }

    
    /**
     * Integer scsCnt을 반환
     * @return Integer scsCnt
     */
    public Integer getScsCnt() {
        return scsCnt;
    }

    
    /**
     * scsCnt을 설정
     * @param scsCnt 을(를) Integer scsCnt로 설정
     */
    public void setScsCnt(Integer scsCnt) {
        this.scsCnt = scsCnt;
    }

    
    /**
     * Integer scsRate을 반환
     * @return Integer scsRate
     */
    public Integer getScsRate() {
        return scsRate;
    }

    
    /**
     * scsRate을 설정
     * @param scsRate 을(를) Integer scsRate로 설정
     */
    public void setScsRate(Integer scsRate) {
        this.scsRate = scsRate;
    }

    
    /**
     * Integer aScsCnt을 반환
     * @return Integer aScsCnt
     */
    public Integer getaScsCnt() {
        return aScsCnt;
    }

    
    /**
     * aScsCnt을 설정
     * @param aScsCnt 을(를) Integer aScsCnt로 설정
     */
    public void setaScsCnt(Integer aScsCnt) {
        this.aScsCnt = aScsCnt;
    }

    
    /**
     * Integer bScsCnt을 반환
     * @return Integer bScsCnt
     */
    public Integer getbScsCnt() {
        return bScsCnt;
    }

    
    /**
     * bScsCnt을 설정
     * @param bScsCnt 을(를) Integer bScsCnt로 설정
     */
    public void setbScsCnt(Integer bScsCnt) {
        this.bScsCnt = bScsCnt;
    }

    
    /**
     * Integer mScsCnt을 반환
     * @return Integer mScsCnt
     */
    public Integer getmScsCnt() {
        return mScsCnt;
    }

    
    /**
     * mScsCnt을 설정
     * @param mScsCnt 을(를) Integer mScsCnt로 설정
     */
    public void setmScsCnt(Integer mScsCnt) {
        this.mScsCnt = mScsCnt;
    }

    
    /**
     * Integer bsScsCnt을 반환
     * @return Integer bsScsCnt
     */
    public Integer getBsScsCnt() {
        return bsScsCnt;
    }

    
    /**
     * bsScsCnt을 설정
     * @param bsScsCnt 을(를) Integer bsScsCnt로 설정
     */
    public void setBsScsCnt(Integer bsScsCnt) {
        this.bsScsCnt = bsScsCnt;
    }

    
    /**
     * int scsRatio을 반환
     * @return int scsRatio
     */
    public double getScsRatio() {
        return scsRatio;
    }

    
    /**
     * scsRatio을 설정
     * @param scsRatio 을(를) int scsRatio로 설정
     */
    public void setScsRatio(double scsRatio) {
        this.scsRatio = scsRatio;
    }

    
    /**
     * Integer aDifScsCnt을 반환
     * @return Integer aDifScsCnt
     */
    public Integer getaDifScsCnt() {
        return aDifScsCnt;
    }

    
    /**
     * aDifScsCnt을 설정
     * @param aDifScsCnt 을(를) Integer aDifScsCnt로 설정
     */
    public void setaDifScsCnt(Integer aDifScsCnt) {
        this.aDifScsCnt = aDifScsCnt;
    }

    
    /**
     * Integer bDifScsCnt을 반환
     * @return Integer bDifScsCnt
     */
    public Integer getbDifScsCnt() {
        return bDifScsCnt;
    }

    
    /**
     * bDifScsCnt을 설정
     * @param bDifScsCnt 을(를) Integer bDifScsCnt로 설정
     */
    public void setbDifScsCnt(Integer bDifScsCnt) {
        this.bDifScsCnt = bDifScsCnt;
    }

    
    /**
     * Integer mDifScsCnt을 반환
     * @return Integer mDifScsCnt
     */
    public Integer getmDifScsCnt() {
        return mDifScsCnt;
    }

    
    /**
     * mDifScsCnt을 설정
     * @param mDifScsCnt 을(를) Integer mDifScsCnt로 설정
     */
    public void setmDifScsCnt(Integer mDifScsCnt) {
        this.mDifScsCnt = mDifScsCnt;
    }

    
    /**
     * Integer bsDifScsCnt을 반환
     * @return Integer bsDifScsCnt
     */
    public Integer getBsDifScsCnt() {
        return bsDifScsCnt;
    }

    
    /**
     * bsDifScsCnt을 설정
     * @param bsDifScsCnt 을(를) Integer bsDifScsCnt로 설정
     */
    public void setBsDifScsCnt(Integer bsDifScsCnt) {
        this.bsDifScsCnt = bsDifScsCnt;
    }
    

}
