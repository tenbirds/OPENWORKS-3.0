<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
if( GlobalConfig.SERVICE_MODE.equals("real")) {
	String ipAddress = (String)request.getRemoteAddr();
	if (!(ipAddress.equals("210.91.26.242") 	|| ipAddress.equals("123.111.240.111") 	|| ipAddress.equals("172.20.105.159") || 
			  ipAddress.equals("172.20.105.105") 	|| ipAddress.equals("172.20.105.67") 		|| ipAddress.equals("152.99.104.252") || 
			  ipAddress.equals("203.254.51.26")  	|| ipAddress.equals("218.48.232.106") 	|| ipAddress.equals("125.128.73.3")		|| 
			  ipAddress.equals("220.64.91.55") 		|| ipAddress.equals("203.254.51.15") 		|| ipAddress.equals("172.20.105.18") 	|| 
			  ipAddress.equals("172.20.101.121") 	|| ipAddress.equals("172.20.101.122")  	|| ipAddress.equals("172.20.101.125") ||
			  ipAddress.equals("172.20.101.126") 	|| ipAddress.equals("172.20.101.127")  	|| ipAddress.equals("172.20.101.129") || 
			  ipAddress.equals("172.20.101.124")  || ipAddress.equals("220.64.91.55")) )
	{ 
		%>
		<script type="text/javascript">alert('접근할 수 없는 IP 입니다'); location.href="https://www.ceart.kr/";</script> 
		<%
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title><decorator:title default="" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="ko" />

	<op:jsTag type="spi" items="jquery,notice,printpreview" />
	<op:jsTag type="openworks" />

	<script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>

	<decorator:head />
</head>

<body>

	<div id="bodyDiv">
		<div id="contentDiv">
			<decorator:body />
		</div>
	</div>

</body>
</html>