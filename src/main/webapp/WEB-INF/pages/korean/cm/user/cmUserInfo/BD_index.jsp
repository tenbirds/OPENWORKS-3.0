<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%
	String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
	%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 정보 | 씨앗 마켓</title>
	 <op:jsTag type="spi" items="form, validate" />
	
	<script type="text/javascript">
	
	</script>
</head>
<body>
	<c:set var="cmmntyId" value="<%=strCmmntyId %>"/>
	<form name="dataForm" id="dataForm" method="post">
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=1&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2>커뮤니티 정보</h2>
				<table class="tbl_view">
					<colgroup>
						<col style="width:20%">
						<col style="width:*">
						<col style="width:20%">
						<col style="width:25%">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit">커뮤니티 이름</td>
							<td><c:out value='${cmUserView.cmmntyNm}'/></td>
							<td class="tit">커뮤니티 개설일</td>
							<td class="last"><c:out value='${cmUserView.confmDt}'/></td>
						</tr>
						<tr>
							<td class="tit">커뮤니티 설명</td>
							<td colspan="3" class="cont_view"><c:out value='${cmUserView.cmmntyDc}'/></td>
						</tr>
						<tr>
							<td class="tit">커뮤니티 카테고리</td>
							<td><c:out value='${cmUserView.cmmntyCtgryNm}'/></td>
							<td class="tit">지원 언어</td>
							<td class="last"><c:out value='${cmUserView.langNm}'/></td>
						</tr>
						<tr>
							<td class="tit">커뮤니티 운영자</td>
							<td colspan="3"><c:out value='${cmUserView.userNm}'/></td>
						</tr>
						<tr>
							<td class="tit">전체 회원수</td>
							<td colspan="3"><c:out value='${cmUserView.cmMberCount}'/>명</td>
						</tr>
					</tbody>
				</table>

			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form>
</body>
</html>
