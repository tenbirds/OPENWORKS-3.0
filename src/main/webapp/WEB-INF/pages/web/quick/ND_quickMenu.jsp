<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty quickMenu}">
<ul>
	<c:forEach items="${quickMenu}" var="_bean" varStatus="status">
		<c:if test="${not empty _bean.filePath}">
			<li>
				<c:if test="${not empty _bean.linkUrl}"><a href="${_bean.linkUrl}" target="${_bean.linkType}" title="${linkType.bannerDesc}"></c:if>
				<img src="${_bean.filePath}" alt="${_bean.imgAlt}" width="60" />
				<c:if test="${not empty _bean.linkUrl}"></a></c:if>
			</li>
		</c:if>
	</c:forEach>
</ul>
<span><a href="#top"><img src="/resources/web/theme/default/images/common/btn_top.gif" alt="맨위로가기" /></a></span>
</c:if>