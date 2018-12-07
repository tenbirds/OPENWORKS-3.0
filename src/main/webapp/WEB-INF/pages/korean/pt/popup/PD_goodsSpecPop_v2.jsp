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
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
  <style type="text/css">
  	div {position:relative;}
  </style>
  <script type="text/javascript">
    // 닫기
    var jsClose = function(){
        parent.$.fn.colorbox.close();
    };
    
      var reportAction = function(){
    	  window.print();
/* <!--    	  
        var open = "http://korean.ceart.kr/report/reporting.jsp?reportSection=3001&goodsCode=${specVo.goodsCode}";
        window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
--> */
    };
    
    var initBody;
    function befrPrint() {
    	initBOdy = document.body.innerHTML;
    	document.body.innerHTML = idPrint.innerHTML;
    }
    
    function afterPrint() {
    	document.body.innerHTML = initBody;
    }
    
    window.onbeforprint = beforPrint;
    window.onafterprint = afterPrint;
    
  </script>
  
 </head>

 <body class="winPopup view_spec">
    <h2>서비스 규격서  <a href="#"  onclick="jsClose();">닫기</a></h2>
    <div class="btnArea rig">
        <a href="#" class="btns st1" onClick="reportAction();">레포트 출력</a>
        <!-- <a href="#"><img src="/cloud_ver2/new_cloud/images/icn_print.png" alt="프린트" /></a> -->
    </div>
  
    <div class="book" id="idPrint">
    	<!-- <div class="page"> -->
        <h3>직접 등록 정보</h3>
        <table class="tbl_st5">
            <thead>
                <tr>
                    <th>No</th>
                    <th>대항목</th>
                    <th>세부항목</th>
                    <th>내용</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan="6" align="center">1</td>
                    <td rowspan="6">회사 개요</td>
                    <td>회사명칭</td>
                    <td>${specVo.langStoreNm} </td>
                </tr>
                <tr>
                    <td>회사 설립년도</td>
                    <td>
                    	<c:if test="${ empty specVo.cmpnyFondYear}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.cmpnyFondYear}">
							${specVo.cmpnyFondYear} 년
						</c:if>                    	
                    </td>
                </tr>
                <tr>
                    <td>기업 구분</td>
                    <td>${specVo.entrprsSeNm} </td>
                </tr>
                <tr>
                    <td>회사 소개</td>
                    <td>
                    	<c:if test="${ empty specVo.cmpnyIntrcn}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.cmpnyIntrcn}">
							${specVo.cmpnyIntrcn}
						</c:if>                    	
                    
                     </td>
                </tr>
                <tr>
                    <td>사업 분야</td>
                    <td>
                    	<c:if test="${ empty specVo.bsnsRealm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.bsnsRealm}">
							${specVo.bsnsRealm}
						</c:if>                      	 
                    </td>
                </tr>
                <tr>
                    <td>주요 레퍼런스</td>
                    <td>
                    	<c:if test="${ empty specVo.mainRefer}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.mainRefer}">
							${specVo.mainRefer}
						</c:if>                       
                    </td>
                </tr>
                
                <tr>
                    <td rowspan="19" align="center">2</td>
                    <td rowspan="19">서비스 개요</td>
                    <td>서비스명칭</td>
                    <td>
                    	<c:if test="${ empty specVo.svcNm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcNm}">
							${specVo.svcNm}
						</c:if>                       
					</td>
                </tr>
                <tr>
                    <td>특장점</td>
                    <td>
                    	<c:if test="${ empty specVo.svcDfnSfe}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcDfnSfe}">
							${specVo.svcDfnSfe}
						</c:if>                       
                    </td>
                </tr>
                <tr>
                    <td>서비스 기대효과</td>
                    <td>
                    	<c:if test="${ empty specVo.svcExpcEffect}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcExpcEffect}">
							${specVo.svcExpcEffect}
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 유형</td>
                    <td>
                    	<c:if test="${ empty specVo.svcTyNm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcTyNm}">
							${specVo.svcTyNm}
						</c:if>                      	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 제공 기업의 공급 유형</td>
                    <td>
                    	<c:if test="${ empty specVo.svcEntrprsSuplyTyNm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcEntrprsSuplyTyNm}">
							${specVo.svcEntrprsSuplyTyNm}
						</c:if>                      	 
                    	 
                    </td>
                </tr>
                <tr>
                    <td>과금 기준(최소) </td>
                    <td>
                    	<c:if test="${ empty specVo.dueStdrMummNm}">
                    	 해당없음
                    	</c:if> 
											<c:if test="${not empty specVo.dueStdrMummNm}">
												${specVo.dueStdrMummNm}
											</c:if>
                    </td>
                </tr>
                <tr>
                    <td>서비스 가격</td>
                    <td>
                    	<c:if test="${ empty specVo.svcPc or specVo.svcPc eq 0}">
                    	 해당없음
                    	</c:if> 
											<c:if test="${not empty specVo.svcPc and specVo.svcPc > 0}">
												<fmt:formatNumber value="${specVo.svcPc}" groupingUsed="true"/>
											</c:if>  
                    </td>
                </tr>
                <tr>
                    <td>서비스 가격 VAT포함여부</td>
                    <td>${specVo.svcPcVat} </td>
                </tr>
                <tr>
                    <td>서비스 가격 통화단위</td>
                    <td>
                    	<c:if test="${ empty specVo.svcPcUntCdNm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcPcUntCdNm}">
							${specVo.svcPcUntCdNm}
						</c:if>                        	
                    </td>                    
                </tr>
                <tr>
                    <td>최소 계약기간</td>
                    <td>
                    	<c:if test="${ empty specVo.mummCntrctpd}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.mummCntrctpd}">
							${specVo.mummCntrctpd}
						</c:if>                       	 
                    </td>
                </tr>
                <tr>
                    <td>가격테이블 첨부 여부</td>
                    <td>${specVo.pcTableAtchAt} </td>
                </tr>
