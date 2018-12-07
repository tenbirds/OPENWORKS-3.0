/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.before;

import java.util.List;

import zes.base.vo.FileVO;
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
public class TcnBeforeNotifyVO extends PaggingVO {

    private static final long serialVersionUID = 1L;

    private String notifyNum;            /** 공고번호 */    
    private int notifySeq;               /** 공고차수 */    
    private String bidGbnCd;             /** 입찰종류여부 */    
    private String goodKndCd;            /** 서비스구분 */    
    private String userId;               /** 수요자ID */    
    private String grpSeq;               /** 구매희망목록순번 */    
    private String nofyDt;               /** 견적 요청일 */    
    private String splyDt;               /** 견적수신일 */
    
    private String useFromDt;            /** 사용기간-부터 */
    private String useToDt;              /** 사용기간-까지 */
    private String puchBudgetAmt;        /** 구매예산 */
    
    private String hopePuchAmt;          /** 희망구매가 */    
    private String vatGbn;               /** vat여부 */
    
    private String delyDt;               /** 납품일자 */    
    private String delyTime;             /** 납품시간 */
    
    private String talkGbn;              /** 합의여부 */    
    private String rplyDt;               /** 응답완료일 */    
    private String delyPlac;             /** 납품장소 */    
    private int delyFile;                /** 납품-첨부파일 */    
    private List<FileVO> delyFileList;   /** 납품-첨부파일 */    
    private String delyFileId;           /** 납품-첨부파일ID(임시저장시 기존 등록되어 있는 파일을 구분하기 위해) */    
    private String addCont;              /** 공고설명 */    
    private String goodsChargerNm;       /** 담당자명 */    
    private String goodsChargerCttpc;    /** 연락처 */    
    private String realDmndOrgn;         /** 기관명 */    
    private String userPosition;         /** 직책 */    
    private String userEmail;            /** 이메일 */    
    private String userTelno;            /** 대표전화 */    
    private String entrDt;               /** 등록일 */    
    private String updtDt;               /** 수정일 */    
    private String cnclDt;               /** 취소일 */    
    private String goodsCd;              /** 상품코드 */    
    private List<String> goodsCodeList;  /** 서비스코드 배열*/
    
    private String realDmndOrgnCd;        /**상위기관 코드*/
    private String realDmndBuseoCd;       /**부서코드*/
    
    
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
    public String getBidGbnCd() {
        return bidGbnCd;
    }

    
    /**
     * bidGbnCd을 설정
     * @param bidGbnCd 을(를) String bidGbnCd로 설정
     */
    public void setBidGbnCd(String bidGbnCd) {
        this.bidGbnCd = bidGbnCd;
    }

    
    /**
     * String goodKndCd을 반환
     * @return String goodKndCd
     */
    public String getGoodKndCd() {
        return goodKndCd;
    }

    
    /**
     * goodKndCd을 설정
     * @param goodKndCd 을(를) String goodKndCd로 설정
     */
    public void setGoodKndCd(String goodKndCd) {
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
     * @param userId 을(를) String user_id로 설정
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }
    

    /**
     * String grpSeq을 반환
     * @return String grpSeq
     */
    public String getGrpSeq() {
        return grpSeq;
    }


    
    /**
     * grpSeq을 설정
     * @param grpSeq 을(를) String grpSeq로 설정
     */
    public void setGrpSeq(String grpSeq) {
        this.grpSeq = grpSeq;
    }
    
    
    /**
     * String nofyDt을 반환
     * @return String nofyDt
     */
    public String getNofyDt() {
        return nofyDt;
    }

    
    /**
     * nofyDt을 설정
     * @param nofyDt 을(를) String nofyDt로 설정
     */
    public void setNofyDt(String nofyDt) {
        this.nofyDt = nofyDt;
    }

    
    /**
     * String splyDt을 반환
     * @return String splyDt
     */
    public String getSplyDt() {
        return splyDt;
    }

    
    /**
     * splyDt을 설정
     * @param splyDt 을(를) String splyDt로 설정
     */
    public void setSplyDt(String splyDt) {
        this.splyDt = splyDt;
    }
    
    /**
     * String useFromDt을 반환
     * @return String useFromDt
     */
    public String getUseFromDt() {
        return useFromDt;
    }


    /**
     * useFromDt을 설정
     * @param useFromDt 을(를) String useFromDt로 설정
     */
    public void setUseFromDt(String useFromDt) {
        this.useFromDt = useFromDt;
    }


    /**
     * String useToDt을 반환
     * @return String useToDt
     */
    public String getUseToDt() {
        return useToDt;
    }


    /**
     * useToDt을 설정
     * @param useToDt 을(를) String useToDt로 설정
     */
    public void setUseToDt(String useToDt) {
        this.useToDt = useToDt;
    }


    /**
     * String puchBudgetAmt을 반환
     * @return String puchBudgetAmt
     */
    public String getpuchBudgetAmt() {
        return puchBudgetAmt;
    }


