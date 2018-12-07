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
import zes.core.lang.validate.annotation.marker.MinLength;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;
import zes.openworks.intra.boardconf.BoardArrangeVO;
import zes.openworks.intra.boardconf.BoardConfVO;
import zes.openworks.intra.boardconf.BoardCtgVO;
import zes.openworks.intra.boardconf.BoardExtensionVO;
import zes.openworks.intra.mgr.MgrVO;
import zes.openworks.web.register.RegisterUserVO;

/**
 * 게시판 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일              수정자                   수정내용
 * --------------  --------  ---------------------------------
 *  2012. 5. 14.     손재숙     JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class BoardVO extends PaggingVO {

    private static final long serialVersionUID = 4899680125294621540L;

    /** 분류 목록(1Depth) */
    private List<BoardCtgVO> ctgList;
    /** 분류 목록(2Depth) */
    private List<BoardCtgVO> aditCtgList;
    
    /**  언어코드  */
    private String langCode;
    
    /** 도메인코드 */
    private Integer domainCd;
    /** 게시판코드 */
    private Integer bbsCd = 0;
    /** 게시글일련 */
    private String bbscttSeq;
    /** 참조일련 */
    private String refrnSeq;
    /** 게시글 순서번호 */
    private Integer bbscttOrdrNo = 0;
    /** 게시글깊이 */
    private Integer bbscttDp = 0;
    /** 부류코드(1Depth) */
    private Integer ctgCd = -1;
    /** 부류코드(2Depth) */
    private Integer aditCtgCd = -1;  
    
    /** 공지게시글여부 */
    private String noticeBbscttAt = "N";
    /** 게시글제목 */
    @Required(message = "제목은 필수 입력입니다.")
    @RangeLength(min = 3, max = 200)
    private String bbscttSj;
    /** 제목바이트 길이 */
    private String bbscttSjLength;
    /** 자를 글자수 */
    private Integer cutTitleNum;
    /** 게시글내용 */
    @Required(message = "내용은 필수 입력입니다.")
    @MinLength(min = 10)
    private String bbscttCn;
    /** 내용요약 */
    private String cnSumry;
    /** 내용요약바이트 길이 */
    private String cnSumryLength;
    /** 내용요약 자를 글자수 */
    private Integer cutSumryNum;
    /** 회신내용 */
    private String replyCn;
        
    /**
     * Integer cutSumryNum을 반환
     * @return Integer cutSumryNum
     */
    public Integer getCutSumryNum() {
        return cutSumryNum;
    }

    
    /**
     * cutSumryNum을 설정
     * @param cutSumryNum 을(를) Integer cutSumryNum로 설정
     */
    public void setCutSumryNum(Integer cutSumryNum) {
        this.cutSumryNum = cutSumryNum;
    }

    /** 회신일시 */
    private String replyDt;
    /** 회신아이디 */
    private String replyId;
    /** 회신등록자(이름) */
    private String replyNm;
    /** 파일일련번호 */
    private Integer fileSeq = -1;
    /** 파일URL */
    private String fileUrl;
    /** 조회수 */
    private Integer rdcnt = 0;
    /** 신고카운트 */
    private Integer accuseCnt = 0;
    /** 추천카운트 */
    private Integer recomendCnt = 0;
    /** IP 주소 */
    private String ipAdres;
    /** 브라우저 에이전트 */
    private String brwsrAgent;
    /** 공개 여부 */
    private String othbcAt = "Y";
    /** 금칙어 여부 */
    private String bannedWordAt = "N";
    
    /** 사용자인증키 */
    private String userKey;
    /** 등록비밀번호 */
    private String registPassword;
    /** 등록자명 */
    @Required(message = "작성자는 필수 입력입니다.")
    @RangeLength(min = 2, max = 10)
    private String registerNm;
    /** 등록자ID */
    private String registId;
    /** mask 등록자ID */
    private String maskRegistId; 
    /** 등록일시 */
    private String registDt;
    /** 수정자ID */
    private String updtId;
    /** 수정일시 */
    private String updtDt;
    /** 관리자아이디 */
    private String mngrId;
    /** 관리자명 */
    private String mngrNm;
    /** 부서코드 */
    private String deptCode;
    /** 부서명 */
    private String deptNm;

    /** 게시판명 */
    private String bbsNm;
    /** 분류명(1Depth) */
    private String ctgNm;
    /** 분류명(2Depth) */
    private String aditCtgNm;
    /** 유저 아이디 */
    private String userId;
    /** 유저 이름 */
    private String userNm;
    /** 유저 유형 */
    private Integer userTyCd;
    /** 유저 이메일 */
    private String email;
    /** 유저 닉네임 */
    private String nickNm;
    /** 유저 연락처 */
    private String telNo;
    /** 수정자명 */
    private String updtNm;

    /** 요약 보여주기여부 */
    private String showSummaryYn = "N";
    /** 목록 보기 타입 */
    private String listShowType = "webzine";

    /** 일련번호 목록 */
    private String[] bbscttSeqs;
    /** 첨부파일 목록 */
    private List<FileVO> fileList;
    /** 체크된 첨부파일 목록 (수정 시) */
    private String[] fileIds;
    /** 태그 사용 */
    private String[] bbsTags;
    /** 커멘트 목록 */
    private List<BoardCmtVO> commentList;
    /** 코멘트 일련번호 */
    private String cmtSeq;

    /** 첨부파일 수 */
    private Integer fileCnt = 0;
    
    /** 첨부파일 수 */
    private Integer downCnt = 0;
    
    /** 커멘트 수 */
    private Integer commentCnt = 0;

    /** 게시판 이전글 */
    private BoardVO prevVO;
    /** 게시판 다음글 */
    private BoardVO nextVO;

    /** 게시물 삭제일 */
    private String delDt;
    /** 게시물 삭제이유 */
    private String delDesc;
    /** 삭제 일련번호 */
    private Integer delSeq;

    /** 확장컬럼1 (ADIT_CTG_CD)*/
    private String estnColumn1;
    /** 확장컬럼2 (ADIT_CTG_NM)*/
    private String estnColumn2;
    /** 확장컬럼3 (Q&A 답변상태 Y-답변완료(처리완료), N-미답변(처리중))*/
    private String estnColumn3;
    /** 확장컬럼4 (Q&A 답변공개여부)*/
    private String estnColumn4;
    /** 확장컬럼5 (비즈매칭 선정여부 Y-선정, N-미선정, S-대기) */
    private String estnColumn5;
    /** 확장컬럼6 (비즈매칭 종료일) */
    private String estnColumn6;
    /** 확장컬럼7 */
    private String estnColumn7;
    /** 확장컬럼8 (비즈매칭 카테고리1)*/
    private String estnColumn8;
    /** 확장컬럼9 (비즈매칭 카테고리2)*/
    private String estnColumn9;
    /** 확장컬럼10 (비즈매칭 카테고리3)*/
    private String estnColumn10;
    /** 비즈매칭 상태 (미완료-INC(INCOMPLETION),완료-COM(COMPLETION),진행-PRO(PROGRESS) */
    private String bizProgression;

    /** 관리자삭제여부 */
    private String mngrDeleteAt;

    /** 등록경과일 */
    private Integer passDay;

    /** 검색 - 분류코드(1Depth) */
    private String q_ctgCd;
    /** 검색 - 분류코드(2Depth) */
    private String q_aditCtgCd;
    /** 검색 - 시작일 */
    private String q_startDt;
    /** 검색 - 종료일 */
    private String q_endDt;
    /** 검색 - 시작일(비즈매칭) */
    private String q_bizStartDt;
    /** 검색 - 종료일(비즈매칭) */
    private String q_bizEndDt;
    /** 검색 - 항목+타입 */
    private String q_searchKeyType;
    /** 검색 - 답변 공개여부 */
    private String q_othbcAt;
    /** 검색 - 답변 상태(추가컬럼조회) */
    private String q_estnColumn3;
    /** 검색 - 비즈매칭 선정여부(추가컬럼조회) */
    private String q_estnColumn5;
    /** 검색 - 도메인코드 */
    private String[] q_domainCd;
    /** 검색 - 서비스선택 */
    private String q_product;
    /** 검색 - 게시판코드 */
    private String q_bbsCd;
    
    /** HostNm */
    private String langType;

    /** 참조댓글일련번호 */
    private String refrnCmtSeq;
    
    /** 선정된 댓글seq */
    private String bizCmtSeq;
    /** 서비스명 */
    private String goodsNm;
    /** 서비스코드 */
    private String goodsCode;
    
    /** 카테고리 명  */
    private String ctgryClNm;
    /** 분류명 배열(1Depth) */
    private String[] ctgNms;
    /** 분류명 배열(2Depth) */
    private String[] aditCtgNms;
    /** 카테고리 3depth명  */
    private String langCtgryNm;
    /** 카테고리 path */
    private String ctgryPath;
    /** 카테고리 코드 */
    private String ctgryCode;
    /** 카테고리코드 (비즈매칭) */
    private String[] ctgryCodes;
    /** 카테고리코드 (비즈매칭) */
    private String[] ctgryUserIds;
    /** 관심항목고유번호 */
    private Integer seq;
    
    /** 등록한 주문코드 */
    private Integer orderNo;
    
    /** 카테고리 리스트 */
    private List<BoardVO> ctgryList;
    /** 카테고리 배열*/
    private String[] categorys;
    /** 카테고리 관심등록 user정보 */
    private List<RegisterUserVO> userList;
    
    
    /** Q&A,비즈매칭(마이페이지구분) */
    private String section;
    
    /** 메일구분값 
     * 31 : 비즈매칭 요청등록 
     * 32 : 비즈매칭 매칭등록 
     * 33 : 비즈매칭 선정 
     * 51 : Q&A질문등록 
     * 52 : Q&A답변등록
     * */
    private Integer mailSection;
    
    /** 비즈매칭연락처 */
    private String bizMatchingCttpc; 
    /** 비즈매칭이메일 */
    private String bizMatchingEmail;
    
    /* 커뮤니티 개설자 아이디 */
    private String cmmntyId;
    /* 커뮤니티 명, 커뮤니티 이름 */
    private String cmmntyNm;
    /* 커뮤니티 메뉴 코드 */
    private int cmmntyMenuCode;
    /* 커뮤니티 글 순서*/
    private int cmmntyBbsSeq;
    
    
