/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.goods;

import java.util.List;
import java.util.Map;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

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
 *  2014. 10. 21.   김병욱       신규
 * </pre>
 * @see
 */
public class GoodsManageVO extends PaggingVO {

    /**  */
    private static final long serialVersionUID = 5004972049218009469L;
    
    private String userId;                        /** 사용자아이디 */    
    private Integer userTyCd;                     /** 사용자 타입 코드 */    
    private String langCode;                      /** 언어코드 */    
    private String goodsCode;                     /** 서비스코드 */    
    private Integer goodsTyCd;                    /** 서비스유형코드 */    
    private String goodsNm;                       /** 서비스명 */    
    private String goodsVerInfo;                  /** 서비스버전정보 */    
    private String goodsHmpgUrl;                  /** 서비스홈페이지URL */    
    private String goodsSumry;                    /** 서비스개요 */    
    private String goodsMainFnct;                 /** 서비스주요기능 */    
    private String cnslExpcEffect;
    
    private String goodsRefer;                    /** 서비스레퍼런스 */    
    private String goodsDwldUrl;                  /** 서비스다운로드URL */    
    private Integer sleMthdCd;                    /** 판매방식코드 */    
    private Integer goodsFileSeq = -1;            /** 서비스파일일련 */    
    private String demoExprnUrl;                  /** 데모체험URL */    
    private String spcltyRealm;
    private Integer cnstntCo;
    private Integer goodsImageFileSeq = -1;
    private Integer goodsMnlFileSeq = -1;         /* 규격서 2.0*/
    private Integer goodsMnlFileSeq1 = -1;        /* 규격서 1.0*/
    
    private String goodsMakr;                     /** 서비스제조사 */    
    private String goodsPc;
    private String goodsChargerNm;
    private String goodsChargerEmail;
    private String goodsChargerCttpc;
    private String goodsChargerMbtlnum;
    
    private Integer goodsRegistSttus;             /** 서비스등록상태 */    
    private Integer[] q_goodsRegistSttuses;       /** 서비스등록상태(조건_배열) */    
    private String goodsActvtyAt = "Y";           /** 서비스전시여부 */    
    private String registId;                      /** 등록아이디 */    
    private String registDt;                      /** 등록일시 */    
    private String updtId;                        /** 수정아이디 */    
    private String updtDt;                        /** 수정일시 */    
    private String confmDt;
    
    private Integer goodsRdcnt = 0;               /** 서비스조회수 */    
    private String mngrDeleteAt = "N";            /** 관리자삭제여부 */    
    private String deleteMngrDeptCode;            /** 삭제관리자부서코드 */    
    private String deleteMngrId;                  /** 삭제관리자아이디 */    
    private Integer cntcInsttCd;
    private String nationGrp;
    private String userTyGrp;
    private Integer goodsKndCd;
    private String goodsKndNm;
    private String comouDe;
    private Integer goodsLicenceCd;
    private String goodsLicenceNm;
    private String goodsLicenceCn;
    private Integer archtcSe;
    private Integer[] archtcSeArry;

    
    private String returnResn;                    /** 반려사유 */    
    private String exmntReturnResn;               /** 검토반려사유 */    
    private String confmReturnResn;               /** 승인반려사유 */    
    private Integer confmReturnSection;           /** 승인반려사유 구분 */    
    private Integer exmntConfmCd;                 /** 검토승인코드 */    
    private Integer exmntConfmHistSn;             /** 검토승인이력순번 */    
    private Integer[] exmntConfmHistSns;
    
    private Integer goodsChngSeq = -1;            /** 첨부사유 */    
    private String goodsChngPc;                   /** 가격정보 */    
    private String goodsBeforPc;                  /** 가격이전정보 */        
    
    private String exmntConfmDt;                  /** 검토승인이력 날짜 */    
    private String exmntLimitDt;
    private Integer exmntDay;
    private String confmLimitDt;
    private Integer confmDay;
    private Integer confmCnt;
    private String exmntDt;
    private String exmntId;
    
    /*서비스상태변경요청 : KS추가 : 2017-07-07 : ST */
    /*요청구분*/
    private Integer requstSe;
    /*요청구분명*/
    private String requstSeNm;
    /*요청사유*/
    private Integer requstResn;
    /*요청사유내용*/
    private String requstResnCn;
    /*요청처리여부*/
    private String requstProcessAt;
    /*전시전환예정일자*/
    private String dspyCnvrsPrearngeDt;
    /*서비스상태변경요청 : KS추가 : 2017-07-07 : ED */
    
    private String mngrId;                        /** 관리자아이디 */    
    private String mngrNm;                        /** 관리자명 */    
    private String deptNm;                        /** 관리자 부서명 */    
    private String telno;                         /** 관리자 휴대전화번호 */    
    private String deptTelno;                     /** 관리자 부서 전화번호 */    
    private String email;                         /** 관리자 이메일 */    
    private String authCode;                      /** 관리자 권한코드 */
    
    private List<String> langCodes;               /** 언어코드 배열 */    
    private String[] goodsCodes;                  /** 서비스코드배열 */
    private String goodsTyNm;

    private String langStoreNm;

    private String langNm;
    private String langEngNm;

    private String sleMthdNm;

    private String goodsRegistSttusNm;

    private List<Map<String, Object>> goodsType;

    private List<Map<String, Object>> goodsMarkList;

    private String ctgryCd;

    private String[] ctgryCds;

    private Integer ctgryDp;

    private String ctgryNm;

    private String parntsCtgryCd;

    private List<Map<String, Object>> goodsCtgry;

    private List<Map<String, Object>> goodsMark;

    private List<Map<String, Object>> goodsStore;

    private List<Map<String, Object>> goodsTag;

    private List<Map<String, Object>> goodsMetaLang;

    private List<Map<String, Object>> goodsMetaOS;

    private List<Map<String, Object>> goodsMetaAS;

    private List<Map<String, Object>> goodsMetaTECH;

    private List<Map<String, Object>> goodsMetaTAG;

    private List<Map<String, Object>> cngdMarkList;

    
    
    private Map<String, Object> exmntMgr;
    private Map<String, Object> confmMgr;

    private String goodsMonitorUrl;
    private String goodsMonitorDay; //모니터링 일자
    private String goodsMonitorTime; //모니터링 시간 추가
    
    private String goodsServiceState;
    private List<FileVO> imageMainFile;
    
    // {{DK, 2016.06.22  서비스제공방식 추가
    private Integer serviceOfferMethod;
    private String serviceOfferMethodNm;
    // }}
    
    private String goodsStat;
    private String goodsStatNm; 
    
    private String updateYn;
    private String chgItemContent;    
    
    private String inUpaGubun;    
    private String inputNm;    
    
    private String cfmItemContent;
    
    private String stat;
    private String gubun;
    private String isMark;

    /**
     2018년 08월 29일 tst_good_spec_describe_i에서 tst_good_info_i로 변경
     서비스 신규등록시 변경  
     */
    private String dueStdrMumm;   //과금기준
    private String svcPcUntCd;      //서비스 가격단위
    private String svcPc;           //서비스가격
    private String svcPcVat;        //VAT포함
    private String mummCntrctpd;    //최소계약기간    
    
    private List<Map<String, Object>> inputNms;
    
    private int crtfcSeCd = 0;
    
    
    private String formNm;
    private String svcFlag;
    private int goodsNum;
    private int crtMarkCd;
    private String certMarkCdGubun;
    
    private int suplycnt;
    private Integer goodsCount;
    private Integer specMaxNum; //규격서 유무 체크
    private String langCtgryNm;
    private String markNm;
    
    /* 페이지 이름 */
    private String pageUrlNm;
    
    private String svcPcUntCdNm;
    private String dueStdrMummNm;    
    private String svcPcVatNm;
    
    /**
     * int crtfcSeCd을 반환
     * @return int crtfcSeCd
     */
    public int getCrtfcSeCd() {
        return crtfcSeCd;
    }
    
    /**
     * crtfcSeCd을 설정
     * @param crtfcSeCd 을(를) int crtfcSeCd로 설정
     */
    public void setCrtfcSeCd(int crtfcSeCd) {
        this.crtfcSeCd = crtfcSeCd;
    }

    /**
     * List<Map<String,Object>> inputNms을 반환
     * @return List<Map<String,Object>> inputNms
     */
    public List<Map<String, Object>> getInputNms() {
        return inputNms;
    }

    /**
     * inputNms을 설정
     * @param inputNms 을(를) List<Map<String,Object>> inputNms로 설정
     */
    public void setInputNms(List<Map<String, Object>> inputNms) {
        this.inputNms = inputNms;
    }

    /**
     * String isMark을 반환
     * @return String isMark
     */
    public String getIsMark() {
        return isMark;
    }

    /**
     * isMark을 설정
     * @param isMark 을(를) String isMark로 설정
     */
    public void setIsMark(String isMark) {
        this.isMark = isMark;
    }










    /**
     * String gubun을 반환
     * @return String gubun
     */
    public String getGubun() {
        return gubun;
    }









    
    /**
     * gubun을 설정
     * @param gubun 을(를) String gubun로 설정
     */
    public void setGubun(String gubun) {
        this.gubun = gubun;
    }









    /**
     * String stat을 반환
     * @return String stat
     */
    public String getStat() {
        return stat;
    }








    
    /**
     * stat을 설정
     * @param stat 을(를) String stat로 설정
     */
    public void setStat(String stat) {
        this.stat = stat;
    }








