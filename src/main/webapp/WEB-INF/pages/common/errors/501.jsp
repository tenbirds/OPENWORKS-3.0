<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>에러페이지</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <%if(GlobalConfig.SERVICE_MODE.equals("real")){%>
	    <!-- <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
		    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/style.css" /> -->
		    <link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
			<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
			<link rel="stylesheet" href="/cloud_ver2/new_cloud/css/v3_css.css"></link>
			<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
			<script type="text/javascript" src="/new_cloud/js/style.js"></script>
    <%} %>
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
		<h2>501 Internal server error (From WAS)</h2>
		
		<dl>
		    <%
		    java.util.Enumeration<?> _e = request.getAttributeNames();
		    while( _e.hasMoreElements() ) {
		        String key = (String)_e.nextElement();
		        out.println( "<dt>" + key + "</dt>" );
		        
		        if ( key.equals("exception") ) {
		            Exception e =(Exception)request.getAttribute(key);
		            out.println( "<dd><pre>" + org.apache.commons.lang.exception.ExceptionUtils.getStackTrace(e) + "</pre></dd>" );
		        }
		        else if ( key.equals("javax.servlet.error.message") ) {
		            out.println( "<dd class='debug-error'>" + request.getAttribute(key) + "</dd>" );
		        }
		        else {
		            out.println( "<dd>" + request.getAttribute(key) + "</dd>" );
		        }
		    }
		    %>
		</dl>

		
		<!-- container -->
		<!-- <div id="container">

			contents
			<div class="contents">
				section
				<div class="section min-h650 ac">
					<div class="error-page">
						<img src="/new_cloud/images/sub/img-error.png" alt="" />
						<h2>죄송합니다.</h2>
						<strong>서비스가 원활하지 않습니다.</strong>
						<p>서비스 이용에 불편을 끼쳐드려 죄송합니다.<br />이전 페이지나 메인 페이지로 이동하여 다시 이용해 주십시오.</p>
					</div>

					btn-area
					<div class="btn-area ac mt20 mb70">
						<a href="#" onclick=" window.history.back();" class="b-btn type2"><strong><span class="ml5 mr5">이전 페이지로</span></strong></a>
						<a href="/korean/pt/index.do" class="b-btn ml20 type2"><strong><span class="ml5 mr5">메인 페이지로</span></strong></a>
						<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1002" class="b-btn ml20 type2"><strong><span class="ml10 mr10">고객센터</span></strong></a>
					</div>
					//btn-area

					<p>© 클라우드스토어 씨앗</p>
				</div>
				//section

			</div>
			//contents
		</div> -->
		<!-- //container -->
	<%}else if(GlobalConfig.SERVICE_MODE.equals("real")){%>
        <!-- container -->
		<!-- <div id="container"> -->

			<!-- contents -->
			<div class="contents">
				<!-- section -->
				<div class="section min-h650 ac">
					<div class="error-page">
						<img src="/new_cloud/images/sub/img-error.png" alt="" />
						<h2>죄송합니다.</h2>
						<strong>서비스가 원활하지 않습니다.</strong>
						<p>서비스 이용에 불편을 끼쳐드려 죄송합니다.<br />이전 페이지나 메인 페이지로 이동하여 다시 이용해 주십시오.</p>
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
			<!-- //contents -->
		<!-- </div> -->
		<!-- //container -->
    <%}%>
</body>
</html>
