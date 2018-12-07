/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.analyze.statistic.common;

import java.util.ArrayList;
import java.util.List;

import zes.base.vo.FileVO;

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
 *  2012. 5. 11.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class ResultVO extends SearchVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -5348100642977481802L;

    /** 리스트 좌측 텍스트 */
    private String title = "";

    /** 통계값 1 */
    private Integer value = 0;
    /** 통계값 1 */
    private Integer value1 = 0;

    /** 통계값 2 */
    private Integer value2 = 0;

    /** 통계값 3 */
    private Integer value3 = 0;

    /** 통계값 34 */
    private Integer value4 = 0;

    /** 통계값 5 */
    private Integer value5 = 0;

    /** 통계값 6 */
    private Integer value6 = 0;

    /** 통계값 7 */
    private Integer value7 = 0;

    /** 통계값 8 */
    private Integer value8 = 0;

    /** 통계값 9 */
    private Integer value9 = 0;

    /** 통계값 10 */
    private Integer value10 = 0;

    /** 통계값(문자) 1 */
    private String textValue = "";

    /** 통계값(문자) 2 */
    private String textValue2 = "";

    /** 통계값(문자) 3 */
    private String textValue3 = "";

    /** 비율값 */
    private Float rateValue = 0.0f;

    /** 비율값2 */
    private Float rateValue2 = 0.0f;

    /** 모바일 통계값 */
    private Integer mobileValue = 0;

    /** 모바일 통계값2 */
    private Integer mobileValue2 = 0;

    /** 모바일 통계값3 */
    private Integer mobileValue3 = 0;

    /** 모바일 통계값4 */
    private Integer mobileValue4 = 0;

    /** 모바일 통계값5 */
    private Integer mobileValue5 = 0;

    /** 모바일 비율값 통계값3 */
    private Float rateMobileValue = 0.0f;

    /** 기타 통계값 */
    private List<Integer> values = new ArrayList<Integer>();

    /** 기타 통계값(모바일) */
    private List<Integer> mobileValues = new ArrayList<Integer>();

    /** 증감 */
    private Integer variation = 0;

    /** 증감(모바일) */
    private Integer mobileVariation = 0;

    /** 서비스통계 */
    private String langCode;
    private String langNm;
    private Integer ctgryClCd;
    private String ctgryClNm;
    private Integer depthCnt0;
    private String depthCd1;
    private String depthNm1;
    private Integer depthCnt1;
    private String depthCd2;
    private String depthNm2;
    private Integer depthCnt2;
    private String depthCd3;
    private String depthNm3;
    private Integer tCnt;
    private Integer pCnt;
    private Integer cCnt;
    private Integer gCnt;
    
    private String issueDate;
    private String basicDate;
    private String flag;
    
    private List dataList;
    
    private List cntrDataList;
    private List cntrTpList;
    private List cntrCorpList;
    
    private Integer saasCnt;
    private Integer paasCnt;
    private Integer iaasCnt;
    private Integer cntSum;
    
    private Integer priveCnt;
    private Integer corpCnt;
    private Integer orgCnt;
    private String cntrDt;
    
    private String svcNm;
    
    /*계약순번*/
    private int cntrctSn;
    /*계약순번 배열*/
    private String[] cntrctSns;
    /*회원아이디*/
    private String userId;
    private String userTyCd;
    /*서비스명*/
    /*계약시작일자*/
    private String cntrctBeginDe;
    /*계약종료일자*/
    private String cntrctEndDe;
    /*계약금액*/
    private Long cntrctamount;
    /*구매기관*/
    private String purchsInsttNm;
    /*판매기관*/
    private String sleInsttNm;
    /*계약서순번*/
    private int ctrtcSn;
    /*등록아이디*/
    private String registId;
    /*등록일시*/
    private String registDt;
    /*수정아이디*/
    private String updtId;
    /*수정일시*/
    private String updtDt;
    /*삭제여부*/
    private String deleteAt;

    private List<FileVO> ctrtcFile;

    private String tempUserSn; 
    private String cntrCount;
    private String goodsNm;
    private String bidGbnNm;
    
    /*계약실적여부 : Y: 계약실적, N: 계약관리*/
    private String useAt;
    
    private String goodsCode;
    private String goodsKnd;
    private Integer privAmount;
    private Integer corpAmount;
    private Integer orgAmount;
    
    
    /**
     * String goodsCode을 반환
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }

    
    /**
     * goodsCode을 설정
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    /**
     * String title을 반환
     *
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    /**
     * title을 설정
     *
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Integer value을 반환
     *
     * @return Integer value
     */
    public Integer getValue() {
        return value;
    }

    /**
     * value을 설정
     *
     * @param value 을(를) Integer value로 설정
     */
    public void setValue(Integer value) {
        this.value = value;
    }

    /**
     * Integer mobileValue을 반환
     *
     * @return Integer mobileValue
     */
    public Integer getMobileValue() {
        return mobileValue;
    }

    /**
     * mobileValue을 설정
     *
     * @param mobileValue 을(를) Integer mobileValue로 설정
     */
    public void setMobileValue(Integer mobileValue) {
        this.mobileValue = mobileValue;
    }

    /**
     * List<Integer> values을 반환
     *
     * @return List<Integer> values
     */
    public List<Integer> getValues() {
        return values;
    }

    /**
     * values을 설정
     *
     * @param values 을(를) List<Integer> values로 설정
     */
    public void setValues(List<Integer> values) {
        this.values = values;
    }

    /**
     * List<Integer> mobileValues을 반환
     *
     * @return List<Integer> mobileValues
     */
    public List<Integer> getMobileValues() {
        return mobileValues;
    }

    /**
     * mobileValues을 설정
     *
     * @param mobileValues 을(를) List<Integer> mobileValues로 설정
     */
    public void setMobileValues(List<Integer> mobileValues) {
        this.mobileValues = mobileValues;
    }

    /**
     * Integer variation을 반환
     *
     * @return Integer variation
     */
    public Integer getVariation() {
        return variation;
    }

    /**
     * variation을 설정
     *
     * @param variation 을(를) Integer variation로 설정
     */
    public void setVariation(Integer variation) {
        this.variation = variation;
    }

    /**
     * Integer mobileVariation을 반환
     *
     * @return Integer mobileVariation
     */
    public Integer getMobileVariation() {
        return mobileVariation;
    }

    /**
     * mobileVariation을 설정
     *
     * @param mobileVariation 을(를) Integer mobileVariation로 설정
     */
    public void setMobileVariation(Integer mobileVariation) {
        this.mobileVariation = mobileVariation;
    }

    /**
     * Integer value2을 반환
     *
     * @return Integer value2
     */
    public Integer getValue2() {
        return value2;
    }

    /**
     * value2을 설정
     *
     * @param value2 을(를) Integer value2로 설정
     */
    public void setValue2(Integer value2) {
        this.value2 = value2;
    }

    /**
     * Integer value3을 반환
     *
     * @return Integer value3
     */
    public Integer getValue3() {
        return value3;
    }

    /**
     * value3을 설정
     *
     * @param value3 을(를) Integer value3로 설정
     */
    public void setValue3(Integer value3) {
        this.value3 = value3;
    }

    /**
     * Integer mobileValue2을 반환
     *
     * @return Integer mobileValue2
     */
    public Integer getMobileValue2() {
        return mobileValue2;
    }

    /**
     * mobileValue2을 설정
     *
     * @param mobileValue2 을(를) Integer mobileValue2로 설정
     */
    public void setMobileValue2(Integer mobileValue2) {
        this.mobileValue2 = mobileValue2;
    }

    /**
     * Integer mobileValue3을 반환
     *
     * @return Integer mobileValue3
     */
    public Integer getMobileValue3() {
        return mobileValue3;
    }

    /**
     * mobileValue3을 설정
     *
     * @param mobileValue3 을(를) Integer mobileValue3로 설정
     */
    public void setMobileValue3(Integer mobileValue3) {
        this.mobileValue3 = mobileValue3;
    }

    /**
     * Float rateValue을 반환
     *
     * @return Float rateValue
     */
    public Float getRateValue() {
        return rateValue;
    }

    /**
     * rateValue을 설정
     *
     * @param rateValue 을(를) Float rateValue로 설정
     */
    public void setRateValue(Float rateValue) {
        this.rateValue = rateValue;
    }

    /**
     * Float rateMobileValue을 반환
     *
     * @return Float rateMobileValue
     */
    public Float getRateMobileValue() {
        return rateMobileValue;
    }

    /**
     * rateMobileValue을 설정
     *
     * @param rateMobileValue 을(를) Float rateMobileValue로 설정
     */
    public void setRateMobileValue(Float rateMobileValue) {
        this.rateMobileValue = rateMobileValue;
    }

    /**
     * Integer value4을 반환
     *
     * @return Integer value4
     */
    public Integer getValue4() {
        return value4;
    }

    /**
     * value4을 설정
     *
     * @param value4 을(를) Integer value4로 설정
     */
    public void setValue4(Integer value4) {
        this.value4 = value4;
    }

    /**
     * Integer value5을 반환
     *
     * @return Integer value5
     */
    public Integer getValue5() {
        return value5;
    }

    /**
     * value5을 설정
     *
     * @param value5 을(를) Integer value5로 설정
     */
    public void setValue5(Integer value5) {
        this.value5 = value5;
    }

    /**
     * Integer mobileValue4을 반환
     *
     * @return Integer mobileValue4
     */
    public Integer getMobileValue4() {
        return mobileValue4;
    }

    /**
     * mobileValue4을 설정
     *
     * @param mobileValue4 을(를) Integer mobileValue4로 설정
     */
    public void setMobileValue4(Integer mobileValue4) {
        this.mobileValue4 = mobileValue4;
    }

    /**
     * Integer mobileValue5을 반환
     *
     * @return Integer mobileValue5
     */
    public Integer getMobileValue5() {
        return mobileValue5;
    }

    /**
     * mobileValue5을 설정
     *
     * @param mobileValue5 을(를) Integer mobileValue5로 설정
     */
    public void setMobileValue5(Integer mobileValue5) {
        this.mobileValue5 = mobileValue5;
    }

    /**
     * Float rateValue2을 반환
     *
     * @return Float rateValue2
     */
    public Float getRateValue2() {
        return rateValue2;
    }

    /**
     * rateValue2을 설정
     *
     * @param rateValue2 을(를) Float rateValue2로 설정
     */
    public void setRateValue2(Float rateValue2) {
        this.rateValue2 = rateValue2;
    }

    /**
     * Integer value6을 반환
     *
     * @return Integer value6
     */
    public Integer getValue6() {
        return value6;
    }

    /**
     * value6을 설정
     *
     * @param value6 을(를) Integer value6로 설정
     */
    public void setValue6(Integer value6) {
        this.value6 = value6;
    }

    /**
     * Integer value7을 반환
     *
     * @return Integer value7
     */
    public Integer getValue7() {
        return value7;
    }

    /**
     * value7을 설정
     *
     * @param value7 을(를) Integer value7로 설정
     */
    public void setValue7(Integer value7) {
        this.value7 = value7;
    }

    /**
     * Integer value8을 반환
     *
     * @return Integer value8
     */
    public Integer getValue8() {
        return value8;
    }

    /**
     * value8을 설정
     *
     * @param value8 을(를) Integer value8로 설정
     */
    public void setValue8(Integer value8) {
        this.value8 = value8;
    }

    /**
     * Integer value9을 반환
     *
     * @return Integer value9
     */
    public Integer getValue9() {
        return value9;
    }

    /**
     * value9을 설정
     *
     * @param value9 을(를) Integer value9로 설정
     */
    public void setValue9(Integer value9) {
        this.value9 = value9;
    }

    /**
     * Integer value10을 반환
     *
     * @return Integer value10
     */
    public Integer getValue10() {
        return value10;
    }

    /**
     * value10을 설정
     *
     * @param value10 을(를) Integer value10로 설정
     */
    public void setValue10(Integer value10) {
        this.value10 = value10;
    }

    /**
     * String textValue을 반환
     *
     * @return String textValue
     */
    public String getTextValue() {
        return textValue;
    }

    /**
     * textValue을 설정
     *
     * @param textValue 을(를) String textValue로 설정
     */
    public void setTextValue(String textValue) {
        this.textValue = textValue;
    }

    /**
     * String textValue2을 반환
     *
     * @return String textValue2
     */
    public String getTextValue2() {
        return textValue2;
    }

    /**
     * textValue2을 설정
     *
     * @param textValue2 을(를) String textValue2로 설정
     */
    public void setTextValue2(String textValue2) {
        this.textValue2 = textValue2;
    }

    /**
     * String textValue3을 반환
     *
     * @return String textValue3
     */
    public String getTextValue3() {
        return textValue3;
    }

    /**
     * textValue3을 설정
     *
     * @param textValue3 을(를) String textValue3로 설정
     */
    public void setTextValue3(String textValue3) {
        this.textValue3 = textValue3;
    }


    /**
     * Integer value1을 반환
     * @return Integer value1
     */
    public Integer getValue1() {
        return value1;
    }


    /**
     * value1을 설정
     * @param value1 을(를) Integer value1로 설정
     */
    public void setValue1(Integer value1) {
        this.value1 = value1;
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
     * Integer ctgryClCd을 반환
     * @return Integer ctgryClCd
     */
    public Integer getCtgryClCd() {
        return ctgryClCd;
    }

    /**
     * ctgryClCd을 설정
     * @param ctgryClCd 을(를) Integer ctgryClCd로 설정
     */
    public void setCtgryClCd(Integer ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }

    /**
     * String ctgryClNm을 반환
     * @return String ctgryClNm
     */
    public String getCtgryClNm() {
        return ctgryClNm;
    }

    /**
     * ctgryClNm을 설정
     * @param ctgryClNm 을(를) String ctgryClNm로 설정
     */
    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }

    /**
     * Integer depthCnt0을 반환
     * @return Integer depthCnt0
     */
    public Integer getDepthCnt0() {
        return depthCnt0;
    }

    /**
     * depthCnt0을 설정
     * @param depthCnt0 을(를) Integer depthCnt0로 설정
     */
    public void setDepthCnt0(Integer depthCnt0) {
        this.depthCnt0 = depthCnt0;
    }

    /**
     * String depthCd1을 반환
     * @return String depthCd1
     */
    public String getDepthCd1() {
        return depthCd1;
    }

    /**
     * depthCd1을 설정
     * @param depthCd1 을(를) String depthCd1로 설정
     */
    public void setDepthCd1(String depthCd1) {
        this.depthCd1 = depthCd1;
    }

    /**
     * String depthNm1을 반환
     * @return String depthNm1
     */
    public String getDepthNm1() {
        return depthNm1;
    }

    /**
     * depthNm1을 설정
     * @param depthNm1 을(를) String depthNm1로 설정
     */
    public void setDepthNm1(String depthNm1) {
        this.depthNm1 = depthNm1;
    }

    /**
     * Integer depthCnt1을 반환
     * @return Integer depthCnt1
     */
    public Integer getDepthCnt1() {
        return depthCnt1;
    }

    /**
     * depthCnt1을 설정
     * @param depthCnt1 을(를) Integer depthCnt1로 설정
     */
    public void setDepthCnt1(Integer depthCnt1) {
        this.depthCnt1 = depthCnt1;
    }

    /**
     * String depthCd2을 반환
     * @return String depthCd2
     */
    public String getDepthCd2() {
        return depthCd2;
    }

    /**
     * depthCd2을 설정
     * @param depthCd2 을(를) String depthCd2로 설정
     */
    public void setDepthCd2(String depthCd2) {
        this.depthCd2 = depthCd2;
    }

    /**
     * String depthNm2을 반환
     * @return String depthNm2
     */
    public String getDepthNm2() {
        return depthNm2;
    }

    /**
     * depthNm2을 설정
     * @param depthNm2 을(를) String depthNm2로 설정
     */
    public void setDepthNm2(String depthNm2) {
        this.depthNm2 = depthNm2;
    }

    /**
     * Integer depthCnt2을 반환
     * @return Integer depthCnt2
     */
    public Integer getDepthCnt2() {
        return depthCnt2;
    }

    /**
     * depthCnt2을 설정
     * @param depthCnt2 을(를) Integer depthCnt2로 설정
     */
    public void setDepthCnt2(Integer depthCnt2) {
        this.depthCnt2 = depthCnt2;
    }

    /**
     * String depthCd3을 반환
     * @return String depthCd3
     */
    public String getDepthCd3() {
        return depthCd3;
    }

    /**
     * depthCd3을 설정
     * @param depthCd3 을(를) String depthCd3로 설정
     */
    public void setDepthCd3(String depthCd3) {
        this.depthCd3 = depthCd3;
    }

    /**
     * String depthNm3을 반환
     * @return String depthNm3
     */
    public String getDepthNm3() {
        return depthNm3;
    }

    /**
     * depthNm3을 설정
     * @param depthNm3 을(를) String depthNm3로 설정
     */
    public void setDepthNm3(String depthNm3) {
        this.depthNm3 = depthNm3;
    }

    /**
     * Integer tCnt을 반환
     * @return Integer tCnt
     */
    public Integer gettCnt() {
        return tCnt;
    }

    /**
     * tCnt을 설정
     * @param tCnt 을(를) Integer tCnt로 설정
     */
    public void settCnt(Integer tCnt) {
        this.tCnt = tCnt;
    }

    /**
     * Integer pCnt을 반환
     * @return Integer pCnt
     */
    public Integer getpCnt() {
        return pCnt;
    }

    /**
     * pCnt을 설정
     * @param pCnt 을(를) Integer pCnt로 설정
     */
    public void setpCnt(Integer pCnt) {
        this.pCnt = pCnt;
    }

    /**
     * Integer cCnt을 반환
     * @return Integer cCnt
     */
    public Integer getcCnt() {
        return cCnt;
    }

    /**
     * cCnt을 설정
     * @param cCnt 을(를) Integer cCnt로 설정
     */
    public void setcCnt(Integer cCnt) {
        this.cCnt = cCnt;
    }

    /**
     * Integer gCnt을 반환
     * @return Integer gCnt
     */
    public Integer getgCnt() {
        return gCnt;
    }

    /**
     * gCnt을 설정
     * @param gCnt 을(를) Integer gCnt로 설정
     */
    public void setgCnt(Integer gCnt) {
        this.gCnt = gCnt;
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
     * String issueDate을 반환
     * @return String issueDate
     */
    public String getIssueDate() {
        return issueDate;
    }
    
    /**
     * setIssueDate 설명
     * @param issueDate
     */
    public void setIssueDate(String issueDate) {
        this.issueDate = issueDate; 
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
     * List tpDataList을 반환
     * @return List tpDataList
     */
    public List getCntrTpList() {
        return cntrTpList;
    }

    
    /**
     * tpDataList을 설정
     * @param tpDataList 을(를) List tpDataList로 설정
     */
    public void setCntrTpList(List cntrTpList) {
        this.cntrTpList = cntrTpList;
    }

    
    /**
     * List cntrctCorpList을 반환
     * @return List cntrctCorpList
     */
    public List getCntrCorpList() {
        return cntrCorpList;
    }

    
    /**
     * cntrctCorpList을 설정
     * @param cntrctCorpList 을(를) List cntrctCorpList로 설정
     */
    public void setCntrCorpList(List cntrCorpList) {
        this.cntrCorpList = cntrCorpList;
    }

    
    /**
     * Integer priveCnt을 반환
     * @return Integer priveCnt
     */
    public Integer getPriveCnt() {
        return priveCnt;
    }

    
    /**
     * priveCnt을 설정
     * @param priveCnt 을(를) Integer priveCnt로 설정
     */
    public void setPriveCnt(Integer priveCnt) {
        this.priveCnt = priveCnt;
    }

    
    /**
     * Integer corpCnt을 반환
     * @return Integer corpCnt
     */
    public Integer getCorpCnt() {
        return corpCnt;
    }

    
    /**
     * corpCnt을 설정
     * @param corpCnt 을(를) Integer corpCnt로 설정
     */
    public void setCorpCnt(Integer corpCnt) {
        this.corpCnt = corpCnt;
    }

    
    /**
     * Integer orgCnt을 반환
     * @return Integer orgCnt
     */
    public Integer getOrgCnt() {
        return orgCnt;
    }

    
    /**
     * orgCnt을 설정
     * @param orgCnt 을(를) Integer orgCnt로 설정
     */
    public void setOrgCnt(Integer orgCnt) {
        this.orgCnt = orgCnt;
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
     * String svcNm을 반환
     * @return String svcNm
     */
    public String getSvcNm() {
        return svcNm;
    }

    
    /**
     * svcNm을 설정
     * @param svcNm 을(를) String svcNm로 설정
     */
    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }

    
    /**
     * int cntrctSn을 반환
     * @return int cntrctSn
     */
    public int getCntrctSn() {
        return cntrctSn;
    }

    
    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) int cntrctSn로 설정
     */
    public void setCntrctSn(int cntrctSn) {
        this.cntrctSn = cntrctSn;
    }

    
    /**
     * String[] cntrctSns을 반환
     * @return String[] cntrctSns
     */
    public String[] getCntrctSns() {
        return cntrctSns;
    }

    
    /**
     * cntrctSns을 설정
     * @param cntrctSns 을(를) String[] cntrctSns로 설정
     */
    public void setCntrctSns(String[] cntrctSns) {
        this.cntrctSns = cntrctSns;
    }

    
    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return userId;
    }

    
    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * String userTyCd을 반환
     * @return String userTyCd
     */
    public String getUserTyCd() {
        return userTyCd;
    }


    /**
     * userTyCd을 설정
     * @param userTyCd 을(를) String userTyCd로 설정
     */
    public void setUserTyCd(String userTyCd) {
        this.userTyCd = userTyCd;
    }

    
    /**
     * String cntrctBeginDe을 반환
     * @return String cntrctBeginDe
     */
    public String getCntrctBeginDe() {
        return cntrctBeginDe;
    }

    
    /**
     * cntrctBeginDe을 설정
     * @param cntrctBeginDe 을(를) String cntrctBeginDe로 설정
     */
    public void setCntrctBeginDe(String cntrctBeginDe) {
        this.cntrctBeginDe = cntrctBeginDe;
    }

    
    /**
     * String cntrctEndDe을 반환
     * @return String cntrctEndDe
     */
    public String getCntrctEndDe() {
        return cntrctEndDe;
    }

    
    /**
     * cntrctEndDe을 설정
     * @param cntrctEndDe 을(를) String cntrctEndDe로 설정
     */
    public void setCntrctEndDe(String cntrctEndDe) {
        this.cntrctEndDe = cntrctEndDe;
    }

    
    /**
     * Long cntrctamount을 반환
     * @return Long cntrctamount
     */
    public Long getCntrctamount() {
        return cntrctamount;
    }

    
    /**
     * cntrctamount을 설정
     * @param cntrctamount 을(를) Long cntrctamount로 설정
     */
    public void setCntrctamount(Long cntrctamount) {
        this.cntrctamount = cntrctamount;
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
     * String sleInsttNm을 반환
     * @return String sleInsttNm
     */
    public String getSleInsttNm() {
        return sleInsttNm;
    }

    
    /**
     * sleInsttNm을 설정
     * @param sleInsttNm 을(를) String sleInsttNm로 설정
     */
    public void setSleInsttNm(String sleInsttNm) {
        this.sleInsttNm = sleInsttNm;
    }

    
    /**
     * int ctrtcSn을 반환
     * @return int ctrtcSn
     */
    public int getCtrtcSn() {
        return ctrtcSn;
    }

    
    /**
     * ctrtcSn을 설정
     * @param ctrtcSn 을(를) int ctrtcSn로 설정
     */
    public void setCtrtcSn(int ctrtcSn) {
        this.ctrtcSn = ctrtcSn;
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
     * String updtId을 반환
     * @return String updtId
     */
    public String getUpdtId() {
        return updtId;
    }

    
    /**
     * updtId을 설정
     * @param updtId 을(를) String updtId로 설정
     */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    
    /**
     * String updtDt을 반환
     * @return String updtDt
     */
    public String getUpdtDt() {
        return updtDt;
    }

    
    /**
     * updtDt을 설정
     * @param updtDt 을(를) String updtDt로 설정
     */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    
    /**
     * String deleteAt을 반환
     * @return String deleteAt
     */
    public String getDeleteAt() {
        return deleteAt;
    }

    
    /**
     * deleteAt을 설정
     * @param deleteAt 을(를) String deleteAt로 설정
     */
    public void setDeleteAt(String deleteAt) {
        this.deleteAt = deleteAt;
    }

    
    /**
     * List<FileVO> ctrtcFile을 반환
     * @return List<FileVO> ctrtcFile
     */
    public List<FileVO> getCtrtcFile() {
        return ctrtcFile;
    }

    
    /**
     * ctrtcFile을 설정
     * @param ctrtcFile 을(를) List<FileVO> ctrtcFile로 설정
     */
    public void setCtrtcFile(List<FileVO> ctrtcFile) {
        this.ctrtcFile = ctrtcFile;
    }

    
    /**
     * String tempUserSn을 반환
     * @return String tempUserSn
     */
    public String getTempUserSn() {
        return tempUserSn;
    }

    
    /**
     * tempUserSn을 설정
     * @param tempUserSn 을(를) String tempUserSn로 설정
     */
    public void setTempUserSn(String tempUserSn) {
        this.tempUserSn = tempUserSn;
    }

    
    /**
     * String cntrCount을 반환
     * @return String cntrCount
     */
    public String getCntrCount() {
        return cntrCount;
    }

    
    /**
     * cntrCount을 설정
     * @param cntrCount 을(를) String cntrCount로 설정
     */
    public void setCntrCount(String cntrCount) {
        this.cntrCount = cntrCount;
    }

    
    /**
     * String goodsNm을 반환
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }

    
    /**
     * goodsNm을 설정
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    
    /**
     * String bidGbnNm을 반환
     * @return String bidGbnNm
     */
    public String getBidGbnNm() {
        return bidGbnNm;
    }

    
    /**
     * bidGbnNm을 설정
     * @param bidGbnNm 을(를) String bidGbnNm로 설정
     */
    public void setBidGbnNm(String bidGbnNm) {
        this.bidGbnNm = bidGbnNm;
    }

    
    /**
     * String useAt을 반환
     * @return String useAt
     */
    public String getUseAt() {
        return useAt;
    }

    
    /**
     * useAt을 설정
     * @param useAt 을(를) String useAt로 설정
     */
    public void setUseAt(String useAt) {
        this.useAt = useAt;
    }


    
    /**
     * String goodsKnd을 반환
     * @return String goodsKnd
     */
    public String getGoodsKnd() {
        return goodsKnd;
    }


    
    /**
     * goodsKnd을 설정
     * @param goodsKnd 을(를) String goodsKnd로 설정
     */
    public void setGoodsKnd(String goodsKnd) {
        this.goodsKnd = goodsKnd;
    }


    
    /**
     * Integer privAmount을 반환
     * @return Integer privAmount
     */
    public Integer getPrivAmount() {
        return privAmount;
    }


    
    /**
     * privAmount을 설정
     * @param privAmount 을(를) Integer privAmount로 설정
     */
    public void setPrivAmount(Integer privAmount) {
        this.privAmount = privAmount;
    }


    
    /**
     * Integer corpAmount을 반환
     * @return Integer corpAmount
     */
    public Integer getCorpAmount() {
        return corpAmount;
    }


    
    /**
     * corpAmount을 설정
     * @param corpAmount 을(를) Integer corpAmount로 설정
     */
    public void setCorpAmount(Integer corpAmount) {
        this.corpAmount = corpAmount;
    }


    
    /**
     * Integer orgAmount을 반환
     * @return Integer orgAmount
     */
    public Integer getOrgAmount() {
        return orgAmount;
    }


    
    /**
     * orgAmount을 설정
     * @param orgAmount 을(를) Integer orgAmount로 설정
     */
    public void setOrgAmount(Integer orgAmount) {
        this.orgAmount = orgAmount;
    }


}
