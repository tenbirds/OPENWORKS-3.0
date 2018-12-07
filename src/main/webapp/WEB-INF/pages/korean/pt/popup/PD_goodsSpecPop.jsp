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
							<td>서비스개요</td>
							<td></td>
							<td>${specVo.goodsSpec1} </td>
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
							<td>VAT 포함여부</td>
							<td>${specVo.goodsSpec2} </td>
						</tr>
						<tr>
							<td>2.2</td>
							<td>최소계약기간</td>
							<td>${specVo.goodsSpec3} </td>
						</tr>
						<tr>
							<td>2.3</td>
							<td>평가판 사용여부</td>
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
							<td>가격 테이블</td>
							<td>${specVo.goodsSpec5} </td>
						</tr>
						<tr>
							<td>3.2</td>
							<td>기술평가표</td>
							<td>${specVo.goodsSpec6} </td>
						</tr>
						<tr>
							<td>3.3</td>
							<td>서비스 항목 정의</td>
							<td>${specVo.goodsSpec7} </td>
						</tr>
						<tr>
							<td>3.4</td>
							<td>기간 및 조건</td>
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
							<td>담당자</td>
							<td>${specVo.goodsSpec9} </td>
						</tr>
						<tr>
							<td>4.2</td>
							<td>전화번호</td>
							<td>${specVo.goodsSpec10} </td>
						</tr>
						<tr>
							<td>4.3</td>
							<td>e-mail</td>
							<td>${specVo.goodsSpec11} </td>
						</tr>
						<tr>
							<td>5</td>
							<td>서비스 특징</td>
							<td></td>
							<td>${specVo.goodsSpec12} </td>
						</tr>
						<tr>
							<td>6</td>
							<td>도입 기대효과</td>
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
							<td>지원 서비스 종류</td>
							<td>${specVo.goodsSpec14} </td>
						</tr>					
						<tr>
							<td>7.2</td>
							<td>제3의 제공자에 접근 지원</td>
							<td>${specVo.goodsSpec15} </td>
						</tr>					
						<tr>
							<td>7.3</td>
							<td>기술지원 시간<br />
								(시간/주간/옵션)
							</td>
							<td>${specVo.goodsSpec16} </td>
						</tr>					
						<tr>
							<td>7.4</td>
							<td>지원대기 시간</td>
							<td>${specVo.goodsSpec17} </td>
						</tr>					
						<tr>
							<td>7.5</td>
							<td>서비스의 단계적 확장</td>
							<td>${specVo.goodsSpec18} </td>
						</tr>					
						<tr>
							<td>8</td>
							<td>공개표준지원</td>
							<td>공개표준 지원 및 문서</td>
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
							<td>절차 포함</td>
							<td>${specVo.goodsSpec20}</td>
						</tr>					
						<tr>
							<td>9.2</td>
							<td>서비스 종료</td>
							<td>절차 포함</td>
							<td>${specVo.goodsSpec21}</td>
						</tr>					
						<tr>
							<td>10</td>
							<td>분석</td>
							<td>실시간 관리 정보 제공 </td>
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
							<td>탄력적 클라우드 지원</td>
							<td>${specVo.goodsSpec23}</td>
						</tr>					
						<tr>
							<td>11.2</td>
							<td>정의된 자원 보장</td>
							<td>${specVo.goodsSpec24}</td>
						</tr>					
						<tr>
							<td>11.3</td>
							<td>영구 저장소 지원</td>
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
							<td>셀프서비스 프로비저닝 지원</td>
							<td>${specVo.goodsSpec26}</td>
						</tr>					
						<tr>
							<td>12.2</td>
							<td>서비스 프로비저닝 시간</td>
							<td>${specVo.goodsSpec27}</td>
						</tr>					
						<tr>
							<td>12.3</td>
							<td>서비스 프로비저닝 해제 시간</td>
							<td>${specVo.goodsSpec28}</td>
						</tr>					
						<tr>
							<td>13</td>
							<td>오픈소스</td>
							<td>오픈소스 S/W 사용 및 지원</td>
							<td>${specVo.goodsSpec29}</td>
						</tr>					
						<tr>
							<td>14</td>
							<td>Code libraries</td>
							<td>Code libraries 작성 언어</td>
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
							<td>API 접근가능 여부 및 지원</td>
							<td>${specVo.goodsSpec31}</td>
						</tr>					
						<tr>
							<td>15.2</td>
							<td>API type</td>					
							<td>${specVo.goodsSpec32}</td>
						</tr>					
						<tr>
							<td>16</td>
							<td>네트워크와 연결</td>
							<td>서비스에 직접 연결하는 네트워크</td>
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
							<td>지원 웹브라우저 목록</td>
							<td>${specVo.goodsSpec34}</td>
						</tr>					
						<tr>
							<td>17.2</td>
							<td>오프라인작업및동기화지원여부</td>
							<td>${specVo.goodsSpec35}</td>
						</tr>					
						<tr>
							<td>17.3</td>
							<td>지원 장비 목록</td>
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
							<td>데이터 저장소 정보 및 인증정보</td>
							<td>${specVo.goodsSpec37}</td>
						</tr>					
						<tr>
							<td>18.2</td>
							<td>사용자가 저장소 위치 지정 가능여부</td>
							<td>${specVo.goodsSpec38}</td>
						</tr>					
						<tr>
							<td>18.3</td>
							<td>백업, 재해복구, 복구계획</td>
							<td>${specVo.goodsSpec39}</td>
						</tr>					
						<tr>
							<td>18.4</td>
							<td>데이터추출 및 삭제계획</td>
							<td>${specVo.goodsSpec40}</td>
						</tr>					
						<tr>
							<td>19</td>
							<td>데이터 전송 보호</td>
							<td>사용자 장비와 서비스간 데이터 보호 방식</td>
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
							<td>데이터센터 위치</td>
							<td>${specVo.goodsSpec42}</td>
						</tr>					
						<tr>
							<td>20.2</td>
							<td>데이터 관리 위치</td>
							<td>${specVo.goodsSpec43}</td>
						</tr>					
						<tr>
							<td>20.3</td>
							<td>데이터센터 보호</td>
							<td>${specVo.goodsSpec44}</td>
						</tr>					
						<tr>
							<td>20.4</td>
							<td>미사용 데이터 보호</td>
							<td>${specVo.goodsSpec45}</td>
						</tr>					
						<tr>
							<td>20.5</td>
							<td>안전한 데이터 삭제</td>
							<td>${specVo.goodsSpec46}</td>
						</tr>					
						<tr>
							<td>20.6</td>
							<td>서비스 가용성</td>
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
							<td>클라우드 배포 모델</td>
							<td>${specVo.goodsSpec48}</td>
						</tr>					
						<tr>
							<td>21.2</td>
							<td>소비자 유형</td>
							<td>${specVo.goodsSpec49}</td>
						</tr>					
						<tr>
							<td>21.3</td>
							<td>서비스 분리</td>
							<td>${specVo.goodsSpec50}</td>
						</tr>					
						<tr>
							<td>21.4</td>
							<td>서비스 관리 분리</td>
							<td>${specVo.goodsSpec51}</td>
						</tr>					
						<tr>
							<td>22</td>
							<td>구성 및 변경관리</td>
							<td>변경영향 평가</td>
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
							<td>사건 관리 절차</td>
							<td>${specVo.goodsSpec53}</td>
						</tr>					
						<tr>
							<td>23.2</td>
							<td>보안사건 고객 보고</td>
							<td>${specVo.goodsSpec54}</td>
						</tr>					
						<tr>
							<td>23.3</td>
							<td>보안사건 정의 공표</td>
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
							<td>취약점 평가</td>
							<td>${specVo.goodsSpec56}</td>
						</tr>					
						<tr>
							<td>24.2</td>
							<td>취약점 모니터링</td>
							<td>${specVo.goodsSpec57}</td>
						</tr>					
						<tr>
							<td>24.3</td>
							<td>취약점 완화 우선순위</td>
							<td>${specVo.goodsSpec58}</td>
						</tr>					
						<tr>
							<td>24.4</td>
							<td>취약점 추적</td>
							<td>${specVo.goodsSpec59}</td>
						</tr>
						<tr>
							<td>24.5</td>
							<td>취약점 완화 시간척도</td>
							<td>${specVo.goodsSpec60}</td>
						</tr>							
						<tr>
							<td>25</td>
							<td>이벤트 모니터링</td>
							<td>이벤트 모니터링</td>
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
							<td>Secure 개발</td>
							<td>${specVo.goodsSpec62}</td>
						</tr>					
						<tr>
							<td>26.2</td>
							<td>Secure design, coding, testing 및 배포</td>
							<td>${specVo.goodsSpec63}</td>
						</tr>					
						<tr>
							<td>26.3</td>
							<td>소프트웨어 구성 관리</td>
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
							<td>타 공급업체와의 데이터 공유</td>
							<td>${specVo.goodsSpec65}</td>
						</tr>					
						<tr>
							<td>27.2</td>
							<td>타 공급업체 보안 요구사항</td>
							<td>${specVo.goodsSpec66}</td>
						</tr>					
						<tr>
							<td>27.3</td>
							<td>타 공급업체의 위험 평가</td>
							<td>${specVo.goodsSpec67}</td>
						</tr>					
						<tr>
							<td>27.4</td>
							<td>타 공급업체 이행여부 모니터링</td>
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
							<td>사용자 인증 및 엑세스 관리</td>
							<td>${specVo.goodsSpec69}</td>
						</tr>					
						<tr>
							<td>28.2</td>
							<td>지원 채널을 통한 사용자 접근 관리*</td>
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
							<td>관리 인터페이스 사용자 접근 제어</td>
							<td>${specVo.goodsSpec71}</td>
						</tr>					
						<tr>
							<td>29.2</td>
							<td>관리자 권한</td>
							<td>${specVo.goodsSpec72}</td>
						</tr>					
						<tr>
							<td>30</td>
							<td>ID 및 인증</td>
							<td>ID 및 인증제어</td>
							<td>${specVo.goodsSpec73}</td>
						</tr>					
						<tr>
							<td>31</td>
							<td>보안서비스 관리</td>
							<td>서비스 관리 모델</td>
							<td>${specVo.goodsSpec74}</td>
						</tr>					
						<tr>
							<td>32</td>
							<td>사용자에게 감사정보 제공*</td>
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
							<td>디바이스 접근 방법</td>
							<td>${specVo.goodsSpec76}</td>
						</tr>					
						<tr>
							<td>33.2</td>
							<td>사용자 교육</td>
							<td>${specVo.goodsSpec77}</td>
						</tr>					
					</tbody>
				</table>			
	</div>
	
  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>	
 </body>
</html>