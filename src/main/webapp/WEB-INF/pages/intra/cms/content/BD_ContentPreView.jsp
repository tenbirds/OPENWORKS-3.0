<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <title>${dataVo.menuNm}</title>
    <!-- 메타데이터 정의 -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <c:out value="${dataVo.headContent}" escapeXml="false" />
</head>
<body>
    <c:out value="${dataVo.bodyContent}" escapeXml="false" />
</body>
</html>