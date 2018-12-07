<%@page import="zes.core.spi.commons.configuration.Config"%>
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
<%@page import="java.util.Enumeration"%>
<%
    StringBuilder paramText = new StringBuilder();
    Enumeration<?> _enum = request.getParameterNames();

    while (_enum.hasMoreElements()) {
        String key = _enum.nextElement().toString();
        if ("content".equals(key) || "password".equals(key) || "passwd".equals(key) || "contents".equals(key)) {
            continue;
        }
        String [] value = request.getParameterValues(key);

        for (int i=0 ; i < value.length ; i++) {
            String _val = java.net.URLEncoder.encode(value[i], "UTF-8");
            paramText.append(key + '=' + _val + '&');
        }
    }

    String paramStr = paramText.toString();
    if(paramStr.endsWith("&")) {
        paramStr = paramStr.substring(0, paramStr.length() -1);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title><decorator:title default="" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/openworks/spi/extjs/resources/css/ext-all.css"/>" media="print"/>

    <op:jsTag type="spi" items="jquery,notice,colorbox,printpreview" />
    <op:jsTag type="openworks" />

    <script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>

    <decorator:head />
    <script>
        var link = 'http://' + document.domain + ':' + '<%=request.getLocalPort()%>' + '<%=request.getRequestURI()%>?' + '<%=paramStr%>';
        $().ready(function () {
			//날짜에 대한 입력값 오류 방지
			$(".ui-datepicker-trigger").parent().children("input").attr("maxlength","10");
			$(".ui-datepicker-trigger").parent().children("input").attr("style","ime-mode:disabled");
        });
    </script>
</head>

<body>

    <!-- 컨텐츠영역 -->
    <div id="contents_area">
        <!-- 타이틀 및 상단아이콘 -->
        <h3><decorator:title default="" /></h3>
        <ul class="loc_m">
            <!-- <li class="ti_01"><a href="#" id="op-gb-interest">즐겨찾기등록</a></li> -->
            <li class="ti_02"><a href="#" id="op-gb-reload">새로고침</a></li>
            <li class="ti_03"><a href="#" id="op-gb-print">화면인쇄</a></li>
            <!-- <li class="ti_04"><a href="#" id="op-gb-help">도움말보기</a></li> -->
        </ul>
        <div id="helpDiv" class="b_write none">
            <op:help menuCd="${param.menuCd}" />
        </div>
        <decorator:body />
    </div>
    <!-- //컨텐츠영역 -->

    <%-- <!-- 접속로그 수집영역 START -->
    <script type="text/javascript">
        var anlzSessionId = '<%=session.getId()%>';
        var anlzClientIp = '<%=request.getRemoteAddr()%>'
    </script>
    <script type="text/javascript">
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
    <script type="text/javascript" src="<c:url value="/resources/intra/analyze/tracking/js/detector.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/intra/analyze/tracking/js/tracker.js"/>"></script>
    <!-- 접속로그 수집영역 END   --> --%>
</body>
</html>