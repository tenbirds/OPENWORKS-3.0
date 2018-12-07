<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title></title>

	<op:jsTag type="spi" items="cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
	
	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">

	//카테고리 저장용
   	bbsCtgAry = new Array();

	$().ready(function(){
		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType 			= "<c:out value='LIST'/>";
		OpenWorks.boardNm				= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.boardType			= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.useCategory 	= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn 				= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.filePermExtsn	= "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.captchaYn 		= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.tagYn 				= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.bbsNm		 			= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.bbsCd		 			= "<c:out value='${boardConfVo.bbsCd}'/>";
		OpenWorks.domainCd			= "<c:out value='${boardConfVo.domainCd}'/>";
		OpenWorks.searchVal			= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey			= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName			= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder			= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.startDt 			= "<c:out value='${param.q_startDt}'/>";
		OpenWorks.endDt   			= "<c:out value='${param.q_endDt}'/>";
		OpenWorks.q_ctgCd       = "<c:out value='${param.q_ctgCd}'/>";
		OpenWorks.q_aditCtgCd   = "<c:out value='${param.q_aditCtgCd}'/>";
		OpenWorks.showSummaryYn	= "<c:out value='N'/>";
		OpenWorks.serverNm 			= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do'/>";
		OpenWorks.isSession			= "<c:out value='${!empty __usk}'/>";
		
		onReadyEventFunctions();
		
		if(OpenWorks.q_ctgCd != null &&  OpenWorks.q_ctgCd != "" && OpenWorks.q_aditCtgCd != null &&  OpenWorks.q_aditCtgCd != ""  ){
			var ctgNum = OpenWorks.q_ctgCd.substring(3,4);
	    var ctg = OpenWorks.q_ctgCd;
	    var aditCtgNum = OpenWorks.q_aditCtgCd; 
	        //기존 클래스 지우기
	        //$("a[id*=ctg]").removeClass('on'); 
	        //$("a[id*=aditctg]").removeClass('on');
	        //$("ul[id*=depth]").addClass('hide');
	        
	        //$("#ctg"+ctgNum).addClass('on'); 
	        //$("#depth"+ctgNum).find("#aditctg_"+aditCtgNum+"_"+ctg).addClass('on');
	        //$("#depth"+ctgNum).removeClass('hide');
        
		} 
    
	});
	
	function viewFaQTab(num) {
	    $('.tab-area > ul > li > a').removeClass('on');
		$('.tab-area > ul > li').removeClass('on');
		$("a[id*=aditctg]").removeClass('on');
		
		$('#ctg'+num).addClass('on');			
		$('#ctg'+num).parent('li').addClass('on');
	}
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>

<body>
	<div>
	<!-- 검색 폼 -->
		<form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();" action="jsSearch();">
			<!-- 기본 검색 사항 -->
			<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" />
			<input type="hidden" name="bbsCd" value="<c:out value='${param.bbsCd}' />" />
			<input type="hidden" name="domainCd" value="<c:out value='${param.domainCd}' />" />
			<input type="hidden" name="pageType" value="<c:out value='' />" />
			<input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}' />" />
			<input type="hidden" name="delDesc" id="delDesc" value="<c:out value='' />" />
			<input type="hidden" name="q_aditCtgCd" id="q_aditCtgCd" value="<c:out value='${param.q_aditCtgCd}' />" />
			<input type="hidden" name="q_ctgCd" id="q_ctgCd" value="<c:out value='${param.q_ctgCd}' />" />
			
			<!-- title-area -->
			<div class="title-area">
				<h2 id="bodyMenuNm"></h2>
					<!-- search -->
					<!-- 검색 삽입. -->
					<c:choose>
	         	<c:when test="${domCd eq 1}">
	          	<%@include file="../common/INC_search.jsp" %>
	         	</c:when>
	         	<c:when test="${domCd eq 2}">
	          	<%@include file="../common/korean/INC_search.jsp" %>
	         	</c:when>
			    </c:choose>
					<!-- //search -->
				</div>
				<!-- //title-area -->
    		<!-- section -->
    		<c:if test="${boardConfVo.ctgYn eq 'Y'}">
				<div class="section">
					<!-- tab -->
					<div class="tab-area">
						<ul class="full">
							<c:if test="${boardConfVo.bbsCd eq '1002'}">
							<li class="${empty param.q_ctgCd? 'on':''}">
								<a href="#" id="ctg0" onclick="viewFaQTab('0'); jsSearchReset(); return false;" class="${empty param.q_ctgCd? 'on':''}">전체</a>
							</li><!-- 선택되었을때 클래스 on 적용 -->
							</c:if>
							<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
							<li class="${ctgVo.ctgCd eq param.q_ctgCd? 'on':''}" style="">
								<a href="#" id="ctg${status.index+1}" onclick="viewFaQTab('${status.index+1}'); jsCtgCdSelect('${ctgVo.ctgCd}',''); return false;" class="${ctgVo.ctgCd eq param.q_ctgCd? 'on':''}">${ctgVo.ctgNm}</a>
		            	<ul id="depth${status.index+1}">
	                  <c:forEach items="${ctgVo.aditCtgList}" var="aditCtgVo" varStatus="status">
	                   <c:if test="${ctgVo.ctgCd == aditCtgVo.ctgCd}">
	                       <li><a href="#" id="aditctg_${aditCtgVo.aditCtgCd}_${aditCtgVo.ctgCd}" onclick="jsCtgCdSelect('${aditCtgVo.ctgCd}','${aditCtgVo.aditCtgCd}');" class="${(aditCtgVo.ctgCd eq param.q_ctgCd && aditCtgVo.aditCtgCd eq param.q_aditCtgCd)? 'on':''}">${aditCtgVo.aditCtgNm}</a></li>
	                   </c:if>
	                  </c:forEach>
		              </ul>
							</li>
							</c:forEach>
						</ul>
					</div>
					<!-- //tab -->
				</div>
				</c:if>
				<!-- //section -->
				
				<%-- 항목 표시 수 --%>
				<c:set var="thCnt" value="0" />
				
				<%-- 내용 --%>
			<!-- section -->
			<div class="section">
			<c:choose>
				<c:when test="${domCd eq 2}">
	      <!-- 불러온 글 갯수 -->
				<op:pagerParam page="param/webListPagerParam.jsp" />
					<!--  -->
	      <%@include file="korean/INC_board.list.jsp" %>
	      </c:when>
			</c:choose>
			</div>
		<!-- //section -->
		</form>
	</div>
</body>
</html>