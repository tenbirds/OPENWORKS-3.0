/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.recomgoods;

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
 *  2014. 10. 21.   김병욱       신규
 * </pre>
 * @see
 */
public class RecomGoodsVO extends GoodsManageVO {

    /**  */
    private static final long serialVersionUID = -5238195597935946181L;

    /**  */
    private Integer recomendLcSeCd;
    private Integer recomendSeCd;
    private Integer priort;
    private String appnDt;
    private String inqrCnt;
    private String sellCnt;
    private String evlScore;
    private String reviewCnt;
    private String subDomain;

    private String[] recomGoodsCodes1;
    private String[] recomGoodsCodes2;
    private Integer[] priorts;
    private String[] appnDts;
    /**
     * Integer recomendLcSeCd을 반환
     * @return Integer recomendLcSeCd
     */
    public Integer getRecomendLcSeCd() {
        return recomendLcSeCd;
    }

    /**
     * recomendLcSeCd을 설정
     * @param recomendLcSeCd 을(를) Integer recomendLcSeCd로 설정
     */
    public void setRecomendLcSeCd(Integer recomendLcSeCd) {
        this.recomendLcSeCd = recomendLcSeCd;
    }

    /**
     * Integer recomendSeCd을 반환
     * @return Integer recomendSeCd
     */
    public Integer getRecomendSeCd() {
        return recomendSeCd;
    }

    /**
     * recomendSeCd을 설정
     * @param recomendSeCd 을(를) Integer recomendSeCd로 설정
     */
    public void setRecomendSeCd(Integer recomendSeCd) {
        this.recomendSeCd = recomendSeCd;
    }

    /**
     * Integer priort을 반환
     * @return Integer priort
     */
    public Integer getPriort() {
        return priort;
    }

    /**
     * priort을 설정
     * @param priort 을(를) Integer priort로 설정
     */
    public void setPriort(Integer priort) {
        this.priort = priort;
    }

    /**
     * String appnDt을 반환
     * @return String appnDt
     */
    public String getAppnDt() {
        return appnDt;
    }

    /**
     * appnDt을 설정
     * @param appnDt 을(를) String appnDt로 설정
     */
    public void setAppnDt(String appnDt) {
        this.appnDt = appnDt;
    }

    /**
     * String inqrCnt을 반환
     * @return String inqrCnt
     */
    public String getInqrCnt() {
        return inqrCnt;
    }

    /**
     * inqrCnt을 설정
     * @param inqrCnt 을(를) String inqrCnt로 설정
     */
    public void setInqrCnt(String inqrCnt) {
        this.inqrCnt = inqrCnt;
    }

    /**
     * String sellCnt을 반환
     * @return String sellCnt
     */
    public String getSellCnt() {
        return sellCnt;
    }

    /**
     * sellCnt을 설정
     * @param sellCnt 을(를) String sellCnt로 설정
     */
    public void setSellCnt(String sellCnt) {
        this.sellCnt = sellCnt;
    }

    /**
     * String evlScore을 반환
     * @return String evlScore
     */
    public String getEvlScore() {
        return evlScore;
    }

    /**
     * evlScore을 설정
     * @param evlScore 을(를) String evlScore로 설정
     */
    public void setEvlScore(String evlScore) {
        this.evlScore = evlScore;
    }

    /**
     * String reviewCnt을 반환
     * @return String reviewCnt
     */
    public String getReviewCnt() {
        return reviewCnt;
    }

    /**
     * reviewCnt을 설정
     * @param reviewCnt 을(를) String reviewCnt로 설정
     */
    public void setReviewCnt(String reviewCnt) {
        this.reviewCnt = reviewCnt;
    }

    /**
     * String subDomain을 반환
     * @return String subDomain
     */
    public String getSubDomain() {
        return subDomain;
    }

    /**
     * subDomain을 설정
     * @param subDomain 을(를) String subDomain로 설정
     */
    public void setSubDomain(String subDomain) {
        this.subDomain = subDomain;
    }

    /**
     * String[] recomGoodsCodes1을 반환
     * @return String[] recomGoodsCodes1
     */
    public String[] getRecomGoodsCodes1() {
        return recomGoodsCodes1;
    }

    /**
     * recomGoodsCodes1을 설정
     * @param recomGoodsCodes1 을(를) String[] recomGoodsCodes1로 설정
     */
    public void setRecomGoodsCodes1(String[] recomGoodsCodes1) {
        this.recomGoodsCodes1 = recomGoodsCodes1;
    }

    /**
     * String[] recomGoodsCodes2을 반환
     * @return String[] recomGoodsCodes2
     */
    public String[] getRecomGoodsCodes2() {
        return recomGoodsCodes2;
    }

    /**
     * recomGoodsCodes2을 설정
     * @param recomGoodsCodes2 을(를) String[] recomGoodsCodes2로 설정
     */
    public void setRecomGoodsCodes2(String[] recomGoodsCodes2) {
        this.recomGoodsCodes2 = recomGoodsCodes2;
    }

    /**
     * Integer [] priorts을 반환
     * @return Integer [] priorts
     */
    public Integer[] getPriorts() {
        return priorts;
    }

    /**
     * priorts을 설정
     * @param priorts 을(를) Integer [] priorts로 설정
     */
    public void setPriorts(Integer[] priorts) {
        this.priorts = priorts;
    }

    /**
     * String [] appnDts을 반환
     * @return String [] appnDts
     */
    public String[] getAppnDts() {
        return appnDts;
    }

    /**
     * appnDts을 설정
     * @param appnDts 을(를) String [] appnDts로 설정
     */
    public void setAppnDts(String[] appnDts) {
        this.appnDts = appnDts;
    }

}
