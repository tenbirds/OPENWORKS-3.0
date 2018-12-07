<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title>설문 상세</title>

    <op:jsTag type="spi" items="datepicker, colorbox, validate, form" />

    <script type="text/javascript" src="<c:url value="/resources/intra/poll/poll.manage.js" />"></script>

    <script type="text/javascript">
    $().ready( function() {

        jsPollUpdate();
        jsPollGroupInsert();
        jsPollGroupModify();
        jsDupCheck();

        // 검색 날짜 입력
        $('#q_startTime').datepicker({dateFormat:"yymmdd"});
        $('#q_endTime').datepicker({dateFormat:"yymmdd"});

        $('#startTime').datepicker({dateFormat:"yymmdd"});
        $('#endTime').datepicker({dateFormat:"yymmdd"}); 

    });

    </script>

</head>

<body>

    <c:choose>
        <c:when test="${dataVo.startYn eq 'N'}">
            <!-- 설문정보 등록/수정 -->
            <%@include file="INC_writeTable.jsp" %>
            <!-- 설문그룹 등록 폼 -->
            <%@include file="INC_groupTable.jsp" %>
            <!-- 설문항목 수정 -->
            <%@include file="INC_itemModifyTable.jsp" %>
        </c:when>
        <c:when test="${dataVo.startYn eq 'Y'}">
            <!-- 설문정보 상세 -->
            <%@include file="INC_viewTable.jsp" %>
            <!-- 등록된 아이템 목록 -->
            <%@include file="INC_itemViewTable.jsp" %>
        </c:when>        
    </c:choose>

</body>
</html>
