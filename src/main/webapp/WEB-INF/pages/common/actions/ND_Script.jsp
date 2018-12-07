<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>${message}</title>

<op:jsTag type="spi" items="jquery" />
<op:jsTag type="openworks" />

<script type="text/javascript">
    ${scriptCode}
</script>
</head>

<body>

</body>
</html>