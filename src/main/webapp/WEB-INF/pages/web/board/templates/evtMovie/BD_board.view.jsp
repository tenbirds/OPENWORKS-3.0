<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<title></title>
	<op:jsTag type="spi" items="form, validate, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/boardcmt.js"></script>
    
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
    

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">
	var cmtTabz;

	$().ready(function(){
		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType			= "<c:out value='${pageType}'/>";
		OpenWorks.boardType			= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.boardNm			= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.useCategory		= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn			= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.filePermExtsn		= "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.captchaYn			= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.rdcntIncrsLmttTime= "<c:out value='${boardConfVo.rdcntIncrsLmttTime}'/>";
		OpenWorks.cmtYn			    = "<c:out value='${boardConfVo.cmtYn}'/>";
		OpenWorks.domainCd			= "<c:out value='${dataVo.domainCd}'/>";
		OpenWorks.bbsCd				= "<c:out value='${dataVo.bbsCd}'/>";
		OpenWorks.bbscttSeq			= "<c:out value='${dataVo.bbscttSeq}'/>";
		OpenWorks.searchVal			= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey			= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName			= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder			= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.tagYn				= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.listViewCd		= "<c:out value='${boardConfVo.listViewCd}'/>";
		OpenWorks.showSummaryYn		= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.isSession			= "<c:out value='${!empty __usk}'/>";

		onReadyEventFunctions();
		
		$('#q_rowPerPage').val(6);
	 });
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>
<!-- contents -->
	<div class="contents">
		<%@include file="INC_board.view.jsp" %>
	</div>
 </body>
</html>