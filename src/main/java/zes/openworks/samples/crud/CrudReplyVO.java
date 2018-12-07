/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.samples.crud;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.MinLength;
import zes.core.lang.validate.annotation.marker.Required;

/**
 * 답글 셈플 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 6.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class CrudReplyVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = -578641027619567506L;

    /** 참조번호 */
    private Integer seq;
    /** 답변번호 */
    private Integer replySeq;
    /** 답변내용 */
    @Required
    @MinLength(min = 10)
    private String replyContents;
    /** 답변이력 */
    private String replyContentsHistory;
    /** 답변자ID */
    private String replyId;
    /** 답변자명 */
    private String replyNm;
    /** 답변일시 */
    private String replyDt;
    /** 파일순번 */
    private Integer fileSeq;
    /** IP주소 */
    private String ipAddr;
    /** 등록자ID */
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록자비밀번호 */
    @Required
    private String regPwd;
    /** 등록일시 */
    private String regDt;
    /** 수정자ID */
    private String modId;
    /** 수정자명 */
    private String modiNm;
    /** 수정일시 */
    private String modiDt;

    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 첨부파일 ID 목록 (수정시 삭제된 파일 정보) */
    private String[] fileIds;
    /** 첨부파일 갯수 */
    private Integer fileCnt;

    /**
     * Integer seq을 반환
     * 
     * @return Integer seq
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * seq을 설정
     * 
     * @param refSeq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * Integer replySeq을 반환
     * 
     * @return Integer replySeq
     */
    public Integer getReplySeq() {
        return replySeq;
    }

    /**
     * replySeq을 설정
     * 
     * @param replySeq 을(를) Integer replySeq로 설정
     */
    public void setReplySeq(Integer replySeq) {
        this.replySeq = replySeq;
    }

    /**
     * String replyContents을 반환
     * 
     * @return String replyContents
     */
    public String getReplyContents() {
        return replyContents;
    }

    /**
     * replyContents을 설정
     * 
     * @param replyContents 을(를) String replyContents로 설정
     */
    public void setReplyContents(String replyContents) {
        this.replyContents = replyContents;
    }

    /**
     * String replyContentsHistory을 반환
     * 
     * @return String replyContentsHistory
     */
    public String getReplyContentsHistory() {
        return replyContentsHistory;
    }

    /**
     * replyContentsHistory을 설정
     * 
     * @param replyContentsHistory 을(를) String replyContentsHistory로 설정
     */
    public void setReplyContentsHistory(String replyContentsHistory) {
        this.replyContentsHistory = replyContentsHistory;
    }

    /**
     * String replyId을 반환
     * 
     * @return String replyId
     */
    public String getReplyId() {
        return replyId;
    }

    /**
     * replyId을 설정
     * 
     * @param replyId 을(를) String replyId로 설정
     */
    public void setReplyId(String replyId) {
        this.replyId = replyId;
    }

    /**
     * String replyNm을 반환
     * 
     * @return String replyNm
     */
    public String getReplyNm() {
        return replyNm;
    }

    /**
     * replyNm을 설정
     * 
     * @param replyNm 을(를) String replyNm로 설정
     */
    public void setReplyNm(String replyNm) {
        this.replyNm = replyNm;
    }

    /**
     * String replyDt을 반환
     * 
     * @return String replyDt
     */
    public String getReplyDt() {
        return replyDt;
    }

    /**
     * replyDt을 설정
     * 
     * @param replyDt 을(를) String replyDt로 설정
     */
    public void setReplyDt(String replyDt) {
        this.replyDt = replyDt;
    }

    /**
     * Integer fileSeq을 반환
     * 
     * @return Integer fileSeq
     */
    public Integer getFileSeq() {
        return fileSeq;
    }

    /**
     * fileSeq을 설정
     * 
     * @param fileSeq 을(를) Integer fileSeq로 설정
     */
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    /**
     * String ipAddr을 반환
     * 
     * @return String ipAddr
     */
    public String getIpAddr() {
        return ipAddr;
    }

    /**
     * ipAddr을 설정
     * 
     * @param ipAddr 을(를) String ipAddr로 설정
     */
    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }

    /**
     * String regId을 반환
     * 
     * @return String regId
     */
    public String getRegId() {
        return regId;
    }

    /**
     * regId을 설정
     * 
     * @param regId 을(를) String regId로 설정
     */
    public void setRegId(String regId) {
        this.regId = regId;
    }

    /**
     * String regNm을 반환
     * 
     * @return String regNm
     */
    public String getRegNm() {
        return regNm;
    }

    /**
     * regNm을 설정
     * 
     * @param regNm 을(를) String regNm로 설정
     */
    public void setRegNm(String regNm) {
        this.regNm = regNm;
    }

    /**
     * String regPwd을 반환
     * 
     * @return String regPwd
     */
    public String getRegPwd() {
        return regPwd;
    }

    /**
     * regPwd을 설정
     * 
     * @param regPwd 을(를) String regPwd로 설정
     */
    public void setRegPwd(String regPwd) {
        this.regPwd = regPwd;
    }

    /**
     * String regDt을 반환
     * 
     * @return String regDt
     */
    public String getRegDt() {
        return regDt;
    }

    /**
     * regDt을 설정
     * 
     * @param regDt 을(를) String regDt로 설정
     */
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    /**
     * String modId을 반환
     * 
     * @return String modId
     */
    public String getModId() {
        return modId;
    }

    /**
     * modId을 설정
     * 
     * @param modId 을(를) String modId로 설정
     */
    public void setModId(String modId) {
        this.modId = modId;
    }

    /**
     * String modiNm을 반환
     * 
     * @return String modiNm
     */
    public String getModiNm() {
        return modiNm;
    }

    /**
     * modiNm을 설정
     * 
     * @param modiNm 을(를) String modiNm로 설정
     */
    public void setModiNm(String modiNm) {
        this.modiNm = modiNm;
    }

    /**
     * String modiDt을 반환
     * 
     * @return String modiDt
     */
    public String getModiDt() {
        return modiDt;
    }

    /**
     * modiDt을 설정
     * 
     * @param modiDt 을(를) String modiDt로 설정
     */
    public void setModiDt(String modiDt) {
        this.modiDt = modiDt;
    }

    /**
     * List<FileVO> fileList을 반환
     * 
     * @return List<FileVO> fileList
     */
    public List<FileVO> getFileList() {
        return fileList;
    }

    /**
     * fileList을 설정
     * 
     * @param fileList 을(를) List<FileVO> fileList로 설정
     */
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    /**
     * String[] fileIds을 반환
     * 
     * @return String[] fileIds
     */
    public String[] getFileIds() {
        return fileIds;
    }

    /**
     * fileIds을 설정
     * 
     * @param fileIds 을(를) String[] fileIds로 설정
     */
    public void setFileIds(String[] fileIds) {
        this.fileIds = fileIds;
    }

    /**
     * Integer fileCnt을 반환
     * 
     * @return Integer fileCnt
     */
    public Integer getFileCnt() {
        return fileCnt;
    }

    /**
     * fileCnt을 설정
     * 
     * @param fileCnt 을(를) Integer fileCnt로 설정
     */
    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }

}
