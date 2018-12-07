/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManageBoard;

import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	 수정자   	 수정내용
 *--------------		----------  	-------------------------------
 * 2014. 10. 28.    		 boseok       	신규
 *</pre>
 * @see
 */
public class CmManageBoardVO  extends PaggingVO {
    
    /**  */
    private static final long serialVersionUID = 3971903556940602174L;
    
    /**  사용자아이디  */
    private String userId;
    /**  언어코드  */
    private String langCode;
    /**  커뮤니티아이디  */
    private String cmmntyId;
    /**  커뮤니티메뉴코드  */
    private String cmmntyMenuCode;
    /**  커뮤니티게시글일련  */
    private Integer cmmntyBbsSeq;
    /**  커뮤니티게시판유형코드  */
    private Integer cmmntyBbsTyCd;
    /**  커뮤니티게시판코드  */
    private Integer cmmntyBbsCd;
    /**  등록자아이디  */
    private String registId;
    /**  등록일시  */
    private String registDt;
    /**  수정자아이디  */
    private String updtId;
    /**  수정일시  */
    private String updtDt;
    /**  게시글제목  */
    private String bbscttSj;
    /**  게시글내용  */
    private String bbscttCn;
    /**  내용요약  */
    private String cnSumry;
    /**  첨부파일일련  */
    private Integer atchFileSeq;
    /**  공개설정코드  */
    private Integer othbcSetupCd;
    /**  조회수  */
    private Integer rdcnt;
    /**  답변내용  */
    private String answerCn;
    /**  답변자아이디  */
    private String answerId;
    /**  답변자 닉네임  */
    private String answerNcnm;
    /**  답변일시  */
    private String answerDt;
    /**  작성자삭제여부  */
    private String wrterDeleteAt;
    /**  관리자삭제여부  */
    private String mngrDeleteAt;
    /**  접근IP주소  */
    private String accessIpAdres;
    /**  공지게시글여부  */
    private String noticeBbscttAt;
    /**  접근브라우저에이전트  */
    private String accessBrwsrAgent;
    /**  댓글 수  */
    private Integer cmBbsCmtCount;
    /**  닉네임  */
    private String ncnm;  
    /** 작성자 닉네임  */
    private String wrterNcnm;
    
    /**  커뮤니티댓글일련  */
    private String cmmntyCmtSeq;
    /**  참조댓글일련  */
    private String refrnCmtSeq;
    /**  댓글깊이  */
    private Integer cmtDp;
    /**  댓글정렬순서  */
    private Integer cmtSortOrdr;
    /**  댓글내용  */
    private String cmtCn;
    /**  작성자IP주소  */
    private String wrterIpAdres;
    /**  댓글삭제코드   1001 작성자삭제 1002 운영자삭제 1003 관리자삭제 */
    private Integer cmtDeleteCd;
    
    
    /** 다운로드 수 */
    private Integer downCnt =0;
    
    /**  파일일련  */
    private Integer fileSeq = -1;
    /**  파일아이디  */
    private String fileId;
    /**  파일순서번호  */
    private Integer orderNo = 0;
    /**  로컬원본명  */
    private String localNm;
    /**  서버파일명  */
    private String serverNm;
    /**  파일URL  */
    private String fileUrl;
    /**  파일사이즈  */
    private String fileSize;
    /**  파일유형  */
    private String fileType;
    /**  파일확장자  */
    private String fileExt;
    /**  파일설명  */
    private String fileDesc;
    /**  INPUT태그변수명  */
    private String inputNm;
    /**  파일바이트사이즈  */
    private Long fileByteSize;
    
    /** 첨부파일 수 */
    private Integer fileCnt = 0;
    
    /** 멀티 체크박스 **/ 
    private List<String> ckMultiBox;
    private String multiCheck;
    
    /**커뮤니티 게시판 이전글 */
   private CmManageBoardVO prevVO;
   /** 커뮤니티 게시판 다음글 */
   private CmManageBoardVO nextVO;
   
