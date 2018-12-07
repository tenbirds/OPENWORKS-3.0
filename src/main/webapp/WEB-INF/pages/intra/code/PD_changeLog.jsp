<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
<op:jsTag type="spi" items="jquery" />

<script type="text/javascript">
    $().ready(function() {

    });

    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $('#sForm input[name=q_currPage]').val(p);
        $('#sForm').submit();
    };
</script>
</head>

<body>
    <!-- 검색-->
    <form id="sForm" method="post" action="PD_changeLog.do">
    <input type="hidden" name="langCode"   	id="langCode"	value="${param.langCode}"/>
    <input type="hidden" name="grpCd"      	id="grpCd"   	value="${param.grpCd}"/>
    <input type="hidden" name="q_currPage"              	value="${param.q_currPage}" />
    <input type="hidden" name="q_rowPerPage"            	value="${param.q_rowPerPage}" />

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
        <caption class="hidden">목록</caption>
        <colgroup>
            <col width="8%"  />
            <col width="20%" />
            <col width=""    />
            <col width="15%" />
            <col width="20%" />
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>구분</th>
                <th>변경내용</th>
                <th>수정자</th>
                <th class="lr_none">변경일자</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="changeLog" varStatus="status">
            <tr>
                <td>${index-status.index}</td>
                <c:choose>
                    <c:when test="${not empty changeLog.changeType}">
                        <td>${changeLog.changeType}</td>
                        <td>${changeLog.changeResutl}</td>
                    </c:when>
                    <c:otherwise>
                        <td>단순변경</td>
                        <td>변경없음</td>
                    </c:otherwise>
                </c:choose>
                <td>${changeLog.modId}</td>
                <td class="lr_none">${changeLog.logDt}</td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="5" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
    </form>
</body>
</html>