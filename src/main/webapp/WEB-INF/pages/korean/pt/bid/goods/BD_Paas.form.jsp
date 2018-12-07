<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
<div class="conWrap detailRequ paas">
	<h3>시스템요구</h3>
	<table class="tbl_st1">
		<thead>
			<tr>
				<th>구분</th>
				<th>지원범위</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>Language</th>
				<td><input type="text" name="langSys" id="langSys" value="${pass[0].langSys}"/></td>
			</tr>
			<tr>
				<th>Frameworks</th>
				<td><input type="text" name="frameworkSys" id="frameworkSys" value="${pass[0].frameworkSys}"/></td>
			</tr>
			<tr>
				<th>Cache</th>
				<td><input type="text" name="cacheSys" id="cacheSys" value="${pass[0].cacheSys}"/></td>
			</tr>
			<tr>
				<th>DBMS</th>
				<td><input type="text" name="dbmsSys" id="dbmsSys" value="${pass[0].dbmsSys}"/></td>
			</tr>
			<tr>
				<th>Fast Deploy</th>
				<td><input type="text" name="fastDeploySys" id="fastDeploySys" value="${pass[0].fastDeploySys}"/></td>
			</tr>
			<tr>
				<th>etc</th>
				<td><input type="text" name="etcSys" id="etcSys" value="${pass[0].etcSys}"/></td>
			</tr>
		</tbody>
	</table>
</div>
<!--// content -->

