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
import zes.core.lang.validate.annotation.marker.AlphaNumeric;
import zes.core.lang.validate.annotation.marker.MaxLength;
import zes.core.lang.validate.annotation.marker.MinLength;
import zes.core.lang.validate.annotation.marker.NotNull;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.RequireFrom;
import zes.core.lang.validate.annotation.marker.Required;
import zes.core.lang.validate.annotation.marker.Size;

/**
 * 셈플 VO 객체
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
public class CrudVO extends PaggingVO {

    /** serialVersionUID */
    private static final long serialVersionUID = 2002441908273848060L;

    /** 일련번호 */
    private Integer seq;
    /** 일련번호목록 */
    private Integer[] seqs;
    /** 참조번호 */
    private Integer refSeq;
    /** 댓글순서 */
    private Integer orderNo;
    /** 댓글레벨 */
    private Integer depth;
    /** 제목 */
    @Required(message = "제목은 필수 입력입니다.")
    @MinLength(min = 3)
    @MaxLength(max = 300)
    private String title;
    /** 분류코드 */
    @Required(message = "분류를 선택하세요.")
    private String ctgCd;
    /** 공지여부 */
    @RequireFrom(fieldName = "openYn", fieldValue = "Y", fieldDesc = "공개여부 공개")
    private String noticeYn;
    /** 내용 */
    @Required(message = "내용은 필수 입력입니다.")
    @MinLength(min = 10)
    private String contents;
    /** 파일순번 */
    private Integer fileSeq;
    /** 조회수 */
    private Integer readCnt;
    /** 접속IP */
    private String ipAddr;
    /** 공개여부 */
    @NotNull
    @Size(min = 1, max = 1, message = "{0}~{1}개 선택(여러개 선택해야 할 경우 셈플)")
    private String openYn;
    /** 답변여부 */
    private String replyYn;
    /** 등록자ID */
    @AlphaNumeric
    private String regId;
    /** 등록자명 */
    private String regNm;
    /** 등록자비밀번호 */
    @Required(message = "비번")
    @RangeLength(min = 3, max = 20)
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

    /** 댓글 갯수 */
    private Integer commCnt;

    /** 이전글 */
    private CrudVO prevVo;
    /** 다음글 */
    private CrudVO nextVo;

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
     * @param seq 을(를) Integer seq로 설정
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * Integer[] seqs을 반환
     * 
     * @return Integer[] seqs
     */
    public Integer[] getSeqs() {
        return seqs;
    }

    /**
     * seqs을 설정
     * 
     * @param seqs 을(를) Integer[] seqs로 설정
     */
    public void setSeqs(Integer[] seqs) {
        this.seqs = seqs;
    }

    /**
     * Integer refSeq을 반환
     * 
     * @return Integer refSeq
     */
    public Integer getRefSeq() {
        return refSeq;
    }

    /**
     * Integer 설정
     * 
     * @param refSeq 을(를) Integer refSeq로 설정
     */
    public void setRefSeq(Integer refSeq) {
        this.refSeq = refSeq;
    }

    /**
     * Integer orderNo을 반환
     * 
     * @return Integer orderNo
     */
    public Integer getOrderNo() {
        return orderNo;
    }

    /**
     * orderNo을 설정
     * 
     * @param orderNo 을(를) Integer orderNo로 설정
     */
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    /**
     * Integer depth을 반환
     * 
     * @return Integer depth
     */
    public Integer getDepth() {
        return depth;
    }

    /**
     * depth을 설정
     * 
     * @param depth 을(를) Integer depth로 설정
     */
    public void setDepth(Integer depth) {
        this.depth = depth;
    }

    /**
     * String ctgCd을 반환
     * 
     * @return Integer ctgCd
     */
    public String getCtgCd() {
        return ctgCd;
    }

    /**
     * ctgCd을 설정
     * 
     * @param ctgCd 을(를) String ctgCd로 설정
     */
    public void setCtgCd(String ctgCd) {
        this.ctgCd = ctgCd;
    }

    /**
     * String noticeYn을 반환
     * 
     * @return String noticeYn
     */
    public String getNoticeYn() {
        return noticeYn;
    }

    /**
     * noticeYn을 설정
     * 
     * @param noticeYn 을(를) String noticeYn로 설정
     */
    public void setNoticeYn(String noticeYn) {
        this.noticeYn = noticeYn;
    }

    /**
     * String title을 반환
     * 
     * @return String title
     */
    public String getTitle() {
        return title;
    }

    /**
     * title을 설정
     * 
     * @param title 을(를) String title로 설정
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * String contents을 반환
     * 
     * @return String contents
     */
    public String getContents() {
        return contents;
    }

    /**
     * contents을 설정
     * 
     * @param contents 을(를) String contents로 설정
     */
    public void setContents(String contents) {
        this.contents = contents;
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
     * Integer readCnt을 반환
     * 
     * @return Integer readCnt
     */
    public Integer getReadCnt() {
        return readCnt;
    }

    /**
     * readCnt을 설정
     * 
     * @param readCnt 을(를) Integer readCnt로 설정
     */
    public void setReadCnt(Integer readCnt) {
        this.readCnt = readCnt;
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
     * String openYn을 반환
     * 
     * @return String openYn
     */
    public String getOpenYn() {
        return openYn;
    }

    /**
     * openYn을 설정
     * 
     * @param openYn 을(를) String openYn로 설정
     */
    public void setOpenYn(String openYn) {
        this.openYn = openYn;
    }

    /**
     * String replyYn을 반환
     * 
     * @return String replyYn
     */
    public String getReplyYn() {
        return replyYn;
    }

    /**
     * replyYn을 설정
     * 
     * @param replyYn 을(를) String replyYn로 설정
     */
    public void setReplyYn(String replyYn) {
        this.replyYn = replyYn;
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
     * List<BaseFileVO> fileList을 반환
     * 
     * @return List<BaseFileVO> fileList
     */
    public List<FileVO> getFileList() {
        return fileList;
    }

    /**
     * fileList을 설정
     * 
     * @param fileList 을(를) List<BaseFileVO> fileList로 설정
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

    /**
     * Integer commCnt을 반환
     * 
     * @return Integer commCnt
     */
    public Integer getCommCnt() {
        return commCnt;
    }

    /**
     * commCnt을 설정
     * 
     * @param commCnt 을(를) Integer commCnt로 설정
     */
    public void setCommCnt(Integer commCnt) {
        this.commCnt = commCnt;
    }

    /**
     * CrudVO prevVo을 반환
     * 
     * @return CrudVO prevVo
     */
    public CrudVO getPrevVo() {
        return prevVo;
    }

    /**
     * prevVo을 설정
     * 
     * @param prevVo 을(를) CrudVO prevVo로 설정
     */
    public void setPrevVo(CrudVO prevVo) {
        this.prevVo = prevVo;
    }

    /**
     * CrudVO nextVo을 반환
     * 
     * @return CrudVO nextVo
     */
    public CrudVO getNextVo() {
        return nextVo;
    }

    /**
     * nextVo을 설정
     * 
     * @param nextVo 을(를) CrudVO nextVo로 설정
     */
    public void setNextVo(CrudVO nextVo) {
        this.nextVo = nextVo;
    }

}
