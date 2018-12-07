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

import zes.base.vo.FeedVO;
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
 *  2018. 03. 27.   이홍석      신규
 * </pre>
 * @see
 */
public class GoodsSpecDescribeVO extends PaggingVO 
{
    private static final long serialVersionUID = 1L;
    
    private String langStoreNm;        /*공급업체명*/
    private String bIZrNo;             /*사업자번호*/
    private String cntrNum;            /*계약번호-조달등록번호*/
    private String cmpnyTelNo;         /* 대표전화*/
    private String goodsChargerNm;     /*담당자*/
    private String cmpnyEmail;         /*대표이메일*/
    private String goodsNm;            /*서비스명*/
    private Date   registDt;           /*마켓등록일*/
    private String indvdlzCdNm;        /*서비스구분*/   
    private String langCtgryNm;        /*서비스종류*/
    
    private String goodsCode ;                           // 상품코드   
    private String goodsNum ;                            // 상품순번   
    private String goodsKndCd ;                          // 상품종류코드(paas 1001 saas 1002 iaas 1003)
    private String cmpnyNm ;                             // 회사 명칭
    private String cmpnyFondYear ;                       // 회사 설립년도
    private String entrprsSe ;                           // 기업 구분 *
    private String entrprsSeNm ;                         // 기업 구분 _ 명
    private String cmpnyIntrcn ;                         // 회사 소개
    private String bsnsRealm ;                           // 사업 분야
    private String mainRefer ;                           // 주요 레퍼런스 (등록 서비스 기준)
    private String svcNm ;                               // 서비스 명칭
    private String svcDfnSfe ;                           // 서비스 정의 및 특징
    private String svcExpcEffect ;                       // 서비스 기대효과
    private String svcTy ;                               // 서비스 유형  *
    private String svcTyNm ;                             // 서비스 유형  *
    private String svcEntrprsSuplyTy ;                   // 서비스 제공 기업의 공급 유형 *
    private String svcEntrprsSuplyTyNm ;                 // 서비스 제공 기업의 공급 유형 *
    private String dueStdrMumm ;                         // 과금 기준(최소) *
    private String dueStdrMummNm ;                       // 과금 기준(최소) _ 명
    private String svcPc ;                               // 서비스 가격
    private String svcPcVat ;                            // 서비스 가격 VAT 포함
    private String svcPcUntCd ;                          // 서비스 가격 통화단위코드 (2085)
    private String svcPcUntCdNm ;                       // 서비스 가격 통화단위코드 (2085) [이름]
    private String mummCntrctpd ;                        // 최소 계약기간
    private String pcTableAtchAt ;                       // 가격테이블 첨부 여부
    private String vatInclsAt ;                          // VAT포함여부 *
    private String vatInclsAtNm ;                        // VAT포함여부 _ 명
    private String svcBeginProcss ;                      // 서비스 시작 절차
    private String svcEndProcss ;                        // 서비스 종료 절차
    private String atSvcEvl ;                            // 서비스 평가판 제공여부
    private String svcEvlSuplyPd ;                       // 서비스 평가판 제공 기간
    private String svcChargerNm ;                        // 서비스 담당자 이름
    private String svcChargerTelno ;                     // 서비스 담당자 전화번호
    private String svcChargerEmail ;                     // 서비스 담당자 이메일
    private String svcChargerMbtlNum;                    //서비스담당자 핸드폰
    private String svcChargerCttpc;                         //국가번호
    private String gnrlzSopmalRegistAt ;                 // 나라장터종합쇼핑몰 등록 여부
    private String privateCloudAt ;                      // Private cloud 구축 여부
    private String publicCloudAt ;                       // Public cloud 구축 여부
    private String hybridCloudAt ;                       // Hybrid cloud 구축 여부
    private String kisaCrtfcAt ;                         // 클라우드 보안 인증(KISA) 여부
    private String cloudSvcQlityCrtfcAt ;                // 클라우드 서비스 품질 인증 여부
    private String cloudSvcCnfirmAt ;                    // 클라우드 서비스 확인제 여부
    private String ccCrtfcAt ;                           // CC 인증 여부
    private String gsCrtfcAt ;                           // GS 인증 여부
    private String slaApplcAt ;                          // SLA 적용 여부
    private String svcUseful ;                           // 서비스 가용성 
    private String atmcEstnSportAt ;                     // 자동 확장 지원 여부
    private String clusteringSportAt ;                   // 클러스터링 지원 여부
    private String sfsrvProvisioningSportAt ;            // 셀프서비스 프로비저닝 지원 여부
    private String svcProvisioningTime ;                 // 서비스 프로비저닝 시간
    private String svcProvisioningRelisTime ;            // 서비스 프로비저닝 해제 시간
    private String dataCnterHbrdLcInfo ;                 // 데이터센터 위치 정보
    private String dataCnterLcInfo ;                     // 데이터센터 국내, 외 위치 정보 *
    private String dataCnterLcInfoNm ;                   // 데이터센터 국내, 외 위치 정보 _ 명
    private String dsstrrecovryPlan ;                    // 재해복구계획 
    private String dataExtrcProcss ;                     // 데이터 추출 절차
    private String unuseDataPrtcPolicy ;                 // 미사용 데이터 보호 정책
    private String safeDataDeletePolicy ;                // 안전한 데이터 삭제 정책
    private String svcManageSttusInfoSuply ;             // 서비스 관리 및 현황 정보 제공 
    private String svcUseLogSuplyAt ;                    // 서비스 이용 로그 제공 여부
    private String troblManageReprtPolicy ;              // 장애관리 및 보고 정책
    private String apiSportAt ;                          // API 지원 여부
    private String apiSportTy ;                          // API 지원 타입
    private String userMnlSuplyAt ;                      // 사용자 매뉴얼 제공 여부
    private String userMnlInfoAt ;                       // 사용자 매뉴얼 정보 유무
    private String userMnlInfoInput ;                    // 사용자 매뉴얼 정보 입력
    private String userEdcSportAt ;                      // 사용자 교육 지원 여부
    private String userEdcSportInput ;                   // 사용자 교육 지원 입력
    private String userEdcInfo ;                         // 사용자 교육 정보
    private String visitEdcSportAt ;                     // 방문 교육 지원 여부
    private String visitTchnlgySportAt ;                 // 방문 기술 지원 여부
    private String visitElseTchnlgySportAt ;             // 방문 외(온라인, 이메일, 전화 등) 기술 지원 여부
    private String cstmrCnterOperAt ;                    // 고객센터 운영 여부
    private String cstmrCnterOperTime ;                  // 고객센터 운영 시간      
    
