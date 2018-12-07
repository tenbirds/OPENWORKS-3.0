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
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<title>클라우드스토어 씨앗 - 홈</title>
	<op:jsTag type="openworks" items="web-core"/>
	<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/ceart_favicon.ico" />
	<link rel="stylesheet" href="/cloud_ver3/html_m/css/common.css">
	<link rel="stylesheet" type="text/css" href="/new_cloud_m/css/main.css" />		
	<script type="text/javascript" src="/new_cloud_m/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud_m/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud_m/js/common.js"></script>
	<script type="text/javascript">var CTX_PATH="<%=request.getContextPath()%>";</script>
	<script type="text/javascript">
	function Search_Enter(i) {
	    if (event.keyCode == 13) {
	        Search_it();
	    }
	    return false;
	}
	function onButtonClick() {
	    nsAdminGoodsList.copy();
	}

	</script>
	<decorator:head />
	<!--[if lt IE 9]>
		<script src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<![endif]-->
</head>
<body>
	<div id="wrap">
		<!-- header -->
<%-- 		<header>
			<div id="header">
				<div class="head">
					<h1>
						<a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/m/index.do"><img src="/cloud_ver2/new_cloud/images/logo.png" alt="클라우드스토어 씨앗" /></a>
						<a href="/korean/m/communication/BD_index.do" class="myCom">나의<br />커뮤니티</a>
						<c:if test="${empty sessionScope['__usk']}">
							<c:if test="${sslYn eq 'Y'}">
								<a href="https://<%=GlobalConfig.DOMAIN_SUBNM %>:443/korean/pt/login/user/BD_index_m.do" class="login">로그인</a>
							</c:if>
							<c:if test="${sslYn ne 'Y'}">
								<a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/pt/login/user/BD_index_m.do" class="login">로그인</a>
							</c:if>
						</c:if>
						<c:if test="${not empty sessionScope['__usk']}">
							<a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/pt/login/user/ND_logoutAction_m.do" class="logout">[로그아웃]</a>
						</c:if>
					</h1>
				</div>

				<!-- quick -->
				<div class="quick">
					<!-- search -->
					<form class="sech_form" onsubmit="return false">
						<fieldset>
							<legend><span>검색</span></legend>	
							<div class="form" name="searchs" id="searchs"">
								<c:if test="${empty searchKeyword}">
							        <span onkeydown="javascript:if(event.keyCode == 13){ fn_mobMainSearch(); }"><input type="text" class="input" title="검색하실 단어 입력" id="totalKeyword" name="totalKeyword" value="" /></span>
						        </c:if>
						        <c:if test="${not empty searchKeyword}">
						        	<span onkeydown="javascript:if(event.keyCode == 13){ fn_mobMainSearch(); }"><input type="text" class="input" title="검색하실 단어 입력" id="totalKeyword" name="totalKeyword" value="${searchKeyword}" /></span>
						        </c:if>
								<input type="button" onclick="javascript:fn_mobMainSearch();" alt="search" class="btn" title="검색">
							</div>
						</fieldset>
					</form>
					<!-- //search -->
				</div>
				<!-- //quick -->
				
				<div class="navi">
					<ul>
						<c:forEach items="${topMenuList}" var="topMenu" varStatus="topCount">
	                        <c:if test="${topMenu.menuDepth == 1 and topMenu.showYn eq 'Y' and topMenu.parentMenuCode eq 'mobile'}">
		                   		<c:set var="tcnt" value="1" />
		                   		<c:choose>
	                            	<c:when test="${not empty topMenu.userMenuUrl}">
	                                	<c:set var="menuUrl" value="${topMenu.userMenuUrl}" />
	                                </c:when>
	                                <c:otherwise>
		                                <c:if test="${not empty topMenu.childList}">
		                                	<c:forEach items="${topMenu.childList}" var="cMenu" varStatus="cStatus">
		                                    	<c:if test="${cStatus.first}">
		                                        	<c:set var="menuUrl" value="${cMenu.userMenuUrl}" />
		                                        </c:if>
		                                    </c:forEach>
	                                    </c:if>
	                                </c:otherwise>
	                           	</c:choose>
	                            <li <c:if test="${not empty cmsVo.topMenuCode and topMenu.menuCode == cmsVo.topMenuCode}">class="on"</c:if>>
	                            	<a href="<c:url value="${menuUrl}" />" id="<c:out value="${topMenu.menuCode}" />"><c:out value="${topMenu.menuNm}" /></a>
			                 	</li>
			                 	<c:set var="tcnt" value="${tcnt+1}" />
			             	</c:if>
	                    </c:forEach>
					</ul>
				</div>
			</div>
		</header>
		
		 --%>
		
<!-- header -->
<header id="header">
	<h1><a href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/m/index.do"><img src="/cloud_ver3/html_m/images/logo.png" alt="클라우드 스토어 씨앗" /></a></h1>
	<div class="con_search">
		<form><input type="search" placeholder="클라우드 서비스 검색" /><a class="btn_search" href="#none">SEARCH</a></form>
	</div>
