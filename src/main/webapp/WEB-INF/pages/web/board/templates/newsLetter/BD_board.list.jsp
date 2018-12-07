<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title></title>

<op:jsTag type="spi" items=" datepicker, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

<!-- 기능별 스크립트 정의 -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
<script type="text/javascript"
	src="/resources/web/theme/common/js/fakeselect.js"></script>

<!-- 사용자 스크립트 시작 -->
<script type="text/javascript">

	//카테고리 저장용
	bbsCtgAry = new Array();

	$().ready(function(){

		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType 			= "LIST";
		OpenWorks.boardNm				= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.boardType			= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.useCategory 	= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn 				= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.filePermExtsn = "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.captchaYn 		= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.tagYn 				= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.bbsNm		 			= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.bbsCd		 			= "<c:out value='${boardConfVo.bbsCd}'/>";
    OpenWorks.domainCd    	= "<c:out value='${boardConfVo.domainCd}'/>";
		OpenWorks.searchVal			= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey			= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName			= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder			= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.startDt 			= "<c:out value='${param.q_startDt}'/>";
		OpenWorks.endDt   			= "<c:out value='${param.q_endDt}'/>";
		OpenWorks.showSummaryYn	= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.serverNm 			= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
		OpenWorks.isSession			= "<c:out value='${!empty __usk}'/>";

		onReadyEventFunctions();

		//검색 날짜 입력
		$('#q_startDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		$('#q_endDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		
	});

	</script>
<!-- 사용자 스크립트 끝 -->
</head>

<body>
	<!-- contents -->
	<div class="contents">
		<!-- 검색 폼 -->
		<form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();" action="jsSearch();">
			<!-- 기본 검색 사항 -->
			<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" /> 
			<input type="hidden" name="bbsCd" value="<c:out value='${param.bbsCd}' />" /> 
			<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" /> 
			<input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}' />" /> 
			<input type="hidden" name="pageType" value="<c:out value='' />" /> 
			<input type="hidden" name="delDesc" id="delDesc" value="<c:out value='' />" />
			<input type="hidden" name="q_ctgCd" id="q_ctgCd" value="<c:out value='${param.q_ctgCd}'/>" />
			<!-- title-area -->
			<div class="title-area">
				<!-- 검색 -->
				<%@include file="../common/korean/INC_search.jsp"%>
			</div>
			<!-- section -->
			
				<%@include file="INC_board.list.jsp"%>												
			
			<!-- 페이징 -->
			<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
			<!-- //페이징 -->		
		</form>					
	<!-- //contents -->
	</div>
</body>
</html>