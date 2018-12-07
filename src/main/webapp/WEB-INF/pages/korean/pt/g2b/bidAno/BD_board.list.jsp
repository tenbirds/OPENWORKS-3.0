<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

<head>
	<title>게시물 목록</title>

	<op:jsTag type="spi" items=" datepicker, cookie" />

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
		OpenWorks.startDt 		= "<c:out value='${param.q_startDt}'/>";
		OpenWorks.endDt   		= "<c:out value='${param.q_endDt}'/>";
		OpenWorks.showSummaryYn	= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.serverNm 		= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
		OpenWorks.isSession		= "<c:out value='${!empty __usk}'/>";

		onReadyEventFunctions();
		
		//검색 날짜 입력
		$('#q_startDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		$('#q_endDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		
	});
	
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>

<body>

	<!-- section -->
	<div class="section">
		<div class="tab-search">
			<table>
				<caption>검색</caption>
				<colgroup>
					<col style="width: 130px;" />
					<col style="width:;" />
				</colgroup>
				<tbody>
					<!-- 1 -->
					<tr>
						<th>공고명</th>
							<td>
								<div class="select-area fl">
								<!-- select box -->
								<div class="sech_form">
									<div class="cont_wrap">
										<div class="selected">
											<select id="dateType" name="dateType"
												title="공고명, 공고번호"
												onchange="if($(this).val() != ''){$(this).next().focus().select();}"
												style="width: 115px; position: absolute; left: -100000px; height: auto;">
												<option value="PBLANC_START_DATE"
													<c:if test="${empty baseVo.dateType || baseVo.dateType eq 'PBLANC_START_DATE' }"> selected="selected" </c:if>>공고명</option>
												<option value="BID_STRT_DATE"
													<c:if test="${baseVo.dateType eq 'BID_STRT_DATE' }"> selected="selected" </c:if>>공고번호</option>
											</select>
										</div>
									</div>
								</div>
								<!-- //select box -->
							</div>
								<input type="text" id="searchNmVal" name="searchNmVal" 
								title="공고명 입력" value="${baseVo.searchNmVal}" class="w650" />
							</td>
					</tr>
					
					<!-- 2 -->
					<tr>
						<th>공고/개찰일</th>
						<td>
							<!-- static select -->
							<div class="select-area fl">
								<!-- select box -->
								<div class="sech_form">
									<div class="cont_wrap">

										<div class="selected">
											<select id="dateType" name="dateType"
												title="검색하실 일자 공고일, 개찰일 중 선택"
												onchange="if($(this).val() != ''){$(this).next().focus().select();}"
												style="width: 115px; position: absolute; left: -100000px; height: auto;">
												<option value="PBLANC_START_DATE"
													<c:if test="${empty baseVo.dateType || baseVo.dateType eq 'PBLANC_START_DATE' }"> selected="selected" </c:if>>공고일</option>
												<option value="BID_STRT_DATE"
													<c:if test="${baseVo.dateType eq 'BID_STRT_DATE' }"> selected="selected" </c:if>>개찰일</option>
											</select>
										</div>
									</div>
								</div>
								<!-- //select box -->
							</div>
							<!-- //static select -->


							<div class="calendar_input">
								<input type="text" class="input" name="sDate" id="sDate"
									readonly="readonly" title="시작일 레이어 달력 열림" style="width: 100px"
									value="${baseVo.sDate}" />
							</div> <span class="divide"> ~ </span>
							<div class="calendar_input end">
								<input type="text" class="input" name="eDate" id="eDate"
									readonly="readonly" title="종료일 레이어 달력 열림" style="width: 100px"
									value="${baseVo.eDate}" />
							</div> <a href="javascript:" id="d_3M" class="b-btn type1"><strong><span>3개월</span></strong></a>
							<p class="caption mt10">검색기간은 공고일자 최대 3개월, 개찰일자 최대 3개월까지 가능</p>
						</td>
					</tr>
					<tr>
						<th>수요기관 명</th>
							<td>
								<input type="radio" value="ORDER_ORGN_NM"	id="searchKey01" name="searchKey"
								<c:if test="${empty baseVo.searchKey || baseVo.searchKey eq 'ORDER_ORGN_NM'}">checked="checked"</c:if> />
								<label for="" class="ml5">공고기관</label>
								
								<input type="radio"	value="REAL_ORGN_NM" id="searchKey02" name="searchKey"
								<c:if test="${baseVo.searchKey eq 'REAL_ORGN_NM'}">checked="checked"</c:if> />
								<label for="" class="ml5">수요기관</label>
								<input type="text" value="<c:out value='${baseVo.searchVal}' />"
								title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal"
								class="w304 ml20" />
							</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- //section -->
	<!-- btn-area -->
	<div class="btn-area mt10 ar">
		<a href="javascript:" onclick="jsSearch();" class="b-btn search type2"><strong><span>검
					색</span></strong></a><a href="javascript:" onclick="jsClean();"
			class="b-btn reset ml10 type1"><strong><span>초기화</span></strong></a>
	</div>
	<!-- //btn-area -->


	<div class="title-area">

		<!-- list -->
		<%@include file="korean/INC_board.list.jsp"%>
		<!-- //list -->


		<!-- 페이징 -->
		<op:pager pager="${pager}" page="pager/webPager.jsp"
			script="jsListReq" />
		<!-- //페이징 -->
	</div>
</body>
</html>