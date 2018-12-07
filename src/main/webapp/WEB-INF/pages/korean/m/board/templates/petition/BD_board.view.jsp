<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>게시물 상세</title>

	<op:jsTag type="spi" items="form, ui, validate, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>

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
		OpenWorks.bbsCd				= "<c:out value='${dataVo.bbsCd}'/>";
		OpenWorks.domainCd			= "<c:out value='${dataVo.domainCd}'/>";
		OpenWorks.bbscttSeq			= "<c:out value='${dataVo.bbscttSeq}'/>";
		OpenWorks.searchVal			= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey			= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName			= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder			= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.tagYn				= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.listViewCd		= "<c:out value='${boardConfVo.listViewCd}'/>";
		OpenWorks.showSummaryYn		= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.isSession			= "<c:out value='${!empty __usk}'/>";
		OpenWorks.section			= "";

		onReadyEventFunctions();
	 });
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" />
        
        <c:choose>
            <c:when test="${domCd eq 2}">
                <%@include file="korean/INC_board.view.jsp" %>
            </c:when>
            <c:when test="${domCd eq 3}">
                <%@include file="english/INC_board.view.jsp" %>
            </c:when>
            <c:when test="${domCd eq 4}">
                <%@include file="spanish/INC_board.view.jsp" %>
            </c:when>
         </c:choose>
</body>
</html>