/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import zes.base.vo.PaggingVO;
import zes.core.lang.Validate;
import zes.openworks.common.GlobalConfig;

/**
 * 데이타 페이징 처리
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
 *  2012. 3. 5.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class OrganPagerVo extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 언어코드 */
    private String langCode = "00";

    /** 언어코드 배열 */
    private List<String> langCodes;

    private Integer num;
    private String orgnCode;
    private String buseoCode;
    private String orgnNm;
    private String orgnNmSt;
    
    private String[] buseoCodes;
    private int cntrctSn;
    
    private String flag;
    
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
     * List<String> langCodes을 반환
     * @return List<String> langCodes
     */
    public List<String> getLangCodes() {
        return langCodes;
    }

    
    /**
     * langCodes을 설정
     * @param langCodes 을(를) List<String> langCodes로 설정
     */
    public void setLangCodes(List<String> langCodes) {
        this.langCodes = langCodes;
    }

    /**
     * Integer num을 반환
     * @return Integer num
     */
    public Integer getNum() {
        return num;
    }


    /**
     * num을 설정
     * @param num 을(를) Integer num로 설정
     */
    public void setNum(Integer num) {
        this.num = num;
    }


    /**
     * String orgnCode을 반환
     * @return String orgnCode
     */
    public String getOrgnCode() {
        return orgnCode;
    }


    /**
     * orgnCode을 설정
     * @param orgnCode 을(를) String orgnCode로 설정
     */
    public void setOrgnCode(String orgnCode) {
        this.orgnCode = orgnCode;
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
     * String[] buseoCodes을 반환
     * @return String[] buseoCodes
     */
    public String[] getBuseoCodes() {
        return buseoCodes;
    }


    
    /**
     * buseoCodes을 설정
     * @param buseoCodes 을(를) String[] buseoCodes로 설정
     */
    public void setBuseoCodes(String[] buseoCodes) {
        this.buseoCodes = buseoCodes;
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
    
    
}
