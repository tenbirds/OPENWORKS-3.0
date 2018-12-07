/*
 * Copyright (c) 2012 ZES Inc. All rights reserved.
 * This software is the confidential and proprietary information of ZES Inc.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with ZES Inc. (http://www.zesinc.co.kr/)
 */
package zes.openworks.intra.store.goods;

import java.util.Date;
import java.util.List;

import zes.base.vo.FileVO;
import zes.base.vo.PaggingVO;

/**
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)앤키소프트
 *
 *         <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2016. 12. 08.   guest1       신규
 * </pre>
 * @see
 */
public class GoodsSpecVO extends PaggingVO {
   
    private static final long serialVersionUID = 1L;
    
    private String  langStoreNm;        /*공급업체명*/
    private String  cntrNum;            /*계약번호-조달등록번호*/
    private String  bIZrNo;             /*사업자번호*/
    private String  cmpnyTelNo;         /* 대표전화*/
    private String  goodsChargerNm;     /*담당자*/
    private String  cmpnyEmail;         /*대표이메일*/
    private String  goodsNm;            /*서비스명*/
    private Date    registDt;           /*마켓등록일*/
    private String  indvdlzCdNm;        /*서비스구분*/   
    private String  langCtgryNm;        /*서비스종류*/
    private String asIs;
    private String goodsCode;
    private String goodsNum ;
    private String goodsSpec1;
    private String goodsSpec2 ;
    private String goodsSpec3 ;
    private String goodsSpec4 ;
    private String goodsSpec5 ;
    private String goodsSpec6 ;
    private String goodsSpec7 ;
    private String goodsSpec8 ;
    private String goodsSpec9 ;
    private String goodsSpec10 ;
    private String goodsSpec11 ;
    private String goodsSpec12 ;
    private String goodsSpec13 ;
    private String goodsSpec14 ;
    private String goodsSpec15 ;
    private String goodsSpec16 ;
    private String goodsSpec17 ;
    private String goodsSpec18 ;
    private String goodsSpec19 ;
    private String goodsSpec20 ;
    private String goodsSpec21 ;
    private String goodsSpec22 ;
    private String goodsSpec23 ;
    private String goodsSpec24 ;
    private String goodsSpec25 ;
    private String goodsSpec26 ;
    private String goodsSpec27 ;
    private String goodsSpec28 ; 
    private String goodsSpec29 ; 
    private String goodsSpec30 ; 
    private String goodsSpec31 ; 
    private String goodsSpec32 ; 
    private String goodsSpec33 ; 
    private String goodsSpec34 ; 
    private String goodsSpec35 ; 
    private String goodsSpec36 ; 
    private String goodsSpec37 ; 
    private String goodsSpec38 ;  
    private String goodsSpec39 ; 
    private String goodsSpec40 ; 
    private String goodsSpec41 ; 
    private String goodsSpec42 ; 
    private String goodsSpec43 ; 
    private String goodsSpec44 ; 
    private String goodsSpec45 ; 
    private String goodsSpec46 ; 
    private String goodsSpec47 ; 
    private String goodsSpec48 ;
    private String goodsSpec49 ; 
    private String goodsSpec50 ; 
    private String goodsSpec51 ; 
    private String goodsSpec52 ; 
    private String goodsSpec53 ; 
    private String goodsSpec54 ; 
    private String goodsSpec55 ; 
    private String goodsSpec56 ; 
    private String goodsSpec57 ; 
    private String goodsSpec58 ; 
    private String goodsSpec59 ; 
    private String goodsSpec60 ; 
    private String goodsSpec61 ; 
    private String goodsSpec62 ;
    private String goodsSpec63 ; 
    private String goodsSpec64 ; 
    private String goodsSpec65 ;
    private String goodsSpec66 ; 
    private String goodsSpec67 ; 
    private String goodsSpec68 ; 
    private String goodsSpec69 ; 
    private String goodsSpec70 ;
    private String goodsSpec71 ;
    private String goodsSpec72 ; 
    private String goodsSpec73 ; 
    private String goodsSpec74 ; 
    private String goodsSpec75 ; 
    private String goodsSpec76 ;
    private String goodsSpec77 ;
    private String UserId     ;
    private String goodsEntrDate;
    private int    fileSeq = 0;
    
    private List<FileVO> specExcelFile;

    /**
     * TOBE SPEC
     */
    private String goodsKndCd;                  //상품종류코드(paas 1001 saas 1002 iaas 1003 SCS 1004)*/
    private String svcBeginProcss;              //서비스 시작 절차
    private String svcEndProcss;                //서비스 종료 절차
    private String atSvcEvl;                    //서비스 평가판 제공여부
    private String svcEvlSuplyPd;               //서비스 평가판 제공 기간
    private String slaApplcAt;                  //SLA 적용 여부
    private String svcUseful;                   //서비스 가용성 
    private String atmcEstnSportAt;             //자동 확장 지원 여부
    private String clusteringSportAt;           //클러스터링 지원 여부
    private String sfsrvProvisioningSportAt;    //셀프서비스 프로비저닝 지원 여부
    private String svcProvisioningTime;         //서비스 프로비저닝 시간
    private String svcProvisioningRelisTime;    //서비스 프로비저닝 해제 시간
    private String dataCnterLcInfo;             //데이터센터 국내, 외 위치 정보
    private String dataCnterHbrdLcInfo;         //데이터센터 위치 정보
    private String dsstrrecovryPlan;            //재해복구계획 
    private String dataExtrcProcss;             //데이터 추출 절차
    private String unuseDataPrtcPolicy;         //미사용 데이터 보호 정책
    private String safeDataDeletePolicy;        //안전한 데이터 삭제 정책
    private String svcManageSttusInfoSuply;     //서비스 관리 및 현황 정보 제공
    private String svcUseLogSuplyAt;            //서비스 이용 로그 제공 여부
    private String troblManageReprtPolicy;      //장애관리 및 보고 정책
    private String apiSportAt;                  //API 지원 여부
    private String apiSportTy;                  //API 지원 타입
    private String userMnlSuplyAt;              //사용자 매뉴얼 제공 여부
    private String userMnlInfoAt;               //사용자 매뉴얼 정보 유무
    private String userMnlInfoInput;            //사용자 매뉴얼 정보 입력
    private String userEdcSportAt;              //사용자 교육 지원 여부
    private String userEdcSportInput;           //사용자 교육 지원 입력
    private String userEdcInfo;                 //사용자 교육 정보
    private String visitEdcSportAt;             //방문 교육 지원 여부
    private String visitTchnlgySportAt;         //방문 기술 지원 여부
    private String visitElseTchnlgySportAt;     //방문 외(온라인, 이메일, 전화 등) 기술 지원 여부
    private String cstmrCnterOperAt;            //고객센터 운영 여부
    private String cstmrCnterOperTime;          //고객센터 운영 시간
    
    /*SaaS*/
    private String sUserSvcSuplyMthd;           //사용자용 서비스 제공 방식
    private String sManageSvcSuplyMthd;         //관리용 서비스 제공 방식
    private String sInfrstrctrSuplyMthd;        //인프라 제공 방식
    private String sScrtyPolicy;                //보안 정책 
    private String sDataEncptAtMthd;            //데이터 암호화 여부 및 방식
    private String sBackupRecovryPolicy;        //백업 및 복구 정책
    private String sUserCrtfcScrtyPrtcPolicy;   //사용자 인증 및 보안 보호 정책
    private String sMultiPltfomSportAt;         //다중 플랫폼 지원 여부
    private String sSportOpersysmList;          //지원 운영체계 목록
    private String sSportWbsrList;              //지원 웹브라우저 목록
    private String sSportMobilePltfomList;      //지원 모바일 플랫폼 목록
    private String sOpenStdSportAt;             //개방형 표준 지원 여부
    private String sGvrnFrmwrkSportAt;          //정부 프레임워크 지원 여부
    private String sOpenSourcSwAt;              //오픈소스 SW 호환 여부
    private String sPaastaAt;                   //PaaS-Ta 호환 여부
    private String sSourcOthbcAt;               //소스 공개 여부
    private String sApiAccessSportAt;           //외부 API ACCESS 지원 여부
    private String sDbMigrationSportAt;         //DB 마이그레이션 지원 여부
    private String sExtrlApplicationSportAt;    //외부 응용프로그램 통합 지원 여부
    private String sSubTenancySportAt;          //Sub-tenancy 지원 여부
    private String sCstmzngPosblAt;             //커스터마이징 가능 여부
    private String sDevlopSportEtc;             //개발지원 조건 및 기타 사항
    
    /* Iaas */
    private String iOthbcStdSportDoc;           // 공개표준 지원 및 문서 
    private String iSvcDirectCnncNtwrk;         // 서비스에 직접 연결하는 네트워크 
    private String iVirtlNtwrkSport;            // 가상 네트워크 지원 
    private String iSynchrnSportAt;             // 동기화 지원 여부 
    private String iSportEqpmnList;             // 지원 장비 목록 
    private String iServerComputerSvc;          // 서버/컴퓨터 서비스 
    private String iStrgeSvc;                   // 스토리지 서비스 
    private String iNtwrkSvc;                   // 네트워크 서비스 
    private String iScrtySvc;                   // 보안 서비스 
    private String iManageSvc;                  // 관리 서비스 
    private String iEtcSvc;                     // 기타 서비스                   
      
    /* Paas */
    private String pSecureDevlop;               // Secure 개발 
    private String pSecureDctWdtb;              // Secure design, coding, testing 및 배포 
    private String pSportLang;                  // 지원 언어 
    private String pSportPltfom;                // 지원 플랫폼 
    private String pSportContainerVer;          // 지원 Container 및 버전 
    private String pSportDataStorge;            // 지원 데이터 저장소 
    private String pSubTenancySportAt;          // Sub-tenancy 지원 여부 
    private String pDvlprUntInfo;               // 개발자 도구 정보 
    private String pSdkApiSuplyAt;              // SDK/API 제공 여부 
    private String pTestDebugingSportAt;        // 테스트 및 디버깅 지원 여부 
    private String pAddonSvcMarkplaceSportAt;   // Add-on 서비스 및 마켓플레이스 지원 여부 
    private String pCisportSport;               // CISPORT(Continuous Integration) 지원 
    private String pLogingMntrngSport;          // 로깅/모니터링 지원 
    private String pLoadBalancingSport;         // Load Balancing 지원 
    
    /* SCS */
    private String cSpcltyRealm;                // 전문 분야  
    private String cIndcWhole;                  // 도입전반  
    private String cSetupMgr;                   // setup  migration 
    private String cHoldQualf;                  // 보유자격  
    private String cHoldTchnlgy;                // 보유기술 
    private String cInfrstrctr;                 // 컨설팅가능 인프라 
    private String cInfrstrctrEtc;              // 컨설팅가능 인프라 기타 
    private String cPltfom;                     // 컨설팅가능 플랫폼 
    private String cPltfomEtc;                  // 컨설팅가능 플랫폼 기타
    private String cPrjctExprnc;                // 프로젝트 경험 
    private String cCnslRelm;                   // 컨설팅 영역 
    private String cCnslRelmEtc;                // 컨설팅 영역 기타
    private String cCnslScope;                  // 컨설팅 범위 
    private String cDetailSvc;                  // 컨설팅 가능 상세 서비스 
    private String cExcPd;                      // 수행기간 
    private String cExcPdEtc;                   // 수행기간 기타 
    private String cExcArea;                    // 수행가능지역 
    private String cBeffatCnslAt;               // 사전컨설팅 가능 여부 
    private String cCnslPc;                     // 컨설팅 가격 
    
    
    
    private String cmpnyFondYear;               //회사 설립년도
    private String cmpnyNm;                     //회사 명칭
    private String cmpnyIntrcn;                 //회사 소개
    private String bsnsRealm;                   //사업 분야
    private String svcEntrprsSuplyTy;           //서비스 제공 기업의 공급 유형 
    private String entrprsSe;                   //기업 구분 
    private String svcChargerNm;                //서비스 담당자 이름
    private String svcChargerEmail;             //서비스 담당자 이메일
    private String svcChargerCttpc;             //서비스 담당자 국가번호
    private String svcChargerTelno;             //서비스 담당자 전화번호
    private String svcChargerMbtlNum;           //서비스 담당자 휴대폰번호
    private Integer priceDnFileSeq;             //가격표파일 번호
    private Integer priceDnFileId;              //가격표파일 아이디
    private Integer mnlDnFileSeq;               //사용자매뉴얼 번호
    private Integer itemDnFileSeq;              //기타첨부파일 번호
    
    private String mainRefer;                   //주요 레퍼런스 (등록 서비스 기준)
    private String svcNm;                       //서비스 명칭
    private String svcDfnSfe;                   //서비스 정의 및 특징
    private String svcExpcEffect;               //서비스 기대효과
    private String svcTy;                       //서비스 유형
    private String dueStdrMumm;                 //과금 기준(최소)
    private String svcPc;                      //서비스 가격
    private String svcPcVat;                    //서비스 가격 VAT포함여부
    private String svcPcUntCd;                  //서비스 가격 통화단위 코드
    private String mummCntrctpd;                //최소 계약기간
    private String pcTableAtchAt;               //가격테이블 첨부 여부
    private String vatInclsAt;                  //VAT포함여부
    private String gnrlzSopmalRegistAt;         //나라장터종합쇼핑몰 등록 여부
    private String privateCloudAt;              //Private cloud 구축 여부
    private String publicCloudAt;//Public cloud 구축 여부
    private String hybridCloudAt;//Hybrid cloud 구축 여부
    private String kisaCrtfcAt;//클라우드 보안 인증(KISA) 여부
    private String cloudSvcQlityCrtfcAt;//클라우드 서비스 품질 인증 여부
    private String cloudSvcCnfirmAt;//클라우드 서비스 확인제 여부
    private String ccCrtfcAt;//CC 인증 여부
    private String gsCrtfcAt;//GS 인증 여부
    
    private int itemDnFileOrdrNo = 0;
/*    private int itemDnFileSeq = 0;    
    private int priceDnFileSeq = 0;    
    private int mnlDnFileSeq = 0;*/
    private int etcFileSeq = 0;
    private String priceDnFileNm;
    private String mnlDnFileNm;
    private String itemDnFileNm;
/*    private String priceDnFileId;*/     
    
    
    private String formNm;
    

    
    
