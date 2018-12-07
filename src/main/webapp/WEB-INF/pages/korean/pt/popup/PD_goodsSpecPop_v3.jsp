<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
 <head>
  <meta charset="UTF-8" />
  <title>POPUP - 서비스 규격서</title>
  <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
  <script type="text/javascript">
    // 닫기
    var jsClose = function(){
        parent.$.fn.colorbox.close();
    };

      var reportAction = function(){
          var open = "http://korean.ceart.kr/report/reporting.jsp?reportSection=3001&goodsCode=${specVo.goodsCode}";
        window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
    };
  </script>

 </head>

 <body class="winPopup view_spec">
    <h2>서비스 규격서  <a href="#"  onclick="jsClose();">닫기</a></h2>
    <div class="btnArea rig">
        <a href="#" class="btns st1" onClick="reportAction();">레포트 출력</a>
        <!-- <a href="#"><img src="/cloud_ver2/new_cloud/images/icn_print.png" alt="프린트" /></a> -->
    </div>
    <div>

        <h3>직접 등록 정보</h3>


        <table class="tbl_st5">
            <colgroup>
                <col width="20%"/>
                <col width="40%"/>
                <col width="40%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>대항목</th>
                    <th>세부항목</th>
                    <th>내용</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan="7">1. 서비스 일반정보</td>
                    <td>서비스명칭</td>
                    <td>${specVo.svcNm} </td>
                </tr>
                <tr>
                    <td>서비스 구분</td>
                    <td>${specVo.svcTyNm} </td>
                </tr>
                <tr>
                    <td>과금 기준(최소) </td>
                    <td>${specVo.dueStdrMummNm} </td>
                </tr>
                <tr>
                    <td>서비스 가격</td>
                    <td>${specVo.svcPc} </td>
                </tr>
                <tr>
                    <td>최소 계약기간</td>
                    <td>${specVo.mummCntrctpd} </td>
                </tr>
                <tr>
                    <td>가격테이블 첨부 여부</td>
                    <td>${specVo.pcTableAtchAt} </td>
                </tr>
                <tr>
                    <td>VAT포함여부 </td>
                    <td>${specVo.vatInclsAt} </td>
                </tr>

                <tr>
                    <td rowspan="3">2-1. 서비스 상세정보</td>
                    <td>주요 레퍼런스</td>
                    <td>${specVo.mainRefer} </td>
                </tr>
                <tr>
                    <td>서비스 정의 및 특징</td>
                    <td>${specVo.svcDfnSfe} </td>
                </tr>
                <tr>
                    <td>서비스 기대효과</td>
                    <td>${specVo.svcExpcEffect} </td>
                </tr>

                <tr>
                    <c:set var="temp" value=""/>

                    <td>2-2. 서비스 사양정보</td>
                    <td>구축방식</td>

                    <c:if test="${specVo.privateCloudAt eq 'Y'}">
                        <c:set var="val" value="Private cloud"/>
                        <c:choose>
                            <c:when test="${temp ne ''}">
                                <c:set var="temp" value="temp+', '+val"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="temp" value="val"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${specVo.publicCloudAt eq 'Y'}">
                        <c:set var="val" value="Public cloud"/>
                        <c:choose>
                            <c:when test="${temp ne ''}">
                                <c:set var="temp" value="temp+', '+val"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="temp" value="val"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${specVo.hybridCloudAt eq 'Y'}">
                        <c:set var="val" value="Hybrid cloud"/>
                        <c:choose>
                            <c:when test="${temp ne ''}">
                                <c:set var="temp" value="temp+', '+val"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="temp" value="val"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <td>${temp} </td>
                </tr>

                <tr>
                    <td rowspan="6">2-3. 서비스 인증정보</td>
                    <td>클라우드 보안 인증(KISA) 여부</td>
                    <td>${specVo.kisaCrtfcAt} </td>
                </tr>
                <tr>
                    <td>CC 인증 여부</td>
                    <td>${specVo.ccCrtfcAt} </td>
                </tr>
                <tr>
                    <td>GS 인증 여부</td>
                    <td>${specVo.gsCrtfcAt} </td>
                </tr>
                <tr>
                    <td>클라우드 서비스 품질 인증 여부</td>
                    <td>${specVo.cloudSvcQlityCrtfcAt} </td>
                </tr>
                <tr>
                    <td>클라우드 서비스 확인제 여부</td>
                    <td>${specVo.cloudSvcCnfirmAt} </td>
                </tr>
                <tr>
                    <td>나라장터종합쇼핑몰 등록 여부</td>
                    <td>${specVo.gnrlzSopmalRegistAt} </td>
                </tr>

            </tbody>

        </table>


        <c:if test="${specVo.goodsKndCd eq 1003}">

            <br/><br/>

            <h3>3-4. 서비스형 소프트웨어(Iaas) 관련 규격</h3>

            <table class="tbl_st5">
                <colgroup>
                    <col width="20%"/>
                    <col width="40%"/>
                    <col width="40%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>대항목</th>
                        <th>세부항목</th>
                        <th>내용</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="center">공개표준지원</td>
                        <td>공개표준 지원 및 문서</td>
                        <td>${specVo.iOthbcStdSportDoc} </td>
                    </tr>
                    <tr>
                        <td rowspan="2" align="center">네트워크와 연결</td>
                        <td>서비스에 직접 연결하는 네트워크</td>
                        <td>${specVo.iSvcDirectCnncNtwrk} </td>
                    </tr>
                    <tr>
                        <td>가상 네트워크 지원</td>
                        <td>${specVo.iVirtlNtwrkSport} </td>
                    </tr>
                    <tr>
                        <td rowspan="2" align="center">접근지원</td>
                        <td>동기화 지원 여부</td>
                        <td>${specVo.iSynchrnSportAt} </td>
                    </tr>
                    <tr>
                        <td>지원 장비 목록</td>
                        <td>${specVo.iSportEqpmnList} </td>
                    </tr>
                    <tr>
                        <td rowspan="6" align="center">제공서비스</td>
                        <td>서버/컴퓨터 서비스</td>
                        <td>${specVo.iServerComputerSvc} </td>
                    </tr>
                    <tr>
                        <td>스토리지 서비스</td>
                        <td>${specVo.iStrgeSvc} </td>
                    </tr>
                    <tr>
                        <td>네트워크 서비스</td>
                        <td>${specVo.iNtwrkSvc} </td>
                    </tr>
                    <tr>
                        <td>보안 서비스</td>
                        <td>${specVo.iScrtySvc} </td>
                    </tr>
                    <tr>
                        <td>관리 서비스</td>
                        <td>${specVo.iManageSvc} </td>
                    </tr>
                    <tr>
                        <td>기타 서비스</td>
                        <td>${specVo.iEtcSvc} </td>
                    </tr>

                    <tr>
                        <td rowspan="6" align="center">4-1. 제공자 정보</td>
                        <td>회사명칭</td>
                        <td>${specVo.langStoreNm} </td>
                    </tr>
                    <tr>
                        <td>회사 설립년도</td>
                        <td>${specVo.cmpnyFondYear} </td>
                    </tr>
                    <tr>
                        <td>회사 소개</td>
                        <td>${specVo.cmpnyIntrcn} </td>
                    </tr>
                    <tr>
                        <td>사업 분야</td>
                        <td>${specVo.bsnsRealm} </td>
                    </tr>
                    <tr>
                        <td>서비스 제공 기업의 공급 유형</td>
                        <td>${specVo.svcEntrprsSuplyTyNm} </td>
                    </tr>
                    <tr>
                        <td>기업 구분</td>
                        <td>${specVo.entrprsSeNm} </td>
                    </tr>

                    <tr>
                        <td rowspan="3" align="center">4-2. 서비스 담당자 정보</td>
                        <td>서비스 담당자 이름</td>
                        <td>${specVo.svcChargerNm} </td>
                    </tr>
                    <tr>
                        <td>서비스 담당자 이메일</td>
                        <td>${specVo.svcChargerEmail} </td>
                    </tr>
                    <tr>
                        <td>서비스 담당자 전화번호</td>
                        <td>${specVo.svcChargerTelno} </td>
                    </tr>
                </tbody>
            </table>

        </c:if>


        <c:if test="${specVo.goodsKndCd eq 1001}">

            <br/><br/>

            <h3>3-4. 서비스형 소프트웨어(Paas) 관련 규격</h3>

            <table class="tbl_st5">
                <thead>
                    <tr>
                        <th>대항목</th>
                        <th>세부항목</th>
                        <th>내용</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="2" align="center">Secure 개발</td>
                        <td>Secure 개발</td>
                        <td>${specVo.pSecureDevlop} </td>
                    </tr>
                    <tr>
                        <td>Secure design, coding, testing 및 배포</td>
                        <td>${specVo.pSecureDctWdtb} </td>
                    </tr>
                    <tr>
                        <td rowspan="5" align="center">아키텍처 계획 수립</td>
                        <td>지원 언어</td>
                        <td>${specVo.pSportLang} </td>
                    </tr>
                    <tr>
                        <td>지원 플랫폼</td>
                        <td>${specVo.pSportPltfom} </td>
                    </tr>
                    <tr>
                        <td>지원 Container 및 버전</td>
                        <td>${specVo.pSportContainerVer} </td>
                    </tr>
                    <tr>
                        <td>지원 데이터 저장소</td>
                        <td>${specVo.pSportDataStorge} </td>
                    </tr>
                    <tr>
                        <td>Sub-tenancy 지원 여부</td>
                        <td>${specVo.pSubTenancySportAt} </td>
                    </tr>
                    <tr>
                        <td rowspan="4" align="center">응용프로그램 개발</td>
                        <td>개발자 도구 정보</td>
                        <td>${specVo.pDvlprUntInfo} </td>
                    </tr>
                    <tr>
                        <td>SDK/API 제공 여부</td>
                        <td>${specVo.pSdkApiSuplyAt} </td>
                    </tr>
                    <tr>
                        <td>테스트 및 디버깅 지원 여부</td>
                        <td>${specVo.pTestDebugingSportAt} </td>
                    </tr>
                    <tr>
                        <td>Add-on 서비스 및 마켓플레이스 지원 여부</td>
                        <td>${specVo.pAddonSvcMarkplaceSportAt} </td>
                    </tr>
                    <tr>
                        <td rowspan="3" align="center">배포 및 운영환경</td>
                        <td>CISPORT(Continuous Integration) 지원</td>
                        <td>${specVo.pCisportSport} </td>
                    </tr>
                    <tr>
                        <td>로깅/모니터링 지원</td>
                        <td>${specVo.pLogingMntrngSport} </td>
                    </tr>
                    <tr>
                        <td>Load Balancing 지원</td>
                        <td>${specVo.pLoadBalancingSport} </td>
                    </tr>

                    <tr>
                        <td rowspan="6" align="center">4-1. 제공자 정보</td>
                        <td>회사명칭</td>
                        <td>${specVo.cmpnyNm} </td>
                    </tr>
                    <tr>
                        <td>회사 설립년도</td>
                        <td>${specVo.cmpnyFondYear} </td>
                    </tr>
                    <tr>
                        <td>회사 소개</td>
                        <td>${specVo.cmpnyIntrcn} </td>
                    </tr>
                    <tr>
                        <td>사업 분야</td>
                        <td>${specVo.bsnsRealm} </td>
                    </tr>
                    <tr>
                        <td>서비스 제공 기업의 공급 유형</td>
                        <td>${specVo.svcEntrprsSuplyTy} </td>
                    </tr>
                    <tr>
                        <td>기업 구분</td>
                        <td>${specVo.entrprsSe} </td>
                    </tr>

                    <tr>
                        <td rowspan="3" align="center">4-2. 서비스 담당자 정보</td>
                        <td>서비스 담당자 이름</td>
                        <td>${specVo.svcChargerNm} </td>
                    </tr>
                    <tr>
                        <td>서비스 담당자 이메일</td>
                        <td>${specVo.svcChargerEmail} </td>
                    </tr>
                    <tr>
                        <td>서비스 담당자 전화번호</td>
                        <td>${specVo.svcChargerTelno} </td>
                    </tr>
                </tbody>
            </table>

        </c:if>


        <c:if test="${specVo.goodsKndCd eq 1002}">

            <br/><br/>

            <h3>3-4. 서비스형 소프트웨어(Saas) 관련 규격</h3>

            <table class="tbl_st5">
                <thead>
                    <tr>
                        <th>대항목</th>
                        <th>세부항목</th>
                        <th>내용</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="2" align="center">서비스 제공 방식</td>
                        <td>사용자용 서비스 제공 방식</td>
                        <td>${specVo.sUserSvcSuplyMthd} </td>
                    </tr>
                    <tr>
                        <td>관리용 서비스 제공 방식</td>
                        <td>${specVo.sManageSvcSuplyMthd} </td>
                    </tr>

                    <tr>
                        <td rowspan="5" align="center">서비스 보안 관리</td>
                        <td>인프라 제공 방식</td>
                        <td>${specVo.sInfrstrctrSuplyMthd} </td>
                    </tr>
                    <tr>
                        <td>보안 정책</td>
                        <td>${specVo.sScrtyPolicy} </td>
                    </tr>
                    <tr>
                        <td>데이터 암호화 여부 및 방식</td>
                        <td>${specVo.sDataEncptAtMthd} </td>
                    </tr>
                    <tr>
                        <td>백업 및 복구 정책</td>
                        <td>${specVo.sBackupRecovryPolicy} </td>
                    </tr>
                    <tr>
                        <td>사용자 인증 및 보안 보호 정책</td>
                        <td>${specVo.sUserCrtfcScrtyPrtcPolicy} </td>
                    </tr>

                    <tr>
                        <td rowspan="4" align="center">다중 플랫폼<br/>(cross platform)</td>
                        <td>다중 플랫폼 지원 여부</td>
                        <td>${specVo.sMultiPltfomSportAt} </td>
                    </tr>
                    <tr>
                        <td>지원 운영체계 목록</td>
                        <td>${specVo.sSportOpersysmList} </td>
                    </tr>
                    <tr>
                        <td>지원 웹브라우저 목록</td>
                        <td>${specVo.sSportWbsrList} </td>
                    </tr>
                    <tr>
                        <td>지원 모바일 플랫폼 목록</td>
                        <td>${specVo.sSportMobilePltfomList} </td>
                    </tr>

                    <tr>
                        <td rowspan="4" align="center">호환성 정보</td>
                        <td>개방형 표준 지원 여부</td>
                        <td>${specVo.sOpenStdSportAt} </td>
                    </tr>
                    <tr>
                        <td>정부 프레임워크 지원 여부</td>
                        <td>${specVo.sGvrnFrmwrkSportAt} </td>
                    </tr>
                    <tr>
                        <td>오픈소스 SW 호환 여부</td>
                        <td>${specVo.sOpenSourcSwAt} </td>
                    </tr>
                    <tr>
                        <td>PaaS-Ta 호환 여부</td>
                        <td>${specVo.sPaastaAt} </td>
                    </tr>

                    <tr>
                        <td rowspan="7" align="center">개발지원 정보</td>
                        <td>소스 공개 여부</td>
                        <td>${specVo.sSourcOthbcAt} </td>
                    </tr>
                    <tr>
                        <td>외부 API ACCESS 지원 여부</td>
                        <td>${specVo.sApiAccessSportAt} </td>
                    </tr>
                    <tr>
                        <td>DB 마이그레이션 지원 여부</td>
                        <td>${specVo.sDbMigrationSportAt} </td>
                    </tr>
                    <tr>
                        <td>외부 응용프로그램 통합 지원 여부</td>
                        <td>${specVo.sExtrlApplicationSportAt} </td>
                    </tr>
                    <tr>
                        <td>Sub-tenancy 지원 여부</td>
                        <td>${specVo.sSubTenancySportAt} </td>
                    </tr>
                    <tr>
                        <td>커스터마이징 가능 여부</td>
                        <td>${specVo.sCstmzngPosblAt} </td>
                    </tr>
                    <tr>
                        <td>개발지원 조건 및 기타 사항</td>
                        <td>${specVo.sDevlopSportEtc} </td>
                    </tr>

                    <tr>
                        <td rowspan="6" align="center">4-1. 제공자 정보</td>
                        <td>회사명칭</td>
                        <td>${specVo.cmpnyNm} </td>
                    </tr>
                    <tr>
                        <td>회사 설립년도</td>
                        <td>${specVo.cmpnyFondYear} </td>
                    </tr>
                    <tr>
                        <td>회사 소개</td>
                        <td>${specVo.cmpnyIntrcn} </td>
                    </tr>
                    <tr>
                        <td>사업 분야</td>
                        <td>${specVo.bsnsRealm} </td>
                    </tr>
                    <tr>
                        <td>서비스 제공 기업의 공급 유형</td>
                        <td>${specVo.svcEntrprsSuplyTy} </td>
                    </tr>
                    <tr>
                        <td>기업 구분</td>
                        <td>${specVo.entrprsSe} </td>
                    </tr>

                    <tr>
                        <td rowspan="3" align="center">4-2. 서비스 담당자 정보</td>
                        <td>서비스 담당자 이름</td>
                        <td>${specVo.svcChargerNm} </td>
                    </tr>
                    <tr>
                        <td>서비스 담당자 이메일</td>
                        <td>${specVo.svcChargerEmail} </td>
                    </tr>
                    <tr>
                        <td>서비스 담당자 전화번호</td>
                        <td>${specVo.svcChargerTelno} </td>
                    </tr>

                </tbody>
            </table>

        </c:if>


        <c:if test="${specVo.goodsKndCd eq 1004}">

            <%--
            <br/><br/>

            <table class="tbl_st5">
                <thead>
                    <tr>
                        <th>대항목</th>
                        <th>세부항목</th>
                        <th>내용</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="19" align="center">SCS</td>
                        <td>전문 분야 </td>
                        <td>${specVo.cSpcltyRealm} </td>
                    </tr>
                    <tr>
                        <td>도입전반</td>
                        <td>${specVo.cIndcWhole} </td>
                    </tr>
                    <tr>
                        <td>Setup &amp; Migration</td>
                        <td>${specVo.cSetupMgr} </td>
                    </tr>
                    <tr>
                        <td>보유자격 </td>
                        <td>${specVo.cHoldQualf} </td>
                    </tr>
                    <tr>
                        <td>보유기술</td>
                        <td>${specVo.cHoldTchnlgy} </td>
                    </tr>
                    <tr>
                        <td>컨설팅가능 인프라</td>
                        <td>${specVo.cInfrstrctr} </td>
                    </tr>
                    <tr>
                        <td>컨설팅가능 인프라 기타</td>
                        <td>${specVo.cInfrstrctrEtc} </td>
                    </tr>
                    <tr>
                        <td>컨설팅가능 플랫폼</td>
                        <td>${specVo.cPltfom} </td>
                    </tr>
                    <tr>
                        <td>컨설팅가능 플랫폼 기타</td>
                        <td>${specVo.cPltfomEtc} </td>
                    </tr>
                    <tr>
                        <td>프로젝트 경험</td>
                        <td>${specVo.cPrjctExprnc} </td>
                    </tr>
                    <tr>
                        <td>컨설팅 영역</td>
                        <td>${specVo.cCnslRelm} </td>
                    </tr>
                    <tr>
                        <td>컨설팅 영역 기타</td>
                        <td>${specVo.cCnslRelmEtc} </td>
                    </tr>
                    <tr>
                        <td>컨설팅 범위</td>
                        <td>${specVo.cCnslScope} </td>
                    </tr>
                    <tr>
                        <td>컨설팅 가능 상세 서비스</td>
                        <td>${specVo.cDetailSvc} </td>
                    </tr>
                    <tr>
                        <td>수행기간</td>
                        <td>${specVo.cExcPd} </td>
                    </tr>
                    <tr>
                        <td>수행기간 기타</td>
                        <td>${specVo.cExcPdEtc} </td>
                    </tr>
                    <tr>
                        <td>수행가능지역</td>
                        <td>${specVo.cExcArea} </td>
                    </tr>
                    <tr>
                        <td>사전컨설팅 가능 여부</td>
                        <td>${specVo.cBeffatCnslAt} </td>
                    </tr>
                    <tr>
                        <td>컨설팅 가격 </td>
                        <td>${specVo.cCnslPc} </td>
                    </tr>

                </tbody>
            </table>
            --%>

        </c:if>

    </div>

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
 </body>
</html>