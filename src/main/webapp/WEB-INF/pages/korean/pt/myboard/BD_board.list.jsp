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
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">

	//카테고리 저장용
	bbsCtgAry = new Array();

	$().ready(function(){
	    
	    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType 		= "LIST";
		OpenWorks.boardNm		= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.boardType		= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.useCategory 	= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn 		= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.filePermExtsn = "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.captchaYn 	= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.tagYn 		= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.bbsNm		 	= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.bbsCd		 	= "<c:out value='${boardConfVo.bbsCd}'/>";
        OpenWorks.domainCd      = "<c:out value='${boardConfVo.domainCd}'/>";
		OpenWorks.searchVal		= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey		= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName		= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder		= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.startDt       = "<c:out value='${param.q_startDt}'/>";
        OpenWorks.endDt         = "<c:out value='${param.q_endDt}'/>";
		OpenWorks.showSummaryYn	= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.section       = "<c:out value='${param.section}'/>";
		OpenWorks.serverNm 		= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
		OpenWorks.isSession		= "<c:out value='${!empty __usk}'/>";

		onReadyEventFunctions();

		//검색 날짜 입력
		$('#q_endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
            buttonImageOnly : true
        });
        
        $('#q_startDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
            buttonImageOnly : true
        });
        
        var set2Str = function(vl){
            return parseInt(vl, 10) > 9 ? vl : '0' + vl;
        };
        var getDateStr = function(date){
            return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
        };
        
        var getCalDate = function(date, months, days){
            var newDate = date;
            if(typeof(date.getDate) != 'function'){
                newDate = new Date();
            }
        
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
        
            return newDate;
        
        };
        
        if ($('#q_init').val() == '1' || $('#q_init').val() == '') {
            // 기간,발표일 달력 생성
            if($('#q_startDt').val() == ''){
                var beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth() - 1);
                $('#q_startDt').val(getDateStr(getCalDate(new Date(),-1,0)));
            }
            if($('#q_endDt').val() == ''){
                $('#q_endDt').val(getDateStr(new Date()));
            }
        }
		
	});

	//검색 버튼
	var jsSearch2 = function(){
	    var searchKey = $("#q_searchKeyType");
	    var searchVal = $("#q_searchVal");
	    
	    if("" == $.trim(searchKey.val())){
	        searchVal.val("");
	    }
	    
	    document.dataForm.elements["q_init"].value = "0";
	    $("#dataForm input[name=q_sortName]").val("");
	    $("#dataForm input[name=q_sortOrder]").val("");
	    refreshPage();
	};
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>