    /**
     * int itemDnFileOrdrNo을 반환
     * @return int itemDnFileOrdrNo
     */
    public int getItemDnFileOrdrNo() {
        return itemDnFileOrdrNo;
    }



    
    /**
     * itemDnFileOrdrNo을 설정
     * @param itemDnFileOrdrNo 을(를) int itemDnFileOrdrNo로 설정
     */
    public void setItemDnFileOrdrNo(int itemDnFileOrdrNo) {
        this.itemDnFileOrdrNo = itemDnFileOrdrNo;
    }



    
    /**
     * int itemDnFileSeq을 반환
     * @return int itemDnFileSeq
     */
    public int getItemDnFileSeq() {
        return itemDnFileSeq;
    }



    
    /**
     * itemDnFileSeq을 설정
     * @param itemDnFileSeq 을(를) int itemDnFileSeq로 설정
     */
    public void setItemDnFileSeq(int itemDnFileSeq) {
        this.itemDnFileSeq = itemDnFileSeq;
    }



    
    /**
     * int priceDnFileSeq을 반환
     * @return int priceDnFileSeq
     */
    public int getPriceDnFileSeq() {
        return priceDnFileSeq;
    }



    
    /**
     * priceDnFileSeq을 설정
     * @param priceDnFileSeq 을(를) int priceDnFileSeq로 설정
     */
    public void setPriceDnFileSeq(int priceDnFileSeq) {
        this.priceDnFileSeq = priceDnFileSeq;
    }



    
    /**
     * int mnlDnFileSeq을 반환
     * @return int mnlDnFileSeq
     */
    public int getMnlDnFileSeq() {
        return mnlDnFileSeq;
    }



    
    /**
     * mnlDnFileSeq을 설정
     * @param mnlDnFileSeq 을(를) int mnlDnFileSeq로 설정
     */
    public void setMnlDnFileSeq(int mnlDnFileSeq) {
        this.mnlDnFileSeq = mnlDnFileSeq;
    }



    
    /**
     * int etcFileSeq을 반환
     * @return int etcFileSeq
     */
    public int getEtcFileSeq() {
        return etcFileSeq;
    }



    
    /**
     * etcFileSeq을 설정
     * @param etcFileSeq 을(를) int etcFileSeq로 설정
     */
    public void setEtcFileSeq(int etcFileSeq) {
        this.etcFileSeq = etcFileSeq;
    }



