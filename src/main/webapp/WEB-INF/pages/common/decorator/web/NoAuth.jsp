<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.openworks.intra.cms.support.CmsDecoratorMapper" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!DOCTYPE html
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <title> </title>
    <!-- 메타데이터 정의 -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <op:jsTag type="spi" items="jquery" />
    <op:jsTag type="openworks" items="web-core"/>
    <script type="text/javascript">
        $().ready(function(){
            <c:if test="${empty sessionScope['__usk']}">
            alert(Message.msg.requiredLogin);
            </c:if>
            <c:if test="${not empty sessionScope['__usk']}">
            alert(Message.msg.noAuth+"\n${userGradeInfo}"+Message.msg.noAuth1);
            </c:if>
            history.back();
        });
    </script>
</head>
<body>
</body>
</html>