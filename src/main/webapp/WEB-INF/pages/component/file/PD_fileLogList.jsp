<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>파일 다운로드 이력</title>

	<op:jsTag type="openworks" items="form" />

	<script type="text/javascript">
		var jsMovePage = function(cpage){
		    $("#q_currPage").val(cpage);
		    dataForm.submit();
		};
	</script>

</head>

<body>

	<!-- 검색 -->
	<form name="dataForm" id="dataForm" method="get" action="/component/file/PD_fileLogList.do">
		<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
		<op:pagerParam title="파일다운로드 이력" />
		<input type="hidden" name="fileSeq" value="${param.fileSeq}" />
		<input type="hidden" name="fileId" value="${param.fileId}" />
	</form>

	<br />

	<table class="boardList">
		<colgroup>
			<col width="60" />
			<col width="100" />
			<col width="" />
		</colgroup>
		<tr>
			<th>순번</th>
			<th>다운로더</th>
			<th>다운로드 일시</th>
		</tr>
		<c:set var="index" value="${pager.indexNo}" />
		<c:forEach items="${pager.list}" var="_bean" varStatus="status">
			<tr>
				<td>${index-status.index}</td>
				<td>${_bean.workerNm}</td>
				<td>${_bean.regDt}</td>
			</tr>
		</c:forEach>

		<c:if test="${empty pager.list}">
			<op:no-data obj="${pager}" colspan="3" />
		</c:if>

	</table>

	<op:pager pager="${pager}" />

</body>
</html>