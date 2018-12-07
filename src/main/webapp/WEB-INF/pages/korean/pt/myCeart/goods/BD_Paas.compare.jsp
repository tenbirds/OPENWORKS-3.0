<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구조건</h3>
<table class="tbl_st4 mt10">
	<tr>
		<th>Language</th>
		<td>
			<dl>
			<c:forEach items="${pass}" var="pass" varStatus="status">
	            <c:choose>
                    <c:when test="${pass.consumerYn eq 'Y'}">
                    <dd>${pass.langSys}</dd>
                    </c:when>
                    <c:when test="${pass.consumerYn eq 'N' and langStoreId==pass.langStoreId}">
                    <dd><i>${pass.langSys}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
			</c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>Frameworks</th>
		<td>
			<dl>
			<c:forEach items="${pass}" var="pass" varStatus="status">
	            <c:choose>
                    <c:when test="${pass.consumerYn eq 'Y'}">
                    <dd>${pass.frameworkSys}</dd>
                    </c:when>
                    <c:when test="${pass.consumerYn eq 'N' and langStoreId==pass.langStoreId}">
                    <dd><i>${pass.frameworkSys}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
			</c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>Cache</th>
		<td>
			<dl>
			<c:forEach items="${pass}" var="pass" varStatus="status">
	            <c:choose>
                    <c:when test="${pass.consumerYn eq 'Y'}">
                    <dd>${pass.cacheSys}</dd>
                    </c:when>
                    <c:when test="${pass.consumerYn eq 'N' and langStoreId==pass.langStoreId}">
                    <dd><i>${pass.cacheSys}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
			</c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>DBMS</th>
		<td>
			<dl>
			<c:forEach items="${pass}" var="pass" varStatus="status">
	            <c:choose>
                    <c:when test="${pass.consumerYn eq 'Y'}">
                    <dd>${pass.dbmsSys}</dd>
                    </c:when>
                    <c:when test="${pass.consumerYn eq 'N' and langStoreId==pass.langStoreId}">
                    <dd><i>${pass.dbmsSys}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
			</c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>Fast Deploy</th>
		<td>
			<dl>
			<c:forEach items="${pass}" var="pass" varStatus="status">
	            <c:choose>
                    <c:when test="${pass.consumerYn eq 'Y'}">
                    <dd>${pass.fastDeploySys}</dd>
                    </c:when>
                    <c:when test="${pass.consumerYn eq 'N' and langStoreId==pass.langStoreId}">
                    <dd><i>${pass.fastDeploySys}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
			</c:forEach>
			</dl>
		</td>
	</tr>
	<tr>
		<th>etc</th>
		<td>
			<dl>
			<c:forEach items="${pass}" var="pass" varStatus="status">
	            <c:choose>
                    <c:when test="${pass.consumerYn eq 'Y'}">
                    <dd>${pass.etcSys}</dd>
                    </c:when>
                    <c:when test="${pass.consumerYn eq 'N' and langStoreId==pass.langStoreId}">
                    <dd><i>${pass.etcSys}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
			</c:forEach>
			</dl>
		</td>
	</tr>
</table>