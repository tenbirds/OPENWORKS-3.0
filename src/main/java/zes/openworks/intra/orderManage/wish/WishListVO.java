/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.orderManage.wish;

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
 * --------------  --------  -------------------------------
 *  2014. 10. 22.    이슬버미       신규
 * </pre>
 * @see
 */
public class WishListVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = -1096778628057397860L;

    /** 사용자아이디 */
    private String userId;
    /** 사용자아이디 */
    private String userNm;
    /** 언어코드 */
    private String langCode;
    /** 언어코드 배열 */
    private List<String> langCodes;
    /** 언어이름 */
    private String langNm;
    /** 서비스코드 */
    private String goodsCd;
    /** 서비스이름 */
    private String goodsNm;
    /** 시작일짜 */
    private String beginDate;
    /** 종료일짜 */
    private String endDate;
   
    /** 사업명 */
    private String auditlogNm;
    /** 적용일 */
    private String srcDt;
    /** 그룹번호 */
    private Integer grpSeq;
    
    /** 선택여부 */
    private String selChk;
    
    /** 상점이름 */
    private String langStoreNm; 
    
    /** 필터조건 */
    private String filterCon;
    
    /** 카테고리 */
    private String ctgryCode;
    
    /** 검색어 */
    private String keyWord;
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
     * String goodsCd을 반환
     * @return String goodsCd
     */
    public String getGoodsCd() {
        return goodsCd;
    }

    
    /**
     * goodsCd을 설정
     * @param goodsCd 을(를) String goodsCd로 설정
     */
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
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
     * String beginDate을 반환
     * @return String beginDate
     */
    public String getBeginDate() {
        return beginDate;
    }

    
    /**
     * beginDate을 설정
     * @param beginDate 을(를) String beginDate로 설정
     */
    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
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
     * String auditlogNm을 반환
     * @return String auditlogNm
     */
    public String getAuditlogNm() {
        return auditlogNm;
    }

    
    /**
     * auditlogNm을 설정
     * @param auditlogNm 을(를) String auditlogNm로 설정
     */
    public void setAuditlogNm(String auditlogNm) {
        this.auditlogNm = auditlogNm;
    }


    
    /**
     * String srcDt을 반환
     * @return String srcDt
     */
    public String getSrcDt() {
        return srcDt;
    }


    
    /**
     * srcDt을 설정
     * @param srcDt 을(를) String srcDt로 설정
     */
    public void setSrcDt(String srcDt) {
        this.srcDt = srcDt;
    }


    
    /**
     * String grpSeq을 반환
     * @return Integer grpSeq
     */
    public Integer getGrpSeq() {
        return grpSeq;
    }


    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) Integer grpSeq로 설정
     */
    public void setGrpSeq(Integer grpSeq) {
        this.grpSeq = grpSeq;
    }


    
    /**
     * String selChk을 반환
     * @return String selChk
     */
    public String getSelChk() {
        return selChk;
    }


    
    /**
     * selChk을 설정
     * @param selChk 을(를) String selChk로 설정
     */
    public void setSelChk(String selChk) {
        this.selChk = selChk;
    }


    
    /**
     * String langStoreNm을 반환
     * @return String langStoreNm
     */
    public String getLangStoreNm() {
        return langStoreNm;
    }


    
    /**
     * langStoreNm을 설정
     * @param langStoreNm 을(를) String langStoreNm로 설정
     */
    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }


    
    /**
     * String filterCon을 반환
     * @return String filterCon
     */
    public String getFilterCon() {
        return filterCon;
    }


    
    /**
     * filterCon을 설정
     * @param filterCon 을(를) String filterCon로 설정
     */
    public void setFilterCon(String filterCon) {
        this.filterCon = filterCon;
    }


    
    /**
     * String ctgryCode을 반환
     * @return String ctgryCode
     */
    public String getCtgryCode() {
        return ctgryCode;
    }


    
    /**
     * ctgryCode을 설정
     * @param ctgryCode 을(를) String ctgryCode로 설정
     */
    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }


    
    /**
     * String keyWord을 반환
     * @return String keyWord
     */
    public String getKeyWord() {
        return keyWord;
    }


    
    /**
     * keyWord을 설정
     * @param keyWord 을(를) String keyWord로 설정
     */
    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }
    
    
    

}
