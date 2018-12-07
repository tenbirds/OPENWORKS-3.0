<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pagez" value="${pager.pages}" />
<div class="paging">
	<c:choose>
		<c:when test="${pager.totalPage > 1}">
			<c:if test="${!pager.startPagePart}">
				<a href="#" onclick="${script}(1); return false;" class="goFist" title="처음페이지로 가기"><img src="/resources/web/theme/default/images/btn/btn_paging_first.gif" alt="처음페이지"/></a>
<%-- 				<a href="#" onclick="${script}(${pager.previousPartLastPage}); return false;" title="이전페이지로 가기" class="prev"><img src="/resources/web/theme/default/images/btn/btn_paging_prev.gif" alt="이전페이지"/></a>
 --%>			</c:if>
			<c:if test="${pager.previousPage}">
			</c:if>
			<span>
			<c:forEach items="${pagez}" var="pages" varStatus="status">
				<c:if test="${pages == pager.currPage}">
					<a href="#" title="현재 ${pages} 페이지" class="on">${pages}</a>
				</c:if>
				<c:if test="${pages != pager.currPage}">
					<a href="#" onclick="${script}(${pages}); return false;" title="${pages} 페이지">${pages}</a>
				</c:if>
			</c:forEach>
			</span>
			<c:if test="${pager.nextPage}">
			</c:if>
			<c:if test="${!pager.lastPagePart}">
<%-- 				<a href="#" onclick="${script}(${pager.nextPartFirstPage}); return false;" title="다음페이지로 가기" class="next"><img src="/resources/web/theme/default/images/btn/btn_paging_next.gif" alt="다음페이지"/></a>
 --%>				<a href="#" onclick="${script}(${pager.lastPage}); return false;" class="goLast" title="마지막페이지로 가기"><img src="/resources/web/theme/default/images/btn/btn_paging_end.gif" alt="마지막페이지"/></a>
			</c:if>
		</c:when>
		<c:otherwise>
		<span>
			<a href="#" title="현재 1 페이지" class="on">1</a>
		</span>	
		</c:otherwise>
	</c:choose>
</div>

	
		