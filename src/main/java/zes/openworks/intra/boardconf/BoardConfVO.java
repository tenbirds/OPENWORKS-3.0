/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.boardconf;

import java.util.List;

import zes.base.vo.PaggingVO;
import zes.core.lang.validate.annotation.marker.RangeLength;
import zes.core.lang.validate.annotation.marker.Required;
import zes.openworks.intra.mgr.MgrVO;

/**
 * 게시판 관리 VO 객체
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 * 
 *  수정일			  수정자					 수정내용
 * --------------  --------  ---------------------------------
 *  2012. 4. 24.   손재숙	  JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 *  2014. 9. 20     박꽃송이      DB 컬럼(사이트 구분 - SITE_DIV_CD) 추가 관련 소스 수정
 * </pre>
 * @see
 */
public class BoardConfVO extends PaggingVO {

    private static final long serialVersionUID = 2004189154549584749L;

    /** 분류 목록(1Depth) */
    private List<BoardCtgVO> ctgList;
    /** 분류 목록(2Depth) */
    private List<BoardCtgVO> aditCtgList;

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
    /** 분류명 배열(1Depth) */
    private String[] ctgNms;
    /** 분류명 배열(2Depth) */
    private String[] aditCtgNms;
    /** 목록 표시항목 배치 목록 */
    private List<BoardArrangeVO> listArrange;
    /** 상세보기 표시항목 배치 목록 */
    private List<BoardArrangeVO> viewArrange;

    /** 게시판 코드 */
    private Integer bbsCd = 0;
    /** 게시판 코드 목록 */
    private String[] bbsCds;
    /** 게시판 명*/
    @Required(message = "게시판 명은 필수 입력입니다.")
    @RangeLength(min = 3, max = 100)
    private String bbsNm;
    /** 게시판 설명 */
    @RangeLength(max = 300)
    private String bbsDc;
    /** 환경설정순서번호 */
    private Integer confOrdrNo = 0;
    /** 사용가부 */
    private String useYn;
    /** 등록일시 */
    private String registDt;
    /** 수정일시 */
    private String updtDt;

    /** 게시물 수 */
    private Integer articleCnt = 0;
    /** 코멘트 수 */
    private Integer commentCnt = 0;
    /** 첨부파일 수 */
    private Integer fileCnt = 0;
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
    /** 타이틀 절단 글자수 */
    private Integer cutTitleNum = 60;
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
    /** 도메인 코드 */
    @Required(message = "도메인 구분은 필수 입력입니다.")
    private Integer domainCd;
    /** 도메인 명(FULL) */
    private String domainNm;
    /** 도메인삭제여부 */
    private String domainDeleteAt = "N";
    /** 분류명(1Depth) */
    private String ctgNm;
    /** 분류명(2Depth) */
    private String aditCtgNm;
    /** 분류코드(1Depth)  */
    private Integer ctgCd;
    /** 분류코드(2Depth) */
    private Integer aditCtgCd;
    
    /** 서비스 목록 */
    private List<BoardConfVO> productList;
    /** 서비스코드 */
    private String goodsCd;
    /** 서비스이름 */
    private String goodsNm;
    /** 언어 */
    private String langCode;

