/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCeart.vo;

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
public class MyCeartBeforeNofyVO extends PaggingVO {

    
    private static final long serialVersionUID = 1L;
    
    private String notifyNum;            /** 공고번호 */    
    private int notifySeq;               /** 공고차수 */    
    private String userId;               /** 공급자ID */    
    private String goodsCode;            /** 상품코드 */    
    private String confmGbn;             /** 확인여부 */    
    private String askApplyCd;           /** 답변여부 */    
    private String splyAmt;              /** 공급가 */
    private String vatGbn;               /** VAT여부 */    
    private String addAnswer;            /** 추가문의*/    
    private String splyNote;             /** 비고 */    
    private int splyFile;                /** 납품 - 첨부파일 */
    private List<FileVO> splyFileList;   /** 납품 - 첨부파일 */    
    private String entrDt;               /** 답변일시 */    
    private String bidGbnCd;             /** 종류여부 */   
    private String goodKndCd;            /** 서비스구분 */    
    private String grpSeq;               /** 구매희망목록 */    
    private String nofyDt;               /** 견적요청일 */ 
    private String splyDt;               /** 견적수신일 */
    
    private String useFromDt;            /** 사용기간_부터 */
    private String useToDt;              /** 사용기간_까지 */
    private String puchBudgetAmt;        /** 구매예산(원) */
    