/*=============================================*/
    /** 확장설정 목록 */
    private List<BoardExtensionVO> listColunms;
    /** 확장상세보기 목록 */
    private List<BoardExtensionVO> viewColunms;
    /** 확장입력 목록 */
    private List<BoardExtensionVO> formColunms;
    /** 검색대상 목록 */
    private List<BoardExtensionVO> searchColunms;
    /** 관리자 목록 */
    private List<MgrVO> authList;
    /** 목록 표시항목 배치 목록 */
    private List<BoardArrangeVO> listArrange;
    /** 상세보기 표시항목 배치 목록 */
    private List<BoardArrangeVO> viewArrange;

    /** 게시판 코드 목록 */
    private String[] bbsCds;
    /** 게시판 명*/
    @Required(message = "게시판 명은 필수 입력입니다.")
    private String bbsDc;
    /** 환경설정순서번호 */
    private Integer confOrdrNo = 0;
    /** 사용가부 */
    private String useYn;
    /** 게시물 수 */
    private Integer articleCnt = 0;
    /** 삭제글 수 */
    private Integer delCnt = 0;

    /** 게시판 설정 구분 코드 */
    private Integer gubunCd = 0;
    
    /**  접근카운트  */
   private int accessCnt;

    /**  접근수정일시  */
   private String accessUpdtDt;
    
    /*
     * -----------------------------------------------------------
     * GLOBAL
     */
    /** 게시판 종류코드 */
    private Integer kndCd = 0;
    /** 게시판 종류 명 */
    private String kndNm;
    /** 분류 가부 */
    @Required
    private String ctgYn = "N";
    /** 공지게시글사용가부 */
    @Required
    private String noticeBbscttUseYn = "N";
    /** 댓글사용가부 */
    @Required
    private String cmtYn = "N";

    /** 헤더 (경로명) */
    private String hderPath;
    /** 푸터 (경로명) */
    private String footerPath;

    /** 목록스킨 */
    private String listSkin;
    /** 상세화면스킨 */
    private String viewSkin;
    /** 양식스킨 */
    private String formSkin;

    /** 스킨세트 (경로명) */
    private String skinPath = "";
    
    /*
     * -----------------------------------------------------------
     * LIST
     */
    /** 페이지당 로우(행)수 */
    private Integer rppNum = 10;
    /** 다운로드 가부 */
    private String dwldYn = "N";
    /** 새글 알림 숫자 */
    private Integer newArticleNum = 3;
    /** 강조 조회 수 */
    private Integer emphasisNum = 100;
    /** 등록자 표시 코드 */
    private Integer registerIndictCd = 0;
    /** FEED 가부 */
    private String feedYn = "N";
    /** 검색 언어코드 */
    private Integer q_domain_cd;
    
    /*
     * -----------------------------------------------------------
     * FORM
     */
    /** 관리자 에디터 가부 */
    private String mngrEditorYn = "N";
    /** 첨부파일 가부 */
    private String fileYn = "N";
    /** 업로더 유형 */
    private Integer uploadTy = 1000;
    /** 최대파일 카운트 */
    private Integer maxFileCnt = 1;
    /** 최대 파일 사이즈 */
    private Integer maxFileSize = 0;
    /** 총합 파일 사이즈 */
    private Integer totalFileSize = 0;
    /** 첨부파일 허용 확장자 ('|' 구분자) */
    private String filePermExtsn; 
    /** CAPTCHAR 자동등록방지가부 */
    private String captchaYn = "N";
    /** 공개 가부 */
    private String othbcYn = "N"; 
    /** 금칙어 가부  */
    private String bannedWordYn = "N";
    /** 금칙어 내용 (쉼표구분) */
    private String bannedWordCn;
    /** 사용자단 에디터 사용여부 */
    private String userEditorYn = "N";


    /*
     * -----------------------------------------------------------
     * VIEW
     */
     
    /** 목록 상세화면 코드 */
    private Integer listViewCd = 1001;
    /** 추천 가부 */
    private String recomendYn = "N";
    /** 신고 가부 */
    private String accuseYn = "N";
    /** 만족도 가부 */
    private String stsfdgYn = "N";
    /** 조회수 증가 제한시간 */
    private Integer rdcntIncrsLmttTime = 3;
    /** 태그가부 */
    private String tagYn = "N";

    /* ------------------------------ 2014. 09. 20 공통  ------------------------------ */
    /** 도메인 명(FULL) */
    private String domainNm;
    /** 도메인삭제여부 */
    private String domainDeleteAt = "N";
    
    /** 서비스 목록 */
    private List<BoardConfVO> productList;
    /** 서비스코드 */
    private String goodsCd;
    
    
    /**
     * bbsBean 객체 복사하기(검색에 필요한 필드만 복사한다.)
     */
    
    public BoardVO copyCreateVO() {
        BoardVO newBean = new BoardVO();
        newBean.setDomainCd(this.getDomainCd());
        newBean.setBbsCd(this.getBbsCd());
        newBean.setBbscttSeq(this.getBbscttSeq());
        newBean.setRefrnSeq(this.getRefrnSeq());
        newBean.setBbscttOrdrNo(this.getBbscttOrdrNo());
        newBean.setBbscttDp(this.getBbscttDp());
        return newBean;
    }

    /**
     * List<BoardCtgVO> ctgList을 반환
     * @return List<BoardCtgVO> ctgList
     */
    public List<BoardCtgVO> getCtgList() {
        return ctgList;
    }

    
    /**
     * ctgList을 설정
     * @param ctgList 을(를) List<BoardCtgVO> ctgList로 설정
     */
    public void setCtgList(List<BoardCtgVO> ctgList) {
        this.ctgList = ctgList;
    }


    
    /**
     * List<BoardCtgVO> aditCtgList을 반환
     * @return List<BoardCtgVO> aditCtgList
     */
    public List<BoardCtgVO> getAditCtgList() {
        return aditCtgList;
    }


    
    /**
     * aditCtgList을 설정
     * @param aditCtgList 을(를) List<BoardCtgVO> aditCtgList로 설정
     */
    public void setAditCtgList(List<BoardCtgVO> aditCtgList) {
        this.aditCtgList = aditCtgList;
    }


    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    public String getBbscttSeq() {
        return bbscttSeq;
    }

    public void setBbscttSeq(String bbscttSeq) {
        this.bbscttSeq = bbscttSeq;
    }


    public Integer getCtgCd() {
        return ctgCd;
    }

    public void setCtgCd(Integer ctgCd) {
        this.ctgCd = ctgCd;
    }

    public Integer getAditCtgCd() {
        return aditCtgCd;
    }

    public void setAditCtgCd(Integer aditCtgCd) {
        this.aditCtgCd = aditCtgCd;
    }

    public String getNoticeBbscttAt() {
        return noticeBbscttAt;
    }

    public void setNoticeBbscttAt(String noticeBbscttAt) {
        this.noticeBbscttAt = noticeBbscttAt;
    }

    public Integer getCutTitleNum() {
        return cutTitleNum;
    }

    public void setCutTitleNum(Integer cutTitleNum) {
        this.cutTitleNum = cutTitleNum;
    }

    public String getReplyDt() {
        return replyDt;
    }

    public void setReplyDt(String replyDt) {
        this.replyDt = replyDt;
    }

    public Integer getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }

    public Integer getRdcnt() {
        return rdcnt;
    }

    public void setRdcnt(Integer rdcnt) {
        this.rdcnt = rdcnt;
    }


    public void setScoreAvg(String scoreAvg) {
    }

    public Integer getAccuseCnt() {
        return accuseCnt;
    }

    public void setAccuseCnt(Integer accuseCnt) {
        this.accuseCnt = accuseCnt;
    }

    public String getIpAdres() {
        return ipAdres;
    }

    public void setIpAdres(String ipAdres) {
        this.ipAdres = ipAdres;
    }

    public String getBrwsrAgent() {
        return brwsrAgent;
    }

    public void setBrwsrAgent(String brwsrAgent) {
        this.brwsrAgent = brwsrAgent;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getRegistId() {
        
        return registId;
    }
    
    public void setRegistId(String registId) {
        this.registId = registId;
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

    public String getRegistDt() {
        return registDt;
    }

    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    public String getUpdtDt() {
        return updtDt;
    }

    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
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

    public String getDeptCode() {
        return deptCode;
    }

    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getBbsNm() {
        return bbsNm;
    }

    public void setBbsNm(String bbsNm) {
        this.bbsNm = bbsNm;
    }
    
    public String getAditCtgNm() {
        return aditCtgNm;
    }

    public void setAditCtgNm(String aditCtgNm) {
        this.aditCtgNm = aditCtgNm;
    }
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCtgNm() {
        return ctgNm;
    }

    public void setCtgNm(String ctgNm) {
        this.ctgNm = ctgNm;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }
    
    public Integer getUserTyCd() {
        return userTyCd;
    }
    
    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickNm() {
        return nickNm;
    }

    public void setNickNm(String nickNm) {
        this.nickNm = nickNm;
    }
    
    public String getTelNo() {
        return telNo;
    }
    
    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getShowSummaryYn() {
        return showSummaryYn;
    }

    public void setShowSummaryYn(String showSummaryYn) {
        this.showSummaryYn = showSummaryYn;
    }

    public String getListShowType() {
        return listShowType;
    }

    public void setListShowType(String listShowType) {
        this.listShowType = listShowType;
    }

    public String[] getBbscttSeqs() {
        return bbscttSeqs;
    }

    public void setBbscttSeqs(String[] bbscttSeqs) {
        this.bbscttSeqs = bbscttSeqs;
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

    /**
     * String[] tagsBbs을(를) 반환
     * 
     * @return String[] tagsBbs
     */
    /*
     * public String[] getTags_bbs(){
     * return tags_bbs;
     * }
     */
    /**
     * tagsBbs을(를) 설정
     * 
     * @param tagsBbs을(를) String[] tagsBbs로 설정
     */
    /*
     * public void setTags_bbs(String[] tagsBbs){
     * tags_bbs = tagsBbs;
     * }
     */

    /**
     * String bbsTags을(를) 반환
     * 
     * @return String bbsTags
     */
    public String[] getBbsTags() {
        /*
         * String str = "";
         * if(Validate.isEmpty(this.tags_bbs)){
         * return str;
         * }
         * for(int i=0; i<this.tags_bbs.length; i++){
         * if(i == (this.tags_bbs.length - 1)){
         * str += this.tags_bbs[i];
         * }else{
         * str += (this.tags_bbs[i] + ", ");
         * }
         * }
         * return str;
         */
        return bbsTags;
    }

    public void setBbsTags(String[] bbsTags) {
        this.bbsTags = bbsTags;
    }

    public List<BoardCmtVO> getCommentList() {
        return commentList;
    }

    public void setCommentList(List<BoardCmtVO> commentList) {
        this.commentList = commentList;
    }

    public String getCmtSeq() {
        return cmtSeq;
    }

    public void setCmtSeq(String cmtSeq) {
        this.cmtSeq = cmtSeq;
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

    public Integer getCommentCnt() {
        return commentCnt;
    }

    public void setCommentCnt(Integer commentCnt) {
        this.commentCnt = commentCnt;
    }

    public BoardVO getPrevVO() {
        return prevVO;
    }

    public void setPrevVO(BoardVO prevVO) {
        this.prevVO = prevVO;
    }

    public BoardVO getNextVO() {
        return nextVO;
    }

    public void setNextVO(BoardVO nextVO) {
        this.nextVO = nextVO;
    }

    public String getDelDt() {
        return delDt;
    }

    public void setDelDt(String delDt) {
        this.delDt = delDt;
    }

    public String getDelDesc() {
        return delDesc;
    }

    public void setDelDesc(String delDesc) {
        this.delDesc = delDesc;
    }

    public Integer getDelSeq() {
        return delSeq;
    }

    public void setDelSeq(Integer delSeq) {
        this.delSeq = delSeq;
    }

    public String getEstnColumn1() {
        return estnColumn1;
    }

    public void setEstnColumn1(String estnColumn1) {
        this.estnColumn1 = estnColumn1;
    }

    public String getEstnColumn2() {
        return estnColumn2;
    }

    public void setEstnColumn2(String estnColumn2) {
        this.estnColumn2 = estnColumn2;
    }

    public String getEstnColumn3() {
        return estnColumn3;
    }

    public void setEstnColumn3(String estnColumn3) {
        this.estnColumn3 = estnColumn3;
    }

    public String getEstnColumn4() {
        return estnColumn4;
    }

    public void setEstnColumn4(String estnColumn4) {
        this.estnColumn4 = estnColumn4;
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

    public String getEstnColumn7() {
        return estnColumn7;
    }

    public void setEstnColumn7(String estnColumn7) {
        this.estnColumn7 = estnColumn7;
    }

    public String getEstnColumn8() {
        return estnColumn8;
    }

    public void setEstnColumn8(String estnColumn8) {
        this.estnColumn8 = estnColumn8;
    }

    public String getEstnColumn9() {
        return estnColumn9;
    }

    public void setEstnColumn9(String estnColumn9) {
        this.estnColumn9 = estnColumn9;
    }

    public String getEstnColumn10() {
        return estnColumn10;
    }

    public void setEstnColumn10(String estnColumn10) {
        this.estnColumn10 = estnColumn10;
    }

    public Integer getPassDay() {
        return passDay;
    }

    public void setPassDay(Integer passDay) {
        this.passDay = passDay;
    }

    public String getQ_ctgCd() {
        return q_ctgCd;
    }

    public void setQ_ctgCd(String q_ctgCd) {
        this.q_ctgCd = q_ctgCd;
    }

    public String getQ_aditCtgCd() {
        return q_aditCtgCd;
    }

    public void setQ_aditCtgCd(String q_aditCtgCd) {
        this.q_aditCtgCd = q_aditCtgCd;
    }

    public String getQ_startDt() {
        return q_startDt;
    }

    public void setQ_startDt(String q_startDt) {
        this.q_startDt = q_startDt;
    }

    public String getQ_endDt() {
        return q_endDt;
    }

    public void setQ_endDt(String q_endDt) {
        this.q_endDt = q_endDt;
    }
    
    public String getQ_bizStartDt() {
        return q_bizStartDt;
    }
    
    public void setQ_bizStartDt(String q_bizStartDt) {
        this.q_bizStartDt = q_bizStartDt;
    }

    public String getQ_bizEndDt() {
        return q_bizEndDt;
    }

    
    public void setQ_bizEndDt(String q_bizEndDt) {
        this.q_bizEndDt = q_bizEndDt;
    }

    public String getQ_searchKeyType() {
        return q_searchKeyType;
    }

    public void setQ_searchKeyType(String q_searchKeyType) {
        this.q_searchKeyType = q_searchKeyType;
    }

    public String getQ_othbcAt() {
        return q_othbcAt;
    }

    public void setQ_othbcAt(String q_othbcAt) {
        this.q_othbcAt = q_othbcAt;
    }

    public String getQ_estnColumn3() {
        return q_estnColumn3;
    }

    public void setQ_estnColumn3(String q_estnColumn3) {
        this.q_estnColumn3 = q_estnColumn3;
    }

    public String getQ_estnColumn5() {
        return q_estnColumn5;
    }

    public void setQ_estnColumn5(String q_estnColumn5) {
        this.q_estnColumn5 = q_estnColumn5;
    }

    public String[] getQ_domainCd() {
        return q_domainCd;
    }

    public void setQ_domainCd(String[] q_domainCd) {
        this.q_domainCd = q_domainCd;
    }
    
    public String getQ_product() {
        return q_product;
    }
    
    public void setQ_product(String q_product) {
        this.q_product = q_product;
    }
    public String getQ_bbsCd() {
        return q_bbsCd;
    }
    
    public void setQ_bbsCd(String q_bbsCd) {
        this.q_bbsCd = q_bbsCd;
    }

    public Integer getDomainCd() {
        return domainCd;
    }

    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }

    public String getReplyId() {
        return replyId;
    }

    public void setReplyId(String replyId) {
        this.replyId = replyId;
    }

    public String getReplyNm() {
        return replyNm;
    }

    public void setReplyNm(String replyNm) {
        this.replyNm = replyNm;
    }

    public String getLangType() {
        return langType;
    }

    public void setLangType(String langType) {
        this.langType = langType;
    }

    public String getRefrnSeq() {
        return refrnSeq;
    }

    public void setRefrnSeq(String refrnSeq) {
        this.refrnSeq = refrnSeq;
    }

    public Integer getBbscttDp() {
        return bbscttDp;
    }

    public void setBbscttDp(Integer bbscttDp) {
        this.bbscttDp = bbscttDp;
    }

    public Integer getRecomendCnt() {
        return recomendCnt;
    }

    public void setRecomendCnt(Integer recomendCnt) {
        this.recomendCnt = recomendCnt;
    }

    public String getOthbcAt() {
        return othbcAt;
    }

    public void setOthbcAt(String othbcAt) {
        this.othbcAt = othbcAt;
    }

    public String getBannedWordAt() {
        return bannedWordAt;
    }

    public void setBannedWordAt(String bannedWordAt) {
        this.bannedWordAt = bannedWordAt;
    }

    public String getRegistPassword() {
        return registPassword;
    }

    public void setRegistPassword(String registPassword) {
        this.registPassword = registPassword;
    }

    public String getMngrDeleteAt() {
        return mngrDeleteAt;
    }

    public void setMngrDeleteAt(String mngrDeleteAt) {
        this.mngrDeleteAt = mngrDeleteAt;
    }

    public Integer getBbscttOrdrNo() {
        return bbscttOrdrNo;
    }

    public void setBbscttOrdrNo(Integer bbscttOrdrNo) {
        this.bbscttOrdrNo = bbscttOrdrNo;
    }

    public String getBbscttSj() {
        return bbscttSj;
    }

    public void setBbscttSj(String bbscttSj) {
        this.bbscttSj = bbscttSj;
    }

    public String getBbscttSjLength() {
        return bbscttSjLength;
    }

    public void setBbscttSjLength(String bbscttSjLength) {
        this.bbscttSjLength = bbscttSjLength;
    }

    public String getBbscttCn() {
        return bbscttCn;
    }

    public void setBbscttCn(String bbscttCn) {
        this.bbscttCn = bbscttCn;
    }

    public String getCnSumry() {
        return cnSumry;
    }

    public void setCnSumry(String cnSumry) {
        this.cnSumry = cnSumry;
    }
    
    /**
     * String cnSumryLength을 반환
     * @return String cnSumryLength
     */
    public String getCnSumryLength() {
        return cnSumryLength;
    }

    
    /**
     * cnSumryLength을 설정
     * @param cnSumryLength 을(를) String cnSumryLength로 설정
     */
    public void setCnSumryLength(String cnSumryLength) {
        this.cnSumryLength = cnSumryLength;
    }

    public String getReplyCn() {
        return replyCn;
    }

    public void setReplyCn(String replyCn) {
        this.replyCn = replyCn;
    }

    public String getRegisterNm() {
        return registerNm;
    }

    public void setRegisterNm(String registerNm) {
        this.registerNm = registerNm;
    }

    public String getUpdtId() {
        return updtId;
    }

    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    public String getUpdtNm() {
        return updtNm;
    }

    public void setUpdtNm(String updtNm) {
        this.updtNm = updtNm;
    }

    public String getRefrnCmtSeq() {
        return refrnCmtSeq;
    }

    public void setRefrnCmtSeq(String refrnCmtSeq) {
        this.refrnCmtSeq = refrnCmtSeq;
    }

    public String getBizProgression() {
        return bizProgression;
    }

    public void setBizProgression(String bizProgression) {
        this.bizProgression = bizProgression;
    }

    public String getBizCmtSeq() {
        return bizCmtSeq;
    }
    
    public void setBizCmtSeq(String bizCmtSeq) {
        this.bizCmtSeq = bizCmtSeq;
    }

    public String getGoodsNm() {
        return goodsNm;
    }

    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    public String getGoodsCode() {
        return goodsCode;
    }

    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }
    
    public String getCtgryClNm() {
        return ctgryClNm;
    }
    
    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }
    
    public String getLangCtgryNm() {
        return langCtgryNm;
    }
    
    public void setLangCtgryNm(String langCtgryNm) {
        this.langCtgryNm = langCtgryNm;
    }

    public String getCtgryPath() {
        return ctgryPath;
    }

    public void setCtgryPath(String ctgryPath) {
        this.ctgryPath = ctgryPath;
    }

    public String getCtgryCode() {
        return ctgryCode;
    }
    
    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }
    
    public String[] getCtgryCodes() {
        return ctgryCodes;
    }

    public void setCtgryCodes(String[] ctgryCodes) {
        this.ctgryCodes = ctgryCodes;
    }
    
    public Integer getSeq() {
        return seq;
    }
    
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public List<BoardVO> getCtgryList() {
        return ctgryList;
    }

    public void setCtgryList(List<BoardVO> ctgryList) {
        this.ctgryList = ctgryList;
    }
    
    
    public String[] getCategorys() {
        return categorys;
    }

    
    public void setCategorys(String[] categorys) {
        this.categorys = categorys;
    }

    public List<RegisterUserVO> getUserList() {
        return userList;
    }

    
    public void setUserList(List<RegisterUserVO> userList) {
        this.userList = userList;
    }

    public String getLangCode() {
        return langCode;
    }

    
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }
    
    public String getSection() {
        return section;
    }
    
    public void setSection(String section) {
        this.section = section;
    }

    public Integer getMailSection() {
        return mailSection;
    }

    public void setMailSection(Integer mailSection) {
        this.mailSection = mailSection;
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

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }


    /**
     * String [] ctgryUserIds을 반환
     * @return String [] ctgryUserIds
     */
    public String[] getCtgryUserIds() {
        return ctgryUserIds;
    }


    /**
     * ctgryUserIds을 설정
     * @param ctgryUserIds 을(를) String [] ctgryUserIds로 설정
     */
    public void setCtgryUserIds(String[] ctgryUserIds) {
        this.ctgryUserIds = ctgryUserIds;
    }


    
    /**
     * String fileurl을 반환
     * @return String fileurl
     */
    public String getFileUrl() {
        return fileUrl;
    }


    
    /**
     * fileurl을 설정
     * @param fileurl 을(를) String fileurl로 설정
     */
    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
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
     * String cmmnTyNm을 반환
     * @return String cmmnTyNm
     */
    public String getCmmntyNm() {
        return cmmntyNm;
    }


    
    /**
     * cmmnTyNm을 설정
     * @param cmmnTyNm 을(를) String cmmnTyNm로 설정
     */
    public void setCmmntyNm(String cmmntyNm) {
        this.cmmntyNm = cmmntyNm;
    }


    
    /**
     * int cmmntyMenuCode을 반환
     * @return int cmmntyMenuCode
     */
    public int getCmmntyMenuCode() {
        return cmmntyMenuCode;
    }


    
    /**
     * cmmntyMenuCode을 설정
     * @param cmmntyMenuCode 을(를) int cmmntyMenuCode로 설정
     */
    public void setCmmntyMenuCode(int cmmntyMenuCode) {
        this.cmmntyMenuCode = cmmntyMenuCode;
    }


    
    /**
     * int cmmntyBbsSeq을 반환
     * @return int cmmntyBbsSeq
     */
    public int getCmmntyBbsSeq() {
        return cmmntyBbsSeq;
    }


    
    /**
     * cmmntyBbsSeq을 설정
     * @param cmmntyBbsSeq 을(를) int cmmntyBbsSeq로 설정
     */
    public void setCmmntyBbsSeq(int cmmntyBbsSeq) {
        this.cmmntyBbsSeq = cmmntyBbsSeq;
    }


    
    /**
     * String[] ctgNms을 반환
     * @return String[] ctgNms
     */
    public String[] getCtgNms() {
        return ctgNms;
    }


    
    /**
     * ctgNms을 설정
     * @param ctgNms 을(를) String[] ctgNms로 설정
     */
    public void setCtgNms(String[] ctgNms) {
        this.ctgNms = ctgNms;
    }


    
    /**
     * String[] aditCtgNms을 반환
     * @return String[] aditCtgNms
     */
    public String[] getAditCtgNms() {
        return aditCtgNms;
    }


    
    /**
     * aditCtgNms을 설정
     * @param aditCtgNms 을(를) String[] aditCtgNms로 설정
     */
    public void setAditCtgNms(String[] aditCtgNms) {
        this.aditCtgNms = aditCtgNms;
    }


    
    /**
     * List<BoardExtensionVO> listColunms을 반환
     * @return List<BoardExtensionVO> listColunms
     */
    public List<BoardExtensionVO> getListColunms() {
        return listColunms;
    }


    
    /**
     * listColunms을 설정
     * @param listColunms 을(를) List<BoardExtensionVO> listColunms로 설정
     */
    public void setListColunms(List<BoardExtensionVO> listColunms) {
        this.listColunms = listColunms;
    }


    
    /**
     * List<BoardExtensionVO> viewColunms을 반환
     * @return List<BoardExtensionVO> viewColunms
     */
    public List<BoardExtensionVO> getViewColunms() {
        return viewColunms;
    }


    
    /**
     * viewColunms을 설정
     * @param viewColunms 을(를) List<BoardExtensionVO> viewColunms로 설정
     */
    public void setViewColunms(List<BoardExtensionVO> viewColunms) {
        this.viewColunms = viewColunms;
    }


    
    /**
     * List<BoardExtensionVO> formColunms을 반환
     * @return List<BoardExtensionVO> formColunms
     */
    public List<BoardExtensionVO> getFormColunms() {
        return formColunms;
    }


    
    /**
     * formColunms을 설정
     * @param formColunms 을(를) List<BoardExtensionVO> formColunms로 설정
     */
    public void setFormColunms(List<BoardExtensionVO> formColunms) {
        this.formColunms = formColunms;
    }


    
    /**
     * List<BoardExtensionVO> searchColunms을 반환
     * @return List<BoardExtensionVO> searchColunms
     */
    public List<BoardExtensionVO> getSearchColunms() {
        return searchColunms;
    }


    
    /**
     * searchColunms을 설정
     * @param searchColunms 을(를) List<BoardExtensionVO> searchColunms로 설정
     */
    public void setSearchColunms(List<BoardExtensionVO> searchColunms) {
        this.searchColunms = searchColunms;
    }


    
    /**
     * List<MgrVO> authList을 반환
     * @return List<MgrVO> authList
     */
    public List<MgrVO> getAuthList() {
        return authList;
    }


    
    /**
     * authList을 설정
     * @param authList 을(를) List<MgrVO> authList로 설정
     */
    public void setAuthList(List<MgrVO> authList) {
        this.authList = authList;
    }


    
    /**
     * List<BoardArrangeVO> listArrange을 반환
     * @return List<BoardArrangeVO> listArrange
     */
    public List<BoardArrangeVO> getListArrange() {
        return listArrange;
    }


    
    /**
     * listArrange을 설정
     * @param listArrange 을(를) List<BoardArrangeVO> listArrange로 설정
     */
    public void setListArrange(List<BoardArrangeVO> listArrange) {
        this.listArrange = listArrange;
    }


    
    /**
     * List<BoardArrangeVO> viewArrange을 반환
     * @return List<BoardArrangeVO> viewArrange
     */
    public List<BoardArrangeVO> getViewArrange() {
        return viewArrange;
    }


    
    /**
     * viewArrange을 설정
     * @param viewArrange 을(를) List<BoardArrangeVO> viewArrange로 설정
     */
    public void setViewArrange(List<BoardArrangeVO> viewArrange) {
        this.viewArrange = viewArrange;
    }


    
    /**
     * String[] bbsCds을 반환
     * @return String[] bbsCds
     */
    public String[] getBbsCds() {
        return bbsCds;
    }


    
    /**
     * bbsCds을 설정
     * @param bbsCds 을(를) String[] bbsCds로 설정
     */
    public void setBbsCds(String[] bbsCds) {
        this.bbsCds = bbsCds;
    }


    
    /**
     * String bbsDc을 반환
     * @return String bbsDc
     */
    public String getBbsDc() {
        return bbsDc;
    }


    
    /**
     * bbsDc을 설정
     * @param bbsDc 을(를) String bbsDc로 설정
     */
    public void setBbsDc(String bbsDc) {
        this.bbsDc = bbsDc;
    }


    
    /**
     * Integer confOrdrNo을 반환
     * @return Integer confOrdrNo
     */
    public Integer getConfOrdrNo() {
        return confOrdrNo;
    }


    
    /**
     * confOrdrNo을 설정
     * @param confOrdrNo 을(를) Integer confOrdrNo로 설정
     */
    public void setConfOrdrNo(Integer confOrdrNo) {
        this.confOrdrNo = confOrdrNo;
    }


    
    /**
     * String useYn을 반환
     * @return String useYn
     */
    public String getUseYn() {
        return useYn;
    }


    
    /**
     * useYn을 설정
     * @param useYn 을(를) String useYn로 설정
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


    
    /**
     * Integer articleCnt을 반환
     * @return Integer articleCnt
     */
    public Integer getArticleCnt() {
        return articleCnt;
    }


    
    /**
     * articleCnt을 설정
     * @param articleCnt 을(를) Integer articleCnt로 설정
     */
    public void setArticleCnt(Integer articleCnt) {
        this.articleCnt = articleCnt;
    }


    
    /**
     * Integer delCnt을 반환
     * @return Integer delCnt
     */
    public Integer getDelCnt() {
        return delCnt;
    }


    
    /**
     * delCnt을 설정
     * @param delCnt 을(를) Integer delCnt로 설정
     */
    public void setDelCnt(Integer delCnt) {
        this.delCnt = delCnt;
    }


    
    /**
     * Integer gubunCd을 반환
     * @return Integer gubunCd
     */
    public Integer getGubunCd() {
        return gubunCd;
    }


    
    /**
     * gubunCd을 설정
     * @param gubunCd 을(를) Integer gubunCd로 설정
     */
    public void setGubunCd(Integer gubunCd) {
        this.gubunCd = gubunCd;
    }


    
    /**
     * int accessCnt을 반환
     * @return int accessCnt
     */
    public int getAccessCnt() {
        return accessCnt;
    }


    
    /**
     * accessCnt을 설정
     * @param accessCnt 을(를) int accessCnt로 설정
     */
    public void setAccessCnt(int accessCnt) {
        this.accessCnt = accessCnt;
    }


    
    /**
     * String accessUpdtDt을 반환
     * @return String accessUpdtDt
     */
    public String getAccessUpdtDt() {
        return accessUpdtDt;
    }


    
    /**
     * accessUpdtDt을 설정
     * @param accessUpdtDt 을(를) String accessUpdtDt로 설정
     */
    public void setAccessUpdtDt(String accessUpdtDt) {
        this.accessUpdtDt = accessUpdtDt;
    }


    
    /**
     * Integer kndCd을 반환
     * @return Integer kndCd
     */
    public Integer getKndCd() {
        return kndCd;
    }


    
    /**
     * kndCd을 설정
     * @param kndCd 을(를) Integer kndCd로 설정
     */
    public void setKndCd(Integer kndCd) {
        this.kndCd = kndCd;
    }


    
    /**
     * String kndNm을 반환
     * @return String kndNm
     */
    public String getKndNm() {
        return kndNm;
    }


    
    /**
     * kndNm을 설정
     * @param kndNm 을(를) String kndNm로 설정
     */
    public void setKndNm(String kndNm) {
        this.kndNm = kndNm;
    }


    
    /**
     * String ctgYn을 반환
     * @return String ctgYn
     */
    public String getCtgYn() {
        return ctgYn;
    }


    
    /**
     * ctgYn을 설정
     * @param ctgYn 을(를) String ctgYn로 설정
     */
    public void setCtgYn(String ctgYn) {
        this.ctgYn = ctgYn;
    }


    
    /**
     * String noticeBbscttUseYn을 반환
     * @return String noticeBbscttUseYn
     */
    public String getNoticeBbscttUseYn() {
        return noticeBbscttUseYn;
    }


    
    /**
     * noticeBbscttUseYn을 설정
     * @param noticeBbscttUseYn 을(를) String noticeBbscttUseYn로 설정
     */
    public void setNoticeBbscttUseYn(String noticeBbscttUseYn) {
        this.noticeBbscttUseYn = noticeBbscttUseYn;
    }


    
    /**
     * String cmtYn을 반환
     * @return String cmtYn
     */
    public String getCmtYn() {
        return cmtYn;
    }


    
    /**
     * cmtYn을 설정
     * @param cmtYn 을(를) String cmtYn로 설정
     */
    public void setCmtYn(String cmtYn) {
        this.cmtYn = cmtYn;
    }


    
    /**
     * String hderPath을 반환
     * @return String hderPath
     */
    public String getHderPath() {
        return hderPath;
    }


    
    /**
     * hderPath을 설정
     * @param hderPath 을(를) String hderPath로 설정
     */
    public void setHderPath(String hderPath) {
        this.hderPath = hderPath;
    }


    
    /**
     * String footerPath을 반환
     * @return String footerPath
     */
    public String getFooterPath() {
        return footerPath;
    }


    
    /**
     * footerPath을 설정
     * @param footerPath 을(를) String footerPath로 설정
     */
    public void setFooterPath(String footerPath) {
        this.footerPath = footerPath;
    }


    
    /**
     * String listSkin을 반환
     * @return String listSkin
     */
    public String getListSkin() {
        return listSkin;
    }


    
    /**
     * listSkin을 설정
     * @param listSkin 을(를) String listSkin로 설정
     */
    public void setListSkin(String listSkin) {
        this.listSkin = listSkin;
    }


    
    /**
     * String viewSkin을 반환
     * @return String viewSkin
     */
    public String getViewSkin() {
        return viewSkin;
    }


    
    /**
     * viewSkin을 설정
     * @param viewSkin 을(를) String viewSkin로 설정
     */
    public void setViewSkin(String viewSkin) {
        this.viewSkin = viewSkin;
    }


    
    /**
     * String formSkin을 반환
     * @return String formSkin
     */
    public String getFormSkin() {
        return formSkin;
    }


    
    /**
     * formSkin을 설정
     * @param formSkin 을(를) String formSkin로 설정
     */
    public void setFormSkin(String formSkin) {
        this.formSkin = formSkin;
    }


    
    /**
     * String skinPath을 반환
     * @return String skinPath
     */
    public String getSkinPath() {
        return skinPath;
    }


    
    /**
     * skinPath을 설정
     * @param skinPath 을(를) String skinPath로 설정
     */
    public void setSkinPath(String skinPath) {
        this.skinPath = skinPath;
    }


    
    /**
     * Integer rppNum을 반환
     * @return Integer rppNum
     */
    public Integer getRppNum() {
        return rppNum;
    }


    
    /**
     * rppNum을 설정
     * @param rppNum 을(를) Integer rppNum로 설정
     */
    public void setRppNum(Integer rppNum) {
        this.rppNum = rppNum;
    }


    
    /**
     * String dwldYn을 반환
     * @return String dwldYn
     */
    public String getDwldYn() {
        return dwldYn;
    }


    
    /**
     * dwldYn을 설정
     * @param dwldYn 을(를) String dwldYn로 설정
     */
    public void setDwldYn(String dwldYn) {
        this.dwldYn = dwldYn;
    }


    
    /**
     * Integer newArticleNum을 반환
     * @return Integer newArticleNum
     */
    public Integer getNewArticleNum() {
        return newArticleNum;
    }


    
    /**
     * newArticleNum을 설정
     * @param newArticleNum 을(를) Integer newArticleNum로 설정
     */
    public void setNewArticleNum(Integer newArticleNum) {
        this.newArticleNum = newArticleNum;
    }


    
    /**
     * Integer emphasisNum을 반환
     * @return Integer emphasisNum
     */
    public Integer getEmphasisNum() {
        return emphasisNum;
    }


    
    /**
     * emphasisNum을 설정
     * @param emphasisNum 을(를) Integer emphasisNum로 설정
     */
    public void setEmphasisNum(Integer emphasisNum) {
        this.emphasisNum = emphasisNum;
    }


    
    /**
     * Integer registerIndictCd을 반환
     * @return Integer registerIndictCd
     */
    public Integer getRegisterIndictCd() {
        return registerIndictCd;
    }


    
    /**
     * registerIndictCd을 설정
     * @param registerIndictCd 을(를) Integer registerIndictCd로 설정
     */
    public void setRegisterIndictCd(Integer registerIndictCd) {
        this.registerIndictCd = registerIndictCd;
    }


    
    /**
     * String feedYn을 반환
     * @return String feedYn
     */
    public String getFeedYn() {
        return feedYn;
    }


    
    /**
     * feedYn을 설정
     * @param feedYn 을(를) String feedYn로 설정
     */
    public void setFeedYn(String feedYn) {
        this.feedYn = feedYn;
    }


    
    /**
     * Integer q_domain_cd을 반환
     * @return Integer q_domain_cd
     */
    public Integer getQ_domain_cd() {
        return q_domain_cd;
    }


    
    /**
     * q_domain_cd을 설정
     * @param q_domain_cd 을(를) Integer q_domain_cd로 설정
     */
    public void setQ_domain_cd(Integer q_domain_cd) {
        this.q_domain_cd = q_domain_cd;
    }


    
    /**
     * String mngrEditorYn을 반환
     * @return String mngrEditorYn
     */
    public String getMngrEditorYn() {
        return mngrEditorYn;
    }


    
    /**
     * mngrEditorYn을 설정
     * @param mngrEditorYn 을(를) String mngrEditorYn로 설정
     */
    public void setMngrEditorYn(String mngrEditorYn) {
        this.mngrEditorYn = mngrEditorYn;
    }


    
    /**
     * String fileYn을 반환
     * @return String fileYn
     */
    public String getFileYn() {
        return fileYn;
    }


    
    /**
     * fileYn을 설정
     * @param fileYn 을(를) String fileYn로 설정
     */
    public void setFileYn(String fileYn) {
        this.fileYn = fileYn;
    }


    
    /**
     * Integer uploadTy을 반환
     * @return Integer uploadTy
     */
    public Integer getUploadTy() {
        return uploadTy;
    }


    
    /**
     * uploadTy을 설정
     * @param uploadTy 을(를) Integer uploadTy로 설정
     */
    public void setUploadTy(Integer uploadTy) {
        this.uploadTy = uploadTy;
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
     * String filePermExtsn을 반환
     * @return String filePermExtsn
     */
    public String getFilePermExtsn() {
        return filePermExtsn;
    }


    
    /**
     * filePermExtsn을 설정
     * @param filePermExtsn 을(를) String filePermExtsn로 설정
     */
    public void setFilePermExtsn(String filePermExtsn) {
        this.filePermExtsn = filePermExtsn;
    }


    
    /**
     * String captchaYn을 반환
     * @return String captchaYn
     */
    public String getCaptchaYn() {
        return captchaYn;
    }


    
    /**
     * captchaYn을 설정
     * @param captchaYn 을(를) String captchaYn로 설정
     */
    public void setCaptchaYn(String captchaYn) {
        this.captchaYn = captchaYn;
    }


    
    /**
     * String othbcYn을 반환
     * @return String othbcYn
     */
    public String getOthbcYn() {
        return othbcYn;
    }


    
    /**
     * othbcYn을 설정
     * @param othbcYn 을(를) String othbcYn로 설정
     */
    public void setOthbcYn(String othbcYn) {
        this.othbcYn = othbcYn;
    }


    
    /**
     * String bannedWordYn을 반환
     * @return String bannedWordYn
     */
    public String getBannedWordYn() {
        return bannedWordYn;
    }


    
    /**
     * bannedWordYn을 설정
     * @param bannedWordYn 을(를) String bannedWordYn로 설정
     */
    public void setBannedWordYn(String bannedWordYn) {
        this.bannedWordYn = bannedWordYn;
    }


    
    /**
     * String bannedWordCn을 반환
     * @return String bannedWordCn
     */
    public String getBannedWordCn() {
        return bannedWordCn;
    }


    
    /**
     * bannedWordCn을 설정
     * @param bannedWordCn 을(를) String bannedWordCn로 설정
     */
    public void setBannedWordCn(String bannedWordCn) {
        this.bannedWordCn = bannedWordCn;
    }


    
    /**
     * String userEditorYn을 반환
     * @return String userEditorYn
     */
    public String getUserEditorYn() {
        return userEditorYn;
    }


    
    /**
     * userEditorYn을 설정
     * @param userEditorYn 을(를) String userEditorYn로 설정
     */
    public void setUserEditorYn(String userEditorYn) {
        this.userEditorYn = userEditorYn;
    }


    
    /**
     * Integer listViewCd을 반환
     * @return Integer listViewCd
     */
    public Integer getListViewCd() {
        return listViewCd;
    }


    
    /**
     * listViewCd을 설정
     * @param listViewCd 을(를) Integer listViewCd로 설정
     */
    public void setListViewCd(Integer listViewCd) {
        this.listViewCd = listViewCd;
    }


    
    /**
     * String recomendYn을 반환
     * @return String recomendYn
     */
    public String getRecomendYn() {
        return recomendYn;
    }


    
    /**
     * recomendYn을 설정
     * @param recomendYn 을(를) String recomendYn로 설정
     */
    public void setRecomendYn(String recomendYn) {
        this.recomendYn = recomendYn;
    }


    
    /**
     * String accuseYn을 반환
     * @return String accuseYn
     */
    public String getAccuseYn() {
        return accuseYn;
    }


    
    /**
     * accuseYn을 설정
     * @param accuseYn 을(를) String accuseYn로 설정
     */
    public void setAccuseYn(String accuseYn) {
        this.accuseYn = accuseYn;
    }


    
    /**
     * String stsfdgYn을 반환
     * @return String stsfdgYn
     */
    public String getStsfdgYn() {
        return stsfdgYn;
    }


    
    /**
     * stsfdgYn을 설정
     * @param stsfdgYn 을(를) String stsfdgYn로 설정
     */
    public void setStsfdgYn(String stsfdgYn) {
        this.stsfdgYn = stsfdgYn;
    }


    
    /**
     * Integer rdcntIncrsLmttTime을 반환
     * @return Integer rdcntIncrsLmttTime
     */
    public Integer getRdcntIncrsLmttTime() {
        return rdcntIncrsLmttTime;
    }


    
    /**
     * rdcntIncrsLmttTime을 설정
     * @param rdcntIncrsLmttTime 을(를) Integer rdcntIncrsLmttTime로 설정
     */
    public void setRdcntIncrsLmttTime(Integer rdcntIncrsLmttTime) {
        this.rdcntIncrsLmttTime = rdcntIncrsLmttTime;
    }


    
    /**
     * String tagYn을 반환
     * @return String tagYn
     */
    public String getTagYn() {
        return tagYn;
    }


    
    /**
     * tagYn을 설정
     * @param tagYn 을(를) String tagYn로 설정
     */
    public void setTagYn(String tagYn) {
        this.tagYn = tagYn;
    }


    
    /**
     * String domainNm을 반환
     * @return String domainNm
     */
    public String getDomainNm() {
        return domainNm;
    }


    
    /**
     * domainNm을 설정
     * @param domainNm 을(를) String domainNm로 설정
     */
    public void setDomainNm(String domainNm) {
        this.domainNm = domainNm;
    }


    
    /**
     * String domainDeleteAt을 반환
     * @return String domainDeleteAt
     */
    public String getDomainDeleteAt() {
        return domainDeleteAt;
    }


    
    /**
     * domainDeleteAt을 설정
     * @param domainDeleteAt 을(를) String domainDeleteAt로 설정
     */
    public void setDomainDeleteAt(String domainDeleteAt) {
        this.domainDeleteAt = domainDeleteAt;
    }


    
    /**
     * List<BoardConfVO> productList을 반환
     * @return List<BoardConfVO> productList
     */
    public List<BoardConfVO> getProductList() {
        return productList;
    }


    
    /**
     * productList을 설정
     * @param productList 을(를) List<BoardConfVO> productList로 설정
     */
    public void setProductList(List<BoardConfVO> productList) {
        this.productList = productList;
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
    

}