   /** 커뮤니티 검색어*/
   private String q_searchKeyWord;
   
   /** 커뮤니티 검색어*/
   private String q_keyWordSearch;
   
   /** 첨부파일 목록 */
   private List<FileVO> fileList;
   
   /** 게시판 태그 */
   private String tagNm;
   
   /** 게시판 목록 공개 설정 체크*/
   private String othbcSetupCdChk;
   
   /** 게시판 파일 **/
   private List <CmManageBoardVO> cmUserBoardFileCollection;

   /** 게시판 태그 **/
   private List <CmManageBoardVO> cmUserBoardTagCollection;
   /** 작성댓글 작성글 체크 **/
   private String writeReplyChk;

   /**  커뮤니티메뉴폴더명  */
   private String cmmntyMenuFolderNm;
   
   
   /** SKYOU 20160107  댓글비빌  */
   private String secretYn;
   
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
     * String cmmntyId을 반환
     * @return String cmmntyId
     */
    public String getCmmntyId() {
        return cmmntyId;
    }
    
    /**
     * cmmntyId을 설정
     * @param cmmntyId 을(를) String cmmntyId로 설정
     */
    public void setCmmntyId(String cmmntyId) {
        this.cmmntyId = cmmntyId;
    }
    
    /**
     * String cmmntyMenuCode을 반환
     * @return String cmmntyMenuCode
     */
    public String getCmmntyMenuCode() {
        return cmmntyMenuCode;
    }
    
    /**
     * cmmntyMenuCode을 설정
     * @param cmmntyMenuCode 을(를) String cmmntyMenuCode로 설정
     */
    public void setCmmntyMenuCode(String cmmntyMenuCode) {
        this.cmmntyMenuCode = cmmntyMenuCode;
    }
    
    /**
     * Integer cmmntyBbsSeq을 반환
     * @return Integer cmmntyBbsSeq
     */
    public Integer getCmmntyBbsSeq() {
        return cmmntyBbsSeq;
    }
    
    /**
     * cmmntyBbsSeq을 설정
     * @param cmmntyBbsSeq 을(를) Integer cmmntyBbsSeq로 설정
     */
    public void setCmmntyBbsSeq(Integer cmmntyBbsSeq) {
        this.cmmntyBbsSeq = cmmntyBbsSeq;
    }
    
    /**
     * Integer cmmntyBbsTyCd을 반환
     * @return Integer cmmntyBbsTyCd
     */
    public Integer getCmmntyBbsTyCd() {
        return cmmntyBbsTyCd;
    }
    
    /**
     * cmmntyBbsTyCd을 설정
     * @param cmmntyBbsTyCd 을(를) Integer cmmntyBbsTyCd로 설정
     */
    public void setCmmntyBbsTyCd(Integer cmmntyBbsTyCd) {
        this.cmmntyBbsTyCd = cmmntyBbsTyCd;
    }
    
    /**
     * Integer cmmntyBbsCd을 반환
     * @return Integer cmmntyBbsCd
     */
    public Integer getCmmntyBbsCd() {
        return cmmntyBbsCd;
    }
    
