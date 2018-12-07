/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.suplerCeart.vo;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.Email;

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
public class SuplerCntrctVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 1L;

    /** 순서 */
    private int cntrctSn;
    
    /** 공급자ID */
    private String suplerId;
    
    /** 공급자명 */
    private String suplerNm;
    
    /** 공급자명 */
    private String userNm;
    
    /** 공급자회사 */
    private String cmpnyNm;

    /** 수요자ID */
    private String commUserId;

    /** 수요자명 */
    private String commUserNm;
    
    /** 사업명 */
    private String svcNm;
    
    /** 계약시작일자 */
    private String cntrctBeginDe;
    
    /** 계약종료일자 */
    private String cntrctEndDe;
    
    /** 금액 */
    private Long cntrctamount;
    
    /** 구매기관 */
    private String purchsInsttNm;
    
    /** 판매기관 */
    private String sleInsttNm;
    
    /** 계약서 SEQ */
    private int ctrtcSn = -1;
    
    /** 계약서-첨부파일목록 */
    private List<FileVO> ctrtcSnList;

    /** 계약서 실 파일명 */
    private String ctrtcSnOrgNm;

    /** 계약서 파일ID(OP_FILE테이블 참조) */
    private String ctrtcSnId;
    
    /** 계약서 파일 Size */
    private String ctrtcSnSize;
    
    /** 계약서 파일 Type */
    private String ctrtcSnTy;

    /** 등록자ID */
    private String registId;
    
    /** 등록일자 */
    private String registDt;
    
    /** 수정자ID */
    private String updtId;
    
    /** 수정일자 */
    private String updtDt;
    
    /** 삭제여부 */
    private String deleteAt;
    
    /** 공고번호 */
    private String notifyNum;
    
    /** 공고차수 */
    private int notifySeq;

    /** 서비스코드 */
    private String goodsCode;
    
    /** 서비스명 */
    private String goodsNm;
    
    /** 계약번호 */
    private String cntrNum;
    
    /** 공급형태 */
    private String splyForm;
    
    /** 공급형태명 */
    private String splyFormNm;
    
    /** 공급형태-기타 */
    private String splyFormEtc;
    
    /** 계약일자 */
    private String cntrDt;
    
    /** 계약건수 */
    private int cntrCount;
    
    /** 견적요청의 기관/기업명 */
    private String realDmndOrgn;

    /** 입찰종류여부(2037) */
    private String bidGbnCd;

    /** 거래계약서 발행상태 코드 */
    private String certResultCode;
    
    /** 수의계약 수기입력 코드**/
    private int registMthdCode;
    
    /*비회원자 정보 등록*/
    private int userSn;
    private String orgnCode; //기관코드
    private String buseoCode; // 부서코드
    private String orgnNm ;
    private String buseoNm ;
    private String tempUserNm;
    
    private String userSe;
    private String sportAt;
    private String[] buseoCodes; // 부서코드
    private String[] realBuseoCodes; // 부서코드
    private String realOrgNm;       //실이용기관명(한개만 추출)
    private String realCmpny;       //실이용기관명(한개만 추출)
    private int realBuesoCnt;       ////실이용기관수
    
    @Email
    private String email;   /** 이메일 */
    private Integer sbscrbTyCd;  /** 가입유형 */
    private String mbtlnum;  /** 휴대폰번호 */

    private String rlCntrctInsttAt;  /*계약기관과 동일하지 않음 체크여부*/

    private String[] cntrctSvcSns;
    private String[] goodsCodes;
    private String[] splyForms; 
    private String[] splyFormEtcs ; 
    private String[] cntrctCounts; 
    private String[] cntrctAmounts;
    
    /**
     * int registMthdCode을 반환
     * @return String registMthdCode
     */
    public int getRegistMthdCode() {
        return registMthdCode;
    }


    
    /**
     * registMthdCode을 설정
     * @param registMthdCode 을(를) String registMthdCode로 설정
     */
    public void setRegistMthdCode(int registMthdCode) {
        this.registMthdCode = registMthdCode;
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

    
    /**
     * String commUserNm을 반환
     * @return String commUserNm
     */
    public String getCommUserNm() {
        return commUserNm;
    }

    
    /**
     * commUserNm을 설정
     * @param commUserNm 을(를) String commUserNm로 설정
     */
    public void setCommUserNm(String commUserNm) {
        this.commUserNm = commUserNm;
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
    public Long getCntrctamount() {
        return cntrctamount;
    }

    
    /**
     * cntrctamount을 설정
     * @param cntrctamount 을(를) int cntrctamount로 설정
     */
    public void setCntrctamount(Long cntrctamount) {
        this.cntrctamount = cntrctamount;
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
     * List<FileVO> ctrtcSnList을 반환
     * @return List<FileVO> ctrtcSnList
     */
    public List<FileVO> getCtrtcSnList() {
        return ctrtcSnList;
    }

    
    /**
     * ctrtcSnList을 설정
     * @param ctrtcSnList 을(를) List<FileVO> ctrtcSnList로 설정
     */
    public void setCtrtcSnList(List<FileVO> ctrtcSnList) {
        this.ctrtcSnList = ctrtcSnList;
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
     * String splyFormNm을 반환
     * @return String splyFormNm
     */
    public String getSplyFormNm() {
        return splyFormNm;
    }

    
    /**
     * splyFormNm을 설정
     * @param splyFormNm 을(를) String splyFormNm로 설정
     */
    public void setSplyFormNm(String splyFormNm) {
        this.splyFormNm = splyFormNm;
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
     * int cntrCount을 반환
     * @return int cntrCount
     */
    public int getCntrCount() {
        return cntrCount;
    }

    
    /**
     * cntrCount을 설정
     * @param cntrCount 을(를) int cntrCount로 설정
     */
    public void setCntrCount(int cntrCount) {
        this.cntrCount = cntrCount;
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
     * String certResultCode을 반환
     * @return String certResultCode
     */
    public String getCertResultCode() {
        return certResultCode;
    }

    
    /**
     * certResultCode을 설정
     * @param certResultCode 을(를) String certResultCode로 설정
     */
    public void setCertResultCode(String certResultCode) {
        this.certResultCode = certResultCode;
    }

    
    /**
     * int userSn을 반환
     * @return int userSn
     */
    public int getUserSn() {
        return userSn;
    }

    
    /**
     * userSn을 설정
     * @param userSn 을(를) int userSn로 설정
     */
    public void setUserSn(int userSn) {
        this.userSn = userSn;
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
     * String buseoNm을 반환
     * @return String buseoNm
     */
    public String getBuseoNm() {
        return buseoNm;
    }



    
    /**
     * buseoNm을 설정
     * @param buseoNm 을(를) String buseoNm로 설정
     */
    public void setBuseoNm(String buseoNm) {
        this.buseoNm = buseoNm;
    }



    
    /**
     * String tempUserNm을 반환
     * @return String tempUserNm
     */
    public String getTempUserNm() {
        return tempUserNm;
    }



    
    /**
     * tempUserNm을 설정
     * @param tempUserNm 을(를) String tempUserNm로 설정
     */
    public void setTempUserNm(String tempUserNm) {
        this.tempUserNm = tempUserNm;
    }



    /**
     * String email을 반환
     * @return String email
     */
    public String getEmail() {
        return email;
    }



    
    /**
     * email을 설정
     * @param email 을(를) String email로 설정
     */
    public void setEmail(String email) {
        this.email = email;
    }



    
    /**
     * Integer sbscrbTyCd을 반환
     * @return Integer sbscrbTyCd
     */
    public Integer getSbscrbTyCd() {
        return sbscrbTyCd;
    }



    
    /**
     * sbscrbTyCd을 설정
     * @param sbscrbTyCd 을(를) Integer sbscrbTyCd로 설정
     */
    public void setSbscrbTyCd(Integer sbscrbTyCd) {
        this.sbscrbTyCd = sbscrbTyCd;
    }



    
    /**
     * String mbtlnum을 반환
     * @return String mbtlnum
     */
    public String getMbtlnum() {
        return mbtlnum;
    }



    
    /**
     * mbtlnum을 설정
     * @param mbtlnum 을(를) String mbtlnum로 설정
     */
    public void setMbtlnum(String mbtlnum) {
        this.mbtlnum = mbtlnum;
    }



    
    /**
     * String rlCntrctInsttAt을 반환
     * @return String rlCntrctInsttAt
     */
    public String getRlCntrctInsttAt() {
        return rlCntrctInsttAt;
    }
    
    /**
     * rlCntrctInsttAt을 설정
     * @param rlCntrctInsttAt 을(를) String rlCntrctInsttAt로 설정
     */
    public void setRlCntrctInsttAt(String rlCntrctInsttAt) {
        this.rlCntrctInsttAt = rlCntrctInsttAt;
    }
 
    
    /**
     * String userSe을 반환
     * @return String userSe
     */
    public String getUserSe() {
        return userSe;
    }

    
    /**
     * userSe을 설정
     * @param userSe 을(를) String userSe로 설정
     */
    public void setUserSe(String userSe) {
        this.userSe = userSe;
    }
    
    /**
     * String sportAt을 반환
     * @return String sportAt
     */
    public String getSportAt() {
        return sportAt;
    }

    
    /**
     * sportAt을 설정
     * @param sportAt 을(를) String sportAt로 설정
     */
    public void setSportAt(String sportAt) {
        this.sportAt = sportAt;
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
     * String[] realBuseoCodes을 반환
     * @return String[] realBuseoCodes
     */
    public String[] getRealBuseoCodes() {
        return realBuseoCodes;
    }

    /**
     * realBuseoCodes을 설정
     * @param realBuseoCodes 을(를) String[] realBuseoCodes로 설정
     */
    public void setRealBuseoCodes(String[] realBuseoCodes) {
        this.realBuseoCodes = realBuseoCodes;
    }
    
    /**
     * String realOrgNm을 반환
     * @return String realOrgNm
     */
    public String getRealOrgNm() {
        return realOrgNm;
    }
    
    /**
     * realOrgNm을 설정
     * @param realOrgNm 을(를) String realOrgNm로 설정
     */
    public void setRealOrgNm(String realOrgNm) {
        this.realOrgNm = realOrgNm;
    }
    
    /**
     * String realCmpny을 반환
     * @return String realCmpny
     */
    public String getRealCmpny() {
        return realCmpny;
    }



    
    /**
     * realCmpny을 설정
     * @param realCmpny 을(를) String realCmpny로 설정
     */
    public void setRealCmpny(String realCmpny) {
        this.realCmpny = realCmpny;
    }



    /**
     * int realBuesoCnt을 반환
     * @return int realBuesoCnt
     */
    public int getRealBuesoCnt() {
        return realBuesoCnt;
    }

    /**
     * realBuesoCnt을 설정
     * @param realBuesoCnt 을(를) int realBuesoCnt로 설정
     */
    public void setRealBuesoCnt(int realBuesoCnt) {
        this.realBuesoCnt = realBuesoCnt;
    }

    /**
     * String[] cntrctSvcSns을 반환
     * @return String[] cntrctSvcSns
     */
    public String[] getCntrctSvcSns() {
        return cntrctSvcSns;
    }

    /**
     * cntrctSvcSns을 설정
     * @param cntrctSvcSns 을(를) String[] cntrctSvcSns로 설정
     */
    public void setCntrctSvcSns(String[] cntrctSvcSns) {
        this.cntrctSvcSns = cntrctSvcSns;
    }



    /**
     * String[] goodsCodes을 반환
     * @return String[] goodsCodes
     */
    public String[] getGoodsCodes() {
        return goodsCodes;
    }

    
    /**
     * goodsCodes을 설정
     * @param goodsCodes 을(를) String[] goodsCodes로 설정
     */
    public void setGoodsCodes(String[] goodsCodes) {
        this.goodsCodes = goodsCodes;
    }

    
    
    /**
     * String[] splyForms을 반환
     * @return String[] splyForms
     */
    public String[] getSplyForms() {
        return splyForms;
    }

    
    /**
     * splyForms을 설정
     * @param splyForms 을(를) String[] splyForms로 설정
     */
    public void setSplyForms(String[] splyForms) {
        this.splyForms = splyForms;
    }

    
    /**
     * String[] splyFormEtcs을 반환
     * @return String[] splyFormEtcs
     */
    public String[] getSplyFormEtcs() {
        return splyFormEtcs;
    }

    
    /**
     * splyFormEtcs을 설정
     * @param splyFormEtcs 을(를) String[] splyFormEtcs로 설정
     */
    public void setSplyFormEtcs(String[] splyFormEtcs) {
        this.splyFormEtcs = splyFormEtcs;
    }

    
    /**
     * String[] cntrctCounts을 반환
     * @return String[] cntrctCounts
     */
    public String[] getCntrctCounts() {
        return cntrctCounts;
    }

    
    /**
     * cntrctCounts을 설정
     * @param cntrctCounts 을(를) String[] cntrctCounts로 설정
     */
    public void setCntrctCounts(String[] cntrctCounts) {
        this.cntrctCounts = cntrctCounts;
    }

    
    /**
     * String[] cntrctAmounts을 반환
     * @return String[] cntrctAmounts
     */
    public String[] getCntrctAmounts() {
        return cntrctAmounts;
    }

    
    /**
     * cntrctAmounts을 설정
     * @param cntrctAmounts 을(를) String[] cntrctAmounts로 설정
     */
    public void setCntrctAmounts(String[] cntrctAmounts) {
        this.cntrctAmounts = cntrctAmounts;
    } 
   
    
    
 
    
}