    /**
     * String cfmItemContent을 반환
     * @return String cfmItemContent
     */
    public String getCfmItemContent() {
        return cfmItemContent;
    }







    
    /**
     * cfmItemContent을 설정
     * @param cfmItemContent 을(를) String cfmItemContent로 설정
     */
    public void setCfmItemContent(String cfmItemContent) {
        this.cfmItemContent = cfmItemContent;
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
     * String inUpaGubun을 반환
     * @return String inUpaGubun
     */
    public String getInUpaGubun() {
        return inUpaGubun;
    }





    
    /**
     * inUpaGubun을 설정
     * @param inUpaGubun 을(를) String inUpaGubun로 설정
     */
    public void setInUpaGubun(String inUpaGubun) {
        this.inUpaGubun = inUpaGubun;
    }





    /**
     * String chgItemContent을 반환
     * @return String chgItemContent
     */
    public String getChgItemContent() {
        return chgItemContent;
    }




    
    /**
     * chgItemContent을 설정
     * @param chgItemContent 을(를) String chgItemContent로 설정
     */
    public void setChgItemContent(String chgItemContent) {
        this.chgItemContent = chgItemContent;
    }




    /**
     * String updateYn을 반환
     * @return String updateYn
     */
    public String getUpdateYn() {
        return updateYn;
    }



    
    /**
     * updateYn을 설정
     * @param updateYn 을(를) String updateYn로 설정
     */
    public void setUpdateYn(String updateYn) {
        this.updateYn = updateYn;
    }



    /**
     * String goodsStat을 반환
     * @return String goodsStat
     */
    public String getGoodsStat() {
        return goodsStat;
    }


    
    /**
     * goodsStat을 설정
     * @param goodsStat 을(를) String goodsStat로 설정
     */
    public void setGoodsStat(String goodsStat) {
        this.goodsStat = goodsStat;
    }


    
    /**
     * String goodsStatNm을 반환
     * @return String goodsStatNm
     */
    public String getGoodsStatNm() {
        return goodsStatNm;
    }


    
    /**
     * goodsStatNm을 설정
     * @param goodsStatNm 을(를) String goodsStatNm로 설정
     */
    public void setGoodsStatNm(String goodsStatNm) {
        this.goodsStatNm = goodsStatNm;
    }


    /**
     * List<Map<String,Object>> goodsMetaExprn을 반환
     * @return List<Map<String,Object>> goodsMetaExprn
     */
    public List<Map<String, Object>> getGoodsMetaExprn() {
        return goodsMetaExprn;
    }


    /**
     * goodsMetaExprn을 설정
     * @param goodsMetaExprn 을(를) List<Map<String,Object>> goodsMetaExprn로 설정
     */
    public void setGoodsMetaExprn(List<Map<String, Object>> goodsMetaExprn) {
        this.goodsMetaExprn = goodsMetaExprn;
    }


    /**
     * List<Map<String,Object>> goodsMetaCntrctUnit을 반환
     * @return List<Map<String,Object>> goodsMetaCntrctUnit
     */
    public List<Map<String, Object>> getGoodsMetaCntrctUnit() {
        return goodsMetaCntrctUnit;
    }


    /**
     * goodsMetaCntrctUnit을 설정
     * @param goodsMetaCntrctUnit 을(를) List<Map<String,Object>> goodsMetaCntrctUnit로 설정
     */
    public void setGoodsMetaCntrctUnit(List<Map<String, Object>> goodsMetaCntrctUnit) {
        this.goodsMetaCntrctUnit = goodsMetaCntrctUnit;
    }


    /**
     * List<Map<String,Object>> goodsMetaSvc을 반환
     * @return List<Map<String,Object>> goodsMetaSvc
     */
    public List<Map<String, Object>> getGoodsMetaSvc() {
        return goodsMetaSvc;
    }


    /**
     * goodsMetaSvc을 설정
     * @param goodsMetaSvc 을(를) List<Map<String,Object>> goodsMetaSvc로 설정
     */
    public void setGoodsMetaSvc(List<Map<String, Object>> goodsMetaSvc) {
        this.goodsMetaSvc = goodsMetaSvc;
    }


    /**
     * List<Map<String,Object>> goodsMetaStd을 반환
     * @return List<Map<String,Object>> goodsMetaStd
     */
    public List<Map<String, Object>> getGoodsMetaStd() {
        return goodsMetaStd;
    }


    /**
     * goodsMetaStd을 설정
     * @param goodsMetaStd 을(를) List<Map<String,Object>> goodsMetaStd로 설정
     */
    public void setGoodsMetaStd(List<Map<String, Object>> goodsMetaStd) {
        this.goodsMetaStd = goodsMetaStd;
    }


    /**
     * List<Map<String,Object>> goodsMetaCnstcMthd을 반환
     * @return List<Map<String,Object>> goodsMetaCnstcMthd
     */
    public List<Map<String, Object>> getGoodsMetaCnstcMthd() {
        return goodsMetaCnstcMthd;
    }


    /**
     * goodsMetaCnstcMthd을 설정
     * @param goodsMetaCnstcMthd 을(를) List<Map<String,Object>> goodsMetaCnstcMthd로 설정
     */
    public void setGoodsMetaCnstcMthd(List<Map<String, Object>> goodsMetaCnstcMthd) {
        this.goodsMetaCnstcMthd = goodsMetaCnstcMthd;
    }


    /**
     * List<Map<String,Object>> goodsMetaScqcLv을 반환
     * @return List<Map<String,Object>> goodsMetaScqcLv
     */
    public List<Map<String, Object>> getGoodsMetaScqcLv() {
        return goodsMetaScqcLv;
    }


    /**
     * goodsMetaScqcLv을 설정
     * @param goodsMetaScqcLv 을(를) List<Map<String,Object>> goodsMetaScqcLv로 설정
     */
    public void setGoodsMetaScqcLv(List<Map<String, Object>> goodsMetaScqcLv) {
        this.goodsMetaScqcLv = goodsMetaScqcLv;
    }


    /** 지원언어 */
    private Integer metaLangCd;
    private String  metaLangNm;
    private Integer[] metaLangs;
    private String metaLangEtc;

    /** 지원OS */
    private String metaOSs;
    private String metaOSetc;

    /** 지원AS */
    private String metaASs;
    private String metaASetc;

    /** 지원TECH */
    private String metaTECHs;
    private String metaTECHetc;

    /** 메타태그 입력태그 */
    private String metaTAGs;
    private String goodsTags;
    private String goodsTagNm;

    /** 메타태그 테이블 */
    private Integer metaGroupCd;
    private Integer metaCode;
    private String metaEtcCn;

    private List<FileVO> imageFile;

    /** 서비스파일 */
    private List<FileVO> goodsFile;

    private List<List<FileVO>> markFile;

    private List<List<FileVO>> markCrtfcFile;

    private Integer crtfcSeFileSeq;

    private Integer[] crtfcSeFileSeqs;
    private String[] crtfcSeFileIds;

    private Integer[] q_crtfcCodes;

    private List<FileVO> mnlFile;

    private List<FileVO> cngdMarkFile;

    private Integer markCd;

    private Integer[] markCds;

    private Integer[] goodsMarkCds;

    private String ctgryCode;

    private String ctgryParentCode;

    private String[] ctgryCodes;

    private Integer ctgryClCd;

    private String ctgryClNm;

    private String ctgryPath;

    /** 메일 템플릿 구분*/
    private Integer mailSection;

    /** 상호호환성인증 */
    private Integer pChk;

    /** 스토어 언어구분 */
    private String storeSction;

    /** 서비스의 현재 상태 */
    private Integer goodsStatus;
    private Integer[] goodsStatuss;

    /** 기술 카테고리 */
    private String techCtgry;

    /** 서비스변경구분코드 */
    private Integer goodsChangeCode;


    //{{2015-12-10 고도화기능으로 서비스정보추가

    private String itemSfe ;  //특징
    private String cmpnyNm ;  //회사명
    private String unitPrice; //단위
    private String orgplce ;  //원산지
    private String cntrctNo ; //계약번호
    private String locplcHedofc ; //본사소재지
    private String priceChk ; //가격체크(무료:0, 유료:1, 유무료:2)
    private String locplcIt ; //지역소재지(IT서비스)
    private String itemVodUrl; //체험판URL
    private String itemDnFileSeq;
    private Integer mnlDnFileSeq = -1;  //사용메뉴얼 다운로드 파일명
    private String frameChk;    //프레임 호환여부(호환:Y)
    private String gtwobChk;    //조달서비스여부(조달:Y)
    private String detailGoodsClNo;//세부물품분류번호
    private String delngStopChk; //거래정지여부
    private String orderIntrcpChk; //주문차단여부
    private String itemImgUrl; //제품이미지URL
    private String smlpzChk; // 중소기업구분체크
    private String metaPrices;
    private String metaAreas;
    private String gtwobNumber;//물품일련번호

    
    private Integer priceDnFileSeq = -1; // 가격표 다운로드 파일명  <!-- {{ BH, 2016.01.13 가격표 다운로드 파일 추가 --!>
    private String priceDnFileId;

    private List<FileVO> priceFile; // <!-- {{ 2016.01.13 가격표 다운로드 파일 추가 --!>

    private String gsCrtfcNo;
    private String naraCrtfcNo;
    
    
    /**
     * Integer priceDnFileSeq을 반환
     * @return Integer priceDnFileSeq
     */
    public Integer getPriceDnFileSeq() {
        return priceDnFileSeq;
    }

    /**
     * priceDnFileSeq을 설정
     * @param priceDnFileSeq 을(를) Integer priceDnFileSeq로 설정
     */
    public void setPriceDnFileSeq(Integer priceDnFileSeq) {
        this.priceDnFileSeq = priceDnFileSeq;
    }
    
    /**
     * String priceDnFileId을 반환
     * @return String priceDnFileId
     */
    public String getPriceDnFileId() {
        return priceDnFileId;
    }
    
    /**
     * priceFileId을 설정
     * @param priceDnFileId 을(를) String priceFileId로 설정
     */
    public void setPriceDnFileId(String priceDnFileId) {
        this.priceDnFileId = priceDnFileId;
    }



    private List<Map<String, Object>> goodsMetaPrice;   //소프트웨어 : 가격
    private List<Map<String, Object>> goodsMetaArea;    //IT전문가서비스 : 지역
    private List<FileVO> dnlFile;
    private List<FileVO> gcFile;

    /** 기타 첨부파일 일련 */
    private Integer etcFileSeq = -1;
    private List<FileVO> etcFile;

    /** 무료/체험 구분(2027) */
    private String metaExprns;
    /** 계약단위(2028) */
    private String metaCntrctUnits;
    private String metaCntrctUnitetc;
    /** 서비스관리(2030) */
    private String metaSvcs;
    /** 호환성(표준)(2031) */
    private String metaStds;
    /** 구축방식(2032) */
    private String metaCnstcMthds;
    /** SCQC Level(2033) */
    private String metaScqcLvs;
    
    /**주요고객*/
    private String cstmrInfo;
    /**서비스 기대효과*/
    private String goodsExpcEffect;
    

    private List<Map<String, Object>> goodsMetaExprn;
    private List<Map<String, Object>> goodsMetaCntrctUnit;
    private List<Map<String, Object>> goodsMetaSvc;
    private List<Map<String, Object>> goodsMetaStd;
    private List<Map<String, Object>> goodsMetaCnstcMthd;
    private List<Map<String, Object>> goodsMetaScqcLv;
    //}}


    /** 사용자아이디 설정 */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /** 사용자아이디 추출 */
    public String getUserId() {
        return userId;
    }

    public Integer getUserTyCd() {
        return userTyCd;
    }

    public void setUserTyCd(Integer userTyCd) {
        this.userTyCd = userTyCd;
    }

    /** 언어코드 설정 */
    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    /** 언어코드 추출 */
    public String getLangCode() {
        return langCode;
    }

    /** 서비스코드 설정 */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    /** 서비스코드 추출 */
    public String getGoodsCode() {
        return goodsCode;
    }

    /**
     * String[] goodsCodes을 반환
     *
     * @return String[] goodsCodes
     */
    public String[] getGoodsCodes() {
        return goodsCodes;
    }

    /**
     * goodsCodes을 설정
     *
     * @param goodsCodes 을(를) String[] goodsCodes로 설정
     */
    public void setGoodsCodes(String[] goodsCodes) {
        this.goodsCodes = goodsCodes;
    }

    /** 서비스유형코드 설정 */
    public void setGoodsTyCd(Integer goodsTyCd) {
        this.goodsTyCd = goodsTyCd;
    }

    /** 서비스유형코드 추출 */
    public Integer getGoodsTyCd() {
        return goodsTyCd;
    }

    /** 서비스명 설정 */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    /** 서비스명 추출 */
    public String getGoodsNm() {
        return goodsNm;
    }

    /** 서비스버전정보 설정 */
    public void setGoodsVerInfo(String goodsVerInfo) {
        this.goodsVerInfo = goodsVerInfo;
    }

    /** 서비스버전정보 추출 */
    public String getGoodsVerInfo() {
        return goodsVerInfo;
    }

    /** 서비스홈페이지URL 설정 */
    public void setGoodsHmpgUrl(String goodsHmpgUrl) {
        this.goodsHmpgUrl = goodsHmpgUrl;
    }

    /** 서비스홈페이지URL 추출 */
    public String getGoodsHmpgUrl() {
        return goodsHmpgUrl;
    }

    /** 서비스개요 설정 */
    public void setGoodsSumry(String goodsSumry) {
        this.goodsSumry = goodsSumry;
    }

    /** 서비스개요 추출 */
    public String getGoodsSumry() {
        return goodsSumry;
    }

    /** 서비스주요기능 설정 */
    public void setGoodsMainFnct(String goodsMainFnct) {
        this.goodsMainFnct = goodsMainFnct;
    }

    /** 서비스주요기능 추출 */
    public String getGoodsMainFnct() {
        return goodsMainFnct;
    }

    /** 서비스레퍼런스 설정 */
    public void setGoodsRefer(String goodsRefer) {
        this.goodsRefer = goodsRefer;
    }

    /** 서비스레퍼런스 추출 */
    public String getGoodsRefer() {
        return goodsRefer;
    }

    /** 서비스다운로드URL 설정 */
    public void setGoodsDwldUrl(String goodsDwldUrl) {
        this.goodsDwldUrl = goodsDwldUrl;
    }

    /** 서비스다운로드URL 추출 */
    public String getGoodsDwldUrl() {
        return goodsDwldUrl;
    }

    /** 판매방식코드 설정 */
    public void setSleMthdCd(Integer sleMthdCd) {
        this.sleMthdCd = sleMthdCd;
    }

    /** 판매방식코드 추출 */
    public Integer getSleMthdCd() {
        return sleMthdCd;
    }

    /** 서비스파일일련 설정 */
    public void setGoodsFileSeq(Integer goodsFileSeq) {
        this.goodsFileSeq = goodsFileSeq;
    }

    /** 서비스파일일련 추출 */
    public Integer getGoodsFileSeq() {
        return goodsFileSeq;
    }

    /** 데모체험URL 설정 */
    public void setDemoExprnUrl(String demoExprnUrl) {
        this.demoExprnUrl = demoExprnUrl;
    }

    /** 데모체험URL 추출 */
    public String getDemoExprnUrl() {
        return demoExprnUrl;
    }

    /** 서비스제조사 설정 */
    public void setGoodsMakr(String goodsMakr) {
        this.goodsMakr = goodsMakr;
    }

    /** 서비스제조사 추출 */
    public String getGoodsMakr() {
        return goodsMakr;
    }

    /** 서비스등록상태 설정 */
    public void setGoodsRegistSttus(Integer goodsRegistSttus) {
        this.goodsRegistSttus = goodsRegistSttus;
    }

    /** 서비스등록상태 추출 */
    public Integer getGoodsRegistSttus() {
        return goodsRegistSttus;
    }

    public Integer[] getQ_goodsRegistSttuses() {
        return q_goodsRegistSttuses;
    }

    public void setQ_goodsRegistSttuses(Integer[] q_goodsRegistSttuses) {
        this.q_goodsRegistSttuses = q_goodsRegistSttuses;
    }

    /** 서비스전시여부 설정 */
    public void setGoodsActvtyAt(String goodsActvtyAt) {
        this.goodsActvtyAt = goodsActvtyAt;
    }

    /** 서비스전시여부 추출 */
    public String getGoodsActvtyAt() {
        return goodsActvtyAt;
    }

    /** 등록아이디 설정 */
    public void setRegistId(String registId) {
        this.registId = registId;
    }

    /** 등록아이디 추출 */
    public String getRegistId() {
        return registId;
    }

    /** 등록일시 설정 */
    public void setRegistDt(String registDt) {
        this.registDt = registDt;
    }

    /** 등록일시 추출 */
    public String getRegistDt() {
        return registDt;
    }

    /** 수정아이디 설정 */
    public void setUpdtId(String updtId) {
        this.updtId = updtId;
    }

    /** 수정아이디 추출 */
    public String getUpdtId() {
        return updtId;
    }

    /** 수정일시 설정 */
    public void setUpdtDt(String updtDt) {
        this.updtDt = updtDt;
    }

    /** 수정일시 추출 */
    public String getUpdtDt() {
        return updtDt;
    }

    /** 서비스조회수 설정 */
    public void setGoodsRdcnt(Integer goodsRdcnt) {
        this.goodsRdcnt = goodsRdcnt;
    }

    /** 서비스조회수 추출 */
    public Integer getGoodsRdcnt() {
        return goodsRdcnt;
    }

    public String getReturnResn() {
        return returnResn;
    }

    public void setReturnResn(String returnResn) {
        this.returnResn = returnResn;
    }

    /** 검토반려사유 설정 */
    public void setExmntReturnResn(String exmntReturnResn) {
        this.exmntReturnResn = exmntReturnResn;
    }

    /** 검토반려사유 추출 */
    public String getExmntReturnResn() {
        return exmntReturnResn;
    }

    /** 승인반려사유 설정 */
    public void setConfmReturnResn(String confmReturnResn) {
        this.confmReturnResn = confmReturnResn;
    }

    /** 승인반려사유 추출 */
    public String getConfmReturnResn() {
        return confmReturnResn;
    }


    public Integer getConfmReturnSection() {
        return confmReturnSection;
    }

    public void setConfmReturnSection(Integer confmReturnSection) {
        this.confmReturnSection = confmReturnSection;
    }

    public Integer getExmntConfmCd() {
        return exmntConfmCd;
    }

    public void setExmntConfmCd(Integer exmntConfmCd) {
        this.exmntConfmCd = exmntConfmCd;
    }

    public Integer getExmntConfmHistSn() {
        return exmntConfmHistSn;
    }

    public void setExmntConfmHistSn(Integer exmntConfmHistSn) {
        this.exmntConfmHistSn = exmntConfmHistSn;
    }
    
    
    /**
     * Integer[] exmntConfmHistSns을 반환
     * @return Integer[] exmntConfmHistSns
     */
    public Integer[] getExmntConfmHistSns() {
        return exmntConfmHistSns;
    }


    
    /**
     * exmntConfmHistSns을 설정
     * @param exmntConfmHistSns 을(를) Integer[] exmntConfmHistSns로 설정
     */
    public void setExmntConfmHistSns(Integer[] exmntConfmHistSns) {
        this.exmntConfmHistSns = exmntConfmHistSns;
    }


    /**
     * Integer goodsChngSeq을 반환
     * @return Integer goodsChngSeq
     */
    public Integer getGoodsChngSeq() {
        return goodsChngSeq;
    }


    
    /**
     * goodsChngSeq을 설정
     * @param goodsChngSeq 을(를) Integer goodsChngSeq로 설정
     */
    public void setGoodsChngSeq(Integer goodsChngSeq) {
        this.goodsChngSeq = goodsChngSeq;
    }

    

    
    /**
     * List<FileVO> gcFile을 반환
     * @return List<FileVO> gcFile
     */
    public List<FileVO> getGcFile() {
        return gcFile;
    }


    
    /**
     * gcFile을 설정
     * @param gcFile 을(를) List<FileVO> gcFile로 설정
     */
    public void setGcFile(List<FileVO> gcFile) {
        this.gcFile = gcFile;
    }


    /**
     * Integer goodsChngPc을 반환
     * @return String goodsChngPc
     */
    public String getGoodsChngPc() {
        return goodsChngPc;
    }


    
    /**
     * goodsChngPc을 설정
     * @param goodsChngPc 을(를) String goodsChngPc로 설정
     */
    public void setGoodsChngPc(String goodsChngPc) {
        this.goodsChngPc = goodsChngPc;
    }


    
    /**
     * Integer goodsBeforPc을 반환
     * @return Integer goodsBeforPc
     */
    public String getGoodsBeforPc() {
        return goodsBeforPc;
    }


    
    /**
     * goodsBeforPc을 설정
     * @param goodsBeforPc 을(를) Integer goodsBeforPc로 설정
     */
    public void setGoodsBeforPc(String goodsBeforPc) {
        this.goodsBeforPc = goodsBeforPc;
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

    public String getDeptNm() {
        return deptNm;
    }

    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }

    public String getTelno() {
        return telno;
    }

    public void setTelno(String telno) {
        this.telno = telno;
    }

    public String getDeptTelno() {
        return deptTelno;
    }

    public void setDeptTelno(String deptTelno) {
        this.deptTelno = deptTelno;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    /** 관리자삭제여부 설정 */
    public void setMngrDeleteAt(String mngrDeleteAt) {
        this.mngrDeleteAt = mngrDeleteAt;
    }

    /** 관리자삭제여부 추출 */
    public String getMngrDeleteAt() {
        return mngrDeleteAt;
    }

    /** 삭제관리자아이디 설정 */
    public void setDeleteMngrId(String deleteMngrId) {
        this.deleteMngrId = deleteMngrId;
    }

    /** 삭제관리자아이디 추출 */
    public String getDeleteMngrId() {
        return deleteMngrId;
    }

    /** 삭제관리자부서코드 설정 */
    public void setDeleteMngrDeptCode(String deleteMngrDeptCode) {
        this.deleteMngrDeptCode = deleteMngrDeptCode;
    }

    /** 삭제관리자부서코드 추출 */
    public String getDeleteMngrDeptCode() {
        return deleteMngrDeptCode;
    }

    /**
     * String langStoreNm을 반환
     *
     * @return String langStoreNm
     */
    public String getLangStoreNm() {
        return langStoreNm;
    }

    /**
     * langStoreNm을 설정
     *
     * @param langStoreNm 을(를) String langStoreNm로 설정
     */
    public void setLangStoreNm(String langStoreNm) {
        this.langStoreNm = langStoreNm;
    }

    /**
     * String langNm을 반환
     *
     * @return String langNm
     */
    public String getLangNm() {
        return langNm;
    }

    /**
     * langNm을 설정
     *
     * @param langNm 을(를) String langNm로 설정
     */
    public void setLangNm(String langNm) {
        this.langNm = langNm;
    }


    public String getLangEngNm() {
        return langEngNm;
    }


    public void setLangEngNm(String langEngNm) {
        this.langEngNm = langEngNm;
    }

    /**
     * String sleMthdNm을 반환
     *
     * @return String sleMthdNm
     */
    public String getSleMthdNm() {
        return sleMthdNm;
    }

    /**
     * sleMthdNm을 설정
     *
     * @param sleMthdNm 을(를) String sleMthdNm로 설정
     */
    public void setSleMthdNm(String sleMthdNm) {
        this.sleMthdNm = sleMthdNm;
    }

    /**
     * String goodsTyNm을 반환
     *
     * @return String goodsTyNm
     */
    public String getGoodsTyNm() {
        return goodsTyNm;
    }

    /**
     * goodsTyNm을 설정
     *
     * @param goodsTyNm 을(를) String goodsTyNm로 설정
     */
    public void setGoodsTyNm(String goodsTyNm) {
        this.goodsTyNm = goodsTyNm;
    }

    /**
     * List<Map<String,Object>> goodsType을 반환
     *
     * @return List<Map<String,Object>> goodsType
     */
    public List<Map<String, Object>> getGoodsType() {
        return goodsType;
    }

    /**
     * goodsType을 설정
     *
     * @param goodsType 을(를) List<Map<String,Object>> goodsType로 설정
     */
    public void setCategory(List<Map<String, Object>> goodsType) {
        this.goodsType = goodsType;
    }

    /**
     * goodsType을 설정
     *
     * @param goodsType 을(를) List<Map<String,Object>> goodsType로 설정
     */
    public void setGoodsType(List<Map<String, Object>> goodsType) {
        this.goodsType = goodsType;
    }

    /**
     * String goodsRegistSttusNm을 반환
     *
     * @return String goodsRegistSttusNm
     */
    public String getGoodsRegistSttusNm() {
        return goodsRegistSttusNm;
    }

    /**
     * goodsRegistSttusNm을 설정
     *
     * @param goodsRegistSttusNm 을(를) String goodsRegistSttusNm로 설정
     */
    public void setGoodsRegistSttusNm(String goodsRegistSttusNm) {
        this.goodsRegistSttusNm = goodsRegistSttusNm;
    }

    /**
     * String ctgryCd을 반환
     *
     * @return String ctgryCd
     */
    public String getCtgryCd() {
        return ctgryCd;
    }

    /**
     * ctgryCd을 설정
     *
     * @param ctgryCd 을(를) String ctgryCd로 설정
     */
    public void setCtgryCd(String ctgryCd) {
        this.ctgryCd = ctgryCd;
    }

    /**
     * Integer ctgryDp을 반환
     *
     * @return Integer ctgryDp
     */
    public Integer getCtgryDp() {
        return ctgryDp;
    }

    /**
     * ctgryDp을 설정
     *
     * @param ctgryDp 을(를) Integer ctgryDp로 설정
     */
    public void setCtgryDp(Integer ctgryDp) {
        this.ctgryDp = ctgryDp;
    }

    /**
     * String ctgryNm을 반환
     *
     * @return String ctgryNm
     */
    public String getCtgryNm() {
        return ctgryNm;
    }

    /**
     * ctgryNm을 설정
     *
     * @param ctgryNm 을(를) String ctgryNm로 설정
     */
    public void setCtgryNm(String ctgryNm) {
        this.ctgryNm = ctgryNm;
    }

    /**
     * String parntsCtgryCd을 반환
     *
     * @return String parntsCtgryCd
     */
    public String getParntsCtgryCd() {
        return parntsCtgryCd;
    }

    /**
     * parntsCtgryCd을 설정
     *
     * @param parntsCtgryCd 을(를) String parntsCtgryCd로 설정
     */
    public void setParntsCtgryCd(String parntsCtgryCd) {
        this.parntsCtgryCd = parntsCtgryCd;
    }

    /**
     * List<String> langCodes을 반환
     *
     * @return List<String> langCodes
     */
    public List<String> getLangCodes() {
        return langCodes;
    }

    /**
     * langCodes을 설정
     *
     * @param langCodes 을(를) List<String> langCodes로 설정
     */
    public void setLangCodes(List<String> langCodes) {
        this.langCodes = langCodes;
    }

    /**
     * List<Map<String,Object>> goodsCtgry을 반환
     *
     * @return List<Map<String,Object>> goodsCtgry
     */
    public List<Map<String, Object>> getGoodsCtgry() {
        return goodsCtgry;
    }

    /**
     * goodsCtgry을 설정
     *
     * @param goodsCtgry 을(를) List<Map<String,Object>> goodsCtgry로 설정
     */
    public void setGoodsCtgry(List<Map<String, Object>> goodsCtgry) {
        this.goodsCtgry = goodsCtgry;
    }

    /**
     * String[] ctgryCds을 반환
     *
     * @return String[] ctgryCds
     */
    public String[] getCtgryCds() {
        return ctgryCds;
    }

    /**
     * ctgryCds을 설정
     *
     * @param ctgryCds 을(를) String[] ctgryCds로 설정
     */
    public void setCtgryCds(String[] ctgryCds) {
        this.ctgryCds = ctgryCds;
    }

    /**
     * List<Map<String,Object>> goodsStore을 반환
     *
     * @return List<Map<String,Object>> goodsStore
     */
    public List<Map<String, Object>> getGoodsStore() {
        return goodsStore;
    }

    /**
     * goodsStore을 설정
     *
     * @param goodsStore 을(를) List<Map<String,Object>> goodsStore로 설정
     */
    public void setGoodsStore(List<Map<String, Object>> goodsStore) {
        this.goodsStore = goodsStore;
    }

    /**
     * List<Map<String,Object>> goodsTag을 반환
     *
     * @return List<Map<String,Object>> goodsTag
     */
    public List<Map<String, Object>> getGoodsTag() {
        return goodsTag;
    }

    /**
     * goodsTag을 설정
     *
     * @param goodsTag 을(를) List<Map<String,Object>> goodsTag로 설정
     */
    public void setGoodsTag(List<Map<String, Object>> goodsTag) {
        this.goodsTag = goodsTag;
    }

    /**
     * List<FileVO> imageFile을 반환
     *
     * @return List<FileVO> imageFile
     */
    public List<FileVO> getImageFile() {
        return imageFile;
    }

    /**
     * imageFile을 설정
     *
     * @param imageFile 을(를) List<FileVO> imageFile로 설정
     */
    public void setImageFile(List<FileVO> imageFile) {
        this.imageFile = imageFile;
    }

    /**
     * long goodsImageFileSeq을 반환
     *
     * @return Integer goodsImageFileSeq
     */
    public Integer getGoodsImageFileSeq() {
        return goodsImageFileSeq;
    }

    /**
     * goodsImageFileSeq을 설정
     *
     * @param goodsImageFileSeq 을(를) Integer goodsImageFileSeq로 설정
     */
    public void setGoodsImageFileSeq(Integer goodsImageFileSeq) {
        this.goodsImageFileSeq = goodsImageFileSeq;
    }

    /**
     * List<FileVO> goodsFile을 반환
     *
     * @return List<FileVO> goodsFile
     */
    public List<FileVO> getGoodsFile() {
        return goodsFile;
    }

    /**
     * goodsFile을 설정
     *
     * @param goodsFile 을(를) List<FileVO> goodsFile로 설정
     */
    public void setGoodsFile(List<FileVO> goodsFile) {
        this.goodsFile = goodsFile;
    }

    /**
     * List<FileVO> mnlFile을 반환
     *
     * @return List<FileVO> mnlFile
     */
    public List<FileVO> getMnlFile() {
        return mnlFile;
    }

    /**
     * mnlFile을 설정
     *
     * @param mnlFile 을(를) List<FileVO> mnlFile로 설정
     */
    public void setMnlFile(List<FileVO> mnlFile) {
        this.mnlFile = mnlFile;
    }

    /**
     * Integer goodsMnlFileSeq을 반환
     *
     * @return Integer goodsMnlFileSeq
     */
    public Integer getGoodsMnlFileSeq() {
        return goodsMnlFileSeq;
    }

    /**
     * goodsMnlFileSeq을 설정
     *
     * @param goodsMnlFileSeq 을(를) Integer goodsMnlFileSeq로 설정
     */
    public void setGoodsMnlFileSeq(Integer goodsMnlFileSeq) {
        this.goodsMnlFileSeq = goodsMnlFileSeq;
    }
    
    
    
    /**
     * Integer goodsMnlFileSeq1을 반환
     * @return Integer goodsMnlFileSeq1
     */
    public Integer getGoodsMnlFileSeq1() {
        return goodsMnlFileSeq1;
    }


    
    /**
     * goodsMnlFileSeq1을 설정
     * @param goodsMnlFileSeq1 을(를) Integer goodsMnlFileSeq1로 설정
     */
    public void setGoodsMnlFileSeq1(Integer goodsMnlFileSeq1) {
        this.goodsMnlFileSeq1 = goodsMnlFileSeq1;
    }


    /**
     * List<Map<String,Object>> goodsMark을 반환
     *
     * @return List<Map<String,Object>> goodsMark
     */
    public List<Map<String, Object>> getGoodsMark() {
        return goodsMark;
    }

    /**
     * goodsMark을 설정
     *
     * @param goodsMark 을(를) List<Map<String,Object>> goodsMark로 설정
     */
    public void setGoodsMark(List<Map<String, Object>> goodsMark) {
        this.goodsMark = goodsMark;
    }

    public List<Map<String, Object>> getGoodsMarkList() {
        return goodsMarkList;
    }

    public void setGoodsMarkList(List<Map<String, Object>> goodsMarkList) {
        this.goodsMarkList = goodsMarkList;
    }

    /**
     * List<List<FileVO>> markFile을 반환
     *
     * @return List<List<FileVO>> markFile
     */
    public List<List<FileVO>> getMarkFile() {
        return markFile;
    }

    /**
     * markFile을 설정
     *
     * @param markFile 을(를) List<List<FileVO>> markFile로 설정
     */
    public void setMarkFile(List<List<FileVO>> markFile) {
        this.markFile = markFile;
    }

    /**
     * List<List<FileVO>> markCrtfcFile을 반환
     *
     * @return List<List<FileVO>> markCrtfcFile
     */
    public List<List<FileVO>> getMarkCrtfcFile() {
        return markCrtfcFile;
    }

    /**
     * markCrtfcFile을 설정
     *
     * @param markCrtfcFile 을(를) List<List<FileVO>> markCrtfcFile로 설정
     */
    public void setMarkCrtfcFile(List<List<FileVO>> markCrtfcFile) {
        this.markCrtfcFile = markCrtfcFile;
    }

    /**
     * Integer[] crtfcSeFileSeq을 반환
     *
     * @return Integer[] crtfcSeFileSeq
     */
    public Integer[] getCrtfcSeFileSeqs() {
        return crtfcSeFileSeqs;
    }

    /**
     * crtfcSeFileSeq을 설정
     *
     * @param crtfcSeFileSeq 을(를) Integer[] crtfcSeFileSeq로 설정
     */
    public void setCrtfcSeFileSeqs(Integer[] crtfcSeFileSeqs) {
        this.crtfcSeFileSeqs = crtfcSeFileSeqs;
    }

    public Integer[] getQ_crtfcCodes() {
        return q_crtfcCodes;
    }

    public void setQ_crtfcCodes(Integer[] q_crtfcCodes) {
        this.q_crtfcCodes = q_crtfcCodes;
    }

    /**
     * Integer[] markCds을 반환
     *
     * @return Integer[] markCds
     */
    public Integer[] getMarkCds() {
        return markCds;
    }

    /**
     * markCds을 설정
     *
     * @param markCds 을(를) Integer[] markCds로 설정
     */
    public void setMarkCds(Integer[] markCds) {
        this.markCds = markCds;
    }

    /**
     * Integer markCd을 반환
     *
     * @return Integer markCd
     */
    public Integer getMarkCd() {
        return markCd;
    }

    /**
     * markCd을 설정
     *
     * @param markCd 을(를) Integer markCd로 설정
     */
    public void setMarkCd(Integer markCd) {
        this.markCd = markCd;
    }

    /**
     * Integer[] goodsMarkCds을 반환
     *
     * @return Integer[] goodsMarkCds
     */
    public Integer[] getGoodsMarkCds() {
        return goodsMarkCds;
    }

    /**
     * goodsMarkCds을 설정
     *
     * @param goodsMarkCds 을(를) Integer[] goodsMarkCds로 설정
     */
    public void setGoodsMarkCds(Integer[] goodsMarkCds) {
        this.goodsMarkCds = goodsMarkCds;
    }

    /**
     * Integer crtfcSeFileSeq을 반환
     *
     * @return Integer crtfcSeFileSeq
     */
    public Integer getCrtfcSeFileSeq() {
        return crtfcSeFileSeq;
    }

    /**
     * crtfcSeFileSeq을 설정
     *
     * @param crtfcSeFileSeq 을(를) Integer crtfcSeFileSeq로 설정
     */
    public void setCrtfcSeFileSeq(Integer crtfcSeFileSeq) {
        this.crtfcSeFileSeq = crtfcSeFileSeq;
    }

    /**
     * String goodsTagNm을 반환
     *
     * @return String goodsTagNm
     */
    public String getGoodsTagNm() {
        return goodsTagNm;
    }

    /**
     * goodsTagNm을 설정
     *
     * @param goodsTagNm 을(를) String goodsTagNm로 설정
     */
    public void setGoodsTagNm(String goodsTagNm) {
        this.goodsTagNm = goodsTagNm;
    }

    /**
     * String ctgryCode을 반환
     *
     * @return String ctgryCode
     */
    public String getCtgryCode() {
        return ctgryCode;
    }

    /**
     * ctgryCode을 설정
     *
     * @param ctgryCode 을(를) String ctgryCode로 설정
     */
    public void setCtgryCode(String ctgryCode) {
        this.ctgryCode = ctgryCode;
    }

    /**
     * String[] ctgryCodes을 반환
     *
     * @return String[] ctgryCodes
     */
    public String[] getCtgryCodes() {
        return ctgryCodes;
    }

    /**
     * ctgryCodes을 설정
     *
     * @param ctgryCodes 을(를) String[] ctgryCodes로 설정
     */
    public void setCtgryCodes(String[] ctgryCodes) {
        this.ctgryCodes = ctgryCodes;
    }

    /**
     * String ctgryClNm을 반환
     *
     * @return String ctgryClNm
     */
    public String getCtgryClNm() {
        return ctgryClNm;
    }

    /**
     * ctgryClNm을 설정
     *
     * @param ctgryClNm 을(를) String ctgryClNm로 설정
     */
    public void setCtgryClNm(String ctgryClNm) {
        this.ctgryClNm = ctgryClNm;
    }

    /**
     * String ctgryPath을 반환
     *
     * @return String ctgryPath
     */
    public String getCtgryPath() {
        return ctgryPath;
    }

    /**
     * ctgryPath을 설정
     *
     * @param ctgryPath 을(를) String ctgryPath로 설정
     */
    public void setCtgryPath(String ctgryPath) {
        this.ctgryPath = ctgryPath;
    }

    /**
     * String goodsChargerNm을 반환
     *
     * @return String goodsChargerNm
     */
    public String getGoodsChargerNm() {
        return goodsChargerNm;
    }

    /**
     * goodsChargerNm을 설정
     *
     * @param goodsChargerNm 을(를) String goodsChargerNm로 설정
     */
    public void setGoodsChargerNm(String goodsChargerNm) {
        this.goodsChargerNm = goodsChargerNm;
    }

    /**
     * String goodsChargerEmail을 반환
     *
     * @return String goodsChargerEmail
     */
    public String getGoodsChargerEmail() {
        return goodsChargerEmail;
    }

    /**
     * goodsChargerEmail을 설정
     *
     * @param goodsChargerEmail 을(를) String goodsChargerEmail로 설정
     */
    public void setGoodsChargerEmail(String goodsChargerEmail) {
        this.goodsChargerEmail = goodsChargerEmail;
    }

    /**
     * String goodsChargerCttpc을 반환
     *
     * @return String goodsChargerCttpc
     */
    public String getGoodsChargerCttpc() {
        return goodsChargerCttpc;
    }

    /**
     * goodsChargerCttpc을 설정
     *
     * @param goodsChargerCttpc 을(를) String goodsChargerCttpc로 설정
     */
    public void setGoodsChargerCttpc(String goodsChargerCttpc) {
        this.goodsChargerCttpc = goodsChargerCttpc;
    }

    /**
     * String cnslExpcEffect을 반환
     *
     * @return String cnslExpcEffect
     */
    public String getCnslExpcEffect() {
        return cnslExpcEffect;
    }

    /**
     * cnslExpcEffect을 설정
     *
     * @param cnslExpcEffect 을(를) String cnslExpcEffect로 설정
     */
    public void setCnslExpcEffect(String cnslExpcEffect) {
        this.cnslExpcEffect = cnslExpcEffect;
    }

    /**
     * Integer cntcInsttCd을 반환
     *
     * @return Integer cntcInsttCd
     */
    public Integer getCntcInsttCd() {
        return cntcInsttCd;
    }

    /**
     * cntcInsttCd을 설정
     *
     * @param cntcInsttCd 을(를) Integer cntcInsttCd로 설정
     */
    public void setCntcInsttCd(Integer cntcInsttCd) {
        this.cntcInsttCd = cntcInsttCd;
    }

    /**
     * Integer cnstntCo을 반환
     *
     * @return Integer cnstntCo
     */
    public Integer getCnstntCo() {
        return cnstntCo;
    }

    /**
     * cnstntCo을 설정
     *
     * @param cnstntCo 을(를) Integer cnstntCo로 설정
     */
    public void setCnstntCo(Integer cnstntCo) {
        this.cnstntCo = cnstntCo;
    }

    /**
     * String spcltyRealm을 반환
     *
     * @return String spcltyRealm
     */
    public String getSpcltyRealm() {
        return spcltyRealm;
    }

    /**
     * spcltyRealm을 설정
     *
     * @param spcltyRealm 을(를) String spcltyRealm로 설정
     */
    public void setSpcltyRealm(String spcltyRealm) {
        this.spcltyRealm = spcltyRealm;
    }

    /**
     * List<Map<String,Object>> cngdMarkList을 반환
     *
     * @return List<Map<String,Object>> cngdMarkList
     */
    public List<Map<String, Object>> getCngdMarkList() {
        return cngdMarkList;
    }

    /**
     * cngdMarkList을 설정
     *
     * @param cngdMarkList 을(를) List<Map<String,Object>> cngdMarkList로 설정
     */
    public void setCngdMarkList(List<Map<String, Object>> cngdMarkList) {
        this.cngdMarkList = cngdMarkList;
    }

    /**
     * List<FileVO> cngdMarkFile을 반환
     *
     * @return List<FileVO> cngdMarkFile
     */
    public List<FileVO> getCngdMarkFile() {
        return cngdMarkFile;
    }

    /**
     * cngdMarkFile을 설정
     *
     * @param cngdMarkFile 을(를) List<FileVO> cngdMarkFile로 설정
     */
    public void setCngdMarkFile(List<FileVO> cngdMarkFile) {
        this.cngdMarkFile = cngdMarkFile;
    }

    /**
     * Integer ctgryClCd을 반환
     *
     * @return Integer ctgryClCd
     */
    public Integer getCtgryClCd() {
        return ctgryClCd;
    }

    /**
     * ctgryClCd을 설정
     *
     * @param ctgryClCd 을(를) Integer ctgryClCd로 설정
     */
    public void setCtgryClCd(Integer ctgryClCd) {
        this.ctgryClCd = ctgryClCd;
    }

    /**
     * String goodsPc을 반환
     *
     * @return String goodsPc
     */
    public String getGoodsPc() {
        return goodsPc;
    }

    /**
     * goodsPc을 설정
     *
     * @param goodsPc 을(를) String goodsPc로 설정
     */
    public void setGoodsPc(String goodsPc) {
        this.goodsPc = goodsPc;
    }

    /**
     * String nationGrp을 반환
     *
     * @return String nationGrp
     */
    public String getNationGrp() {
        return nationGrp;
    }

    /**
     * nationGrp을 설정
     *
     * @param nationGrp 을(를) String nationGrp로 설정
     */
    public void setNationGrp(String nationGrp) {
        this.nationGrp = nationGrp;
    }

    /**
     * String userTyGrp을 반환
     *
     * @return String userTyGrp
     */
    public String getUserTyGrp() {
        return userTyGrp;
    }

    /**
     * userTyGrp을 설정
     *
     * @param userTyGrp 을(를) String userTyGrp로 설정
     */
    public void setUserTyGrp(String userTyGrp) {
        this.userTyGrp = userTyGrp;
    }

    /**
     * String comouDe을 반환
     *
     * @return String comouDe
     */
    public String getComouDe() {
        return comouDe;
    }

    /**
     * comouDe을 설정
     *
     * @param comouDe 을(를) String comouDe로 설정
     */
    public void setComouDe(String comouDe) {
        this.comouDe = comouDe;
    }

    /**
     * Integer goodsLicenceCd을 반환
     *
     * @return Integer goodsLicenceCd
     */
    public Integer getGoodsLicenceCd() {
        return goodsLicenceCd;
    }

    /**
     * goodsLicenceCd을 설정
     *
     * @param goodsLicenceCd 을(를) Integer goodsLicenceCd로 설정
     */
    public void setGoodsLicenceCd(Integer goodsLicenceCd) {
        this.goodsLicenceCd = goodsLicenceCd;
    }

    /**
     * String goodsLicenceCn을 반환
     *
     * @return String goodsLicenceCn
     */
    public String getGoodsLicenceCn() {
        return goodsLicenceCn;
    }

    /**
     * goodsLicenceCn을 설정
     *
     * @param goodsLicenceCn 을(를) String goodsLicenceCn로 설정
     */
    public void setGoodsLicenceCn(String goodsLicenceCn) {
        this.goodsLicenceCn = goodsLicenceCn;
    }

    /**
     * Integer archtcSe을 반환
     *
     * @return Integer archtcSe
     */
    public Integer getArchtcSe() {
        return archtcSe;
    }

    /**
     * archtcSe을 설정
     *
     * @param archtcSe 을(를) Integer archtcSe로 설정
     */
    public void setArchtcSe(Integer archtcSe) {
        this.archtcSe = archtcSe;
    }

    /**
     * String goodsChargerMbtlnum을 반환
     *
     * @return String goodsChargerMbtlnum
     */
    public String getGoodsChargerMbtlnum() {
        return goodsChargerMbtlnum;
    }

    /**
     * goodsChargerMbtlnum을 설정
     *
     * @param goodsChargerMbtlnum 을(를) String goodsChargerMbtlnum로 설정
     */
    public void setGoodsChargerMbtlnum(String goodsChargerMbtlnum) {
        this.goodsChargerMbtlnum = goodsChargerMbtlnum;
    }

    /**
     * List<Map<String,Object>> goodsMetaLang을 반환
     *
     * @return List<Map<String,Object>> goodsMetaLang
     */
    public List<Map<String, Object>> getGoodsMetaLang() {
        return goodsMetaLang;
    }

    /**
     * goodsMetaLang을 설정
     *
     * @param goodsMetaLang 을(를) List<Map<String,Object>> goodsMetaLang로 설정
     */
    public void setGoodsMetaLang(List<Map<String, Object>> goodsMetaLang) {
        this.goodsMetaLang = goodsMetaLang;
    }

    /**
     * List<Map<String,Object>> goodsMetaOS을 반환
     *
     * @return List<Map<String,Object>> goodsMetaOS
     */
    public List<Map<String, Object>> getGoodsMetaOS() {
        return goodsMetaOS;
    }

    /**
     * goodsMetaOS을 설정
     *
     * @param goodsMetaOS 을(를) List<Map<String,Object>> goodsMetaOS로 설정
     */
    public void setGoodsMetaOS(List<Map<String, Object>> goodsMetaOS) {
        this.goodsMetaOS = goodsMetaOS;
    }

    /**
     * List<Map<String,Object>> goodsMetaAS을 반환
     *
     * @return List<Map<String,Object>> goodsMetaAS
     */
    public List<Map<String, Object>> getGoodsMetaAS() {
        return goodsMetaAS;
    }

    /**
     * goodsMetaAS을 설정
     *
     * @param goodsMetaAS 을(를) List<Map<String,Object>> goodsMetaAS로 설정
     */
    public void setGoodsMetaAS(List<Map<String, Object>> goodsMetaAS) {
        this.goodsMetaAS = goodsMetaAS;
    }

    /**
     * String goodsLicenceNm을 반환
     *
     * @return String goodsLicenceNm
     */
    public String getGoodsLicenceNm() {
        return goodsLicenceNm;
    }

    /**
     * goodsLicenceNm을 설정
     *
     * @param goodsLicenceNm 을(를) String goodsLicenceNm로 설정
     */
    public void setGoodsLicenceNm(String goodsLicenceNm) {
        this.goodsLicenceNm = goodsLicenceNm;
    }

    /**
     * Integer goodsKndCd을 반환
     *
     * @return Integer goodsKndCd
     */
    public Integer getGoodsKndCd() {
        return goodsKndCd;
    }

    /**
     * goodsKndCd을 설정
     *
     * @param goodsKndCd 을(를) Integer goodsKndCd로 설정
     */
    public void setGoodsKndCd(Integer goodsKndCd) {
        this.goodsKndCd = goodsKndCd;
    }

    /**
     * String goodsKndNm을 반환
     *
     * @return String goodsKndNm
     */
    public String getGoodsKndNm() {
        return goodsKndNm;
    }

    /**
     * goodsKndNm을 설정
     *
     * @param goodsKndNm 을(를) String goodsKndNm로 설정
     */
    public void setGoodsKndNm(String goodsKndNm) {
        this.goodsKndNm = goodsKndNm;
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
     * Integer[] archtcSeArry을 반환
     * @return Integer[] archtcSeArry
     */
    public Integer[] getArchtcSeArry() {
        return archtcSeArry;
    }

    /**
     * archtcSeArry을 설정
     * @param archtcSeArry 을(를) Integer[] archtcSeArry로 설정
     */
    public void setArchtcSeArry(Integer[] archtcSeArry) {
        this.archtcSeArry = archtcSeArry;
    }

    /**
     * Integer metaLangCd을 반환
     * @return Integer metaLangCd
     */
    public Integer getMetaLangCd() {
        return metaLangCd;
    }

    /**
     * metaLangCd을 설정
     * @param metaLangCd 을(를) Integer metaLangCd로 설정
     */
    public void setMetaLangCd(Integer metaLangCd) {
        this.metaLangCd = metaLangCd;
    }

    /**
     * String metaLangNm을 반환
     * @return String metaLangNm
     */
    public String getMetaLangNm() {
        return metaLangNm;
    }

    /**
     * metaLangNm을 설정
     * @param metaLangNm 을(를) String metaLangNm로 설정
     */
    public void setMetaLangNm(String metaLangNm) {
        this.metaLangNm = metaLangNm;
    }

    /**
     * Integer metaGroupCd을 반환
     * @return Integer metaGroupCd
     */
    public Integer getMetaGroupCd() {
        return metaGroupCd;
    }

    /**
     * metaGroupCd을 설정
     * @param metaGroupCd 을(를) Integer metaGroupCd로 설정
     */
    public void setMetaGroupCd(Integer metaGroupCd) {
        this.metaGroupCd = metaGroupCd;
    }

    /**
     * Integer metaCode을 반환
     * @return Integer metaCode
     */
    public Integer getMetaCode() {
        return metaCode;
    }

    /**
     * metaCode을 설정
     * @param metaCode 을(를) Integer metaCode로 설정
     */
    public void setMetaCode(Integer metaCode) {
        this.metaCode = metaCode;
    }

    /**
     * String metaEtcCn을 반환
     * @return String metaEtcCn
     */
    public String getMetaEtcCn() {
        return metaEtcCn;
    }

    /**
     * metaEtcCn을 설정
     * @param metaEtcCn 을(를) String metaEtcCn로 설정
     */
    public void setMetaEtcCn(String metaEtcCn) {
        this.metaEtcCn = metaEtcCn;
    }

    /**
     * String goodsTags을 반환
     * @return String goodsTags
     */
    public String getGoodsTags() {
        return goodsTags;
    }

    /**
     * goodsTags을 설정
     * @param goodsTags 을(를) String goodsTags로 설정
     */
    public void setGoodsTags(String goodsTags) {
        this.goodsTags = goodsTags;
    }

    /**
     * Integer[] metaLangs을 반환
     * @return Integer[] metaLangs
     */
    public Integer[] getMetaLangs() {
        return metaLangs;
    }

    /**
     * metaLangs을 설정
     * @param metaLangs 을(를) Integer[] metaLangs로 설정
     */
    public void setMetaLangs(Integer[] metaLangs) {
        this.metaLangs = metaLangs;
    }

    /**
     * String metaLangEtc을 반환
     * @return String metaLangEtc
     */
    public String getMetaLangEtc() {
        return metaLangEtc;
    }

    /**
     * metaLangEtc을 설정
     * @param metaLangEtc 을(를) String metaLangEtc로 설정
     */
    public void setMetaLangEtc(String metaLangEtc) {
        this.metaLangEtc = metaLangEtc;
    }

    /**
     * String metaOSs을 반환
     * @return String metaOSs
     */
    public String getMetaOSs() {
        return metaOSs;
    }

    /**
     * metaOSs을 설정
     * @param metaOSs 을(를) String metaOSs로 설정
     */
    public void setMetaOSs(String metaOSs) {
        this.metaOSs = metaOSs;
    }

    /**
     * String metaOSetc을 반환
     * @return String metaOSetc
     */
    public String getMetaOSetc() {
        return metaOSetc;
    }

    /**
     * metaOSetc을 설정
     * @param metaOSetc 을(를) String metaOSetc로 설정
     */
    public void setMetaOSetc(String metaOSetc) {
        this.metaOSetc = metaOSetc;
    }

    /**
     * String metaASs을 반환
     * @return String metaASs
     */
    public String getMetaASs() {
        return metaASs;
    }

    /**
     * metaASs을 설정
     * @param metaASs 을(를) String metaASs로 설정
     */
    public void setMetaASs(String metaASs) {
        this.metaASs = metaASs;
    }

    /**
     * String metaASetc을 반환
     * @return String metaASetc
     */
    public String getMetaASetc() {
        return metaASetc;
    }

    /**
     * metaASetc을 설정
     * @param metaASetc 을(를) String metaASetc로 설정
     */
    public void setMetaASetc(String metaASetc) {
        this.metaASetc = metaASetc;
    }

    /**
     * String metaTECHs을 반환
     * @return String metaTECHs
     */
    public String getMetaTECHs() {
        return metaTECHs;
    }

    /**
     * metaTECHs을 설정
     * @param metaTECHs 을(를) String metaTECHs로 설정
     */
    public void setMetaTECHs(String metaTECHs) {
        this.metaTECHs = metaTECHs;
    }

    /**
     * String metaTECHetc을 반환
     * @return String metaTECHetc
     */
    public String getMetaTECHetc() {
        return metaTECHetc;
    }

    /**
     * metaTECHetc을 설정
     * @param metaTECHetc 을(를) String metaTECHetc로 설정
     */
    public void setMetaTECHetc(String metaTECHetc) {
        this.metaTECHetc = metaTECHetc;
    }

    /**
     * List<Map<String,Object>> goodsMetaTECH을 반환
     * @return List<Map<String,Object>> goodsMetaTECH
     */
    public List<Map<String, Object>> getGoodsMetaTECH() {
        return goodsMetaTECH;
    }

    /**
     * goodsMetaTECH을 설정
     * @param goodsMetaTECH 을(를) List<Map<String,Object>> goodsMetaTECH로 설정
     */
    public void setGoodsMetaTECH(List<Map<String, Object>> goodsMetaTECH) {
        this.goodsMetaTECH = goodsMetaTECH;
    }

    /**
     * String metaTAGs을 반환
     * @return String metaTAGs
     */
    public String getMetaTAGs() {
        return metaTAGs;
    }

    /**
     * metaTAGs을 설정
     * @param metaTAGs 을(를) String metaTAGs로 설정
     */
    public void setMetaTAGs(String metaTAGs) {
        this.metaTAGs = metaTAGs;
    }

    /**
     * List<Map<String,Object>> goodsMetaTAG을 반환
     * @return List<Map<String,Object>> goodsMetaTAG
     */
    public List<Map<String, Object>> getGoodsMetaTAG() {
        return goodsMetaTAG;
    }

    /**
     * goodsMetaTAG을 설정
     * @param goodsMetaTAG 을(를) List<Map<String,Object>> goodsMetaTAG로 설정
     */
    public void setGoodsMetaTAG(List<Map<String, Object>> goodsMetaTAG) {
        this.goodsMetaTAG = goodsMetaTAG;
    }


    public Integer getMailSection() {
        return mailSection;
    }


    public void setMailSection(Integer mailSection) {
        this.mailSection = mailSection;
    }

    /**
     * String exmntConfmDt을 반환
     * @return String exmntConfmDt
     */
    public String getExmntConfmDt() {
        return exmntConfmDt;
    }

    /**
     * exmntConfmDt을 설정
     * @param exmntConfmDt 을(를) String exmntConfmDt로 설정
     */
    public void setExmntConfmDt(String exmntConfmDt) {
        this.exmntConfmDt = exmntConfmDt;
    }

    /**
     * String exmntLimitDt을 반환
     * @return String exmntLimitDt
     */
    public String getExmntLimitDt() {
        return exmntLimitDt;
    }

    /**
     * exmntLimitDt을 설정
     * @param exmntLimitDt 을(를) String exmntLimitDt로 설정
     */
    public void setExmntLimitDt(String exmntLimitDt) {
        this.exmntLimitDt = exmntLimitDt;
    }

    /**
     * Integer exmntDay을 반환
     * @return Integer exmntDay
     */
    public Integer getExmntDay() {
        return exmntDay;
    }

    /**
     * exmntDay을 설정
     * @param exmntDay 을(를) Integer exmntDay로 설정
     */
    public void setExmntDay(Integer exmntDay) {
        this.exmntDay = exmntDay;
    }

    /**
     * String confmLimitDt을 반환
     * @return String confmLimitDt
     */
    public String getConfmLimitDt() {
        return confmLimitDt;
    }

    /**
     * confmLimitDt을 설정
     * @param confmLimitDt 을(를) String confmLimitDt로 설정
     */
    public void setConfmLimitDt(String confmLimitDt) {
        this.confmLimitDt = confmLimitDt;
    }

    /**
     * Integer confmDay을 반환
     * @return Integer confmDay
     */
    public Integer getConfmDay() {
        return confmDay;
    }

    /**
     * confmDay을 설정
     * @param confmDay 을(를) Integer confmDay로 설정
     */
    public void setConfmDay(Integer confmDay) {
        this.confmDay = confmDay;
    }

    /**
     * Map<String,Object> exmntMgr을 반환
     * @return Map<String,Object> exmntMgr
     */
    public Map<String, Object> getExmntMgr() {
        return exmntMgr;
    }

    /**
     * exmntMgr을 설정
     * @param exmntMgr 을(를) Map<String,Object> exmntMgr로 설정
     */
    public void setExmntMgr(Map<String, Object> exmntMgr) {
        this.exmntMgr = exmntMgr;
    }

    /**
     * Map<String,Object> confmMgr을 반환
     * @return Map<String,Object> confmMgr
     */
    public Map<String, Object> getConfmMgr() {
        return confmMgr;
    }

    /**
     * confmMgr을 설정
     * @param confmMgr 을(를) Map<String,Object> confmMgr로 설정
     */
    public void setConfmMgr(Map<String, Object> confmMgr) {
        this.confmMgr = confmMgr;
    }

    /**
     * Integer confmCnt을 반환
     * @return Integer confmCnt
     */
    public Integer getConfmCnt() {
        return confmCnt;
    }

    /**
     * confmCnt을 설정
     * @param confmCnt 을(를) Integer confmCnt로 설정
     */
    public void setConfmCnt(Integer confmCnt) {
        this.confmCnt = confmCnt;
    }
    

    
    /**
     * String exmntDt을 반환
     * @return String exmntDt
     */
    public String getExmntDt() {
        return exmntDt;
    }


    
    /**
     * exmntDt을 설정
     * @param exmntDt 을(를) String exmntDt로 설정
     */
    public void setExmntDt(String exmntDt) {
        this.exmntDt = exmntDt;
    }


    
    /**
     * String exmntId을 반환
     * @return String exmntId
     */
    public String getExmntId() {
        return exmntId;
    }


    
    /**
     * exmntId을 설정
     * @param exmntId 을(를) String exmntId로 설정
     */
    public void setExmntId(String exmntId) {
        this.exmntId = exmntId;
    }


    /**
     * Integer pChk을 반환
     * @return Integer pChk
     */
    public Integer getpChk() {
        return pChk;
    }

    /**
     * pChk을 설정
     * @param pChk 을(를) Integer pChk로 설정
     */
    public void setpChk(Integer pChk) {
        this.pChk = pChk;
    }

    public String getStoreSction() {
        return storeSction;
    }

    public void setStoreSction(String storeSction) {
        this.storeSction = storeSction;
    }

    /**
     * Integer goodsStatus을 반환
     * @return Integer goodsStatus
     */
    public Integer getGoodsStatus() {
        return goodsStatus;
    }

    /**
     * goodsStatus을 설정
     * @param goodsStatus 을(를) Integer goodsStatus로 설정
     */
    public void setGoodsStatus(Integer goodsStatus) {
        this.goodsStatus = goodsStatus;
    }

    /**
     * Integer[] goodsStatuss을 반환
     * @return Integer[] goodsStatuss
     */
    public Integer[] getGoodsStatuss() {
        return goodsStatuss;
    }

    /**
     * goodsStatuss을 설정
     * @param goodsStatuss 을(를) Integer[] goodsStatuss로 설정
     */
    public void setGoodsStatuss(Integer[] goodsStatuss) {
        this.goodsStatuss = goodsStatuss;
    }

    /**
     * String techCtgry을 반환
     * @return String techCtgry
     */
    public String getTechCtgry() {
        return techCtgry;
    }

    /**
     * techCtgry을 설정
     * @param techCtgry 을(를) String techCtgry로 설정
     */
    public void setTechCtgry(String techCtgry) {
        this.techCtgry = techCtgry;
    }

    /**
     * Integer goodsChangeCode을 반환
     * @return Integer goodsChangeCode
     */
    public Integer getGoodsChangeCode() {
        return goodsChangeCode;
    }

    /**
     * goodsChangeCode을 설정
     * @param goodsChangeCode 을(를) Integer goodsChangeCode로 설정
     */
    public void setGoodsChangeCode(Integer goodsChangeCode) {
        this.goodsChangeCode = goodsChangeCode;
    }


    /**
     * String ctgryParentCode을 반환
     * @return String ctgryParentCode
     */
    public String getCtgryParentCode() {
        return ctgryParentCode;
    }


    /**
     * ctgryParentCode을 설정
     * @param ctgryParentCode 을(를) String ctgryParentCode로 설정
     */
    public void setCtgryParentCode(String ctgryParentCode) {
        this.ctgryParentCode = ctgryParentCode;
    }

    //{{skyou 2015-12-10 고도화기능으로 서비스정보추가
    /**
     * String itemSfe을 반환
     * @return String itemSfe
     */
    public String getItemSfe() {
        return itemSfe;
    }


    /**
     * itemSfe을 설정
     * @param itemSfe 을(를) String itemSfe로 설정
     */
    public void setItemSfe(String itemSfe) {
        this.itemSfe = itemSfe;
    }


    /**
     * String orgplce을 반환
     * @return String orgplce
     */
    public String getOrgplce() {
        return orgplce;
    }


    /**
     * orgplce을 설정
     * @param orgplce 을(를) String orgplce로 설정
     */
    public void setOrgplce(String orgplce) {
        this.orgplce = orgplce;
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
     * String unitPrice을 반환
     * @return String unitPrice
     */
    public String getUnitPrice() {
        return unitPrice;
    }


    /**
     * unitPrice을 설정
     * @param unitPrice 을(를) String unitPrice로 설정
     */
    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }


    /**
     * String cntrctNo을 반환
     * @return String cntrctNo
     */
    public String getCntrctNo() {
        return cntrctNo;
    }


    /**
     * cntrctNo을 설정
     * @param cntrctNo 을(를) String cntrctNo로 설정
     */
    public void setCntrctNo(String cntrctNo) {
        this.cntrctNo = cntrctNo;
    }


    /**
     * String locplcHedofc을 반환
     * @return String locplcHedofc
     */
    public String getLocplcHedofc() {
        return locplcHedofc;
    }


    /**
     * locplcHedofc을 설정
     * @param locplcHedofc 을(를) String locplcHedofc로 설정
     */
    public void setLocplcHedofc(String locplcHedofc) {
        this.locplcHedofc = locplcHedofc;
    }


    /**
     * String priceChk을 반환
     * @return String priceChk
     */
    public String getPriceChk() {
        return priceChk;
    }


    /**
     * priceChk을 설정
     * @param priceChk 을(를) String priceChk로 설정
     */
    public void setPriceChk(String priceChk) {
        this.priceChk = priceChk;
    }

    /**
     * String locplcIt을 반환
     * @return String locplcIt
     */
    public String getLocplcIt() {
        return locplcIt;
    }


    /**
     * locplcIt을 설정
     * @param locplcIt 을(를) String locplcIt로 설정
     */
    public void setLocplcIt(String locplcIt) {
        this.locplcIt = locplcIt;
    }


    /**
     * String itemVodUrl을 반환
     * @return String itemVodUrl
     */
    public String getItemVodUrl() {
        return itemVodUrl;
    }


    /**
     * itemVodUrl을 설정
     * @param itemVodUrl 을(를) String itemVodUrl로 설정
     */
    public void setItemVodUrl(String itemVodUrl) {
        this.itemVodUrl = itemVodUrl;
    }


    /**
     * String itemDnFileSeq을 반환
     * @return String itemDnFileSeq
     */
    public String getItemDnFileSeq() {
        return itemDnFileSeq;
    }


    /**
     * itemDnFileSeq을 설정
     * @param itemDnFileSeq 을(를) String itemDnFileSeq로 설정
     */
    public void setItemDnFileSeq(String itemDnFileSeq) {
        this.itemDnFileSeq = itemDnFileSeq;
    }


    /**
     * Integer mnlDnFileSeq을 반환
     * @return Integer mnlDnFileSeq
     */
    public Integer getMnlDnFileSeq() {
        return mnlDnFileSeq;
    }


    /**
     * mnlDnFileSeq을 설정
     * @param mnlDnFileSeq 을(를) Integer mnlDnFileSeq로 설정
     */
    public void setMnlDnFileSeq(Integer mnlDnFileSeq) {
        this.mnlDnFileSeq = mnlDnFileSeq;
    }

    /**
     * String frameChk을 반환
     * @return String frameChk
     */
    public String getFrameChk() {
        return frameChk;
    }


    /**
     * frameChk을 설정
     * @param frameChk 을(를) String frameChk로 설정
     */
    public void setFrameChk(String frameChk) {
        this.frameChk = frameChk;
    }

    /**
     * String gtwobChk을 반환
     * @return String gtwobChk
     */
    public String getGtwobChk() {
        return gtwobChk;
    }


    /**
     * gtwobChk을 설정
     * @param gtwobChk 을(를) String gtwobChk로 설정
     */
    public void setGtwobChk(String gtwobChk) {
        this.gtwobChk = gtwobChk;
    }


    /**
     * String detailGoodsClNo을 반환
     * @return String detailGoodsClNo
     */
    public String getDetailGoodsClNo() {
        return detailGoodsClNo;
    }


    /**
     * detailGoodsClNo을 설정
     * @param detailGoodsClNo 을(를) String detailGoodsClNo로 설정
     */
    public void setDetailGoodsClNo(String detailGoodsClNo) {
        this.detailGoodsClNo = detailGoodsClNo;
    }

    /**
     * String delngStopChk을 반환
     * @return String delngStopChk
     */
    public String getDelngStopChk() {
        return delngStopChk;
    }


    /**
     * delngStopChk을 설정
     * @param delngStopChk 을(를) String delngStopChk로 설정
     */
    public void setDelngStopChk(String delngStopChk) {
        this.delngStopChk = delngStopChk;
    }


    /**
     * String orderIntrcpChk을 반환
     * @return String orderIntrcpChk
     */
    public String getOrderIntrcpChk() {
        return orderIntrcpChk;
    }


    /**
     * orderIntrcpChk을 설정
     * @param orderIntrcpChk 을(를) String orderIntrcpChk로 설정
     */
    public void setOrderIntrcpChk(String orderIntrcpChk) {
        this.orderIntrcpChk = orderIntrcpChk;
    }

    /**
     * String itemImgUrl을 반환
     * @return String itemImgUrl
     */
    public String getItemImgUrl() {
        return itemImgUrl;
    }


    /**
     * itemImgUrl을 설정
     * @param itemImgUrl 을(를) String itemImgUrl로 설정
     */
    public void setItemImgUrl(String itemImgUrl) {
        this.itemImgUrl = itemImgUrl;
    }


    /**
     * String[] metaPrices을 반환
     * @return String[] metaPrices
     */
    public String getMetaPrices() {
        return metaPrices;
    }


    /**
     * metaPrices을 설정
     * @param metaPrices 을(를) String metaPrices로 설정
     */
    public void setMetaPrices(String metaPrices) {
        this.metaPrices = metaPrices;
    }


    /**
     * String smlpzChk을 반환
     * @return String smlpzChk
     */
    public String getSmlpzChk() {
        return smlpzChk;
    }


    /**
     * smlpzChk을 설정
     * @param smlpzChk 을(를) String smlpzChk로 설정
     */
    public void setSmlpzChk(String smlpzChk) {
        this.smlpzChk = smlpzChk;
    }



    /**
     * String metaAreas을 반환
     * @return String metaAreas
     */
    public String getMetaAreas() {
        return metaAreas;
    }


    /**
     * metaAreas을 설정
     * @param metaAreas 을(를) String[] metaAreas로 설정
     */
    public void setMetaAreas(String metaAreas) {
        this.metaAreas = metaAreas;
    }


    /**
     * List<Map<String,Object>> goodsMetaPrice을 반환
     * @return List<Map<String,Object>> goodsMetaPrice
     */
    public List<Map<String, Object>> getGoodsMetaPrice() {
        return goodsMetaPrice;
    }


    /**
     * goodsMetaPrice을 설정
     * @param goodsMetaPrice 을(를) List<Map<String,Object>> goodsMetaPrice로 설정
     */
    public void setGoodsMetaPrice(List<Map<String, Object>> goodsMetaPrice) {
        this.goodsMetaPrice = goodsMetaPrice;
    }


    /**
     * List<Map<String,Object>> goodsMetaArea을 반환
     * @return List<Map<String,Object>> goodsMetaArea
     */
    public List<Map<String, Object>> getGoodsMetaArea() {
        return goodsMetaArea;
    }


    /**
     * goodsMetaArea을 설정
     * @param goodsMetaArea 을(를) List<Map<String,Object>> goodsMetaArea로 설정
     */
    public void setGoodsMetaArea(List<Map<String, Object>> goodsMetaArea) {
        this.goodsMetaArea = goodsMetaArea;
    }


    /**
     * List<FileVO> 을 반환
     * @return List<FileVO> dnlFile
     */
    public List<FileVO> getDnlFile() {
        return dnlFile;
    }


    /**
     * dnlFile을 설정
     * @param dnlFile 을(를) List<FileVO> dnlFile로 설정
     */
    public void setDnlFile(List<FileVO> dnlFile) {
        this.dnlFile = dnlFile;
    }


    /**
     * String gtwobNumber을 반환
     * @return String gtwobNumber
     */
    public String getGtwobNumber() {
        return gtwobNumber;
    }


    /**
     * gtwobNumber을 설정
     * @param gtwobNumber 을(를) String gtwobNumber로 설정
     */
    public void setGtwobNumber(String gtwobNumber) {
        this.gtwobNumber = gtwobNumber;
    }


    /**
     * Integer etcFileSeq을 반환
     * @return Integer etcFileSeq
     */
    public Integer getEtcFileSeq() {
        return etcFileSeq;
    }


    /**
     * etcFileSeq을 설정
     * @param etcFileSeq 을(를) Integer etcFileSeq로 설정
     */
    public void setEtcFileSeq(Integer etcFileSeq) {
        this.etcFileSeq = etcFileSeq;
    }


    /**
     * List<FileVO> etcFile을 반환
     * @return List<FileVO> etcFile
     */
    public List<FileVO> getEtcFile() {
        return etcFile;
    }


    /**
     * etcFile을 설정
     * @param etcFile 을(를) List<FileVO> etcFile로 설정
     */
    public void setEtcFile(List<FileVO> etcFile) {
        this.etcFile = etcFile;
    }


    /**
     * String metaExprns을 반환
     * @return String metaExprns
     */
    public String getMetaExprns() {
        return metaExprns;
    }


    /**
     * metaExprns을 설정
     * @param metaExprns 을(를) String metaExprns로 설정
     */
    public void setMetaExprns(String metaExprns) {
        this.metaExprns = metaExprns;
    }


    /**
     * String metaCntrctUnits을 반환
     * @return String metaCntrctUnits
     */
    public String getMetaCntrctUnits() {
        return metaCntrctUnits;
    }


    /**
     * metaCntrctUnits을 설정
     * @param metaCntrctUnits 을(를) String metaCntrctUnits로 설정
     */
    public void setMetaCntrctUnits(String metaCntrctUnits) {
        this.metaCntrctUnits = metaCntrctUnits;
    }


    /**
     * String metaCntrctUnitetc을 반환
     * @return String metaCntrctUnitetc
     */
    public String getMetaCntrctUnitetc() {
        return metaCntrctUnitetc;
    }


    /**
     * metaCntrctUnitetc을 설정
     * @param metaCntrctUnitetc 을(를) String metaCntrctUnitetc로 설정
     */
    public void setMetaCntrctUnitetc(String metaCntrctUnitetc) {
        this.metaCntrctUnitetc = metaCntrctUnitetc;
    }


    /**
     * String metaSvcs을 반환
     * @return String metaSvcs
     */
    public String getMetaSvcs() {
        return metaSvcs;
    }


    /**
     * metaSvcs을 설정
     * @param metaSvcs 을(를) String metaSvcs로 설정
     */
    public void setMetaSvcs(String metaSvcs) {
        this.metaSvcs = metaSvcs;
    }


    /**
     * String metaStds을 반환
     * @return String metaStds
     */
    public String getMetaStds() {
        return metaStds;
    }


    /**
     * metaStds을 설정
     * @param metaStds 을(를) String metaStds로 설정
     */
    public void setMetaStds(String metaStds) {
        this.metaStds = metaStds;
    }


    /**
     * String metaCnstcMthds을 반환
     * @return String metaCnstcMthds
     */
    public String getMetaCnstcMthds() {
        return metaCnstcMthds;
    }


    /**
     * metaCnstcMthds을 설정
     * @param metaCnstcMthds 을(를) String metaCnstcMthds로 설정
     */
    public void setMetaCnstcMthds(String metaCnstcMthds) {
        this.metaCnstcMthds = metaCnstcMthds;
    }


    /**
     * String metaScqcLvs을 반환
     * @return String metaScqcLvs
     */
    public String getMetaScqcLvs() {
        return metaScqcLvs;
    }


    /**
     * metaScqcLvs을 설정
     * @param metaScqcLvs 을(를) String metaScqcLvs로 설정
     */
    public void setMetaScqcLvs(String metaScqcLvs) {
        this.metaScqcLvs = metaScqcLvs;
    }



    /**
     * List<FileVO> priceFile을 반환
     * @return List<FileVO> priceFile
     */
    public List<FileVO> getPriceFile() {
        return priceFile;
    }



    /**
     * priceFile을 설정
     * @param priceFile 을(를) List<FileVO> priceFile로 설정
     */
    public void setPriceFile(List<FileVO> priceFile) {
        this.priceFile = priceFile;
    }



    /**
     * List<FileVO> imageMainFile을 반환
     * @return List<FileVO> imageMainFile
     */
    public List<FileVO> getImageMainFile() {
        return imageMainFile;
    }



    /**
     * imageMainFile을 설정
     * @param imageMainFile 을(를) List<FileVO> imageMainFile로 설정
     */
    public void setImageMainFile(List<FileVO> imageMainFile) {
        this.imageMainFile = imageMainFile;
    }



    /**
     * String goodsMonitorUrl을 반환
     * @return String goodsMonitorUrl
     */
    public String getGoodsMonitorUrl() {
        return goodsMonitorUrl;
    }



    /**
     * goodsMonitorUrl을 설정
     * @param goodsMonitorUrl 을(를) String goodsMonitorUrl로 설정
     */
    public void setGoodsMonitorUrl(String goodsMonitorUrl) {
        this.goodsMonitorUrl = goodsMonitorUrl;
    }


    /**
     * String goodsServiceState을 반환
     * @return String goodsServiceState
     */
    public String getGoodsServiceState() {
        return goodsServiceState;
    }



    /**
     * goodsServiceState을 설정
     * @param goodsServiceState 을(를) String goodsServiceState로 설정
     */
    public void setGoodsServiceState(String goodsServiceState) {
        this.goodsServiceState = goodsServiceState;
    }

    //}}

    /**
     * String goodsMonitorDay을 반환
     * @return String goodsMonitorDay
     */
    public String getGoodsMonitorDay() {
        return goodsMonitorDay;
    }



    /**
     * goodsMonitorDay을 설정
     * @param goodsMonitorDay 을(를) String goodsMonitorDay로 설정
     */
    public void setGoodsMonitorDay(String goodsMonitorDay) {
        this.goodsMonitorDay = goodsMonitorDay;
    }



    /**
     * String goodsMonitorTime을 반환
     * @return String goodsMonitorTime
     */
    public String getGoodsMonitorTime() {
        return goodsMonitorTime;
    }



    /**
     * goodsMonitorTime을 설정
     * @param goodsMonitorTime 을(를) String goodsMonitorTime로 설정
     */
    public void setGoodsMonitorTime(String goodsMonitorTime) {
        this.goodsMonitorTime = goodsMonitorTime;
    }


    
    /**
     * Integer serviceOfferMethod을 반환
     * @return Integer serviceOfferMethod
     */
    public Integer getServiceOfferMethod() {
        return serviceOfferMethod;
    }


    
    /**
     * serviceOfferMethod을 설정
     * @param serviceOfferMethod 을(를) Integer serviceOfferMethod로 설정
     */
    public void setServiceOfferMethod(Integer serviceOfferMethod) {
        this.serviceOfferMethod = serviceOfferMethod;
    }


    
    /**
     * String serviceOfferMethodNm을 반환
     * @return String serviceOfferMethodNm
     */
    public String getServiceOfferMethodNm() {
        return serviceOfferMethodNm;
    }


    
    /**
     * serviceOfferMethodNm을 설정
     * @param serviceOfferMethodNm 을(를) String serviceOfferMethodNm로 설정
     */
    public void setServiceOfferMethodNm(String serviceOfferMethodNm) {
        this.serviceOfferMethodNm = serviceOfferMethodNm;
    }


    /**
     * Integer requstSe을 반환
     * @return Integer requstSe
     */
    public Integer getRequstSe() {
        return requstSe;
    }


    /**
     * requstSe을 설정
     * @param requstSe 을(를) Integer requstSe로 설정
     */
    public void setRequstSe(Integer requstSe) {
        this.requstSe = requstSe;
    }


    /**
     * Integer requstResn을 반환
     * @return Integer requstResn
     */
    public Integer getRequstResn() {
        return requstResn;
    }


    /**
     * requstResn을 설정
     * @param requstResn 을(를) Integer requstResn로 설정
     */
    public void setRequstResn(Integer requstResn) {
        this.requstResn = requstResn;
    }


    /**
     * String requstProcessAt을 반환
     * @return String requstProcessAt
     */
    public String getRequstProcessAt() {
        return requstProcessAt;
    }


    /**
     * requstProcessAt을 설정
     * @param requstProcessAt 을(를) String requstProcessAt로 설정
     */
    public void setRequstProcessAt(String requstProcessAt) {
        this.requstProcessAt = requstProcessAt;
    }


    /**
     * String requstSeNm을 반환
     * @return String requstSeNm
     */
    public String getRequstSeNm() {
        return requstSeNm;
    }


    /**
     * requstSeNm을 설정
     * @param requstSeNm 을(를) String requstSeNm로 설정
     */
    public void setRequstSeNm(String requstSeNm) {
        this.requstSeNm = requstSeNm;
    }


    /**
     * String requstResnCn을 반환
     * @return String requstResnCn
     */
    public String getRequstResnCn() {
        return requstResnCn;
    }


    /**
     * requstResnCn을 설정
     * @param requstResnCn 을(를) String requstResnCn로 설정
     */
    public void setRequstResnCn(String requstResnCn) {
        this.requstResnCn = requstResnCn;
    }


    /**
     * String dspyCnvrsPrearngeDt을 반환
     * @return String dspyCnvrsPrearngeDt
     */
    public String getDspyCnvrsPrearngeDt() {
        return dspyCnvrsPrearngeDt;
    }


    /**
     * dspyCnvrsPrearngeDt을 설정
     * @param dspyCnvrsPrearngeDt 을(를) String dspyCnvrsPrearngeDt로 설정
     */
    public void setDspyCnvrsPrearngeDt(String dspyCnvrsPrearngeDt) {
        this.dspyCnvrsPrearngeDt = dspyCnvrsPrearngeDt;
    }


    
    /**
     * String cstmrInfo을 반환
     * @return String cstmrInfo
     */
    public String getCstmrInfo() {
        return cstmrInfo;
    }


    
    /**
     * cstmrInfo을 설정
     * @param cstmrInfo 을(를) String cstmrInfo로 설정
     */
    public void setCstmrInfo(String cstmrInfo) {
        this.cstmrInfo = cstmrInfo;
    }


    
    /**
     * String goodsExpcEffect을 반환
     * @return String goodsExpcEffect
     */
    public String getGoodsExpcEffect() {
        return goodsExpcEffect;
    }
    
    /**
     * goodsExpcEffect을 설정
     * @param goodsExpcEffect 을(를) String goodsExpcEffect로 설정
     */
    public void setGoodsExpcEffect(String goodsExpcEffect) {
        this.goodsExpcEffect = goodsExpcEffect;
    }


    
    /**
     * String gsCrtfcNo을 반환
     * @return String gsCrtfcNo
     */
    public String getGsCrtfcNo() {
        return gsCrtfcNo;
    }


    
    /**
     * gsCrtfcNo을 설정
     * @param gsCrtfcNo 을(를) String gsCrtfcNo로 설정
     */
    public void setGsCrtfcNo(String gsCrtfcNo) {
        this.gsCrtfcNo = gsCrtfcNo;
    }


    
    /**
     * String naraCrtfcNo을 반환
     * @return String naraCrtfcNo
     */
    public String getNaraCrtfcNo() {
        return naraCrtfcNo;
    }

    /**
     * naraCrtfcNo을 설정
     * @param naraCrtfcNo 을(를) String naraCrtfcNo로 설정
     */
    public void setNaraCrtfcNo(String naraCrtfcNo) {
        this.naraCrtfcNo = naraCrtfcNo;
    }











    
    
    /**
     * String svcPcUntCd을 반환
     * @return String svcPcUntCd
     */
    public String getSvcPcUntCd() {
        return svcPcUntCd;
    }











    
    /**
     * svcPcUntCd을 설정
     * @param svcPcUntCd 을(를) String svcPcUntCd로 설정
     */
    public void setSvcPcUntCd(String svcPcUntCd) {
        this.svcPcUntCd = svcPcUntCd;
    }











    
    /**
     * String svcPc을 반환
     * @return String svcPc
     */
    public String getSvcPc() {
        return svcPc;
    }











    
    /**
     * svcPc을 설정
     * @param svcPc 을(를) String svcPc로 설정
     */
    public void setSvcPc(String svcPc) {
        this.svcPc = svcPc;
    }











    
    /**
     * String svcPcVat을 반환
     * @return String svcPcVat
     */
    public String getSvcPcVat() {
        return svcPcVat;
    }











    
    /**
     * svcPcVat을 설정
     * @param svcPcVat 을(를) String svcPcVat로 설정
     */
    public void setSvcPcVat(String svcPcVat) {
        this.svcPcVat = svcPcVat;
    }











    
    /**
     * String mummCntrctpd을 반환
     * @return String mummCntrctpd
     */
    public String getMummCntrctpd() {
        return mummCntrctpd;
    }











    
    /**
     * mummCntrctpd을 설정
     * @param mummCntrctpd 을(를) String mummCntrctpd로 설정
     */
    public void setMummCntrctpd(String mummCntrctpd) {
        this.mummCntrctpd = mummCntrctpd;
    }











    
    /**
     * String dueStdrMumm을 반환
     * @return String dueStdrMumm
     */
    public String getDueStdrMumm() {
        return dueStdrMumm;
    }











    
    /**
     * dueStdrMumm을 설정
     * @param dueStdrMumm 을(를) String dueStdrMumm로 설정
     */
    public void setDueStdrMumm(String dueStdrMumm) {
        this.dueStdrMumm = dueStdrMumm;
    }













    /**
     * String formNm을 반환
     * @return String formNm
     */
    public String getFormNm() {
        return formNm;
    }













    /**
     * formNm을 설정
     * @param formNm 을(를) String formNm로 설정
     */
    public void setFormNm(String formNm) {
        this.formNm = formNm;
    }

    /**
     * String svcFlag을 반환
     * @return String svcFlag
     */
    public String getSvcFlag() {
        return svcFlag;
    }

    /**
     * svcFlag을 설정
     * @param svcFlag 을(를) String svcFlag로 설정
     */
    public void setSvcFlag(String svcFlag) {
        this.svcFlag = svcFlag;
    }

    /**
     * int goodsNum을 반환
     * @return int goodsNum
     */
    public int getGoodsNum() {
        return goodsNum;
    }

    /**
     * goodsNum을 설정
     * @param goodsNum 을(를) int goodsNum로 설정
     */
    public void setGoodsNum(int goodsNum) {
        this.goodsNum = goodsNum;
    }

    /**
     * int suplycnt을 반환
     * @return int suplycnt
     */
    public int getSuplycnt() {
        return suplycnt;
    }

    /**
     * suplycnt을 설정
     * @param suplycnt 을(를) int suplycnt로 설정
     */
    public void setSuplycnt(int suplycnt) {
        this.suplycnt = suplycnt;
    }

    /**
     * String langCtgryNm을 반환
     * @return String langCtgryNm
     */
    public String getLangCtgryNm() {
        return langCtgryNm;
    }

    /**
     * langCtgryNm을 설정
     * @param langCtgryNm 을(를) String langCtgryNm로 설정
     */
    public void setLangCtgryNm(String langCtgryNm) {
        this.langCtgryNm = langCtgryNm;
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
     * int specMaxNum을 반환
     * @return int specMaxNum
     */
    public Integer getSpecMaxNum() {
        return specMaxNum;
    }

    /**
     * specMaxNum을 설정
     * @param specMaxNum 을(를) int specMaxNum로 설정
     */
    public void setSpecMaxNum(Integer specMaxNum) {
        this.specMaxNum = specMaxNum;
    }

    /**
     * Integer goodsCount을 반환
     * @return Integer goodsCount
     */
    public Integer getGoodsCount() {
        return goodsCount;
    }

    /**
     * goodsCount을 설정
     * @param goodsCount 을(를) Integer goodsCount로 설정
     */
    public void setGoodsCount(Integer goodsCount) {
        this.goodsCount = goodsCount;
    }

    /**
     * String pageUrlNm을 반환
     * @return String pageUrlNm
     */
    public String getPageUrlNm() {
        return pageUrlNm;
    }

    /**
     * pageUrlNm을 설정
     * @param pageUrlNm 을(를) String pageUrlNm로 설정
     */
    public void setPageUrlNm(String pageUrlNm) {
        this.pageUrlNm = pageUrlNm;
    }

    /**
     * String svcPcUntCdNm을 반환
     * @return String svcPcUntCdNm
     */
    public String getSvcPcUntCdNm() {
        return svcPcUntCdNm;
    }

    /**
     * svcPcUntCdNm을 설정
     * @param svcPcUntCdNm 을(를) String svcPcUntCdNm로 설정
     */
    public void setSvcPcUntCdNm(String svcPcUntCdNm) {
        this.svcPcUntCdNm = svcPcUntCdNm;
    }

    /**
     * String dueStdrMummNm을 반환
     * @return String dueStdrMummNm
     */
    public String getDueStdrMummNm() {
        return dueStdrMummNm;
    }

    /**
     * dueStdrMummNm을 설정
     * @param dueStdrMummNm 을(를) String dueStdrMummNm로 설정
     */
    public void setDueStdrMummNm(String dueStdrMummNm) {
        this.dueStdrMummNm = dueStdrMummNm;
    }

    /**
     * int crtMarkCd을 반환
     * @return int crtMarkCd
     */
    public int getCrtMarkCd() {
        return crtMarkCd;
    }

    /**
     * crtMarkCd을 설정
     * @param crtMarkCd 을(를) int crtMarkCd로 설정
     */
    public void setCrtMarkCd(int crtMarkCd) {
        this.crtMarkCd = crtMarkCd;
    }

    /**
     * String certMarkCdGubun을 반환
     * @return String certMarkCdGubun
     */
    public String getCertMarkCdGubun() {
        return certMarkCdGubun;
    }

    /**
     * certMarkCdGubun을 설정
     * @param certMarkCdGubun 을(를) String certMarkCdGubun로 설정
     */
    public void setCertMarkCdGubun(String certMarkCdGubun) {
        this.certMarkCdGubun = certMarkCdGubun;
    }

    /**
     * String svcPcVatNm을 반환
     * @return String svcPcVatNm
     */
    public String getSvcPcVatNm() {
        return svcPcVatNm;
    }

    /**
     * svcPcVatNm을 설정
     * @param svcPcVatNm 을(를) String svcPcVatNm로 설정
     */
    public void setSvcPcVatNm(String svcPcVatNm) {
        this.svcPcVatNm = svcPcVatNm;
    }

    /**
     * String [] crtfcSeFileIds을 반환
     * @return String [] crtfcSeFileIds
     */
    public String[] getCrtfcSeFileIds() {
        return crtfcSeFileIds;
    }

    /**
     * crtfcSeFileIds을 설정
     * @param crtfcSeFileIds 을(를) String [] crtfcSeFileIds로 설정
     */
    public void setCrtfcSeFileIds(String[] crtfcSeFileIds) {
        this.crtfcSeFileIds = crtfcSeFileIds;
    }

   
}
