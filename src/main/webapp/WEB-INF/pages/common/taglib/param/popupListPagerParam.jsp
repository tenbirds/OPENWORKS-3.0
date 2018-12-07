<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

        <div class="po_rel">
            <c:choose>
                <c:when test="${not empty RPP_NUM}">
                <h2 class="">
                    <c:if test="${not empty paggingTitle}">
                    ${paggingTitle}
                    </c:if>
                </h2>
    
                <fieldset class="h4_r">
                    <legend>페이지당 목록갯수 선택</legend>
                    <label for="boardsearch">페이지당 목록</label>
                    <select name='q_rowPerPage' id='q_rowPerPage'>
                        <c:forEach items="${RPP_NUM}" var="rppNum">
                            <option value="${rppNum}" <c:if test="${rppNum eq searchMap.q_rowPerPage}">selected="selected"</c:if>>${rppNum}</option>
                        </c:forEach>
                    </select>
                    <button class="gray">변경</button>
                </fieldset>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="q_rowPerPage" id="q_rowPerPage" value="${searchMap.q_rowPerPage}" />
                </c:otherwise>
            </c:choose>
            <input type="hidden" name="q_currPage" id="q_currPage" value="${searchMap.q_currPage}" />
            <input type="hidden" name="q_sortName" id="q_sortName" value="${searchMap.q_sortName}" />
            <input type="hidden" name="q_sortOrder" id="q_sortOrder" value="${searchMap.q_sortOrder}" />
        </div>