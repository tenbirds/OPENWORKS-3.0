<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <form name="dataForm" id="dataForm" method="get" action="PD_pollResponseList.do">
        <!-- 기본 검색 항목 -->
        <input type="hidden" name="q_currentPage" value='<c:out value="${param.q_currentPage}" default="1" />' />
        <input type="hidden" name="q_rowPerPage" value='<c:out value="${param.q_rowPerPage}" default="10" />' />
        <input type="hidden" name="q_seq" value='<c:out value="${param.seq}" />' />

        <!-- 목록 테이블 -->
        <table class="boardList"  border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="40" id="td-SEQ" />
                <col id="td-TITLE" />
                <col width="60" id="td-REG_NM" />
                <col width="60" id="td-REG_TIME" />
            </colgroup>
            <thead>
                <tr>
                    <th id="th-SEQ"><span><a href="#hh" onclick="jsSortAction('seq'); return false;" >순번</a></span></th>
                    <th id="th-TITLE"><span><a href="#hh" onclick="jsSortAction('title'); return false;" >내용</a></span></th>
                    <th id="th-REG_NM"><span><a href="#hh" onclick="jsSortAction('regId'); return false;" >등록자</a></span></th>
                    <th id="th-REG_TIME" class="no-bg"><span><a href="#hh" onclick="jsSortAction('regDt'); return false;" >등록일</a></span></th>
                </tr>
            </thead>

            <tbody id="odd-color">
            <!-- 게시물 목록 -->
            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="pollVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td class="a-left"></td>
                    <td>${pollVo.regNm}</td>
                    <td>${pollVo.regDt}</td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="4" />

            </tbody>
        </table>

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    </form>