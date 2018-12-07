<%@page import="java.util.Enumeration"%>
<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<h4 class='tx_13' id="sub_title"></h4>
<!-- 검색 -->
<div class='search'>
    <fieldset>
        <label class='tx_b'>
<!--             도메인 :  --> 
        </label>
        <c:if test="${searchVo.analyzeId eq 'resourceTheme'}">
        	<label class='tx_b'>분야선택 : </label>
	        <select id='prvCode' name='prvCode' class='over mar_r20'>
	        		<option value='' <c:if test="${empty searchVo.prvCode}">selected='selected'</c:if>>분야선택</option>
	        	<c:forEach items='${codeList}' var='data' varStatus='idx'>
	            	<option value='<c:out value='${data.prvCd}'/>' <c:if test="${data.prvCd eq searchVo.prvCode}">selected='selected'</c:if>><c:out value='${data.prvNm}'/>(<c:out value='${data.prvCd}'/>)</option>
	            </c:forEach>
	        </select>
        </c:if>
        <label class='tx_b'>기간설정 : </label>
        <input type='text' id='startDate' name='startDate' class='w120' value='<c:out value='${searchVo.startDateFmt}'/>' title='시작일'/>
        ~ 
        <input type='text' id='endDate' name='endDate' class='w120' value='<c:out value='${searchVo.endDateFmt}'/>' title='날짜선택'/>
        <button class='gray mar_l5 mar_b5' onclick='search();'>검색</button>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button id="d-0" class='s_blue mar_l5 mar_b5'>당일</button>
        <button id="d-1" class='s_blue mar_l5 mar_b5'>전일</button>
        <button id="d-7" class='s_blue mar_l5 mar_b5'>7일</button>
        <button id="m-1" class='s_blue mar_l5 mar_b5'>1개월</button>
        <button id="m-3" class='s_blue mar_l5 mar_b5'>3개월</button>
        <button class='s_blue mar_l20 mar_b5' onclick="jsExcelView()">엑셀저장</button>
        <c:if test="${searchVo.analyzeId eq 'resourceUser'}">
        <label class='tx_b'>사용자 ID : </label>
        <input class='w120' id='searchText' type='text' value='<c:out value="${searchVo.searchText }"/>' name='searchText' title='검색어를 입력하세요.'/>
        <button class='gray mar_l5 mar_b5' onclick="search();">검색</button>
        </c:if>
    </fieldset>
</div>
<form id="excelForm" action=".">
    <%
    Enumeration<String> en = request.getParameterNames();
    while(en.hasMoreElements()) {
    	String paramName = en.nextElement();
    	out.println(String.format("<input type='hidden' name='%s' value='%s'/>", paramName, request.getParameter(paramName)));
    }
    %>
</form>
<!-- //검색 -->