    private String iOthbcStdSportDoc ;                   // 공개표준 지원 및 문서
    private String iSvcDirectCnncNtwrk ;                 // 서비스에 직접 연결하는 네트워크
    private String iVirtlNtwrkSport ;                    // 가상 네트워크 지원
    private String iSynchrnSportAt ;                     // 동기화 지원 여부 
    private String iSportEqpmnList ;                     // 지원 장비 목록
    private String iServerComputerSvc ;                  // 서버/컴퓨터 서비스
    private String iStrgeSvc ;                           // 스토리지 서비스
    private String iNtwrkSvc ;                           // 네트워크 서비스
    private String iScrtySvc ;                           // 보안 서비스
    private String iManageSvc ;                          // 관리 서비스
    private String iEtcSvc ;                             // 기타 서비스
    
    private String pSecureDevlop ;                       // Secure 개발
    private String pSecureDctWdtb ;                      // Secure design, coding, testing 및 배포
    private String pSportLang ;                          // 지원 언어
    private String pSportPltfom ;                        // 지원 플랫폼
    private String pSportContainerVer ;                  // 지원 Container 및 버전
    private String pSportDataStorge ;                    // 지원 데이터 저장소
    private String pSubTenancySportAt ;                  // Sub-tenancy 지원 여부
    private String pDvlprUntInfo ;                       // 개발자 도구 정보
    private String pSdkApiSuplyAt ;                      // SDK/API 제공 여부
    private String pTestDebugingSportAt ;                // 테스트 및 디버깅 지원 여부
    private String pAddonSvcMarkplaceSportAt ;           // Add-on 서비스 및 마켓플레이스 지원 여부
    private String pCisportSport ;                       // CISPORT(Continuous Integration) 지원
    private String pLogingMntrngSport ;                  // 로깅/모니터링 지원
    private String pLoadBalancingSport ;                 // Load Balancing 지원
    
