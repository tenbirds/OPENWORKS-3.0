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
public class MyCeartPurchsDtlsVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 언어코드 */
    private String langCode;

    /** 언어코드 배열 */
    private List<String> langCodes;

    /** 계약관리정보 순번 */
    private String cntrctSn;

    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;

    /** 입찰종류여부(2037) */
    private int bidGbnCd;
    
    /** 입찰종류명 */
    private String bidGbnNm;
    
    /** 공급자ID */
    private String suplerId;
    
    /** 공급자명 */
    private String suplerNm;

    /** 공급자 기관명 */
    private String suplerStoreNm;

    /** 수요자아이디 */
    private String endsUserId;
    
    /** 수요자명 */
    private String endsUserNm;

    /** 서비스코드 */
    private String goodsCode;
    
    /** 서비스명 */
    private String goodsNm;
    
    /** 평가서 파일 SEQ */
    private String evalSheetFile;
    
    /** 평가서 실파일명 */
    private String evalSheetFileOrgNm;
    
    /** 평가서 파일 ID */
    private String evalSheetFileId;
    
    /** 평가서 파일 size */
    private String evalSheetFileSize;
    
    /** 평가서 파일 type */
    private String evalSheetFileTy;

    /** 계약일자 */
    private String cntrDt;
    
    /** 계약시작일 */
    private String cntrctBeginDe;
    
    /** 계약종료일 */
    private String cntrctEndDe;

    /** 실적증명서 요청상태(2045) */
    private String certReultCode;

    /** 실적증명서 요청상태 명 */
    private String certReultNm;

    /** 계약서 파일 SEQ */
    private String ctrtcSn;
    
    /** 계약서 실 파일명 */
    private String ctrtcSnOrgNm;
    
    /** 계약서 파일 ID */
    private String ctrtcSnId;
    
    /** 계약서 파일 size */
    private String ctrtcSnSize;
    
    /** 계약서 파일 type */
    private String ctrtcSnTy;

    /** 계약결과 등록여부(견적/공고 없이 계약등록) */
    private String myCtrtcYn;

    /** 조회조건1 */
    private String searchDiv01;
    
    /** 조회조건2 */
    private String searchDiv02;
    
    /** 조회 Text */
    private String searchKeyWord;

    /** 수의계약 전용  공급형태(구매방식) */
    private String splyForm;
    /** 수의계약 전용 서비스명*/
    private String svcNm;
    /** 수의계약 전용 금액 */
    private int cntrctaMount;
    /** 수의계약 서비스명 */
    private String sleInsttNm;
    
    /** 수의계약,수기입력 분류 코드 */
    private String registMthdCode;
    
    private String buseoCode;   /**기관코드*/
    private Integer userTyCd;   /**회원유형코드*/
    
    
    
    
    /**
     * String registMthdCode을 반환
     * @return String registMthdCode
     */
    public String getRegistMthdCode() {
        return registMthdCode;
    }






    
    /**
     * registMthdCode을 설정
     * @param registMthdCode 을(를) String registMthdCode로 설정
     */
    public void setRegistMthdCode(String registMthdCode) {
        this.registMthdCode = registMthdCode;
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
     * int cntrctaMount을 반환
     * @return int cntrctaMount
     */
    public int getCntrctaMount() {
        return cntrctaMount;
    }




    
    /**
     * cntrctaMount을 설정
     * @param cntrctaMount 을(를) int cntrctaMount로 설정
     */
    public void setCntrctaMount(int cntrctaMount) {
        this.cntrctaMount = cntrctaMount;
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
     * String cntrctSn을 반환
     * @return String cntrctSn
     */
    public String getCntrctSn() {
        return cntrctSn;
    }

    
    /**
     * cntrctSn을 설정
     * @param cntrctSn 을(를) String cntrctSn로 설정
     */
    public void setCntrctSn(String cntrctSn) {
        this.cntrctSn = cntrctSn;
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
     * int bidGbnCd을 반환
     * @return int bidGbnCd
     */
    public int getBidGbnCd() {
        return bidGbnCd;
    }

    
    /**
     * bidGbnCd을 설정
     * @param bidGbnCd 을(를) int bidGbnCd로 설정
     */
    public void setBidGbnCd(int bidGbnCd) {
        this.bidGbnCd = bidGbnCd;
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
     * String suplerId을 반환
     * @return String suplerId
     */
    public String getSuplerId() {
        return suplerId;
    }

    
    /**
     * suplerId을 설정
     * @param suplerId 을(를) String suplerId로 설정
     */
    public void setSuplerId(String suplerId) {
        this.suplerId = suplerId;
    }

    
    /**
     * String suplerNm을 반환
     * @return String suplerNm
     */
    public String getSuplerNm() {
        return suplerNm;
    }

    
    /**
     * suplerNm을 설정
     * @param suplerNm 을(를) String suplerNm로 설정
     */
    public void setSuplerNm(String suplerNm) {
        this.suplerNm = suplerNm;
    }

    
    /**
     * String suplerStoreNm을 반환
     * @return String suplerStoreNm
     */
    public String getSuplerStoreNm() {
        return suplerStoreNm;
    }

    
    /**
     * suplerStoreNm을 설정
     * @param suplerStoreNm 을(를) String suplerStoreNm로 설정
     */
    public void setSuplerStoreNm(String suplerStoreNm) {
        this.suplerStoreNm = suplerStoreNm;
    }

    
    /**
     * String endsUserId을 반환
     * @return String endsUserId
     */
    public String getEndsUserId() {
        return endsUserId;
    }

    
    /**
     * endsUserId을 설정
     * @param endsUserId 을(를) String endsUserId로 설정
     */
    public void setEndsUserId(String endsUserId) {
        this.endsUserId = endsUserId;
    }

    
    /**
     * String endsUserNm을 반환
     * @return String endsUserNm
     */
    public String getEndsUserNm() {
        return endsUserNm;
    }

    
    /**
     * endsUserNm을 설정
     * @param endsUserNm 을(를) String endsUserNm로 설정
     */
    public void setEndsUserNm(String endsUserNm) {
        this.endsUserNm = endsUserNm;
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
     * String evalSheetFile을 반환
     * @return String evalSheetFile
     */
    public String getEvalSheetFile() {
        return evalSheetFile;
    }

    
    /**
     * evalSheetFile을 설정
     * @param evalSheetFile 을(를) String evalSheetFile로 설정
     */
    public void setEvalSheetFile(String evalSheetFile) {
        this.evalSheetFile = evalSheetFile;
    }

    
    /**
     * String evalSheetFileOrgNm을 반환
     * @return String evalSheetFileOrgNm
     */
    public String getEvalSheetFileOrgNm() {
        return evalSheetFileOrgNm;
    }

    
    /**
     * evalSheetFileOrgNm을 설정
     * @param evalSheetFileOrgNm 을(를) String evalSheetFileOrgNm로 설정
     */
    public void setEvalSheetFileOrgNm(String evalSheetFileOrgNm) {
        this.evalSheetFileOrgNm = evalSheetFileOrgNm;
    }

    
    /**
     * String evalSheetFileId을 반환
     * @return String evalSheetFileId
     */
    public String getEvalSheetFileId() {
        return evalSheetFileId;
    }

    
    /**
     * evalSheetFileId을 설정
     * @param evalSheetFileId 을(를) String evalSheetFileId로 설정
     */
    public void setEvalSheetFileId(String evalSheetFileId) {
        this.evalSheetFileId = evalSheetFileId;
    }

    
    /**
     * String evalSheetFileSize을 반환
     * @return String evalSheetFileSize
     */
    public String getEvalSheetFileSize() {
        return evalSheetFileSize;
    }

    
    /**
     * evalSheetFileSize을 설정
     * @param evalSheetFileSize 을(를) String evalSheetFileSize로 설정
     */
    public void setEvalSheetFileSize(String evalSheetFileSize) {
        this.evalSheetFileSize = evalSheetFileSize;
    }

    
    /**
     * String evalSheetFileTy을 반환
     * @return String evalSheetFileTy
     */
    public String getEvalSheetFileTy() {
        return evalSheetFileTy;
    }

    
    /**
     * evalSheetFileTy을 설정
     * @param evalSheetFileTy 을(를) String evalSheetFileTy로 설정
     */
    public void setEvalSheetFileTy(String evalSheetFileTy) {
        this.evalSheetFileTy = evalSheetFileTy;
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
     * String certReultCode을 반환
     * @return String certReultCode
     */
    public String getCertReultCode() {
        return certReultCode;
    }

    
    /**
     * certReultCode을 설정
     * @param certReultCode 을(를) String certReultCode로 설정
     */
    public void setCertReultCode(String certReultCode) {
        this.certReultCode = certReultCode;
    }

    
    /**
     * String certReultNm을 반환
     * @return String certReultNm
     */
    public String getCertReultNm() {
        return certReultNm;
    }

    
    /**
     * certReultNm을 설정
     * @param certReultNm 을(를) String certReultNm로 설정
     */
    public void setCertReultNm(String certReultNm) {
        this.certReultNm = certReultNm;
    }

    
    /**
     * String ctrtcSn을 반환
     * @return String ctrtcSn
     */
    public String getCtrtcSn() {
        return ctrtcSn;
    }

    
    /**
     * ctrtcSn을 설정
     * @param ctrtcSn 을(를) String ctrtcSn로 설정
     */
    public void setCtrtcSn(String ctrtcSn) {
        this.ctrtcSn = ctrtcSn;
    }

    
    /**
     * String ctrtcSnOrgNm을 반환
     * @return String ctrtcSnOrgNm
     */
    public String getCtrtcSnOrgNm() {
        return ctrtcSnOrgNm;
    }

    
    /**
     * ctrtcSnOrgNm을 설정
     * @param ctrtcSnOrgNm 을(를) String ctrtcSnOrgNm로 설정
     */
    public void setCtrtcSnOrgNm(String ctrtcSnOrgNm) {
        this.ctrtcSnOrgNm = ctrtcSnOrgNm;
    }

    
    /**
     * String ctrtcSnId을 반환
     * @return String ctrtcSnId
     */
    public String getCtrtcSnId() {
        return ctrtcSnId;
    }

    
    /**
     * ctrtcSnId을 설정
     * @param ctrtcSnId 을(를) String ctrtcSnId로 설정
     */
    public void setCtrtcSnId(String ctrtcSnId) {
        this.ctrtcSnId = ctrtcSnId;
    }

    
    /**
     * String ctrtcSnSize을 반환
     * @return String ctrtcSnSize
     */
    public String getCtrtcSnSize() {
        return ctrtcSnSize;
    }

    
    /**
     * ctrtcSnSize을 설정
     * @param ctrtcSnSize 을(를) String ctrtcSnSize로 설정
     */
    public void setCtrtcSnSize(String ctrtcSnSize) {
        this.ctrtcSnSize = ctrtcSnSize;
    }

    
    /**
     * String ctrtcSnTy을 반환
     * @return String ctrtcSnTy
     */
    public String getCtrtcSnTy() {
        return ctrtcSnTy;
    }

    
    /**
     * ctrtcSnTy을 설정
     * @param ctrtcSnTy 을(를) String ctrtcSnTy로 설정
     */
    public void setCtrtcSnTy(String ctrtcSnTy) {
        this.ctrtcSnTy = ctrtcSnTy;
    }

    
    /**
     * String myCtrtcYn을 반환
     * @return String myCtrtcYn
     */
    public String getMyCtrtcYn() {
        return myCtrtcYn;
    }

    
    /**
     * myCtrtcYn을 설정
     * @param myCtrtcYn 을(를) String myCtrtcYn로 설정
     */
    public void setMyCtrtcYn(String myCtrtcYn) {
        this.myCtrtcYn = myCtrtcYn;
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
     * Integer userTyCd을 반환
     * @return Integer userTyCd
     */
    public Integer getUserTyCd() {
        return userTyCd;
    }







    /**
     * userTyCd을 설정
     * @param userTyCd 을(를) Integer userTyCd로 설정
     */
    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }

    
}
