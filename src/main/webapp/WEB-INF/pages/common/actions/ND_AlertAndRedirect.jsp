<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>${message}</title>

<op:jsTag type="spi" items="jquery,notice" />
<op:jsTag type="openworks" />

<script type="text/javascript">
	<c:if test="${not empty message}">
		alert("${message}");
	</c:if>
	<c:if test="${not empty url}">
		<c:if test="${not empty target}">
			${target}.location.href = "${url}";
		</c:if>
		<c:if test="${empty target}">
			self.location.href = "${url}";
		</c:if>
		self.location.href = "${url}";
	</c:if>
	<c:if test="${empty url}">
		alert("이동을 위한 URL 정보가 없습니다.");
	</c:if>
</script>
</head>

<body>
<!-- ${message} -->
</body>

</html>