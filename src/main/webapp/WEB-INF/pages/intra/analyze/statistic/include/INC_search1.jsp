<%@page import="java.util.Enumeration"%>
<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<h4 class='tx_13' id="sub_title"></h4>
<!-- 검색 -->
<div class='search'>
    <fieldset>
        <label class='tx_b'>
            도메인 : 
        </label>
        <select id='domain' name='domain' class='over mar_r20'>
            <c:forEach var="domainVo" items="${domainList}">
	            <option value='${domainVo.domainNm}' <c:if test="${param.domain eq domainVo.domainNm}">selected='selected'</c:if>>${domainVo.domainNm}</option>
            </c:forEach>
        </select>
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