<%--                 
                <tr>
                    <td>VAT포함여부 </td>
                    <td>${specVo.vatInclsAt} </td>
                </tr>
--%>               
                <tr>
                    <td>서비스 시작 절차</td>
                    <td>
                    	<c:if test="${ empty specVo.svcBeginProcss}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcBeginProcss}">
							${specVo.svcBeginProcss}
						</c:if>                     	
                     </td>
                </tr>
                <tr>
                    <td>서비스 종료 절차</td>
                    <td>
                    	<c:if test="${ empty specVo.svcEndProcss}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcEndProcss}">
							${specVo.svcEndProcss}
						</c:if>                     	
                    	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 평가판 제공여부</td>
                    <td>${specVo.atSvcEvl} </td>
                </tr>
                <tr>
                    <td>서비스 평가판 제공 기간</td>
                    <td>
                    	<c:if test="${ empty specVo.svcEvlSuplyPd}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcEvlSuplyPd}">
							${specVo.svcEvlSuplyPd}
						</c:if>                      	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 담당자 이름</td>
                    <td>
                    	<c:if test="${ empty specVo.svcChargerNm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcChargerNm}">
							${specVo.svcChargerNm}
						</c:if>       
                     </td>
                </tr>
                <tr>
                    <td>서비스 담당자 전화번호</td>
                    <td>
                    	<c:if test="${ empty specVo.svcChargerTelno}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcChargerTelno}">
							${specVo.svcChargerTelno}
						</c:if>       
                    	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 담당자 이메일</td>
                    <td>
                    	<c:if test="${ empty specVo.svcChargerEmail}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcChargerEmail}">
							${specVo.svcChargerEmail}
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>나라장터종합쇼핑몰 등록 여부</td>
                    <td>${specVo.gnrlzSopmalRegistAt} </td>
                </tr>
                
                <tr>
                    <td rowspan="13" align="center">3</td>
                    <td rowspan="13">서비스 기술정보</td>
                    <td>Private cloud 구축 여부</td>
                    <td>${specVo.privateCloudAt} </td>
                </tr>
                <tr>
                    <td>Public cloud 구축 여부</td>
                    <td>${specVo.publicCloudAt} </td>
                </tr>
                <tr>
                    <td>Hybrid cloud 구축 여부</td>
                    <td>${specVo.hybridCloudAt} </td>
                </tr>
                <tr>
                    <td>클라우드 보안 인증(CSAP) 여부</td>
                    <td>
                    	<c:if test="${ empty specVo.kisaCrtfcAt}">
                    	 NO
                    	</c:if> 
						<c:if test="${not empty specVo.kisaCrtfcAt}">
						YES
						</c:if>                    
                    </td>
                </tr>
                <tr>
                    <td>클라우드서비스 품질성능 확인여부</td>
                    <td>
                    	<c:if test="${ empty specVo.cloudSvcQlityCrtfcAt}">
                    	 NO
                    	</c:if> 
						<c:if test="${not empty specVo.cloudSvcQlityCrtfcAt}">
						YES
						</c:if>                     	 
                    </td>
                </tr>
                <!-- tr>
                    <td>클라우드 서비스 확인제 여부</td>
                    <td>${specVo.cloudSvcCnfirmAt} </td>
                </tr -->
                <tr>
                    <td>CC 인증 여부</td>
                    <td>
                    	<c:if test="${ empty specVo.ccCrtfcAt}">
							NO
                    	</c:if> 
						<c:if test="${not empty specVo.ccCrtfcAt}">
							YES
						</c:if>                     	 
                    </td>
                </tr>
                <!-- tr>
                    <td>GS 인증 여부</td>
                    <td>${specVo.gsCrtfcAt} </td>
                </tr -->
                <tr>
                    <td>SLA 적용 여부</td>
                    <td>${specVo.slaApplcAt} </td>
                </tr>
                <tr>
                    <td>서비스 가용성</td>
                    <td>
                    	<c:if test="${ empty specVo.svcUseful}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcUseful}">
							${specVo.svcUseful} %
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>자동 확장 지원 여부</td>
                    <td>${specVo.atmcEstnSportAt} </td>
                </tr>
                <tr>
                    <td>클러스터링 지원 여부</td>
                    <td>${specVo.clusteringSportAt} </td>
                </tr>
                <tr>
                    <td>셀프서비스 프로비저닝 지원 여부</td>
                    <td>${specVo.sfsrvProvisioningSportAt} </td>
                </tr>
                <tr>
                    <td>서비스 프로비저닝 시간</td>
                    <td>
                    	<c:if test="${ empty specVo.svcProvisioningTime}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcProvisioningTime}">
							${specVo.svcProvisioningTime} 분
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 프로비저닝 해제 시간</td>
                    <td>
                    	<c:if test="${ empty specVo.svcProvisioningRelisTime}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcProvisioningRelisTime}">
							${specVo.svcProvisioningRelisTime} 분
						</c:if>                      	 
                    </td>
                </tr>
                
                <tr>
                    <td rowspan="11" align="center">4</td>
                    <td rowspan="11">서비스 및 데이터 관리 정보</td>
                    <td>데이터센터 국내, 외 위치 정보</td>
                    <td>
                    	<c:if test="${ empty specVo.dataCnterLcInfoNm}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.dataCnterLcInfoNm}">
							${specVo.dataCnterLcInfoNm} 
						</c:if>                     	
                     </td>
                </tr>
                <tr>
                    <td>데이터센터 위치 정보</td>
                    <td>
                    	<c:if test="${ empty specVo.dataCnterHbrdLcInfo}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.dataCnterHbrdLcInfo}">
							${specVo.dataCnterHbrdLcInfo} 
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>재해복구계획</td>
                    <td>
                    	<c:if test="${ empty specVo.dsstrrecovryPlan}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.dsstrrecovryPlan}">
							${specVo.dsstrrecovryPlan} 
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>데이터 추출 절차</td>
                    <td>
                    	<c:if test="${ empty specVo.dataExtrcProcss}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.dataExtrcProcss}">
							${specVo.dataExtrcProcss} 
						</c:if>                     	 
                    </td>
                </tr>
                <tr>
                    <td>미사용 데이터 보호 정책</td>
                    <td>
                    	<c:if test="${ empty specVo.unuseDataPrtcPolicy}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.unuseDataPrtcPolicy}">
							${specVo.unuseDataPrtcPolicy} 
						</c:if>                     	 
                    	 
                    </td>
                </tr>
                <tr>
                    <td>안전한 데이터 삭제 정책</td>
                    <td>
                    	<c:if test="${ empty specVo.safeDataDeletePolicy}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.safeDataDeletePolicy}">
							${specVo.safeDataDeletePolicy} 
						</c:if>                      	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 관리 및 현황 정보 제공</td>
                    <td>
                    	<c:if test="${ empty specVo.svcManageSttusInfoSuply}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.svcManageSttusInfoSuply}">
							${specVo.svcManageSttusInfoSuply} 
						</c:if>                       	 
                    </td>
                </tr>
                <tr>
                    <td>서비스 이용 로그 제공 여부</td>
                    <td>${specVo.svcUseLogSuplyAt} </td>
                </tr>
                <tr>
                    <td>장애관리 및 보고 정책</td>
                    <td>
                    	<c:if test="${ empty specVo.troblManageReprtPolicy}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.troblManageReprtPolicy}">
							${specVo.troblManageReprtPolicy} 
						</c:if>                        	 
                    </td>
                </tr>
                <tr>
                    <td>API 지원 여부</td>
                    <td>${specVo.apiSportAt} </td>
                </tr>
                <tr>
                    <td>API 지원 타입</td>
                    <td>
                    	<c:if test="${ empty specVo.apiSportTy}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.apiSportTy}">
							${specVo.apiSportTy} 
						</c:if>                      	 
                    </td>
                </tr>
                
                <tr>
                    <td rowspan="8" align="center">5</td>
                    <td rowspan="8">서비스 지원 정보</td>
                    <td>사용자 매뉴얼 제공 여부</td>
                    <td>${specVo.userMnlSuplyAt} </td>
                </tr>
                <!-- tr>
                    <td>사용자 매뉴얼 정보 유무</td>
                    <td>${specVo.userMnlInfoAt} </td>
                </tr>
                <tr>
                    <td>사용자 매뉴얼 정보 입력</td>
                    <td>
                    	<c:if test="${ empty specVo.userMnlInfoInput}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.userMnlInfoInput}">
							${specVo.userMnlInfoInput} 
						</c:if>                     	 
                    </td>
                </tr -->
                <tr>
                    <td>사용자 교육 지원 여부</td>
                    <td>${specVo.userEdcSportAt} </td>
                </tr>
                <tr>
                    <td>사용자 교육 지원 입력</td>
                    <td>
                    	<c:if test="${ empty specVo.userEdcSportInput}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.userEdcSportInput}">
							${specVo.userEdcSportInput} 
						</c:if>                     	 
                    	 
                    </td>
                </tr>
                <!-- tr>
                    <td>사용자 교육 정보</td>
                    <td>
                    	<c:if test="${ empty specVo.userEdcInfo}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.userEdcInfo}">
							${specVo.userEdcInfo} 
						</c:if>                    	 
                    </td>
                </tr -->
                <tr>
                    <td>방문 교육 지원 여부</td>
                    <td>${specVo.visitEdcSportAt} </td>
                </tr>
                <tr>
                    <td>방문 기술 지원 여부</td>
                    <td>${specVo.visitTchnlgySportAt} </td>
                </tr>
                <tr>
                    <td>방문 외(온라인, 이메일, 전화 등) 기술 지원 여부</td>
                    <td>${specVo.visitElseTchnlgySportAt} </td>
                </tr>
                <tr>
                    <td>고객센터 운영 여부</td>
                    <td>${specVo.cstmrCnterOperAt} </td>
                </tr>
                <tr>
                    <td>고객센터 운영 시간</td>
                    <td>
                    	<c:if test="${ empty specVo.cstmrCnterOperTime}">
                    	 해당없음
                    	</c:if> 
						<c:if test="${not empty specVo.cstmrCnterOperTime}">
							${specVo.cstmrCnterOperTime} 
						</c:if>                    	 
                    	 
                    </td>
                </tr>

            </tbody>
        </table>            
    
    
        <c:if test="${specVo.goodsKndCd eq 1003}">

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
	                    <td rowspan="11" align="center">IaaS</td>
	                    <td>공개표준 지원 및 문서</td>
	                    <td>
                    		<c:if test="${ empty specVo.iOthbcStdSportDoc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iOthbcStdSportDoc}">
								${specVo.iOthbcStdSportDoc} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>서비스에 직접 연결하는 네트워크</td>
	                    <td>
                    		<c:if test="${ empty specVo.iSvcDirectCnncNtwrk}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iSvcDirectCnncNtwrk}">
								${specVo.iSvcDirectCnncNtwrk} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>가상 네트워크 지원</td>
	                    <td>
                    		<c:if test="${ empty specVo.iVirtlNtwrkSport}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iVirtlNtwrkSport}">
								${specVo.iVirtlNtwrkSport} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>동기화 지원 여부</td>
	                    <td>${specVo.iSynchrnSportAt} </td>
	                </tr>
	                <tr>
	                    <td>지원 장비 목록</td>
	                    <td>
                    		<c:if test="${ empty specVo.iSportEqpmnList}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iSportEqpmnList}">
								${specVo.iSportEqpmnList} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>서버/컴퓨터 서비스</td>
	                    <td>
                    		<c:if test="${ empty specVo.iServerComputerSvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iServerComputerSvc}">
								${specVo.iServerComputerSvc} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>스토리지 서비스</td>
	                    <td>
                    		<c:if test="${ empty specVo.iStrgeSvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iStrgeSvc}">
								${specVo.iStrgeSvc} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>네트워크 서비스</td>
	                    <td>
                    		<c:if test="${ empty specVo.iNtwrkSvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iNtwrkSvc}">
								${specVo.iNtwrkSvc} 
							</c:if> 		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>보안 서비스</td>
	                    <td>
                    		<c:if test="${ empty specVo.iScrtySvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iScrtySvc}">
								${specVo.iScrtySvc} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>관리 서비스</td>
	                    <td>
                    		<c:if test="${ empty specVo.iManageSvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iManageSvc}">
								${specVo.iManageSvc} 
							</c:if> 		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>기타 서비스</td>
	                    <td>
                    		<c:if test="${ empty specVo.iEtcSvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.iEtcSvc}">
								${specVo.iEtcSvc} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	                    
    	</c:if>
    	
    	<c:if test="${specVo.goodsKndCd eq 1001}">

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
	                    <td rowspan="14" align="center">PaaS</td>
	                    <td>Secure 개발</td>
	                    <td>
                    		<c:if test="${ empty specVo.pSecureDevlop}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pSecureDevlop}">
								${specVo.pSecureDevlop} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>Secure design, coding, testing 및 배포</td>
	                    <td>
                    		<c:if test="${ empty specVo.pSecureDctWdtb}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pSecureDctWdtb}">
								${specVo.pSecureDctWdtb} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>지원 언어</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pSportLang}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pSportLang}">
								${specVo.pSportLang} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>지원 플랫폼</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pSportPltfom}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pSportPltfom}">
								${specVo.pSportPltfom} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>지원 Container 및 버전</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pSportContainerVer}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pSportContainerVer}">
								${specVo.pSportContainerVer} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>지원 데이터 저장소</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pSportDataStorge}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pSportDataStorge}">
								${specVo.pSportDataStorge} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>Sub-tenancy 지원 여부</td>
	                    <td>${specVo.pSubTenancySportAt} </td>
	                </tr>
	                <tr>
	                    <td>개발자 도구 정보</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pDvlprUntInfo}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pDvlprUntInfo}">
								${specVo.pDvlprUntInfo} 
							</c:if> 	                    	 
	                    </td>
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
	                    <td>CISPORT(Continuous Integration) 지원</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pCisportSport}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pCisportSport}">
								${specVo.pCisportSport} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>로깅/모니터링 지원</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pLogingMntrngSport}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pLogingMntrngSport}">
								${specVo.pLogingMntrngSport} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>Load Balancing 지원</td>
	                    <td>
	                   		<c:if test="${ empty specVo.pLoadBalancingSport}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.pLoadBalancingSport}">
								${specVo.pLoadBalancingSport} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	            </tbody>
	        </table>            
		</c:if>
		
		
		<c:if test="${specVo.goodsKndCd eq 1002}">

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
	                    <td rowspan="22" align="center">SaaS</td>
	                    <td>사용자용 서비스 제공 방식</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sUserSvcSuplyMthd}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sUserSvcSuplyMthd}">
								${specVo.sUserSvcSuplyMthd} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>관리용 서비스 제공 방식</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sManageSvcSuplyMthd}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sManageSvcSuplyMthd}">
								${specVo.sManageSvcSuplyMthd} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>인프라 제공 방식</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sInfrstrctrSuplyMthd}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sInfrstrctrSuplyMthd}">
								${specVo.sInfrstrctrSuplyMthd} 
							</c:if> 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>보안 정책</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sScrtyPolicy}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sScrtyPolicy}">
								${specVo.sScrtyPolicy} 
							</c:if> 	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>데이터 암호화 여부 및 방식</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sDataEncptAtMthd}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sDataEncptAtMthd}">
								${specVo.sDataEncptAtMthd} 
							</c:if>	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>백업 및 복구 정책</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sBackupRecovryPolicy}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sBackupRecovryPolicy}">
								${specVo.sBackupRecovryPolicy} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>사용자 인증 및 보안 보호 정책</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sUserCrtfcScrtyPrtcPolicy}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sUserCrtfcScrtyPrtcPolicy}">
								${specVo.sUserCrtfcScrtyPrtcPolicy} 
							</c:if>	 	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>다중 플랫폼 지원 여부</td>
	                    <td>${specVo.sMultiPltfomSportAt} </td>
	                </tr>
	                <tr>
	                    <td>지원 운영체계 목록</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sSportOpersysmList}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sSportOpersysmList}">
								${specVo.sSportOpersysmList} 
							</c:if>	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>지원 웹브라우저 목록</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sSportWbsrList}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sSportWbsrList}">
								${specVo.sSportWbsrList} 
							</c:if>	                    	 

	                    </td>
	                </tr>
	                <tr>
	                    <td>지원 모바일 플랫폼 목록</td>
	                    <td>
	                   		<c:if test="${ empty specVo.sSportMobilePltfomList}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sSportMobilePltfomList}">
								${specVo.sSportMobilePltfomList} 
							</c:if>	  	                    	 
	                    </td>
	                </tr>
	                <tr>
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
	                    <td>
	                   		<c:if test="${ empty specVo.sDevlopSportEtc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.sDevlopSportEtc}">
								${specVo.sDevlopSportEtc} 
							</c:if>	  	                    	 
	                    	 
	                    </td>
	                </tr>
	            </tbody>
	        </table> 
	    </c:if>               
    
    
    	<c:if test="${specVo.goodsKndCd eq 1004}">

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
	                    <td>
	                   		<c:if test="${ empty specVo.cSpcltyRealm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cSpcltyRealm}">
								${specVo.cSpcltyRealm} 
							</c:if>		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>도입전반</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cIndcWhole}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cIndcWhole}">
								${specVo.cIndcWhole} 
							</c:if>		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>Setup &amp; Migration</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cSetupMgr}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cSetupMgr}">
								${specVo.cSetupMgr} 
							</c:if>		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>보유자격 </td>
	                    <td>
	                   		<c:if test="${ empty specVo.cHoldQualf}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cHoldQualf}">
								${specVo.cHoldQualf} 
							</c:if>	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>보유기술</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cHoldTchnlgy}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cHoldTchnlgy}">
								${specVo.cHoldTchnlgy} 
							</c:if>	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅가능 인프라</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cInfrstrctrNm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cInfrstrctrNm}">
								${specVo.cInfrstrctrNm} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅가능 인프라 기타</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cInfrstrctrEtc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cInfrstrctrEtc}">
								${specVo.cInfrstrctrEtc} 
							</c:if>		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅가능 플랫폼</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cPltfomNm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cPltfomNm}">
								${specVo.cPltfomNm} 
							</c:if>		                    	 
	                    	 
	                   	</td>
	                </tr>
	                <tr>
	                    <td>컨설팅가능 플랫폼 기타</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cPltfomEtc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cPltfomEtc}">
								${specVo.cPltfomEtc} 
							</c:if>	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>프로젝트 경험</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cPrjctExprnc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cPrjctExprnc}">
								${specVo.cPrjctExprnc} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅 영역</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cCnslRelmNm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cCnslRelmNm}">
								${specVo.cCnslRelmNm} 
							</c:if>		                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅 영역 기타</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cCnslRelmEtc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cCnslRelmEtc}">
								${specVo.cCnslRelmEtc} 
							</c:if>		                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅 범위</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cCnslScopeNm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cCnslScopeNm}">
								${specVo.cCnslScopeNm} 
							</c:if>	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅 가능 상세 서비스</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cDetailSvc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cDetailSvc}">
								${specVo.cDetailSvc} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>수행기간</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cExcPdNm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cExcPdNm}">
								${specVo.cExcPdNm} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>수행기간 기타</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cExcPdEtc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cExcPdEtc}">
								${specVo.cExcPdEtc} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>수행가능지역</td>
	                    <td>
	                   		<c:if test="${ empty specVo.cExcAreaNm}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cExcAreaNm}">
								${specVo.cExcAreaNm} 
							</c:if>	                    	 
	                    	 
	                    </td>
	                </tr>
	                <tr>
	                    <td>사전컨설팅 가능 여부</td>
	                    <td>
	                    	${specVo.cBeffatCnslAt}
	                    </td>
	                </tr>
	                <tr>
	                    <td>컨설팅 가격 </td>
	                    <td>
	                   		<c:if test="${ empty specVo.cCnslPc}">
                    	 		해당없음
                    		</c:if> 
							<c:if test="${not empty specVo.cCnslPc}">
								${specVo.cCnslPc} 
							</c:if>		                    	 
	                    </td>
	                </tr>
	                
	            </tbody>
	        </table>            
    	</c:if>
<!-- 
    	</div>
 -->
    </div>
 
  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>    
 </body>
</html>