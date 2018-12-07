<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

	<c:set var="pagez" value="${pager.pages}" />

	<div class="paging">
	<c:choose>
		<c:when test="${pager.totalPage > 1}">
			<c:if test="${!pager.startPagePart}">
				<a href="#" onclick="${script}(1); return false;" class="p_gray" title="처음페이지로 가기">First</a>
				<a href="#" onclick="${script}(${pager.previousPartLastPage}); return false;" class="p_gray" title="이전페이지로 가기">Prev</a>
			</c:if>
	
			<c:forEach items="${pagez}" var="pages">
				<c:if test="${pages eq pager.currPage}">
					<span title="현재 ${pages} 페이지">${pages}</span>
				</c:if>
				<c:if test="${pages ne pager.currPage}">
					<a href="#" onclick="${script}(${pages}); return false;" title="${pages} 페이지">${pages}</a>
				</c:if>
			</c:forEach>
	
			<c:if test="${!pager.lastPagePart}">
				<a href="#" onclick="${script}(${pager.nextPartFirstPage}); return false;" class="p_gray" title="다음페이지로 가기">Next</a>
				<a href="#" onclick="${script}(${pager.lastPage}); return false;" class="p_gray" title="마지막페이지로 가기">End</a>
			</c:if>
	
			<fieldset>
				<legend>페이지이동</legend>
				<label class="skip" for="pageGo">페이지이동</label>
				<input type="text" value="" id="txtMovePage" name="txtMovePage" class="w55 vm" title="이동할페이지를 입력하세요" /> page
				<button class="gray mar_l5 vm" onclick="${script}($('#txtMovePage').val()); return false;">이동</button>
			</fieldset>
		</c:when>
		<c:otherwise>
			<span title="현재 1 페이지">1</span>
		</c:otherwise>
	</c:choose>
	</div>
