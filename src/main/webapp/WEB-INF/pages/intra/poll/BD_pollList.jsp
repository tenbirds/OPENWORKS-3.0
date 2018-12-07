<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>설문 목록 조회</title>

    <op:jsTag type="spi" items="highlight, datepicker, colorbox" />
    <op:jsTag type="openworks" items="ui" />

    <script type="text/javascript" src="<c:url value="/resources/intra/poll/poll.manage.js" />"></script>

    <!-- 사용자 스크립트 시작  -->    
    <script type="text/javascript">

    $().ready( function() {
        <c:if test="${not empty param.q_startTime or not empty param.q_endTime}">
                jsToggleSearchOption();
        </c:if>
        // 검색 날짜 입력
        $('#q_startTime').datepicker({dateFormat:"yy-mm-dd"});
        $('#q_endTime').datepicker({dateFormat:"yy-mm-dd"});   
    });

    </script>
    <!-- 사용자 스크립트 끝  -->

</head>

<body>

    <!-- 컨텐츠영역 -->
    <div id="content">

        <!-- 검색 폼 -->
        <form name="dataForm" id="dataForm" method="get" onsubmit="return jsPollSearch();">

            <!-- 상세화면 이동시 조건 항목 -->
            <input type="hidden" name="q_seq" value="" />

        <!-- 검색 영역 시작 -->
        <div class="search" id="Search_Menu_div" >

            <c:choose>
                <c:when test="${isSuper}">
                    <select name="q_domainCd" id="q_domainCd" class="input-select" title="선택">
                        <option value="">-- 도메인 선택 --</option>
                        <c:forEach items="${domainList}" var="domain">
                        <option value="${domain.domainCd}" <c:if test="${domain.domainCd eq param.q_domainCd}">selected='selected'</c:if>>${domain.domainNm}</option>
                        </c:forEach>
                    </select>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="q_domainCd" value="${param.q_domainCd}" />
                </c:otherwise>
            </c:choose>

            <select name="q_openYn" id="q_openYn" class="input-select" title="선택">
                <option value="">-- 공개여부 --</option>
                <option value="Y" <c:if test="${param.q_openYn eq 'Y'}">selected="selected"</c:if>>공개</option>
                <option value="N" <c:if test="${param.q_openYn eq 'N'}">selected="selected"</c:if>>미공개</option>
            </select>

            <input type="text" name="q_title" id="q_title" value="${param.q_title}" />

            <button type="button" class="gray" onclick="jsPollSearch();">검색</button>
            <button type="button" class="gray" onclick="jsToggleSearchOption(this);">검색옵션</button>
            <button type="button" class="gray" onclick="jsPollSearchReset();">초기화</button>

            <!-- 검색 옵션 시작 -->
            <div id="SearchOptionDiv" class="mar_t5 none">
                <input type="text" id="q_startTime" name="q_startTime" class="w80" value="${param.q_startTime}" maxlength='8' /> ~ 
                <input type="text" id="q_endTime" name="q_endTime" class="w80" value="${param.q_endTime}" maxlength='8' />&nbsp;

                <button type="button" class="gray" onclick="jsSetDay(0, 1, 0);">오늘</button>
                <button type="button" class="gray" onclick="jsSetDay(0, 2, 0);">1일</button>
                <button type="button" class="gray" onclick="jsSetDay(0, 7, 0);">7일</button>
                <button type="button" class="gray" onclick="jsSetDay(0, 10, 0);">10일</button>
                <button type="button" class="gray" onclick="jsSetDay(0, 15, 0);">15일</button>
                <button type="button" class="gray" onclick="jsSetDay(1, 1, 0);">1개월</button>
                <button type="button" class="gray" onclick="jsSetDay(3, 1, 0);">3개월</button>
                <button type="button" class="gray" onclick="jsSetDay(6, 1, 0);">6개월</button>
                <button type="button" class="gray" onclick="jsSetDay(-1, 1, 0);">전체</button>
            </div>
            <!-- 검색 옵션 끝 -->

        </div>
        <!-- 검색 영역 끝 -->

        <%-- 페이징 관련 파라미터 생성.--%>
        <op:pagerParam title="설문 목록" />

        </form>

        <!-- 목록 삽입. -->
        <%@include file="INC_listTable.jsp" %>

        </div>

        <!-- 페이징 -->
        <op:pager pager="${pager}" script="jsPollList" />
        <!-- //페이징 -->

        <!-- 버튼 -->
        <div class="btn_r">
            <button class="w_blue" type="button" onclick="jsPollInsertForm();">등록</button>
        </div>
        <!-- //버튼 -->

</body>
</html>
