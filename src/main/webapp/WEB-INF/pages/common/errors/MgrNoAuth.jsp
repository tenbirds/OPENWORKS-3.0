<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.openworks.intra.cms.support.CmsDecoratorMapper" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!DOCTYPE html
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>사용 권한 없음</title>
<!-- 메타데이터 정의 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<op:jsTag type="spi" items="jquery, notice, colorbox, printpreview" />
<op:jsTag type="openworks" />
</head>
<body>

    <div style="text-align:center;padding:100px;">
        <h1>메뉴 사용 권한이 없습니다.</h1>
        <br /><br />
        <button type="button" class="gray mar_l5 vm" onclick="history.back();">돌아가기</button>
    </div>

</body>
</html>