    public Integer getBbsCd() {
        return bbsCd;
    }

    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }

    public String[] getBbsCds() {
        return bbsCds;
    }

    public void setBbsCds(String[] bbsCds) {
        this.bbsCds = bbsCds;
    }

    public String getBbsNm() {
        return bbsNm;
    }

    public void setBbsNm(String bbsNm) {
        this.bbsNm = bbsNm;
    }

    public String getBbsDc() {
        return bbsDc;
    }

    public void setBbsDc(String bbsDc) {
        this.bbsDc = bbsDc;
    }

    public Integer getConfOrderNo() {
        return confOrdrNo;
    }

    public void setConfOrderNo(Integer confOrderNo) {
        this.confOrdrNo = confOrderNo;
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

    public Integer getArticleCnt() {
        return articleCnt;
    }

    public void setArticleCnt(Integer articleCnt) {
        this.articleCnt = articleCnt;
    }

    public Integer getCommentCnt() {
        return commentCnt;
    }

    public void setCommentCnt(Integer commentCnt) {
        this.commentCnt = commentCnt;
    }

    public Integer getFileCnt() {
        return fileCnt;
    }

    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }

    public Integer getDelCnt() {
        return delCnt;
    }

    public void setDelCnt(Integer delCnt) {
        this.delCnt = delCnt;
    }


    public Integer getKndCd() {
        return kndCd;
    }

    public void setKndCd(Integer kndCd) {
        this.kndCd = kndCd;
    }

    public String getKndNm() {
        return kndNm;
    }

    public void setKndNm(String kndNm) {
        this.kndNm = kndNm;
    }

    public String getCtgYn() {
        return ctgYn;
    }

    public void setCtgYn(String ctgYn) {
        this.ctgYn = ctgYn;
    }

    public String getCmtYn() {
        return cmtYn;
    }

    public void setCmtYn(String cmtYn) {
        this.cmtYn = cmtYn;
    }

    public String getNoticeBbscttUseYn() {
        return noticeBbscttUseYn;
    }

    public void setNoticeBbscttUseYn(String noticeBbscttUseYn) {
        this.noticeBbscttUseYn = noticeBbscttUseYn;
    }

    public String getSkinPath() {
        return skinPath;
    }

    public void setSkinPath(String skinPath) {
        this.skinPath = skinPath;
    }

    public String getHderPath() {
        return hderPath;
    }

    public void setHderPath(String hderPath) {
        this.hderPath = hderPath;
    }

    public String getFooterPath() {
        return footerPath;
    }

    public void setFooterPath(String footerPath) {
        this.footerPath = footerPath;
    }

    public String getListSkin() {
        return listSkin;
    }

    public void setListSkin(String listSkin) {
        this.listSkin = listSkin;
    }

    public String getViewSkin() {
        return viewSkin;
    }

    public void setViewSkin(String viewSkin) {
        this.viewSkin = viewSkin;
    }

    public String getFormSkin() {
        return formSkin;
    }

    public void setFormSkin(String formSkin) {
        this.formSkin = formSkin;
    }

    public String getFeedYn() {
        return feedYn;
    }

    public void setFeedYn(String feedYn) {
        this.feedYn = feedYn;
    }

    public Integer getRppNum() {
        return rppNum;
    }

    public void setRppNum(Integer rppNum) {
        this.rppNum = rppNum;
    }

    public String getDwldYn() {
        return dwldYn;
    }

    public void setDwldYn(String dwldYn) {
        this.dwldYn = dwldYn;
    }

    public Integer getCutTitleNum() {
        return cutTitleNum;
    }

    public void setCutTitleNum(Integer cutTitleNum) {
        this.cutTitleNum = cutTitleNum;
    }

    public Integer getNewArticleNum() {
        return newArticleNum;
    }

    public void setNewArticleNum(Integer newArticleNum) {
        this.newArticleNum = newArticleNum;
    }

    public Integer getEmphasisNum() {
        return emphasisNum;
    }

    public void setEmphasisNum(Integer emphasisNum) {
        this.emphasisNum = emphasisNum;
    }

    public Integer getRegisterIndictCd() {
        return registerIndictCd;
    }

    public void setRegisterIndictCd(Integer registerIndictCd) {
        this.registerIndictCd = registerIndictCd;
    }

    public String getMngrEditorYn() {
        return mngrEditorYn;
    }

    public void setMngrEditorYn(String mngrEditorYn) {
        this.mngrEditorYn = mngrEditorYn;
    }

    public String getUserEditorYn() {
        return userEditorYn;
    }

    public void setUserEditorYn(String userEditorYn) {
        this.userEditorYn = userEditorYn;
    }

    public String getFileYn() {
        return fileYn;
    }

    public void setFileYn(String fileYn) {
        this.fileYn = fileYn;
    }

    public Integer getUploadTy() {
        return uploadTy;
    }

    public void setUploadTy(Integer uploadTy) {
        this.uploadTy = uploadTy;
    }

    public Integer getMaxFileCnt() {
        return maxFileCnt;
    }

    public void setMaxFileCnt(Integer maxFileCnt) {
        this.maxFileCnt = maxFileCnt;
    }

    public Integer getMaxFileSize() {
        return maxFileSize;
    }

    public void setMaxFileSize(Integer maxFileSize) {
        this.maxFileSize = maxFileSize;
    }

    public Integer getTotalFileSize() {
        return totalFileSize;
    }

    public void setTotalFileSize(Integer totalFileSize) {
        this.totalFileSize = totalFileSize;
    }

    public String getFilePermExtsn() {
        return filePermExtsn;
    }

    public void setFilePermExtsn(String filePermExtsn) {
        this.filePermExtsn = filePermExtsn;
    }

    public String getBannedWordYn() {
        return bannedWordYn;
    }

    public void setBannedWordYn(String bannedWordYn) {
        this.bannedWordYn = bannedWordYn;
    }

    public String getBannedWordCn() {
        return bannedWordCn;
    }

    public void setBannedWordCn(String bannedWordCn) {
        this.bannedWordCn = bannedWordCn;
    }

    public String getCaptchaYn() {
        return captchaYn;
    }

    public void setCaptchaYn(String captchaYn) {
        this.captchaYn = captchaYn;
    }

    public String getOthbcYn() {
        return othbcYn;
    }

    public void setOthbcYn(String othbcYn) {
        this.othbcYn = othbcYn;
    }

    public Integer getListViewCd() {
        return listViewCd;
    }

    public void setListViewCd(Integer listViewCd) {
        this.listViewCd = listViewCd;
    }

    public String getRecomendYn() {
        return recomendYn;
    }

    public void setRecomendYn(String recomendYn) {
        this.recomendYn = recomendYn;
    }

    public String getAccuseYn() {
        return accuseYn;
    }

    public void setAccuseYn(String accuseYn) {
        this.accuseYn = accuseYn;
    }

    public String getStsfdgYn() {
        return stsfdgYn;
    }

    public void setStsfdgYn(String stsfdgYn) {
        this.stsfdgYn = stsfdgYn;
    }

    public Integer getRdcntIncrsLmttTime() {
        return rdcntIncrsLmttTime;
    }

    public void setRdcntIncrsLmttTime(Integer rdcntIncrsLmttTime) {
        this.rdcntIncrsLmttTime = rdcntIncrsLmttTime;
    }

    public String getTagYn() {
        return tagYn;
    }

    public void setTagYn(String tagYn) {
        this.tagYn = tagYn;
    }


    public Integer getGubunCd() {
        return gubunCd;
    }

    public void setGubunCd(Integer gubunCd) {
        this.gubunCd = gubunCd;
    }
    
    public Integer getConfOrdrNo() {
        return confOrdrNo;
    }

    public void setConfOrdrNo(Integer confOrdrNo) {
        this.confOrdrNo = confOrdrNo;
    }

    public int getAccessCnt() {
        return accessCnt;
    }

    public void setAccessCnt(int accessCnt) {
        this.accessCnt = accessCnt;
    }

    public String getAccessUpdtDt() {
        return accessUpdtDt;
    }

    public void setAccessUpdtDt(String accessUpdtDt) {
        this.accessUpdtDt = accessUpdtDt;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }


    public List<BoardCtgVO> getCtgList() {
        return ctgList;
    }

    public void setCtgList(List<BoardCtgVO> ctgList) {
        this.ctgList = ctgList;
    }

    public List<BoardCtgVO> getAditCtgList() {
        return aditCtgList;
    }

    public void setAditCtgList(List<BoardCtgVO> aditCtgList) {
        this.aditCtgList = aditCtgList;
    }

    public List<BoardExtensionVO> getListColunms() {
        return listColunms;
    }

    public void setListColunms(List<BoardExtensionVO> listColunms) {
        this.listColunms = listColunms;
    }

    public List<BoardExtensionVO> getViewColunms() {
        return viewColunms;
    }

    public void setViewColunms(List<BoardExtensionVO> viewColunms) {
        this.viewColunms = viewColunms;
    }

    public List<BoardExtensionVO> getFormColunms() {
        return formColunms;
    }

    public void setFormColunms(List<BoardExtensionVO> formColunms) {
        this.formColunms = formColunms;
    }

    public List<BoardExtensionVO> getSearchColunms() {
        return searchColunms;
    }

    public void setSearchColunms(List<BoardExtensionVO> searchColunms) {
        this.searchColunms = searchColunms;
    }

    public String[] getCtgNms() {
        return ctgNms;
    }

    public void setCtgNms(String[] ctgNms) {
        this.ctgNms = ctgNms;
    }

    public List<MgrVO> getAuthList() {
        return authList;
    }

    public void setAuthList(List<MgrVO> authList) {
        this.authList = authList;
    }

    public List<BoardArrangeVO> getListArrange() {
        return listArrange;
    }

    public void setListArrange(List<BoardArrangeVO> listArrange) {
        this.listArrange = listArrange;
    }

    public List<BoardArrangeVO> getViewArrange() {
        return viewArrange;
    }

    public void setViewArrange(List<BoardArrangeVO> viewArrange) {
        this.viewArrange = viewArrange;
    }
    

    public Integer getDomainCd() {
        return domainCd;
    }


    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }


    public String getDomainNm() {
        return domainNm;
    }


    public void setDomainNm(String domainNm) {
        this.domainNm = domainNm;
    }

    public String getDomainDeleteAt() {
        return domainDeleteAt;
    }

    public void setDomainDeleteAt(String domainDeleteAt) {
        this.domainDeleteAt = domainDeleteAt;
    }

    public Integer getQ_domain_cd() {
        return q_domain_cd;
    }


    public void setQ_domain_cd(Integer q_domain_cd) {
        this.q_domain_cd = q_domain_cd;
    }


    public String getCtgNm() {
        return ctgNm;
    }


    public void setCtgNm(String ctgNm) {
        this.ctgNm = ctgNm;
    }

    public String[] getAditCtgNms() {
        return aditCtgNms;
    }

    public void setAditCtgNms(String[] aditCtgNms) {
        this.aditCtgNms = aditCtgNms;
    }

    public String getAditCtgNm() {
        return aditCtgNm;
    }

    public void setAditCtgNm(String aditCtgNm) {
        this.aditCtgNm = aditCtgNm;
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

    
    public List<BoardConfVO> getProductList() {
        return productList;
    }

    
    public void setProductList(List<BoardConfVO> productList) {
        this.productList = productList;
    }

    
    public String getGoodsCd() {
        return goodsCd;
    }

    
    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }

    
    public String getGoodsNm() {
        return goodsNm;
    }

    
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    
    public String getLangCode() {
        return langCode;
    }

    
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }


}
