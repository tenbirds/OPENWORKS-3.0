<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

		<table width="5930" border="0" cellspacing="0" cellpadding="0" class="tableStyle">
			<caption class="hidden">수요조사</caption>
			<colgroup>
				<col width="80px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
				<col width="150px;" >
			</colgroup>
			<thead>
				<tr>
					<th rowspan="4">①순번</th>
					<th rowspan="4">②상위기관명</th>
					<th rowspan="4">③기관명</th>
					<th rowspan="4">④시스템명</th>
					<th rowspan="4">⑤시스템목적</th>
					<th rowspan="4">⑥시스템구분<br />
						(기존/신규)</th>
					<th rowspan="4">⑦담당자</th>
					<th rowspan="4">⑧이메일</th>
					<th rowspan="4">⑨연락처</th>
					<th colspan="8">시스템	구축 운영 내역</th>
					<th colspan="4">민간 클라우드 전환 제외대상</th>
					<th colspan="10">정보자원등급	평가</th>
					<th colspan="9">클라우드	전환 검토</th>
				</tr>
				<tr>
					<th rowspan="3">⑩구축년도<br />
						(YYYY)</th>
					<th rowspan="3">⑪최근<br />
						업그레이드년도<br />
						(YYYY)</th>
					<th rowspan="3">⑫구축비<br />
						(단위:천원)</th>
					<th rowspan="3">⑬당해년도유지보수비<br />
						(단위:천원)</th>
					<th rowspan="3">⑭당해년도운영비<br />
						(단위:천원)</th>
					<th rowspan="3">⑮클라우드이용여부(Y/N)</th>
					<th colspan="2">세부내역</th>
					<th colspan="3">1단계 사전검토</th>
					<th>결과</th>
					<th colspan="7">2단계	본검토</th>
					<th colspan="3">결과</th>
					<th rowspan="3">㉜클라우드전환 또는<br />도입예정<br />
						(전환/도입예정/N)</th>
					<th colspan="6">전환예정시스템 세부내역</th>
					<th colspan="2">전환시기</th>
				</tr>
				<tr>
					<th rowspan="2">⑯클라우드구분<br />
						(민간/자체/G-Cloud)</th>
					<th rowspan="2">⑰클라우드도입년도<br />
						(YYYY)</th>
					<th rowspan="2">⑱시스템<br />
						(Y/N)</th>
					<th rowspan="2">⑲구현성<br />
						(Y/N)</th>
					<th rowspan="2">⑳경제성<br />
						(Y/N)</th>
					<th rowspan="2">㉑제외대상<br />
						(Y/N)</th>
					<th rowspan="2">㉒서비스<br />
						(3/2/1)</th>
					<th rowspan="2">㉓데이터<br />
						(3/2/1)</th>
					<th rowspan="2">㉔연계<br />
						(3/2/1)</th>
					<th rowspan="2">㉕업무대체율<br />
						(3/2/1)</th>
					<th rowspan="2">㉖업무대체비용<br />
						(3/2/1)</th>
					<th rowspan="2">㉗업무대체수준<br />
						(㉕+㉖)/2</th>
					<th rowspan="2">㉘사고시파급효과<br />
						(3/2/1)</th>
					<th rowspan="2">㉙총점</th>
					<th rowspan="2">㉚평균</th>
					<th rowspan="2">㉛클라우드자체평가등급</th>
					<th rowspan="2">㉝클라우드구분<br />
						(민간/자체/G-Cloud)</th>
					<th colspan="5">예산</th>
					<th rowspan="2">㊴2017년<br />
						(Y/N)</th>
					<th rowspan="2">㊵2017년	이후 전환연도<br />
						(YYYY)</th>
				</tr>
				<tr>
					<th>㉞2017년 1/4분기<br />
						(단위:천원)</th>
					<th>㉟2017년	2/4분기<br />
						(단위:천원)</th>
					<th>㊱2017년	3/4분기<br />
						(단위:천원)</th>
					<th>㊲2017년	4/4분기<br />
						(단위:천원)</th>
					<th>㊳2017년	이후<br />
						(단위:천원)</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(selectList) > 0}" >
						<c:forEach items="${selectList}" var="list" varStatus="status">
							<tr>
								<td>${list.dmandSurveyNo}</td>
								<td>${list.dmandSurveyHighorgname}</td>
								<td>${list.dmandSurveyOrgname}</td>
								<td>${list.dmandSurveySysname}</td>
								<td>${list.dmandSurveySysobj}</td>
								<td>${list.dmandSurveyDivision}</td>
								<td>${list.dmandSurveyManager}</td>
								<td>${list.dmandSurveyMail}</td>
								<td>${list.dmandSurveyPhone}</td>
								<td>${list.dmandSurveyBuildy}</td>
								<td>${list.dmandSurveyUpy}</td>
								<td>${list.dmandSurveyBuildcost}</td>
								<td>${list.dmandSurveyMaint}</td>
								<td>${list.dmandSurveyExpenses}</td>
								<td>${list.dmandSurveyClouduse}</td>
								<td>${list.dmandSurveySeparation}</td>
								<td>${list.dmandSurveyIntroy}</td>
								<td>${list.dmandSurveyFirstsyst}</td>
								<td>${list.dmandSurveyFirstreal}</td>
								<td>${list.dmandSurveyFirstecon}</td>
								<td>${list.dmandSurveyExem}</td>
								<td>${list.dmandSurveySecoundserv}</td>
								<td>${list.dmandSurveySecounddata}</td>
								<td>${list.dmandSurveySecoundconn}</td>
								<td>${list.dmandSurveySecoundsubs}</td>
								<td>${list.dmandSurveySecoundsubscost}</td>
								<td>${list.dmandSurveySecoundsubslevel}</td>
								<td>${list.dmandSurveySecoundripp}</td>
								<td>${list.dmandSurveyTotalscore}</td>
								<td>${list.dmandSurveyAverage}</td>
								<td>${list.dmandSurveySelflevel}</td>
								<td>${list.dmandSurveyChangep}</td>
								<td>${list.dmandSurveySeparation2}</td>
								<td>${list.dmandSurveyFiquater}</td>
								<td>${list.dmandSurveySequater}</td>
								<td>${list.dmandSurveyThquater}</td>
								<td>${list.dmandSurveyFoquater}</td>
								<td>${list.dmandSurveyAfquater}</td>
								<td>${list.dmandSurveyChangeth}</td>
								<td>${list.dmandSurveyChangene}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="40">조회된 데이터가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>