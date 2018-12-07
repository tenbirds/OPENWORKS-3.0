<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<c:set var="pageTitle" value="" />
<c:set var="jspFileNm" value="" />
<c:choose>
	<c:when test="${param.tmplatTy eq 'L'}">
		<c:set var="pageTitle" value="목록" />
		<c:set var="jspFileNm" value="BD_board.list.jsp" />
	</c:when>
	<c:when test="${param.tmplatTy eq 'V'}">
		<c:set var="pageTitle" value="읽기" />
		<c:set var="jspFileNm" value="BD_board.view.jsp" />
	</c:when>
	<c:when test="${param.tmplatTy eq 'F'}">
		<c:set var="pageTitle" value="쓰기" />
		<c:set var="jspFileNm" value="BD_board.form.jsp" />
	</c:when>
</c:choose>

<html>
<head>
<title>게시판 ${pageTitle} 템플릿 관리</title>
<op:jsTag type="openworks" items="ui" />

<!-- 사용자 스크립트 시작 -->
<script type="text/javascript">
	$().ready(function(){

	});

	var jsInsertForm = function(){
	    $("#tmplatId").val("");
	    $("#dataForm").attr("action", "BD_boardTemplateForm.do");
		$("#dataForm").submit();
	};

	var jsUpdateForm = function(templateId){
	    $("#tmplatId").val(templateId);
	    $("#dataForm").attr("action", "BD_boardTemplateForm.do");
		$("#dataForm").submit();
	};
	
	var jsSourceDwon = function(filePath){
	    location.href = "/component/file/ND_directDownload.do?fn=${jspFileNm}&fp=" + filePath;
	};
</script>
<!-- 사용자 스크립트 끝 -->
</head>

<body>
	<!-- 검색 폼 -->
	<form name="dataForm" id="dataForm" method="get">
		<!-- 기본 검색 사항 -->
		<input type="hidden" name="tmplatTy" id="tmplatTy" value="${param.tmplatTy}" />
		<input type="hidden" name="tmplatId" id="tmplatId" value="" />

		<table class="boardWrite" cellspacing="0" border="0" summary="게시판 목록 텝플릿으로 미리보기,템플릿명 등의 조회 정보를 제공합니다.">
			<colgroup>
				<col width="33%" />
				<col width="34%" />
				<col width="33%" />
			</colgroup>
			<c:forEach items="${dataList}" var="vo" varStatus="status">
				<c:if test="${status.count % 3 == 1}">
					<tr>
				</c:if>
				<td class="tx_c">
					<c:if test="${!empty vo.screenshotFilePath}">
						<img src="${vo.screenshotFilePath}" width="200" class="mar_b5" style="border: 1px solid #ddd; padding: 5px;" /><br />
					</c:if>
					<c:if test="${empty vo.screenshotFilePath}">
						<img src="/resources/openworks/theme/default/images/contents/no_img.gif" class="mar_b5 mar_t5" /><br />
					</c:if>
					<span class="tx_orange_b">${vo.tmplatNm} (${vo.tmplatId})</span><br />
					<button type="button" class="gray mar_t5 mar_b5" onclick="jsUpdateForm('${vo.tmplatId}')">편집</button>
					<button type="button" class="gray mar_t5 mar_b5" onclick="jsSourceDwon('${vo.tmplatFilePath}');">다운로드</button>
				</td>				
				<c:if test="${status.count % 3 == 0}">
					</tr>
				</c:if>
			</c:forEach>
			<c:if test="${empty dataList}">
				<tr>
					<td colspan="3" class="tx_c h_30">등록된 ${pageTitle} 템플릿이 없습니다.</td>
				</tr>
			</c:if>
		</table>

		<!-- 버튼 -->
		<div class="w_100p mar_t20">
			<div class="tx_c">
				<button type="button" class="w_blue mar_l5" onclick="jsInsertForm();">${pageTitle} 템플릿 신규등록</button>
			</div>
		</div>

	</form>

</body>
</html>