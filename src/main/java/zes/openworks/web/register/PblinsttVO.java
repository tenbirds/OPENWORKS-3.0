/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.register;

/**
 * @version 1.0
 * @since
 * @author
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 9. 29.    최강식   신규작성
 * </pre>
 * @see
 */
public class PblinsttVO {
    /** 기관코드 **/
    private Integer pblinsttCd;
    /** 기관유형 **/
    private String pblinsttType;
    /** 상위기관명 **/
    private String upperPblinsttNm;
    /** 기관명 **/
    private String pblinsttNm;
    
    
    
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
     * String pblinsttType을 반환
     * @return String pblinsttType
     */
    public String getPblinsttType() {
        return pblinsttType;
    }
    /**
     * pblinsttType을 설정
     * @param pblinsttType 을(를) String pblinsttType로 설정
     */
    public void setPblinsttType(String pblinsttType) {
        this.pblinsttType = pblinsttType;
    }
    /**
     * String upperPblinsttNm을 반환
     * @return String upperPblinsttNm
     */
    public String getUpperPblinsttNm() {
        return upperPblinsttNm;
    }
    /**
     * upperPblinsttNm을 설정
     * @param upperPblinsttNm 을(를) String upperPblinsttNm로 설정
     */
    public void setUpperPblinsttNm(String upperPblinsttNm) {
        this.upperPblinsttNm = upperPblinsttNm;
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

}