    private String sUserSvcSuplyMthd ;                   // 사용자용 서비스 제공 방식
    private String sManageSvcSuplyMthd ;                 // 관리용 서비스 제공 방식
    private String sInfrstrctrSuplyMthd ;                // 인프라 제공 방식
    private String sScrtyPolicy ;                        // 보안 정책 
    private String sDataEncptAtMthd ;                    // 데이터 암호화 여부 및 방식
    private String sBackupRecovryPolicy ;                // 백업 및 복구 정책
    private String sUserCrtfcScrtyPrtcPolicy ;           // 사용자 인증 및 보안 보호 정책
    private String sMultiPltfomSportAt ;                 // 다중 플랫폼 지원 여부
    private String sSportOpersysmList ;                  // 지원 운영체계 목록
    private String sSportWbsrList ;                      // 지원 웹브라우저 목록
    private String sSportMobilePltfomList ;              // 지원 모바일 플랫폼 목록
    private String sOpenStdSportAt ;                     // 개방형 표준 지원 여부
    private String sGvrnFrmwrkSportAt ;                  // 정부 프레임워크 지원 여부
    private String sOpenSourcSwAt ;                      // 오픈소스 SW 호환 여부
    private String sPaastaAt ;                           // PaaS-Ta 호환 여부
    private String sSourcOthbcAt ;                       // 소스 공개 여부
    private String sApiAccessSportAt ;                   // 외부 API ACCESS 지원 여부
    private String sDbMigrationSportAt ;                 // DB 마이그레이션 지원 여부
    private String sExtrlApplicationSportAt ;            // 외부 응용프로그램 통합 지원 여부
    private String sSubTenancySportAt ;                  // Sub-tenancy 지원 여부
    private String sCstmzngPosblAt ;                     // 커스터마이징 가능 여부
    private String sDevlopSportEtc ;                     // 개발지원 조건 및 기타 사항
    
    private String cSpcltyRealm ;                        // 전문 분야 
    private String cIndcWhole ;                          // 도입전반 
    private String cSetupMgr ;                           // setup & migration
    private String cHoldQualf ;                          // 보유자격 
    private String cHoldTchnlgy ;                        // 보유기술
    private String cInfrstrctr ;                         // 컨설팅가능 인프라
    private String cInfrstrctrNm ;                       // 컨설팅가능 인프라 [이름]
    private String cInfrstrctrEtc ;                      // 컨설팅가능 인프라 기타
    private String cPltfom ;                             // 컨설팅가는 플랫폼
    private String cPltfomNm ;                           // 컨설팅가는 플랫폼 [이름]
    private String cPltfomEtc ;                          // 컨설팅가는 플랫폼 기타
    private String cPrjctExprnc ;                        // 프로젝트 경험
    private String cCnslRelm ;                           // 컨설팅 영역
    private String cCnslRelmNm ;                        // 컨설팅 영역 [이름]
    private String cCnslRelmEtc ;                        // 컨설팅 영역 기타
    private String cCnslScope ;                          // 컨설팅 범위
    private String cCnslScopeNm ;                          // 컨설팅 범위 [이름] 

