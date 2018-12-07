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
	<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/ceart_favicon.ico" />
	<script type="text/javascript">var CTX_PATH="<%=request.getContextPath()%>";</script>
	
	<op:jsTag type="openworks" items="web-core"/>
	<op:jsTag type="spi" items="notice,colorbox,printpreview" />
	
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
    
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery.imageScroller.js"></script><!-- //image banner Rolling -->

    <decorator:head />
	
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<!-- 2016.08.22 : KS : 메인 디자인 변경 {{ -->
	<link href="/new_cloud/css/main_ver2.css" rel="stylesheet" type="text/css" />
    <link href="/new_cloud/css/sub_ver2.css" rel="stylesheet" type="text/css" />    
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
    <!-- }} -->
     
	<script defer src="/new_cloud/js/jquery.flexslider.js"></script>
	<link rel="stylesheet" href="/new_cloud/css/flexslider.css" type="text/css" media="screen" />
	
	<script type="text/javascript">
		var menuNm = "<c:out value="${cmsVo.menuNm}" />";
		
		$(window).load(function() {
		  $('.flexslider').flexslider({
		    animation: "slide"
		  });
		});
	</script>
	
</head>
<body>
	<%-- <jsp:include page="../inc/header.jsp" flush="true"></jsp:include>	 --%>
	<%@include file="../inc/header.jsp" %>
	
	
	<!-- content -->
	<section class="listTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2><c:out value="${cmsVo.topMenuNm}" /></h2>
			<div id="bodyMenuNm"><c:out value="${cmsVo.menuNm}" /> <span style="font-size:17px;font-weight: bold;"><decorator:title default="" /></span></div>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	
	<section class="lay_lnb">
		<div class="conWrap">
			<nav>
				<!-- 좌측 카테고리 -->
				<ul>
					<c:if test="${not empty subMenuList}">
					<c:forEach items="${subMenuList}" var="subMenuVO" varStatus="subStatus">
                           <c:set var="childUrl" value="" />
                    		<c:if test="${subMenuVO.showYn eq 'Y'}">
                           	<c:set var="applyLinkType" value="" />
                            <c:choose>
                                <c:when test="${subMenuVO.linkType eq 'popup'}">
                                    <c:set var="applyLinkType" value="class=\"usermenuOpen\"" />
                                </c:when>
                                <c:when test="${subMenuVO.linkType eq 'layer'}">
                                    <c:set var="applyLinkType" value="class=\"usermenuColobox\"" />
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${not empty subMenuVO.userMenuUrl}">
                                    <c:set var="childUrl" value="${subMenuVO.userMenuUrl}" />
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${subMenuVO.childList}" var="childMenuVo" varStatus="childMenuVoStatus">
                                        <c:if test="${childMenuVoStatus.first}">
                                            <c:set var="childUrl" value="${childMenuVo.userMenuUrl}" />
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
							<c:if test="${not empty subMenuVO.childList}">
                            	<c:set var="showmenu" value="${cmsVo.parentMenuCode}" />
                            </c:if>
                            <c:if test="${empty subMenuVO.childList}">
                            	<c:set var="showmenu" value="${cmsVo.menuCode}" />
                            </c:if>
                            <c:if test="${subMenuVO.menuCode eq 'dcPartcptReqst' || subMenuVO.menuCode eq 'dcPartcptAprslt' || subMenuVO.menuCode eq 'dmandExamin'}">
                            <c:if test="${fn:startsWith(sessionScope['MEM_TYPE'], '30') && sessionScope['MEM_CHARGER_AT'] eq 'Y' }">
							<li <c:if test="${subMenuVO.menuCode eq cmsVo.menuCode}">class="on"</c:if>>
								<a href="<c:url value="${childUrl}" />"><c:out value="${subMenuVO.menuNm}" /></a>
								<c:if test="${subMenuVO.menuCode eq showmenu}">
									<c:if test="${not empty subMenuVO.childList}">
	                                	<c:forEach items="${subMenuVO.childList}" var="childMenuVO">
	                                    	<c:set var="cshowmenu" value="${childMenuVO.menuCode}" />
	                                    	<c:if test="${childMenuVO.showYn eq 'Y'}">
	                                        	<ul>
	                                                <c:set var="applyLinkType" value="" />
	                                                <c:choose>
	                                                    <c:when test="${childMenuVO.linkType eq 'popup'}">
	                                                        <c:set var="applyLinkType" value="class=\"usermenuOpen\"" />
	                                                    </c:when>
	                                                    <c:when test="${childMenuVO.linkType eq 'layer'}">
	                                                        <c:set var="applyLinkType" value="class=\"usermenuColobox\"" />
	                                                    </c:when>
	                                                </c:choose>
	                                                <li >
	                                                    <a href="<c:url value="${childMenuVO.userMenuUrl}" />" <c:if test="${childMenuVO.menuCode eq cmsVo.menuCode}">class="on"</c:if> <c:out value="${applyLinkType}" escapeXml="false"/>>- <c:out value="${childMenuVO.menuNm}" /></a>
	                                                </li>
	                                            </ul>
	                                        </c:if>
	                               		</c:forEach>
	                                </c:if>
								</c:if>
							</li>
							</c:if>
							</c:if>
							<c:if test="${subMenuVO.menuCode ne 'dcPartcptReqst' && subMenuVO.menuCode ne 'dcPartcptAprslt' && subMenuVO.menuCode ne 'dmandExamin'}">
							<li <c:if test="${subMenuVO.menuCode eq cmsVo.menuCode}">class="on"</c:if>>
								<a href="<c:url value="${childUrl}" />"><c:out value="${subMenuVO.menuNm}" /></a>
								<c:if test="${subMenuVO.menuCode eq showmenu}">
									<c:if test="${not empty subMenuVO.childList}">
										<ul>
	                                	<c:forEach items="${subMenuVO.childList}" var="childMenuVO">
	                                    	<c:set var="cshowmenu" value="${childMenuVO.menuCode}" />
	                                    	<c:if test="${childMenuVO.showYn eq 'Y'}">	                                        	
                                                <c:set var="applyLinkType" value="" />
                                                <c:choose>
                                                    <c:when test="${childMenuVO.linkType eq 'popup'}">
                                                        <c:set var="applyLinkType" value="class=\"usermenuOpen\"" />
                                                    </c:when>
                                                    <c:when test="${childMenuVO.linkType eq 'layer'}">
                                                        <c:set var="applyLinkType" value="class=\"usermenuColobox\"" />
                                                    </c:when>
                                                </c:choose>
                                                <li>
                                                    <a href="<c:url value="${childMenuVO.userMenuUrl}" />" <c:out value="${applyLinkType}" escapeXml="false"/> <c:if test="${childMenuVO.menuCode eq cmsVo.menuCode}">class="on"</c:if>><c:out value="${childMenuVO.menuNm}" /></a>
                                                </li>
	                                        </c:if>
	                               		</c:forEach>
	                               		  </ul>
	                                </c:if>
								</c:if>
							</li>
							</c:if>
						</c:if>
					</c:forEach>
				</c:if>
				</ul>
				<!--// 좌측 카테고리 -->
			</nav>
		<!-- //left -->

		<!-- contents -->
			<decorator:body />
		<!-- contents -->	
	  </div>	
	</section>
	<!--// content -->
		
	<jsp:include page="../inc/foot.jsp" flush="true"></jsp:include>
	<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>		
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
	<!--footer End-->
<!-- <script type="text/javascript">
	$(document).ready(function(){
	    $('#bodyMenuNm').text(menuNm);
	});
</script>	 -->
</body>
</html>