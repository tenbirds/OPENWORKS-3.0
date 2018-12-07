/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.sale;

import java.util.List;

import zes.base.vo.BaseVO;
import zes.base.vo.FileVO;

public class SleVO extends BaseVO {

    /**  */
    private static final long serialVersionUID = 5256780797370899243L;

    /* 신청내용보기 */
    public static final Integer OM_TY_CD_VE = 1001;
    /* 다운로드 */
    public static final Integer OM_TY_CD_DW = 1002;
    /* 컨설팅 */
    public static final Integer OM_MT_CD_CT = 1003;

    
    private String seqNo;
    
    private Integer goodsInqryNo;
    private String inqrySj;
    private Integer answerSttusCd;
    private Integer domainCd;
    private Integer bbsCd;
    private String bbscttSeq;
    private String bbscttSj;
    private String registDt;
    private Integer goodsRegistSttus;    
    
    /** 판매자아이디 */
    private String registId;
    /** 사용자아이디 */
    private String userId; //
    /** 사용자아이디 */
    private String userNm;
    /** 언어코드 */
    private String langCode; //
    /** 언어코드 배열 */
    private List<String> langCodes;
    /** 언어이름 */
    private String langNm;
    /** 서비스코드 */
    private String goodsCode; //
    /** 서비스이름 */
    private String goodsNm; //
    /** 서비스구분코드 */
    private String goodsTyCd;
    /** 서비스구분이름 */
    private String goodsTyNm;
    /** 카테고리코드 */
    private String ctgryCd;
    /** 카테고리 이름 */
    private String ctgryNm;
    /** 판매방식코드 */
    private Integer sleMthdCd;
    /** 판매방식이름 */
    private String sleMthdNm;
    /** 시작일짜 */
    private String beginDate;
    /** 종료일짜 */
    private String endDate;
    /** 카테고리 부서코드 */
    private String parntsCtgryCd;
    /** 카테고리 깊이코드 */
    private String ctgryDp;
    /** 주문일시 */
    private String orderDt;
    /** 주문번호 */
    private String purchsNo; //
    /** 주문자아이디 */
    private String ordrrId;
    /** 주문자이름 */
    private String ordrrNm;
    /** 스토어이름 */
    private String storeNm;
    /** 주문확인여부 */
    private String orderCnfirmAt;
    /** 카테고리구분코드 */
    private Integer[] ctgryClCd; //
    /** 카테고리구분이름 */
    private String ctgryClNm;
    
    private Integer goodsImageFileSeq;
    
    private List<FileVO> imageFile;
    
    /** 커뮤니티아이디 */
    private String cmmntyId;
    
    private String cmpnyNm;
    
    private String sellCnt;
    
    private String evlScore;
    
    private String intrstSetupDt;
    
    private String sellStop;

    private String inqireDt;
    
    /*처리해야할 상세정보(견적)요청서*/
    private String notifyNum;
    private int notifySeq;
    private String rplyDt;
    
    /* 입찰참여(응찰) 현황 */
    private String bidNotifyNm; //공고명
    private String cntrMothod;  //계약방법
    private String cntrMothodNm;
    private String bidPgesStat;  //입찰진행상태 2044
    private String bidPgesStatNm;
   
    /** 마스터/서브관리 [의견공유] */
    private String masterId;      
    private String masubNum;
    private String masubTitle;      
    private String masubEntrDate;
   
    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getLangCode() {
        return langCode;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public List<String> getLangCodes() {
        return langCodes;
    }

    public void setLangCodes(List<String> langCodes) {
        this.langCodes = langCodes;
    }

    public String getLangNm() {
        return langNm;
    }

    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    public String getGoodsNm() {
        return goodsNm;
    }

    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    public String getGoodsTyCd() {
        return goodsTyCd;
    }

    public void setGoodsTyCd(String goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    public String getGoodsTyNm() {
        return goodsTyNm;
    }

    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }

    public String getCtgryCd() {
        return ctgryCd;
    }

    public void setCtgryCd(String ctgryCd) {
        this.ctgryCd = ctgryCd;
    }

    public String getCtgryNm() {
        return ctgryNm;
    }

    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }

