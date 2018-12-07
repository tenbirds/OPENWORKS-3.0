<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>유효기간 설정 관리</title>
    <op:jsTag type="spi" items="ui,validate,form"/>
    
    <script type="text/javascript">
    <!--
    
    $().ready(function () {
        
    });
    
    //-->
    </script>
</head>

<body>

<h2>유효기간 설정</h2>
<div id="popup">
<form name="pagingForm" id="pagingForm" method="post" action="PD_setExpDatePop.do">
	<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
	<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
	<input type="hidden" name="q_currPage" value="${param.q_currPage}" />
	<input type="hidden" name="q_sortName" value="" />
	<input type="hidden" name="q_sortOrder" value="" />
	<input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
</form>
<form name="dataForm" id="dataForm" method="post" action="PD_setExpDatePop.do">
    <op:pagerParam title="유효기간설정" />
</form>

	<table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="10%" />
            <col width="45%" />
            <col width="15%" />
            <col width="15%" />
            <col width="15%" />
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>적용시작일</th>
                <th>유효기간</th>
                <th>등록자</th>
                <th class="lr_none">수정자</th>
            </tr>
        </thead>
        <tbody id="odd-color">
        
            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="list" varStatus="status">
                <tr>
                    <td>
                        ${index-status.index}
                    </td>
                    <td>
                    	<a href="PD_setExpDateForm.do?seqNo=${list.seqNo}">
                            ${list.appStDate}
                        </a>
                    </td>
                    <td>
                    	<c:choose>
                    		<c:when test="${not empty list.expDt and list.expDt ne 100}">${list.expDt} 년</c:when>
                    		<c:when test="${not empty list.expDt and list.expDt eq 100}">제한없음</c:when>
                    	</c:choose>
                    </td>
                    <td>
                    	${list.regId}
                    </td>
                    <td class="lr_none">
                    	${list.modId}
                    </td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="5" />
        </tbody>
    </table>
    
    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <c:if test="${empty pager.list}">
	    <p class="tx_c mar_t20">
	        <button class="blue" type="button" onclick="location.href='PD_setExpDateForm.do'">등록</button>
	        <button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">취소</button>
	    </p>
    </c:if>
    
</div>
</body>
</html>
                    