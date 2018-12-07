<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구조건</h3>
<table class="tbl_st1">
	<thead>
		<tr>
			<th>단위</th>
			<th>제공용량</th>
			<th>단가</th>
			<th>제공방법</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach items="${sassI}" var="sassI" varStatus="status">
	        <c:choose>
                <c:when test="${sassI.consumerYn eq 'Y'}">
		<tr>
			<td><c:if test="${sassI.unitSys ne '1006'}">${sassI.unitSysNm}&nbsp;</c:if><c:if test="${sassI.unitSys eq '1006'}">${sassI.etcUnitSys}&nbsp;</c:if></td>
			<td>${sassI.captySys}&nbsp;</td>
			<td>${sassI.amountSys}&nbsp;</td>
			<td>${sassI.splyMothSysNm}&nbsp;</td>
		</tr>
                </c:when>
            </c:choose>
	    </c:forEach>
	</tbody>
</table>

<table class="tbl_st1 mt20">
	<thead>
		<tr>
			<th>옵션명</th>
			<th>단위</th>
			<th>제공용량</th>
			<th>단가</th>
			<th>설명</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach items="${sassD}" var="sassD" varStatus="status">
	        <c:choose>
                <c:when test="${sassD.consumerYn eq 'Y'}">
		<tr>
			<td>${sassD.optionNm}&nbsp;</td>
			<td>${sassD.unitItem}&nbsp;</td>
			<td>${sassD.captyItem}&nbsp;</td>
			<td>${sassD.amountItem}&nbsp;</td>
			<td>${sassD.cmntItem}&nbsp;</td>
		</tr>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 알림 문구 -->
        <c:if test="${empty sassD}">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
        </c:if>
	</tbody>
</table>