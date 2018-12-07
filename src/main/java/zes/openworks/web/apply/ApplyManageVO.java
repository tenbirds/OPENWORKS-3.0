/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.apply;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

/**
 * 
 *
 * @version 1.0
 * @since openworks-2.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2016. 12. 26.    방기배       신규
 *</pre>
 * @see
 */
public class ApplyManageVO extends PaggingVO{
    /**  */
    private static final long serialVersionUID = 5004972049218009469L;
    /** 공고번호 번호 */
    private String noifyNum;
    /* 공고차수 */
    private int noifySeq;
    /* 요청 갯수*/
    private int totalCount;

    /** 사용자이름 */
    private String userNm;
    /** 회사 서브 이름 */
    private String goodsSumry;
    /** 사용자아이디 */
    private String askApply;
    /** 사용자아이디 */
    private String bidSuss;
    private String cntrGbn;
   
    /** 서비스코드 */
    private String goodsCode;
    /** 서비스명 */
    private String applyNm;

    private String splyForm;
    private String cntrStart;
    private String cntrEnd;
    private int splyAmt;
    private String splyFormEtc;
    /* 회사명 */
    private String cmpnyNm ; 
    private String applyMakr;
    /** 언어코드 */
    private String langCode;
    /** 판매자아이디 */
    private String registId;
    
    /* 답변 처음인지 수정인지 확인*/
    private String applytype;
    
    /** 수의계약사유첨부-첨부파일 */
    private int optlCntrFile;
    
    /** 수의계약사유첨부-첨부파일 */
    private List<FileVO> optlCntrFileList;
    
    /** 납품-첨부파일 */
    private int delyFile;

    /** 납품-첨부파일 */
    private List<FileVO> delyFileList;
    
    /* 계약체결 첨부파일 */
    private String splyFile;
    
    /* 계약체결 첨부파일 */
    private List<FileVO> splyFileList;
    
    
    private String supplyAmounts;
    /* 추가답변 */
    private String addAnswer;
    /* */
    private String explanatorys;
    /* 직책 */
    private String positions;
    /* 비고 */
    private String splyNote;
    /* 가격 */
    private int AmountItem1;
    
    
    
    /**
     * int amountItem1을 반환
     * @return int amountItem1
     */
    public int getAmountItem1() {
        return AmountItem1;
    }











    
    /**
     * amountItem1을 설정
     * @param amountItem1 을(를) int amountItem1로 설정
     */
    public void setAmountItem1(int amountItem1) {
        AmountItem1 = amountItem1;
    }











    /**
     * List<FileVO> splyFileList을 반환
     * @return List<FileVO> splyFileList
     */
    public List<FileVO> getSplyFileList() {
        return splyFileList;
    }










    
    /**
     * splyFileList을 설정
     * @param splyFileList 을(를) List<FileVO> splyFileList로 설정
     */
    public void setSplyFileList(List<FileVO> splyFileList) {
        this.splyFileList = splyFileList;
    }










    /**
     * String splyFile을 반환
     * @return String splyFile
     */
    public String getSplyFile() {
        return splyFile;
    }









    
    /**
     * splyFile을 설정
     * @param splyFile 을(를) String splyFile로 설정
     */
    public void setSplyFile(String splyFile) {
        this.splyFile = splyFile;
    }









    /**
     * String goodsCode을 반환
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }







    
    
    /**
     * List<FileVO> optlCntrFileList을 반환
     * @return List<FileVO> optlCntrFileList
     */
    public List<FileVO> getOptlCntrFileList() {
        return optlCntrFileList;
    }








    
    /**
     * optlCntrFileList을 설정
     * @param optlCntrFileList 을(를) List<FileVO> optlCntrFileList로 설정
     */
    public void setOptlCntrFileList(List<FileVO> optlCntrFileList) {
        this.optlCntrFileList = optlCntrFileList;
    }








    
    /**
     * List<FileVO> delyFileList을 반환
     * @return List<FileVO> delyFileList
     */
    public List<FileVO> getDelyFileList() {
        return delyFileList;
    }








    
    /**
     * delyFileList을 설정
     * @param delyFileList 을(를) List<FileVO> delyFileList로 설정
     */
    public void setDelyFileList(List<FileVO> delyFileList) {
        this.delyFileList = delyFileList;
    }








    /**
     * goodsCode을 설정
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }







    /**
     * String applytype을 반환
     * @return String applytype
     */
    public String getApplytype() {
        return applytype;
    }






    
    /**
     * applytype을 설정
     * @param applytype 을(를) String applytype로 설정
     */
    public void setApplytype(String applytype) {
        this.applytype = applytype;
    }