</header>
<!-- end : header -->

<!-- nav -->
<nav id="nav">
	<ul>
	<c:forEach items="${topMenuList}" var="topMenu" varStatus="topCount">
          <c:if test="${topMenu.menuDepth == 1 and topMenu.showYn eq 'Y' and topMenu.parentMenuCode eq 'mobile'}">
      		<c:set var="tcnt" value="1" />
      		<c:choose>
              	<c:when test="${not empty topMenu.userMenuUrl}">
                  	<c:set var="menuUrl" value="${topMenu.userMenuUrl}" />
                  </c:when>
                  <c:otherwise>
                   <c:if test="${not empty topMenu.childList}">
                   	<c:forEach items="${topMenu.childList}" var="cMenu" varStatus="cStatus">
                       	<c:if test="${cStatus.first}">
                           	<c:set var="menuUrl" value="${cMenu.userMenuUrl}" />
                           </c:if>
                       </c:forEach>
                      </c:if>
                  </c:otherwise>
             	</c:choose>
              <li <c:if test="${not empty cmsVo.topMenuCode and topMenu.menuCode == cmsVo.topMenuCode}">class="on"</c:if>>
              	<a href="<c:url value="${menuUrl}" />" id="<c:out value="${topMenu.menuCode}" />"><c:out value="${topMenu.menuNm}" /></a>
     	</li>
     	<c:set var="tcnt" value="${tcnt+1}" />
 	</c:if>
   </c:forEach>
	                    
		<!-- <li><a href="#none">SaasS</a></li>
		<li><a href="#none">PaaS</a></li>
		<li><a href="#none">IaaS</a></li>
		<li><a href="#none">클라우드 허브</a></li>
		<li><a href="#none">씨앗소식</a></li>
		<li><a href="#none">씨앗소개</a></li> -->
	</ul>
</nav>
<!-- end : nav -->

		<!-- //header -->

		<!-- //container -->
		<decorator:body />
		<!-- //container -->


<!-- footer -->
<footer id="footer">
	<ul class="txt_footer">
		<li>씨앗 고객센터 : 1522-0089(평일 9:00~18:00)</li>
		<li>이메일 : ceart@ceart.kr</li>
	</ul>
	<ul class="link_footer">
	<li><a href="/kor/userGuide/m_termsofuse.jsp">서비스 이용약관</a> | <a href="/kor/userGuide/m_privacypolicy.jsp">개인정보 처리방침</a> | <a href="http://www.ceart.kr/korean/pt/index.do">PC버전 보기</a></li>
<!-- 		<li><a href="#">서비스 이용약관</a></li>
		<li><a href="#">개인정보 처리방침</a></li> -->
	</ul>
	<address>
		<p>대구광역시 동구 첨단로 53 (41068)<br />서울사무소 : 서울특별시 중구 청계천로 14 (04520)</p>
		<p>Copyright 2018 한국정보화진흥원 All Rights Reserved</p>
	</address>
</footer>
<!-- end : footer -->

		<!-- <!-- footer -->
		<!-- <footer>
			<div id="footer">
				<div class="foot-area">
					quick
					<div class="quick">
						<a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1007">이벤트</a>
						<a href="/korean/m/board/BD_board.list.do?domainCd=2&amp;bbsCd=1001">공지사항</a>
						<a href="/mob/userGuide/roadmap_dg.jsp">오시는길</a>
						<a href="http://www.seart.kr/m" class="new">씨앗소프트웨어</a>
						<a href="/korean/pt/index.do"class="new">PC버전</a>					
					</div>
					//quick
					<address>
						<p><strong>본원</strong><span>대구광역시 동구 첨단로 53 (41068)</span></p>
						<p><strong>서울사무소</strong><span>서울특별시 중구 청계천로 14 (04520)</span></p>					
						<p><strong>대표전화</strong><span><a href="tel:1522-0089">1522-0089</a></span><strong>이메일</strong><span><a href="mailto:ceart@ceart.kr">ceart@ceart.kr</a></span></p>
						<p><strong>개인정보보호 책임자</strong><span>경영기획실장</span></p>
						<p>Copyright 2015 한국정보화진흥원 All Rights Reserved.</p>
					</address>
				</div>
				select box
				
				<div class="section">
					<div class="box ar">
						구글번역
						<div id="google_translate_element" class="google"></div>
						<script type="text/javascript">
						function googleTranslateElementInit() {
						    new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'en,ja,ko', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: true, multilanguagePage: true}, 'google_translate_element');
							//new google.translate.TranslateElement({pageLanguage: 'ko', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
						}
						</script>
						<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
						//구글번역
					</div>
				</div>
				
				//select box
				<p class="copyright">Copyright © 한국정보화진흥원 All Rights Reserved.</p>
			</div>
		</footer> -->
		<!-- //footer -->
	</div>
</body>
</html>