<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${not empty RPP_NUM}">
		<span class="totalcount">
			<c:if test="${not empty paggingTitle}">
				${paggingTitle},
			</c:if>
			Total <em class="orange">${pager.totalNum}</em>
		</span>
		
        <div class="select list" style="width:100px;">
            <select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" onchange="this.form.submit()" style="width:100px;z-index:5">
                <c:forEach items="${RPP_NUM}" var="rppNum">
                    <option value="${rppNum}" <c:if test="${rppNum eq searchMap.q_rowPerPage}">selected="selected"</c:if>>${rppNum}</option>
                </c:forEach>
            </select>
        </div>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${searchMap.q_rowPerPage}" />
	</c:otherwise>
</c:choose>
<input type="hidden" name="q_currPage" id="q_currPage" value="${searchMap.q_currPage}" />
<input type="hidden" name="q_sortName" id="q_sortName" value="${searchMap.q_sortName}" />
<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="${searchMap.q_sortOrder}" />