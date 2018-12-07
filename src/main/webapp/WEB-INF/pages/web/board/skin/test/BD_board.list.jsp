<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title></title>

	<op:jsTag type="spi" items="highlight, datepicker, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">

	//카테고리 저장용
	bbsCtgAry = new Array();

	$().ready(function(){

		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType 		= "LIST";
		OpenWorks.boardNm		= "${boardConfVo.bbsNm}";
		OpenWorks.boardType		= "${boardConfVo.kindCd}";
		OpenWorks.useCategory 	= "${boardConfVo.ctgYn}";
		OpenWorks.fileYn 		= "${boardConfVo.fileYn}";
		OpenWorks.fileExts 		= "${boardConfVo.fileExts}";
		OpenWorks.captchaYn 	= "${boardConfVo.captchaYn}";
		OpenWorks.tagYn 		= "${boardConfVo.tagYn}";
		OpenWorks.bbsNm		 	= "${boardConfVo.bbsNm}";
		OpenWorks.bbsCd		 	= "${boardConfVo.bbsCd}";
		OpenWorks.searchVal		= "${param.q_searchVal}";
		OpenWorks.searchKey		= "${param.q_searchKey}";
		OpenWorks.sortName		= "${param.q_sortName}";
		OpenWorks.sortOrder		= "${param.q_sortOrder}";
		OpenWorks.startDt 		= "${param.q_startDt}";
		OpenWorks.endDt   		= "${param.q_endDt}";
		OpenWorks.showSummaryYn	= "${param.showSummaryYn}";
		OpenWorks.serverNm 		= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
		OpenWorks.isSession		= ${!empty __usk};

		onReadyEventFunctions();

		//검색 날짜 입력
		$('#q_startDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		$('#q_endDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});

	});

	</script>
	<!-- 사용자 스크립트 끝 -->
</head>

<body>
이건 test 스킨임당...
	<form name="convertForm" id="convertForm" method="post" onsubmit="return false;" action="BD_board.list.do">
		<!--  변환 옵션 사항 -->
		<input type="hidden" name="bbsCd" value="${param.bbsCd}" />
		<input type="hidden" name="maxResult" id="maxResult" value="" />
		<input type="hidden" name="showAll" id="showAll" value="N" />
		<input type="hidden" name="noticeYnYn" id="noticeYnYn" value="N" />
		<input type="hidden" name="titleYn" id="titleYn" value="N" />
		<input type="hidden" name="summaryYn" id="summaryYn" value="N" />
		<input type="hidden" name="scoreSumYn" id="scoreSumYn" value="N" />
		<input type="hidden" name="regDtYn" id="regDtYn" value="N" />
		<input type="hidden" name="modDtYn" id="modDtYn" value="N" />
		<input type="hidden" name="readCntYn" id="readCntYn" value="N" />
		<input type="hidden" name="regNmYn" id="regNmYn" value="N" />
		<input type="hidden" name="mgrIdYn" id="mgrIdYn" value="N" />
		<input type="hidden" name="userKeyYn" id="userKeyYn" value="N" />
		<input type="hidden" name="scoreCntYn" id="scoreCntYn" value="N" />
		<input type="hidden" name="accuseCntYn" id="accuseCntYn" value="N" />
		<input type="hidden" name="recomCntYn" id="recomCntYn" value="N" />
		<input type="hidden" name="type" value="" />

		<input type="hidden" name="q_currPage" value="${param.q_currPage}" />
		<input type="hidden" name="q_ctgCd" value="-1" />
		<input type="hidden" name="q_sortName" value="${param.q_sortName}" />
		<input type="hidden" name="q_sortOrder" value="${param.q_sortOrder}" />
		<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
		<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
		<input type="hidden" name="q_startDt" value="${param.q_startDt}" />
		<input type="hidden" name="q_endDt" value="${param.q_endDt}" />
	</form>

	<!-- 검색 폼 -->
	<form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();" action="jsSearch();">
		<!-- 기본 검색 사항 -->
		<input type="hidden" name="seq" id="seq" value="" />
		<input type="hidden" name="bbsCd" value="${param.bbsCd}" />
		<input type="hidden" name="pageType" value="" />
		<input type="hidden" name="showSummaryYn" value="${param.showSummaryYn}" />
		<input type="hidden" name="delDesc" id="delDesc" value="" />

		<!-- 검색 삽입. -->
		<%@include file="../../templates/common/INC_search.jsp" %>

		<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
		<op:pagerParam page="param/webListPagerParam.jsp" />

		<!-- 목록 삽입. -->
		<%@include file="INC_board.list.jsp" %>

		<!-- 페이징 -->
		<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
		<!-- //페이징 -->

		<!-- 버튼 -->
		<div>
			<div class="float_l">
				<c:if test="${boardConfVo.feedYn eq 'Y'}">
					<a href="#" class="mar_r2" onclick="jsConvertAction('rss');"><img src="/resources/web/theme/default/images/btn/btn_rss.gif" alt="RSS" /></a>
					<a href="#" class="mar_r2" onclick="jsConvertAction('atom');"><img src="/resources/web/theme/default/images/btn/btn_atom.gif" alt="ATOM" /></a>
				</c:if>
				<c:if test="${boardConfVo.tagYn eq 'Y'}">
					<a href="#" class="mar_r2"><img id="tagCloud" src="/resources/web/theme/default/images/btn/btn_tag.gif" alt="tag" /></a>
				</c:if>
				<a href="#" onclick="jsSummaryShow();"><img src="/resources/web/theme/default/images/btn/btn_summary.gif" alt="summary" /></a>
			</div>
			<div class="float_r">
				<a href="#" onclick="jsInsertForm('INSERT');"><img src="/resources/web/theme/default/images/btn/btn_regist.gif" alt="등록" /></a>
			</div>
		</div>

	</form>

</body>
</html>