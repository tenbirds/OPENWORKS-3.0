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
	<title>클라우드스토어 씨앗 - <c:choose><c:when test="${not empty cmsVo.title}"><c:out value="${cmsVo.title}" /> : <c:out value="${cmsVo.menuPath}" escapeXml="true"/></c:when><c:otherwise><c:out value="${cmsVo.menuNm}" /> : <c:out value="${cmsVo.menuPath}" escapeXml="true"/></c:otherwise></c:choose></title>
	<op:jsTag type="openworks" items="web-core"/>
	<op:jsTag type="spi" items="notice,colorbox,printpreview" />
	<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/ceart_favicon.ico" />
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
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery.imageScroller.js"></script><!-- //image banner Rolling -->
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
    <decorator:head />
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" /> 
	<!-- 2016.08.22 : KS : 메인 디자인 변경 -->
	<!-- <link href="/new_cloud/css/main_ver2.css" rel="stylesheet" type="text/css" />-->
	
    <link href="/new_cloud/css/sub_ver2.css" rel="stylesheet" type="text/css" /> 
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
          
</head>

 <body>
	<%-- <jsp:include page="../inc/header.jsp" flush="true"></jsp:include>	 --%>
	<%@include file="../inc/header.jsp" %>
		

	<!-- //container -->
	<decorator:body />
	<!-- //container -->
	
	<jsp:include page="../inc/foot.jsp" flush="true"></jsp:include>
	
	<!-- 팝업존 스타트 -->
	<!-- <script type="text/javascript" src="/resources/web/popup/js/main_start.js"></script> -->
	<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>	
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
</body>
</html>