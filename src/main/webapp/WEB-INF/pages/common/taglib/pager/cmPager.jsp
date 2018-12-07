<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pagez" value="${pager.pages}" />

<div class="paging">
	<c:choose>
		<c:when test="${pager.totalPage > 1}">
			<c:if test="${!pager.startPagePart}">
				<a href="#" onclick="${script}(1); return false;" title="처음페이지로 가기"><img src="/resources/cmmnty/default/images/btn/btn_paging_first.gif"  alt="처음" /></a>
				<a href="#" onclick="${script}(${pager.previousPartLastPage}); return false;" title="이전페이이지로 가기" class="prev"> <img src="/resources/cmmnty/default/images/btn/btn_paging_prev.gif" alt="이전"></a>
			</c:if>

			<c:forEach items="${pagez}" var="pages" varStatus="status">
				<c:if test="${pages eq pager.currPage}">
					<a href="#" title="현재 ${pages} 페이지" class="on"><strong>${pages}</strong></a>
				</c:if>
				<c:if test="${pages ne pager.currPage}">
					<a href="#" onclick="${script}(${pages}); return false;" title="${pages} 페이지">${pages}</a>
				</c:if>
				<c:if test="${!status.last}"> <span>&nbsp;</span> </c:if>
			</c:forEach>

			<c:if test="${!pager.lastPagePart}">
				<a href="#" onclick="${script}(${pager.nextPartFirstPage}); return false;"  class="next" title="다음페이지로 가기"><img src="/resources/cmmnty/default/images/btn/btn_paging_next.gif" alt="다음"></a>
				<a href="#" onclick="${script}(${pager.lastPage}); return false;" title="마지막페이지로 가기"><img src="/resources/web/theme/default/images/btn/btn_paging_l.gif" alt="끝" /></a>
			</c:if>

<!-- 			<fieldset> -->
<!-- 				<legend>페이지이동</legend> -->
<!-- 				<input type="text" value="" id="txtMovePage" name="txtMovePage" class="w30 vm" title="이동할페이지를 입력하세요" /> page -->
<%-- 				<input type="image" alt="이동" src="/resources/web/theme/default/images/btn/btn_g_move.gif" onclick="${script}($('#txtMovePage').val()); return false;" /> --%>
<!-- 			</fieldset> -->
		</c:when>
		<c:otherwise>
			<a href="#" title="현재 1 페이지" class="on"><strong>1</strong></a>
		</c:otherwise>
	</c:choose>
</div>