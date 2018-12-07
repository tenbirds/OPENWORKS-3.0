<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>SITE MAP | 클라우드스토어 씨앗</title>
	<script type="text/javascript">
	
	</script>
</head>
<body>
	<!-- container -->
	<div id="container" class="join-wrap">	
		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
				<div class="title-area">
					<h2>사이트맵</h2>
				</div>
			<!-- //title-area -->
				
			<!-- div class="visual">
				<img src="/resources/web/theme/default/images/info/sitemap_visu.jpg" alt="씨앗 마켓 사이트맵 전체보기" />
			</div -->
			
			<div class="section">
					<div class="join-area">
						<!-- sitemap -->
						<div class="sitemap">
							<div class="fl">
							<c:forEach items="${CmsMenuList}" var="siteMenu1">
								<c:if test="${siteMenu1.menuDepth == 1 && siteMenu1.showYn eq 'Y' && (siteMenu1.sortOrder == 1 || siteMenu1.sortOrder == 2 || siteMenu1.sortOrder == 3 )}">
								    <dl>
								     <dt><c:out value="${siteMenu1.menuNm}" /></dt>
										<dd>
											<ul>
												<li><a href="<c:url value="${siteMenu1.userMenuUrl}" />">전체</a></li>
												<c:forEach items="${ctgryList}" var="ctgryList">
												<c:if test="${ctgryList.ctgryClCd == '1002' and siteMenu1.menuNm eq 'SaaS'}">
												<li><a href="${siteMenu1.userMenuUrl}&ctgryCode=${ctgryList.ctgryCode}&ctgryParentCode=${ctgryList.ctgryCode}">${ctgryList.langCtgryNm}</a></li>
												</c:if>
												<c:if test="${ctgryList.ctgryClCd == '1001' and siteMenu1.menuNm eq 'PaaS'}">
												<li><a href="${siteMenu1.userMenuUrl}&ctgryCode=${ctgryList.ctgryCode}&ctgryParentCode=${ctgryList.ctgryCode}">${ctgryList.langCtgryNm}</a></li>
												</c:if>
												<c:if test="${ctgryList.ctgryClCd == '1003' and siteMenu1.menuNm eq 'IaaS'}">
												<li><a href="${siteMenu1.userMenuUrl}&ctgryCode=${ctgryList.ctgryCode}&ctgryParentCode=${ctgryList.ctgryCode}">${ctgryList.langCtgryNm}</a></li>
												</c:if>
												</c:forEach>
											</ul>
										</dd>
									</dl>	
								</c:if>
							</c:forEach>
							<!-- {{ // 소개 -->
							<c:forEach items="${CmsMenuList}" var="siteMenu2">
							<c:if test="${siteMenu2.menuDepth == 1 && (siteMenu2.menuCode eq 'introduction')}">								
									<c:set var="pMenuCd2" value="${siteMenu2.menuCode}" />
								<dl>
									<dt><c:out value="${siteMenu2.menuNm}" /></dt>
									<dd><ul><c:forEach items="${CmsMenuList}" var="siteSubMenu2">
											<c:if test="${siteSubMenu2.menuDepth == 2 && pMenuCd2 eq siteSubMenu2.parentMenuCode}">
												<c:set var="pSubMenuCd2" value="${siteSubMenu2.menuCode}" />
													<li><a href="<c:url value="${siteSubMenu2.userMenuUrl}" />"><c:out value="${siteSubMenu2.menuNm}" /></a></li>
													</c:if>
											</c:forEach>
										</ul>
								  	</dd>	
								</dl>
							</c:if>
							</c:forEach>
							<!-- {{ //스토어, 커뮤니케이션-->
							
							<!-- {{ 회원, 공지사항, 고객센터 -->
							<c:forEach items="${CmsMenuList}" var="siteMenu3"> <!-- || 회원 가입 빠짐   //-->
							<c:if test="${siteMenu3.menuDepth == 1 && (siteMenu3.menuCode eq 'member' || siteMenu3.menuCode eq 'notice' || siteMenu3.menuCode eq 'customerService')}">
								<c:set var="pMenuCd3" value="${siteMenu3.menuCode}" />
								<dl>
									<dt><c:out value="${siteMenu3.menuNm}" /></dt>
									<c:if test="${siteMenu3.menuCode ne 'notice'}">
										<dd>
											<ul><c:forEach items="${CmsMenuList}" var="siteSubMenu3">
													<c:if test="${siteSubMenu3.menuDepth == 2 && pMenuCd3 eq siteSubMenu3.parentMenuCode}">
														<c:set var="pSubMenuCd3" value="${siteSubMenu3.menuCode}" />
															<li><a href="<c:url value="${siteSubMenu3.userMenuUrl}" />"><c:out value="${siteSubMenu3.menuNm}" /></a></li>
													</c:if>
												</c:forEach></ul>
									</c:if>
									<c:if test="${siteMenu3.menuCode eq 'notice'}">
										<dd>
											<ul>
											<li><a href="<c:url value="${siteMenu3.userMenuUrl}" />"><c:out value="${siteMenu3.menuNm}" /></a></li>
										</ul>
									</c:if>
								</dl>
							</c:if>
							</c:forEach>
							<!-- }}  -->
							<!-- {{ //스토어, 소개, 커뮤니케이션-->
							<c:forEach items="${CmsMenuList}" var="siteMenu2">
							<c:if test="${siteMenu2.menuDepth == 1 && (siteMenu2.menuCode eq 'communication')}">								
									<c:set var="pMenuCd2" value="${siteMenu2.menuCode}" />
								<dl>
									<dt><c:out value="${siteMenu2.menuNm}" /></dt>
									<dd><ul><c:forEach items="${CmsMenuList}" var="siteSubMenu2">
											<c:if test="${siteSubMenu2.menuDepth == 2 && pMenuCd2 eq siteSubMenu2.parentMenuCode}">
												<c:set var="pSubMenuCd2" value="${siteSubMenu2.menuCode}" />
													<li><a href="<c:url value="${siteSubMenu2.userMenuUrl}" />"><c:out value="${siteSubMenu2.menuNm}" /></a></li>
													</c:if>
											</c:forEach>
										</ul>
								  	</dd>	
								</dl>
							</c:if>
							</c:forEach>
							<!-- {{ //스토어, 커뮤니케이션-->
							</div>	<!-- {{마이페이지, 판매하기  -->
							<div class="fr">
								<c:forEach items="${CmsMenuList}" var="siteMenu4">
										<c:if test="${siteMenu4.menuDepth == 1 && (siteMenu4.menuCode eq 'myPage' || siteMenu4.menuCode eq 'forSale')}">
												<dl><c:set var="pMenuCd4" value="${siteMenu4.menuCode}" />
												<dt><c:out value="${siteMenu4.menuNm}" /></dt>
											 	<dd><c:forEach items="${CmsMenuList}" var="siteSubMenu4">
														<c:if test="${siteSubMenu4.menuDepth == 2 && siteSubMenu4.showYn eq 'Y' && pMenuCd4 eq siteSubMenu4.parentMenuCode}">
															<c:set var="pSubMenuCd4" value="${siteSubMenu4.menuCode}" />
															<dl><dt><a href="<c:url value="${siteSubMenu4.userMenuUrl}" />"><c:out value="${siteSubMenu4.menuNm}" /></a></dt>
																<dd>
																	<ul>
																	<c:forEach items="${CmsMenuList}" var="siteChildMenu4">
						                               					<c:if test="${siteChildMenu4.menuDepth == 3 && pSubMenuCd4 eq siteChildMenu4.parentMenuCode}">
																			<li><a href="<c:url value="${siteChildMenu4.userMenuUrl}" />"><c:out value="${siteChildMenu4.menuNm}" /></a></li>
																		</c:if>
																	</c:forEach>
																	</ul>
																</dd>
															</dl>
														</c:if>
													</c:forEach>
												</dd></dl>	
											</c:if>
										</c:forEach>
								
							</div><!--}}  -->
					  </div>
					</div>
			</div>		
		</div>						
	</div>
	<!-- //container -->
</body>
</html>
