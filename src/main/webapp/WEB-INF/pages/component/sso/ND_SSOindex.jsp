<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.base.support.OpHelper" %>
<%@ page import="zes.core.spi.commons.configuration.Config" %>
<%

	String mgrSSOId = request.getParameter("mgrSSOId");//' == null ? "" : request.getParameter("mgrSSOId");
	String mgrSSOCd= request.getParameter("mgrSSOCd");// == null ? "" : request.getParameter("mgrSSOCd");
	Object loginVo = OpHelper.getMgrSession(request);
	if(loginVo != null){
		response.sendRedirect(request.getContextPath() + Config.getString("url.mgrMain"));
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head><c:url value="" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="ko" />
<title>로그인</title>
<op:jsTag type="spi" items="jquery, notice, cookie" />
<op:jsTag type="openworks" />
<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
    <script type='text/javaScript'>
    <!--
        function jsSend() {
            document.ssoForm.submit();
        }
    -->
    </script>
</head>

<body onLoad='jsSend();'>

    <form name='ssoForm' method='post' action='/sso/ND_openWorksSSO.do'>
        <input type='hidden' name='mgrSSOId' value='<%= mgrSSOId %>'>
        <input type='hidden' name='mgrSSOCd' value='<%= mgrSSOCd %>'>
    </form>

</body>