<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<op:jsTag type="spi" items="form" />
<title>가입정보변경이력</title>
</head>
 
<body>
<ul class="blet">
	<li>회원가입정보설정관리는 시스템 구축시 회원가입정보 설정을 위해 설계된 관리시스템입니다.</li>
	<li><span class="tx_blue_n">구축 후 또는 운영 중 회원가입정보 설정을 변경</span>할 경우 가입정보 중 다른 시스템 또는 다른 기능에서 가입정보를 사용하고 있는 경우 <span class="tx_blue_n">심각한 문제가 발생</span>할 수 있습니다.</li>
	<li>회원가입정보 설정을 변경할 때에는 다른 <span class="tx_blue_n">프로그램과의 연관관계를 고려</span>하여 신중히 <span class="tx_blue_n">사용</span>하시기 바랍니다.</li>
</ul>

<!-- 탭 -->
<ul class="tab">
	<li><a href="BD_index.do">기본항목설정</a></li>
	<li><a href="BD_userInfoInterest.do">스토어항목설정</a></li>
	<li><a href="BD_userInfoLog.do" class="on">가입정보변경이력</a></li>
</ul>
<!-- //탭 -->

<form name="form" id="form" method="post">
<input type="hidden" name="itemGubun" id="itemGubun" />

	<h4>회원가입정보 변경이력</h4>
	<!-- 리스트 -->
	<table class="boardList" cellspacing="0" border="0" summary="변경이력 리스트입니다.">
		<caption class="hidden"> 변경이력 리스트 </caption>
		<colgroup>
			<col width="6%"/>
			<col width="12%"/>
			<col width=""/>
			<col width="10%"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>변경일시</th>
				<th>변경사항</th>
				<th>등록자</th>
				<th class="lr_none">등록자ID</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="listSize" value="${listLen}" />
			<c:forEach var="item" items="${list}" varStatus="status">
				<tr <c:if test="${(listSize-status.index)%2==0}">class="bg_yellow"</c:if>>
					<td>${listSize - status.index}</td>
					<td>${item.updtDt}</td>
					<td class="tx_l">${item.updtCn}</td>
					<td>${item.updtNm}</td>
					<td class="lr_none">${item.updtId}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- //리스트 -->
</form>
</body>
</html>