<body>
	<div class="myDoc oper">
	<!-- 검색 폼 -->
	<form name="dataForm" id="dataForm" method="get" onsubmit="return false;" >
		<!-- 기본 검색 사항 -->
		<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" />
		<input type="hidden" name="bbsCd"  value="<c:out value='${param.bbsCd}' />" />
		<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
		<input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}' />" />
		<input type="hidden" name="pageType" value="<c:out value='' />" />
		<input type="hidden" name="delDesc" id="delDesc" value="<c:out value='' />" />
        <input type="hidden" name="q_ctgCd" id="q_ctgCd" value="<c:out value='' />" />
        <input type="hidden" name="section" id="section" value="<c:out value='${param.section}'/>"/>
        <input type="hidden" name="q_init" id="q_init" value="${param.q_init}" />
    
		<!-- 구매내역 검색 영역 -->
	
		<div class="schOpt">
			<table class="tbl_st4">
			<tr>
				<th>제목/내용</th>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<th>기간(문의일)</th>
				<td class="term">
				<input type="text" name="q_startDt" id="q_startDt" readonly="readonly" title="시작일 레이어 달력 열림" value="${baseVo.q_startDt}" /> ~
				<input type="text" name="q_endDt" id="q_endDt" readonly="readonly" title="종료일 레이어 달력 열림" value="${baseVo.q_endDt}" />
					
					<a href="#" onclick="jsSetDay(0, 1, 0); return false;" class="btns st3">오늘</a>
					<a href="#" onclick="jsSetDay(0, 7, 0); return false;" class="btns st3">1주일</a>
					<a href="#" onclick="jsSetDay(1, 1, 0); return false;" class="btns st3">1개월</a>
					<a href="#" onclick="jsSetDay(3, 1, 0); return false;" class="btns st3">3개월</a>
				</td>
			</tr>
			</table>
			
			</div>
			<!-- btn-area -->
			<div class="btnArea rig mtm20">
				<a href="#" onclick="jsSearch2(); return false;" class="btns st5 icn icnSearch">검색</a >
				<a href="#" onclick="jsSearchReset(); return false;" class="btns st5">전체보기</a>
			</div>
			<!-- //btn-area -->
			
		
		<!-- //구매내역 검색 영역 -->
		<p class="total-count">총 <strong>${pager.totalNum}</strong>개</p>        

		<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='${searchMap.q_currPage}'/>"/>
		<input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value='${searchMap.q_sortName}'/>" />
		<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value='${searchMap.q_sortOrder}'/>"/>	
		 
		 <div class="type-list">	
         <!-- tbl_write -->
         <table class="tbl_st1">
			<thead>
				<tr>
					<th id="th-ROWNUM">번호</th>
					<th id="th-ESTN_COLUMN3">답변상태</th>
					<th id="th-CTG_CD">카테고리</th>
					<th id="th-BBSCTT_SJ">문의제목</th>
					<th id="th-OTHBC_AT">문의성격</th>
					<th id="th-REGIST_DT">문의일</th>
					<th id="th-REPLY_DT">답변일</th>
				</tr>
			</thead>
            	<tbody >
                <!-- 공지 제외 게시물 목록 -->
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <!-- 번호(필수) -->
                        <td>
                            <c:choose>
                                <c:when test="${(pageType eq 'VIEW') && (baseVo.bbscttSeq eq dataVo.bbscttSeq)}">
                                    <img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png' />" alt="현재글" />
                                </c:when>
                                <c:otherwise>
                                    ${index-status.index}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <!-- 상태  -->
                        <td>
                            <c:if test="${baseVo.estnColumn3 eq 'Y'}"><span class="condi_a">답변완료</span></c:if>
                            <c:if test="${baseVo.estnColumn3 eq 'N'}"><span class="condi_b">미답변</span></c:if>
                        </td>

                        <!-- 목록 배치에서 설정한 항목 배치 -->
                        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                            <c:choose>
                                <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                    <!-- 분류 항목 -->
                                    <td ><c:out value='${baseVo.ctgNm}'/></td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                    <!-- 제목 항목 -->
                                    <td class="title">
	                                    <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                                        onclick="jsView('${baseVo.domainCd}','${baseVo.bbsCd}', '${baseVo.bbscttSeq}', '${baseVo.registPassword}', '${baseVo.othbcAt}'); return false;">
	                                        <c:out value='${fn:substring(baseVo.bbscttSj,0,50)}'/><c:if test="${baseVo.bbscttSjLength > 50}">...</c:if>
	                                        <c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
	                                        <c:if test="${baseVo.fileCnt > 0}">
	                                            <img alt="첨부된 이미지" class="ico" src="/resources/web/theme/default/images/common/ico/ico_image.gif">
	                                        </c:if>
	                                    </a>
                                    </td>
                                    <!-- 공개여부(문의성격) -->
                                    <td>
	                                    <c:if test="${baseVo.othbcAt == 'Y'}">공개</c:if>
	                                    <c:if test="${baseVo.othbcAt == 'N'}">비공개</c:if>
                                    </td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                                    <!-- 분류 항목 -->
                                    <td class="date"><c:out value='${baseVo.registDt}'/></td>
                                    <td class="date"><c:out value='${baseVo.replyDt}'/></td>
                                </c:when>
                                <c:otherwise>
<%-- 		                       <td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td> --%>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tr>
                </c:forEach>

                <!-- 데이터가 없을 때 알림 문구 -->
                <c:if test="${empty pager.list}">
                    <op:no-data obj="${pager}" colspan="7" />
                </c:if>

            </tbody>
        </table>
		</div>

         <!-- //tbl_write -->
		<!-- 페이징 -->
		<div class="paging">
		<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
		</div>
		<!-- //페이징 -->

	<!-- //contents -->

		</div>
	</form>	
</body>
</html>