    public Integer getSleMthdCd() {
        return sleMthdCd;
    }

    public void setSleMthdCd(Integer sleMthdCd) {
        this.sleMthdCd = sleMthdCd;
    }

    public String getSleMthdNm() {
        return sleMthdNm;
    }

    public void setSleMthdNm(String sleMthdNm) {
        this.sleMthdNm = sleMthdNm;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getParntsCtgryCd() {
        return parntsCtgryCd;
    }

    public void setParntsCtgryCd(String parntsCtgryCd) {
        this.parntsCtgryCd = parntsCtgryCd;
    }

    public String getCtgryDp() {
        return ctgryDp;
    }

    public void setCtgryDp(String ctgryDp) {
        this.ctgryDp = ctgryDp;
    }

    public String getOrderDt() {
        return orderDt;
    }

    public void setOrderDt(String orderDt) {
        this.orderDt = orderDt;
    }

    public String getPurchsNo() {
        return purchsNo;
    }

    public void setPurchsNo(String purchsNo) {
        this.purchsNo = purchsNo;
    }

    public String getOrdrrId() {
        return ordrrId;
    }

    public void setOrdrrId(String ordrrId) {
        this.ordrrId = ordrrId;
    }

    public String getOrdrrNm() {
        return ordrrNm;
    }

    public void setOrdrrNm(String ordrrNm) {
        this.ordrrNm = ordrrNm;
    }

    public String getStoreNm() {
        return storeNm;
    }

    public void setStoreNm(String storeNm) {
        this.storeNm = storeNm;
    }

    public String getOrderCnfirmAt() {
        return orderCnfirmAt;
    }

    public void setOrderCnfirmAt(String orderCnfirmAt) {
        this.orderCnfirmAt = orderCnfirmAt;
    }

    public String getCtgryClNm() {
        return ctgryClNm;
    }

    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }

    /**
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }

    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }

    /**
     * String cmpnyNm을 반환
     * @return String cmpnyNm
     */
    public String getCmpnyNm() {
        return cmpnyNm;
    }

    /**
     * cmpnyNm을 설정
     * @param cmpnyNm 을(를) String cmpnyNm로 설정
     */
    public void setCmpnyNm(String cmpnyNm) {
        this.cmpnyNm = cmpnyNm;
    }

    /**
     * List<FileVO> imageFile을 반환
     * @return List<FileVO> imageFile
     */
    public List<FileVO> getImageFile() {
        return imageFile;
    }

    /**
     * imageFile을 설정
     * @param imageFile 을(를) List<FileVO> imageFile로 설정
     */
    public void setImageFile(List<FileVO> imageFile) {
        this.imageFile = imageFile;
    }

    /**
     * Integer goodsImageFileSeq을 반환
     * @return Integer goodsImageFileSeq
     */
    public Integer getGoodsImageFileSeq() {
        return goodsImageFileSeq;
    }

