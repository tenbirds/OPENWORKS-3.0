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
	    location.href="/korean/pt/sale/goods/BD_goodsSpecForm.do?goodsCode=${specVo.goodsCode}";
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
				
				<table class="tbl_st4">
					<tr>
						<th>공급사</th>
						<td>${specVo.langStoreNm}</td>
						<th>조달등록번호</th>
						<td>${specVo.cntrNum}</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td>${specVo.bIZrNo}</td>
						<th>대표전화</th>
						<td>${specVo.cmpnyTelNo}</td>
					</tr>
					<tr>
						<th>담당자</th>
						<td>${specVo.goodsChargerNm}</td>
						<th>대표 이메일</th>
						<td>${specVo.cmpnyEmail}</td>
					</tr>
					<tr>
						<th>서비스명</th>
						<td>${specVo.goodsNm}</td>
						<th>마켓 등록일</th>
						<td><fmt:formatDate value="${specVo.registDt}" pattern="YYYY-MM-dd"/> </td>
					</tr>
					<tr>
						<th>서비스구분</th>
						<td>${specVo.indvdlzCdNm}</td>
						<th>서비스종류</th>
						<td>${specVo.langCtgryNm}</td>
					</tr>
				</table>				
			
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
							<td>1</td>
							<td class="requ">서비스개요</td>
							<td></td>
							<td>${specVo.goodsSpec1}</td>
						</tr>
						<tr>
							<td>2</td>
							<td>가격</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>2.1</td>
							<td rowspan="3"></td>
							<td class="requ">VAT 포함여부</td>
							<td>${specVo.goodsSpec2} </td>
						</tr>
						<tr>
							<td>2.2</td>
							<td class="requ">최소계약기간</td>
							<td>${specVo.goodsSpec3} </td>
						</tr>
						<tr>
							<td>2.3</td>
							<td class="requ">평가판 사용여부</td>
							<td>${specVo.goodsSpec4} </td>
						</tr>
						<tr>
							<td>3</td>
							<td>첨부문서</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>3.1</td>
							<td rowspan="4"></td>
							<td class="requ">가격 테이블</td>
							<td>${specVo.goodsSpec5} </td>
						</tr>
						<tr>
							<td>3.2</td>
							<td class="requ">기술평가표</td>
							<td>${specVo.goodsSpec6} </td>
						</tr>
						<tr>
							<td>3.3</td>
							<td class="requ">서비스 항목 정의</td>
							<td>${specVo.goodsSpec7} </td>
						</tr>
						<tr>
							<td>3.4</td>
							<td class="requ">기간 및 조건</td>
							<td>${specVo.goodsSpec8} </td>
						</tr>
						<tr>
							<td>4</td>
							<td>연락처</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>4.1</td>
							<td rowspan="3"></td>
							<td class="requ">담당자</td>
							<td>${specVo.goodsSpec9} </td>
						</tr>
						<tr>
							<td>4.2</td>
							<td class="requ">전화번호</td>
							<td>${specVo.goodsSpec10} </td>
						</tr>
						<tr>
							<td>4.3</td>
							<td>e-mail</td>
							<td>${specVo.goodsSpec11} </td>
						</tr>
						<tr>
							<td>5</td>
							<td class="requ">서비스 특징</td>
							<td></td>
							<td>${specVo.goodsSpec12} </td>
						</tr>
						<tr>
							<td>6</td>
							<td class="requ">도입 기대효과</td>
							<td></td>
							<td>${specVo.goodsSpec13} </td>
						</tr>					
						<tr>
							<td>7</td>
							<td>기술지원</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>7.1</td>
							<td rowspan="5"></td>
							<td class="requ">지원 서비스 종류</td>
							<td>${specVo.goodsSpec14} </td>
						</tr>					
						<tr>
							<td>7.2</td>
							<td class="requ">제3의 제공자에 접근 지원</td>
							<td>${specVo.goodsSpec15} </td>
						</tr>					
						<tr>
							<td>7.3</td>
							<td class="requ">기술지원 시간<br />
								(시간/주간/옵션)
							</td>
							<td>${specVo.goodsSpec16} </td>
						</tr>					
						<tr>
							<td>7.4</td>
							<td class="requ">지원대기 시간</td>
							<td>${specVo.goodsSpec17} </td>
						</tr>					
						<tr>
							<td>7.5</td>
							<td class="requ">서비스의 단계적 확장</td>
							<td>${specVo.goodsSpec18} </td>
						</tr>					
						<tr>
							<td>8</td>
							<td>공개표준지원</td>
							<td class="requ">공개표준 지원 및 문서</td>
							<td>${specVo.goodsSpec19} </td>
						</tr>					
						<tr>
							<td>9</td>
							<td>서비스 개시/종료절차</td>
							<td></td>
							<td> </td>
						</tr>					
						<tr>
							<td>9.1</td>
							<td>서비스 개시 </td>
							<td class="requ">절차 포함</td>
							<td>${specVo.goodsSpec20}</td>
						</tr>					
						<tr>
							<td>9.2</td>
							<td>서비스 종료</td>
							<td class="requ">절차 포함</td>
							<td>${specVo.goodsSpec21}</td>
						</tr>					
						<tr>
							<td>10</td>
							<td>분석</td>
							<td class="requ">실시간 관리 정보 제공 </td>
							<td>${specVo.goodsSpec22}</td>
						</tr>					
						<tr>
							<td>11</td>
							<td>클라우드 특성</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>11.1</td>
							<td rowspan="3"></td>
							<td class="requ">탄력적 클라우드 지원</td>
							<td>${specVo.goodsSpec23}</td>
						</tr>					
						<tr>
							<td>11.2</td>
							<td class="requ">정의된 자원 보장</td>
							<td>${specVo.goodsSpec24}</td>
						</tr>					
						<tr>
							<td>11.3</td>
							<td class="requ">영구 저장소 지원</td>
							<td>${specVo.goodsSpec25}</td>
						</tr>					
						<tr>
							<td>12</td>
							<td>프로비저닝</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>12.1</td>
							<td rowspan="3"></td>
							<td class="requ">셀프서비스 프로비저닝 지원</td>
							<td>${specVo.goodsSpec26}</td>
						</tr>					
						<tr>
							<td>12.2</td>
							<td class="requ">서비스 프로비저닝 시간</td>
							<td>${specVo.goodsSpec27}</td>
						</tr>					
						<tr>
							<td>12.3</td>
							<td class="requ">서비스 프로비저닝 해제 시간</td>
							<td>${specVo.goodsSpec28}</td>
						</tr>					
						<tr>
							<td>13</td>
							<td>오픈소스</td>
							<td class="requ">오픈소스 S/W 사용 및 지원</td>
							<td>${specVo.goodsSpec29}</td>
						</tr>					
						<tr>
							<td>14</td>
							<td>Code libraries</td>
							<td class="requ">Code libraries 작성 언어</td>
							<td>${specVo.goodsSpec30}</td>
						</tr>					
						<tr>
							<td>15</td>
							<td>API access</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>15.1</td>
							<td rowspan="2"></td>
							<td class="requ">API 접근가능 여부 및 지원</td>
							<td>${specVo.goodsSpec31}</td>
						</tr>					
						<tr>
							<td>15.2</td>
							<td class="requ">API type</td>					
							<td>${specVo.goodsSpec32}</td>
						</tr>					
						<tr>
							<td>16</td>
							<td>네트워크와 연결</td>
							<td  class="requ">서비스에 직접 연결하는 네트워크</td>
							<td>${specVo.goodsSpec33}</td>
						</tr>					
						<tr>
							<td>17</td>
							<td>접근지원</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>17.1</td>
							<td rowspan="3"></td>
							<td  class="requ">지원 웹브라우저 목록</td>
							<td>${specVo.goodsSpec34}</td>
						</tr>					
						<tr>
							<td>17.2</td>
							<td class="requ">오프라인작업및동기화지원여부</td>
							<td>${specVo.goodsSpec35}</td>
						</tr>					
						<tr>
							<td>17.3</td>
							<td class="requ">지원 장비 목록</td>
							<td>${specVo.goodsSpec36}</td>
						</tr>					
						<tr>
							<td>18</td>
							<td>데이터 저장소</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>18.1</td>
							<td rowspan="4"></td>
							<td class="requ">데이터 저장소 정보 및 인증정보</td>
							<td>${specVo.goodsSpec37}</td>
						</tr>					
						<tr>
							<td>18.2</td>
							<td class="requ">사용자가 저장소 위치 지정 가능여부</td>
							<td>${specVo.goodsSpec38}</td>
						</tr>					
						<tr>
							<td>18.3</td>
							<td class="requ">백업, 재해복구, 복구계획</td>
							<td>${specVo.goodsSpec39}</td>
						</tr>					
						<tr>
							<td>18.4</td>
							<td class="requ">데이터추출 및 삭제계획</td>
							<td>${specVo.goodsSpec40}</td>
						</tr>					
						<tr>
							<td>19</td>
							<td>데이터 전송 보호</td>
							<td class="requ">사용자 장비와 서비스간 데이터 보호 방식</td>
							<td>${specVo.goodsSpec41}</td>
						</tr>					
						<tr>
							<td>20</td>
							<td>자산보호 및 복구</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>20.1</td>
							<td rowspan="6"></td>
							<td class="requ">데이터센터 위치</td>
							<td>${specVo.goodsSpec42}</td>
						</tr>					
						<tr>
							<td>20.2</td>
							<td class="requ">데이터 관리 위치</td>
							<td>${specVo.goodsSpec43}</td>
						</tr>					
						<tr>
							<td>20.3</td>
							<td class="requ">데이터센터 보호</td>
							<td>${specVo.goodsSpec44}</td>
						</tr>					
						<tr>
							<td>20.4</td>
							<td class="requ">미사용 데이터 보호</td>
							<td>${specVo.goodsSpec45}</td>
						</tr>					
						<tr>
							<td>20.5</td>
							<td class="requ">안전한 데이터 삭제</td>
							<td>${specVo.goodsSpec46}</td>
						</tr>					
						<tr>
							<td>20.6</td>
							<td class="requ">서비스 가용성</td>
							<td>${specVo.goodsSpec47}</td>
						</tr>					
						<tr>
							<td>21</td>
							<td>분리정책</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>21.1</td>
							<td rowspan="4"></td>
							<td class="requ">클라우드 배포 모델</td>
							<td>${specVo.goodsSpec48}</td>
						</tr>					
						<tr>
							<td>21.2</td>
							<td class="requ">소비자 유형</td>
							<td>${specVo.goodsSpec49}</td>
						</tr>					
						<tr>
							<td>21.3</td>
							<td class="requ">서비스 분리</td>
							<td>${specVo.goodsSpec50}</td>
						</tr>					
						<tr>
							<td>21.4</td>
							<td class="requ">서비스 관리 분리</td>
							<td>${specVo.goodsSpec51}</td>
						</tr>					
						<tr>
							<td>22</td>
							<td>구성 및 변경관리</td>
							<td class="requ">변경영향 평가</td>
							<td>${specVo.goodsSpec52}</td>
						</tr>					
						<tr>
							<td>23</td>
							<td>사건 관리</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>23.1</td>
							<td rowspan="3"></td>
							<td class="requ">사건 관리 절차</td>
							<td>${specVo.goodsSpec53}</td>
						</tr>					
						<tr>
							<td>23.2</td>
							<td class="requ">보안사건 고객 보고</td>
							<td>${specVo.goodsSpec54}</td>
						</tr>					
						<tr>
							<td>23.3</td>
							<td class="requ">보안사건 정의 공표</td>
							<td>${specVo.goodsSpec55}</td>
						</tr>					
						<tr>
							<td>24</td>
							<td>취약점 관리</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>24.1</td>
							<td rowspan="5"></td>
							<td class="requ">취약점 평가</td>
							<td>${specVo.goodsSpec56}</td>
						</tr>					
						<tr>
							<td>24.2</td>
							<td class="requ">취약점 모니터링</td>
							<td>${specVo.goodsSpec57}</td>
						</tr>					
						<tr>
							<td>24.3</td>
							<td class="requ">취약점 완화 우선순위</td>
							<td>${specVo.goodsSpec58}</td>
						</tr>					
						<tr>
							<td>24.4</td>
							<td class="requ">취약점 추적</td>
							<td>${specVo.goodsSpec59}</td>
						</tr>
						<tr>
							<td>24.5</td>
							<td class="requ">취약점 완화 시간척도</td>
							<td>${specVo.goodsSpec60}</td>
						</tr>							
						<tr>
							<td>25</td>
							<td>이벤트 모니터링</td>
							<td class="requ">이벤트 모니터링</td>
							<td>${specVo.goodsSpec61}</td>
						</tr>					
						<tr>
							<td>26</td>
							<td>Secure 개발</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>26.1</td>
							<td rowspan="3"></td>
							<td class="requ">Secure 개발</td>
							<td>${specVo.goodsSpec62}</td>
						</tr>					
						<tr>
							<td>26.2</td>
							<td>Secure design, coding, testing 및 배포</td>
							<td>${specVo.goodsSpec63}</td>
						</tr>					
						<tr>
							<td>26.3</td>
							<td class="requ">소프트웨어 구성 관리</td>
							<td>${specVo.goodsSpec64}</td>
						</tr>					
						<tr>
							<td>27</td>
							<td>공급망 보안</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>27.1</td>
							<td rowspan="4"></td>
							<td class="requ">타 공급업체와의 데이터 공유</td>
							<td>${specVo.goodsSpec65}</td>
						</tr>					
						<tr>
							<td>27.2</td>
							<td class="requ">타 공급업체 보안 요구사항</td>
							<td>${specVo.goodsSpec66}</td>
						</tr>					
						<tr>
							<td>27.3</td>
							<td class="requ">타 공급업체의 위험 평가</td>
							<td>${specVo.goodsSpec67}</td>
						</tr>					
						<tr>
							<td>27.4</td>
							<td class="requ">타 공급업체 이행여부 모니터링</td>
							<td>${specVo.goodsSpec68}</td>
						</tr>					
						<tr>
							<td>28</td>
							<td>고객 인증</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>28.1</td>
							<td rowspan="2"></td>
							<td class="requ">사용자 인증 및 엑세스 관리</td>
							<td>${specVo.goodsSpec69}</td>
						</tr>					
						<tr>
							<td>28.2</td>
							<td>지원 채널을 통한 사용자 접근 관리</td>
							<td>${specVo.goodsSpec70}</td>
						</tr>					
						<tr>
							<td>29</td>
							<td>관리 인터페이스 분리 및 접근 제어</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>29.1</td>
							<td rowspan="2"></td>
							<td class="requ">관리 인터페이스 사용자 접근 제어</td>
							<td>${specVo.goodsSpec71}</td>
						</tr>					
						<tr>
							<td>29.2</td>
							<td class="requ">관리자 권한</td>
							<td>${specVo.goodsSpec72}</td>
						</tr>					
						<tr>
							<td>30</td>
							<td>ID 및 인증</td>
							<td class="requ">ID 및 인증제어</td>
							<td>${specVo.goodsSpec73}</td>
						</tr>					
						<tr>
							<td>31</td>
							<td>보안서비스 관리</td>
							<td class="requ">서비스 관리 모델</td>
							<td>${specVo.goodsSpec74}</td>
						</tr>					
						<tr>
							<td>32</td>
							<td>사용자에게 감사정보 제공</td>
							<td>감사정보 제공</td>
							<td>${specVo.goodsSpec75}</td>
						</tr>					
						<tr>
							<td>33</td>
							<td>사용자의 이용 안정성</td>
							<td></td>
							<td></td>
						</tr>					
						<tr>
							<td>33.1</td>
							<td rowspan="2"></td>
							<td class="requ">디바이스 접근 방법</td>
							<td>${specVo.goodsSpec76}</td>
						</tr>					
						<tr>
							<td>33.2</td>
							<td class="requ">사용자 교육</td>
							<td>${specVo.goodsSpec77}</td>
						</tr>					
					</tbody>
				</table>
				
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
		
		<c:set var="setCtgryCodes" value="${specVo.goodsSpec77}" />
		<!-- popup 유효성 검사 -->
		<article class="popup proSel">
	
			<h2>유효성 검사<a href="#">닫기</a></h2>
			<div>
				<p>
					유효성 검증 결과 아래의 컬럼(항목)에 문제가 있습니다.<br /> 
					엑셀 파일을 보완하여 다시 등록하세요.
				</p>
				
				<ul><c:set var="cnt" value="0" />
					<c:if test="${specVo.goodsSpec1 ==''}"><li>서비스개요 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec2 ==''}"><li>VAT 포함여부 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec3 ==''}"><li>최소계약기간</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec4 ==''}"><li>평가판 사용여부</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec5 ==''}"><li>가격 테이블</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec6 ==''}"><li>기술평가표</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec7 ==''}"><li>서비스 항목 정의</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec8 ==''}"><li>기간 및 조건</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec9 ==''}"><li>담당자 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec10 ==''}"><li>전화번호 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec11 ==''}"><li>e-mail</li>	<c:set var="cnt" value="${cnt+1}" /></c:if>		
					<c:if test="${specVo.goodsSpec12 ==''}"><li>서비스 특징</li>	<c:set var="cnt" value="${cnt+1}" /></c:if>									
					<c:if test="${specVo.goodsSpec13 ==''}"><li>도입 기대효과</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec14 ==''}"><li>지원 서비스 종류</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec15 ==''}"><li>제3의 제공자에 접근 지원 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec16 ==''}"><li>기술지원 시간 (시간/주간/옵션)</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec17 ==''}"><li><li>지원대기 시간</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec18 ==''}"><li>서비스의 단계적 확장</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec19 ==''}"><li>공개표준 지원 및 문서</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec20 ==''}"><li>서비스 개시 절차 포함 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec21 ==''}"><li>서비스 종료  절차 포함</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec22 ==''}"><li>실시간 관리 정보 제공</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec23 ==''}"><li>탄력적 클라우드 지원</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec24 ==''}"><li>정의된 자원 보장</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec25 ==''}"><li>영구 저장소 지원</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec26 ==''}"><li>셀프서비스 프로비저닝 지원</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec27==''}"><li>서비스 프로비저닝 시간</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec28==''}"><li>서비스 프로비저닝 해제 시간</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec29==''}"><li>오픈소스 S/W 사용 및 지원</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec30==''}"><li>Code libraries 작성 언어</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec31==''}"><li>API 접근가능 여부 및 지원</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec32==''}"><li>API type</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec33==''}"><li>서비스에 직접 연결하는 네트워크</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec34==''}"><li>지원 웹브라우저 목록</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec35==''}"><li>오프라인작업및동기화지원여부</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec36==''}"><li>지원 장비 목록</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec37==''}"><li>데이터 저장소 정보 및 인증정보</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec38==''}"><li>사용자가 저장소 위치 지정 가능여부 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec39==''}"><li>백업, 재해복구, 복구계획</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec40==''}"><li>데이터추출 및 삭제계획 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec41==''}"><li>사용자 장비와 서비스간 데이터 보호 방식</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec42==''}"><li>데이터센터 위치</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec43==''}"><li>데이터 관리 위치</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec44==''}"><li>데이터센터 보호</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec45==''}"><li>미사용 데이터 보호 </li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec46==''}"><li>안전한 데이터 삭제</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec47==''}"><li>서비스 가용성</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec48==''}"><li>클라우드 배포 모델</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec49==''}"><li>소비자 유형</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec50==''}"><li>서비스 분리</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec51==''}"><li>서비스 관리 분리</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec52==''}"><li>변경영향 평가</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec53==''}"><li>사건 관리 절차</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec54==''}"><li>보안사건 고객 보고</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec55==''}"><li>보안사건 정의 공표</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec56==''}"><li>취약점 평가</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec57==''}"><li>취약점 모니터링</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec58==''}"><li>취약점 완화 우선순위</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec59==''}"><li>취약점 추적</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec60==''}"><li>취약점 완화 시간척도</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec61==''}"><li>이벤트 모니터링</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec62==''}"><li>Secure 개발</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec63==''}"><li>Secure design, coding, testing 및 배포</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec64==''}"><li>소프트웨어 구성 관리</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec65==''}"><li>타 공급업체와의 데이터 공유</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec66==''}"><li>타 공급업체 보안 요구사항</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec67==''}"><li>타 공급업체의 위험 평가</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec68==''}"><li>타 공급업체 이행여부 모니터링</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec69==''}"><li>사용자 인증 및 엑세스 관리</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec71==''}"><li>관리 인터페이스 사용자 접근 제어</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec72==''}"><li>관리자 권한</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec73==''}"><li>ID 및 인증제어</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec74==''}"><li>서비스 관리 모델</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec76==''}"><li>디바이스 접근 방법</li><c:set var="cnt" value="${cnt+1}" /></c:if>
					<c:if test="${specVo.goodsSpec77==''}"><li>사용자 교육</li><c:set var="cnt" value="${cnt+1}" /></c:if>
				</ul>
		
				<div class="btnArea">
					<a href="#" class="btns st1 alert">확인</a>
				</div>				
			</div>
		</article>
		<!--// popup 유효성 검사 -->
		<script>
		<c:if test="${cnt > 0}"> 
			$(".proSel").addClass("on");
		    $("#regReq").attr("onclick", "alert('등록된 서비스 규격서 정보에 누락된 항목이 있습니다. 확인 바랍니다. ');");
		 </c:if>
		</script>
	</section>
	<!--// content -->			
</body>
</html>