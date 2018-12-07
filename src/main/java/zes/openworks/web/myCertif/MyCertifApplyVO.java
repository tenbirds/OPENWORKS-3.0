/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.web.myCertif;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

/**
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2017. 11. 24.    SKYOU      신규
 * </pre> rou_issu_apply_i (이용실적증명서발급신청)
 * @see
 */
public class MyCertifApplyVO extends PaggingVO {
    
    static final long serialVersionUID = 7054332550855622442L;
    
    private int rouSn;                  //이용실적발급일련번호
    private String userId;              //사용자아이디
    private String issuResn;            //발급사유
    private String issuMth;             //발급방법(E:이메일, Z:우편발송)
    private String issuMthNm;           //발급방법(E:이메일, Z:우편발송)
    private String email;               //이메일
    private String zip;                 //우편번호
    private String bassAdres;           //기본주소
    private String detailAdres;         //상세주소
    private String issuSttus;           //발급상태(GROUP_CD:2045, 1001: 실적증명요청, 1002: 반려, 1003: 발급완료)
    private String issuSttusNm;         //발급상태 이름
    private String registId;            //등록아이디
    private String registDt;            //등록일
    private String updtId;              //수정아이디
    private String updtDt;              //수정자ID
    int fileSeq =-1;                    //파일일련번호
    private String sndngDe;             //발송일
    private String rouIssuNo;            //발급번호
    private String buseoCode;           //기관코드
    private Integer userTyCd;           //회원유형 코드
    
    private String[] cntrctSvcSns;
   
    /**
     * int rouSn을 반환
     * @return int rouSn
     */
    public int getRouSn() {
        return rouSn;
    }
    
    /**
     * rouSn을 설정
     * @param rouSn 을(를) int rouSn로 설정
     */
    public void setRouSn(int rouSn) {
        this.rouSn = rouSn;
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
     * String issuResn을 반환
     * @return String issuResn
     */
    public String getIssuResn() {
        return issuResn;
    }
    
    /**
     * issuResn을 설정
     * @param issuResn 을(를) String issuResn로 설정
     */
    public void setIssuResn(String issuResn) {
        this.issuResn = issuResn;
    }
    
    /**
     * String issuMth을 반환
     * @return String issuMth
     */
    public String getIssuMth() {
        return issuMth;
    }
    
    /**
     * issuMth을 설정
     * @param issuMth 을(를) String issuMth로 설정
     */
    public void setIssuMth(String issuMth) {
        this.issuMth = issuMth;
    }
    
    
    /**
     * String issuMthNm을 반환
     * @return String issuMthNm
     */
    public String getIssuMthNm() {
        return issuMthNm;
    }

    
    /**
     * issuMthNm을 설정
     * @param issuMthNm 을(를) String issuMthNm로 설정
     */
    public void setIssuMthNm(String issuMthNm) {
        this.issuMthNm = issuMthNm;
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
     * String zip을 반환
     * @return String zip
     */
    public String getZip() {
        return zip;
    }
    
    /**
     * zip을 설정
     * @param zip 을(를) String zip로 설정
     */
    public void setZip(String zip) {
        this.zip = zip;
    }
    
    /**
     * String bassAdres을 반환
     * @return String bassAdres
     */
    public String getBassAdres() {
        return bassAdres;
    }
    
    /**
     * bassAdres을 설정
     * @param bassAdres 을(를) String bassAdres로 설정
     */
    public void setBassAdres(String bassAdres) {
        this.bassAdres = bassAdres;
    }
    
    /**
     * String detailAdres을 반환
     * @return String detailAdres
     */
    public String getDetailAdres() {
        return detailAdres;
    }
    
    /**
     * detailAdres을 설정
     * @param detailAdres 을(를) String detailAdres로 설정
     */
    public void setDetailAdres(String detailAdres) {
        this.detailAdres = detailAdres;
    }
    
    /**
     * String issuSttus을 반환
     * @return String issuSttus
     */
    public String getIssuSttus() {
        return issuSttus;
    }
    
    /**
     * issuSttus을 설정
     * @param issuSttus 을(를) String issuSttus로 설정
     */
    public void setIssuSttus(String issuSttus) {
        this.issuSttus = issuSttus;
    }
    
    
    /**
     * String issuSttusNm을 반환
     * @return String issuSttusNm
     */
    public String getIssuSttusNm() {
        return issuSttusNm;
    }

    
    /**
     * issuSttusNm을 설정
     * @param issuSttusNm 을(를) String issuSttusNm로 설정
     */
    public void setIssuSttusNm(String issuSttusNm) {
        this.issuSttusNm = issuSttusNm;
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
     * int fileSeq을 반환
     * @return int fileSeq
     */
    public int getFileSeq() {
        return fileSeq;
    }
    
    /**
     * fileSeq을 설정
     * @param fileSeq 을(를) int fileSeq로 설정
     */
    public void setFileSeq(int fileSeq) {
        this.fileSeq = fileSeq;
    }
    
    /**
     * String sndngDe을 반환
     * @return String sndngDe
     */
    public String getSndngDe() {
        return sndngDe;
    }
    
    /**
     * sndngDe을 설정
     * @param sndngDe 을(를) String sndngDe로 설정
     */
    public void setSndngDe(String sndngDe) {
        this.sndngDe = sndngDe;
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
     * String rouIssuNo을 반환
     * @return String rouIssuNo
     */
    public String getRouIssuNo() {
        return rouIssuNo;
    }

    
    /**
     * rouIssuNo을 설정
     * @param rouIssuNo 을(를) String rouIssuNo로 설정
     */
    public void setRouIssuNo(String rouIssuNo) {
        this.rouIssuNo = rouIssuNo;
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