    /**
     * goodsImageFileSeq을 설정
     * @param goodsImageFileSeq 을(를) Integer goodsImageFileSeq로 설정
     */
    public void setGoodsImageFileSeq(Integer goodsImageFileSeq) {
        this.goodsImageFileSeq = goodsImageFileSeq;
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
     * String intrstSetupDt을 반환
     * @return String intrstSetupDt
     */
    public String getIntrstSetupDt() {
        return intrstSetupDt;
    }

    /**
     * intrstSetupDt을 설정
     * @param intrstSetupDt 을(를) String intrstSetupDt로 설정
     */
    public void setIntrstSetupDt(String intrstSetupDt) {
        this.intrstSetupDt = intrstSetupDt;
    }

    /**
     * String sellStop을 반환
     * @return String sellStop
     */
    public String getSellStop() {
        return sellStop;
    }

    /**
     * sellStop을 설정
     * @param sellStop 을(를) String sellStop로 설정
     */
    public void setSellStop(String sellStop) {
        this.sellStop = sellStop;
    }

    /**
     * String inqireDt을 반환
     * @return String inqireDt
     */
    public String getInqireDt() {
        return inqireDt;
    }

    /**
     * inqireDt을 설정
     * @param inqireDt 을(를) String inqireDt로 설정
     */
    public void setInqireDt(String inqireDt) {
        this.inqireDt = inqireDt;
    }

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
     * Integer[] ctgryClCd을 반환
     * @return Integer[] ctgryClCd
     */
    public Integer[] getCtgryClCd() {
        return ctgryClCd;
    }

    /**
     * ctgryClCd을 설정
     * @param ctgryClCd 을(를) Integer[] ctgryClCd로 설정
     */
    public void setCtgryClCd(Integer[] ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }

    /**
     * String seqNo을 반환
     * @return String seqNo
     */
    public String getSeqNo() {
        return seqNo;
    }

    /**
     * seqNo을 설정
     * @param seqNo 을(를) String seqNo로 설정
     */
    public void setSeqNo(String seqNo) {
        this.seqNo = seqNo;
    }

    /**
     * Integer goodsInqryNo을 반환
     * @return Integer goodsInqryNo
     */
    public Integer getGoodsInqryNo() {
        return goodsInqryNo;
    }

    /**
     * goodsInqryNo을 설정
     * @param goodsInqryNo 을(를) Integer goodsInqryNo로 설정
     */
    public void setGoodsInqryNo(Integer goodsInqryNo) {
        this.goodsInqryNo = goodsInqryNo;
    }

    /**
     * String inqrySj을 반환
     * @return String inqrySj
     */
    public String getInqrySj() {
        return inqrySj;
    }

    /**
     * inqrySj을 설정
     * @param inqrySj 을(를) String inqrySj로 설정
     */
    public void setInqrySj(String inqrySj) {
        this.inqrySj = inqrySj;
    }

    /**
     * Integer answerSttusCd을 반환
     * @return Integer answerSttusCd
     */
    public Integer getAnswerSttusCd() {
        return answerSttusCd;
    }

    /**
     * answerSttusCd을 설정
     * @param answerSttusCd 을(를) Integer answerSttusCd로 설정
     */
    public void setAnswerSttusCd(Integer answerSttusCd) {
        this.answerSttusCd = answerSttusCd;
    }

    /**
     * Integer domainCd을 반환
     * @return Integer domainCd
     */
    public Integer getDomainCd() {
        return domainCd;
    }

    /**
     * domainCd을 설정
     * @param domainCd 을(를) Integer domainCd로 설정
     */
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    /**
     * Integer bbsCd을 반환
     * @return Integer bbsCd
     */
    public Integer getBbsCd() {
        return bbsCd;
    }

    /**
     * bbsCd을 설정
     * @param bbsCd 을(를) Integer bbsCd로 설정
     */
    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    /**
     * String bbscttSeq을 반환
     * @return String bbscttSeq
     */
    public String getBbscttSeq() {
        return bbscttSeq;
    }

    /**
     * bbscttSeq을 설정
     * @param bbscttSeq 을(를) String bbscttSeq로 설정
     */
    public void setBbscttSeq(String bbscttSeq) {
        this.bbscttSeq = bbscttSeq;
    }

    /**
     * String bbscttSj을 반환
     * @return String bbscttSj
     */
    public String getBbscttSj() {
        return bbscttSj;
    }

    /**
     * bbscttSj을 설정
     * @param bbscttSj 을(를) String bbscttSj로 설정
     */
    public void setBbscttSj(String bbscttSj) {
        this.bbscttSj = bbscttSj;
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
     * Integer goodsRegistSttus을 반환
     * @return Integer goodsRegistSttus
     */
    public Integer getGoodsRegistSttus() {
        return goodsRegistSttus;
    }

    /**
     * goodsRegistSttus을 설정
     * @param goodsRegistSttus 을(를) Integer goodsRegistSttus로 설정
     */
    public void setGoodsRegistSttus(Integer goodsRegistSttus) {
        this.goodsRegistSttus = goodsRegistSttus;
    }
    

    /**
     * String masterId을 반환
     * @return String masterId
     */
    public String getMasterId() {
        return masterId;
    }

    /**
     * registDt을 설정
     * @param masterId 을(를) String masterId로 설정
     */
    public void setMasterId(String masterId) {
        this.masterId = masterId;
    }

    /**
     * String masubNum을 반환
     * @return String masubNum
     */
    public String getMasubNum() {
        return masubNum;
    }

    /**
     * masubNum을 설정
     * @param masubNum 을(를) String masubNum로 설정
     */
    public void setMasubNum(String masubNum) {
        this.masubNum = masubNum;
    }
    
    /**
     * String masubTitle을 반환
     * @return String masubTitle
     */
    public String getMasubTitle() {
        return masubTitle;
    }

    /**
     * masubTitle을 설정
     * @param masubTitle 을(를) String masubTitle로 설정
     */
    public void setMasubTitle(String masubTitle) {
        this.masubTitle = masubTitle;
    }

    /**
     * String masubEntrDate을 반환
     * @return String masubEntrDate
     */
    public String getMasubEntrDate() {
        return masubEntrDate;
    }

    /**
     * masubNum을 설정
     * @param masubNum 을(를) String masubNum로 설정
     */
    public void setMasubEntrDate(String masubEntrDate) {
        this.masubEntrDate = masubEntrDate;
    }   
    
    /**
     * String notifyNum을 반환
     * @return String notifyNum
     */
    public String getNotifyNum() {
        return notifyNum;
    }

    /**
     * notifyNum을 설정
     * @param notifyNum 을(를) String notifyNum로 설정
     */
    public void setNotifyNum(String notifyNum) {
        this.notifyNum = notifyNum;
    }
 

    /**
     * int notifySeq을 반환
     * @return int notifySeq
     */
    public int getNotifySeq() {
        return notifySeq;
    }

    /**
     * v을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
    }


    /**
     * String rplyDt을 반환
     * @return String rplyDt
     */
    public String getRplyDt() {
        return rplyDt;
    }

    /**
     * rplyDt을 설정
     * @param rplyDt 을(를) String rplyDt로 설정
     */
    public void setRplyDt(String rplyDt) {
        this.rplyDt = rplyDt;
    }

    /**
     * 공고명
     * @return String bidNotifyNm
     */
    public String getBidNotifyNm() {
        return bidNotifyNm;
    }

    public void setBidNotifyNm(String bidNotifyNm) {
        this.bidNotifyNm = bidNotifyNm;
    }
   
    /**
     * 계약방법코드
     * @return String cntrMothod
     */
    public String getCntrMothod() {
        return cntrMothod;  
    }

    public void setCntrMothod(String cntrMothod) {
        this.cntrMothod = cntrMothod;
    }

    /**
     * 계약방법명칭
     * @return String cntrMothodNm
     */
    public String getCntrMothodNm() {
        return cntrMothodNm;
    }

    public void setCntrMothodNm(String cntrMothodNm) {
        this.cntrMothodNm = cntrMothodNm;
    }

    /**
     * 입찰진행상태코드 2044
     * @return String bidPgesStat
     */
    public String getBidPgesStat() {
        return bidPgesStat;
    }

    public void setBidPgesStat(String bidPgesStat) {
        this.bidPgesStat = bidPgesStat;
    }
    /**
     * 입찰진행상태
     * @return String bidPgesStatNm
     */
    public String getBidPgesStatNm() {
        return bidPgesStatNm;
    }

    public void setBidPgesStatNm(String bidPgesStatNm) {
        this.bidPgesStatNm = bidPgesStatNm;
    }

    
}