    /**
     * String applyMakr을 반환
     * @return String applyMakr
     */
    public String getApplyMakr() {
        return applyMakr;
    }





    
    /**
     * applyMakr을 설정
     * @param applyMakr 을(를) String applyMakr로 설정
     */
    public void setApplyMakr(String applyMakr) {
        this.applyMakr = applyMakr;
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
     * String splyForm을 반환
     * @return String splyForm
     */
    public String getSplyForm() {
        return splyForm;
    }


    
    /**
     * splyForm을 설정
     * @param splyForm 을(를) String splyForm로 설정
     */
    public void setSplyForm(String splyForm) {
        this.splyForm = splyForm;
    }


    
    /**
     * String cntrStart을 반환
     * @return String cntrStart
     */
    public String getCntrStart() {
        return cntrStart;
    }


    
    /**
     * cntrStart을 설정
     * @param cntrStart 을(를) String cntrStart로 설정
     */
    public void setCntrStart(String cntrStart) {
        this.cntrStart = cntrStart;
    }


    
    /**
     * String cntrEnd을 반환
     * @return String cntrEnd
     */
    public String getCntrEnd() {
        return cntrEnd;
    }


    
    /**
     * cntrEnd을 설정
     * @param cntrEnd 을(를) String cntrEnd로 설정
     */
    public void setCntrEnd(String cntrEnd) {
        this.cntrEnd = cntrEnd;
    }


    
    /**
     * String splyAmt을 반환
     * @return String splyAmt
     */
    public int getSplyAmt() {
        return splyAmt;
    }


    
    /**
     * splyAmt을 설정
     * @param splyAmt 을(를) String splyAmt로 설정
     */
    public void setSplyAmt(int splyAmt) {
        this.splyAmt = splyAmt;
    }


    
    /**
     * String splyFormEtc을 반환
     * @return String splyFormEtc
     */
    public String getSplyFormEtc() {
        return splyFormEtc;
    }


    
    /**
     * splyFormEtc을 설정
     * @param splyFormEtc 을(를) String splyFormEtc로 설정
     */
    public void setSplyFormEtc(String splyFormEtc) {
        this.splyFormEtc = splyFormEtc;
    }

    /**
     * String[] applyCodes을 반환
     *
     * @return String[] applyCodes
     */
 
    /** 서비스명 설정 */
    public void setapplyNm(String applyNm) {
        this.applyNm = applyNm;
    }

    /** 서비스명 추출 */
    public String getapplyNm() {
        return applyNm;
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
     * String goodsSumry을 반환
     * @return String goodsSumry
     */
    public String getGoodsSumry() {
        return goodsSumry;
    }


    
    /**
     * goodsSumry을 설정
     * @param goodsSumry 을(를) String goodsSumry로 설정
     */
    public void setGoodsSumry(String goodsSumry) {
        this.goodsSumry = goodsSumry;
    }


    
    /**
     * String askApply을 반환
     * @return String askApply
     */
    public String getAskApply() {
        return askApply;
    }


    
    /**
     * askApply을 설정
     * @param askApply 을(를) String askApply로 설정
     */
    public void setAskApply(String askApply) {
        this.askApply = askApply;
    }

    /**
     * String cntrGbn을 반환
     * @return String cntrGbn
     */
    public String getCntrGbn() {
        return cntrGbn;
    }


    
    /**
     * cntrGbn을 설정
     * @param cntrGbn 을(를) String cntrGbn로 설정
     */
    public void setCntrGbn(String cntrGbn) {
        this.cntrGbn = cntrGbn;
    }

    
    /**
     * String bidSuss을 반환
     * @return String bidSuss
     */
    public String getBidSuss() {
        return bidSuss;
    }


    
    /**
     * bidSuss을 설정
     * @param bidSuss 을(를) String bidSuss로 설정
     */
    public void setBidSuss(String bidSuss) {
        this.bidSuss = bidSuss;
    }

    /**
     * String noifyNum을 반환
     * @return String noifyNum
     */
    public String getNoifyNum() {
        return noifyNum;
    }



    
    /**
     * noifyNum을 설정
     * @param noifyNum 을(를) String noifyNum로 설정
     */
    public void setNoifyNum(String noifyNum) {
        this.noifyNum = noifyNum;
    }



    
    /**
     * String noifySeq을 반환
     * @return String noifySeq
     */
    public int getNoifySeq() {
        return noifySeq;
    }

    /**
     * noifySeq을 설정
     * @param noifySeq 을(를) String noifySeq로 설정
     */
    public void setNoifySeq(int noifySeq) {
        this.noifySeq = noifySeq;
    }
    /**
     * int totalCount을 반환
     * @return int totalCount
     */
    public int getTotalCount() {
        return totalCount;
    }


    /**
     * totalCount을 설정
     * @param totalCount 을(를) int totalCount로 설정
     */
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
    /* MasterInfo
     * 마스터인포
     * 입찰 번호 */
    private String notifyNum;
    /* 공급자 아이디*/
    private String langStoreId;
    /* 수요자 아이디*/
    private String demandId;
    
    private String consumerYn;
    /* 수요자 아이디*/
    private String bidUserId;
    /* 이메일 아이디 */
    private String emailId;
    /*  회사 번호    */
    private String telnoNum;
    /* 입찰 차수*/
    private int notifySeq;
    /* 입찰종류여부*/
    private int bidGbnCd;
    /* 서비스구분 */
    private int goodKndCd;
    /* 수요자 아이디*/
    private String userId;
    /* 수매희망목록순번 */
    private int grpSed;
    /* 공고종류   */
    private int bidKndCd;
    /* 공고분류 */
    private int bidClassCd;
    /* 계약방법*/
    private int cntrMothod;
    /*      */
    private String readDmndOrgn;
    /*      */
    private String goodsChargerNm;
    /*      */
    private String goodsChargerCttpc;
    /*      */
    private String linkOrgnUrl;
    /*      */
    private String bidNotifyNm;
    /*      */
    private String strtDt;
    /*      */
    private String clseDt;
    /*      */
    private String openNum;
    /*      */
    private int areaLimit1;
    /*      */
    private int areaLimit2;
    /*      */
    private int areaLimit3;
    /*      */
    private String catyLimitEntr;
    /*      */
    private String catyLimitVntr;
    /*      */
    private String catyLimitSoc;
    /*      */
    private String catyLimitWomn;
    /*      */
    private String catyLimitDiad;
    /*      */
    private String catyLimitEtn;
    /*      */
    private int hopePuchAmt;
    /*      */
    private String vatGbn;
    /*      */
    private String delyDt;
    /*      */
    private String notifyCont;
    /*      */
    private String talkGbn;
    /*      */
    private String rplyDt;
    /*      */
    private String delyPlac;
    /*      */
    private String notifyCout;
    /*      */
    private int bidPgesStat;
    /*      */
    private String bidChngCauser;
    /*  직책  */
    private String userPosition;
    
    /* 공급자 정보 */
    /* 휴대폰 번호 */
    private String mbtlNumber;
    /* 회사대표번호 */
    private String cmpnyReprsntTelno;
    /* 공급자 이름 */
    private String userNms;
    /* 이메일 아이디 */
    private String emailIds;
    /* 회사이름 */
    private String cmpnyNms;

    
    
    /**
     * String demandId을 반환
     * @return String demandId
     */
    public String getDemandId() {
        return demandId;
    }






    
    /**
     * demandId을 설정
     * @param demandId 을(를) String demandId로 설정
     */
    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }






    /**
     * String bidUserId을 반환
     * @return String bidUserId
     */
    public String getBidUserId() {
        return bidUserId;
    }






    
    /**
     * bidUserId을 설정
     * @param bidUserId 을(를) String bidUserId로 설정
     */
    public void setBidUserId(String bidUserId) {
        this.bidUserId = bidUserId;
    }






    /**
     * String userNms을 반환
     * @return String userNms
     */
    public String getUserNms() {
        return userNms;
    }

    
    /**
     * String notifyCont을 반환
     * @return String notifyCont
     */
    public String getNotifyCont() {
        return notifyCont;
    }



    
    
    /**
     * String langStoreId을 반환
     * @return String langStoreId
     */
    public String getLangStoreId() {
        return langStoreId;
    }






    
    /**
     * langStoreId을 설정
     * @param langStoreId 을(를) String langStoreId로 설정
     */
    public void setLangStoreId(String langStoreId) {
        this.langStoreId = langStoreId;
    }






    
    /**
     * String consumerYn을 반환
     * @return String consumerYn
     */
    public String getConsumerYn() {
        return consumerYn;
    }






    
    /**
     * consumerYn을 설정
     * @param consumerYn 을(를) String consumerYn로 설정
     */
    public void setConsumerYn(String consumerYn) {
        this.consumerYn = consumerYn;
    }






    /**
     * notifyCont을 설정
     * @param notifyCont 을(를) String notifyCont로 설정
     */
    public void setNotifyCont(String notifyCont) {
        this.notifyCont = notifyCont;
    }



    /**
     * userNms을 설정
     * @param userNms 을(를) String userNms로 설정
     */
    public void setUserNms(String userNms) {
        this.userNms = userNms;
    }



    
    /**
     * String emailIds을 반환
     * @return String emailIds
     */
    public String getEmailIds() {
        return emailIds;
    }



    
    /**
     * emailIds을 설정
     * @param emailIds 을(를) String emailIds로 설정
     */
    public void setEmailIds(String emailIds) {
        this.emailIds = emailIds;
    }



    
    /**
     * String cmpnyNms을 반환
     * @return String cmpnyNms
     */
    public String getCmpnyNms() {
        return cmpnyNms;
    }



    
    /**
     * cmpnyNms을 설정
     * @param cmpnyNms 을(를) String cmpnyNms로 설정
     */
    public void setCmpnyNms(String cmpnyNms) {
        this.cmpnyNms = cmpnyNms;
    }



    /**
     * String mbtlNumber을 반환
     * @return String mbtlNumber
     */
    public String getMbtlNumber() {
        return mbtlNumber;
    }


    /**
     * mbtlNumber을 설정
     * @param mbtlNumber 을(를) String mbtlNumber로 설정
     */
    public void setMbtlNumber(String mbtlNumber) {
        this.mbtlNumber = mbtlNumber;
    }

    /**
     * String cmpnyReprsntTelno을 반환
     * @return String cmpnyReprsntTelno
     */
    public String getCmpnyReprsntTelno() {
        return cmpnyReprsntTelno;
    }



    
    /**
     * cmpnyReprsntTelno을 설정
     * @param cmpnyReprsntTelno 을(를) String cmpnyReprsntTelno로 설정
     */
    public void setCmpnyReprsntTelno(String cmpnyReprsntTelno) {
        this.cmpnyReprsntTelno = cmpnyReprsntTelno;
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
     * notifySeq을 설정
     * @param notifySeq 을(를) int notifySeq로 설정
     */
    public void setNotifySeq(int notifySeq) {
        this.notifySeq = notifySeq;
    }
    
    /**
     * String bidGbnCd을 반환
     * @return String bidGbnCd
     */
    public int getBidGbnCd() {
        return bidGbnCd;
    }
    
    /**
     * bidGbnCd을 설정
     * @param bidGbnCd 을(를) String bidGbnCd로 설정
     */
    public void setBidGbnCd(int bidGbnCd) {
        this.bidGbnCd = bidGbnCd;
    }
    
    /**
     * String goodKndCd을 반환
     * @return String goodKndCd
     */
    public int getGoodKndCd() {
        return goodKndCd;
    }
    
    /**
     * goodKndCd을 설정
     * @param goodKndCd 을(를) String goodKndCd로 설정
     */
    public void setGoodKndCd(int goodKndCd) {
        this.goodKndCd = goodKndCd;
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
     * String grp_Sed을 반환
     * @return String grp_Sed
     */
    public int getGrpSed() {
        return grpSed;
    }
    
    /**
     * grp_Sed을 설정
     * @param grp_Sed 을(를) String grp_Sed로 설정
     */
    public void setGrp_Sed(int grpSed) {
        this.grpSed = grpSed;
    }
    
    /**
     * String bidKndCd을 반환
     * @return String bidKndCd
     */
    public int getBidKndCd() {
        return bidKndCd;
    }
    
    /**
     * bidKndCd을 설정
     * @param bidKndCd 을(를) String bidKndCd로 설정
     */
    public void setBidKndCd(int bidKndCd) {
        this.bidKndCd = bidKndCd;
    }
    
    /**
     * String bidClassCd을 반환
     * @return String bidClassCd
     */
    public int getBidClassCd() {
        return bidClassCd;
    }
    
    /**
     * bidClassCd을 설정
     * @param bidClassCd 을(를) String bidClassCd로 설정
     */
    public void setBidClassCd(int bidClassCd) {
        this.bidClassCd = bidClassCd;
    }
    
    /**
     * String cntrMothod을 반환
     * @return String cntrMothod
     */
    public int getCntrMothod() {
        return cntrMothod;
    }
    
    /**
     * cntrMothod을 설정
     * @param cntrMothod 을(를) String cntrMothod로 설정
     */
    public void setCntrMothod(int cntrMothod) {
        this.cntrMothod = cntrMothod;
    }
    
    /**
     * String optlCntrFile을 반환
     * @return String optlCntrFile
     */
    public int getOptlCntrFile() {
        return optlCntrFile;
    }
    
    /**
     * optlCntrFile을 설정
     * @param optlCntrFile 을(를) String optlCntrFile로 설정
     */
    public void setOptlCntrFile(int optlCntrFile) {
        this.optlCntrFile = optlCntrFile;
    }
    
    /**
     * String readDmndOrgn을 반환
     * @return String readDmndOrgn
     */
    public String getReadDmndOrgn() {
        return readDmndOrgn;
    }
    
    /**
     * readDmndOrgn을 설정
     * @param readDmndOrgn 을(를) String readDmndOrgn로 설정
     */
    public void setReadDmndOrgn(String readDmndOrgn) {
        this.readDmndOrgn = readDmndOrgn;
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
     * String goodsChargerCttpc을 반환
     * @return String goodsChargerCttpc
     */
    public String getGoodsChargerCttpc() {
        return goodsChargerCttpc;
    }
    
    /**
     * goodsChargerCttpc을 설정
     * @param goodsChargerCttpc 을(를) String goodsChargerCttpc로 설정
     */
    public void setGoodsChargerCttpc(String goodsChargerCttpc) {
        this.goodsChargerCttpc = goodsChargerCttpc;
    }
    
    /**
     * String linkOrgnUrl을 반환
     * @return String linkOrgnUrl
     */
    public String getLinkOrgnUrl() {
        return linkOrgnUrl;
    }
    
    /**
     * linkOrgnUrl을 설정
     * @param linkOrgnUrl 을(를) String linkOrgnUrl로 설정
     */
    public void setLinkOrgnUrl(String linkOrgnUrl) {
        this.linkOrgnUrl = linkOrgnUrl;
    }
    
    /**
     * String bidNotifyNm을 반환
     * @return String bidNotifyNm
     */
    public String getBidNotifyNm() {
        return bidNotifyNm;
    }
    
    /**
     * bidNotifyNm을 설정
     * @param bidNotifyNm 을(를) String bidNotifyNm로 설정
     */
    public void setBidNotifyNm(String bidNotifyNm) {
        this.bidNotifyNm = bidNotifyNm;
    }
    
    /**
     * String strtDt을 반환
     * @return String strtDt
     */
    public String getStrtDt() {
        return strtDt;
    }
    
    /**
     * strtDt을 설정
     * @param strtDt 을(를) String strtDt로 설정
     */
    public void setStrtDt(String strtDt) {
        this.strtDt = strtDt;
    }
    
    /**
     * String clseDt을 반환
     * @return String clseDt
     */
    public String getClseDt() {
        return clseDt;
    }
    
    /**
     * clseDt을 설정
     * @param clseDt 을(를) String clseDt로 설정
     */
    public void setClseDt(String clseDt) {
        this.clseDt = clseDt;
    }
    
    /**
     * String openNum을 반환
     * @return String openNum
     */
    public String getOpenNum() {
        return openNum;
    }
    
    /**
     * openNum을 설정
     * @param openNum 을(를) String openNum로 설정
     */
    public void setOpenNum(String openNum) {
        this.openNum = openNum;
    }
    
    /**
     * String areaLimit1을 반환
     * @return String areaLimit1
     */
    public int getAreaLimit1() {
        return areaLimit1;
    }
    
    /**
     * areaLimit1을 설정
     * @param areaLimit1 을(를) String areaLimit1로 설정
     */
    public void setAreaLimit1(int areaLimit1) {
        this.areaLimit1 = areaLimit1;
    }
    
    /**
     * String areaLimit2을 반환
     * @return String areaLimit2
     */
    public int getAreaLimit2() {
        return areaLimit2;
    }
    
    /**
     * areaLimit2을 설정
     * @param areaLimit2 을(를) String areaLimit2로 설정
     */
    public void setAreaLimit2(int areaLimit2) {
        this.areaLimit2 = areaLimit2;
    }
    
    /**
     * String areaLimit3을 반환
     * @return String areaLimit3
     */
    public int getAreaLimit3() {
        return areaLimit3;
    }
    
    /**
     * areaLimit3을 설정
     * @param areaLimit3 을(를) String areaLimit3로 설정
     */
    public void setAreaLimit3(int areaLimit3) {
        this.areaLimit3 = areaLimit3;
    }
    
    /**
     * String catyLimitEntr을 반환
     * @return String catyLimitEntr
     */
    public String getCatyLimitEntr() {
        return catyLimitEntr;
    }
    
    /**
     * catyLimitEntr을 설정
     * @param catyLimitEntr 을(를) String catyLimitEntr로 설정
     */
    public void setCatyLimitEntr(String catyLimitEntr) {
        this.catyLimitEntr = catyLimitEntr;
    }
    
    /**
     * String catyLimitVntr을 반환
     * @return String catyLimitVntr
     */
    public String getCatyLimitVntr() {
        return catyLimitVntr;
    }
    
    /**
     * catyLimitVntr을 설정
     * @param catyLimitVntr 을(를) String catyLimitVntr로 설정
     */
    public void setCatyLimitVntr(String catyLimitVntr) {
        this.catyLimitVntr = catyLimitVntr;
    }
    
    /**
     * String catyLimitSoc을 반환
     * @return String catyLimitSoc
     */
    public String getCatyLimitSoc() {
        return catyLimitSoc;
    }
    
    /**
     * catyLimitSoc을 설정
     * @param catyLimitSoc 을(를) String catyLimitSoc로 설정
     */
    public void setCatyLimitSoc(String catyLimitSoc) {
        this.catyLimitSoc = catyLimitSoc;
    }
    
    /**
     * String catyLimitWomn을 반환
     * @return String catyLimitWomn
     */
    public String getCatyLimitWomn() {
        return catyLimitWomn;
    }
    
    /**
     * catyLimitWomn을 설정
     * @param catyLimitWomn 을(를) String catyLimitWomn로 설정
     */
    public void setCatyLimitWomn(String catyLimitWomn) {
        this.catyLimitWomn = catyLimitWomn;
    }
    
    /**
     * String catyLimitDiad을 반환
     * @return String catyLimitDiad
     */
    public String getCatyLimitDiad() {
        return catyLimitDiad;
    }
    
    /**
     * catyLimitDiad을 설정
     * @param catyLimitDiad 을(를) String catyLimitDiad로 설정
     */
    public void setCatyLimitDiad(String catyLimitDiad) {
        this.catyLimitDiad = catyLimitDiad;
    }
    
    /**
     * String catyLimitEtn을 반환
     * @return String catyLimitEtn
     */
    public String getCatyLimitEtn() {
        return catyLimitEtn;
    }
    
    /**
     * catyLimitEtn을 설정
     * @param catyLimitEtn 을(를) String catyLimitEtn로 설정
     */
    public void setCatyLimitEtn(String catyLimitEtn) {
        this.catyLimitEtn = catyLimitEtn;
    }
    
    /**
     * String hopePuchAmt을 반환
     * @return String hopePuchAmt
     */
    public int getHopePuchAmt() {
        return hopePuchAmt;
    }
    
    /**
     * hopePuchAmt을 설정
     * @param hopePuchAmt 을(를) String hopePuchAmt로 설정
     */
    public void setHopePuchAmt(int hopePuchAmt) {
        this.hopePuchAmt = hopePuchAmt;
    }
    
    /**
     * String vatGbn을 반환
     * @return String vatGbn
     */
    public String getVatGbn() {
        return vatGbn;
    }
    
    /**
     * vatGbn을 설정
     * @param vatGbn 을(를) String vatGbn로 설정
     */
    public void setVatGbn(String vatGbn) {
        this.vatGbn = vatGbn;
    }
    
    /**
     * String delyDt을 반환
     * @return String delyDt
     */
    public String getDelyDt() {
        return delyDt;
    }
    
    /**
     * delyDt을 설정
     * @param delyDt 을(를) String delyDt로 설정
     */
    public void setDelyDt(String delyDt) {
        this.delyDt = delyDt;
    }
    
    /**
     * String talkGbn을 반환
     * @return String talkGbn
     */
    public String getTalkGbn() {
        return talkGbn;
    }
    
    /**
     * talkGbn을 설정
     * @param talkGbn 을(를) String talkGbn로 설정
     */
    public void setTalkGbn(String talkGbn) {
        this.talkGbn = talkGbn;
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
     * String delyPlac을 반환
     * @return String delyPlac
     */
    public String getDelyPlac() {
        return delyPlac;
    }
    
    /**
     * delyPlac을 설정
     * @param delyPlac 을(를) String delyPlac로 설정
     */
    public void setDelyPlac(String delyPlac) {
        this.delyPlac = delyPlac;
    }
    
    /**
     * String delyFile을 반환
     * @return String delyFile
     */
    public int getDelyFile() {
        return delyFile;
    }
    
    /**
     * delyFile을 설정
     * @param delyFile 을(를) String delyFile로 설정
     */
    public void setDelyFile(int delyFile) {
        this.delyFile = delyFile;
    }
    
    /**
     * String notifyCout을 반환
     * @return String notifyCout
     */
    public String getNotifyCout() {
        return notifyCout;
    }
    
    /**
     * notifyCout을 설정
     * @param notifyCout 을(를) String notifyCout로 설정
     */
    public void setNotifyCout(String notifyCout) {
        this.notifyCout = notifyCout;
    }
    
    /**
     * String bidPgesStat을 반환
     * @return String bidPgesStat
     */
    public int getBidPgesStat() {
        return bidPgesStat;
    }
    
    /**
     * bidPgesStat을 설정
     * @param bidPgesStat 을(를) String bidPgesStat로 설정
     */
    public void setBidPgesStat(int bidPgesStat) {
        this.bidPgesStat = bidPgesStat;
    }
    
    /**
     * String bidChngCauser을 반환
     * @return String bidChngCauser
     */
    public String getBidChngCauser() {
        return bidChngCauser;
    }
    
    /**
     * bidChngCauser을 설정
     * @param bidChngCauser 을(를) String bidChngCauser로 설정
     */
    public void setBidChngCauser(String bidChngCauser) {
        this.bidChngCauser = bidChngCauser;
    }
    
    /**
     * String userPosition을 반환
     * @return String userPosition
     */
    public String getUserPosition() {
        return userPosition;
    }
    
    /**
     * userPosition을 설정
     * @param userPosition 을(를) String userPosition로 설정
     */
    public void setUserPosition(String userPosition) {
        this.userPosition = userPosition;
    }
    /**
     * String telnoNum을 반환
     * @return String telnoNum
     */
    public String getTelnoNum() {
        return telnoNum;
    }



    
    /**
     * telnoNum을 설정
     * @param telnoNum 을(를) String telnoNum로 설정
     */
    public void setTelnoNum(String telnoNum) {
        this.telnoNum = telnoNum;
    }
    
    /**
     * String emailId을 반환
     * @return String emailId
     */
    public String getEmailId() {
        return emailId;
    }


    /**
     * emailId을 설정
     * @param emailId 을(를) String emailId로 설정
     */
    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }
    /*
     * bid saprivate String i
     * 사스 데이터 추출
     */
    private int unitSys;
    private String etcUnitSys;
    private String captySys;
    private int amountSys;
    private int splyMothSys;
    private String optionNm;
    private String unitItem;
    private String captyItem;
    private String amountItem;
    private String cmntItem;
    private int applySeq;
    private String applySeqs;
    private String applyGbn;
    private int splyAmts;
    private String vatGbns;
    private String splyNotes;
    private String addAnswers;

   
    
    /**
     * String applySeqs을 반환
     * @return String applySeqs
     */
    public String getApplySeqs() {
        return applySeqs;
    }







    
    /**
     * applySeqs을 설정
     * @param applySeqs 을(를) String applySeqs로 설정
     */
    public void setApplySeqs(String applySeqs) {
        this.applySeqs = applySeqs;
    }







    /**
     * int splyAmts을 반환
     * @return int splyAmts
     */
    public int getSplyAmts() {
        return splyAmts;
    }






    
    /**
     * splyAmts을 설정
     * @param splyAmts 을(를) int splyAmts로 설정
     */
    public void setSplyAmts(int splyAmts) {
        this.splyAmts = splyAmts;
    }






    
    /**
     * String vatGbns을 반환
     * @return String vatGbns
     */
    public String getVatGbns() {
        return vatGbns;
    }






    
    /**
     * vatGbns을 설정
     * @param vatGbns 을(를) String vatGbns로 설정
     */
    public void setVatGbns(String vatGbns) {
        this.vatGbns = vatGbns;
    }






    
    /**
     * String splyNotes을 반환
     * @return String splyNotes
     */
    public String getSplyNotes() {
        return splyNotes;
    }






    
    /**
     * splyNotes을 설정
     * @param splyNotes 을(를) String splyNotes로 설정
     */
    public void setSplyNotes(String splyNotes) {
        this.splyNotes = splyNotes;
    }






    
    /**
     * String addAnswers을 반환
     * @return String addAnswers
     */
    public String getAddAnswers() {
        return addAnswers;
    }






    
    /**
     * addAnswers을 설정
     * @param addAnswers 을(를) String addAnswers로 설정
     */
    public void setAddAnswers(String addAnswers) {
        this.addAnswers = addAnswers;
    }






/**
     * String applyGbn을 반환
     * @return String applyGbn
     */
    public String getApplyGbn() {
        return applyGbn;
    }






    
    /**
     * applyGbn을 설정
     * @param applyGbn 을(를) String applyGbn로 설정
     */
    public void setApplyGbn(String applyGbn) {
        this.applyGbn = applyGbn;
    }






    /**
     * String etcUnitSys을 반환
     * @return String etcUnitSys
     */
    public String getEtcUnitSys() {
        return etcUnitSys;
    }






    
    /**
     * etcUnitSys을 설정
     * @param etcUnitSys 을(를) String etcUnitSys로 설정
     */
    public void setEtcUnitSys(String etcUnitSys) {
        this.etcUnitSys = etcUnitSys;
    }






    /**
     * int applySeq을 반환
     * @return int applySeq
     */
    public int getApplySeq() {
        return applySeq;
    }






    
    /**
     * applySeq을 설정
     * @param applySeq 을(를) int applySeq로 설정
     */
    public void setApplySeq(int applySeq) {
        this.applySeq = applySeq;
    }






    /**
     * String optionNm을 반환
     * @return String optionNm
     */
    public String getOptionNm() {
        return optionNm;
    }



    
    /**
     * optionNm을 설정
     * @param optionNm 을(를) String optionNm로 설정
     */
    public void setOptionNm(String optionNm) {
        this.optionNm = optionNm;
    }



    
    /**
     * String unitItem을 반환
     * @return String unitItem
     */
    public String getUnitItem() {
        return unitItem;
    }



    
    /**
     * unitItem을 설정
     * @param unitItem 을(를) String unitItem로 설정
     */
    public void setUnitItem(String unitItem) {
        this.unitItem = unitItem;
    }



    
    /**
     * String captyItem을 반환
     * @return String captyItem
     */
    public String getCaptyItem() {
        return captyItem;
    }



    
    /**
     * captyItem을 설정
     * @param captyItem 을(를) String captyItem로 설정
     */
    public void setCaptyItem(String captyItem) {
        this.captyItem = captyItem;
    }



    
    /**
     * int amountItem을 반환
     * @return int amountItem
     */
    public String getAmountItem() {
        return amountItem;
    }



    
    /**
     * amountItem을 설정
     * @param amountItem 을(를) int amountItem로 설정
     */
    public void setAmountItem(String amountItem) {
        this.amountItem = amountItem;
    }



    
    /**
     * String cmntItem을 반환
     * @return String cmntItem
     */
    public String getCmntItem() {
        return cmntItem;
    }



    
    /**
     * cmntItem을 설정
     * @param cmntItem 을(를) String cmntItem로 설정
     */
    public void setCmntItem(String cmntItem) {
        this.cmntItem = cmntItem;
    }



    /**
     * String unitSys을 반환
     * @return String unitSys
     */
    public int getUnitSys() {
        return unitSys;
    }



    
    /**
     * unitSys을 설정
     * @param unitSys 을(를) String unitSys로 설정
     */
    public void setUnitSys(int unitSys) {
        this.unitSys = unitSys;
    }



    
    /**
     * String captySys을 반환
     * @return String captySys
     */
    public String getCaptySys() {
        return captySys;
    }



    
    /**
     * captySys을 설정
     * @param captySys 을(를) String captySys로 설정
     */
    public void setCaptySys(String captySys) {
        this.captySys = captySys;
    }



    
    /**
     * int amountSys을 반환
     * @return int amountSys
     */
    public int getAmountSys() {
        return amountSys;
    }



    
    /**
     * amountSys을 설정
     * @param amountSys 을(를) int amountSys로 설정
     */
    public void setAmountSys(int amountSys) {
        this.amountSys = amountSys;
    }



    
    /**
     * int splyMothSys을 반환
     * @return int splyMothSys
     */
    public int getSplyMothSys() {
        return splyMothSys;
    }



    
    /**
     * splyMothSys을 설정
     * @param splyMothSys 을(를) int splyMothSys로 설정
     */
    public void setSplyMothSys(int splyMothSys) {
        this.splyMothSys = splyMothSys;
    }

    /* Paprivate String 데이터 부분 */
    private String langSys;
    private String frameworkSys;
    private String cacheSys;
    private String dbmsSys;
    private String fastDeploySys;
    private String etcSys;

    /**
     * String language을 반환
     * @return String language
     */
    public String getLangSys() {
        return langSys;
    }



    
    /**
     * language을 설정
     * @param language 을(를) String language로 설정
     */
    public void setLangSys(String langSys) {
        this.langSys = langSys;
    }



    
    /**
     * String framework을 반환
     * @return String framework
     */
    public String getFrameworkSys() {
        return frameworkSys;
    }



    
    /**
     * framework을 설정
     * @param framework 을(를) String framework로 설정
     */
    public void setFrameworkSys(String frameworkSys) {
        this.frameworkSys = frameworkSys;
    }



    
    /**
     * String cache을 반환
     * @return String cache
     */
    public String getCacheSys() {
        return cacheSys;
    }



    
    /**
     * cache을 설정
     * @param cache 을(를) String cache로 설정
     */
    public void setCacheSys(String cacheSys) {
        this.cacheSys = cacheSys;
    }



    
    /**
     * String dbms을 반환
     * @return String dbms
     */
    public String getDbmsSys() {
        return dbmsSys;
    }



    
    /**
     * dbms을 설정
     * @param dbms 을(를) String dbms로 설정
     */
    public void setDbms(String dbmsSys) {
        this.dbmsSys = dbmsSys;
    }



    
    /**
     * String fastdeploy을 반환
     * @return String fastdeploy
     */
    public String getFastDeploySys() {
        return fastDeploySys;
    }



    
    /**
     * fastdeploy을 설정
     * @param fastdeploy 을(를) String fastdeploy로 설정
     */
    public void setFastDeploySys(String fastDeploySys) {
        this.fastDeploySys = fastDeploySys;
    }



    
    /**
     * String etc을 반환
     * @return String etc
     */
    public String getEtcSys() {
        return etcSys;
    }



    
    /**
     * etc을 설정
     * @param etc 을(를) String etc로 설정
     */
    public void setEtcSys(String etcSys) {
        this.etcSys = etcSys;
    }
    /* Iaprivate String 데이터 관한 부분 */
    private String serverUse;
    private String serverOs;
    private String serverCpu;
    private String serverMemory;
    private String serverDisk;
    private String serverQnty;
    private String serverIp;
    private String serverNetwork;
    private String serverGslb;
    private String serverLdbl;
    private String serverSnap;
    private String serverImg;
    private String dbUse;
    private String dbOs;
    private String dbCpu;
    private String dbMemory;
    private String dbDisk;
    private String dbQnty;
    private String dbIp;
    private String dbNetwork;
    private String dbAddDisk;
    private String dbBackStorg;
    private String dbStorgSpace;
    private String dbTransVlmn;  
    private String cdnTransVlmn;
    private String cdnRequCnt;
    private String webGoodsKind;
    private String webAccess;
    private String mntingVm;
    private String mntingIdCnt;
    private String bakupCnt;
    private String bakupStorg;
    private String mangFunc;
    private String sectyVpn;
    private String sectySslvpn;
    private String techSupt;
    private String funcDmnd1;
    private String funcDmnd2;
    private String funcDmnd3;
    private String funcDmnd4;
    private String interfaceDmnd;
    private String sectyDmnd1;
    private String sectyDmnd2;
    private String sectyDmnd3;
    private String sectyDmnd4;
    private String sectyDmnd5;
    private String qutyDmnd1;
    private String qutyDmnd2;
    private String optnDmnd1;
    private String optnDmnd2;
    private String prjtDmnd1;
    private String prjtDmnd2;
    private String prjtDmnd3;
    private String etcDmnd;




    
    
    
    
    
    /**
     * String cdnTransVlmn을 반환
     * @return String cdnTransVlmn
     */
    public String getCdnTransVlmn() {
        return cdnTransVlmn;
    }






    
    /**
     * cdnTransVlmn을 설정
     * @param cdnTransVlmn 을(를) String cdnTransVlmn로 설정
     */
    public void setCdnTransVlmn(String cdnTransVlmn) {
        this.cdnTransVlmn = cdnTransVlmn;
    }






    
    /**
     * String cdnRequCnt을 반환
     * @return String cdnRequCnt
     */
    public String getCdnRequCnt() {
        return cdnRequCnt;
    }






    
    /**
     * cdnRequCnt을 설정
     * @param cdnRequCnt 을(를) String cdnRequCnt로 설정
     */
    public void setCdnRequCnt(String cdnRequCnt) {
        this.cdnRequCnt = cdnRequCnt;
    }






    /**
     * String bakupCnt을 반환
     * @return String bakupCnt
     */
    public String getBakupCnt() {
        return bakupCnt;
    }






    
    /**
     * bakupCnt을 설정
     * @param bakupCnt 을(를) String bakupCnt로 설정
     */
    public void setBakupCnt(String bakupCnt) {
        this.bakupCnt = bakupCnt;
    }






    
    /**
     * String sectyVpn을 반환
     * @return String sectyVpn
     */
    public String getSectyVpn() {
        return sectyVpn;
    }






    
    /**
     * sectyVpn을 설정
     * @param sectyVpn 을(를) String sectyVpn로 설정
     */
    public void setSectyVpn(String sectyVpn) {
        this.sectyVpn = sectyVpn;
    }






    /**
     * String bakupStorg을 반환
     * @return String bakupStorg
     */
    public String getBakupStorg() {
        return bakupStorg;
    }






    
    /**
     * bakupStorg을 설정
     * @param bakupStorg 을(를) String bakupStorg로 설정
     */
    public void setBakupStorg(String bakupStorg) {
        this.bakupStorg = bakupStorg;
    }






    
    /**
     * String techSupt을 반환
     * @return String techSupt
     */
    public String getTechSupt() {
        return techSupt;
    }






    
    /**
     * techSupt을 설정
     * @param techSupt 을(를) String techSupt로 설정
     */
    public void setTechSupt(String techSupt) {
        this.techSupt = techSupt;
    }






    
    /**
     * String funcDmnd1을 반환
     * @return String funcDmnd1
     */
    public String getFuncDmnd1() {
        return funcDmnd1;
    }






    
    /**
     * funcDmnd1을 설정
     * @param funcDmnd1 을(를) String funcDmnd1로 설정
     */
    public void setFuncDmnd1(String funcDmnd1) {
        this.funcDmnd1 = funcDmnd1;
    }






    
    /**
     * String optnDmnd1을 반환
     * @return String optnDmnd1
     */
    public String getOptnDmnd1() {
        return optnDmnd1;
    }






    
    /**
     * optnDmnd1을 설정
     * @param optnDmnd1 을(를) String optnDmnd1로 설정
     */
    public void setOptnDmnd1(String optnDmnd1) {
        this.optnDmnd1 = optnDmnd1;
    }






    
    /**
     * String etcDmnd을 반환
     * @return String etcDmnd
     */
    public String getEtcDmnd() {
        return etcDmnd;
    }






    
    /**
     * etcDmnd을 설정
     * @param etcDmnd 을(를) String etcDmnd로 설정
     */
    public void setEtcDmnd(String etcDmnd) {
        this.etcDmnd = etcDmnd;
    }






    /**
     * String webGoodsKind을 반환
     * @return String webGoodsKind
     */
    public String getWebGoodsKind() {
        return webGoodsKind;
    }






    
    /**
     * webGoodsKind을 설정
     * @param webGoodsKind 을(를) String webGoodsKind로 설정
     */
    public void setWebGoodsKind(String webGoodsKind) {
        this.webGoodsKind = webGoodsKind;
    }






    
    /**
     * String webAccess을 반환
     * @return String webAccess
     */
    public String getWebAccess() {
        return webAccess;
    }






    
    /**
     * webAccess을 설정
     * @param webAccess 을(를) String webAccess로 설정
     */
    public void setWebAccess(String webAccess) {
        this.webAccess = webAccess;
    }






    
    /**
     * String mntingVm을 반환
     * @return String mntingVm
     */
    public String getMntingVm() {
        return mntingVm;
    }






    
    /**
     * mntingVm을 설정
     * @param mntingVm 을(를) String mntingVm로 설정
     */
    public void setMntingVm(String mntingVm) {
        this.mntingVm = mntingVm;
    }






    
    /**
     * String mntingIdCnt을 반환
     * @return String mntingIdCnt
     */
    public String getMntingIdCnt() {
        return mntingIdCnt;
    }






    
    /**
     * mntingIdCnt을 설정
     * @param mntingIdCnt 을(를) String mntingIdCnt로 설정
     */
    public void setMntingIdCnt(String mntingIdCnt) {
        this.mntingIdCnt = mntingIdCnt;
    }






    
    /**
     * String mangFunc을 반환
     * @return String mangFunc
     */
    public String getMangFunc() {
        return mangFunc;
    }






    
    /**
     * mangFunc을 설정
     * @param mangFunc 을(를) String mangFunc로 설정
     */
    public void setMangFunc(String mangFunc) {
        this.mangFunc = mangFunc;
    }






    
    /**
     * String sectySslvpn을 반환
     * @return String sectySslvpn
     */
    public String getSectySslvpn() {
        return sectySslvpn;
    }






    
    /**
     * sectySslvpn을 설정
     * @param sectySslvpn 을(를) String sectySslvpn로 설정
     */
    public void setSectySslvpn(String sectySslvpn) {
        this.sectySslvpn = sectySslvpn;
    }






    
    /**
     * String funcDmnd2을 반환
     * @return String funcDmnd2
     */
    public String getFuncDmnd2() {
        return funcDmnd2;
    }






    
    /**
     * funcDmnd2을 설정
     * @param funcDmnd2 을(를) String funcDmnd2로 설정
     */
    public void setFuncDmnd2(String funcDmnd2) {
        this.funcDmnd2 = funcDmnd2;
    }






    
    /**
     * String funcDmnd3을 반환
     * @return String funcDmnd3
     */
    public String getFuncDmnd3() {
        return funcDmnd3;
    }






    
    /**
     * funcDmnd3을 설정
     * @param funcDmnd3 을(를) String funcDmnd3로 설정
     */
    public void setFuncDmnd3(String funcDmnd3) {
        this.funcDmnd3 = funcDmnd3;
    }






    
    /**
     * String funcDmnd4을 반환
     * @return String funcDmnd4
     */
    public String getFuncDmnd4() {
        return funcDmnd4;
    }






    
    /**
     * funcDmnd4을 설정
     * @param funcDmnd4 을(를) String funcDmnd4로 설정
     */
    public void setFuncDmnd4(String funcDmnd4) {
        this.funcDmnd4 = funcDmnd4;
    }






    
    /**
     * String interfaceDmnd을 반환
     * @return String interfaceDmnd
     */
    public String getInterfaceDmnd() {
        return interfaceDmnd;
    }






    
    /**
     * interfaceDmnd을 설정
     * @param interfaceDmnd 을(를) String interfaceDmnd로 설정
     */
    public void setInterfaceDmnd(String interfaceDmnd) {
        this.interfaceDmnd = interfaceDmnd;
    }






    
    /**
     * String sectyDmnd1을 반환
     * @return String sectyDmnd1
     */
    public String getSectyDmnd1() {
        return sectyDmnd1;
    }






    
    /**
     * sectyDmnd1을 설정
     * @param sectyDmnd1 을(를) String sectyDmnd1로 설정
     */
    public void setSectyDmnd1(String sectyDmnd1) {
        this.sectyDmnd1 = sectyDmnd1;
    }






    
    /**
     * String sectyDmnd2을 반환
     * @return String sectyDmnd2
     */
    public String getSectyDmnd2() {
        return sectyDmnd2;
    }






    
    /**
     * sectyDmnd2을 설정
     * @param sectyDmnd2 을(를) String sectyDmnd2로 설정
     */
    public void setSectyDmnd2(String sectyDmnd2) {
        this.sectyDmnd2 = sectyDmnd2;
    }






    
    /**
     * String sectyDmnd3을 반환
     * @return String sectyDmnd3
     */
    public String getSectyDmnd3() {
        return sectyDmnd3;
    }






    
    /**
     * sectyDmnd3을 설정
     * @param sectyDmnd3 을(를) String sectyDmnd3로 설정
     */
    public void setSectyDmnd3(String sectyDmnd3) {
        this.sectyDmnd3 = sectyDmnd3;
    }






    
    /**
     * String sectyDmnd4을 반환
     * @return String sectyDmnd4
     */
    public String getSectyDmnd4() {
        return sectyDmnd4;
    }






    
    /**
     * sectyDmnd4을 설정
     * @param sectyDmnd4 을(를) String sectyDmnd4로 설정
     */
    public void setSectyDmnd4(String sectyDmnd4) {
        this.sectyDmnd4 = sectyDmnd4;
    }






    
    /**
     * String sectyDmnd5을 반환
     * @return String sectyDmnd5
     */
    public String getSectyDmnd5() {
        return sectyDmnd5;
    }






    
    /**
     * sectyDmnd5을 설정
     * @param sectyDmnd5 을(를) String sectyDmnd5로 설정
     */
    public void setSectyDmnd5(String sectyDmnd5) {
        this.sectyDmnd5 = sectyDmnd5;
    }






    
    /**
     * String qutyDmnd1을 반환
     * @return String qutyDmnd1
     */
    public String getQutyDmnd1() {
        return qutyDmnd1;
    }






    
    /**
     * qutyDmnd1을 설정
     * @param qutyDmnd1 을(를) String qutyDmnd1로 설정
     */
    public void setQutyDmnd1(String qutyDmnd1) {
        this.qutyDmnd1 = qutyDmnd1;
    }






    
    /**
     * String qutyDmnd2을 반환
     * @return String qutyDmnd2
     */
    public String getQutyDmnd2() {
        return qutyDmnd2;
    }






    
    /**
     * qutyDmnd2을 설정
     * @param qutyDmnd2 을(를) String qutyDmnd2로 설정
     */
    public void setQutyDmnd2(String qutyDmnd2) {
        this.qutyDmnd2 = qutyDmnd2;
    }






    
    /**
     * String optnDmnd2을 반환
     * @return String optnDmnd2
     */
    public String getOptnDmnd2() {
        return optnDmnd2;
    }






    
    /**
     * optnDmnd2을 설정
     * @param optnDmnd2 을(를) String optnDmnd2로 설정
     */
    public void setOptnDmnd2(String optnDmnd2) {
        this.optnDmnd2 = optnDmnd2;
    }






    
    /**
     * String prjtDmnd1을 반환
     * @return String prjtDmnd1
     */
    public String getPrjtDmnd1() {
        return prjtDmnd1;
    }






    
    /**
     * prjtDmnd1을 설정
     * @param prjtDmnd1 을(를) String prjtDmnd1로 설정
     */
    public void setPrjtDmnd1(String prjtDmnd1) {
        this.prjtDmnd1 = prjtDmnd1;
    }






    
    /**
     * String prjtDmnd2을 반환
     * @return String prjtDmnd2
     */
    public String getPrjtDmnd2() {
        return prjtDmnd2;
    }






    
    /**
     * prjtDmnd2을 설정
     * @param prjtDmnd2 을(를) String prjtDmnd2로 설정
     */
    public void setPrjtDmnd2(String prjtDmnd2) {
        this.prjtDmnd2 = prjtDmnd2;
    }






    
    /**
     * String prjtDmnd3을 반환
     * @return String prjtDmnd3
     */
    public String getPrjtDmnd3() {
        return prjtDmnd3;
    }






    
    /**
     * prjtDmnd3을 설정
     * @param prjtDmnd3 을(를) String prjtDmnd3로 설정
     */
    public void setPrjtDmnd3(String prjtDmnd3) {
        this.prjtDmnd3 = prjtDmnd3;
    }






    /**
     * String serverUse을 반환
     * @return String serverUse
     */
    public String getServerUse() {
        return serverUse;
    }



    
    /**
     * serverUse을 설정
     * @param serverUse 을(를) String serverUse로 설정
     */
    public void setServerUse(String serverUse) {
        this.serverUse = serverUse;
    }



    
    /**
     * String serverOs을 반환
     * @return String serverOs
     */
    public String getServerOs() {
        return serverOs;
    }



    
    /**
     * serverOs을 설정
     * @param serverOs 을(를) String serverOs로 설정
     */
    public void setServerOs(String serverOs) {
        this.serverOs = serverOs;
    }



    
    /**
     * String serverCpu을 반환
     * @return String serverCpu
     */
    public String getServerCpu() {
        return serverCpu;
    }



    
    /**
     * serverCpu을 설정
     * @param serverCpu 을(를) String serverCpu로 설정
     */
    public void setServerCpu(String serverCpu) {
        this.serverCpu = serverCpu;
    }



    
    /**
     * String serverDisk을 반환
     * @return String serverDisk
     */
    public String getServerDisk() {
        return serverDisk;
    }



    
    /**
     * serverDisk을 설정
     * @param serverDisk 을(를) String serverDisk로 설정
     */
    public void setServerDisk(String serverDisk) {
        this.serverDisk = serverDisk;
    }



    
    /**
     * String serverQnty을 반환
     * @return String serverQnty
     */
    public String getServerQnty() {
        return serverQnty;
    }



    
    /**
     * serverQnty을 설정
     * @param serverQnty 을(를) String serverQnty로 설정
     */
    public void setServerQnty(String serverQnty) {
        this.serverQnty = serverQnty;
    }



    
    /**
     * String serverIp을 반환
     * @return String serverIp
     */
    public String getServerIp() {
        return serverIp;
    }



    
    /**
     * serverIp을 설정
     * @param serverIp 을(를) String serverIp로 설정
     */
    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }



    
    /**
     * String serverNetwork을 반환
     * @return String serverNetwork
     */
    public String getServerNetwork() {
        return serverNetwork;
    }



    
    /**
     * serverNetwork을 설정
     * @param serverNetwork 을(를) String serverNetwork로 설정
     */
    public void setServerNetwork(String serverNetwork) {
        this.serverNetwork = serverNetwork;
    }



    
    /**
     * String serverGslb을 반환
     * @return String serverGslb
     */
    public String getServerGslb() {
        return serverGslb;
    }



    
    /**
     * serverGslb을 설정
     * @param serverGslb 을(를) String serverGslb로 설정
     */
    public void setServerGslb(String serverGslb) {
        this.serverGslb = serverGslb;
    }



    
    /**
     * String serverLdbl을 반환
     * @return String serverLdbl
     */
    public String getServerLdbl() {
        return serverLdbl;
    }



    
    /**
     * serverLdbl을 설정
     * @param serverLdbl 을(를) String serverLdbl로 설정
     */
    public void setServerLdbl(String serverLdbl) {
        this.serverLdbl = serverLdbl;
    }



    
    /**
     * String serverSnap을 반환
     * @return String serverSnap
     */
    public String getServerSnap() {
        return serverSnap;
    }



    
    /**
     * serverSnap을 설정
     * @param serverSnap 을(를) String serverSnap로 설정
     */
    public void setServerSnap(String serverSnap) {
        this.serverSnap = serverSnap;
    }



    
    /**
     * String serverImg을 반환
     * @return String serverImg
     */
    public String getServerImg() {
        return serverImg;
    }



    
    /**
     * serverImg을 설정
     * @param serverImg 을(를) String serverImg로 설정
     */
    public void setServerImg(String serverImg) {
        this.serverImg = serverImg;
    }



    
    /**
     * String dbUse을 반환
     * @return String dbUse
     */
    public String getDbUse() {
        return dbUse;
    }



    
    /**
     * dbUse을 설정
     * @param dbUse 을(를) String dbUse로 설정
     */
    public void setDbUse(String dbUse) {
        this.dbUse = dbUse;
    }



    
    /**
     * String dbOs을 반환
     * @return String dbOs
     */
    public String getDbOs() {
        return dbOs;
    }



    
    /**
     * dbOs을 설정
     * @param dbOs 을(를) String dbOs로 설정
     */
    public void setDbOs(String dbOs) {
        this.dbOs = dbOs;
    }



    
    /**
     * String dbCpu을 반환
     * @return String dbCpu
     */
    public String getDbCpu() {
        return dbCpu;
    }



    
    /**
     * dbCpu을 설정
     * @param dbCpu 을(를) String dbCpu로 설정
     */
    public void setDbCpu(String dbCpu) {
        this.dbCpu = dbCpu;
    }



    
    /**
     * String dbDisk을 반환
     * @return String dbDisk
     */
    public String getDbDisk() {
        return dbDisk;
    }



    
    /**
     * dbDisk을 설정
     * @param dbDisk 을(를) String dbDisk로 설정
     */
    public void setDbDisk(String dbDisk) {
        this.dbDisk = dbDisk;
    }



    
    /**
     * String dbQnty을 반환
     * @return String dbQnty
     */
    public String getDbQnty() {
        return dbQnty;
    }



    
    /**
     * dbQnty을 설정
     * @param dbQnty 을(를) String dbQnty로 설정
     */
    public void setDbQnty(String dbQnty) {
        this.dbQnty = dbQnty;
    }



    
    /**
     * String dbIp을 반환
     * @return String dbIp
     */
    public String getDbIp() {
        return dbIp;
    }



    
    /**
     * dbIp을 설정
     * @param dbIp 을(를) String dbIp로 설정
     */
    public void setDbIp(String dbIp) {
        this.dbIp = dbIp;
    }



    
    /**
     * String dbNetwork을 반환
     * @return String dbNetwork
     */
    public String getDbNetwork() {
        return dbNetwork;
    }



    
    /**
     * dbNetwork을 설정
     * @param dbNetwork 을(를) String dbNetwork로 설정
     */
    public void setDbNetwork(String dbNetwork) {
        this.dbNetwork = dbNetwork;
    }



    
    /**
     * String dbAddDisk을 반환
     * @return String dbAddDisk
     */
    public String getDbAddDisk() {
        return dbAddDisk;
    }



    
    /**
     * dbAddDisk을 설정
     * @param dbAddDisk 을(를) String dbAddDisk로 설정
     */
    public void setDbAddDisk(String dbAddDisk) {
        this.dbAddDisk = dbAddDisk;
    }



    
    /**
     * String dbBackStorg을 반환
     * @return String dbBackStorg
     */
    public String getDbBackStorg() {
        return dbBackStorg;
    }



    
    /**
     * dbBackStorg을 설정
     * @param dbBackStorg 을(를) String dbBackStorg로 설정
     */
    public void setDbBackStorg(String dbBackStorg) {
        this.dbBackStorg = dbBackStorg;
    }



    
    /**
     * String dbStorgSpace을 반환
     * @return String dbStorgSpace
     */
    public String getDbStorgSpace() {
        return dbStorgSpace;
    }



    
    /**
     * dbStorgSpace을 설정
     * @param dbStorgSpace 을(를) String dbStorgSpace로 설정
     */
    public void setDbStorgSpace(String dbStorgSpace) {
        this.dbStorgSpace = dbStorgSpace;
    }



    
    /**
     * String dbTransVlmn을 반환
     * @return String dbTransVlmn
     */
    public String getDbTransVlmn() {
        return dbTransVlmn;
    }



    
    /**
     * dbTransVlmn을 설정
     * @param dbTransVlmn 을(를) String dbTransVlmn로 설정
     */
    public void setDbTransVlmn(String dbTransVlmn) {
        this.dbTransVlmn = dbTransVlmn;
    }



    
    /**
     * dbmsSys을 설정
     * @param dbmsSys 을(를) String dbmsSys로 설정
     */
    public void setDbmsSys(String dbmsSys) {
        this.dbmsSys = dbmsSys;
    }



    
    /**
     * String serverMemory을 반환
     * @return String serverMemory
     */
    public String getServerMemory() {
        return serverMemory;
    }



    
    /**
     * serverMemory을 설정
     * @param serverMemory 을(를) String serverMemory로 설정
     */
    public void setServerMemory(String serverMemory) {
        this.serverMemory = serverMemory;
    }



    
    /**
     * String dbMemory을 반환
     * @return String dbMemory
     */
    public String getDbMemory() {
        return dbMemory;
    }



    
    /**
     * dbMemory을 설정
     * @param dbMemory 을(를) String dbMemory로 설정
     */
    public void setDbMemory(String dbMemory) {
        this.dbMemory = dbMemory;
    }
    
    

    /**
     * String addAnswer을 반환
     * @return String addAnswer
     */
    public String getAddAnswer() {
        return addAnswer;
    }






    
    /**
     * addAnswer을 설정
     * @param addAnswer 을(를) String addAnswer로 설정
     */
    public void setAddAnswer(String addAnswer) {
        this.addAnswer = addAnswer;
    }






    
    /**
     * String splyNote을 반환
     * @return String splyNote
     */
    public String getSplyNote() {
        return splyNote;
    }






    
    /**
     * splyNote을 설정
     * @param splyNote 을(를) String splyNote로 설정
     */
    public void setSplyNote(String splyNote) {
        this.splyNote = splyNote;
    }



    /**
     * String positions을 반환
     * @return String positions
     */
    public String getPositions() {
        return positions;
    }




    
    /**
     * positions을 설정
     * @param positions 을(를) String positions로 설정
     */
    public void setPositions(String positions) {
        this.positions = positions;
    }






    /**
     * String supplyAmounts을 반환
     * @return String supplyAmounts
     */
    public String getSupplyAmounts() {
        return supplyAmounts;
    }






    
    /**
     * supplyAmounts을 설정
     * @param supplyAmounts 을(를) String supplyAmounts로 설정
     */
    public void setSupplyAmounts(String supplyAmounts) {
        this.supplyAmounts = supplyAmounts;
    }


    /**
     * String explanatorys을 반환
     * @return String explanatorys
     */
    public String getExplanatorys() {
        return explanatorys;
    }






    
    /**
     * explanatorys을 설정
     * @param explanatorys 을(를) String explanatorys로 설정
     */
    public void setExplanatorys(String explanatorys) {
        this.explanatorys = explanatorys;
    }
    
    
    
    
    
    
    /* applyPopup 데이서 셋 */
    private int cntrctSn;
    private String svcNm;
    private String cntrctBeginDe;
    private String cntrctEndDe;
    private int cntrctaMount;
    private String purchsInsttNm;
    private String sleInsttNm;
    private int ctrtcSn;
    private String registDt;
    private String updtId;
    private String updtDt;
    private String deleteAt;
    private String cntrNum;
    private String cntrDt;
    private String commUserId;


    
    
    
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
     * int cntrctamount을 반환
     * @return int cntrctamount
     */
    public int getCntrctaMount() {
        return cntrctaMount;
    }







    
    /**
     * cntrctamount을 설정
     * @param cntrctamount 을(를) int cntrctamount로 설정
     */
    public void setCntrctaMount(int cntrctaMount) {
        this.cntrctaMount = cntrctaMount;
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
     * String cntrNum을 반환
     * @return String cntrNum
     */
    public String getCntrNum() {
        return cntrNum;
    }







    
    /**
     * cntrNum을 설정
     * @param cntrNum 을(를) String cntrNum로 설정
     */
    public void setCntrNum(String cntrNum) {
        this.cntrNum = cntrNum;
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
     * String commUserId을 반환
     * @return String commUserId
     */
    public String getCommUserId() {
        return commUserId;
    }







    
    /**
     * commUserId을 설정
     * @param commUserId 을(를) String commUserId로 설정
     */
    public void setCommUserId(String commUserId) {
        this.commUserId = commUserId;
    }
  
    
}