    /**
     * String priceDnFileNm을 반환
     * @return String priceDnFileNm
     */
    public String getPriceDnFileNm() {
        return priceDnFileNm;
    }


    
    /**
     * priceDnFileNm을 설정
     * @param priceDnFileNm 을(를) String priceDnFileNm로 설정
     */
    public void setPriceDnFileNm(String priceDnFileNm) {
        this.priceDnFileNm = priceDnFileNm;
    }


    
    /**
     * String mnlDnFileNm을 반환
     * @return String mnlDnFileNm
     */
    public String getMnlDnFileNm() {
        return mnlDnFileNm;
    }


    
    /**
     * mnlDnFileNm을 설정
     * @param mnlDnFileNm 을(를) String mnlDnFileNm로 설정
     */
    public void setMnlDnFileNm(String mnlDnFileNm) {
        this.mnlDnFileNm = mnlDnFileNm;
    }


    
    /**
     * String itemDnFileNm을 반환
     * @return String itemDnFileNm
     */
    public String getItemDnFileNm() {
        return itemDnFileNm;
    }


    
    /**
     * itemDnFileNm을 설정
     * @param itemDnFileNm 을(를) String itemDnFileNm로 설정
     */
    public void setItemDnFileNm(String itemDnFileNm) {
        this.itemDnFileNm = itemDnFileNm;
    }


    
    /**
     * String priceDnFileId을 반환
     * @return String priceDnFileId
     */
    public Integer getPriceDnFileId() {
        return priceDnFileId;
    }


    
    /**
     * priceDnFileId을 설정
     * @param priceDnFileId 을(를) String priceDnFileId로 설정
     */
    public void setPriceDnFileId(Integer priceDnFileId) {
        this.priceDnFileId = priceDnFileId;
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
     * String cntrNum을 반환
     * @return String cntrNum
     */
    public String getCntrNum() {
        return cntrNum;
    }

    
    /**
     * cntrNum을 설정
     * @param cntrNum 을(를) String cntrNum로 설정
     */
    public void setCntrNum(String cntrNum) {
        this.cntrNum = cntrNum;
    }

    
    /**
     * String bIZrNo을 반환
     * @return String bIZrNo
     */
    public String getbIZrNo() {
        return bIZrNo;
    }

    
    /**
     * bIZrNo을 설정
     * @param bIZrNo 을(를) String bIZrNo로 설정
     */
    public void setbIZrNo(String bIZrNo) {
        this.bIZrNo = bIZrNo;
    }

    
    /**
     * String cmpnyTelNo을 반환
     * @return String cmpnyTelNo
     */
    public String getCmpnyTelNo() {
        return cmpnyTelNo;
    }

    
    /**
     * cmpnyTelNo을 설정
     * @param cmpnyTelNo 을(를) String cmpnyTelNo로 설정
     */
    public void setCmpnyTelNo(String cmpnyTelNo) {
        this.cmpnyTelNo = cmpnyTelNo;
    }

    
    /**
     * String goodsChargerNm을 반환
     * @return String goodsChargerNm
     */
    public String getGoodsChargerNm() {
        return goodsChargerNm;
    }

    
    /**
     * goodsChargerNm을 설정
     * @param goodsChargerNm 을(를) String goodsChargerNm로 설정
     */
    public void setGoodsChargerNm(String goodsChargerNm) {
        this.goodsChargerNm = goodsChargerNm;
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
     * String goodsNm을 반환
     * @return String goodsNm
     */
    public String getGoodsNm() {
        return goodsNm;
    }

    
    /**
     * goodsNm을 설정
     * @param goodsNm 을(를) String goodsNm로 설정
     */
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    
    /**
     * Date registDt을 반환
     * @return Date registDt
     */
    public Date getRegistDt() {
        return registDt;
    }


    
    /**
     * registDt을 설정
     * @param registDt 을(를) Date registDt로 설정
     */
    public void setRegistDt(Date registDt) {
        this.registDt = registDt;
    }


    /**
     * String indvdlzCdNm을 반환
     * @return String indvdlzCdNm
     */
    public String getIndvdlzCdNm() {
        return indvdlzCdNm;
    }


    
    /**
     * indvdlzCdNm을 설정
     * @param indvdlzCdNm 을(를) String indvdlzCdNm로 설정
     */
    public void setIndvdlzCdNm(String indvdlzCdNm) {
        this.indvdlzCdNm = indvdlzCdNm;
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
     * String goodsCode을 반환
     * @return String goodsCode
     */
    public String getGoodsCode() {
        return goodsCode;
    }
    
    /**
     * goodsCode을 설정
     * @param goodsCode 을(를) String goodsCode로 설정
     */
    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }
    
    /**
     * String goodsNum을 반환
     * @return String goodsNum
     */
    public String getGoodsNum() {
        return goodsNum;
    }
    
    /**
     * goodsNum을 설정
     * @param goodsNum 을(를) String goodsNum로 설정
     */
    public void setGoodsNum(String goodsNum) {
        this.goodsNum = goodsNum;
    }
    
    /**
     * String goodsSpec1을 반환
     * @return String goodsSpec1
     */
    public String getGoodsSpec1() {
        return goodsSpec1;
    }
    
    /**
     * goodsSpec1을 설정
     * @param goodsSpec1 을(를) String goodsSpec1로 설정
     */
    public void setGoodsSpec1(String goodsSpec1) {
        this.goodsSpec1 = goodsSpec1;
    }
    
    /**
     * String goodsSpec2을 반환
     * @return String goodsSpec2
     */
    public String getGoodsSpec2() {
        return goodsSpec2;
    }
    
    /**
     * goodsSpec2을 설정
     * @param goodsSpec2 을(를) String goodsSpec2로 설정
     */
    public void setGoodsSpec2(String goodsSpec2) {
        this.goodsSpec2 = goodsSpec2;
    }
    
    /**
     * String goodsSpec3을 반환
     * @return String goodsSpec3
     */
    public String getGoodsSpec3() {
        return goodsSpec3;
    }
    
    /**
     * goodsSpec3을 설정
     * @param goodsSpec3 을(를) String goodsSpec3로 설정
     */
    public void setGoodsSpec3(String goodsSpec3) {
        this.goodsSpec3 = goodsSpec3;
    }
    
    /**
     * String goodsSpec4을 반환
     * @return String goodsSpec4
     */
    public String getGoodsSpec4() {
        return goodsSpec4;
    }
    
    /**
     * goodsSpec4을 설정
     * @param goodsSpec4 을(를) String goodsSpec4로 설정
     */
    public void setGoodsSpec4(String goodsSpec4) {
        this.goodsSpec4 = goodsSpec4;
    }
    
    /**
     * String goodsSpec5을 반환
     * @return String goodsSpec5
     */
    public String getGoodsSpec5() {
        return goodsSpec5;
    }
    
    /**
     * goodsSpec5을 설정
     * @param goodsSpec5 을(를) String goodsSpec5로 설정
     */
    public void setGoodsSpec5(String goodsSpec5) {
        this.goodsSpec5 = goodsSpec5;
    }
    
    /**
     * String goodsSpec6을 반환
     * @return String goodsSpec6
     */
    public String getGoodsSpec6() {
        return goodsSpec6;
    }
    
    /**
     * goodsSpec6을 설정
     * @param goodsSpec6 을(를) String goodsSpec6로 설정
     */
    public void setGoodsSpec6(String goodsSpec6) {
        this.goodsSpec6 = goodsSpec6;
    }
    
    /**
     * String goodsSpec7을 반환
     * @return String goodsSpec7
     */
    public String getGoodsSpec7() {
        return goodsSpec7;
    }
    
    /**
     * goodsSpec7을 설정
     * @param goodsSpec7 을(를) String goodsSpec7로 설정
     */
    public void setGoodsSpec7(String goodsSpec7) {
        this.goodsSpec7 = goodsSpec7;
    }
    
    /**
     * String goodsSpec8을 반환
     * @return String goodsSpec8
     */
    public String getGoodsSpec8() {
        return goodsSpec8;
    }
    
    /**
     * goodsSpec8을 설정
     * @param goodsSpec8 을(를) String goodsSpec8로 설정
     */
    public void setGoodsSpec8(String goodsSpec8) {
        this.goodsSpec8 = goodsSpec8;
    }
    
    /**
     * String goodsSpec9을 반환
     * @return String goodsSpec9
     */
    public String getGoodsSpec9() {
        return goodsSpec9;
    }
    
    /**
     * goodsSpec9을 설정
     * @param goodsSpec9 을(를) String goodsSpec9로 설정
     */
    public void setGoodsSpec9(String goodsSpec9) {
        this.goodsSpec9 = goodsSpec9;
    }
    
    /**
     * String goodsSpec10을 반환
     * @return String goodsSpec10
     */
    public String getGoodsSpec10() {
        return goodsSpec10;
    }
    
    /**
     * goodsSpec10을 설정
     * @param goodsSpec10 을(를) String goodsSpec10로 설정
     */
    public void setGoodsSpec10(String goodsSpec10) {
        this.goodsSpec10 = goodsSpec10;
    }
    
    /**
     * String goodsSpec11을 반환
     * @return String goodsSpec11
     */
    public String getGoodsSpec11() {
        return goodsSpec11;
    }
    
    /**
     * goodsSpec11을 설정
     * @param goodsSpec11 을(를) String goodsSpec11로 설정
     */
    public void setGoodsSpec11(String goodsSpec11) {
        this.goodsSpec11 = goodsSpec11;
    }
    
    /**
     * String goodsSpec12을 반환
     * @return String goodsSpec12
     */
    public String getGoodsSpec12() {
        return goodsSpec12;
    }
    
    /**
     * goodsSpec12을 설정
     * @param goodsSpec12 을(를) String goodsSpec12로 설정
     */
    public void setGoodsSpec12(String goodsSpec12) {
        this.goodsSpec12 = goodsSpec12;
    }
    
    /**
     * String goodsSpec13을 반환
     * @return String goodsSpec13
     */
    public String getGoodsSpec13() {
        return goodsSpec13;
    }
    
    /**
     * goodsSpec13을 설정
     * @param goodsSpec13 을(를) String goodsSpec13로 설정
     */
    public void setGoodsSpec13(String goodsSpec13) {
        this.goodsSpec13 = goodsSpec13;
    }
    
    /**
     * String goodsSpec14을 반환
     * @return String goodsSpec14
     */
    public String getGoodsSpec14() {
        return goodsSpec14;
    }
    
    /**
     * goodsSpec14을 설정
     * @param goodsSpec14 을(를) String goodsSpec14로 설정
     */
    public void setGoodsSpec14(String goodsSpec14) {
        this.goodsSpec14 = goodsSpec14;
    }
    
    /**
     * String goodsSpec15을 반환
     * @return String goodsSpec15
     */
    public String getGoodsSpec15() {
        return goodsSpec15;
    }
    
    /**
     * goodsSpec15을 설정
     * @param goodsSpec15 을(를) String goodsSpec15로 설정
     */
    public void setGoodsSpec15(String goodsSpec15) {
        this.goodsSpec15 = goodsSpec15;
    }
    
    /**
     * String goodsSpec16을 반환
     * @return String goodsSpec16
     */
    public String getGoodsSpec16() {
        return goodsSpec16;
    }
    
    /**
     * goodsSpec16을 설정
     * @param goodsSpec16 을(를) String goodsSpec16로 설정
     */
    public void setGoodsSpec16(String goodsSpec16) {
        this.goodsSpec16 = goodsSpec16;
    }
    
    /**
     * String goodsSpec17을 반환
     * @return String goodsSpec17
     */
    public String getGoodsSpec17() {
        return goodsSpec17;
    }
    
    /**
     * goodsSpec17을 설정
     * @param goodsSpec17 을(를) String goodsSpec17로 설정
     */
    public void setGoodsSpec17(String goodsSpec17) {
        this.goodsSpec17 = goodsSpec17;
    }
    
    /**
     * String goodsSpec18을 반환
     * @return String goodsSpec18
     */
    public String getGoodsSpec18() {
        return goodsSpec18;
    }
    
    /**
     * goodsSpec18을 설정
     * @param goodsSpec18 을(를) String goodsSpec18로 설정
     */
    public void setGoodsSpec18(String goodsSpec18) {
        this.goodsSpec18 = goodsSpec18;
    }
    
    /**
     * String goodsSpec19을 반환
     * @return String goodsSpec19
     */
    public String getGoodsSpec19() {
        return goodsSpec19;
    }
    
    /**
     * goodsSpec19을 설정
     * @param goodsSpec19 을(를) String goodsSpec19로 설정
     */
    public void setGoodsSpec19(String goodsSpec19) {
        this.goodsSpec19 = goodsSpec19;
    }
    
    /**
     * String goodsSpec20을 반환
     * @return String goodsSpec20
     */
    public String getGoodsSpec20() {
        return goodsSpec20;
    }
    
    /**
     * goodsSpec20을 설정
     * @param goodsSpec20 을(를) String goodsSpec20로 설정
     */
    public void setGoodsSpec20(String goodsSpec20) {
        this.goodsSpec20 = goodsSpec20;
    }
    
    /**
     * String goodsSpec21을 반환
     * @return String goodsSpec21
     */
    public String getGoodsSpec21() {
        return goodsSpec21;
    }
    
    /**
     * goodsSpec21을 설정
     * @param goodsSpec21 을(를) String goodsSpec21로 설정
     */
    public void setGoodsSpec21(String goodsSpec21) {
        this.goodsSpec21 = goodsSpec21;
    }
    
    /**
     * String goodsSpec22을 반환
     * @return String goodsSpec22
     */
    public String getGoodsSpec22() {
        return goodsSpec22;
    }
    
    /**
     * goodsSpec22을 설정
     * @param goodsSpec22 을(를) String goodsSpec22로 설정
     */
    public void setGoodsSpec22(String goodsSpec22) {
        this.goodsSpec22 = goodsSpec22;
    }
    
    /**
     * String goodsSpec23을 반환
     * @return String goodsSpec23
     */
    public String getGoodsSpec23() {
        return goodsSpec23;
    }
    
    /**
     * goodsSpec23을 설정
     * @param goodsSpec23 을(를) String goodsSpec23로 설정
     */
    public void setGoodsSpec23(String goodsSpec23) {
        this.goodsSpec23 = goodsSpec23;
    }
    
    /**
     * String goodsSpec24을 반환
     * @return String goodsSpec24
     */
    public String getGoodsSpec24() {
        return goodsSpec24;
    }
    
    /**
     * goodsSpec24을 설정
     * @param goodsSpec24 을(를) String goodsSpec24로 설정
     */
    public void setGoodsSpec24(String goodsSpec24) {
        this.goodsSpec24 = goodsSpec24;
    }
    
    /**
     * String goodsSpec25을 반환
     * @return String goodsSpec25
     */
    public String getGoodsSpec25() {
        return goodsSpec25;
    }
    
    /**
     * goodsSpec25을 설정
     * @param goodsSpec25 을(를) String goodsSpec25로 설정
     */
    public void setGoodsSpec25(String goodsSpec25) {
        this.goodsSpec25 = goodsSpec25;
    }
    
    /**
     * String goodsSpec26을 반환
     * @return String goodsSpec26
     */
    public String getGoodsSpec26() {
        return goodsSpec26;
    }
    
    /**
     * goodsSpec26을 설정
     * @param goodsSpec26 을(를) String goodsSpec26로 설정
     */
    public void setGoodsSpec26(String goodsSpec26) {
        this.goodsSpec26 = goodsSpec26;
    }
    
    /**
     * String goodsSpec27을 반환
     * @return String goodsSpec27
     */
    public String getGoodsSpec27() {
        return goodsSpec27;
    }
    
    /**
     * goodsSpec27을 설정
     * @param goodsSpec27 을(를) String goodsSpec27로 설정
     */
    public void setGoodsSpec27(String goodsSpec27) {
        this.goodsSpec27 = goodsSpec27;
    }
    
    /**
     * String goodsSpec28을 반환
     * @return String goodsSpec28
     */
    public String getGoodsSpec28() {
        return goodsSpec28;
    }
    
    /**
     * goodsSpec28을 설정
     * @param goodsSpec28 을(를) String goodsSpec28로 설정
     */
    public void setGoodsSpec28(String goodsSpec28) {
        this.goodsSpec28 = goodsSpec28;
    }
    
    /**
     * String goodsSpec29을 반환
     * @return String goodsSpec29
     */
    public String getGoodsSpec29() {
        return goodsSpec29;
    }
    
    /**
     * goodsSpec29을 설정
     * @param goodsSpec29 을(를) String goodsSpec29로 설정
     */
    public void setGoodsSpec29(String goodsSpec29) {
        this.goodsSpec29 = goodsSpec29;
    }
    
    /**
     * String goodsSpec30을 반환
     * @return String goodsSpec30
     */
    public String getGoodsSpec30() {
        return goodsSpec30;
    }
    
    /**
     * goodsSpec30을 설정
     * @param goodsSpec30 을(를) String goodsSpec30로 설정
     */
    public void setGoodsSpec30(String goodsSpec30) {
        this.goodsSpec30 = goodsSpec30;
    }
    
    /**
     * String goodsSpec31을 반환
     * @return String goodsSpec31
     */
    public String getGoodsSpec31() {
        return goodsSpec31;
    }
    
    /**
     * goodsSpec31을 설정
     * @param goodsSpec31 을(를) String goodsSpec31로 설정
     */
    public void setGoodsSpec31(String goodsSpec31) {
        this.goodsSpec31 = goodsSpec31;
    }
    
    /**
     * String goodsSpec32을 반환
     * @return String goodsSpec32
     */
    public String getGoodsSpec32() {
        return goodsSpec32;
    }
    
    /**
     * goodsSpec32을 설정
     * @param goodsSpec32 을(를) String goodsSpec32로 설정
     */
    public void setGoodsSpec32(String goodsSpec32) {
        this.goodsSpec32 = goodsSpec32;
    }
    
    /**
     * String goodsSpec33을 반환
     * @return String goodsSpec33
     */
    public String getGoodsSpec33() {
        return goodsSpec33;
    }
    
    /**
     * goodsSpec33을 설정
     * @param goodsSpec33 을(를) String goodsSpec33로 설정
     */
    public void setGoodsSpec33(String goodsSpec33) {
        this.goodsSpec33 = goodsSpec33;
    }
    
    /**
     * String goodsSpec34을 반환
     * @return String goodsSpec34
     */
    public String getGoodsSpec34() {
        return goodsSpec34;
    }
    
    /**
     * goodsSpec34을 설정
     * @param goodsSpec34 을(를) String goodsSpec34로 설정
     */
    public void setGoodsSpec34(String goodsSpec34) {
        this.goodsSpec34 = goodsSpec34;
    }
    
    /**
     * String goodsSpec35을 반환
     * @return String goodsSpec35
     */
    public String getGoodsSpec35() {
        return goodsSpec35;
    }
    
    /**
     * goodsSpec35을 설정
     * @param goodsSpec35 을(를) String goodsSpec35로 설정
     */
    public void setGoodsSpec35(String goodsSpec35) {
        this.goodsSpec35 = goodsSpec35;
    }
    
    /**
     * String goodsSpec36을 반환
     * @return String goodsSpec36
     */
    public String getGoodsSpec36() {
        return goodsSpec36;
    }
    
    /**
     * goodsSpec36을 설정
     * @param goodsSpec36 을(를) String goodsSpec36로 설정
     */
    public void setGoodsSpec36(String goodsSpec36) {
        this.goodsSpec36 = goodsSpec36;
    }
    
    /**
     * String goodsSpec37을 반환
     * @return String goodsSpec37
     */
    public String getGoodsSpec37() {
        return goodsSpec37;
    }
    
    /**
     * goodsSpec37을 설정
     * @param goodsSpec37 을(를) String goodsSpec37로 설정
     */
    public void setGoodsSpec37(String goodsSpec37) {
        this.goodsSpec37 = goodsSpec37;
    }
    
    /**
     * String goodsSpec38을 반환
     * @return String goodsSpec38
     */
    public String getGoodsSpec38() {
        return goodsSpec38;
    }
    
    /**
     * goodsSpec38을 설정
     * @param goodsSpec38 을(를) String goodsSpec38로 설정
     */
    public void setGoodsSpec38(String goodsSpec38) {
        this.goodsSpec38 = goodsSpec38;
    }
    
    /**
     * String goodsSpec39을 반환
     * @return String goodsSpec39
     */
    public String getGoodsSpec39() {
        return goodsSpec39;
    }
    
    /**
     * goodsSpec39을 설정
     * @param goodsSpec39 을(를) String goodsSpec39로 설정
     */
    public void setGoodsSpec39(String goodsSpec39) {
        this.goodsSpec39 = goodsSpec39;
    }
    
    /**
     * String goodsSpec40을 반환
     * @return String goodsSpec40
     */
    public String getGoodsSpec40() {
        return goodsSpec40;
    }
    
    /**
     * goodsSpec40을 설정
     * @param goodsSpec40 을(를) String goodsSpec40로 설정
     */
    public void setGoodsSpec40(String goodsSpec40) {
        this.goodsSpec40 = goodsSpec40;
    }
    
    /**
     * String goodsSpec41을 반환
     * @return String goodsSpec41
     */
    public String getGoodsSpec41() {
        return goodsSpec41;
    }
    
    /**
     * goodsSpec41을 설정
     * @param goodsSpec41 을(를) String goodsSpec41로 설정
     */
    public void setGoodsSpec41(String goodsSpec41) {
        this.goodsSpec41 = goodsSpec41;
    }
    
    /**
     * String goodsSpec42을 반환
     * @return String goodsSpec42
     */
    public String getGoodsSpec42() {
        return goodsSpec42;
    }
    
    /**
     * goodsSpec42을 설정
     * @param goodsSpec42 을(를) String goodsSpec42로 설정
     */
    public void setGoodsSpec42(String goodsSpec42) {
        this.goodsSpec42 = goodsSpec42;
    }
    
    /**
     * String goodsSpec43을 반환
     * @return String goodsSpec43
     */
    public String getGoodsSpec43() {
        return goodsSpec43;
    }
    
    /**
     * goodsSpec43을 설정
     * @param goodsSpec43 을(를) String goodsSpec43로 설정
     */
    public void setGoodsSpec43(String goodsSpec43) {
        this.goodsSpec43 = goodsSpec43;
    }
    
    /**
     * String goodsSpec44을 반환
     * @return String goodsSpec44
     */
    public String getGoodsSpec44() {
        return goodsSpec44;
    }
    
    /**
     * goodsSpec44을 설정
     * @param goodsSpec44 을(를) String goodsSpec44로 설정
     */
    public void setGoodsSpec44(String goodsSpec44) {
        this.goodsSpec44 = goodsSpec44;
    }
    
    /**
     * String goodsSpec45을 반환
     * @return String goodsSpec45
     */
    public String getGoodsSpec45() {
        return goodsSpec45;
    }
    
    /**
     * goodsSpec45을 설정
     * @param goodsSpec45 을(를) String goodsSpec45로 설정
     */
    public void setGoodsSpec45(String goodsSpec45) {
        this.goodsSpec45 = goodsSpec45;
    }
    
    /**
     * String goodsSpec46을 반환
     * @return String goodsSpec46
     */
    public String getGoodsSpec46() {
        return goodsSpec46;
    }
    
    /**
     * goodsSpec46을 설정
     * @param goodsSpec46 을(를) String goodsSpec46로 설정
     */
    public void setGoodsSpec46(String goodsSpec46) {
        this.goodsSpec46 = goodsSpec46;
    }
    
    /**
     * String goodsSpec47을 반환
     * @return String goodsSpec47
     */
    public String getGoodsSpec47() {
        return goodsSpec47;
    }
    
    /**
     * goodsSpec47을 설정
     * @param goodsSpec47 을(를) String goodsSpec47로 설정
     */
    public void setGoodsSpec47(String goodsSpec47) {
        this.goodsSpec47 = goodsSpec47;
    }
    
    /**
     * String goodsSpec48을 반환
     * @return String goodsSpec48
     */
    public String getGoodsSpec48() {
        return goodsSpec48;
    }
    
    /**
     * goodsSpec48을 설정
     * @param goodsSpec48 을(를) String goodsSpec48로 설정
     */
    public void setGoodsSpec48(String goodsSpec48) {
        this.goodsSpec48 = goodsSpec48;
    }
    
    /**
     * String goodsSpec49을 반환
     * @return String goodsSpec49
     */
    public String getGoodsSpec49() {
        return goodsSpec49;
    }
    
    /**
     * goodsSpec49을 설정
     * @param goodsSpec49 을(를) String goodsSpec49로 설정
     */
    public void setGoodsSpec49(String goodsSpec49) {
        this.goodsSpec49 = goodsSpec49;
    }
    
    /**
     * String goodsSpec50을 반환
     * @return String goodsSpec50
     */
    public String getGoodsSpec50() {
        return goodsSpec50;
    }
    
    /**
     * goodsSpec50을 설정
     * @param goodsSpec50 을(를) String goodsSpec50로 설정
     */
    public void setGoodsSpec50(String goodsSpec50) {
        this.goodsSpec50 = goodsSpec50;
    }
    
    /**
     * String goodsSpec51을 반환
     * @return String goodsSpec51
     */
    public String getGoodsSpec51() {
        return goodsSpec51;
    }
    
    /**
     * goodsSpec51을 설정
     * @param goodsSpec51 을(를) String goodsSpec51로 설정
     */
    public void setGoodsSpec51(String goodsSpec51) {
        this.goodsSpec51 = goodsSpec51;
    }
    
    /**
     * String goodsSpec52을 반환
     * @return String goodsSpec52
     */
    public String getGoodsSpec52() {
        return goodsSpec52;
    }
    
    /**
     * goodsSpec52을 설정
     * @param goodsSpec52 을(를) String goodsSpec52로 설정
     */
    public void setGoodsSpec52(String goodsSpec52) {
        this.goodsSpec52 = goodsSpec52;
    }
    
    /**
     * String goodsSpec53을 반환
     * @return String goodsSpec53
     */
    public String getGoodsSpec53() {
        return goodsSpec53;
    }
    
    /**
     * goodsSpec53을 설정
     * @param goodsSpec53 을(를) String goodsSpec53로 설정
     */
    public void setGoodsSpec53(String goodsSpec53) {
        this.goodsSpec53 = goodsSpec53;
    }
    
    /**
     * String goodsSpec54을 반환
     * @return String goodsSpec54
     */
    public String getGoodsSpec54() {
        return goodsSpec54;
    }
    
    /**
     * goodsSpec54을 설정
     * @param goodsSpec54 을(를) String goodsSpec54로 설정
     */
    public void setGoodsSpec54(String goodsSpec54) {
        this.goodsSpec54 = goodsSpec54;
    }
    
    /**
     * String goodsSpec55을 반환
     * @return String goodsSpec55
     */
    public String getGoodsSpec55() {
        return goodsSpec55;
    }
    
    /**
     * goodsSpec55을 설정
     * @param goodsSpec55 을(를) String goodsSpec55로 설정
     */
    public void setGoodsSpec55(String goodsSpec55) {
        this.goodsSpec55 = goodsSpec55;
    }
    
    /**
     * String goodsSpec56을 반환
     * @return String goodsSpec56
     */
    public String getGoodsSpec56() {
        return goodsSpec56;
    }
    
    /**
     * goodsSpec56을 설정
     * @param goodsSpec56 을(를) String goodsSpec56로 설정
     */
    public void setGoodsSpec56(String goodsSpec56) {
        this.goodsSpec56 = goodsSpec56;
    }
    
    /**
     * String goodsSpec57을 반환
     * @return String goodsSpec57
     */
    public String getGoodsSpec57() {
        return goodsSpec57;
    }
    
    /**
     * goodsSpec57을 설정
     * @param goodsSpec57 을(를) String goodsSpec57로 설정
     */
    public void setGoodsSpec57(String goodsSpec57) {
        this.goodsSpec57 = goodsSpec57;
    }
    
    /**
     * String goodsSpec58을 반환
     * @return String goodsSpec58
     */
    public String getGoodsSpec58() {
        return goodsSpec58;
    }
    
    /**
     * goodsSpec58을 설정
     * @param goodsSpec58 을(를) String goodsSpec58로 설정
     */
    public void setGoodsSpec58(String goodsSpec58) {
        this.goodsSpec58 = goodsSpec58;
    }
    
    /**
     * String goodsSpec59을 반환
     * @return String goodsSpec59
     */
    public String getGoodsSpec59() {
        return goodsSpec59;
    }
    
    /**
     * goodsSpec59을 설정
     * @param goodsSpec59 을(를) String goodsSpec59로 설정
     */
    public void setGoodsSpec59(String goodsSpec59) {
        this.goodsSpec59 = goodsSpec59;
    }
    
    /**
     * String goodsSpec60을 반환
     * @return String goodsSpec60
     */
    public String getGoodsSpec60() {
        return goodsSpec60;
    }
    
    /**
     * goodsSpec60을 설정
     * @param goodsSpec60 을(를) String goodsSpec60로 설정
     */
    public void setGoodsSpec60(String goodsSpec60) {
        this.goodsSpec60 = goodsSpec60;
    }
    
    /**
     * String goodsSpec61을 반환
     * @return String goodsSpec61
     */
    public String getGoodsSpec61() {
        return goodsSpec61;
    }
    
    /**
     * goodsSpec61을 설정
     * @param goodsSpec61 을(를) String goodsSpec61로 설정
     */
    public void setGoodsSpec61(String goodsSpec61) {
        this.goodsSpec61 = goodsSpec61;
    }
    
    /**
     * String goodsSpec62을 반환
     * @return String goodsSpec62
     */
    public String getGoodsSpec62() {
        return goodsSpec62;
    }
    
    /**
     * goodsSpec62을 설정
     * @param goodsSpec62 을(를) String goodsSpec62로 설정
     */
    public void setGoodsSpec62(String goodsSpec62) {
        this.goodsSpec62 = goodsSpec62;
    }
    
    /**
     * String goodsSpec63을 반환
     * @return String goodsSpec63
     */
    public String getGoodsSpec63() {
        return goodsSpec63;
    }
    
    /**
     * goodsSpec63을 설정
     * @param goodsSpec63 을(를) String goodsSpec63로 설정
     */
    public void setGoodsSpec63(String goodsSpec63) {
        this.goodsSpec63 = goodsSpec63;
    }
    
    /**
     * String goodsSpec64을 반환
     * @return String goodsSpec64
     */
    public String getGoodsSpec64() {
        return goodsSpec64;
    }
    
    /**
     * goodsSpec64을 설정
     * @param goodsSpec64 을(를) String goodsSpec64로 설정
     */
    public void setGoodsSpec64(String goodsSpec64) {
        this.goodsSpec64 = goodsSpec64;
    }
    
    /**
     * String goodsSpec65을 반환
     * @return String goodsSpec65
     */
    public String getGoodsSpec65() {
        return goodsSpec65;
    }
    
    /**
     * goodsSpec65을 설정
     * @param goodsSpec65 을(를) String goodsSpec65로 설정
     */
    public void setGoodsSpec65(String goodsSpec65) {
        this.goodsSpec65 = goodsSpec65;
    }
    
    /**
     * String goodsSpec66을 반환
     * @return String goodsSpec66
     */
    public String getGoodsSpec66() {
        return goodsSpec66;
    }
    
    /**
     * goodsSpec66을 설정
     * @param goodsSpec66 을(를) String goodsSpec66로 설정
     */
    public void setGoodsSpec66(String goodsSpec66) {
        this.goodsSpec66 = goodsSpec66;
    }
    
    /**
     * String goodsSpec67을 반환
     * @return String goodsSpec67
     */
    public String getGoodsSpec67() {
        return goodsSpec67;
    }
    
    /**
     * goodsSpec67을 설정
     * @param goodsSpec67 을(를) String goodsSpec67로 설정
     */
    public void setGoodsSpec67(String goodsSpec67) {
        this.goodsSpec67 = goodsSpec67;
    }
    
    /**
     * String goodsSpec68을 반환
     * @return String goodsSpec68
     */
    public String getGoodsSpec68() {
        return goodsSpec68;
    }
    
    /**
     * goodsSpec68을 설정
     * @param goodsSpec68 을(를) String goodsSpec68로 설정
     */
    public void setGoodsSpec68(String goodsSpec68) {
        this.goodsSpec68 = goodsSpec68;
    }
    
    /**
     * String goodsSpec69을 반환
     * @return String goodsSpec69
     */
    public String getGoodsSpec69() {
        return goodsSpec69;
    }
    
    /**
     * goodsSpec69을 설정
     * @param goodsSpec69 을(를) String goodsSpec69로 설정
     */
    public void setGoodsSpec69(String goodsSpec69) {
        this.goodsSpec69 = goodsSpec69;
    }
    
    /**
     * String goodsSpec70을 반환
     * @return String goodsSpec70
     */
    public String getGoodsSpec70() {
        return goodsSpec70;
    }
    
    /**
     * goodsSpec70을 설정
     * @param goodsSpec70 을(를) String goodsSpec70로 설정
     */
    public void setGoodsSpec70(String goodsSpec70) {
        this.goodsSpec70 = goodsSpec70;
    }
    
    /**
     * String goodsSpec71을 반환
     * @return String goodsSpec71
     */
    public String getGoodsSpec71() {
        return goodsSpec71;
    }
    
    /**
     * goodsSpec71을 설정
     * @param goodsSpec71 을(를) String goodsSpec71로 설정
     */
    public void setGoodsSpec71(String goodsSpec71) {
        this.goodsSpec71 = goodsSpec71;
    }
    
    /**
     * String goodsSpec72을 반환
     * @return String goodsSpec72
     */
    public String getGoodsSpec72() {
        return goodsSpec72;
    }
    
    /**
     * goodsSpec72을 설정
     * @param goodsSpec72 을(를) String goodsSpec72로 설정
     */
    public void setGoodsSpec72(String goodsSpec72) {
        this.goodsSpec72 = goodsSpec72;
    }
    
    /**
     * String goodsSpec73을 반환
     * @return String goodsSpec73
     */
    public String getGoodsSpec73() {
        return goodsSpec73;
    }
    
    /**
     * goodsSpec73을 설정
     * @param goodsSpec73 을(를) String goodsSpec73로 설정
     */
    public void setGoodsSpec73(String goodsSpec73) {
        this.goodsSpec73 = goodsSpec73;
    }
    
    /**
     * String goodsSpec74을 반환
     * @return String goodsSpec74
     */
    public String getGoodsSpec74() {
        return goodsSpec74;
    }
    
    /**
     * goodsSpec74을 설정
     * @param goodsSpec74 을(를) String goodsSpec74로 설정
     */
    public void setGoodsSpec74(String goodsSpec74) {
        this.goodsSpec74 = goodsSpec74;
    }
    
    /**
     * String goodsSpec75을 반환
     * @return String goodsSpec75
     */
    public String getGoodsSpec75() {
        return goodsSpec75;
    }
    
    /**
     * goodsSpec75을 설정
     * @param goodsSpec75 을(를) String goodsSpec75로 설정
     */
    public void setGoodsSpec75(String goodsSpec75) {
        this.goodsSpec75 = goodsSpec75;
    }
    
    /**
     * String goodsSpec76을 반환
     * @return String goodsSpec76
     */
    public String getGoodsSpec76() {
        return goodsSpec76;
    }
    
    /**
     * goodsSpec76을 설정
     * @param goodsSpec76 을(를) String goodsSpec76로 설정
     */
    public void setGoodsSpec76(String goodsSpec76) {
        this.goodsSpec76 = goodsSpec76;
    }
    
    /**
     * String goodsSpec77을 반환
     * @return String goodsSpec77
     */
    public String getGoodsSpec77() {
        return goodsSpec77;
    }
    
    /**
     * goodsSpec77을 설정
     * @param goodsSpec77 을(를) String goodsSpec77로 설정
     */
    public void setGoodsSpec77(String goodsSpec77) {
        this.goodsSpec77 = goodsSpec77;
    }
    
   
    /**
     * String userId을 반환
     * @return String userId
     */
    public String getUserId() {
        return UserId;
    }

    
    /**
     * userId을 설정
     * @param userId 을(를) String userId로 설정
     */
    public void setUserId(String userId) {
        UserId = userId;
    }

    
    /**
     * List<FileVO> specExcelFile을 반환
     * @return List<FileVO> specExcelFile
     */
    public List<FileVO> getSpecExcelFile() {
        return specExcelFile;
    }

    
    /**
     * specExcelFile을 설정
     * @param specExcelFile 을(를) List<FileVO> specExcelFile로 설정
     */
    public void setSpecExcelFile(List<FileVO> specExcelFile) {
        this.specExcelFile = specExcelFile;
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
     * String goodsEntrDate을 반환
     * @return String goodsEntrDate
     */
    public String getGoodsEntrDate() {
        return goodsEntrDate;
    }


    
    /**
     * goodsEntrDate을 설정
     * @param goodsEntrDate 을(를) String goodsEntrDate로 설정
     */
    public void setGoodsEntrDate(String goodsEntrDate) {
        this.goodsEntrDate = goodsEntrDate;
    }


    
    /**
     * String asIs을 반환
     * @return String asIs
     */
    public String getAsIs() {
        return asIs;
    }


    
    /**
     * asIs을 설정
     * @param asIs 을(를) String asIs로 설정
     */
    public void setAsIs(String asIs) {
        this.asIs = asIs;
    }




    
    /**
     * String goodsKndCd을 반환
     * @return String goodsKndCd
     */
    public String getGoodsKndCd() {
        return goodsKndCd;
    }




    
    /**
     * goodsKndCd을 설정
     * @param goodsKndCd 을(를) String goodsKndCd로 설정
     */
    public void setGoodsKndCd(String goodsKndCd) {
        this.goodsKndCd = goodsKndCd;
    }




    
    /**
     * String svcBeginProcss을 반환
     * @return String svcBeginProcss
     */
    public String getSvcBeginProcss() {
        return svcBeginProcss;
    }




    
    /**
     * svcBeginProcss을 설정
     * @param svcBeginProcss 을(를) String svcBeginProcss로 설정
     */
    public void setSvcBeginProcss(String svcBeginProcss) {
        this.svcBeginProcss = svcBeginProcss;
    }




    
    /**
     * String svcEndProcss을 반환
     * @return String svcEndProcss
     */
    public String getSvcEndProcss() {
        return svcEndProcss;
    }




    
    /**
     * svcEndProcss을 설정
     * @param svcEndProcss 을(를) String svcEndProcss로 설정
     */
    public void setSvcEndProcss(String svcEndProcss) {
        this.svcEndProcss = svcEndProcss;
    }




    
    /**
     * String atSvcEvl을 반환
     * @return String atSvcEvl
     */
    public String getAtSvcEvl() {
        return atSvcEvl;
    }




    
    /**
     * atSvcEvl을 설정
     * @param atSvcEvl 을(를) String atSvcEvl로 설정
     */
    public void setAtSvcEvl(String atSvcEvl) {
        this.atSvcEvl = atSvcEvl;
    }




    
    /**
     * String svcEvlSuplyPd을 반환
     * @return String svcEvlSuplyPd
     */
    public String getSvcEvlSuplyPd() {
        return svcEvlSuplyPd;
    }




    
    /**
     * svcEvlSuplyPd을 설정
     * @param svcEvlSuplyPd 을(를) String svcEvlSuplyPd로 설정
     */
    public void setSvcEvlSuplyPd(String svcEvlSuplyPd) {
        this.svcEvlSuplyPd = svcEvlSuplyPd;
    }




    
    /**
     * String slaApplcAt을 반환
     * @return String slaApplcAt
     */
    public String getSlaApplcAt() {
        return slaApplcAt;
    }




    
    /**
     * slaApplcAt을 설정
     * @param slaApplcAt 을(를) String slaApplcAt로 설정
     */
    public void setSlaApplcAt(String slaApplcAt) {
        this.slaApplcAt = slaApplcAt;
    }




    
    /**
     * String svcUseful을 반환
     * @return String svcUseful
     */
    public String getSvcUseful() {
        return svcUseful;
    }




    
    /**
     * svcUseful을 설정
     * @param svcUseful 을(를) String svcUseful로 설정
     */
    public void setSvcUseful(String svcUseful) {
        this.svcUseful = svcUseful;
    }




    
    /**
     * String atmcEstnSportAt을 반환
     * @return String atmcEstnSportAt
     */
    public String getAtmcEstnSportAt() {
        return atmcEstnSportAt;
    }




    
    /**
     * atmcEstnSportAt을 설정
     * @param atmcEstnSportAt 을(를) String atmcEstnSportAt로 설정
     */
    public void setAtmcEstnSportAt(String atmcEstnSportAt) {
        this.atmcEstnSportAt = atmcEstnSportAt;
    }




    
    /**
     * String clusteringSportAt을 반환
     * @return String clusteringSportAt
     */
    public String getClusteringSportAt() {
        return clusteringSportAt;
    }




    
    /**
     * clusteringSportAt을 설정
     * @param clusteringSportAt 을(를) String clusteringSportAt로 설정
     */
    public void setClusteringSportAt(String clusteringSportAt) {
        this.clusteringSportAt = clusteringSportAt;
    }




    
    /**
     * String sfsrvProvisioningSportAt을 반환
     * @return String sfsrvProvisioningSportAt
     */
    public String getSfsrvProvisioningSportAt() {
        return sfsrvProvisioningSportAt;
    }




    
    /**
     * sfsrvProvisioningSportAt을 설정
     * @param sfsrvProvisioningSportAt 을(를) String sfsrvProvisioningSportAt로 설정
     */
    public void setSfsrvProvisioningSportAt(String sfsrvProvisioningSportAt) {
        this.sfsrvProvisioningSportAt = sfsrvProvisioningSportAt;
    }




    
    /**
     * String svcProvisioningTime을 반환
     * @return String svcProvisioningTime
     */
    public String getSvcProvisioningTime() {
        return svcProvisioningTime;
    }




    
    /**
     * svcProvisioningTime을 설정
     * @param svcProvisioningTime 을(를) String svcProvisioningTime로 설정
     */
    public void setSvcProvisioningTime(String svcProvisioningTime) {
        this.svcProvisioningTime = svcProvisioningTime;
    }




    
    /**
     * String svcProvisioningRelisTime을 반환
     * @return String svcProvisioningRelisTime
     */
    public String getSvcProvisioningRelisTime() {
        return svcProvisioningRelisTime;
    }




    
    /**
     * svcProvisioningRelisTime을 설정
     * @param svcProvisioningRelisTime 을(를) String svcProvisioningRelisTime로 설정
     */
    public void setSvcProvisioningRelisTime(String svcProvisioningRelisTime) {
        this.svcProvisioningRelisTime = svcProvisioningRelisTime;
    }




    
    /**
     * String dataCnterLcInfo을 반환
     * @return String dataCnterLcInfo
     */
    public String getDataCnterLcInfo() {
        return dataCnterLcInfo;
    }




    
    /**
     * dataCnterLcInfo을 설정
     * @param dataCnterLcInfo 을(를) String dataCnterLcInfo로 설정
     */
    public void setDataCnterLcInfo(String dataCnterLcInfo) {
        this.dataCnterLcInfo = dataCnterLcInfo;
    }




    
    /**
     * String dataCnterHbrdLcInfo을 반환
     * @return String dataCnterHbrdLcInfo
     */
    public String getDataCnterHbrdLcInfo() {
        return dataCnterHbrdLcInfo;
    }




    
    /**
     * dataCnterHbrdLcInfo을 설정
     * @param dataCnterHbrdLcInfo 을(를) String dataCnterHbrdLcInfo로 설정
     */
    public void setDataCnterHbrdLcInfo(String dataCnterHbrdLcInfo) {
        this.dataCnterHbrdLcInfo = dataCnterHbrdLcInfo;
    }




    
    /**
     * String dsstrrecovryPlan을 반환
     * @return String dsstrrecovryPlan
     */
    public String getDsstrrecovryPlan() {
        return dsstrrecovryPlan;
    }




    
    /**
     * dsstrrecovryPlan을 설정
     * @param dsstrrecovryPlan 을(를) String dsstrrecovryPlan로 설정
     */
    public void setDsstrrecovryPlan(String dsstrrecovryPlan) {
        this.dsstrrecovryPlan = dsstrrecovryPlan;
    }




    
    /**
     * String dataExtrcProcss을 반환
     * @return String dataExtrcProcss
     */
    public String getDataExtrcProcss() {
        return dataExtrcProcss;
    }




    
    /**
     * dataExtrcProcss을 설정
     * @param dataExtrcProcss 을(를) String dataExtrcProcss로 설정
     */
    public void setDataExtrcProcss(String dataExtrcProcss) {
        this.dataExtrcProcss = dataExtrcProcss;
    }




    
    /**
     * String unuseDataPrtcPolicy을 반환
     * @return String unuseDataPrtcPolicy
     */
    public String getUnuseDataPrtcPolicy() {
        return unuseDataPrtcPolicy;
    }




    
    /**
     * unuseDataPrtcPolicy을 설정
     * @param unuseDataPrtcPolicy 을(를) String unuseDataPrtcPolicy로 설정
     */
    public void setUnuseDataPrtcPolicy(String unuseDataPrtcPolicy) {
        this.unuseDataPrtcPolicy = unuseDataPrtcPolicy;
    }




    
    /**
     * String safeDataDeletePolicy을 반환
     * @return String safeDataDeletePolicy
     */
    public String getSafeDataDeletePolicy() {
        return safeDataDeletePolicy;
    }




    
    /**
     * safeDataDeletePolicy을 설정
     * @param safeDataDeletePolicy 을(를) String safeDataDeletePolicy로 설정
     */
    public void setSafeDataDeletePolicy(String safeDataDeletePolicy) {
        this.safeDataDeletePolicy = safeDataDeletePolicy;
    }




    
    /**
     * String svcManageSttusInfoSuply을 반환
     * @return String svcManageSttusInfoSuply
     */
    public String getSvcManageSttusInfoSuply() {
        return svcManageSttusInfoSuply;
    }




    
    /**
     * svcManageSttusInfoSuply을 설정
     * @param svcManageSttusInfoSuply 을(를) String svcManageSttusInfoSuply로 설정
     */
    public void setSvcManageSttusInfoSuply(String svcManageSttusInfoSuply) {
        this.svcManageSttusInfoSuply = svcManageSttusInfoSuply;
    }




    
    /**
     * String svcUseLogSuplyAt을 반환
     * @return String svcUseLogSuplyAt
     */
    public String getSvcUseLogSuplyAt() {
        return svcUseLogSuplyAt;
    }




    
    /**
     * svcUseLogSuplyAt을 설정
     * @param svcUseLogSuplyAt 을(를) String svcUseLogSuplyAt로 설정
     */
    public void setSvcUseLogSuplyAt(String svcUseLogSuplyAt) {
        this.svcUseLogSuplyAt = svcUseLogSuplyAt;
    }




    
    /**
     * String troblManageReprtPolicy을 반환
     * @return String troblManageReprtPolicy
     */
    public String getTroblManageReprtPolicy() {
        return troblManageReprtPolicy;
    }




    
    /**
     * troblManageReprtPolicy을 설정
     * @param troblManageReprtPolicy 을(를) String troblManageReprtPolicy로 설정
     */
    public void setTroblManageReprtPolicy(String troblManageReprtPolicy) {
        this.troblManageReprtPolicy = troblManageReprtPolicy;
    }




    
    /**
     * String apiSportAt을 반환
     * @return String apiSportAt
     */
    public String getApiSportAt() {
        return apiSportAt;
    }




    
    /**
     * apiSportAt을 설정
     * @param apiSportAt 을(를) String apiSportAt로 설정
     */
    public void setApiSportAt(String apiSportAt) {
        this.apiSportAt = apiSportAt;
    }




    
    /**
     * String apiSportTy을 반환
     * @return String apiSportTy
     */
    public String getApiSportTy() {
        return apiSportTy;
    }




    
    /**
     * apiSportTy을 설정
     * @param apiSportTy 을(를) String apiSportTy로 설정
     */
    public void setApiSportTy(String apiSportTy) {
        this.apiSportTy = apiSportTy;
    }




    
    /**
     * String userMnlSuplyAt을 반환
     * @return String userMnlSuplyAt
     */
    public String getUserMnlSuplyAt() {
        return userMnlSuplyAt;
    }




    
    /**
     * userMnlSuplyAt을 설정
     * @param userMnlSuplyAt 을(를) String userMnlSuplyAt로 설정
     */
    public void setUserMnlSuplyAt(String userMnlSuplyAt) {
        this.userMnlSuplyAt = userMnlSuplyAt;
    }




    
    /**
     * String userMnlInfoAt을 반환
     * @return String userMnlInfoAt
     */
    public String getUserMnlInfoAt() {
        return userMnlInfoAt;
    }




    
    /**
     * userMnlInfoAt을 설정
     * @param userMnlInfoAt 을(를) String userMnlInfoAt로 설정
     */
    public void setUserMnlInfoAt(String userMnlInfoAt) {
        this.userMnlInfoAt = userMnlInfoAt;
    }




    
    /**
     * String userMnlInfoInput을 반환
     * @return String userMnlInfoInput
     */
    public String getUserMnlInfoInput() {
        return userMnlInfoInput;
    }




    
    /**
     * userMnlInfoInput을 설정
     * @param userMnlInfoInput 을(를) String userMnlInfoInput로 설정
     */
    public void setUserMnlInfoInput(String userMnlInfoInput) {
        this.userMnlInfoInput = userMnlInfoInput;
    }




    
    /**
     * String userEdcSportAt을 반환
     * @return String userEdcSportAt
     */
    public String getUserEdcSportAt() {
        return userEdcSportAt;
    }




    
    /**
     * userEdcSportAt을 설정
     * @param userEdcSportAt 을(를) String userEdcSportAt로 설정
     */
    public void setUserEdcSportAt(String userEdcSportAt) {
        this.userEdcSportAt = userEdcSportAt;
    }




    
    /**
     * String userEdcSportInput을 반환
     * @return String userEdcSportInput
     */
    public String getUserEdcSportInput() {
        return userEdcSportInput;
    }




    
    /**
     * userEdcSportInput을 설정
     * @param userEdcSportInput 을(를) String userEdcSportInput로 설정
     */
    public void setUserEdcSportInput(String userEdcSportInput) {
        this.userEdcSportInput = userEdcSportInput;
    }




    
    /**
     * String userEdcInfo을 반환
     * @return String userEdcInfo
     */
    public String getUserEdcInfo() {
        return userEdcInfo;
    }




    
    /**
     * userEdcInfo을 설정
     * @param userEdcInfo 을(를) String userEdcInfo로 설정
     */
    public void setUserEdcInfo(String userEdcInfo) {
        this.userEdcInfo = userEdcInfo;
    }




    
    /**
     * String visitEdcSportAt을 반환
     * @return String visitEdcSportAt
     */
    public String getVisitEdcSportAt() {
        return visitEdcSportAt;
    }




    
    /**
     * visitEdcSportAt을 설정
     * @param visitEdcSportAt 을(를) String visitEdcSportAt로 설정
     */
    public void setVisitEdcSportAt(String visitEdcSportAt) {
        this.visitEdcSportAt = visitEdcSportAt;
    }




    
    /**
     * String visitTchnlgySportAt을 반환
     * @return String visitTchnlgySportAt
     */
    public String getVisitTchnlgySportAt() {
        return visitTchnlgySportAt;
    }




    
    /**
     * visitTchnlgySportAt을 설정
     * @param visitTchnlgySportAt 을(를) String visitTchnlgySportAt로 설정
     */
    public void setVisitTchnlgySportAt(String visitTchnlgySportAt) {
        this.visitTchnlgySportAt = visitTchnlgySportAt;
    }




    
    /**
     * String visitElseTchnlgySportAt을 반환
     * @return String visitElseTchnlgySportAt
     */
    public String getVisitElseTchnlgySportAt() {
        return visitElseTchnlgySportAt;
    }




    
    /**
     * visitElseTchnlgySportAt을 설정
     * @param visitElseTchnlgySportAt 을(를) String visitElseTchnlgySportAt로 설정
     */
    public void setVisitElseTchnlgySportAt(String visitElseTchnlgySportAt) {
        this.visitElseTchnlgySportAt = visitElseTchnlgySportAt;
    }




    
    /**
     * String cstmrCnterOperAt을 반환
     * @return String cstmrCnterOperAt
     */
    public String getCstmrCnterOperAt() {
        return cstmrCnterOperAt;
    }




    
    /**
     * cstmrCnterOperAt을 설정
     * @param cstmrCnterOperAt 을(를) String cstmrCnterOperAt로 설정
     */
    public void setCstmrCnterOperAt(String cstmrCnterOperAt) {
        this.cstmrCnterOperAt = cstmrCnterOperAt;
    }




    
    /**
     * String cstmrCnterOperTime을 반환
     * @return String cstmrCnterOperTime
     */
    public String getCstmrCnterOperTime() {
        return cstmrCnterOperTime;
    }




    
    /**
     * cstmrCnterOperTime을 설정
     * @param cstmrCnterOperTime 을(를) String cstmrCnterOperTime로 설정
     */
    public void setCstmrCnterOperTime(String cstmrCnterOperTime) {
        this.cstmrCnterOperTime = cstmrCnterOperTime;
    }




    
    /**
     * String sUserSvcSuplyMthd을 반환
     * @return String sUserSvcSuplyMthd
     */
    public String getsUserSvcSuplyMthd() {
        return sUserSvcSuplyMthd;
    }




    
    /**
     * sUserSvcSuplyMthd을 설정
     * @param sUserSvcSuplyMthd 을(를) String sUserSvcSuplyMthd로 설정
     */
    public void setsUserSvcSuplyMthd(String sUserSvcSuplyMthd) {
        this.sUserSvcSuplyMthd = sUserSvcSuplyMthd;
    }




    
    /**
     * String sManageSvcSuplyMthd을 반환
     * @return String sManageSvcSuplyMthd
     */
    public String getsManageSvcSuplyMthd() {
        return sManageSvcSuplyMthd;
    }




    
    /**
     * sManageSvcSuplyMthd을 설정
     * @param sManageSvcSuplyMthd 을(를) String sManageSvcSuplyMthd로 설정
     */
    public void setsManageSvcSuplyMthd(String sManageSvcSuplyMthd) {
        this.sManageSvcSuplyMthd = sManageSvcSuplyMthd;
    }




    
    /**
     * String sInfrstrctrSuplyMthd을 반환
     * @return String sInfrstrctrSuplyMthd
     */
    public String getsInfrstrctrSuplyMthd() {
        return sInfrstrctrSuplyMthd;
    }




    
    /**
     * sInfrstrctrSuplyMthd을 설정
     * @param sInfrstrctrSuplyMthd 을(를) String sInfrstrctrSuplyMthd로 설정
     */
    public void setsInfrstrctrSuplyMthd(String sInfrstrctrSuplyMthd) {
        this.sInfrstrctrSuplyMthd = sInfrstrctrSuplyMthd;
    }




    
    /**
     * String sScrtyPolicy을 반환
     * @return String sScrtyPolicy
     */
    public String getsScrtyPolicy() {
        return sScrtyPolicy;
    }




    
    /**
     * sScrtyPolicy을 설정
     * @param sScrtyPolicy 을(를) String sScrtyPolicy로 설정
     */
    public void setsScrtyPolicy(String sScrtyPolicy) {
        this.sScrtyPolicy = sScrtyPolicy;
    }




    
    /**
     * String sDataEncptAtMthd을 반환
     * @return String sDataEncptAtMthd
     */
    public String getsDataEncptAtMthd() {
        return sDataEncptAtMthd;
    }




    
    /**
     * sDataEncptAtMthd을 설정
     * @param sDataEncptAtMthd 을(를) String sDataEncptAtMthd로 설정
     */
    public void setsDataEncptAtMthd(String sDataEncptAtMthd) {
        this.sDataEncptAtMthd = sDataEncptAtMthd;
    }




    
    /**
     * String sBackupRecovryPolicy을 반환
     * @return String sBackupRecovryPolicy
     */
    public String getsBackupRecovryPolicy() {
        return sBackupRecovryPolicy;
    }




    
    /**
     * sBackupRecovryPolicy을 설정
     * @param sBackupRecovryPolicy 을(를) String sBackupRecovryPolicy로 설정
     */
    public void setsBackupRecovryPolicy(String sBackupRecovryPolicy) {
        this.sBackupRecovryPolicy = sBackupRecovryPolicy;
    }




    
    /**
     * String sUserCrtfcScrtyPrtcPolicy을 반환
     * @return String sUserCrtfcScrtyPrtcPolicy
     */
    public String getsUserCrtfcScrtyPrtcPolicy() {
        return sUserCrtfcScrtyPrtcPolicy;
    }




    
    /**
     * sUserCrtfcScrtyPrtcPolicy을 설정
     * @param sUserCrtfcScrtyPrtcPolicy 을(를) String sUserCrtfcScrtyPrtcPolicy로 설정
     */
    public void setsUserCrtfcScrtyPrtcPolicy(String sUserCrtfcScrtyPrtcPolicy) {
        this.sUserCrtfcScrtyPrtcPolicy = sUserCrtfcScrtyPrtcPolicy;
    }




    
    /**
     * String sMultiPltfomSportAt을 반환
     * @return String sMultiPltfomSportAt
     */
    public String getsMultiPltfomSportAt() {
        return sMultiPltfomSportAt;
    }




    
    /**
     * sMultiPltfomSportAt을 설정
     * @param sMultiPltfomSportAt 을(를) String sMultiPltfomSportAt로 설정
     */
    public void setsMultiPltfomSportAt(String sMultiPltfomSportAt) {
        this.sMultiPltfomSportAt = sMultiPltfomSportAt;
    }




    
    /**
     * String sSportOpersysmList을 반환
     * @return String sSportOpersysmList
     */
    public String getsSportOpersysmList() {
        return sSportOpersysmList;
    }




    
    /**
     * sSportOpersysmList을 설정
     * @param sSportOpersysmList 을(를) String sSportOpersysmList로 설정
     */
    public void setsSportOpersysmList(String sSportOpersysmList) {
        this.sSportOpersysmList = sSportOpersysmList;
    }




    
    /**
     * String sSportWbsrList을 반환
     * @return String sSportWbsrList
     */
    public String getsSportWbsrList() {
        return sSportWbsrList;
    }




    
    /**
     * sSportWbsrList을 설정
     * @param sSportWbsrList 을(를) String sSportWbsrList로 설정
     */
    public void setsSportWbsrList(String sSportWbsrList) {
        this.sSportWbsrList = sSportWbsrList;
    }




    
    /**
     * String sSportMobilePltfomList을 반환
     * @return String sSportMobilePltfomList
     */
    public String getsSportMobilePltfomList() {
        return sSportMobilePltfomList;
    }




    
    /**
     * sSportMobilePltfomList을 설정
     * @param sSportMobilePltfomList 을(를) String sSportMobilePltfomList로 설정
     */
    public void setsSportMobilePltfomList(String sSportMobilePltfomList) {
        this.sSportMobilePltfomList = sSportMobilePltfomList;
    }




    
    /**
     * String sOpenStdSportAt을 반환
     * @return String sOpenStdSportAt
     */
    public String getsOpenStdSportAt() {
        return sOpenStdSportAt;
    }




    
    /**
     * sOpenStdSportAt을 설정
     * @param sOpenStdSportAt 을(를) String sOpenStdSportAt로 설정
     */
    public void setsOpenStdSportAt(String sOpenStdSportAt) {
        this.sOpenStdSportAt = sOpenStdSportAt;
    }




    
    /**
     * String sGvrnFrmwrkSportAt을 반환
     * @return String sGvrnFrmwrkSportAt
     */
    public String getsGvrnFrmwrkSportAt() {
        return sGvrnFrmwrkSportAt;
    }




    
    /**
     * sGvrnFrmwrkSportAt을 설정
     * @param sGvrnFrmwrkSportAt 을(를) String sGvrnFrmwrkSportAt로 설정
     */
    public void setsGvrnFrmwrkSportAt(String sGvrnFrmwrkSportAt) {
        this.sGvrnFrmwrkSportAt = sGvrnFrmwrkSportAt;
    }




    
    /**
     * String sOpenSourcSwAt을 반환
     * @return String sOpenSourcSwAt
     */
    public String getsOpenSourcSwAt() {
        return sOpenSourcSwAt;
    }




    
    /**
     * sOpenSourcSwAt을 설정
     * @param sOpenSourcSwAt 을(를) String sOpenSourcSwAt로 설정
     */
    public void setsOpenSourcSwAt(String sOpenSourcSwAt) {
        this.sOpenSourcSwAt = sOpenSourcSwAt;
    }




    
    /**
     * String sPaastaAt을 반환
     * @return String sPaastaAt
     */
    public String getsPaastaAt() {
        return sPaastaAt;
    }




    
    /**
     * sPaastaAt을 설정
     * @param sPaastaAt 을(를) String sPaastaAt로 설정
     */
    public void setsPaastaAt(String sPaastaAt) {
        this.sPaastaAt = sPaastaAt;
    }




    
    /**
     * String sSourcOthbcAt을 반환
     * @return String sSourcOthbcAt
     */
    public String getsSourcOthbcAt() {
        return sSourcOthbcAt;
    }




    
    /**
     * sSourcOthbcAt을 설정
     * @param sSourcOthbcAt 을(를) String sSourcOthbcAt로 설정
     */
    public void setsSourcOthbcAt(String sSourcOthbcAt) {
        this.sSourcOthbcAt = sSourcOthbcAt;
    }




    
    /**
     * String sApiAccessSportAt을 반환
     * @return String sApiAccessSportAt
     */
    public String getsApiAccessSportAt() {
        return sApiAccessSportAt;
    }




    
    /**
     * sApiAccessSportAt을 설정
     * @param sApiAccessSportAt 을(를) String sApiAccessSportAt로 설정
     */
    public void setsApiAccessSportAt(String sApiAccessSportAt) {
        this.sApiAccessSportAt = sApiAccessSportAt;
    }




    
    /**
     * String sDbMigrationSportAt을 반환
     * @return String sDbMigrationSportAt
     */
    public String getsDbMigrationSportAt() {
        return sDbMigrationSportAt;
    }




    
    /**
     * sDbMigrationSportAt을 설정
     * @param sDbMigrationSportAt 을(를) String sDbMigrationSportAt로 설정
     */
    public void setsDbMigrationSportAt(String sDbMigrationSportAt) {
        this.sDbMigrationSportAt = sDbMigrationSportAt;
    }




    
    /**
     * String sExtrlApplicationSportAt을 반환
     * @return String sExtrlApplicationSportAt
     */
    public String getsExtrlApplicationSportAt() {
        return sExtrlApplicationSportAt;
    }




    
    /**
     * sExtrlApplicationSportAt을 설정
     * @param sExtrlApplicationSportAt 을(를) String sExtrlApplicationSportAt로 설정
     */
    public void setsExtrlApplicationSportAt(String sExtrlApplicationSportAt) {
        this.sExtrlApplicationSportAt = sExtrlApplicationSportAt;
    }




    
    /**
     * String sSubTenancySportAt을 반환
     * @return String sSubTenancySportAt
     */
    public String getsSubTenancySportAt() {
        return sSubTenancySportAt;
    }




    
    /**
     * sSubTenancySportAt을 설정
     * @param sSubTenancySportAt 을(를) String sSubTenancySportAt로 설정
     */
    public void setsSubTenancySportAt(String sSubTenancySportAt) {
        this.sSubTenancySportAt = sSubTenancySportAt;
    }




    
    /**
     * String sCstmzngPosblAt을 반환
     * @return String sCstmzngPosblAt
     */
    public String getsCstmzngPosblAt() {
        return sCstmzngPosblAt;
    }




    
    /**
     * sCstmzngPosblAt을 설정
     * @param sCstmzngPosblAt 을(를) String sCstmzngPosblAt로 설정
     */
    public void setsCstmzngPosblAt(String sCstmzngPosblAt) {
        this.sCstmzngPosblAt = sCstmzngPosblAt;
    }




    
    /**
     * String sDevlopSportEtc을 반환
     * @return String sDevlopSportEtc
     */
    public String getsDevlopSportEtc() {
        return sDevlopSportEtc;
    }




    
    /**
     * sDevlopSportEtc을 설정
     * @param sDevlopSportEtc 을(를) String sDevlopSportEtc로 설정
     */
    public void setsDevlopSportEtc(String sDevlopSportEtc) {
        this.sDevlopSportEtc = sDevlopSportEtc;
    }




    
    /**
     * String iOthbcStdSportDoc을 반환
     * @return String iOthbcStdSportDoc
     */
    public String getiOthbcStdSportDoc() {
        return iOthbcStdSportDoc;
    }




    
    /**
     * iOthbcStdSportDoc을 설정
     * @param iOthbcStdSportDoc 을(를) String iOthbcStdSportDoc로 설정
     */
    public void setiOthbcStdSportDoc(String iOthbcStdSportDoc) {
        this.iOthbcStdSportDoc = iOthbcStdSportDoc;
    }




    
    /**
     * String iSvcDirectCnncNtwrk을 반환
     * @return String iSvcDirectCnncNtwrk
     */
    public String getiSvcDirectCnncNtwrk() {
        return iSvcDirectCnncNtwrk;
    }




    
    /**
     * iSvcDirectCnncNtwrk을 설정
     * @param iSvcDirectCnncNtwrk 을(를) String iSvcDirectCnncNtwrk로 설정
     */
    public void setiSvcDirectCnncNtwrk(String iSvcDirectCnncNtwrk) {
        this.iSvcDirectCnncNtwrk = iSvcDirectCnncNtwrk;
    }




    
    /**
     * String iVirtlNtwrkSport을 반환
     * @return String iVirtlNtwrkSport
     */
    public String getiVirtlNtwrkSport() {
        return iVirtlNtwrkSport;
    }




    
    /**
     * iVirtlNtwrkSport을 설정
     * @param iVirtlNtwrkSport 을(를) String iVirtlNtwrkSport로 설정
     */
    public void setiVirtlNtwrkSport(String iVirtlNtwrkSport) {
        this.iVirtlNtwrkSport = iVirtlNtwrkSport;
    }




    
    /**
     * String iSynchrnSportAt을 반환
     * @return String iSynchrnSportAt
     */
    public String getiSynchrnSportAt() {
        return iSynchrnSportAt;
    }




    
    /**
     * iSynchrnSportAt을 설정
     * @param iSynchrnSportAt 을(를) String iSynchrnSportAt로 설정
     */
    public void setiSynchrnSportAt(String iSynchrnSportAt) {
        this.iSynchrnSportAt = iSynchrnSportAt;
    }




    
    /**
     * String iSportEqpmnList을 반환
     * @return String iSportEqpmnList
     */
    public String getiSportEqpmnList() {
        return iSportEqpmnList;
    }




    
    /**
     * iSportEqpmnList을 설정
     * @param iSportEqpmnList 을(를) String iSportEqpmnList로 설정
     */
    public void setiSportEqpmnList(String iSportEqpmnList) {
        this.iSportEqpmnList = iSportEqpmnList;
    }




    
    /**
     * String iServerComputerSvc을 반환
     * @return String iServerComputerSvc
     */
    public String getiServerComputerSvc() {
        return iServerComputerSvc;
    }




    
    /**
     * iServerComputerSvc을 설정
     * @param iServerComputerSvc 을(를) String iServerComputerSvc로 설정
     */
    public void setiServerComputerSvc(String iServerComputerSvc) {
        this.iServerComputerSvc = iServerComputerSvc;
    }




    
    /**
     * String iStrgeSvc을 반환
     * @return String iStrgeSvc
     */
    public String getiStrgeSvc() {
        return iStrgeSvc;
    }




    
    /**
     * iStrgeSvc을 설정
     * @param iStrgeSvc 을(를) String iStrgeSvc로 설정
     */
    public void setiStrgeSvc(String iStrgeSvc) {
        this.iStrgeSvc = iStrgeSvc;
    }




    
    /**
     * String iNtwrkSvc을 반환
     * @return String iNtwrkSvc
     */
    public String getiNtwrkSvc() {
        return iNtwrkSvc;
    }




    
    /**
     * iNtwrkSvc을 설정
     * @param iNtwrkSvc 을(를) String iNtwrkSvc로 설정
     */
    public void setiNtwrkSvc(String iNtwrkSvc) {
        this.iNtwrkSvc = iNtwrkSvc;
    }




    
    /**
     * String iScrtySvc을 반환
     * @return String iScrtySvc
     */
    public String getiScrtySvc() {
        return iScrtySvc;
    }




    
    /**
     * iScrtySvc을 설정
     * @param iScrtySvc 을(를) String iScrtySvc로 설정
     */
    public void setiScrtySvc(String iScrtySvc) {
        this.iScrtySvc = iScrtySvc;
    }




    
    /**
     * String iManageSvc을 반환
     * @return String iManageSvc
     */
    public String getiManageSvc() {
        return iManageSvc;
    }




    
    /**
     * iManageSvc을 설정
     * @param iManageSvc 을(를) String iManageSvc로 설정
     */
    public void setiManageSvc(String iManageSvc) {
        this.iManageSvc = iManageSvc;
    }




    
    /**
     * String iEtcSvc을 반환
     * @return String iEtcSvc
     */
    public String getiEtcSvc() {
        return iEtcSvc;
    }




    
    /**
     * iEtcSvc을 설정
     * @param iEtcSvc 을(를) String iEtcSvc로 설정
     */
    public void setiEtcSvc(String iEtcSvc) {
        this.iEtcSvc = iEtcSvc;
    }




    
    /**
     * String pSecureDevlop을 반환
     * @return String pSecureDevlop
     */
    public String getpSecureDevlop() {
        return pSecureDevlop;
    }




    
    /**
     * pSecureDevlop을 설정
     * @param pSecureDevlop 을(를) String pSecureDevlop로 설정
     */
    public void setpSecureDevlop(String pSecureDevlop) {
        this.pSecureDevlop = pSecureDevlop;
    }




    
    /**
     * String pSecureDctWdtb을 반환
     * @return String pSecureDctWdtb
     */
    public String getpSecureDctWdtb() {
        return pSecureDctWdtb;
    }




    
    /**
     * pSecureDctWdtb을 설정
     * @param pSecureDctWdtb 을(를) String pSecureDctWdtb로 설정
     */
    public void setpSecureDctWdtb(String pSecureDctWdtb) {
        this.pSecureDctWdtb = pSecureDctWdtb;
    }




    
    /**
     * String pSportLang을 반환
     * @return String pSportLang
     */
    public String getpSportLang() {
        return pSportLang;
    }




    
    /**
     * pSportLang을 설정
     * @param pSportLang 을(를) String pSportLang로 설정
     */
    public void setpSportLang(String pSportLang) {
        this.pSportLang = pSportLang;
    }




    
    /**
     * String pSportPltfom을 반환
     * @return String pSportPltfom
     */
    public String getpSportPltfom() {
        return pSportPltfom;
    }




    
    /**
     * pSportPltfom을 설정
     * @param pSportPltfom 을(를) String pSportPltfom로 설정
     */
    public void setpSportPltfom(String pSportPltfom) {
        this.pSportPltfom = pSportPltfom;
    }




    
    /**
     * String pSportContainerVer을 반환
     * @return String pSportContainerVer
     */
    public String getpSportContainerVer() {
        return pSportContainerVer;
    }




    
    /**
     * pSportContainerVer을 설정
     * @param pSportContainerVer 을(를) String pSportContainerVer로 설정
     */
    public void setpSportContainerVer(String pSportContainerVer) {
        this.pSportContainerVer = pSportContainerVer;
    }




    
    /**
     * String pSportDataStorge을 반환
     * @return String pSportDataStorge
     */
    public String getpSportDataStorge() {
        return pSportDataStorge;
    }




    
    /**
     * pSportDataStorge을 설정
     * @param pSportDataStorge 을(를) String pSportDataStorge로 설정
     */
    public void setpSportDataStorge(String pSportDataStorge) {
        this.pSportDataStorge = pSportDataStorge;
    }




    
    /**
     * String pSubTenancySportAt을 반환
     * @return String pSubTenancySportAt
     */
    public String getpSubTenancySportAt() {
        return pSubTenancySportAt;
    }




    
    /**
     * pSubTenancySportAt을 설정
     * @param pSubTenancySportAt 을(를) String pSubTenancySportAt로 설정
     */
    public void setpSubTenancySportAt(String pSubTenancySportAt) {
        this.pSubTenancySportAt = pSubTenancySportAt;
    }




    
    /**
     * String pDvlprUntInfo을 반환
     * @return String pDvlprUntInfo
     */
    public String getpDvlprUntInfo() {
        return pDvlprUntInfo;
    }




    
    /**
     * pDvlprUntInfo을 설정
     * @param pDvlprUntInfo 을(를) String pDvlprUntInfo로 설정
     */
    public void setpDvlprUntInfo(String pDvlprUntInfo) {
        this.pDvlprUntInfo = pDvlprUntInfo;
    }




    
    /**
     * String pSdkApiSuplyAt을 반환
     * @return String pSdkApiSuplyAt
     */
    public String getpSdkApiSuplyAt() {
        return pSdkApiSuplyAt;
    }




    
    /**
     * pSdkApiSuplyAt을 설정
     * @param pSdkApiSuplyAt 을(를) String pSdkApiSuplyAt로 설정
     */
    public void setpSdkApiSuplyAt(String pSdkApiSuplyAt) {
        this.pSdkApiSuplyAt = pSdkApiSuplyAt;
    }




    
    /**
     * String pTestDebugingSportAt을 반환
     * @return String pTestDebugingSportAt
     */
    public String getpTestDebugingSportAt() {
        return pTestDebugingSportAt;
    }




    
    /**
     * pTestDebugingSportAt을 설정
     * @param pTestDebugingSportAt 을(를) String pTestDebugingSportAt로 설정
     */
    public void setpTestDebugingSportAt(String pTestDebugingSportAt) {
        this.pTestDebugingSportAt = pTestDebugingSportAt;
    }




    
    /**
     * String pAddonSvcMarkplaceSportAt을 반환
     * @return String pAddonSvcMarkplaceSportAt
     */
    public String getpAddonSvcMarkplaceSportAt() {
        return pAddonSvcMarkplaceSportAt;
    }




    
    /**
     * pAddonSvcMarkplaceSportAt을 설정
     * @param pAddonSvcMarkplaceSportAt 을(를) String pAddonSvcMarkplaceSportAt로 설정
     */
    public void setpAddonSvcMarkplaceSportAt(String pAddonSvcMarkplaceSportAt) {
        this.pAddonSvcMarkplaceSportAt = pAddonSvcMarkplaceSportAt;
    }




    
    /**
     * String pCisportSport을 반환
     * @return String pCisportSport
     */
    public String getpCisportSport() {
        return pCisportSport;
    }




    
    /**
     * pCisportSport을 설정
     * @param pCisportSport 을(를) String pCisportSport로 설정
     */
    public void setpCisportSport(String pCisportSport) {
        this.pCisportSport = pCisportSport;
    }




    
    /**
     * String pLogingMntrngSport을 반환
     * @return String pLogingMntrngSport
     */
    public String getpLogingMntrngSport() {
        return pLogingMntrngSport;
    }




    
    /**
     * pLogingMntrngSport을 설정
     * @param pLogingMntrngSport 을(를) String pLogingMntrngSport로 설정
     */
    public void setpLogingMntrngSport(String pLogingMntrngSport) {
        this.pLogingMntrngSport = pLogingMntrngSport;
    }




    
    /**
     * String pLoadBalancingSport을 반환
     * @return String pLoadBalancingSport
     */
    public String getpLoadBalancingSport() {
        return pLoadBalancingSport;
    }




    
    /**
     * pLoadBalancingSport을 설정
     * @param pLoadBalancingSport 을(를) String pLoadBalancingSport로 설정
     */
    public void setpLoadBalancingSport(String pLoadBalancingSport) {
        this.pLoadBalancingSport = pLoadBalancingSport;
    }




    
    /**
     * String cSpcltyRealm을 반환
     * @return String cSpcltyRealm
     */
    public String getcSpcltyRealm() {
        return cSpcltyRealm;
    }




    
    /**
     * cSpcltyRealm을 설정
     * @param cSpcltyRealm 을(를) String cSpcltyRealm로 설정
     */
    public void setcSpcltyRealm(String cSpcltyRealm) {
        this.cSpcltyRealm = cSpcltyRealm;
    }




    
    /**
     * String cIndcWhole을 반환
     * @return String cIndcWhole
     */
    public String getcIndcWhole() {
        return cIndcWhole;
    }




    
    /**
     * cIndcWhole을 설정
     * @param cIndcWhole 을(를) String cIndcWhole로 설정
     */
    public void setcIndcWhole(String cIndcWhole) {
        this.cIndcWhole = cIndcWhole;
    }




    
    /**
     * String cSetupMgr을 반환
     * @return String cSetupMgr
     */
    public String getcSetupMgr() {
        return cSetupMgr;
    }




    
    /**
     * cSetupMgr을 설정
     * @param cSetupMgr 을(를) String cSetupMgr로 설정
     */
    public void setcSetupMgr(String cSetupMgr) {
        this.cSetupMgr = cSetupMgr;
    }




    
    /**
     * String cHoldQualf을 반환
     * @return String cHoldQualf
     */
    public String getcHoldQualf() {
        return cHoldQualf;
    }




    
    /**
     * cHoldQualf을 설정
     * @param cHoldQualf 을(를) String cHoldQualf로 설정
     */
    public void setcHoldQualf(String cHoldQualf) {
        this.cHoldQualf = cHoldQualf;
    }




    
    /**
     * String cHoldTchnlgy을 반환
     * @return String cHoldTchnlgy
     */
    public String getcHoldTchnlgy() {
        return cHoldTchnlgy;
    }




    
    /**
     * cHoldTchnlgy을 설정
     * @param cHoldTchnlgy 을(를) String cHoldTchnlgy로 설정
     */
    public void setcHoldTchnlgy(String cHoldTchnlgy) {
        this.cHoldTchnlgy = cHoldTchnlgy;
    }




    
    /**
     * String cInfrstrctr을 반환
     * @return String cInfrstrctr
     */
    public String getcInfrstrctr() {
        return cInfrstrctr;
    }




    
    /**
     * cInfrstrctr을 설정
     * @param cInfrstrctr 을(를) String cInfrstrctr로 설정
     */
    public void setcInfrstrctr(String cInfrstrctr) {
        this.cInfrstrctr = cInfrstrctr;
    }




    
    /**
     * String cInfrstrctrEtc을 반환
     * @return String cInfrstrctrEtc
     */
    public String getcInfrstrctrEtc() {
        return cInfrstrctrEtc;
    }




    
    /**
     * cInfrstrctrEtc을 설정
     * @param cInfrstrctrEtc 을(를) String cInfrstrctrEtc로 설정
     */
    public void setcInfrstrctrEtc(String cInfrstrctrEtc) {
        this.cInfrstrctrEtc = cInfrstrctrEtc;
    }




    
    /**
     * String cPltfom을 반환
     * @return String cPltfom
     */
    public String getcPltfom() {
        return cPltfom;
    }




    
    /**
     * cPltfom을 설정
     * @param cPltfom 을(를) String cPltfom로 설정
     */
    public void setcPltfom(String cPltfom) {
        this.cPltfom = cPltfom;
    }




    
    /**
     * String cPltfomEtc을 반환
     * @return String cPltfomEtc
     */
    public String getcPltfomEtc() {
        return cPltfomEtc;
    }




    
    /**
     * cPltfomEtc을 설정
     * @param cPltfomEtc 을(를) String cPltfomEtc로 설정
     */
    public void setcPltfomEtc(String cPltfomEtc) {
        this.cPltfomEtc = cPltfomEtc;
    }




    
    /**
     * String cPrjctExprnc을 반환
     * @return String cPrjctExprnc
     */
    public String getcPrjctExprnc() {
        return cPrjctExprnc;
    }




    
    /**
     * cPrjctExprnc을 설정
     * @param cPrjctExprnc 을(를) String cPrjctExprnc로 설정
     */
    public void setcPrjctExprnc(String cPrjctExprnc) {
        this.cPrjctExprnc = cPrjctExprnc;
    }




    
    /**
     * String cCnslRelm을 반환
     * @return String cCnslRelm
     */
    public String getcCnslRelm() {
        return cCnslRelm;
    }




    
    /**
     * cCnslRelm을 설정
     * @param cCnslRelm 을(를) String cCnslRelm로 설정
     */
    public void setcCnslRelm(String cCnslRelm) {
        this.cCnslRelm = cCnslRelm;
    }




    
    /**
     * String cCnslRelmEtc을 반환
     * @return String cCnslRelmEtc
     */
    public String getcCnslRelmEtc() {
        return cCnslRelmEtc;
    }




    
    /**
     * cCnslRelmEtc을 설정
     * @param cCnslRelmEtc 을(를) String cCnslRelmEtc로 설정
     */
    public void setcCnslRelmEtc(String cCnslRelmEtc) {
        this.cCnslRelmEtc = cCnslRelmEtc;
    }




    
    /**
     * String cCnslScope을 반환
     * @return String cCnslScope
     */
    public String getcCnslScope() {
        return cCnslScope;
    }




    
    /**
     * cCnslScope을 설정
     * @param cCnslScope 을(를) String cCnslScope로 설정
     */
    public void setcCnslScope(String cCnslScope) {
        this.cCnslScope = cCnslScope;
    }




    
    /**
     * String cDetailSvc을 반환
     * @return String cDetailSvc
     */
    public String getcDetailSvc() {
        return cDetailSvc;
    }




    
    /**
     * cDetailSvc을 설정
     * @param cDetailSvc 을(를) String cDetailSvc로 설정
     */
    public void setcDetailSvc(String cDetailSvc) {
        this.cDetailSvc = cDetailSvc;
    }




    
    /**
     * String cExcPd을 반환
     * @return String cExcPd
     */
    public String getcExcPd() {
        return cExcPd;
    }




    
    /**
     * cExcPd을 설정
     * @param cExcPd 을(를) String cExcPd로 설정
     */
    public void setcExcPd(String cExcPd) {
        this.cExcPd = cExcPd;
    }




    
    /**
     * String cExcPdEtc을 반환
     * @return String cExcPdEtc
     */
    public String getcExcPdEtc() {
        return cExcPdEtc;
    }




    
    /**
     * cExcPdEtc을 설정
     * @param cExcPdEtc 을(를) String cExcPdEtc로 설정
     */
    public void setcExcPdEtc(String cExcPdEtc) {
        this.cExcPdEtc = cExcPdEtc;
    }




    
    /**
     * String cExcArea을 반환
     * @return String cExcArea
     */
    public String getcExcArea() {
        return cExcArea;
    }




    
    /**
     * cExcArea을 설정
     * @param cExcArea 을(를) String cExcArea로 설정
     */
    public void setcExcArea(String cExcArea) {
        this.cExcArea = cExcArea;
    }




    
    /**
     * String cBeffatCnslAt을 반환
     * @return String cBeffatCnslAt
     */
    public String getcBeffatCnslAt() {
        return cBeffatCnslAt;
    }




    
    /**
     * cBeffatCnslAt을 설정
     * @param cBeffatCnslAt 을(를) String cBeffatCnslAt로 설정
     */
    public void setcBeffatCnslAt(String cBeffatCnslAt) {
        this.cBeffatCnslAt = cBeffatCnslAt;
    }




    
    /**
     * String cCnslPc을 반환
     * @return String cCnslPc
     */
    public String getcCnslPc() {
        return cCnslPc;
    }




    
    /**
     * cCnslPc을 설정
     * @param cCnslPc 을(를) String cCnslPc로 설정
     */
    public void setcCnslPc(String cCnslPc) {
        this.cCnslPc = cCnslPc;
    }




    
    /**
     * String cmpnyFondYear을 반환
     * @return String cmpnyFondYear
     */
    public String getCmpnyFondYear() {
        return cmpnyFondYear;
    }




    
    /**
     * cmpnyFondYear을 설정
     * @param cmpnyFondYear 을(를) String cmpnyFondYear로 설정
     */
    public void setCmpnyFondYear(String cmpnyFondYear) {
        this.cmpnyFondYear = cmpnyFondYear;
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
     * String cmpnyIntrcn을 반환
     * @return String cmpnyIntrcn
     */
    public String getCmpnyIntrcn() {
        return cmpnyIntrcn;
    }




    
    /**
     * cmpnyIntrcn을 설정
     * @param cmpnyIntrcn 을(를) String cmpnyIntrcn로 설정
     */
    public void setCmpnyIntrcn(String cmpnyIntrcn) {
        this.cmpnyIntrcn = cmpnyIntrcn;
    }




    
    /**
     * String bsnsRealm을 반환
     * @return String bsnsRealm
     */
    public String getBsnsRealm() {
        return bsnsRealm;
    }




    
    /**
     * bsnsRealm을 설정
     * @param bsnsRealm 을(를) String bsnsRealm로 설정
     */
    public void setBsnsRealm(String bsnsRealm) {
        this.bsnsRealm = bsnsRealm;
    }




    
    /**
     * String svcEntrprsSuplyTy을 반환
     * @return String svcEntrprsSuplyTy
     */
    public String getSvcEntrprsSuplyTy() {
        return svcEntrprsSuplyTy;
    }




    
    /**
     * svcEntrprsSuplyTy을 설정
     * @param svcEntrprsSuplyTy 을(를) String svcEntrprsSuplyTy로 설정
     */
    public void setSvcEntrprsSuplyTy(String svcEntrprsSuplyTy) {
        this.svcEntrprsSuplyTy = svcEntrprsSuplyTy;
    }




    
    /**
     * String entrprsSe을 반환
     * @return String entrprsSe
     */
    public String getEntrprsSe() {
        return entrprsSe;
    }




    
    /**
     * entrprsSe을 설정
     * @param entrprsSe 을(를) String entrprsSe로 설정
     */
    public void setEntrprsSe(String entrprsSe) {
        this.entrprsSe = entrprsSe;
    }




    
    /**
     * String svcChargerNm을 반환
     * @return String svcChargerNm
     */
    public String getSvcChargerNm() {
        return svcChargerNm;
    }




    
    /**
     * svcChargerNm을 설정
     * @param svcChargerNm 을(를) String svcChargerNm로 설정
     */
    public void setSvcChargerNm(String svcChargerNm) {
        this.svcChargerNm = svcChargerNm;
    }




    
    /**
     * String svcChargerEmail을 반환
     * @return String svcChargerEmail
     */
    public String getSvcChargerEmail() {
        return svcChargerEmail;
    }




    
    /**
     * svcChargerEmail을 설정
     * @param svcChargerEmail 을(를) String svcChargerEmail로 설정
     */
    public void setSvcChargerEmail(String svcChargerEmail) {
        this.svcChargerEmail = svcChargerEmail;
    }




    
    /**
     * String svcChargerCttpc을 반환
     * @return String svcChargerCttpc
     */
    public String getSvcChargerCttpc() {
        return svcChargerCttpc;
    }




    
    /**
     * svcChargerCttpc을 설정
     * @param svcChargerCttpc 을(를) String svcChargerCttpc로 설정
     */
    public void setSvcChargerCttpc(String svcChargerCttpc) {
        this.svcChargerCttpc = svcChargerCttpc;
    }




    
    /**
     * String svcChargerTelno을 반환
     * @return String svcChargerTelno
     */
    public String getSvcChargerTelno() {
        return svcChargerTelno;
    }




    
    /**
     * svcChargerTelno을 설정
     * @param svcChargerTelno 을(를) String svcChargerTelno로 설정
     */
    public void setSvcChargerTelno(String svcChargerTelno) {
        this.svcChargerTelno = svcChargerTelno;
    }




    
    /**
     * String svcChargerMbtlNum을 반환
     * @return String svcChargerMbtlNum
     */
    public String getSvcChargerMbtlNum() {
        return svcChargerMbtlNum;
    }




    
    /**
     * svcChargerMbtlNum을 설정
     * @param svcChargerMbtlNum 을(를) String svcChargerMbtlNum로 설정
     */
    public void setSvcChargerMbtlNum(String svcChargerMbtlNum) {
        this.svcChargerMbtlNum = svcChargerMbtlNum;
    }




    
    /**
     * String mainRefer을 반환
     * @return String mainRefer
     */
    public String getMainRefer() {
        return mainRefer;
    }




    
    /**
     * mainRefer을 설정
     * @param mainRefer 을(를) String mainRefer로 설정
     */
    public void setMainRefer(String mainRefer) {
        this.mainRefer = mainRefer;
    }




    
    /**
     * String svcNm을 반환
     * @return String svcNm
     */
    public String getSvcNm() {
        return svcNm;
    }




    
    /**
     * svcNm을 설정
     * @param svcNm 을(를) String svcNm로 설정
     */
    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }




    
    /**
     * String svcDfnSfe을 반환
     * @return String svcDfnSfe
     */
    public String getSvcDfnSfe() {
        return svcDfnSfe;
    }




    
    /**
     * svcDfnSfe을 설정
     * @param svcDfnSfe 을(를) String svcDfnSfe로 설정
     */
    public void setSvcDfnSfe(String svcDfnSfe) {
        this.svcDfnSfe = svcDfnSfe;
    }




    
    /**
     * String svcExpcEffect을 반환
     * @return String svcExpcEffect
     */
    public String getSvcExpcEffect() {
        return svcExpcEffect;
    }




    
    /**
     * svcExpcEffect을 설정
     * @param svcExpcEffect 을(를) String svcExpcEffect로 설정
     */
    public void setSvcExpcEffect(String svcExpcEffect) {
        this.svcExpcEffect = svcExpcEffect;
    }




    
    /**
     * String svcTy을 반환
     * @return String svcTy
     */
    public String getSvcTy() {
        return svcTy;
    }




    
    /**
     * svcTy을 설정
     * @param svcTy 을(를) String svcTy로 설정
     */
    public void setSvcTy(String svcTy) {
        this.svcTy = svcTy;
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
     * String pcTableAtchAt을 반환
     * @return String pcTableAtchAt
     */
    public String getPcTableAtchAt() {
        return pcTableAtchAt;
    }




    
    /**
     * pcTableAtchAt을 설정
     * @param pcTableAtchAt 을(를) String pcTableAtchAt로 설정
     */
    public void setPcTableAtchAt(String pcTableAtchAt) {
        this.pcTableAtchAt = pcTableAtchAt;
    }




    
    /**
     * String vatInclsAt을 반환
     * @return String vatInclsAt
     */
    public String getVatInclsAt() {
        return vatInclsAt;
    }




    
    /**
     * vatInclsAt을 설정
     * @param vatInclsAt 을(를) String vatInclsAt로 설정
     */
    public void setVatInclsAt(String vatInclsAt) {
        this.vatInclsAt = vatInclsAt;
    }




    
    /**
     * String gnrlzSopmalRegistAt을 반환
     * @return String gnrlzSopmalRegistAt
     */
    public String getGnrlzSopmalRegistAt() {
        return gnrlzSopmalRegistAt;
    }




    
    /**
     * gnrlzSopmalRegistAt을 설정
     * @param gnrlzSopmalRegistAt 을(를) String gnrlzSopmalRegistAt로 설정
     */
    public void setGnrlzSopmalRegistAt(String gnrlzSopmalRegistAt) {
        this.gnrlzSopmalRegistAt = gnrlzSopmalRegistAt;
    }




    
    /**
     * String privateCloudAt을 반환
     * @return String privateCloudAt
     */
    public String getPrivateCloudAt() {
        return privateCloudAt;
    }




    
    /**
     * privateCloudAt을 설정
     * @param privateCloudAt 을(를) String privateCloudAt로 설정
     */
    public void setPrivateCloudAt(String privateCloudAt) {
        this.privateCloudAt = privateCloudAt;
    }




    
    /**
     * String publicCloudAt을 반환
     * @return String publicCloudAt
     */
    public String getPublicCloudAt() {
        return publicCloudAt;
    }




    
    /**
     * publicCloudAt을 설정
     * @param publicCloudAt 을(를) String publicCloudAt로 설정
     */
    public void setPublicCloudAt(String publicCloudAt) {
        this.publicCloudAt = publicCloudAt;
    }




    
    /**
     * String hybridCloudAt을 반환
     * @return String hybridCloudAt
     */
    public String getHybridCloudAt() {
        return hybridCloudAt;
    }




    
    /**
     * hybridCloudAt을 설정
     * @param hybridCloudAt 을(를) String hybridCloudAt로 설정
     */
    public void setHybridCloudAt(String hybridCloudAt) {
        this.hybridCloudAt = hybridCloudAt;
    }




    
    /**
     * String kisaCrtfcAt을 반환
     * @return String kisaCrtfcAt
     */
    public String getKisaCrtfcAt() {
        return kisaCrtfcAt;
    }




    
    /**
     * kisaCrtfcAt을 설정
     * @param kisaCrtfcAt 을(를) String kisaCrtfcAt로 설정
     */
    public void setKisaCrtfcAt(String kisaCrtfcAt) {
        this.kisaCrtfcAt = kisaCrtfcAt;
    }




    
    /**
     * String cloudSvcQlityCrtfcAt을 반환
     * @return String cloudSvcQlityCrtfcAt
     */
    public String getCloudSvcQlityCrtfcAt() {
        return cloudSvcQlityCrtfcAt;
    }




    
    /**
     * cloudSvcQlityCrtfcAt을 설정
     * @param cloudSvcQlityCrtfcAt 을(를) String cloudSvcQlityCrtfcAt로 설정
     */
    public void setCloudSvcQlityCrtfcAt(String cloudSvcQlityCrtfcAt) {
        this.cloudSvcQlityCrtfcAt = cloudSvcQlityCrtfcAt;
    }




    
    /**
     * String cloudSvcCnfirmAt을 반환
     * @return String cloudSvcCnfirmAt
     */
    public String getCloudSvcCnfirmAt() {
        return cloudSvcCnfirmAt;
    }




    
    /**
     * cloudSvcCnfirmAt을 설정
     * @param cloudSvcCnfirmAt 을(를) String cloudSvcCnfirmAt로 설정
     */
    public void setCloudSvcCnfirmAt(String cloudSvcCnfirmAt) {
        this.cloudSvcCnfirmAt = cloudSvcCnfirmAt;
    }




    
    /**
     * String ccCrtfcAt을 반환
     * @return String ccCrtfcAt
     */
    public String getCcCrtfcAt() {
        return ccCrtfcAt;
    }




    
    /**
     * ccCrtfcAt을 설정
     * @param ccCrtfcAt 을(를) String ccCrtfcAt로 설정
     */
    public void setCcCrtfcAt(String ccCrtfcAt) {
        this.ccCrtfcAt = ccCrtfcAt;
    }




    
    /**
     * String gsCrtfcAt을 반환
     * @return String gsCrtfcAt
     */
    public String getGsCrtfcAt() {
        return gsCrtfcAt;
    }




    
    /**
     * gsCrtfcAt을 설정
     * @param gsCrtfcAt 을(를) String gsCrtfcAt로 설정
     */
    public void setGsCrtfcAt(String gsCrtfcAt) {
        this.gsCrtfcAt = gsCrtfcAt;
    }




    
    /**
     * priceDnFileSeq을 설정
     * @param priceDnFileSeq 을(를) Integer priceDnFileSeq로 설정
     */
    public void setPriceDnFileSeq(Integer priceDnFileSeq) {
        this.priceDnFileSeq = priceDnFileSeq;
    }




    
    /**
     * mnlDnFileSeq을 설정
     * @param mnlDnFileSeq 을(를) Integer mnlDnFileSeq로 설정
     */
    public void setMnlDnFileSeq(Integer mnlDnFileSeq) {
        this.mnlDnFileSeq = mnlDnFileSeq;
    }




    
    /**
     * itemDnFileSeq을 설정
     * @param itemDnFileSeq 을(를) Integer itemDnFileSeq로 설정
     */
    public void setItemDnFileSeq(Integer itemDnFileSeq) {
        this.itemDnFileSeq = itemDnFileSeq;
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


}
