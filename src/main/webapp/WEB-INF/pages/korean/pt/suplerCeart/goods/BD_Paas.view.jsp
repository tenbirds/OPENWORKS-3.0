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
                        <c:when test="${pass.consumerYn eq 'N'}">
                            <dd><input type="text" id="langSys" name="langSys" value="${pass.langSys}"/></dd>
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
                        <c:when test="${pass.consumerYn eq 'N'}">
                            <dd><input type="text" id="frameworkSys" name="frameworkSys" value="${pass.frameworkSys}"/></dd>
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
                        <c:when test="${pass.consumerYn eq 'N'}">
                            <dd><input type="text" id="cacheSys" name="cacheSys" value="${pass.cacheSys}"/></dd>
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
                        <c:when test="${pass.consumerYn eq 'N'}">
                            <dd><input type="text" id="dbmsSys" name="dbmsSys" value="${pass.dbmsSys}"/></dd>
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
                        <c:when test="${pass.consumerYn eq 'N'}">
                            <dd><input type="text" id="fastDeploySys" name="fastDeploySys" value="${pass.fastDeploySys}"/></dd>
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
                        <c:when test="${pass.consumerYn eq 'N'}">
                            <dd><input type="text" id="etcSys" name="etcSys" value="${pass.etcSys}"/></dd>
                        </c:when>
                    </c:choose>
	            </c:forEach>
			</dl>
		</td>
	</tr>
</table>

