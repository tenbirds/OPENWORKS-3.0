<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>호환성 신청 | 표준프레임워크 | 소개 | 씨앗 마켓</title>
</head>
<body>
	<div class="order_finish member">
	    <p class="txt">호환성 신청은 <strong>“판매권한”</strong>을 갖은 회원만 신청이 가능합니다.</p>
	    <%-- <div class="btn_org">
	      <c:if test="${sessionScope['__usk'].nationCode eq 410}">
	          <a href="/${_pathLang}/pt/register/BD_userCrtfc.do?userTyCd=&nationCode=${sessionScope['__usk'].nationCode}"><span class="member">판매 회원 전환 신청하기</span></a>
	      </c:if>
	      <c:if test="${sessionScope['__usk'].nationCode ne 410}">
	          <a href="/${_pathLang}/pt/register/BD_index.do?userTyCd=&nationCode=${sessionScope['__usk'].nationCode}"><span class="member">판매 회원 전환 신청하기</span></a>
	      </c:if>
	    </div> --%>
	</div>
</body>
</html>