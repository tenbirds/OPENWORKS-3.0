<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%
	String sessionid = request.getSession().getId();
	response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionid + "; secure");

	String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";

	request.setAttribute("strCmmntyId", strCmmntyId);
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	
	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	//변경소스
	request.setAttribute("SubDomain", "korean");
	//}}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script  type="text/javascript" >
			var cmmntyId  = "<c:out value='${strCmmntyId}'/>";
			var SubDomain  = "<c:out value='${SubDomain}'/>";
			if(SubDomain !="intra"){
				if(cmmntyId == ""){
				    // 이전소스
				    //location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/pt/index.do";
				    
				    //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
					// 변경소스
					location.href="http://${domain_name}/<c:out value='${SubDomain}'/>/pt/index.do";
					//}}

				}
			}
	</script>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	<title>클라우드스토어 씨앗 - 커뮤니티</title>
	<op:jsTag type="openworks" items="cmweb-core"/>
	<op:jsTag type="spi" items="notice, colorbox" />
	<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/ceart_favicon.ico" />
	<script type="text/javascript" src="/resources/cmmnty/default/js/common.js"></script>
	<!-- 웹로그모니터링 -->
    <script type="text/javascript" src="/resources/web/theme/default/js/makePCookie.js"></script>
	<decorator:head />
	<script type="text/javascript">
	$(document).ready(function(){
	    $('nav#gnb').css({
	        width:(70+'%'),
	        marginLeft:'30px'
	    });
	    $('nav#gnb li').width($('nav#gnb').width() / $('nav#gnb').find('li').size());	    
	});
	</script>

</head>
<body>
	<!-- skip navi -->
	<ul class="skip_navi">
		<li><a href="#contents">본문내용으로 바로가기</a></li>
	</ul>
	<!-- //skip navi -->
	<div id="wrap">
		<!-- header -->
		<header>
			<div id="header">
				<h1><a href="/<c:out value='${SubDomain}'/>/pt/index.do"><img src="/cloud_ver2/new_cloud/images/logo.png" alt="클라우드"></a></h1>
				<nav id="gnb">
					<ul>
						<li><a href="/<c:out value='${SubDomain}'/>/pt/store/software/BD_index.do?goodsTyCd=1002">SaaS</a></li>
						<li><a href="/<c:out value='${SubDomain}'/>/pt/store/software/BD_index.do?goodsTyCd=1001">PaaS</a></li>
						<li><a href="/<c:out value='${SubDomain}'/>/pt/store/software/BD_index.do?goodsTyCd=1003">IaaS</a></li>
						<li><a href="/web/board/BD_board.view.do?domainCd=2&bbsCd=1013&bbscttSeq=20151013000000000">지식</a></li>
						<li><a href="/kor/introduction/ompIntro/ompIntroduction.jsp">소개</a></li>
						<li><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1010">전문가상담</a></li>
					</ul>
				</nav>

				<div class="account">
					<c:if test="${empty sessionScope['__usk']}"><a href="#none" onclick="jsLoginCheck(this,'<c:out value="${sessionScope['__usk'].userId}"/>' ,'cmuser', '');" class="name" >LOGIN</a></c:if>
					<c:if test="${not empty sessionScope['__usk']}">
					<a href="#none" class="name" onclick="showLayer('info');"><c:out value="${sessionScope['__usk'].userNm}" /> 님</a>
					<ul id="info" onmouseover="showLayer('info');" onmouseout="hideLayer('info');">
						<li><a href="/<c:out value='${SubDomain}'/>/pt/register/BD_password.do">회원정보 변경</a></li>
						<li><a href="/login/user/ND_logoutAction.do">로그아웃</a></li>
					</ul>
					</c:if>
				</div>
			</div>
		</header>
		<!-- //header -->

		<!-- container -->
		<decorator:body />
		<!-- //container -->

		<!-- footer -->
		<footer>
<!-- 			오픈마켓플레이스 <span class="company" ><span id="footerCmNm"/></span> -->
		</footer>
		<!-- //footer-->
	</div>

</body>
</html>