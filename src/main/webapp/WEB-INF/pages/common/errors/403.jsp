<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    boolean isXHR = false;
    if ("XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))) {
        isXHR = true;
    }

    if ( isXHR ) { 
%>
    <div style="margin:10px 0;">파일을 찾을 수 없습니다. (404 Page not found)</div>
    <div>
        <%= request.getAttribute("javax.servlet.forward.request_uri") %>
    </div>
    
<% } else { %>
<html>
<head>
    <title>에러페이지</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <!-- <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/style.css" /> -->
    <link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<link rel="stylesheet" href="/cloud_ver2/new_cloud/css/v3_css.css"></link>
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
    <script type="text/javascript">
    
    </script>
    <style type="text/css">
        dl {
            padding: 8px; border: 1px solid gray;
        }
        dl dt {
            color: blue; margin-top: 6px; 
        }
        dl dd {
        }
        dd.req-page { color: red; font-weight: bold; }
        dd.debug-error { color: orange; }
        
        .btnBold { font-weight: bold;}
    </style>
</head>

<body>

    <%if(GlobalConfig.SERVICE_MODE.equals("dev")){%>
		<h2>403 Page not found</h2>
		<dl>
		    <dt>JSP 페이지</dt>
		    <dd class="req-page"><%= request.getAttribute("javax.servlet.forward.request_uri") %></dd>
		</dl>
		<!-- container -->
		<div id="container">
		<div class="contents">
				<!-- section -->
				<div class="section min-h650 ac">
					<div class="error-page">
						<img src="/new_cloud/images/sub/img-error.png" alt="" />
						<h2>죄송합니다.</h2>
						<strong>해당 페이지의 접근 권한이 없어 요청하신 페이지를 연결할 수 없습니다.</strong>
					</div>
					
					<!-- btn-area -->
					<div class="btn-area ac error_area">
						<!-- <a href="#" onclick=" window.history.back();" class="b-btn type2"><strong><span class="ml5 mr5">이전 페이지로</span></strong></a>
						<a href="/korean/pt/index.do" class="b-btn ml20 type2"><strong><span class="ml5 mr5">메인 페이지로</span></strong></a>
						<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1002" class="b-btn ml20 type2"><strong><span class="ml10 mr10">고객센터</span></strong></a> -->
						<a href="#" onclick=" window.history.back();" class="btns st1 btnBold">이전 페이지로</a>
						<a href="/korean/pt/index.do" class="btns st1 btnBold">메인 페이지로</a>
						<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1002" class="btns st1 btnBold">고객센터</a>
					</div>
					<!-- //btn-area -->

					<p style="text-align: center; margin-top: 20px;">© 클라우드스토어 씨앗</p>
				</div>
				<!-- //section -->
			</div>
		</div>
		<!-- //container -->
	<%}else if(GlobalConfig.SERVICE_MODE.equals("real")){%>
		<!-- container -->
		<div id="container">
		 	<div class="contents">
				<!-- section -->
				<div class="section min-h650 ac">
					<div class="error-page">
						<img src="/new_cloud/images/sub/img-error.png" alt="" />
						<h2>죄송합니다.</h2>
						<strong>해당 페이지의 접근 권한이 없어 요청하신 페이지를 연결할 수 없습니다.</strong>
					</div>
		
					<!-- btn-area -->
					<div class="btn-area ac error_area">
						<!-- <a href="#" onclick=" window.history.back();" class="b-btn type2"><strong><span class="ml5 mr5">이전 페이지로</span></strong></a>
						<a href="/korean/pt/index.do" class="b-btn ml20 type2"><strong><span class="ml5 mr5">메인 페이지로</span></strong></a>
						<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1002" class="b-btn ml20 type2"><strong><span class="ml10 mr10">고객센터</span></strong></a> -->
						<a href="#" onclick=" window.history.back();" class="btns st1 btnBold">이전 페이지로</a>
						<a href="/korean/pt/index.do" class="btns st1 btnBold">메인 페이지로</a>
						<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1002" class="btns st1 btnBold">고객센터</a>
					</div>
					<!-- //btn-area -->
		
					<p style="text-align: center; margin-top: 20px;">© 클라우드스토어 씨앗</p>
				</div>
				<!-- //section -->
			</div>
		</div>
	<!-- //container -->
	<%} %>	
</body>
</html>

<% } %>