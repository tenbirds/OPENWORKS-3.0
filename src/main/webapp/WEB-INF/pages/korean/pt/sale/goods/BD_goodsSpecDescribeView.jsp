<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>수요정보조사</title>
    <op:jsTag type="openworks" items="ui" />
    <op:jsTag type="spi" items="form,validate" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />

    <script type="text/javascript">
        $(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");});});
    </script>
    
    <style>
        .goodsDescribePage { margin-top: 20px; }
    </style>

    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">
    var jsWaitingView = function(vl){    
          document.dataForm.action = "BD_waitingView.do";
          document.dataForm.submit();
    };
    
    var jsGoodsView = function(vl){    
          document.dataForm.action = "BD_goodsView.do";
          document.dataForm.submit();
    };
    
    var jsGoodsSpecAction = function() {
        location.href="/korean/pt/sale/goods/BD_goodsSpecForm.do?goodsCode=${specDescribeVo.goodsCode}";
        /* document.dataForm.action = "BD_goodsSpecForm.do";
        document.dataForm.submit(); */
    };
    
 
    var jsGoodsUpdateAction = function(sttus) {
        $("#goodsRegistSttus").val(sttus);
        $("#insertSection").val(sttus);
        if (confirm("등록 신청시 관리자가 검토, 승인이 완료되기 전까지 해당 서비스를 수정할 수 없습니다.\n등록 신청을 하시겠습니까?")) {
            $("#dataForm").attr("action", "ND_goodsConfirmAction.do");
            $("#dataForm").submit();
        }
    };
    </script>
    <!-- 사용자 스크립트 끝 -->
</head>
<body>
<form name="dataForm" id="dataForm" method="post">
    <input type="hidden" name="goodsStatus" id="goodsStatus"  value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" name="goodsRegistSttus"  id="goodsRegistSttus"/>
    <input type="hidden" name="insertSection" id="insertSection" value=""/>
    <input type="hidden" name="registDt" id="registDt" value="<c:out value='${dataVo.registDt}'/>"/>
    <input type="hidden" name="goodsCode" id="goodsCode" value="<c:out value='${dataVo.goodsCode}'/>"/>
</form>
<div class="supAdm register">
                <c:if test="${dataVo.goodsRegistSttus eq 1001 || dataVo.goodsRegistSttus eq 1008}"><img src="/cloud_ver2/new_cloud/images/srvRgst_step_3.png" alt="등록된 규격서 확인" /></c:if>
                <h3>등록된 규격서 확인</h3>
                
                <div class="btnArea rig"><%-- ${dataVo.goodsRegistSttus} --%>
                    <c:if test="${dataVo.goodsRegistSttus eq 1002 or dataVo.goodsRegistSttus eq 1009}">
                    <a href="javascript:"onClick="jsWaitingView()"  class="f_l btns st2 icn icnBck2">이전</a>
                    </c:if>
                    <c:if test="${dataVo.goodsRegistSttus eq 1007}">
                    <a href="javascript:"onClick="jsGoodsView()"  class="f_l btns st2 icn icnBck2">이전</a>
                    </c:if>
                    <c:if test="${dataVo.goodsRegistSttus eq 1001 || dataVo.goodsRegistSttus eq 1003 || dataVo.goodsRegistSttus eq 1008 }">    
                    <a href="javascript:" onClick="jsGoodsSpecAction()" class="f_l btns st1 icn icnXlx">규격서 다시 등록</a>                    
                    </c:if>
                    <c:if test="${dataVo.goodsRegistSttus eq 1001 || dataVo.goodsRegistSttus eq 1003}">
                    <a href="javascript:" onClick="jsGoodsUpdateAction('1002')"  id="regReq" class="btns st1 icn icnWrite">등록신청</a>
                    </c:if>
                    <c:if test="${dataVo.goodsRegistSttus eq 1008 || dataVo.goodsRegistSttus eq 1010}">
                    <a href="javascript:" onClick="jsGoodsUpdateAction('1009')"  id="regReq" class="btns st1 icn icnWrite">등록신청</a>
                    </c:if>
                </div>                
                
                
                
                <div class="goodsDescribePage">
                <table class="tbl_st5" border="1" >
                    <thead>
                        <tr>
                            <th style="width: 150px;">대항목</th>
                            <th style="width: 200px;">세부항목</th>
                            <th>입력</th>
                        </tr>
                    </thead>
                    <tbody>  
                    
                        <!--

                        1. 회사 개요

                        -->                                       
                        <tr><td rowspan="6">1. 회사 개요</td><td>회사 명칭</td><td>${specDescribeVo.cmpnyNm}</td></tr>
                        <tr><td>회사 설립년도</td><td>${specDescribeVo.cmpnyFondYear}</td></tr>
                        <tr><td>기업 구분 </td>
                            <td>${specDescribeVo.entrprsSeNm}</td>
                        </tr>
                        <tr><td>회사 소개</td></td><td>${specDescribeVo.cmpnyIntrcn}</td></tr>
                        <tr><td>사업 분야</td><td>${specDescribeVo.bsnsRealm}</td></tr>
                        <tr><td>주요 레퍼런스 (등록 서비스 기준)</td><td>${specDescribeVo.mainRefer}</td></tr>

                        <!--

                        2. 서비스 개요

                        --> 
                        <tr><td rowspan="18">2. 서비스 개요</td><td>서비스 명칭</td><td>${specDescribeVo.svcNm}</td></tr>
                        <tr><td>서비스 정의 및 특징</td><td>${specDescribeVo.svcDfnSfe}</td></tr>
                        <tr><td>서비스 기대효과</td><td>${specDescribeVo.svcExpcEffect}</td></tr>
                        <tr><td>서비스 유형  </td>
                            <td>${specDescribeVo.svcTyNm}</td>
                        </tr>
                        <tr><td>서비스 제공 기업의 공급 유형 </td>
                            <td>${specDescribeVo.svcEntrprsSuplyTyNm}</td>
                        </tr>
                        <tr><td>과금 기준(최소) </td>
                            <td>${specDescribeVo.dueStdrMummNm}</td>                       
                        </tr>
                        <tr><td>서비스 가격</td><td>${specDescribeVo.svcPc}</td></tr>
                        <tr><td>최소 계약기간</td><td>${specDescribeVo.mummCntrctpd}</td></tr>
                        <tr><td>가격테이블 첨부 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.pcTableAtchAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.pcTableAtchAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>VAT포함여부 </td>
                            <td>${specDescribeVo.vatInclsAtNm}</td>
                        </tr>
                        <tr><td>서비스 시작 절차</td><td>${specDescribeVo.svcBeginProcss}</td></tr>
                        <tr><td>서비스 종료 절차</td><td>${specDescribeVo.svcEndProcss}</td></tr>
                        <tr><td>서비스 평가판 제공여부</td>
                            <td>
                                <c:if test="${specDescribeVo.atSvcEvl eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.atSvcEvl eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>서비스 평가판 제공 기간</td><td>${specDescribeVo.svcEvlSuplyPd}</td></tr>
                        <tr><td>서비스 담당자 이름</td><td>${specDescribeVo.svcChargerNm}</td></tr>
                        <tr><td>서비스 담당자 전화번호</td><td>${specDescribeVo.svcChargerTelno}</td></tr>
                        <tr><td>서비스 담당자 이메일</td><td>${specDescribeVo.svcChargerEmail}</td></tr>
                        <tr><td>나라장터종합쇼핑몰 등록 여부</td><td>${specDescribeVo.gnrlzSopmalRegistAt}</td></tr>

                        <!--

                        3. 서비스 기술 정보

                        --> 
                        <tr><td rowspan="15">3. 서비스 기술 정보</td><td>Private cloud 구축 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.privateCloudAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.privateCloudAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>Public cloud 구축 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.publicCloudAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.publicCloudAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>Hybrid cloud 구축 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.hybridCloudAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.hybridCloudAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>클라우드 보안 인증(KISA) 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.kisaCrtfcAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.kisaCrtfcAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>클라우드 서비스 품질 인증 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.cloudSvcQlityCrtfcAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.cloudSvcQlityCrtfcAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>클라우드 서비스 확인제 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.cloudSvcCnfirmAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.cloudSvcCnfirmAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>CC 인증 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.ccCrtfcAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.ccCrtfcAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>GS 인증 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.gsCrtfcAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.gsCrtfcAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>SLA 적용 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.slaApplcAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.slaApplcAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>서비스 가용성 </td><td>${specDescribeVo.svcUseful}</td></tr>
                        <tr><td>자동 확장 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.atmcEstnSportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.atmcEstnSportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>클러스터링 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.clusteringSportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.clusteringSportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>셀프서비스 프로비저닝 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.sfsrvProvisioningSportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.sfsrvProvisioningSportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>서비스 프로비저닝 시간</td><td>${specDescribeVo.svcProvisioningTime}</td></tr>
                        <tr><td>서비스 프로비저닝 해제 시간</td><td>${specDescribeVo.svcProvisioningRelisTime}</td></tr>

                        <!--

                        4. 서비스 및 데이터 관리 정보

                        --> 
                        <tr><td rowspan="11">4. 서비스 및 데이터 관리 정보</td>
                            <td>데이터센터 국내, 외 위치 정보</td>
                            <td>${specDescribeVo.dataCnterLcInfoNm}</td>
                        </tr>
                        <tr><td>데이터센터 위치 정보 </td><td>${specDescribeVo.dataCnterHbrdLcInfo}</td></tr>
                        <tr><td>재해복구계획 </td><td>${specDescribeVo.dsstrrecovryPlan}</td></tr>
                        <tr><td>데이터 추출 절차</td><td>${specDescribeVo.dataExtrcProcss}</td></tr>
                        <tr><td>미사용 데이터 보호 정책</td><td>${specDescribeVo.unuseDataPrtcPolicy}</td></tr>
                        <tr><td>안전한 데이터 삭제 정책</td><td>${specDescribeVo.safeDataDeletePolicy}</td></tr>
                        <tr><td>서비스 관리 및 현황 정보 제공 </td>
                            <td>
                                <c:if test="${specDescribeVo.svcManageSttusInfoSuply eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.svcManageSttusInfoSuply eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>서비스 이용 로그 제공 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.svcUseLogSuplyAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.svcUseLogSuplyAt eq 'N'}">No</c:if>
                            </td>                       
                        </tr>
                        <tr><td>장애관리 및 보고 정책</td><td>${specDescribeVo.troblManageReprtPolicy}</td></tr>
                        <tr><td>API 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.apiSportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.apiSportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>API 지원 타입</td><td>${specDescribeVo.apiSportTy}</td></tr>

                        <!--

                        5. 서비스 지원 정보

                        --> 
                        <tr><td rowspan="10">5. 서비스 지원 정보</td>
                            <td>사용자 매뉴얼 제공 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.userMnlSuplyAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.userMnlSuplyAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>사용자 매뉴얼 정보 유무</td>
                            <td>
                                <c:if test="${specDescribeVo.userMnlInfoAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.userMnlInfoAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>사용자 매뉴얼 정보 입력</td><td>${specDescribeVo.userMnlInfoInput}</td></tr>
                        <tr><td>사용자 교육 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.userEdcSportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.userEdcSportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>사용자 교육 정보</td><td>${specDescribeVo.userEdcInfo}</td></tr>
                        <tr><td>방문 교육 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.visitEdcSportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.visitEdcSportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>방문 기술 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.visitTchnlgySportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.visitTchnlgySportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>방문 외(온라인, 이메일, 전화 등) 기술 지원 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.visitElseTchnlgySportAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.visitElseTchnlgySportAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>고객센터 운영 여부</td>
                            <td>
                                <c:if test="${specDescribeVo.cstmrCnterOperAt eq 'Y'}">Yes</c:if>
                                <c:if test="${specDescribeVo.cstmrCnterOperAt eq 'N'}">No</c:if>
                            </td>
                        </tr>
                        <tr><td>고객센터 운영 시간</td><td>${specDescribeVo.cstmrCnterOperTime}</td></tr>
                     </tbody>
                </table>
                </div>
                
                <c:if test="${specDescribeVo.goodsKndCd eq 1003}">                
                
	                
	                <div class="goodsDescribePage">
	                <table class="tbl_st5" border="1" >
	                    <thead>
	                        <tr>
	                            <th style="width: 150px;">대항목</th>
	                            <th style="width: 200px;">세부항목</th>
	                            <th>입력</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <!-- <tr><td colspan="3">Iaas</td></tr> -->
	                        <tr><td>공개표준지원</td><td>공개표준 지원 및 문서</td><td>${specDescribeVo.iOthbcStdSportDoc}</td></tr>
	                        <tr><td rowspan="2">네트워그와 연결</td><td>서비스에 직접 연결하는 네트워크</td><td>${specDescribeVo.iSvcDirectCnncNtwrk}</td></tr>
	                        <tr><td>가상 네트워크 지원</td><td>${specDescribeVo.iVirtlNtwrkSport}</td></tr>
	                        <tr><td rowspan="2">접근지원</td>
	                            <td>동기화 지원 여부 </td>
	                            <td>
	                                <c:if test="${specDescribeVo.iSynchrnSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.iSynchrnSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>지원 장비 목록</td><td>${specDescribeVo.iSportEqpmnList}</td></tr>
	                        <tr><td rowspan="6">제공 서비스</td><td>서버/컴퓨터 서비스</td><td>${specDescribeVo.iServerComputerSvc}</td></tr>
	                        <tr><td>스토리지 서비스</td><td>${specDescribeVo.iStrgeSvc}</td></tr>
	                        <tr><td>네트워크 서비스</td><td>${specDescribeVo.iNtwrkSvc}</td></tr>
	                        <tr><td>보안 서비스</td><td>${specDescribeVo.iScrtySvc}</td></tr>
	                        <tr><td>관리 서비스</td><td>${specDescribeVo.iManageSvc}</td></tr>
	                        <tr><td>기타 서비스</td><td>${specDescribeVo.iEtcSvc}</td></tr>
	                     </tbody>
	                </table>
	                </div>
	             </c:if>   
	             
				 <c:if test="${specDescribeVo.goodsKndCd eq 1001}">	                
	                <div class="goodsDescribePage">
	                <table class="tbl_st5" border="1" >
	                    <thead>
	                        <tr>
	                            <th style="width: 150px;">대항목</th>
	                            <th style="width: 200px;">세부항목</th>
	                            <th>입력</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <!-- <tr><td colspan="3">Paas</td></tr> -->
	                        <tr><td rowspan="2">Secure 개발</td><td>Secure 개발</td><td>${specDescribeVo.pSecureDevlop}</td></tr>
	                        <tr><td>Secure design, coding, testing 및 배포</td><td>${specDescribeVo.pSecureDctWdtb}</td></tr>
	                        <tr><td rowspan="5">아키텍처 계회 수립</td><td>지원 언어</td><td>${specDescribeVo.pSportLang}</td></tr>
	                        <tr><td>지원 플랫폼</td><td>${specDescribeVo.pSportPltfom}</td></tr>
	                        <tr><td>지원 Container 및 버전</td><td>${specDescribeVo.pSportContainerVer}</td></tr>
	                        <tr><td>지원 데이터 저장소</td><td>${specDescribeVo.pSportDataStorge}</td></tr>
	                        <tr><td>Sub-tenancy 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.pSubTenancySportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.pSubTenancySportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td rowspan="4">응용프로그램 개발</td><td>개발자 도구 정보</td><td>${specDescribeVo.pDvlprUntInfo}</td></tr>
	                        <tr><td>SDK/API 제공 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.pSdkApiSuplyAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.pSdkApiSuplyAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>테스트 및 디버깅 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.pTestDebugingSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.pTestDebugingSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>Add-on 서비스 및 마켓플레이스 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.pAddonSvcMarkplaceSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.pAddonSvcMarkplaceSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td rowspan="3">배포 및 운영환경</td><td>CISPORT(Continuous Integration) 지원</td><td>${specDescribeVo.pCisportSport}</td></tr>
	                        <tr><td>로깅/모니터링 지원</td><td>${specDescribeVo.pLogingMntrngSport}</td></tr>
	                        <tr><td>Load Balancing 지원</td><td>${specDescribeVo.pLoadBalancingSport}</td></tr>
	                     </tbody>
	                </table>
	                </div>
	             </c:if>
	                
				 <c:if test="${specDescribeVo.goodsKndCd eq 1002}">
	                <div class="goodsDescribePage">
	                <table class="tbl_st5" border="1" >
	                    <thead>
	                        <tr>
	                            <th style="width: 150px;">대항목</th>
	                            <th style="width: 200px;">세부항목</th>
	                            <th>입력</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <!-- <tr><td colspan="3">Saas</td></tr> -->
	                        <tr><td rowspan="2">서비스 제공 방식</td><td>사용자용 서비스 제공 방식</td><td>${specDescribeVo.sUserSvcSuplyMthd}</td></tr>
	                        <tr><td>관리용 서비스 제공 방식</td><td>${specDescribeVo.sManageSvcSuplyMthd}</td></tr>
	                        <tr><td rowspan="5">서비스 보안 관리</td><td>인프라 제공 방식</td><td>${specDescribeVo.sInfrstrctrSuplyMthd}</td></tr>
	                        <tr><td>보안 정책 </td><td>${specDescribeVo.sScrtyPolicy}</td></tr>
	                        <tr><td>데이터 암호화 여부 및 방식</td><td>${specDescribeVo.sDataEncptAtMthd}</td></tr>
	                        <tr><td>백업 및 복구 정책</td><td>${specDescribeVo.sBackupRecovryPolicy}</td></tr>
	                        <tr><td>사용자 인증 및 보안 보호 정책</td><td>${specDescribeVo.sUserCrtfcScrtyPrtcPolicy}</td></tr>
	                        <tr><td rowspan="4">다중 플랫폼<br />(cross platform)</td>
	                            <td>다중 플랫폼 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sMultiPltfomSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sMultiPltfomSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>지원 운영체계 목록</td><td>${specDescribeVo.sSportOpersysmList}</td></tr>
	                        <tr><td>지원 웹브라우저 목록</td><td>${specDescribeVo.sSportWbsrList}</td></tr>
	                        <tr><td>지원 모바일 플랫폼 목록</td><td>${specDescribeVo.sSportMobilePltfomList}</td></tr>
	                        <tr><td rowspan="4">혼환성 정보</td>
	                            <td>개방형 표준 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sOpenStdSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sOpenStdSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>정부 프레임워크 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sGvrnFrmwrkSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sGvrnFrmwrkSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>오픈소스 SW 호환 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sOpenSourcSwAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sOpenSourcSwAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>PaaS-Ta 호환 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sPaastaAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sPaastaAt eq 'N'}">No</c:if>
	                           </td>
	                        </tr>
	                        <tr><td rowspan="7">개발지원 정보</td>
	                            <td>소스 공개 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sSourcOthbcAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sSourcOthbcAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>외부 API ACCESS 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sApiAccessSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sApiAccessSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>DB 마이그레이션 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sDbMigrationSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sDbMigrationSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>외부 응용프로그램 통합 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sExtrlApplicationSportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sExtrlApplicationSportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>Sub-tenancy 지원 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sSubTenancySportAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sSubTenancySportAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>커스터마이징 가능 여부</td>
	                            <td>
	                                <c:if test="${specDescribeVo.sCstmzngPosblAt eq 'Y'}">Yes</c:if>
	                                <c:if test="${specDescribeVo.sCstmzngPosblAt eq 'N'}">No</c:if>
	                            </td>
	                        </tr>
	                        <tr><td>개발지원 조건 및 기타 사항</td><td>${specDescribeVo.sDevlopSportEtc}</td></tr>
	                     </tbody>
	                </table>
	                </div>
	            </c:if>
	                
	                
                <div class="btnArea rig">
                    <c:if test="${dataVo.goodsRegistSttus eq 1002 or dataVo.goodsRegistSttus eq 1009}">
                    <a href="javascript:"onClick="jsWaitingView()"  class="f_l btns st2 icn icnBck2">이전</a>
                    </c:if>
                    <c:if test="${dataVo.goodsRegistSttus eq 1007}">
                    <a href="javascript:"onClick="jsGoodsView()"  class="f_l btns st2 icn icnBck2">이전</a>
                    </c:if>
                    <c:if test="${dataVo.goodsRegistSttus eq 1001 || dataVo.goodsRegistSttus eq 1003 || dataVo.goodsRegistSttus eq 1008 || dataVo.goodsRegistSttus eq 1010}">    
                        <a href="javascript:" onClick="jsGoodsSpecAction()" class="f_l btns st1 icn icnXlx">규격서 다시 등록</a>
                    </c:if>
                </div>        
            </div>    
        </div>        
        
        
        
    </section>
    <!--// content -->            
</body>
</html>