    /**
     * cmmntyBbsCd을 설정
     * @param cmmntyBbsCd 을(를) Integer cmmntyBbsCd로 설정
     */
    public void setCmmntyBbsCd(Integer cmmntyBbsCd) {
        this.cmmntyBbsCd = cmmntyBbsCd;
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
     * String bbscttSj을 반환
     * @return String bbscttSj
     */
    public String getBbscttSj() {
        return bbscttSj;
    }
    
    /**
     * bbscttSj을 설정
     * @param bbscttSj 을(를) String bbscttSj로 설정
     */
    public void setBbscttSj(String bbscttSj) {
        this.bbscttSj = bbscttSj;
    }
    
    /**
     * String bbscttCn을 반환
     * @return String bbscttCn
     */
    public String getBbscttCn() {
        return bbscttCn;
    }
    
    /**
     * bbscttCn을 설정
     * @param bbscttCn 을(를) String bbscttCn로 설정
     */
    public void setBbscttCn(String bbscttCn) {
        this.bbscttCn = bbscttCn;
    }
    
    /**
     * String cnSumry을 반환
     * @return String cnSumry
     */
    public String getCnSumry() {
        return cnSumry;
    }
    
    /**
     * cnSumry을 설정
     * @param cnSumry 을(를) String cnSumry로 설정
     */
    public void setCnSumry(String cnSumry) {
        this.cnSumry = cnSumry;
    }
    
    /**
     * Integer atchFileSeq을 반환
     * @return Integer atchFileSeq
     */
    public Integer getAtchFileSeq() {
        return atchFileSeq;
    }
    
    /**
     * atchFileSeq을 설정
     * @param atchFileSeq 을(를) Integer atchFileSeq로 설정
     */
    public void setAtchFileSeq(Integer atchFileSeq) {
        this.atchFileSeq = atchFileSeq;
    }
    
    /**
     * Integer othbcSetupCd을 반환
     * @return Integer othbcSetupCd
     */
    public Integer getOthbcSetupCd() {
        return othbcSetupCd;
    }
    
    /**
     * othbcSetupCd을 설정
     * @param othbcSetupCd 을(를) Integer othbcSetupCd로 설정
     */
    public void setOthbcSetupCd(Integer othbcSetupCd) {
        this.othbcSetupCd = othbcSetupCd;
    }
    
    /**
     * Integer rdcnt을 반환
     * @return Integer rdcnt
     */
    public Integer getRdcnt() {
        return rdcnt;
    }
    
    /**
     * rdcnt을 설정
     * @param rdcnt 을(를) Integer rdcnt로 설정
     */
    public void setRdcnt(Integer rdcnt) {
        this.rdcnt = rdcnt;
    }
    
    /**
     * String answerCn을 반환
     * @return String answerCn
     */
    public String getAnswerCn() {
        return answerCn;
    }
    
    /**
     * answerCn을 설정
     * @param answerCn 을(를) String answerCn로 설정
     */
    public void setAnswerCn(String answerCn) {
        this.answerCn = answerCn;
    }
    
    /**
     * String answerId을 반환
     * @return String answerId
     */
    public String getAnswerId() {
        return answerId;
    }
    
    /**
     * answerId을 설정
     * @param answerId 을(를) String answerId로 설정
     */
    public void setAnswerId(String answerId) {
        this.answerId = answerId;
    }
    
    /**
     * String answerDt을 반환
     * @return String answerDt
     */
    public String getAnswerDt() {
        return answerDt;
    }
    
    /**
     * answerDt을 설정
     * @param answerDt 을(를) String answerDt로 설정
     */
    public void setAnswerDt(String answerDt) {
        this.answerDt = answerDt;
    }
    
    /**
     * String wrterDeleteAt을 반환
     * @return String wrterDeleteAt
     */
    public String getWrterDeleteAt() {
        return wrterDeleteAt;
    }
    
    /**
     * wrterDeleteAt을 설정
     * @param wrterDeleteAt 을(를) String wrterDeleteAt로 설정
     */
    public void setWrterDeleteAt(String wrterDeleteAt) {
        this.wrterDeleteAt = wrterDeleteAt;
    }
    
    /**
     * String mngrDeleteAt을 반환
     * @return String mngrDeleteAt
     */
    public String getMngrDeleteAt() {
        return mngrDeleteAt;
    }
    
    /**
     * mngrDeleteAt을 설정
     * @param mngrDeleteAt 을(를) String mngrDeleteAt로 설정
     */
    public void setMngrDeleteAt(String mngrDeleteAt) {
        this.mngrDeleteAt = mngrDeleteAt;
    }
    
    /**
     * String accessIpAdres을 반환
     * @return String accessIpAdres
     */
    public String getAccessIpAdres() {
        return accessIpAdres;
    }
    
    /**
     * accessIpAdres을 설정
     * @param accessIpAdres 을(를) String accessIpAdres로 설정
     */
    public void setAccessIpAdres(String accessIpAdres) {
        this.accessIpAdres = accessIpAdres;
    }
    
    /**
     * String accessBrwsrAgent을 반환
     * @return String accessBrwsrAgent
     */
    public String getAccessBrwsrAgent() {
        return accessBrwsrAgent;
    }
    
    /**
     * accessBrwsrAgent을 설정
     * @param accessBrwsrAgent 을(를) String accessBrwsrAgent로 설정
     */
    public void setAccessBrwsrAgent(String accessBrwsrAgent) {
        this.accessBrwsrAgent = accessBrwsrAgent;
    }

    
    /**
     * Integer cmBbsCmtCount을 반환
     * @return Integer cmBbsCmtCount
     */
    public Integer getCmBbsCmtCount() {
        return cmBbsCmtCount;
    }

    
    /**
     * cmBbsCmtCount을 설정
     * @param cmBbsCmtCount 을(를) Integer cmBbsCmtCount로 설정
     */
    public void setCmBbsCmtCount(Integer cmBbsCmtCount) {
        this.cmBbsCmtCount = cmBbsCmtCount;
    }

    
    /**
     * String ncnm을 반환
     * @return String ncnm
     */
    public String getNcnm() {
        return ncnm;
    }

    
    /**
     * ncnm을 설정
     * @param ncnm 을(를) String ncnm로 설정
     */
    public void setNcnm(String ncnm) {
        this.ncnm = ncnm;
    }

    
    /**
     * Integer downCnt을 반환
     * @return Integer downCnt
     */
    public Integer getDownCnt() {
        return downCnt;
    }

    
    /**
     * downCnt을 설정
     * @param downCnt 을(를) Integer downCnt로 설정
     */
    public void setDownCnt(Integer downCnt) {
        this.downCnt = downCnt;
    }

    
    /**
     * List<String> ckMultiBox을 반환
     * @return List<String> ckMultiBox
     */
    public List<String> getCkMultiBox() {
        return ckMultiBox;
    }

    
    /**
     * ckMultiBox을 설정
     * @param ckMultiBox 을(를) List<String> ckMultiBox로 설정
     */
    public void setCkMultiBox(List<String> ckMultiBox) {
        this.ckMultiBox = ckMultiBox;
    }

    
    /**
     * String multiCheck을 반환
     * @return String multiCheck
     */
    public String getMultiCheck() {
        return multiCheck;
    }

    
    /**
     * multiCheck을 설정
     * @param multiCheck 을(를) String multiCheck로 설정
     */
    public void setMultiCheck(String multiCheck) {
        this.multiCheck = multiCheck;
    }

    
    /**
     * Integer fileSeq을 반환
     * @return Integer fileSeq
     */
    public Integer getFileSeq() {
        return fileSeq;
    }

    
    /**
     * fileSeq을 설정
     * @param fileSeq 을(를) Integer fileSeq로 설정
     */
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    
    /**
     * String fileId을 반환
     * @return String fileId
     */
    public String getFileId() {
        return fileId;
    }

    
    /**
     * fileId을 설정
     * @param fileId 을(를) String fileId로 설정
     */
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    
   


    
    /**
     * String fileUrl을 반환
     * @return String fileUrl
     */
    public String getFileUrl() {
        return fileUrl;
    }

    
    /**
     * fileUrl을 설정
     * @param fileUrl 을(를) String fileUrl로 설정
     */
    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    
    /**
     * String fileSize을 반환
     * @return String fileSize
     */
    public String getFileSize() {
        return fileSize;
    }

    
    /**
     * fileSize을 설정
     * @param fileSize 을(를) String fileSize로 설정
     */
    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }


    
    /**
     * String inputNm을 반환
     * @return String inputNm
     */
    public String getInputNm() {
        return inputNm;
    }

    
    /**
     * inputNm을 설정
     * @param inputNm 을(를) String inputNm로 설정
     */
    public void setInputNm(String inputNm) {
        this.inputNm = inputNm;
    }
    
    
    /**
     * Integer orderNo을 반환
     * @return Integer orderNo
     */
    public Integer getOrderNo() {
        return orderNo;
    }

    
    /**
     * orderNo을 설정
     * @param orderNo 을(를) Integer orderNo로 설정
     */
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    
    /**
     * String localNm을 반환
     * @return String localNm
     */
    public String getLocalNm() {
        return localNm;
    }

    
    /**
     * localNm을 설정
     * @param localNm 을(를) String localNm로 설정
     */
    public void setLocalNm(String localNm) {
        this.localNm = localNm;
    }

    
    /**
     * String serverNm을 반환
     * @return String serverNm
     */
    public String getServerNm() {
        return serverNm;
    }

    
    /**
     * serverNm을 설정
     * @param serverNm 을(를) String serverNm로 설정
     */
    public void setServerNm(String serverNm) {
        this.serverNm = serverNm;
    }

    
    /**
     * String fileType을 반환
     * @return String fileType
     */
    public String getFileType() {
        return fileType;
    }

    
    /**
     * fileType을 설정
     * @param fileType 을(를) String fileType로 설정
     */
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    
    /**
     * String fileExt을 반환
     * @return String fileExt
     */
    public String getFileExt() {
        return fileExt;
    }

    
    /**
     * fileExt을 설정
     * @param fileExt 을(를) String fileExt로 설정
     */
    public void setFileExt(String fileExt) {
        this.fileExt = fileExt;
    }

    
    /**
     * String fileDesc을 반환
     * @return String fileDesc
     */
    public String getFileDesc() {
        return fileDesc;
    }

    
    /**
     * fileDesc을 설정
     * @param fileDesc 을(를) String fileDesc로 설정
     */
    public void setFileDesc(String fileDesc) {
        this.fileDesc = fileDesc;
    }

    
    /**
     * Long fileByteSize을 반환
     * @return Long fileByteSize
     */
    public Long getFileByteSize() {
        return fileByteSize;
    }

    
    /**
     * fileByteSize을 설정
     * @param fileByteSize 을(를) Long fileByteSize로 설정
     */
    public void setFileByteSize(Long fileByteSize) {
        this.fileByteSize = fileByteSize;
    }

