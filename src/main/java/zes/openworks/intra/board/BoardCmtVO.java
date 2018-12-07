/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.board;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

/**
 * 게시판 코멘트 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *  
 *   수정일			  수정자					수정내용
 * --------------  --------  ---------------------------------
 *  2012. 5. 14.	 손재숙	 JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardCmtVO extends PaggingVO {

    private static final long serialVersionUID = -1405393597849020323L;

    /** 도메인 코드 */
    private Integer domainCd = 0;
    /** 게시판 코드 */
    private int bbsCd;
    /** 게시판 일련번호 */
    private String bbscttSeq;
    /** 댓글 일련번호 */
    private String cmtSeq;
    /** 아이콘키 */
    private String iconKey;
    /** 코멘트 */
    private String nttCmtCn;
    /** IP주소 */
    private String ipAdres;
    /** 사용자 KEY */
    private String userKey;
    /** 등록비밀번호 */
    private String registPassword;
    /** 등로자명 */
    private String registerNm;
    /** 등록자 아이디 (mask)*/
    private String maskRegistId;
    /** 등록자 아이디 */
    private String registId;
    /** 등록일시 */
    private String registDt;
    /** 수정자 아이디 */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 수정자 명 */
    private String updtNm;
    /** 관리자 아이디 */
    private String mngrId;
    /** 관리자 이름 */
    private String mngrNm;
    /** 게시글평가점수 */
    private int bbscttEvlScore = 0; 
    /** 관리자삭제여부 */
    private String mngrDeleteAt; 

    /** 사용자ID */
    private String userId;
    /** 사용자명 */
    private String userNm;
    /** 사용자 닉네임 */
    private String nickNm;

    /** ---------- 2014. 10. 02 ---------- */
    /** -------- 댓글의 답글 추가 --------- */
    /** 댓글순서번호 */
    private Integer cmtOrdrNo;
    /** 참조댓글일련번호 */
    private String refrnCmtSeq;
    /** 댓글 깊이 */
    private Integer cmtDp;
    /** 사용자삭제여부 */
    private String userDeleteAt; 
    
    /** 비즈매칭회사명 */
    private String bizMatchingCmpnyNm; 
    /** 비즈매칭연락처 */
    private String bizMatchingCttpc; 
    /** 비즈매칭이메일 */
    private String bizMatchingEmail;
    /** MASK 비즈매칭이메일 */
    private String maskBizMatchingEmail;
    /** 비즈매칭공개여부 */
    private String bizMatchingOthbcAt ="N"; 
    /** 비즈매칭 선정댓글 seq */
    private String bizCmtSeq;
    /** 비즈매칭 선정여부 */
    private String estnColumn5;
    /** 비즈매칭 선정여부 */
    private String estnColumn6;
    /** 비즈매칭 상태 (미완료-INC(INCOMPLETION),완료-COM(COMPLETION),진행-PRO(PROGRESS) */
    private String bizProgression;

    /** 2015.09.15 */
    /** 파일일련번호 */
    private Integer fileSeq = -1;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 체크된 첨부파일 목록 (수정 시) */
    private String[] fileIds;
    /** 첨부파일 수 */
    private Integer fileCnt = 0;
    /** 첨부파일 수 */
    private Integer downCnt = 0;

    /**
     * bbsBean 객체 복사하기(검색에 필요한 필드만 복사한다.)
     */
    public BoardCmtVO copyCreateVO() {
        BoardCmtVO newBean = new BoardCmtVO();
        newBean.setDomainCd(this.getDomainCd());
        newBean.setBbsCd(this.getBbsCd());
        newBean.setBbscttSeq(this.getBbscttSeq());
        newBean.setCmtSeq(this.getCmtSeq());
        newBean.setRefrnCmtSeq(this.getRefrnCmtSeq());
        newBean.setCmtOrdrNo(this.getCmtOrdrNo());
        newBean.setCmtDp(this.getCmtDp());
        return newBean;
    }

    public Integer getDomainCd() {
        return domainCd;
    }

    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    public int getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(int bbsCd) {
        this.bbsCd = bbsCd;
    }

    public String getBbscttSeq() {
        return bbscttSeq;
    }

    public void setBbscttSeq(String bbscttSeq) {
        this.bbscttSeq = bbscttSeq;
    }

    public String getCmtSeq() {
        return cmtSeq;
    }

    public void setCmtSeq(String cmtSeq) {
        this.cmtSeq = cmtSeq;
    }

    public String getIconKey() {
        return iconKey;
    }

    public void setIconKey(String iconKey) {
        this.iconKey = iconKey;
    }

    
    public String getNttCmtCn() {
        return nttCmtCn;
    }

    
    public void setNttCmtCn(String nttCmtCn) {
        this.nttCmtCn = nttCmtCn;
    }

    
    public String getIpAdres() {
        return ipAdres;
    }

    
    public void setIpAdres(String ipAdres) {
        this.ipAdres = ipAdres;
    }

    
    public String getUserKey() {
        return userKey;
    }

    
    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    
    public String getRegistPassword() {
        return registPassword;
    }

    
    public void setRegistPassword(String registPassword) {
        this.registPassword = registPassword;
    }

    
    public String getRegisterNm() {
        return registerNm;
    }

    
    public void setRegisterNm(String registerNm) {
        this.registerNm = registerNm;
    }

    
    public String getMaskRegistId() {
        
        int registIdSize = this.getRegistId().length();
        String registIdTemp = this.getRegistId().substring(0, 3);
        String registMask = "";
        
        for(int i=0; i<registIdSize-3; i++){
            registMask += "*";
        }
        
        maskRegistId = registIdTemp + registMask; 

        return maskRegistId;
    }

    
    public void setMaskRegistId(String maskRegistId) {
        this.maskRegistId = maskRegistId;
    }

    
    public String getRegistId() {
        return registId;
    }

    
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    
    public String getRegistDt() {
        return registDt;
    }

    
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    
    public String getUpdtId() {
        return updtId;
    }

    
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    
    public String getUpdtDt() {
        return updtDt;
    }

    
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    
    public String getUpdtNm() {
        return updtNm;
    }

    
    public void setUpdtNm(String updtNm) {
        this.updtNm = updtNm;
    }

    
    public String getMngrId() {
        return mngrId;
    }

    
    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    
    public String getMngrNm() {
        return mngrNm;
    }

    
    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    
    public int getBbscttEvlScore() {
        return bbscttEvlScore;
    }

    
    public void setBbscttEvlScore(int bbscttEvlScore) {
        this.bbscttEvlScore = bbscttEvlScore;
    }

    
    public String getMngrDeleteAt() {
        return mngrDeleteAt;
    }

    
    public void setMngrDeleteAt(String mngrDeleteAt) {
        this.mngrDeleteAt = mngrDeleteAt;
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

    
    public String getNickNm() {
        return nickNm;
    }

    
    public void setNickNm(String nickNm) {
        this.nickNm = nickNm;
    }

    
    public Integer getCmtOrdrNo() {
        return cmtOrdrNo;
    }

    
    public void setCmtOrdrNo(Integer cmtOrdrNo) {
        this.cmtOrdrNo = cmtOrdrNo;
    }

    
    public String getRefrnCmtSeq() {
        return refrnCmtSeq;
    }

    
    public void setRefrnCmtSeq(String refrnCmtSeq) {
        this.refrnCmtSeq = refrnCmtSeq;
    }

    
    public Integer getCmtDp() {
        return cmtDp;
    }

    
    public void setCmtDp(Integer cmtDp) {
        this.cmtDp = cmtDp;
    }

    
    public String getUserDeleteAt() {
        return userDeleteAt;
    }

    
    public void setUserDeleteAt(String userDeleteAt) {
        this.userDeleteAt = userDeleteAt;
    }

    
    public String getBizMatchingCmpnyNm() {
        return bizMatchingCmpnyNm;
    }

    
    public void setBizMatchingCmpnyNm(String bizMatchingCmpnyNm) {
        this.bizMatchingCmpnyNm = bizMatchingCmpnyNm;
    }

    
    public String getBizMatchingCttpc() {
        return bizMatchingCttpc;
    }

    
    public void setBizMatchingCttpc(String bizMatchingCttpc) {
        this.bizMatchingCttpc = bizMatchingCttpc;
    }

    
    public String getBizMatchingEmail() {
        return bizMatchingEmail;
    }

    
    public void setBizMatchingEmail(String bizMatchingEmail) {
        this.bizMatchingEmail = bizMatchingEmail;
    }

    
    
    public String getMaskBizMatchingEmail() {
        
        if(this.getBizMatchingEmail() != null && this.getBizMatchingEmail() != ""){
            String bizMatchingEmailSplit[] = this.getBizMatchingEmail().split("@");
            int bizMatchingEmailSize = bizMatchingEmailSplit[0].length();
            String bizMatchingEmailTemp = bizMatchingEmailSplit[0].substring(0, 3);
            String bizMatchingEmailMask = "";
            
            for(int i=0; i<bizMatchingEmailSize-4; i++){
                bizMatchingEmailMask += "*";
            }
            
            maskBizMatchingEmail = bizMatchingEmailTemp + bizMatchingEmailMask+"@"+bizMatchingEmailSplit[1];
            
        }        
        
        return maskBizMatchingEmail;
    }

    
    public void setMaskBizMatchingEmail(String maskBizMatchingEmail) {
        this.maskBizMatchingEmail = maskBizMatchingEmail;
    }

    public String getBizMatchingOthbcAt() {
        return bizMatchingOthbcAt;
    }

    
    public void setBizMatchingOthbcAt(String bizMatchingOthbcAt) {
        this.bizMatchingOthbcAt = bizMatchingOthbcAt;
    }

    
    public String getBizCmtSeq() {
        return bizCmtSeq;
    }

    
    public void setBizCmtSeq(String bizCmtSeq) {
        this.bizCmtSeq = bizCmtSeq;
    }

    
    public String getEstnColumn5() {
        return estnColumn5;
    }

    
    public void setEstnColumn5(String estnColumn5) {
        this.estnColumn5 = estnColumn5;
    }

    
    public String getEstnColumn6() {
        return estnColumn6;
    }

    
    public void setEstnColumn6(String estnColumn6) {
        this.estnColumn6 = estnColumn6;
    }

    
    public String getBizProgression() {
        return bizProgression;
    }

    
    public void setBizProgression(String bizProgression) {
        this.bizProgression = bizProgression;
    }

    /** 2015.09.15. Start LeeChangHwan */
    public Integer getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    public List<FileVO> getFileList() {
        return fileList;
    }

    public void setFileList(List<FileVO> fileList) {
        this.fileList = fileList;
    }

    public String[] getFileIds() {
        return fileIds;
    }

    /**
     * fileIds을(를) 설정
     * 
     * @param fileIds을(를) String[] fileIds로 설정
     */
    public void setFileIds(String[] fileIds) {
        this.fileIds = fileIds;
    }

    public Integer getFileCnt() {
        return fileCnt;
    }

    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }

    public Integer getDownCnt() {
        return downCnt;
    }

    public void setDownCnt(Integer downCnt) {
        this.downCnt = downCnt;
    }
    /** 2015.09.15. End */

}
