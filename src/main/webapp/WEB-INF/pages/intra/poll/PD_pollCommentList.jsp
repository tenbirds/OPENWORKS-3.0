<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title>설문 상세</title>

    <op:jsTag type="openworks" items="form" />

    <script type="text/javascript" src="<c:url value="/resources/intra/poll/poll.manage.js" />"></script>

    <script type="text/javascript">
        $().ready( function() {
        });
    </script>

</head>

<body>

    <!-- 검색 폼 -->
    <form name="dataForm" id="dataForm" method="get" action="PD_pollCommentList.do">
        <!-- 기본 검색 항목 -->
        <input type="hidden" name="q_seq" value='<c:out value="${param.q_seq}" />' />
        <input type="hidden" name="q_groupSeq" value='<c:out value="${param.q_groupSeq}" />' />
        <c:if test="${not empty param.q_itemSeq}">
            <input type="hidden" name="q_itemSeq" value='<c:out value="${param.q_itemSeq}" />' />
        </c:if>

        <%-- 페이징 관련 파라미터 생성.--%>
        <op:pagerParam title="설문 의견 목록" />

    </form>

        <!-- 목록 테이블 -->
        <table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="40" id="td-SEQ" />
                <col id="td-TITLE" />
                <col width="60" id="td-REG_NM" />
                <col width="120" id="td-REG_TIME" />
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
            <c:forEach items="${pager.list}" var="pollCommentVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td class="tl">${pollCommentVo.etcComments}</td>
                    <td>${pollCommentVo.regNm} ${pollCommentVo.regId}</td>
                    <td>${pollCommentVo.regTime}</td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="4" />

            </tbody>
        </table>

        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

</body>
</html>