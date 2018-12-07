<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	String sessionid = request.getSession().getId();
	response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionid + "; secure");
	request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	
	String sslYn = "";
	String devYn = "";
	if ("Y".equals(Config.getString("global.sslUse"))) {
		sslYn = "Y";
	} else {
		sslYn = "N";
	}
	if ("dev".equals(Config.getString("global.serviceMode"))) {
		devYn = "Y";
	}else{
		devYn = "N";
	}
%>
<c:set var="sslYn" value="<%=sslYn%>" scope="page"/>
<c:set var="devYn" value="<%=devYn%>" scope="page"/>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<!-- <meta http-equiv="Pragma" content="no-cache" /> -->
	<!-- <meta http-equiv="Expires" content="-1" /> -->
	<title>클라우드스토어 씨앗 - 홈</title>
	<op:jsTag type="openworks" items="web-core"/> 
	<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/ceart_favicon.ico" />
	<script type="text/javascript" src="/resources/openworks/spi/jquery/cookie/jquery.cookie.js"></script>

	<script type="text/javascript">var CTX_PATH="<%=request.getContextPath()%>";</script>
	<!-- 접속로그 수집영역 START -->
    <script type="text/javascript">
        var anlzSessionId = '<%=session.getId()%>';
        var anlzClientIp = '<%=request.getRemoteAddr()%>';
        var anlzSearchEngine = new Array();
        var anlzMobileOS = new Array();
        
        <%
	        String[] domains = Config.getStringArray("analyze.search-engines.domain");
	        for (String domain : domains) {
            	out.println("anlzSearchEngine.push('"+domain+"');");
        	}
	        String[] mobiles = Config.getStringArray("analyze.platforms.mobile");
	        for (String mobile : mobiles) {
            	out.println("anlzMobileOS.push('"+mobile+"');");
        	}
        %>
    </script>    
    <script type="text/javascript" src="/resources/web/analyze/tracking/js/detector.js"></script>
    <script type="text/javascript" src="/resources/web/analyze/tracking/js/tracker.js"></script>
    <!-- 접속로그 수집영역 END   -->
	
    <decorator:head />
	<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_main.css' />
</head>

 <body class="main">
	
	<%@include file="../inc/header.jsp" %>
	
	<!-- //container -->
	<decorator:body />
	<!-- //container -->
		
	<jsp:include page="../inc/foot.jsp" flush="true"></jsp:include>
	<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>		
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
</body>
</html>