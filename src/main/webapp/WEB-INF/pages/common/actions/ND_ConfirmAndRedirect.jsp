<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>${message}</title>

<op:jsTag type="spi" items="jquery,notice" />
<op:jsTag type="openworks" />

<script type="text/javascript">
	if(confirm("${message}")) {
		<c:if test="${empty url}">
		alert("이동을 위한 URL 정보가 없습니다.");
		</c:if>
		document.location.href = "${url}";
	} else {
		//history.back();
		document.location.href = "/korean/pt/index.do"
	}
</script>
</head>

<body>
${message}
</body>
</html>