    /**
     * puchBudgetAmt을 설정
     * @param puchBudgetAmt 을(를) String puchBudgetAmt로 설정
     */
    public void setpuchBudgetAmt(String puchBudgetAmt) {
        this.puchBudgetAmt = puchBudgetAmt;
    }
    
    /**
     * String hopePuchAmt을 반환
     * @return String hopePuchAmt
     */
    public String getHopePuchAmt() {
        return hopePuchAmt;
    }

    
    /**
     * hopePuchAmt을 설정
     * @param hopePuchAmt 을(를) String hopePuchAmt로 설정
     */
    public void setHopePuchAmt(String hopePuchAmt) {
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
     * String delyTime을 반환
     * @return String delyTime
     */
    public String getDelyTime() {
        return delyTime;
    }


    
    /**
     * delyTime을 설정
     * @param delyTime 을(를) String delyTime로 설정
     */
    public void setDelyTime(String delyTime) {
        this.delyTime = delyTime;
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
     * int delyFile을 반환
     * @return int delyFile
     */
    public int getDelyFile() {
        return delyFile;
    }

    
    /**
     * delyFile을 설정
     * @param delyFile 을(를) int delyFile로 설정
     */
    public void setDelyFile(int delyFile) {
        this.delyFile = delyFile;
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
     * String delyFileId을 반환
     * @return String delyFileId
     */
    public String getDelyFileId() {
        return delyFileId;
    }

    
    /**
     * delyFileId을 설정
     * @param delyFileId 을(를) String delyFileId로 설정
     */
    public void setDelyFileId(String delyFileId) {
        this.delyFileId = delyFileId;
    }

    
    /**
     * String addCont을 반환
     * @return String addCont
     */
    public String getAddCont() {
        return addCont;
    }

    
    /**
     * addCont을 설정
     * @param addCont 을(를) String addCont로 설정
     */
    public void setAddCont(String addCont) {
        this.addCont = addCont;
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
     * String realDmndOrgn을 반환
     * @return String realDmndOrgn
     */
    public String getRealDmndOrgn() {
        return realDmndOrgn;
    }

    
    /**
     * realDmndOrgn을 설정
     * @param realDmndOrgn 을(를) String realDmndOrgn로 설정
     */
    public void setRealDmndOrgn(String realDmndOrgn) {
        this.realDmndOrgn = realDmndOrgn;
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
     * String userEmail을 반환
     * @return String userEmail
     */
    public String getUserEmail() {
        return userEmail;
    }

    
    /**
     * userEmail을 설정
     * @param userEmail 을(를) String userEmail로 설정
     */
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    
    /**
     * String userTelno을 반환
     * @return String userTelno
     */
    public String getUserTelno() {
        return userTelno;
    }

    
    /**
     * userTelno을 설정
     * @param userTelno 을(를) String userTelno로 설정
     */
    public void setUserTelno(String userTelno) {
        this.userTelno = userTelno;
    }

    
    /**
     * String entrDt을 반환
     * @return String entrDt
     */
    public String getEntrDt() {
        return entrDt;
    }

    
    /**
     * entrDt을 설정
     * @param entrDt 을(를) String entrDt로 설정
     */
    public void setEntrDt(String entrDt) {
        this.entrDt = entrDt;
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
     * String cnclDt을 반환
     * @return String cnclDt
     */
    public String getCnclDt() {
        return cnclDt;
    }

    
    /**
     * cnclDt을 설정
     * @param cnclDt 을(를) String cnclDt로 설정
     */
    public void setCnclDt(String cnclDt) {
        this.cnclDt = cnclDt;
    }

    
    /**
     * long serialversionuid을 반환
     * @return long serialversionuid
     */
    public static long getSerialversionuid() {
        return serialVersionUID;
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
     * List<String> goodsCodeList을 반환
     * @return List<String> goodsCodeList
     */
    public List<String> getGoodsCodeList() {
        return goodsCodeList;
    }


    
    /**
     * goodsCodeList을 설정
     * @param goodsCodeList 을(를) List<String> goodsCodeList로 설정
     */
    public void setGoodsCodeList(List<String> goodsCodeList) {
        this.goodsCodeList = goodsCodeList;
    }


    /**
     * String realDmndOrgnCd을 반환
     * @return String realDmndOrgnCd
     */
    public String getRealDmndOrgnCd() {
        return realDmndOrgnCd;
    }


    /**
     * realDmndOrgnCd을 설정
     * @param realDmndOrgnCd 을(를) String realDmndOrgnCd로 설정
     */
    public void setRealDmndOrgnCd(String realDmndOrgnCd) {
        this.realDmndOrgnCd = realDmndOrgnCd;
    }


    /**
     * String realDmndBuseoCd을 반환
     * @return String realDmndBuseoCd
     */
    public String getRealDmndBuseoCd() {
        return realDmndBuseoCd;
    }


    /**
     * realDmndBuseoCd을 설정
     * @param realDmndBuseoCd 을(를) String realDmndBuseoCd로 설정
     */
    public void setRealDmndBuseoCd(String realDmndBuseoCd) {
        this.realDmndBuseoCd = realDmndBuseoCd;
    }



}