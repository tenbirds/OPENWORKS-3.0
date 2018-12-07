<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title></title>

	<op:jsTag type="spi" items="datepicker, cookie" />
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
		OpenWorks.pageType 		= "<c:out value='LIST'/>";
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
		OpenWorks.bizStartDt	= "<c:out value='${param.q_bizStartDt}'/>";
		OpenWorks.bizEndDt  	= "<c:out value='${param.q_bizEndDt}'/>";
		OpenWorks.showSummaryYn	= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.section   	= "<c:out value='myboardB'/>";
		OpenWorks.serverNm 		= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
		OpenWorks.isSession		= "<c:out value='${!empty __usk}'/>";

		$('#q_bizEndDt').datepicker({
	        showOn : 'button',
	        defaultDate : null,
	        buttonImage : '<c:url value="/new_cloud/images/icon-btn/btn-calendar.gif" />',
	        buttonImageOnly : true
	    });
		
	    $('#q_bizStartDt').datepicker({
	        showOn : 'button',
	        defaultDate : null,
	        buttonImage : '<c:url value="/new_cloud/images/icon-btn/btn-calendar.gif" />',
	        buttonImageOnly : true
	    });
	    
		onReadyEventFunctions();
		
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
            if($('#q_bizStartDt').val() == ''){
                var beginDate = new Date();
                $('#q_bizStartDt').val(getDateStr(new Date()));
            }
            if($('#q_bizEndDt').val() == ''){
                beginDate.setMonth(beginDate.getMonth() +1);
                $('#q_bizEndDt').val(getDateStr(getCalDate(new Date(),+1,0)));
            }
        }
		
	});
	
    //page번호로 목록 페이지를 호출한다.(bbsCd는 기본 셋팅값 사용)
    var jsListReq = function(page) {
        document.dataForm.elements["q_init"].value = "0";
        $("#dataForm input[name=q_currPage]").val(page);
        jsRequest("dataForm", "BD_bizMatchIndex.do", "get");
    };
    
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>

	<!-- 검색 폼 -->
	<form name="dataForm" id="dataForm" method="get" onsubmit="return false;">
		<!-- 기본 검색 사항 -->
		<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
		<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value=''/>"/>
		<input type="hidden" name="bbsCd" value="<c:out value='${param.bbsCd}' />"/>
		<input type="hidden" name="pageType" value="<c:out value=''/>"/>
		<input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}'/>"/>
		<input type="hidden" name="delDesc" id="delDesc" value="<c:out value=''/>"/>
		<input type="hidden" name="q_init" id="q_init" value="${param.q_init}" />
		<input type="hidden" name="section" id="section" value="${param.section}" />
		<input type="hidden" name="q_searchKey" id="q_searchKey" value="<c:out value='${param.q_searchKey}'/>" />
		<input type="hidden" name="q_searchKeyType" id="q_searchKeyType" value="<c:out value='BBSCTT_SJ_BBSCTT_CN'/>"/>
		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
			<div class="title-area">
				<h2>비즈매칭 내역</h2>
			</div>
			<!-- //title-area -->

			<!-- section -->
			<div class="section">
				<div class="tab-search">
					<table>
						<caption>검색</caption>
						<colgroup>
						<col style="width:130px;"/>
						<col style="width:;"/>
						</colgroup>
						<tbody>
							<tr>
								<th>제목/내용</th>

								<td><input type="text" class="w650" id="q_searchVal" name="q_searchVal" title="검색어 입력" value="<c:out value='${param.q_searchVal}'/>" /></td>
							</tr>
							<tr>
								<th>기간(종료일)</th>
								<td>

									<div class="calendar_input">
									  <input type="text" class="input" name="q_bizStartDt" id="q_bizStartDt" readonly="readonly" title="검색 시작일 입력" style="width:100px" value="<c:out value='${param.q_bizStartDt}'/>" />
									</div>
									<span class="divide"> ~ </span>
									<div class="calendar_input end">
									  <input type="text" class="input" name="q_bizEndDt" id="q_bizEndDt" readonly="readonly" title="검색 종료일 입력" style="width:100px" value="<c:out value='${param.q_bizEndDt}'/>" />
									</div>
									 
									<span><a href="#" class="b-btn mr05 type1" onclick="jsBizSetDay(0, 1, 0); return false;"><strong><span>오늘</span></strong></a></span>
									<span><a href="#" class="b-btn mr05 type1" onclick="jsBizSetDay(0, 7, 0); return false;"><strong><span>1주일</span></strong></a></span>
									<span><a href="#" class="b-btn mr05 type1" onclick="jsBizSetDay(1, 1, 0); return false;"><strong><span>1개월</span></strong></a></span>
									<span><a href="#" class="b-btn mr05 type1" onclick="jsBizSetDay(3, 1, 0); return false;"><strong><span>3개월</span></strong></a></span>

								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- //section -->
			
			<!-- btn-area -->
			<div class="btn-area mt10 ar">
				<a href="#" class="b-btn search type2" onclick="jsListReq(1); return false;"><strong><span>검 색</span></strong></a>
				<a href="#" class="b-btn ml10 type1" onclick="jsSearchReset(); return false;"><strong><span>전체보기</span></strong></a>
			</div>
			<!-- //btn-area -->
			
			<!-- section -->
			<div class="section">
				<h3 class="stitle"></h3>
				<p class="total-count">총 <strong><c:out value='${pager.totalNum}'/></strong>개</p>
				<!-- list -->
				<div class="type-list">
					<table>
						<caption>비즈매칭 내역</caption>
						<colgroup>
						<col style="width:80px;"/>
						<col style="width:*;"/>
						<col style="width:100px;"/>
						<col style="width:100px;"/>
						<col style="width:80px;"/>
						<col style="width:80px;"/>
						<col style="width:100px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>상태</th>
								<th>종료일</th>
								<th>매칭수</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
	                        <c:set var="index" value="${pager.indexNo}"/>
	                        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	                        <tr>
	                            <!-- 번호(필수) -->
	                            <td>${index-status.index}</td>
	                            
	                            <!-- 제목 항목 -->
	                            <td class="title">
                                    <span style="color: #333; display: inline-block;">
                                        <c:choose>
                                            <c:when test="${(baseVo.estnColumn7 eq '1')}"></c:when>
                                            <c:otherwise>[매칭댓글]</c:otherwise>
                                        </c:choose>
                                    </span>
	                                
	                                <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                                    onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>','<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
	                                    <c:out value='${fn:substring(baseVo.bbscttSj,0,23)}'/><c:if test="${baseVo.bbscttSjLength > 23}">...</c:if>
	                                </a>
	
	                                <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
	                              
	                                <c:choose>
	                                    <c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
	                                        <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
	                                    </c:when>
	                                    <c:when test="${baseVo.fileCnt > 0}">
	                                        <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span>
	                                    </c:when>
	                                </c:choose>

	                                <c:if test="${baseVo.othbcAt eq 'Y'}">
	                                    <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div>
	                                </c:if>
	                                <c:if test="${baseVo.othbcAt eq 'N'}">
	                                    <div id="titleSummary${status.count}" class="tx_blue_s">* 비밀글 입니다. *</div>
	                                </c:if>
	                            </td>
	                          
	                          
	                            <!-- 상태 -->
	                            <td>
		                            <c:if test="${baseVo.bizProgression eq 'COM'}"><span class="condi_a">완료</span></c:if>
		                            <c:if test="${baseVo.bizProgression eq 'INC'}"><span class="condi_a">완료</span></c:if>
		                            <c:if test="${baseVo.bizProgression eq 'PRO'}"><span class="condi_d">진행중</span></c:if>
	                           </td>
	                           
	                           <!-- 종료일 -->
	                           <td><c:out value='${baseVo.estnColumn6}'/></td>
	                           <!-- 매칭수 -->
	                           <td><c:out value='${ baseVo.commentCnt}'/></td>
	                           <!-- 조회수 항목 -->
	                           <td><c:out value='${baseVo.rdcnt}'/></td>
	                           <!-- 등록일 -->
	                           <td><c:out value='${baseVo.registDt}'/></td>
					       </tr>
				           </c:forEach>
				           
					       <!-- 데이터가 없을 때 알림 문구 -->
					       <c:if test="${empty pager.list}">
						       <op:no-data obj="${pager}" colspan="7" />
					       </c:if>
						</tbody>
					</table>
				</div>
				<!-- //list -->

				<!-- paging -->
				<div class="paging">
					<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
				</div>
				<!-- //paging -->
			</div>
			<!-- //section -->

		</div>
		<!-- //contents -->
	
	</form>
</body>
</html>