/*
 * Copyright (c) 2012 OMP Inc. All rights reserved.
 * This software is the confidential and proprietary information of OMP Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with OMP Inc. 
 */
package zes.openworks.intra.cmMgmt.cmManage;

import java.util.List;

import zes.base.vo.PaggingVO;
import zes.openworks.intra.cmMgmt.cmManageBoard.CmManageBoardVO;


/**
 * 
 *
 * @version 1.0
 * @since OpenMarketPlace 프로젝트. (After JDK 1.6)
 * @author 오픈마켓플레이스
 *<pre>
 *<< 개정이력(Modification Information) >>
 *   
 *    수정일       	수정자   	수정내용
 *--------------		--------  	-------------------------------
 * 2014. 10. 14.    		SON.H.S       	신규
 *</pre>
 * @see
 */
public class CmManageVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 7613266357130218482L;
    
    /** ********************** TCM_CMNT_INFO_I********************** */
    /**  사용자아이디  */
    private String userId;
    /**  사용자 이름  */
    private String userNm;
    /**  언어코드  */
    private String langCode;
    /**  언어명  */
    private String langNm;
    
    /** 언어 영문명 */
    private String langEngNm;
    /**  커뮤니티아이디  */
    private String cmmntyId;
    /**  로고타이틀번호  */
    private Integer logoTitleNo;
    /**  커뮤니티URL  */
    private String cmmntyUrl;
    /**  커뮤니티명  */
    private String cmmntyNm;
    /**  커뮤니티설명  */
    private String cmmntyDc;
    /**  커뮤니티카테고리코드  */
    private Integer cmmntyCtgryCd;
    /**  커뮤니티카테고리명  */
    private String cmmntyCtgryNm;
    /**  커뮤니티가입방식  */
    private String cmmntySbscrbMthd;
    /**  로고파일일련  */
    private Integer logoFileSeq = -1;
    /**  로고파일경로  */
    private String logoFileUrl;
    /**  로고파일경로  */
    private String defaultLogoFileUrl;
    /**  로고타이틀  */
    private String logoTitle;
    /**  로고타이틀가로위치  */
    private Integer logoTitleWidthLc;
    /**  로고타이틀세로위치  */
    private Integer logoTitleVrticlLc;
    /**  로고타이글꼴  */
    private String logoTitleFont;
    /**  로고타이글꼴 크기 */
    private Integer logoTitleFontSize;
    /**  로고타이틀색상  */
    private String logoTitleColor;
    /**  개설신청일시  */
    private String estblReqstDt;
    /**  개설신청자아이디  */
    private String estblReqstId;
    /**  개설신청자 이름  */
    private String estblReqstNm;
    /**  개설신청사유  */
    private String estblReqstResn;
    /**  승인거절사유  */
    private String confmRejectResn;
    /**  커뮤니티상태코드  */
    private Integer cmmntySttusCd;
    /**  커뮤니티상태명  */
    private String cmmntySttusNm;
    /**  커뮤니티폐쇄신청일시  */
    private String cmmntyClsReqstDt;
    /**  커뮤니티폐쇄일시  */
    private String cmmntyClsDt;
    /**  커뮤니티폐쇄일시 전일 */
    private String cmmntyBeforeClsDt;
    

    /**  커뮤니티폐쇄아이디  */
    private String cmmntyClsId;
    /**  커뮤니티폐쇄 신청자 이름  */
    private String cmmntyClsUserNm;
    /**  커뮤니티폐쇄 관리자 이름  */
    private String cmmntyClsManagerNm;
    /**  커뮤니티폐쇄사유  */
    private String cmmntyClsResn;
    /**  관리자폐쇄여부  */
    private String mngrClsAt;
    /**  수정자아이디  */
    private String updtId;
    /**  수정일시  */
    private String updtDt;
    /**  커뮤니티 중복 체크  */
    private String cmNmUrlCheck;
    /** 로고파일 직접 등록 여부 */
    private String logoDirectRegistAt;
    /**  승인일  */
    private String confmDt;
    
    /** ********************** TCM_CMNT_MBER_I********************** */
    /**  커뮤니티회원아이디  */
    private String cmmntyMberId;
    /**  닉네임  */
    private String ncnm;
    /**  회원상태  */
    private Integer mberStateCd;
    /**  회원상태명  */
    private String mberStateNm;
    /**  가입거절사유  */
    private String sbscrbRejectResn;
    /**  가입신청일시  */
    private String sbscrbReqstDt;
    /**  가입승인일시  */
    private String sbscrbConfmDt;
    /**  강제탈퇴코드  */
    private Integer enfrcSecsnCd;
    /**  강제탈퇴코드 명 */
    private String enfrcSecsnNm;
    
    /**  가입거절일시  */
   private String sbscrbRejectDt;
      /**  탈퇴일시  */
   private String secsnDt;
   
   private String idOthbcAt;                
   private String nmOthbcAt;           
   private String telnoOthbcAt;            
   private String mbtlnumOthbcAt;      
   private String emailOthbcAt;       
   private String cmpnyNmOthbcAt;      
   private String reprsntTelnoOthbcAt; 
   private String cmpnyEmailOthbcAt;  
   
    /** **********************  TCM_MBER_MENU_M  ********************** */
    /**  커뮤니티메뉴코드  */
    private String cmmntyMenuCode;
    /**  커뮤니티메뉴코드 멀티  */
    private List <String> cmmntyMenuMultiCode;
    /**  메뉴게시판구분  */
    private String menuBbsSe;
    /**  필수메뉴가부  */
    private String essntlMenuAt;
    /**  정렬순서  */
    private Integer sortOrdr;
    /**  커뮤니티메뉴폴더명  */
    private String cmmntyMenuFolderNm;
    /**  커뮤니티메뉴URL  */
    private String cmmntyMenuUrl;
    /**  커뮤니티메뉴명  */
    private String cmmntyMenuNm;
    /**  커뮤니티 멀티 메뉴명  */
    private List <String> cmmntyMenuMultiNm;
    
    /** 메뉴 추가**/
    private List <CmManageVO> cmMberMenuCollection;
    
    /**  메뉴성격코드  */
    private Integer menuCharctCd;
    /**  메뉴성격 명  */
    private String menuCharctNm;
    /**  커뮤니티게시판유형코드  */
    private Integer cmmntyBbsTyCd;
    /**  커뮤니티게시판유형 명  */
    private String cmmntyBbsTyNm;
    /**  커뮤니티게시판코드  */
    private Integer cmmntyBbsCd;
    
    /** ********************** OP_USER ********************** */
    
    /**  국가코드 - 410 한국 */
    private String nationCode;
    
    /**  사용자유형코드  */
    private Integer userTyCd;
    /**  사용자유형코드 명  */
    private String userTyNm;
    
    /**  사용자등급코드  */
    private String userGradCode;
    /**  사용자상태  */
    private Integer userSttusCd;
    /**  사용자상태 명 */
    private String userSttusNm;
    
    /**  전화번호  */
    private String telno;
    
    /**  휴대폰번호  */
    private String mbtlnum;
    /**  이메일  */
    private String email;
    
    /**  회원수  */
    private Integer cmMberCount;
    /** 커뮤니티 게시판 총글수 */
    private Integer cmBbsCount;
    /** 커뮤니티 게시판 총댓글수 */
    private Integer cmBbsCmtCount;
    
    /** 커뮤니티 회원 게시판 글수 */
    private Integer cmMberBbsCount;
    
    private Integer cmMberTopCount;
    private Integer cmBbsTopCount;
    /** 커뮤니티 회원 게시판 댓글수 */
    private Integer cmMberBbsCmtCount;
    /** 커뮤니티 메뉴 갯수 */
    private Integer cmmntyMenuCount;
    /**  일반회원 회사명  */
    private String userCmpnyNm;
    /**  일반회원 회사대표전화번호  */
    private String userCmpnyReprsntTelno;
    /**  기업회원 회사명  */
    private String entCmpnyNm;
    /**  일반회원 회사대표전화번호  */
    private String entCmpnyReprsntTelno;
    
    /** 국제전화번호 **/
    private String intrlTelno;
    /** ********************** TUM_SVC_STOR_I ********************** */
    /**  스토어 명  */
    private String langStoreNm;
    
    /** ********************** OP_USER_ENTRPRS_OPTION ********************** */

    /**  FAX수신동의코드  */
    private Integer faxRecptnAgreCd;
    /**  이메일수신동의코드  */
    private Integer emailRecptnAgreCd;
    /**  회사명  */
    private String cmpnyNm;
    /**  회사우편번호  */
    private String cmpnyZip;
    /**  회사기본주소  */
    private String cmpnyBassAdres;
    /**  회사상세주소  */
    private String cmpnyDetailAdres;
    /**  회사전화번호  */
    private String cmpnyTelno;
    /**  회사대표자명  */
    private String cmpnyRprsntvNm;
    /**  사업자등록번호  */
    private String bizrno;
    /**  회사대표전화번호  */
    private String cmpnyReprsntTelno;
    /**  회사팩스번호  */
    private String cmpnyFaxnum;
    /**  회사이메일  */
    private String cmpnyEmail;
    /**  회사URL  */
    private String cmpnyUrl;
    
    /** ********************** OP_USER_ENTRPRS_OPTION ********************** */

    /**  생년월일  */
    private String brthdy;
    /**  성별코드  */
    private Integer sexdstnCd;
    /**  양력음력윤달코드  */
    private Integer slrcldLrrLpnhCd;
    /**  SMS수신동의코드  */
    private Integer smsRecptnAgreCd;

    /** 멀티 체크박스 **/ 
    private List<String> ckMultiBox;
    private String multiCheck;
    /** 검색 추가 **/
    private String cmmntySttusCdNotIn;
    
    /** ********************** TCM_VSIT_ANAL_S ********************** */
    /**  방문세션아이디  */
    private String visitSesionId;
    /**  방문일시  */
    private String visitDt;
    /**  방문IP  */
    private String visitIp;
    
    
    
    /** ********************** TCM_PGE_ANAL_S ********************** */
    /**  접속세션아이디  */
    private String conectSesionId;
    /**  접속일시  */
    private String conectDt;
    /**  접속IP  */
    private String conectIp;
    /**  접속URL  */
    private String conectUrl;
    /**  페이지타이틀  */
    private String pgeTitle;
    /**  페이지조회수  */
    private Integer pgeRdcnt = 0;
    
    
    /** 방문수**/
    private Integer cmVisitCount;
    /** 게시판 목록 공개 설정 체크*/
    private String othbcSetupCdChk;
    
    
    /** 사용자 메인 페이지 게시판 **/
    private List <CmManageBoardVO> cmUserMainBoardCollection;
    
    private String mngrEmail;      
    private String mngrNm;        
    private String mngrId;           

    
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
     * Integer logoTitleNo을 반환
     * @return Integer logoTitleNo
     */
    public Integer getLogoTitleNo() {
        return logoTitleNo;
    }
    
    /**
     * logoTitleNo을 설정
     * @param logoTitleNo 을(를) Integer logoTitleNo로 설정
     */
    public void setLogoTitleNo(Integer logoTitleNo) {
        this.logoTitleNo = logoTitleNo;
    }
    
    /**
     * String cmmntyUrl을 반환
     * @return String cmmntyUrl
     */
    public String getCmmntyUrl() {
        return cmmntyUrl;
    }
    
    /**
     * cmmntyUrl을 설정
     * @param cmmntyUrl 을(를) String cmmntyUrl로 설정
     */
    public void setCmmntyUrl(String cmmntyUrl) {
        this.cmmntyUrl = cmmntyUrl;
    }
    
    /**
     * String cmmntyNm을 반환
     * @return String cmmntyNm
     */
    public String getCmmntyNm() {
        return cmmntyNm;
    }
    
    /**
     * cmmntyNm을 설정
     * @param cmmntyNm 을(를) String cmmntyNm로 설정
     */
    public void setCmmntyNm(String cmmntyNm) {
        this.cmmntyNm = cmmntyNm;
    }
    
    /**
     * String cmmntyDc을 반환
     * @return String cmmntyDc
     */
    public String getCmmntyDc() {
        return cmmntyDc;
    }
    
    /**
     * cmmntyDc을 설정
     * @param cmmntyDc 을(를) String cmmntyDc로 설정
     */
    public void setCmmntyDc(String cmmntyDc) {
        this.cmmntyDc = cmmntyDc;
    }
    
    /**
     * Integer cmmntyCtgryCd을 반환
     * @return Integer cmmntyCtgryCd
     */
    public Integer getCmmntyCtgryCd() {
        return cmmntyCtgryCd;
    }
    
    /**
     * cmmntyCtgryCd을 설정
     * @param cmmntyCtgryCd 을(를) Integer cmmntyCtgryCd로 설정
     */
    public void setCmmntyCtgryCd(Integer cmmntyCtgryCd) {
        this.cmmntyCtgryCd = cmmntyCtgryCd;
    }
    
    /**
     * String cmmntySbscrbMthd을 반환
     * @return String cmmntySbscrbMthd
     */
    public String getCmmntySbscrbMthd() {
        return cmmntySbscrbMthd;
    }
    
    /**
     * cmmntySbscrbMthd을 설정
     * @param cmmntySbscrbMthd 을(를) String cmmntySbscrbMthd로 설정
     */
    public void setCmmntySbscrbMthd(String cmmntySbscrbMthd) {
        this.cmmntySbscrbMthd = cmmntySbscrbMthd;
    }
    
    /**
     * Integer logoFileSeq을 반환
     * @return Integer logoFileSeq
     */
    public Integer getLogoFileSeq() {
        return logoFileSeq;
    }
    
    /**
     * logoFileSeq을 설정
     * @param logoFileSeq 을(를) Integer logoFileSeq로 설정
     */
    public void setLogoFileSeq(Integer logoFileSeq) {
        this.logoFileSeq = logoFileSeq;
    }
    
    /**
     * Integer logoTitleWidthLc을 반환
     * @return Integer logoTitleWidthLc
     */
    public Integer getLogoTitleWidthLc() {
        return logoTitleWidthLc;
    }
    
    /**
     * logoTitleWidthLc을 설정
     * @param logoTitleWidthLc 을(를) Integer logoTitleWidthLc로 설정
     */
    public void setLogoTitleWidthLc(Integer logoTitleWidthLc) {
        this.logoTitleWidthLc = logoTitleWidthLc;
    }
    
    /**
     * Integer logoTitleVrticlLc을 반환
     * @return Integer logoTitleVrticlLc
     */
    public Integer getLogoTitleVrticlLc() {
        return logoTitleVrticlLc;
    }
    
    /**
     * logoTitleVrticlLc을 설정
     * @param logoTitleVrticlLc 을(를) Integer logoTitleVrticlLc로 설정
     */
    public void setLogoTitleVrticlLc(Integer logoTitleVrticlLc) {
        this.logoTitleVrticlLc = logoTitleVrticlLc;
    }
    
    /**
     * Integer logoTitleFont을 반환
     * @return Integer logoTitleFont
     */
    public String getLogoTitleFont() {
        return logoTitleFont;
    }
    
    /**
     * logoTitleFont을 설정
     * @param logoTitleFont 을(를) Integer logoTitleFont로 설정
     */
    public void setLogoTitleFont(String logoTitleFont) {
        this.logoTitleFont = logoTitleFont;
    }
    
    /**
     * String logoTitleColor을 반환
     * @return String logoTitleColor
     */
    public String getLogoTitleColor() {
        return logoTitleColor;
    }
    
    /**
     * logoTitleColor을 설정
     * @param logoTitleColor 을(를) String logoTitleColor로 설정
     */
    public void setLogoTitleColor(String logoTitleColor) {
        this.logoTitleColor = logoTitleColor;
    }
    
    /**
     * String estblReqstDt을 반환
     * @return String estblReqstDt
     */
    public String getEstblReqstDt() {
        return estblReqstDt;
    }
    
    /**
     * estblReqstDt을 설정
     * @param estblReqstDt 을(를) String estblReqstDt로 설정
     */
    public void setEstblReqstDt(String estblReqstDt) {
        this.estblReqstDt = estblReqstDt;
    }
    
    /**
     * String estblReqstId을 반환
     * @return String estblReqstId
     */
    public String getEstblReqstId() {
        return estblReqstId;
    }
    
    /**
     * estblReqstId을 설정
     * @param estblReqstId 을(를) String estblReqstId로 설정
     */
    public void setEstblReqstId(String estblReqstId) {
        this.estblReqstId = estblReqstId;
    }
    
    /**
     * String estblReqstResn을 반환
     * @return String estblReqstResn
     */
    public String getEstblReqstResn() {
        return estblReqstResn;
    }
    
    /**
     * estblReqstResn을 설정
     * @param estblReqstResn 을(를) String estblReqstResn로 설정
     */
    public void setEstblReqstResn(String estblReqstResn) {
        this.estblReqstResn = estblReqstResn;
    }
    
    /**
     * String confmRejectResn을 반환
     * @return String confmRejectResn
     */
    public String getConfmRejectResn() {
        return confmRejectResn;
    }
    
    /**
     * confmRejectResn을 설정
     * @param confmRejectResn 을(를) String confmRejectResn로 설정
     */
    public void setConfmRejectResn(String confmRejectResn) {
        this.confmRejectResn = confmRejectResn;
    }
    
    /**
     * Integer cmmntySttusCd을 반환
     * @return Integer cmmntySttusCd
     */
    public Integer getCmmntySttusCd() {
        return cmmntySttusCd;
    }
    
    /**
     * cmmntySttusCd을 설정
     * @param cmmntySttusCd 을(를) Integer cmmntySttusCd로 설정
     */
    public void setCmmntySttusCd(Integer cmmntySttusCd) {
        this.cmmntySttusCd = cmmntySttusCd;
    }
    
    /**
     * String cmmntyClsReqstDt을 반환
     * @return String cmmntyClsReqstDt
     */
    public String getCmmntyClsReqstDt() {
        return cmmntyClsReqstDt;
    }
    
    /**
     * cmmntyClsReqstDt을 설정
     * @param cmmntyClsReqstDt 을(를) String cmmntyClsReqstDt로 설정
     */
    public void setCmmntyClsReqstDt(String cmmntyClsReqstDt) {
        this.cmmntyClsReqstDt = cmmntyClsReqstDt;
    }
    
    /**
     * String cmmntyClsDt을 반환
     * @return String cmmntyClsDt
     */
    public String getCmmntyClsDt() {
        return cmmntyClsDt;
    }
    
    /**
     * cmmntyClsDt을 설정
     * @param cmmntyClsDt 을(를) String cmmntyClsDt로 설정
     */
    public void setCmmntyClsDt(String cmmntyClsDt) {
        this.cmmntyClsDt = cmmntyClsDt;
    }
    
    /**
     * String cmmntyClsId을 반환
     * @return String cmmntyClsId
     */
    public String getCmmntyClsId() {
        return cmmntyClsId;
    }
    
    /**
     * cmmntyClsId을 설정
     * @param cmmntyClsId 을(를) String cmmntyClsId로 설정
     */
    public void setCmmntyClsId(String cmmntyClsId) {
        this.cmmntyClsId = cmmntyClsId;
    }
    
    /**
     * String cmmntyClsResn을 반환
     * @return String cmmntyClsResn
     */
    public String getCmmntyClsResn() {
        return cmmntyClsResn;
    }
    
    /**
     * cmmntyClsResn을 설정
     * @param cmmntyClsResn 을(를) String cmmntyClsResn로 설정
     */
    public void setCmmntyClsResn(String cmmntyClsResn) {
        this.cmmntyClsResn = cmmntyClsResn;
    }
    
    /**
     * String mngrClsAt을 반환
     * @return String mngrClsAt
     */
    public String getMngrClsAt() {
        return mngrClsAt;
    }
    
    /**
     * mngrClsAt을 설정
     * @param mngrClsAt 을(를) String mngrClsAt로 설정
     */
    public void setMngrClsAt(String mngrClsAt) {
        this.mngrClsAt = mngrClsAt;
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
     * String cmmntyMberId을 반환
     * @return String cmmntyMberId
     */
    public String getCmmntyMberId() {
        return cmmntyMberId;
    }

    
    /**
     * cmmntyMberId을 설정
     * @param cmmntyMberId 을(를) String cmmntyMberId로 설정
     */
    public void setCmmntyMberId(String cmmntyMberId) {
        this.cmmntyMberId = cmmntyMberId;
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
     * Integer mberStateCd을 반환
     * @return Integer mberStateCd
     */
    public Integer getMberStateCd() {
        return mberStateCd;
    }

    
    /**
     * mberStateCd을 설정
     * @param mberStateCd 을(를) Integer mberStateCd로 설정
     */
    public void setMberStateCd(Integer mberStateCd) {
        this.mberStateCd = mberStateCd;
    }

    
    /**
     * String sbscrbRejectResn을 반환
     * @return String sbscrbRejectResn
     */
    public String getSbscrbRejectResn() {
        return sbscrbRejectResn;
    }

    
    /**
     * sbscrbRejectResn을 설정
     * @param sbscrbRejectResn 을(를) String sbscrbRejectResn로 설정
     */
    public void setSbscrbRejectResn(String sbscrbRejectResn) {
        this.sbscrbRejectResn = sbscrbRejectResn;
    }

    
    /**
     * String sbscrbReqstDt을 반환
     * @return String sbscrbReqstDt
     */
    public String getSbscrbReqstDt() {
        return sbscrbReqstDt;
    }

    
    /**
     * sbscrbReqstDt을 설정
     * @param sbscrbReqstDt 을(를) String sbscrbReqstDt로 설정
     */
    public void setSbscrbReqstDt(String sbscrbReqstDt) {
        this.sbscrbReqstDt = sbscrbReqstDt;
    }

    
    /**
     * String sbscrbConfmDt을 반환
     * @return String sbscrbConfmDt
     */
    public String getSbscrbConfmDt() {
        return sbscrbConfmDt;
    }

    
    /**
     * sbscrbConfmDt을 설정
     * @param sbscrbConfmDt 을(를) String sbscrbConfmDt로 설정
     */
    public void setSbscrbConfmDt(String sbscrbConfmDt) {
        this.sbscrbConfmDt = sbscrbConfmDt;
    }

    
    /**
     * Integer enfrcSecsnCd을 반환
     * @return Integer enfrcSecsnCd
     */
    public Integer getEnfrcSecsnCd() {
        return enfrcSecsnCd;
    }

    
    /**
     * enfrcSecsnCd을 설정
     * @param enfrcSecsnCd 을(를) Integer enfrcSecsnCd로 설정
     */
    public void setEnfrcSecsnCd(Integer enfrcSecsnCd) {
        this.enfrcSecsnCd = enfrcSecsnCd;
    }

    
    /**
     * String langNm을 반환
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    
    /**
     * langNm을 설정
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }

    
    /**
     * String cmmntyCtgryNm을 반환
     * @return String cmmntyCtgryNm
     */
    public String getCmmntyCtgryNm() {
        return cmmntyCtgryNm;
    }

    
    /**
     * cmmntyCtgryNm을 설정
     * @param cmmntyCtgryNm 을(를) String cmmntyCtgryNm로 설정
     */
    public void setCmmntyCtgryNm(String cmmntyCtgryNm) {
        this.cmmntyCtgryNm = cmmntyCtgryNm;
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

    
    /**
     * String userGradCode을 반환
     * @return String userGradCode
     */
    public String getUserGradCode() {
        return userGradCode;
    }

    
    /**
     * userGradCode을 설정
     * @param userGradCode 을(를) String userGradCode로 설정
     */
    public void setUserGradCode(String userGradCode) {
        this.userGradCode = userGradCode;
    }

    
    /**
     * Integer userSttusCd을 반환
     * @return Integer userSttusCd
     */
    public Integer getUserSttusCd() {
        return userSttusCd;
    }

    
    /**
     * userSttusCd을 설정
     * @param userSttusCd 을(를) Integer userSttusCd로 설정
     */
    public void setUserSttusCd(Integer userSttusCd) {
        this.userSttusCd = userSttusCd;
    }

    
    /**
     * Integer cmMberCount을 반환
     * @return Integer cmMberCount
     */
    public Integer getCmMberCount() {
        return cmMberCount;
    }

    
    /**
     * cmMberCount을 설정
     * @param cmMberCount 을(를) Integer cmMberCount로 설정
     */
    public void setCmMberCount(Integer cmMberCount) {
        this.cmMberCount = cmMberCount;
    }

    
    /**
     * String telno을 반환
     * @return String telno
     */
    public String getTelno() {
        return telno;
    }

    
    /**
     * telno을 설정
     * @param telno 을(를) String telno로 설정
     */
    public void setTelno(String telno) {
        this.telno = telno;
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
     * String userCmpnyNm을 반환
     * @return String userCmpnyNm
     */
    public String getUserCmpnyNm() {
        return userCmpnyNm;
    }

    
    /**
     * userCmpnyNm을 설정
     * @param userCmpnyNm 을(를) String userCmpnyNm로 설정
     */
    public void setUserCmpnyNm(String userCmpnyNm) {
        this.userCmpnyNm = userCmpnyNm;
    }

    
    /**
     * String userCmpnyReprsntTelno을 반환
     * @return String userCmpnyReprsntTelno
     */
    public String getUserCmpnyReprsntTelno() {
        return userCmpnyReprsntTelno;
    }

    
    /**
     * userCmpnyReprsntTelno을 설정
     * @param userCmpnyReprsntTelno 을(를) String userCmpnyReprsntTelno로 설정
     */
    public void setUserCmpnyReprsntTelno(String userCmpnyReprsntTelno) {
        this.userCmpnyReprsntTelno = userCmpnyReprsntTelno;
    }

    
    /**
     * String entCmpnyNm을 반환
     * @return String entCmpnyNm
     */
    public String getEntCmpnyNm() {
        return entCmpnyNm;
    }

    
    /**
     * entCmpnyNm을 설정
     * @param entCmpnyNm 을(를) String entCmpnyNm로 설정
     */
    public void setEntCmpnyNm(String entCmpnyNm) {
        this.entCmpnyNm = entCmpnyNm;
    }

    
    /**
     * String entCmpnyReprsntTelno을 반환
     * @return String entCmpnyReprsntTelno
     */
    public String getEntCmpnyReprsntTelno() {
        return entCmpnyReprsntTelno;
    }

    
    /**
     * entCmpnyReprsntTelno을 설정
     * @param entCmpnyReprsntTelno 을(를) String entCmpnyReprsntTelno로 설정
     */
    public void setEntCmpnyReprsntTelno(String entCmpnyReprsntTelno) {
        this.entCmpnyReprsntTelno = entCmpnyReprsntTelno;
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
     * String logoFileUrl을 반환
     * @return String logoFileUrl
     */
    public String getLogoFileUrl() {
        return logoFileUrl;
    }

    
    /**
     * logoFileUrl을 설정
     * @param logoFileUrl 을(를) String logoFileUrl로 설정
     */
    public void setLogoFileUrl(String logoFileUrl) {
        this.logoFileUrl = logoFileUrl;
    }

    
    /**
     * Integer logoTitle을 반환
     * @return Integer logoTitle
     */
    public String getLogoTitle() {
        return logoTitle;
    }

    
    /**
     * logoTitle을 설정
     * @param logoTitle 을(를) Integer logoTitle로 설정
     */
    public void setLogoTitle(String logoTitle) {
        this.logoTitle = logoTitle;
    }

    
    /**
     * Integer logoTitleFontSize을 반환
     * @return Integer logoTitleFontSize
     */
    public Integer getLogoTitleFontSize() {
        return logoTitleFontSize;
    }

    
    /**
     * logoTitleFontSize을 설정
     * @param logoTitleFontSize 을(를) Integer logoTitleFontSize로 설정
     */
    public void setLogoTitleFontSize(Integer logoTitleFontSize) {
        this.logoTitleFontSize = logoTitleFontSize;
    }

    
    /**
     * String cmNmUrlCheck을 반환
     * @return String cmNmUrlCheck
     */
    public String getCmNmUrlCheck() {
        return cmNmUrlCheck;
    }

    
    /**
     * cmNmUrlCheck을 설정
     * @param cmNmUrlCheck 을(를) String cmNmUrlCheck로 설정
     */
    public void setCmNmUrlCheck(String cmNmUrlCheck) {
        this.cmNmUrlCheck = cmNmUrlCheck;
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
     * String menuBbsSe을 반환
     * @return String menuBbsSe
     */
    public String getMenuBbsSe() {
        return menuBbsSe;
    }

    
    /**
     * menuBbsSe을 설정
     * @param menuBbsSe 을(를) String menuBbsSe로 설정
     */
    public void setMenuBbsSe(String menuBbsSe) {
        this.menuBbsSe = menuBbsSe;
    }

    
    /**
     * String essntlMenuAt을 반환
     * @return String essntlMenuAt
     */
    public String getEssntlMenuAt() {
        return essntlMenuAt;
    }

    
    /**
     * essntlMenuAt을 설정
     * @param essntlMenuAt 을(를) String essntlMenuAt로 설정
     */
    public void setEssntlMenuAt(String essntlMenuAt) {
        this.essntlMenuAt = essntlMenuAt;
    }

    
    /**
     * Integer sortOrdr을 반환
     * @return Integer sortOrdr
     */
    public Integer getSortOrdr() {
        return sortOrdr;
    }

    
    /**
     * sortOrdr을 설정
     * @param sortOrdr 을(를) Integer sortOrdr로 설정
     */
    public void setSortOrdr(Integer sortOrdr) {
        this.sortOrdr = sortOrdr;
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
     * String cmmntyMenuUrl을 반환
     * @return String cmmntyMenuUrl
     */
    public String getCmmntyMenuUrl() {
        return cmmntyMenuUrl;
    }

    
    /**
     * cmmntyMenuUrl을 설정
     * @param cmmntyMenuUrl 을(를) String cmmntyMenuUrl로 설정
     */
    public void setCmmntyMenuUrl(String cmmntyMenuUrl) {
        this.cmmntyMenuUrl = cmmntyMenuUrl;
    }

    
    /**
     * String cmmntyMenuNm을 반환
     * @return String cmmntyMenuNm
     */
    public String getCmmntyMenuNm() {
        return cmmntyMenuNm;
    }

    
    /**
     * cmmntyMenuNm을 설정
     * @param cmmntyMenuNm 을(를) String cmmntyMenuNm로 설정
     */
    public void setCmmntyMenuNm(String cmmntyMenuNm) {
        this.cmmntyMenuNm = cmmntyMenuNm;
    }

    
    /**
     * Integer menuCharctCd을 반환
     * @return Integer menuCharctCd
     */
    public Integer getMenuCharctCd() {
        return menuCharctCd;
    }

    
    /**
     * menuCharctCd을 설정
     * @param menuCharctCd 을(를) Integer menuCharctCd로 설정
     */
    public void setMenuCharctCd(Integer menuCharctCd) {
        this.menuCharctCd = menuCharctCd;
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
     * String logoDirectRegistAt을 반환
     * @return String logoDirectRegistAt
     */
    public String getLogoDirectRegistAt() {
        return logoDirectRegistAt;
    }

    
    /**
     * logoDirectRegistAt을 설정
     * @param logoDirectRegistAt 을(를) String logoDirectRegistAt로 설정
     */
    public void setLogoDirectRegistAt(String logoDirectRegistAt) {
        this.logoDirectRegistAt = logoDirectRegistAt;
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
     * Integer faxRecptnAgreCd을 반환
     * @return Integer faxRecptnAgreCd
     */
    public Integer getFaxRecptnAgreCd() {
        return faxRecptnAgreCd;
    }

    
    /**
     * faxRecptnAgreCd을 설정
     * @param faxRecptnAgreCd 을(를) Integer faxRecptnAgreCd로 설정
     */
    public void setFaxRecptnAgreCd(Integer faxRecptnAgreCd) {
        this.faxRecptnAgreCd = faxRecptnAgreCd;
    }

    
    /**
     * Integer emailRecptnAgreCd을 반환
     * @return Integer emailRecptnAgreCd
     */
    public Integer getEmailRecptnAgreCd() {
        return emailRecptnAgreCd;
    }

    
    /**
     * emailRecptnAgreCd을 설정
     * @param emailRecptnAgreCd 을(를) Integer emailRecptnAgreCd로 설정
     */
    public void setEmailRecptnAgreCd(Integer emailRecptnAgreCd) {
        this.emailRecptnAgreCd = emailRecptnAgreCd;
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
     * String cmpnyZip을 반환
     * @return String cmpnyZip
     */
    public String getCmpnyZip() {
        return cmpnyZip;
    }

    
    /**
     * cmpnyZip을 설정
     * @param cmpnyZip 을(를) String cmpnyZip로 설정
     */
    public void setCmpnyZip(String cmpnyZip) {
        this.cmpnyZip = cmpnyZip;
    }

    
    /**
     * String cmpnyBassAdres을 반환
     * @return String cmpnyBassAdres
     */
    public String getCmpnyBassAdres() {
        return cmpnyBassAdres;
    }

    
    /**
     * cmpnyBassAdres을 설정
     * @param cmpnyBassAdres 을(를) String cmpnyBassAdres로 설정
     */
    public void setCmpnyBassAdres(String cmpnyBassAdres) {
        this.cmpnyBassAdres = cmpnyBassAdres;
    }

    
    /**
     * String cmpnyDetailAdres을 반환
     * @return String cmpnyDetailAdres
     */
    public String getCmpnyDetailAdres() {
        return cmpnyDetailAdres;
    }

    
    /**
     * cmpnyDetailAdres을 설정
     * @param cmpnyDetailAdres 을(를) String cmpnyDetailAdres로 설정
     */
    public void setCmpnyDetailAdres(String cmpnyDetailAdres) {
        this.cmpnyDetailAdres = cmpnyDetailAdres;
    }

    
    /**
     * String cmpnyTelno을 반환
     * @return String cmpnyTelno
     */
    public String getCmpnyTelno() {
        return cmpnyTelno;
    }

    
    /**
     * cmpnyTelno을 설정
     * @param cmpnyTelno 을(를) String cmpnyTelno로 설정
     */
    public void setCmpnyTelno(String cmpnyTelno) {
        this.cmpnyTelno = cmpnyTelno;
    }

    
    /**
     * String cmpnyRprsntvNm을 반환
     * @return String cmpnyRprsntvNm
     */
    public String getCmpnyRprsntvNm() {
        return cmpnyRprsntvNm;
    }

    
    /**
     * cmpnyRprsntvNm을 설정
     * @param cmpnyRprsntvNm 을(를) String cmpnyRprsntvNm로 설정
     */
    public void setCmpnyRprsntvNm(String cmpnyRprsntvNm) {
        this.cmpnyRprsntvNm = cmpnyRprsntvNm;
    }

    
    /**
     * String bizrno을 반환
     * @return String bizrno
     */
    public String getBizrno() {
        return bizrno;
    }

    
    /**
     * bizrno을 설정
     * @param bizrno 을(를) String bizrno로 설정
     */
    public void setBizrno(String bizrno) {
        this.bizrno = bizrno;
    }

    
    /**
     * String cmpnyReprsntTelno을 반환
     * @return String cmpnyReprsntTelno
     */
    public String getCmpnyReprsntTelno() {
        return cmpnyReprsntTelno;
    }

    
    /**
     * cmpnyReprsntTelno을 설정
     * @param cmpnyReprsntTelno 을(를) String cmpnyReprsntTelno로 설정
     */
    public void setCmpnyReprsntTelno(String cmpnyReprsntTelno) {
        this.cmpnyReprsntTelno = cmpnyReprsntTelno;
    }

    
    /**
     * String cmpnyFaxnum을 반환
     * @return String cmpnyFaxnum
     */
    public String getCmpnyFaxnum() {
        return cmpnyFaxnum;
    }

    
    /**
     * cmpnyFaxnum을 설정
     * @param cmpnyFaxnum 을(를) String cmpnyFaxnum로 설정
     */
    public void setCmpnyFaxnum(String cmpnyFaxnum) {
        this.cmpnyFaxnum = cmpnyFaxnum;
    }

    
    /**
     * String cmpnyEmail을 반환
     * @return String cmpnyEmail
     */
    public String getCmpnyEmail() {
        return cmpnyEmail;
    }

    
    /**
     * cmpnyEmail을 설정
     * @param cmpnyEmail 을(를) String cmpnyEmail로 설정
     */
    public void setCmpnyEmail(String cmpnyEmail) {
        this.cmpnyEmail = cmpnyEmail;
    }

    
    /**
     * String cmpnyUrl을 반환
     * @return String cmpnyUrl
     */
    public String getCmpnyUrl() {
        return cmpnyUrl;
    }

    
    /**
     * cmpnyUrl을 설정
     * @param cmpnyUrl 을(를) String cmpnyUrl로 설정
     */
    public void setCmpnyUrl(String cmpnyUrl) {
        this.cmpnyUrl = cmpnyUrl;
    }

    
    /**
     * String brthdy을 반환
     * @return String brthdy
     */
    public String getBrthdy() {
        return brthdy;
    }

    
    /**
     * brthdy을 설정
     * @param brthdy 을(를) String brthdy로 설정
     */
    public void setBrthdy(String brthdy) {
        this.brthdy = brthdy;
    }

    
    /**
     * Integer sexdstnCd을 반환
     * @return Integer sexdstnCd
     */
    public Integer getSexdstnCd() {
        return sexdstnCd;
    }

    
    /**
     * sexdstnCd을 설정
     * @param sexdstnCd 을(를) Integer sexdstnCd로 설정
     */
    public void setSexdstnCd(Integer sexdstnCd) {
        this.sexdstnCd = sexdstnCd;
    }

    
    /**
     * Integer slrcldLrrLpnhCd을 반환
     * @return Integer slrcldLrrLpnhCd
     */
    public Integer getSlrcldLrrLpnhCd() {
        return slrcldLrrLpnhCd;
    }

    
    /**
     * slrcldLrrLpnhCd을 설정
     * @param slrcldLrrLpnhCd 을(를) Integer slrcldLrrLpnhCd로 설정
     */
    public void setSlrcldLrrLpnhCd(Integer slrcldLrrLpnhCd) {
        this.slrcldLrrLpnhCd = slrcldLrrLpnhCd;
    }

    
    /**
     * Integer smsRecptnAgreCd을 반환
     * @return Integer smsRecptnAgreCd
     */
    public Integer getSmsRecptnAgreCd() {
        return smsRecptnAgreCd;
    }

    
    /**
     * smsRecptnAgreCd을 설정
     * @param smsRecptnAgreCd 을(를) Integer smsRecptnAgreCd로 설정
     */
    public void setSmsRecptnAgreCd(Integer smsRecptnAgreCd) {
        this.smsRecptnAgreCd = smsRecptnAgreCd;
    }

    
    /**
     * String userTyNm을 반환
     * @return String userTyNm
     */
    public String getUserTyNm() {
        return userTyNm;
    }

    
    /**
     * userTyNm을 설정
     * @param userTyNm 을(를) String userTyNm로 설정
     */
    public void setUserTyNm(String userTyNm) {
        this.userTyNm = userTyNm;
    }

    
    /**
     * String userSttusNm을 반환
     * @return String userSttusNm
     */
    public String getUserSttusNm() {
        return userSttusNm;
    }

    
    /**
     * userSttusNm을 설정
     * @param userSttusNm 을(를) String userSttusNm로 설정
     */
    public void setUserSttusNm(String userSttusNm) {
        this.userSttusNm = userSttusNm;
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
     * Integer cmBbsCount을 반환
     * @return Integer cmBbsCount
     */
    public Integer getCmBbsCount() {
        return cmBbsCount;
    }

    
    /**
     * cmBbsCount을 설정
     * @param cmBbsCount 을(를) Integer cmBbsCount로 설정
     */
    public void setCmBbsCount(Integer cmBbsCount) {
        this.cmBbsCount = cmBbsCount;
    }

    
    /**
     * String estblReqstNm을 반환
     * @return String estblReqstNm
     */
    public String getEstblReqstNm() {
        return estblReqstNm;
    }

    
    /**
     * estblReqstNm을 설정
     * @param estblReqstNm 을(를) String estblReqstNm로 설정
     */
    public void setEstblReqstNm(String estblReqstNm) {
        this.estblReqstNm = estblReqstNm;
    }

    
    /**
     * String cmmntyClsUserNm을 반환
     * @return String cmmntyClsUserNm
     */
    public String getCmmntyClsUserNm() {
        return cmmntyClsUserNm;
    }

    
    /**
     * cmmntyClsUserNm을 설정
     * @param cmmntyClsUserNm 을(를) String cmmntyClsUserNm로 설정
     */
    public void setCmmntyClsUserNm(String cmmntyClsUserNm) {
        this.cmmntyClsUserNm = cmmntyClsUserNm;
    }

    
    /**
     * String cmmntyClsManagerNm을 반환
     * @return String cmmntyClsManagerNm
     */
    public String getCmmntyClsManagerNm() {
        return cmmntyClsManagerNm;
    }

    
    /**
     * cmmntyClsManagerNm을 설정
     * @param cmmntyClsManagerNm 을(를) String cmmntyClsManagerNm로 설정
     */
    public void setCmmntyClsManagerNm(String cmmntyClsManagerNm) {
        this.cmmntyClsManagerNm = cmmntyClsManagerNm;
    }

    
    /**
     * String menuCharctNm을 반환
     * @return String menuCharctNm
     */
    public String getMenuCharctNm() {
        return menuCharctNm;
    }

    
    /**
     * menuCharct을 설정
     * @param menuCharct 을(를) Integer menuCharct로 설정
     */
    public void setMenuCharctNm(String menuCharctNm) {
        this.menuCharctNm = menuCharctNm;
    }

    
    /**
     * Integer cmmntyBbsTyNm을 반환
     * @return Integer cmmntyBbsTyNm
     */
    public String getCmmntyBbsTyNm() {
        return cmmntyBbsTyNm;
    }

    
    /**
     * cmmntyBbsTyNm을 설정
     * @param cmmntyBbsTyNm 을(를) Integer cmmntyBbsTyNm로 설정
     */
    public void setCmmntyBbsTyNm(String cmmntyBbsTyNm) {
        this.cmmntyBbsTyNm = cmmntyBbsTyNm;
    }

    
    /**
     * List<String> cmmntyMenuMultiNm을 반환
     * @return List<String> cmmntyMenuMultiNm
     */
    public List<String> getCmmntyMenuMultiNm() {
        return cmmntyMenuMultiNm;
    }

    
    /**
     * cmmntyMenuMultiNm을 설정
     * @param cmmntyMenuMultiNm 을(를) List<String> cmmntyMenuMultiNm로 설정
     */
    public void setCmmntyMenuMultiNm(List<String> cmmntyMenuMultiNm) {
        this.cmmntyMenuMultiNm = cmmntyMenuMultiNm;
    }

    
    /**
     * List<String> cmmntyMenuMultiCode을 반환
     * @return List<String> cmmntyMenuMultiCode
     */
    public List<String> getCmmntyMenuMultiCode() {
        return cmmntyMenuMultiCode;
    }

    
    /**
     * cmmntyMenuMultiCode을 설정
     * @param cmmntyMenuMultiCode 을(를) List<String> cmmntyMenuMultiCode로 설정
     */
    public void setCmmntyMenuMultiCode(List<String> cmmntyMenuMultiCode) {
        this.cmmntyMenuMultiCode = cmmntyMenuMultiCode;
    }

    
    /**
     * String cmmntySttusNm을 반환
     * @return String cmmntySttusNm
     */
    public String getCmmntySttusNm() {
        return cmmntySttusNm;
    }

    
    /**
     * cmmntySttusNm을 설정
     * @param cmmntySttusNm 을(를) String cmmntySttusNm로 설정
     */
    public void setCmmntySttusNm(String cmmntySttusNm) {
        this.cmmntySttusNm = cmmntySttusNm;
    }

    
    /**
     * String cmmntySttusCdNotIn을 반환
     * @return String cmmntySttusCdNotIn
     */
    public String getCmmntySttusCdNotIn() {
        return cmmntySttusCdNotIn;
    }

    
    /**
     * cmmntySttusCdNotIn을 설정
     * @param cmmntySttusCdNotIn 을(를) String cmmntySttusCdNotIn로 설정
     */
    public void setCmmntySttusCdNotIn(String cmmntySttusCdNotIn) {
        this.cmmntySttusCdNotIn = cmmntySttusCdNotIn;
    }

    
    /**
     * List<CmManageVO> cmMberMenuCollection을 반환
     * @return List<CmManageVO> cmMberMenuCollection
     */
    public List<CmManageVO> getCmMberMenuCollection() {
        return cmMberMenuCollection;
    }

    
    /**
     * cmMberMenuCollection을 설정
     * @param cmMberMenuCollection 을(를) List<CmManageVO> cmMberMenuCollection로 설정
     */
    public void setCmMberMenuCollection(List<CmManageVO> cmMberMenuCollection) {
        this.cmMberMenuCollection = cmMberMenuCollection;
    }

    
    /**
     * String sbscrbRejectDt을 반환
     * @return String sbscrbRejectDt
     */
    public String getSbscrbRejectDt() {
        return sbscrbRejectDt;
    }

    
    /**
     * sbscrbRejectDt을 설정
     * @param sbscrbRejectDt 을(를) String sbscrbRejectDt로 설정
     */
    public void setSbscrbRejectDt(String sbscrbRejectDt) {
        this.sbscrbRejectDt = sbscrbRejectDt;
    }

    
    /**
     * String secsnDt을 반환
     * @return String secsnDt
     */
    public String getSecsnDt() {
        return secsnDt;
    }

    
    /**
     * secsnDt을 설정
     * @param secsnDt 을(를) String secsnDt로 설정
     */
    public void setSecsnDt(String secsnDt) {
        this.secsnDt = secsnDt;
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
     * Integer cmMberBbsCount을 반환
     * @return Integer cmMberBbsCount
     */
    public Integer getCmMberBbsCount() {
        return cmMberBbsCount;
    }

    
    /**
     * cmMberBbsCount을 설정
     * @param cmMberBbsCount 을(를) Integer cmMberBbsCount로 설정
     */
    public void setCmMberBbsCount(Integer cmMberBbsCount) {
        this.cmMberBbsCount = cmMberBbsCount;
    }

    
    /**
     * Integer cmMberBbsCmtCount을 반환
     * @return Integer cmMberBbsCmtCount
     */
    public Integer getCmMberBbsCmtCount() {
        return cmMberBbsCmtCount;
    }

    
    /**
     * cmMberBbsCmtCount을 설정
     * @param cmMberBbsCmtCount 을(를) Integer cmMberBbsCmtCount로 설정
     */
    public void setCmMberBbsCmtCount(Integer cmMberBbsCmtCount) {
        this.cmMberBbsCmtCount = cmMberBbsCmtCount;
    }

    
    /**
     * String langEngNm을 반환
     * @return String langEngNm
     */
    public String getLangEngNm() {
        return langEngNm;
    }

    
    /**
     * langEngNm을 설정
     * @param langEngNm 을(를) String langEngNm로 설정
     */
    public void setLangEngNm(String langEngNm) {
        this.langEngNm = langEngNm;
    }

    
    /**
     * Integer cmmntyMenuCount을 반환
     * @return Integer cmmntyMenuCount
     */
    public Integer getCmmntyMenuCount() {
        return cmmntyMenuCount;
    }

    
    /**
     * cmmntyMenuCount을 설정
     * @param cmmntyMenuCount 을(를) Integer cmmntyMenuCount로 설정
     */
    public void setCmmntyMenuCount(Integer cmmntyMenuCount) {
        this.cmmntyMenuCount = cmmntyMenuCount;
    }

    
    /**
     * String enfrcSecsnNm을 반환
     * @return String enfrcSecsnNm
     */
    public String getEnfrcSecsnNm() {
        return enfrcSecsnNm;
    }

    
    /**
     * enfrcSecsnNm을 설정
     * @param enfrcSecsnNm 을(를) String enfrcSecsnNm로 설정
     */
    public void setEnfrcSecsnNm(String enfrcSecsnNm) {
        this.enfrcSecsnNm = enfrcSecsnNm;
    }

    
    /**
     * String visitSesionId을 반환
     * @return String visitSesionId
     */
    public String getVisitSesionId() {
        return visitSesionId;
    }

    
    /**
     * visitSesionId을 설정
     * @param visitSesionId 을(를) String visitSesionId로 설정
     */
    public void setVisitSesionId(String visitSesionId) {
        this.visitSesionId = visitSesionId;
    }

    
    /**
     * String visitDt을 반환
     * @return String visitDt
     */
    public String getVisitDt() {
        return visitDt;
    }

    
    /**
     * visitDt을 설정
     * @param visitDt 을(를) String visitDt로 설정
     */
    public void setVisitDt(String visitDt) {
        this.visitDt = visitDt;
    }

    
    /**
     * String visitIp을 반환
     * @return String visitIp
     */
    public String getVisitIp() {
        return visitIp;
    }

    
    /**
     * visitIp을 설정
     * @param visitIp 을(를) String visitIp로 설정
     */
    public void setVisitIp(String visitIp) {
        this.visitIp = visitIp;
    }

    
    /**
     * Integer cmVisitCount을 반환
     * @return Integer cmVisitCount
     */
    public Integer getCmVisitCount() {
        return cmVisitCount;
    }

    
    /**
     * cmVisitCount을 설정
     * @param cmVisitCount 을(를) Integer cmVisitCount로 설정
     */
    public void setCmVisitCount(Integer cmVisitCount) {
        this.cmVisitCount = cmVisitCount;
    }

    
    /**
     * String defaultLogoFileUrl을 반환
     * @return String defaultLogoFileUrl
     */
    public String getDefaultLogoFileUrl() {
        return defaultLogoFileUrl;
    }

    
    /**
     * defaultLogoFileUrl을 설정
     * @param defaultLogoFileUrl 을(를) String defaultLogoFileUrl로 설정
     */
    public void setDefaultLogoFileUrl(String defaultLogoFileUrl) {
        this.defaultLogoFileUrl = defaultLogoFileUrl;
    }

    
    /**
     * String nationCode을 반환
     * @return String nationCode
     */
    public String getNationCode() {
        return nationCode;
    }

    
    /**
     * nationCode을 설정
     * @param nationCode 을(를) String nationCode로 설정
     */
    public void setNationCode(String nationCode) {
        this.nationCode = nationCode;
    }

    
    /**
     * String confmDt을 반환
     * @return String confmDt
     */
    public String getConfmDt() {
        return confmDt;
    }

    
    /**
     * confmDt을 설정
     * @param confmDt 을(를) String confmDt로 설정
     */
    public void setConfmDt(String confmDt) {
        this.confmDt = confmDt;
    }

    
    
    /**
     * String cmmntyBeforeClsDt을 반환
     * @return String cmmntyBeforeClsDt
     */
    public String getCmmntyBeforeClsDt() {
        return cmmntyBeforeClsDt;
    }

    
    /**
     * cmmntyBeforeClsDt을 설정
     * @param cmmntyBeforeClsDt 을(를) String cmmntyBeforeClsDt로 설정
     */
    public void setCmmntyBeforeClsDt(String cmmntyBeforeClsDt) {
        this.cmmntyBeforeClsDt = cmmntyBeforeClsDt;
    }

    
    /**
     * String intrlTelno을 반환
     * @return String intrlTelno
     */
    public String getIntrlTelno() {
        return intrlTelno;
    }

    
    /**
     * intrlTelno을 설정
     * @param intrlTelno 을(를) String intrlTelno로 설정
     */
    public void setIntrlTelno(String intrlTelno) {
        this.intrlTelno = intrlTelno;
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
     * List<CmManageBoardVO> cmUserMainBoardCollection을 반환
     * @return List<CmManageBoardVO> cmUserMainBoardCollection
     */
    public List<CmManageBoardVO> getCmUserMainBoardCollection() {
        return cmUserMainBoardCollection;
    }

    
    /**
     * cmUserMainBoardCollection을 설정
     * @param cmUserMainBoardCollection 을(를) List<CmManageBoardVO> cmUserMainBoardCollection로 설정
     */
    public void setCmUserMainBoardCollection(List<CmManageBoardVO> cmUserMainBoardCollection) {
        this.cmUserMainBoardCollection = cmUserMainBoardCollection;
    }

    
    /**
     * String mberStateNm을 반환
     * @return String mberStateNm
     */
    public String getMberStateNm() {
        return mberStateNm;
    }

    
    /**
     * mberStateNm을 설정
     * @param mberStateNm 을(를) String mberStateNm로 설정
     */
    public void setMberStateNm(String mberStateNm) {
        this.mberStateNm = mberStateNm;
    }

    
    /**
     * String idOthbcAt을 반환
     * @return String idOthbcAt
     */
    public String getIdOthbcAt() {
        return idOthbcAt;
    }

    
    /**
     * idOthbcAt을 설정
     * @param idOthbcAt 을(를) String idOthbcAt로 설정
     */
    public void setIdOthbcAt(String idOthbcAt) {
        this.idOthbcAt = idOthbcAt;
    }

    
    /**
     * String nmOthbcAt을 반환
     * @return String nmOthbcAt
     */
    public String getNmOthbcAt() {
        return nmOthbcAt;
    }

    
    /**
     * nmOthbcAt을 설정
     * @param nmOthbcAt 을(를) String nmOthbcAt로 설정
     */
    public void setNmOthbcAt(String nmOthbcAt) {
        this.nmOthbcAt = nmOthbcAt;
    }

    
    /**
     * String telnoOthbcAt을 반환
     * @return String telnoOthbcAt
     */
    public String getTelnoOthbcAt() {
        return telnoOthbcAt;
    }

    
    /**
     * telnoOthbcAt을 설정
     * @param telnoOthbcAt 을(를) String telnoOthbcAt로 설정
     */
    public void setTelnoOthbcAt(String telnoOthbcAt) {
        this.telnoOthbcAt = telnoOthbcAt;
    }

    
    /**
     * String mbtlnumOthbcAt을 반환
     * @return String mbtlnumOthbcAt
     */
    public String getMbtlnumOthbcAt() {
        return mbtlnumOthbcAt;
    }

    
    /**
     * mbtlnumOthbcAt을 설정
     * @param mbtlnumOthbcAt 을(를) String mbtlnumOthbcAt로 설정
     */
    public void setMbtlnumOthbcAt(String mbtlnumOthbcAt) {
        this.mbtlnumOthbcAt = mbtlnumOthbcAt;
    }

    
    /**
     * String emailOthbcAt을 반환
     * @return String emailOthbcAt
     */
    public String getEmailOthbcAt() {
        return emailOthbcAt;
    }

    
    /**
     * emailOthbcAt을 설정
     * @param emailOthbcAt 을(를) String emailOthbcAt로 설정
     */
    public void setEmailOthbcAt(String emailOthbcAt) {
        this.emailOthbcAt = emailOthbcAt;
    }

    
    /**
     * String cmpnyNmOthbcAt을 반환
     * @return String cmpnyNmOthbcAt
     */
    public String getCmpnyNmOthbcAt() {
        return cmpnyNmOthbcAt;
    }

    
    /**
     * cmpnyNmOthbcAt을 설정
     * @param cmpnyNmOthbcAt 을(를) String cmpnyNmOthbcAt로 설정
     */
    public void setCmpnyNmOthbcAt(String cmpnyNmOthbcAt) {
        this.cmpnyNmOthbcAt = cmpnyNmOthbcAt;
    }

    
    /**
     * String reprsntTelnoOthbcAt을 반환
     * @return String reprsntTelnoOthbcAt
     */
    public String getReprsntTelnoOthbcAt() {
        return reprsntTelnoOthbcAt;
    }

    
    /**
     * reprsntTelnoOthbcAt을 설정
     * @param reprsntTelnoOthbcAt 을(를) String reprsntTelnoOthbcAt로 설정
     */
    public void setReprsntTelnoOthbcAt(String reprsntTelnoOthbcAt) {
        this.reprsntTelnoOthbcAt = reprsntTelnoOthbcAt;
    }

    
    /**
     * String cmpnyEmailOthbcAt을 반환
     * @return String cmpnyEmailOthbcAt
     */
    public String getCmpnyEmailOthbcAt() {
        return cmpnyEmailOthbcAt;
    }

    
    /**
     * cmpnyEmailOthbcAt을 설정
     * @param cmpnyEmailOthbcAt 을(를) String cmpnyEmailOthbcAt로 설정
     */
    public void setCmpnyEmailOthbcAt(String cmpnyEmailOthbcAt) {
        this.cmpnyEmailOthbcAt = cmpnyEmailOthbcAt;
    }

    
    /**
     * String mngrEmail을 반환
     * @return String mngrEmail
     */
    public String getMngrEmail() {
        return mngrEmail;
    }

    
    /**
     * mngrEmail을 설정
     * @param mngrEmail 을(를) String mngrEmail로 설정
     */
    public void setMngrEmail(String mngrEmail) {
        this.mngrEmail = mngrEmail;
    }

    
    /**
     * String mngrNm을 반환
     * @return String mngrNm
     */
    public String getMngrNm() {
        return mngrNm;
    }

    
    /**
     * mngrNm을 설정
     * @param mngrNm 을(를) String mngrNm로 설정
     */
    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    
    /**
     * String mngrId을 반환
     * @return String mngrId
     */
    public String getMngrId() {
        return mngrId;
    }

    
    /**
     * mngrId을 설정
     * @param mngrId 을(를) String mngrId로 설정
     */
    public void setMngrId(String mngrId) {
        this.mngrId = mngrId;
    }

    
    /**
     * Integer cmMberTopCount을 반환
     * @return Integer cmMberTopCount
     */
    public Integer getCmMberTopCount() {
        return cmMberTopCount;
    }

    
    /**
     * cmMberTopCount을 설정
     * @param cmMberTopCount 을(를) Integer cmMberTopCount로 설정
     */
    public void setCmMberTopCount(Integer cmMberTopCount) {
        this.cmMberTopCount = cmMberTopCount;
    }

    
    /**
     * Integer cmBbsTopCount을 반환
     * @return Integer cmBbsTopCount
     */
    public Integer getCmBbsTopCount() {
        return cmBbsTopCount;
    }

    
    /**
     * cmBbsTopCount을 설정
     * @param cmBbsTopCount 을(를) Integer cmBbsTopCount로 설정
     */
    public void setCmBbsTopCount(Integer cmBbsTopCount) {
        this.cmBbsTopCount = cmBbsTopCount;
    }

    
    /**
     * String conectSesionId을 반환
     * @return String conectSesionId
     */
    public String getConectSesionId() {
        return conectSesionId;
    }

    
    /**
     * conectSesionId을 설정
     * @param conectSesionId 을(를) String conectSesionId로 설정
     */
    public void setConectSesionId(String conectSesionId) {
        this.conectSesionId = conectSesionId;
    }

    
    /**
     * String conectDt을 반환
     * @return String conectDt
     */
    public String getConectDt() {
        return conectDt;
    }

    
    /**
     * conectDt을 설정
     * @param conectDt 을(를) String conectDt로 설정
     */
    public void setConectDt(String conectDt) {
        this.conectDt = conectDt;
    }

    
    /**
     * String conectIp을 반환
     * @return String conectIp
     */
    public String getConectIp() {
        return conectIp;
    }

    
    /**
     * conectIp을 설정
     * @param conectIp 을(를) String conectIp로 설정
     */
    public void setConectIp(String conectIp) {
        this.conectIp = conectIp;
    }

    
    /**
     * String conectUrl을 반환
     * @return String conectUrl
     */
    public String getConectUrl() {
        return conectUrl;
    }

    
    /**
     * conectUrl을 설정
     * @param conectUrl 을(를) String conectUrl로 설정
     */
    public void setConectUrl(String conectUrl) {
        this.conectUrl = conectUrl;
    }

    
    /**
     * String pgeTitle을 반환
     * @return String pgeTitle
     */
    public String getPgeTitle() {
        return pgeTitle;
    }

    
    /**
     * pgeTitle을 설정
     * @param pgeTitle 을(를) String pgeTitle로 설정
     */
    public void setPgeTitle(String pgeTitle) {
        this.pgeTitle = pgeTitle;
    }

    
    /**
     * Integer pgeRdcnt을 반환
     * @return Integer pgeRdcnt
     */
    public Integer getPgeRdcnt() {
        return pgeRdcnt;
    }

    
    /**
     * pgeRdcnt을 설정
     * @param pgeRdcnt 을(를) Integer pgeRdcnt로 설정
     */
    public void setPgeRdcnt(Integer pgeRdcnt) {
        this.pgeRdcnt = pgeRdcnt;
    }
    
    

}