    /**
     * CmManageBoardVO prevVO을 반환
     * @return CmManageBoardVO prevVO
     */
    public CmManageBoardVO getPrevVO() {
        return prevVO;
    }

    
    /**
     * prevVO을 설정
     * @param prevVO 을(를) CmManageBoardVO prevVO로 설정
     */
    public void setPrevVO(CmManageBoardVO prevVO) {
        this.prevVO = prevVO;
    }

    
    /**
     * CmManageBoardVO nextVO을 반환
     * @return CmManageBoardVO nextVO
     */
    public CmManageBoardVO getNextVO() {
        return nextVO;
    }

    
    /**
     * nextVO을 설정
     * @param nextVO 을(를) CmManageBoardVO nextVO로 설정
     */
    public void setNextVO(CmManageBoardVO nextVO) {
        this.nextVO = nextVO;
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
     * List<CmManageBoardVO> cmUserBoardFileCollection을 반환
     * @return List<CmManageBoardVO> cmUserBoardFileCollection
     */
    public List<CmManageBoardVO> getCmUserBoardFileCollection() {
        return cmUserBoardFileCollection;
    }

    
    /**
     * cmUserBoardFileCollection을 설정
     * @param cmUserBoardFileCollection 을(를) List<CmManageBoardVO> cmUserBoardFileCollection로 설정
     */
    public void setCmUserBoardFileCollection(List<CmManageBoardVO> cmUserBoardFileCollection) {
        this.cmUserBoardFileCollection = cmUserBoardFileCollection;
    }

    
    /**
     * String noticeBbscttAt을 반환
     * @return String noticeBbscttAt
     */
    public String getNoticeBbscttAt() {
        return noticeBbscttAt;
    }

    
    /**
     * noticeBbscttAt을 설정
     * @param noticeBbscttAt 을(를) String noticeBbscttAt로 설정
     */
    public void setNoticeBbscttAt(String noticeBbscttAt) {
        this.noticeBbscttAt = noticeBbscttAt;
    }

    
    /**
     * String tagNm을 반환
     * @return String tagNm
     */
    public String getTagNm() {
        return tagNm;
    }

    
    /**
     * tagNm을 설정
     * @param tagNm 을(를) String tagNm로 설정
     */
    public void setTagNm(String tagNm) {
        this.tagNm = tagNm;
    }

    
    /**
     * String q_searchKeyWord을 반환
     * @return String q_searchKeyWord
     */
    public String getQ_searchKeyWord() {
        return q_searchKeyWord;
    }

    
    /**
     * q_searchKeyWord을 설정
     * @param q_searchKeyWord 을(를) String q_searchKeyWord로 설정
     */
    public void setQ_searchKeyWord(String q_searchKeyWord) {
        this.q_searchKeyWord = q_searchKeyWord;
    }

    
    /**
     * List<CmManageBoardVO> cmUserBoarTagCollection을 반환
     * @return List<CmManageBoardVO> cmUserBoarTagCollection
     */
    public List<CmManageBoardVO> getCmUserBoardTagCollection() {
        return cmUserBoardTagCollection;
    }

    
    /**
     * cmUserBoarTagCollection을 설정
     * @param cmUserBoarTagCollection 을(를) List<CmManageBoardVO> cmUserBoarTagCollection로 설정
     */
    public void setCmUserBoardTagCollection(List<CmManageBoardVO> cmUserBoardTagCollection) {
        this.cmUserBoardTagCollection = cmUserBoardTagCollection;
    }

    
    /**
     * String cmmntyCmtSeq을 반환
     * @return String cmmntyCmtSeq
     */
    public String getCmmntyCmtSeq() {
        return cmmntyCmtSeq;
    }

    
    /**
     * cmmntyCmtSeq을 설정
     * @param cmmntyCmtSeq 을(를) String cmmntyCmtSeq로 설정
     */
    public void setCmmntyCmtSeq(String cmmntyCmtSeq) {
        this.cmmntyCmtSeq = cmmntyCmtSeq;
    }

    
    /**
     * String refrnCmtSeq을 반환
     * @return String refrnCmtSeq
     */
    public String getRefrnCmtSeq() {
        return refrnCmtSeq;
    }

    
    /**
     * refrnCmtSeq을 설정
     * @param refrnCmtSeq 을(를) String refrnCmtSeq로 설정
     */
    public void setRefrnCmtSeq(String refrnCmtSeq) {
        this.refrnCmtSeq = refrnCmtSeq;
    }

    
    /**
     * Integer cmtDp을 반환
     * @return Integer cmtDp
     */
    public Integer getCmtDp() {
        return cmtDp;
    }

    
    /**
     * cmtDp을 설정
     * @param cmtDp 을(를) Integer cmtDp로 설정
     */
    public void setCmtDp(Integer cmtDp) {
        this.cmtDp = cmtDp;
    }

    
    /**
     * Integer cmtSortOrdr을 반환
     * @return Integer cmtSortOrdr
     */
    public Integer getCmtSortOrdr() {
        return cmtSortOrdr;
    }

    
    /**
     * cmtSortOrdr을 설정
     * @param cmtSortOrdr 을(를) Integer cmtSortOrdr로 설정
     */
    public void setCmtSortOrdr(Integer cmtSortOrdr) {
        this.cmtSortOrdr = cmtSortOrdr;
    }

    
    /**
     * String cmtCn을 반환
     * @return String cmtCn
     */
    public String getCmtCn() {
        return cmtCn;
    }

    
    /**
     * cmtCn을 설정
     * @param cmtCn 을(를) String cmtCn로 설정
     */
    public void setCmtCn(String cmtCn) {
        this.cmtCn = cmtCn;
    }

    
    /**
     * String wrterIpAdres을 반환
     * @return String wrterIpAdres
     */
    public String getWrterIpAdres() {
        return wrterIpAdres;
    }

    
    /**
     * wrterIpAdres을 설정
     * @param wrterIpAdres 을(를) String wrterIpAdres로 설정
     */
    public void setWrterIpAdres(String wrterIpAdres) {
        this.wrterIpAdres = wrterIpAdres;
    }

    
    /**
     * Integer cmtDeleteCd을 반환
     * @return Integer cmtDeleteCd
     */
    public Integer getCmtDeleteCd() {
        return cmtDeleteCd;
    }

    
    /**
     * cmtDeleteCd을 설정
     * @param cmtDeleteCd 을(를) Integer cmtDeleteCd로 설정
     */
    public void setCmtDeleteCd(Integer cmtDeleteCd) {
        this.cmtDeleteCd = cmtDeleteCd;
    }

    
    /**
     * String othbcSetupCdChk을 반환
     * @return String othbcSetupCdChk
     */
    public String getOthbcSetupCdChk() {
        return othbcSetupCdChk;
    }

    
    /**
     * othbcSetupCdChk을 설정
     * @param othbcSetupCdChk 을(를) String othbcSetupCdChk로 설정
     */
    public void setOthbcSetupCdChk(String othbcSetupCdChk) {
        this.othbcSetupCdChk = othbcSetupCdChk;
    }

    
    /**
     * String answerNcnm을 반환
     * @return String answerNcnm
     */
    public String getAnswerNcnm() {
        return answerNcnm;
    }

    
    /**
     * answerNcnm을 설정
     * @param answerNcnm 을(를) String answerNcnm로 설정
     */
    public void setAnswerNcnm(String answerNcnm) {
        this.answerNcnm = answerNcnm;
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

    
    /**
     * String writeReplyChk을 반환
     * @return String writeReplyChk
     */
    public String getWriteReplyChk() {
        return writeReplyChk;
    }

    
    /**
     * writeReplyChk을 설정
     * @param writeReplyChk 을(를) String writeReplyChk로 설정
     */
    public void setWriteReplyChk(String writeReplyChk) {
        this.writeReplyChk = writeReplyChk;
    }

    
    /**
     * String wrterNcnm을 반환
     * @return String wrterNcnm
     */
    public String getWrterNcnm() {
        return wrterNcnm;
    }

    
    /**
     * wrterNcnm을 설정
     * @param wrterNcnm 을(를) String wrterNcnm로 설정
     */
    public void setWrterNcnm(String wrterNcnm) {
        this.wrterNcnm = wrterNcnm;
    }

    
    /**
     * String cmmntyMenuFolderNm을 반환
     * @return String cmmntyMenuFolderNm
     */
    public String getCmmntyMenuFolderNm() {
        return cmmntyMenuFolderNm;
    }

    
    /**
     * cmmntyMenuFolderNm을 설정
     * @param cmmntyMenuFolderNm 을(를) String cmmntyMenuFolderNm로 설정
     */
    public void setCmmntyMenuFolderNm(String cmmntyMenuFolderNm) {
        this.cmmntyMenuFolderNm = cmmntyMenuFolderNm;
    }

    
    /**
     * String q_keyWordSearch을 반환
     * @return String q_keyWordSearch
     */
    public String getQ_keyWordSearch() {
        return q_keyWordSearch;
    }

    
    /**
     * q_keyWordSearch을 설정
     * @param q_keyWordSearch 을(를) String q_keyWordSearch로 설정
     */
    public void setQ_keyWordSearch(String q_keyWordSearch) {
        this.q_keyWordSearch = q_keyWordSearch;
    }

    
    /**
     * String secretYn을 반환
     * @return String secretYn
     */
    public String getSecretYn() {
        return secretYn;
    }

    
    /**
     * secretYn을 설정
     * @param secretYn 을(를) String secretYn로 설정
     */
    public void setSecretYn(String secretYn) {
        this.secretYn = secretYn;
    }

    
}