    private String hopePuchAmt;          /** 희망구매가 */    
    private String delyDt;               /** 납품일 */
    private String delyTime;             /** 납품시간 */    
    private String talkGbn;              /** 협의여부 */    
    private String rplyDt;               /** 응답완료일 */   
    private String rplyTime;             /** 응답완료시간 */    
    private String delyPlac;             /** 납품장소 */    
    private int delyFile;                /** 납품-첨부파일 SEQ */   
    private String delyFileOrgNm;        /** 납품-첨부파일 실 파일명 */    
    private String delyFileId;           /** 납품-첨부파일 파일ID(OP_FILE테이블 참조) */    
    private String delyFileSize;         /** 납품-첨부파일 파일명 Size */    
    private String delyFileTy;           /** 납품-첨부파일 파일명 Type */   
    private String addCont;              /** 추가답변 */    
    private String goodsChargerNm;       /** 담당자명 */    
    private String goodsChargerCttpc;    /** 연락처 */    
    private String realDmndOrgn;         /** 기관명 */    
    private String userPosition;         /** 직책 */    
    private String userEmail;            /** 이메일 */    
    private String userTelno;            /** 대표전화 */    
    private String updtDt;               /** 수정일 */    
    private String cnclDt;               /** 취소일 */    
    private String langStoreId;          /** 상점아이디 */    
    private String langStoreNm;          /** 언어별상점명 */    
    private String goodsNm;              /** 상품명 */    
    private String goodsKndCd;           /** 상품종류코드 */    
    private String searchDiv01;          /** 조회조건1 */    
    private String searchDiv02;          /** 조회조건2 */    
    private String searchKeyWord;        /** 조회 Text */    
    private String langCode;             /** 언어코드 */    
    private List<String> langCodes;      /** 언어코드 배열 */    
    private String delete_at;            /** 삭제여부 */
    private String buseoCode;            /**기관코드*/
    private Integer userTyCd;             /**회원분류코드*/

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
     * String confmGbn을 반환
     * @return String confmGbn
     */
    public String getConfmGbn() {
        return confmGbn;
    }

    
    /**
     * confmGbn을 설정
     * @param confmGbn 을(를) String confmGbn로 설정
     */
    public void setConfmGbn(String confmGbn) {
        this.confmGbn = confmGbn;
    }

    
    /**
     * String askApplyCd을 반환
     * @return String askApplyCd
     */
    public String getAskApplyCd() {
        return askApplyCd;
    }

    
    /**
     * askApplyCd을 설정
     * @param askApplyCd 을(를) String askApplyCd로 설정
     */
    public void setAskApplyCd(String askApplyCd) {
        this.askApplyCd = askApplyCd;
    }

    
    /**
     * String splyAmt을 반환
     * @return String splyAmt
     */
    public String getSplyAmt() {
        return splyAmt;
    }

    
    /**
     * splyAmt을 설정
     * @param splyAmt 을(를) String splyAmt로 설정
     */
    public void setSplyAmt(String splyAmt) {
        this.splyAmt = splyAmt;
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
     * int splyFile을 반환
     * @return int splyFile
     */
    public int getSplyFile() {
        return splyFile;
    }

    
    /**
     * splyFile을 설정
     * @param splyFile 을(를) int splyFile로 설정
     */
    public void setSplyFile(int splyFile) {
        this.splyFile = splyFile;
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
    public String getPuchBudgetAmt() {
        return puchBudgetAmt;
    }


    /**
     * puchBudgetAmt을 설정
     * @param puchBudgetAmt 을(를) String puchBudgetAmt로 설정
     */
    public void setPuchBudgetAmt(String puchBudgetAmt) {
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
     * String rplyTime을 반환
     * @return String rplyTime
     */
    public String getRplyTime() {
        return rplyTime;
    }

    
    /**
     * rplyTime을 설정
     * @param rplyTime 을(를) String rplyTime로 설정
     */
    public void setRplyTime(String rplyTime) {
        this.rplyTime = rplyTime;
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
     * String delyFileOrgNm을 반환
     * @return String delyFileOrgNm
     */
    public String getDelyFileOrgNm() {
        return delyFileOrgNm;
    }

    
    /**
     * delyFileOrgNm을 설정
     * @param delyFileOrgNm 을(를) String delyFileOrgNm로 설정
     */
    public void setDelyFileOrgNm(String delyFileOrgNm) {
        this.delyFileOrgNm = delyFileOrgNm;
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
     * String delyFileSize을 반환
     * @return String delyFileSize
     */
    public String getDelyFileSize() {
        return delyFileSize;
    }

    
    /**
     * delyFileSize을 설정
     * @param delyFileSize 을(를) String delyFileSize로 설정
     */
    public void setDelyFileSize(String delyFileSize) {
        this.delyFileSize = delyFileSize;
    }

    
    /**
     * String delyFileTy을 반환
     * @return String delyFileTy
     */
    public String getDelyFileTy() {
        return delyFileTy;
    }

    
    /**
     * delyFileTy을 설정
     * @param delyFileTy 을(를) String delyFileTy로 설정
     */
    public void setDelyFileTy(String delyFileTy) {
        this.delyFileTy = delyFileTy;
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
     * String goodsKndCd을 반환
     * @return String goodsKndCd
     */
    public String getGoodsKndCd() {
        return goodsKndCd;
    }

    
    /**
     * goodsKndCd을 설정
     * @param goodsKndCd 을(를) String goodsKndCd로 설정
     */
    public void setGoodsKndCd(String goodsKndCd) {
        this.goodsKndCd = goodsKndCd;
    }

    
    /**
     * String searchDiv01을 반환
     * @return String searchDiv01
     */
    public String getSearchDiv01() {
        return searchDiv01;
    }

    
    /**
     * searchDiv01을 설정
     * @param searchDiv01 을(를) String searchDiv01로 설정
     */
    public void setSearchDiv01(String searchDiv01) {
        this.searchDiv01 = searchDiv01;
    }

    
    /**
     * String searchDiv02을 반환
     * @return String searchDiv02
     */
    public String getSearchDiv02() {
        return searchDiv02;
    }

    
    /**
     * searchDiv02을 설정
     * @param searchDiv02 을(를) String searchDiv02로 설정
     */
    public void setSearchDiv02(String searchDiv02) {
        this.searchDiv02 = searchDiv02;
    }

    
    /**
     * String searchKeyWord을 반환
     * @return String searchKeyWord
     */
    public String getSearchKeyWord() {
        return searchKeyWord;
    }

    
    /**
     * searchKeyWord을 설정
     * @param searchKeyWord 을(를) String searchKeyWord로 설정
     */
    public void setSearchKeyWord(String searchKeyWord) {
        this.searchKeyWord = searchKeyWord;
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
     * String delete_at을 반환
     * @return String delete_at
     */
    public String getDelete_at() {
        return delete_at;
    }


    
    /**
     * delete_at을 설정
     * @param delete_at 을(를) String delete_at로 설정
     */
    public void setDelete_at(String delete_at) {
        this.delete_at = delete_at;
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
     * String userTyCd을 반환
     * @return String userTyCd
     */
    public Integer getUserTyCd() {
        return userTyCd;
    }


    /**
     * userTyCd을 설정
     * @param integer 을(를) String userTyCd로 설정
     */
    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }



    
}
