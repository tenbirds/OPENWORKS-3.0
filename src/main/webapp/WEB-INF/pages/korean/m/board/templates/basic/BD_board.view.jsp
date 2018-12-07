<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<title>게시물 상세</title>

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
	 });
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>
    <c:if test="${boardConfVo.bbsCd eq 1001}">
    <!-- container -->
    <div id="container">
        <!-- contents -->
        <div id="contents">
            <c:choose>

                <c:when test="${domCd eq 3}">
                    <div class="location"><span class="home">Home</span><strong>Announcement</strong></div>
                    <section class="content rela">
                    <h3>Announcement</h3>
                </c:when>
                <c:when test="${domCd eq 4}">
                    <div class="location"><span class="home">Inicio</span><strong>Anuncio</strong></div>
                    <section class="content rela">
                    <h3>Anuncio</h3>
                </c:when>
            </c:choose>
    </c:if>
   
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
         
         
    <c:if test="${boardConfVo.bbsCd eq 1001}">
           </section>
        </div>
        <!-- //contents -->
    </div>
    <!-- //container -->
    </c:if>
 </body>
</html>