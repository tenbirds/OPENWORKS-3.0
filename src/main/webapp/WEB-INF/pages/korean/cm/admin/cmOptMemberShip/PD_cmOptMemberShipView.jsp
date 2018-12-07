<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 회원 정보</title>
	<op:jsTag type="openworks" items="cmweb-core"/>
	<op:jsTag type="spi" items="notice" />
	<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/style.css" />
	<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
	
	
</head>
<body>

<!-- 팝업 윈도우 크기 width:778px  -->
	<div id="pop_wrap">
	
		<div class="pop_container">
			<!-- popup header -->
			<div class="header">
				<h1>커뮤니티 회원 정보</h1>
			</div>
			<!-- //header -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="userId" name="userId" value="<c:out value="${cmOptMemberShipInfoView.userId}"/>" />
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmOptMemberShipInfoView.cmmntyId}"/>" />
		<input type="hidden" id="cmmntySttusCd" name="cmmntySttusCd" value="<c:out value="${cmOptMemberShipInfoView.cmmntySttusCd}"/>" /> 
			<!-- popup content -->
			<div class="section">
				<p class="tit">개인</p>
				<table class="tbl_pop">
				<colgroup>
					<col style="width:16%;">
					<col style="width:11%;">
					<col style="width:14%;">
					<col>
					<col style="width:14%;">
					<col style="width:16%;">
				</colgroup>
				<tbody>
<!-- 					<tr> -->
<!-- 						<td class="tit">작성자</td> -->
<!-- 						<td>고길동</td> -->
<!-- 						<td class="tit">이메일</td> -->
<!-- 						<td>abcd@ancdefg.com</td> -->
<!-- 						<td class="tit">작성일자</td> -->
<!-- 						<td class="date">2014.08.15. 23:32</td> -->
<!-- 					</tr> -->
					<tr>
						<td class="tit">구분</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.nationCode == '401' }">국내기업</c:if><c:if test="${cmOptMemberShipInfoView.nationCode != '401'}">외국기업</c:if></td>
					</tr>
					<tr>
						<td class="tit">아이디</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.idOthbcAt == 'N'|| empty cmOptMemberShipInfoView.idOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.idOthbcAt == 'Y'}"><c:out value="${cmOptMemberShipInfoView.cmmntyMberId}"/></c:if></td>
					</tr>
					<tr>
						<td class="tit">이름</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.nmOthbcAt == 'N' || empty cmOptMemberShipInfoView.nmOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.nmOthbcAt == 'Y'}"><c:out value="${cmOptMemberShipInfoView.userNm}"/></c:if></td>
					</tr>
					<tr>
						<td class="tit">닉네임</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.ncnm}"/></td>
					</tr>
	              	<tr>
						<td class="tit">전화번호</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.telnoOthbcAt == 'N' || empty cmOptMemberShipInfoView.telnoOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.telnoOthbcAt == 'Y'}"><c:out value="${cmOptMemberShipInfoView.telno}"/></c:if></td>
					</tr>
					<tr>
						<td class="tit">휴대전화</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.mbtlnumOthbcAt == 'N' || empty cmOptMemberShipInfoView.mbtlnumOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.mbtlnumOthbcAt == 'Y'}"><c:out value="${cmOptMemberShipInfoView.mbtlnum}"/></c:if></td>
					</tr>
					<tr>
						<td class="tit">이메일 주소</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.emailOthbcAt == 'N' || empty cmOptMemberShipInfoView.emailOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.emailOthbcAt == 'Y'}"><c:out value="${cmOptMemberShipInfoView.email}"/></c:if></td>
					</tr>
				</tbody>
				</table>
				<br/>
				<p class="tit">회사</p>
				<table class="tbl_pop">
				<colgroup>
					<col style="width:16%;">
					<col style="width:11%;">
					<col style="width:14%;">
					<col>
					<col style="width:14%;">
					<col style="width:16%;">
				</colgroup>
				<tbody>
					<tr>
						<td class="tit">회사명</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.cmpnyNmOthbcAt == 'N' || empty cmOptMemberShipInfoView.cmpnyNmOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.cmpnyNmOthbcAt == 'Y'}"><c:out value="${userDefaultInfo.cmpnyNm}"/></c:if></td>
					</tr>
					<tr>
						<td class="tit">회사 대표번호</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.reprsntTelnoOthbcAt == 'N' || empty cmOptMemberShipInfoView.reprsntTelnoOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.reprsntTelnoOthbcAt == 'Y'}"><c:out value="${userDefaultInfo.cmpnyReprsntTelno}"/></c:if></td>
					</tr>
					<tr>
						<td class="tit">회사 이메일 주소</td>
						<td colspan="5"><c:if test="${cmOptMemberShipInfoView.cmpnyEmailOthbcAt == 'N' || empty cmOptMemberShipInfoView.cmpnyEmailOthbcAt}">비공개</c:if><c:if test="${cmOptMemberShipInfoView.cmpnyEmailOthbcAt == 'Y'}"><c:out value="${userDefaultInfo.cmpnyEmail}"/></c:if></td>
					</tr>
				</tbody>
				</table>
				<br/>
			<p class="tit">활동</p>
				<table class="tbl_pop">
				<colgroup>
					<col style="width:16%;">
					<col style="width:11%;">
					<col style="width:14%;">
					<col>
					<col style="width:14%;">
					<col style="width:16%;">
				</colgroup>
				<tbody>
					<tr>
						<td class="tit">가입일</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.sbscrbReqstDt}"/></td>
					</tr>
					<tr>
						<td class="tit">최종방문일</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.visitDt}"/></td>
					</tr>
					<c:if test="${cmOptMemberShipInfoView.mberStateCd == '1004' }">
					<tr>
						<td class="tit">탈퇴일</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.secsnDt}"/></td>
					</tr>
					<tr>
						<td class="tit">탈퇴 구분</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.enfrcSecsnNm}"/></td>
					</tr>
					</c:if>
					<tr>
						<td class="tit">방문수</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.cmVisitCount}"/></td>
					</tr>
					<tr>
						<td class="tit">작성글</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.cmMberBbsCount}"/></td>
					</tr>
					<tr>
						<td class="tit">댓글수</td>
						<td colspan="5"><c:out value="${cmOptMemberShipInfoView.cmMberBbsCmtCount}"/></td>
					</tr>
				</tbody>
				</table>
		
				<div class="btn_area">
					<div class="btn_pop_c">						
						<div class="btn_navi">
<!-- 							<a href="#reg"><span class="gt">답변수정</span></a> -->
						</div>
						<div class="btn_navi_g">
							<a href="#cancel" onclick="jsCloseWin();" ><span class="cancel">닫기</span></a>
						</div>
					</div>
				</div>
			</div>
			<!-- //popup content -->
	</form>
			<a class="w_close" href="#close" onclick="jsCloseWin();">
				<span>닫기</span>
			</a>
		</div>
	</div>
</body>
</html>
