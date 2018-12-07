<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${not empty RPP_NUM}">
		<span class="totalcount">
			<c:if test="${not empty paggingTitle}">
				${paggingTitle},
			</c:if>
			Total <em class="tx_orange">${pager.totalNum}</em>
		</span>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${searchMap.q_rowPerPage}" />
	</c:otherwise>
</c:choose>
<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='${searchMap.q_currPage}'/>"/>
<input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value='${searchMap.q_sortName}'/>" />
<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value='${searchMap.q_sortOrder}'/>"/>
