/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.markMgmt;

import java.util.List;

import zes.base.vo.BaseVO;
import zes.base.vo.FileVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       수정자   수정내용
 *--------------  --------  -------------------------------
 * 2014. 11. 24.    김영상       신규
 *</pre>
 * @see
 */
public class MarkVO extends BaseVO {

    private static final long serialVersionUID = -4297486580763642589L;
    
    /** 마크 코드 */
    private Integer markCd; //groupCd:1011
    /** 마크명 */
    private String markNm;
    /** 파일일련 */
    private Integer markImageFileSeq = -1;
    /** 연계기관 코드 */
    private Integer cntcInsttCd; //groupCd:201
    /** 연계서비스명 */
    private String cntcGoodsNm;
    /** 연계서비스이미지파일일련 */
    private Integer cntcGoodsImageSeq = -1;
    /** 등록아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 등록수정구분 */
    private String sepp;
    /** 수정아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    
    /** 최대 업로드 파일수 */
    private Integer maxFileCnt = 1;
    /** 파일 최대 사이즈 */
    private Integer maxFileSize = 1;
    /** 전체 업로드 사이즈 */
    private Integer totalFileSize = 1;
    /** 첨부파일 허용 확장자 (',' 구분자) */
    private String fileExts = ".jpg,.jpeg,.gif,.png";
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 첨부파일 수 */
    private Integer fileCnt = 0;

    /**
     * Integer markCd을 반환
     * @return Integer markCd
     */
    public Integer getMarkCd() {
        return markCd;
    }
    
    /**
     * markCd을 설정
     * @param markCd 을(를) Integer markCd로 설정
     */
    public void setMarkCd(Integer markCd) {
        this.markCd = markCd;
    }
    
    /**
     * String markNm을 반환
     * @return String markNm
     */
    public String getMarkNm() {
        return markNm;
    }
    
    /**
     * markNm을 설정
     * @param markNm 을(를) String markNm로 설정
     */
    public void setMarkNm(String markNm) {
        this.markNm = markNm;
    }
    
    /**
     * Integer markImageFileSeq을 반환
     * @return Integer markImageFileSeq
     */
    public Integer getMarkImageFileSeq() {
        return markImageFileSeq;
    }
    
    /**
     * markImageFileSeq을 설정
     * @param markImageFileSeq 을(를) Integer markImageFileSeq로 설정
     */
    public void setMarkImageFileSeq(Integer markImageFileSeq) {
        this.markImageFileSeq = markImageFileSeq;
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
     * Integer cntcInsttCd을 반환
     * @return Integer cntcInsttCd
     */
    public Integer getCntcInsttCd() {
        return cntcInsttCd;
    }

    /**
     * cntcInsttCd을 설정
     * @param cntcInsttCd 을(를) Integer cntcInsttCd로 설정
     */
    public void setCntcInsttCd(Integer cntcInsttCd) {
        this.cntcInsttCd = cntcInsttCd;
    }

    /**
     * String cntcGoodsNm을 반환
     * @return String cntcGoodsNm
     */
    public String getCntcGoodsNm() {
        return cntcGoodsNm;
    }

    /**
     * cntcGoodsNm을 설정
     * @param cntcGoodsNm 을(를) String cntcGoodsNm로 설정
     */
    public void setCntcGoodsNm(String cntcGoodsNm) {
        this.cntcGoodsNm = cntcGoodsNm;
    }

    /**
     * Integer cntcGoodsImageSeq을 반환
     * @return Integer cntcGoodsImageSeq
     */
    public Integer getCntcGoodsImageSeq() {
        return cntcGoodsImageSeq;
    }

    /**
     * cntcGoodsImageSeq을 설정
     * @param cntcGoodsImageSeq 을(를) Integer cntcGoodsImageSeq로 설정
     */
    public void setCntcGoodsImageSeq(Integer cntcGoodsImageSeq) {
        this.cntcGoodsImageSeq = cntcGoodsImageSeq;
    }

    /**
     * Integer maxFileCnt을 반환
     * @return Integer maxFileCnt
     */
    public Integer getMaxFileCnt() {
        return maxFileCnt;
    }

    /**
     * maxFileCnt을 설정
     * @param maxFileCnt 을(를) Integer maxFileCnt로 설정
     */
    public void setMaxFileCnt(Integer maxFileCnt) {
        this.maxFileCnt = maxFileCnt;
    }

    /**
     * String sepp을 반환
     * @return String sepp
     */
    public String getSepp() {
        return sepp;
    }

    /**
     * sepp을 설정
     * @param sepp 을(를) String sepp로 설정
     */
    public void setSepp(String sepp) {
        this.sepp = sepp;
    }

    /**
     * Integer maxFileSize을 반환
     * @return Integer maxFileSize
     */
    public Integer getMaxFileSize() {
        return maxFileSize;
    }

    /**
     * maxFileSize을 설정
     * @param maxFileSize 을(를) Integer maxFileSize로 설정
     */
    public void setMaxFileSize(Integer maxFileSize) {
        this.maxFileSize = maxFileSize;
    }

    /**
     * Integer totalFileSize을 반환
     * @return Integer totalFileSize
     */
    public Integer getTotalFileSize() {
        return totalFileSize;
    }

    /**
     * totalFileSize을 설정
     * @param totalFileSize 을(를) Integer totalFileSize로 설정
     */
    public void setTotalFileSize(Integer totalFileSize) {
        this.totalFileSize = totalFileSize;
    }

    /**
     * String fileExts을 반환
     * @return String fileExts
     */
    public String getFileExts() {
        return fileExts;
    }

    /**
     * fileExts을 설정
     * @param fileExts 을(를) String fileExts로 설정
     */
    public void setFileExts(String fileExts) {
        this.fileExts = fileExts;
    }

    /**
     * List<FileVO> fileList을 반환
     * @return List<FileVO> fileList
     */
    public List<FileVO> getFileList() {
        return fileList;
    }

    /**
     * fileList을 설정
     * @param fileList 을(를) List<FileVO> fileList로 설정
     */
    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    /**
     * Integer fileCnt을 반환
     * @return Integer fileCnt
     */
    public Integer getFileCnt() {
        return fileCnt;
    }

    /**
     * fileCnt을 설정
     * @param fileCnt 을(를) Integer fileCnt로 설정
     */
    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }
    
}
