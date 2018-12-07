/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.resource.statistic;

import java.util.ArrayList;
import java.util.List;

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
public class RscCntResultVO extends RscCntSearchVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -5348100642977481802L;

    /** 리스트 좌측 텍스트 */
    private String title = "";

    private String prvCd = "";

    private String prvNm = "";

    private String meta_title = "";

    private String meta_desc = "";

    private String metaMasterSeqN = "";

    /** 통계값 1 */
    private Integer value = 0;

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

    /**
     * String meta_title을 반환
     * 
     * @return String meta_title
     */
    public String getMeta_title() {
        return meta_title;
    }

    /**
     * meta_title을 설정
     * 
     * @param meta_title 을(를) String meta_title로 설정
     */
    public void setMeta_title(String meta_title) {
        this.meta_title = meta_title;
    }

    /**
     * String meta_desc을 반환
     * 
     * @return String meta_desc
     */
    public String getMeta_desc() {
        return meta_desc;
    }

    /**
     * meta_desc을 설정
     * 
     * @param meta_desc 을(를) String meta_desc로 설정
     */
    public void setMeta_desc(String meta_desc) {
        this.meta_desc = meta_desc;
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
     * String prvCd을 반환
     * 
     * @return String prvCd
     */
    public String getPrvCd() {
        return prvCd;
    }

    /**
     * prvCd을 설정
     * 
     * @param prvCd 을(를) String prvCd로 설정
     */
    public void setPrvCd(String prvCd) {
        this.prvCd = prvCd;
    }

    /**
     * String prvNm을 반환
     * 
     * @return String prvNm
     */
    public String getPrvNm() {
        return prvNm;
    }

    /**
     * prvNm을 설정
     * 
     * @param prvNm 을(를) String prvNm로 설정
     */
    public void setPrvNm(String prvNm) {
        this.prvNm = prvNm;
    }

    /**
     * String metaMasterSeqN을 반환
     * 
     * @return String metaMasterSeqN
     */
    public String getMetaMasterSeqN() {
        return metaMasterSeqN;
    }

    /**
     * metaMasterSeqN을 설정
     * 
     * @param metaMasterSeqN 을(를) String metaMasterSeqN로 설정
     */
    public void setMetaMasterSeqN(String metaMasterSeqN) {
        this.metaMasterSeqN = metaMasterSeqN;
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

}