    private String cDetailSvc ;                          // 컨설팅 가능 상세 서비스
    private String cExcPd ;                              // 수행기간
    private String cExcPdNm ;                            // 수행기간 [이름]
    private String cExcPdEtc ;                           // 수행기간 기타
    private String cExcArea ;                            // 수행가능지역
    private String cExcAreaNm ;                          // 수행가능지역 [이름]
    private String cBeffatCnslAt ;                       // 사전컨설팅 가능 여부
    private String cCnslPc ;                             // 컨설팅 가격
    
    private String step;
    private String chgItemContent;                       //규격서변경사유       
    
    private String updtId;
    private String isMark; 

    private List<GoodsSpecDescribeVO> itemDnFileOrdrNo;
    private List<GoodsSpecDescribeVO> itemDnFileNm;
    
    private List<FileVO> dnlFile;
    private List<FileVO> etcFile;
    private List<FileVO> priceFile; // <!-- {{ 2016.01.13 가격표 다운로드 파일 추가 --!>    
    
    /**
     * List<FileVO> dnlFile을 반환
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
     * List<GoodsSpecDescribeVO> itemDnFileOrdrNo을 반환
     * @return List<GoodsSpecDescribeVO> itemDnFileOrdrNo
     */
    public List<GoodsSpecDescribeVO> getItemDnFileOrdrNo() {
        return itemDnFileOrdrNo;
    }









    
    /**
     * itemDnFileOrdrNo을 설정
     * @param itemDnFileOrdrNo 을(를) List<GoodsSpecDescribeVO> itemDnFileOrdrNo로 설정
     */
    public void setItemDnFileOrdrNo(List<GoodsSpecDescribeVO> itemDnFileOrdrNo) {
        this.itemDnFileOrdrNo = itemDnFileOrdrNo;
    }









    
    /**
     * List<GoodsSpecDescribeVO> itemDnFileNm을 반환
     * @return List<GoodsSpecDescribeVO> itemDnFileNm
     */
    public List<GoodsSpecDescribeVO> getItemDnFileNm() {
        return itemDnFileNm;
    }









    
    /**
     * itemDnFileNm을 설정
     * @param itemDnFileNm 을(를) List<GoodsSpecDescribeVO> itemDnFileNm로 설정
     */
    public void setItemDnFileNm(List<GoodsSpecDescribeVO> itemDnFileNm) {
        this.itemDnFileNm = itemDnFileNm;
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



    private String entrDate ;                            // 생성일시
    private String userId ;                              // 로그인아이디
    
    private String updateYn;
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
     * String entrDate을 반환
     * @return String entrDate
     */
    public String getEntrDate() {
        return entrDate;
    }

    
    /**
     * entrDate을 설정
     * @param entrDate 을(를) String entrDate로 설정
     */
    public void setEntrDate(String entrDate) {
        this.entrDate = entrDate;
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
     * String entrprsSeNm을 반환
     * @return String entrprsSeNm
     */
    public String getEntrprsSeNm() {
        return entrprsSeNm;
    }


    /**
     * entrprsSeNm을 설정
     * @param entrprsSeNm 을(를) String entrprsSeNm로 설정
     */
    public void setEntrprsSeNm(String entrprsSeNm) {
        this.entrprsSeNm = entrprsSeNm;
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
     * String svcTyNm을 반환
     * @return String svcTyNm
     */
    public String getSvcTyNm() {
        return svcTyNm;
    }


    /**
     * svcTyNm을 설정
     * @param svcTyNm 을(를) String svcTyNm로 설정
     */
    public void setSvcTyNm(String svcTyNm) {
        this.svcTyNm = svcTyNm;
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
     * String svcEntrprsSuplyTyNm을 반환
     * @return String svcEntrprsSuplyTyNm
     */
    public String getSvcEntrprsSuplyTyNm() {
        return svcEntrprsSuplyTyNm;
    }


    /**
     * svcEntrprsSuplyTyNm을 설정
     * @param svcEntrprsSuplyTyNm 을(를) String svcEntrprsSuplyTyNm로 설정
     */
    public void setSvcEntrprsSuplyTyNm(String svcEntrprsSuplyTyNm) {
        this.svcEntrprsSuplyTyNm = svcEntrprsSuplyTyNm;
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
     * String vatInclsAtNm을 반환
     * @return String vatInclsAtNm
     */
    public String getVatInclsAtNm() {
        return vatInclsAtNm;
    }


    /**
     * vatInclsAtNm을 설정
     * @param vatInclsAtNm 을(를) String vatInclsAtNm로 설정
     */
    public void setVatInclsAtNm(String vatInclsAtNm) {
        this.vatInclsAtNm = vatInclsAtNm;
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
     * String dataCnterLcInfoNm을 반환
     * @return String dataCnterLcInfoNm
     */
    public String getDataCnterLcInfoNm() {
        return dataCnterLcInfoNm;
    }

    /**
     * dataCnterLcInfoNm을 설정
     * @param dataCnterLcInfoNm 을(를) String dataCnterLcInfoNm로 설정
     */
    public void setDataCnterLcInfoNm(String dataCnterLcInfoNm) {
        this.dataCnterLcInfoNm = dataCnterLcInfoNm;
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
     * String cInfrstrctrNm을 반환
     * @return String cInfrstrctrNm
     */
    public String getcInfrstrctrNm() {
        return cInfrstrctrNm;
    }


    /**
     * cInfrstrctrNm을 설정
     * @param cInfrstrctrNm 을(를) String cInfrstrctrNm로 설정
     */
    public void setcInfrstrctrNm(String cInfrstrctrNm) {
        this.cInfrstrctrNm = cInfrstrctrNm;
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
     * String cPltfomNm을 반환
     * @return String cPltfomNm
     */
    public String getcPltfomNm() {
        return cPltfomNm;
    }


    /**
     * cPltfomNm을 설정
     * @param cPltfomNm 을(를) String cPltfomNm로 설정
     */
    public void setcPltfomNm(String cPltfomNm) {
        this.cPltfomNm = cPltfomNm;
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
     * String cCnslRelmNm을 반환
     * @return String cCnslRelmNm
     */
    public String getcCnslRelmNm() {
        return cCnslRelmNm;
    }

    /**
     * cCnslRelmNm을 설정
     * @param cCnslRelmNm 을(를) String cCnslRelmNm로 설정
     */
    public void setcCnslRelmNm(String cCnslRelmNm) {
        this.cCnslRelmNm = cCnslRelmNm;
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
     * String cCnslScopeNm을 반환
     * @return String cCnslScopeNm
     */
    public String getcCnslScopeNm() {
        return cCnslScopeNm;
    }

    /**
     * cCnslScopeNm을 설정
     * @param cCnslScopeNm 을(를) String cCnslScopeNm로 설정
     */
    public void setcCnslScopeNm(String cCnslScopeNm) {
        this.cCnslScopeNm = cCnslScopeNm;
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
     * String cExcPdNm을 반환
     * @return String cExcPdNm
     */
    public String getcExcPdNm() {
        return cExcPdNm;
    }


    /**
     * cExcPdNm을 설정
     * @param cExcPdNm 을(를) String cExcPdNm로 설정
     */
    public void setcExcPdNm(String cExcPdNm) {
        this.cExcPdNm = cExcPdNm;
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
     * String cExcAreaNm을 반환
     * @return String cExcAreaNm
     */
    public String getcExcAreaNm() {
        return cExcAreaNm;
    }


    /**
     * cExcAreaNm을 설정
     * @param cExcAreaNm 을(를) String cExcAreaNm로 설정
     */
    public void setcExcAreaNm(String cExcAreaNm) {
        this.cExcAreaNm = cExcAreaNm;
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
     * String step을 반환
     * @return String step
     */
    public String getStep() {
        return step;
    }


    
    /**
     * step을 설정
     * @param step 을(를) String step로 설정
     */
    public void setStep(String step) {
        this.step = step;
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

    
}
