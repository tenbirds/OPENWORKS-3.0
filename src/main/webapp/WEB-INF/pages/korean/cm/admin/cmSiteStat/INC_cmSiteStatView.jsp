<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">

</script>
			<input type="hidden" id="searchUnit" name="searchUnit" value="${searchVo.searchUnit}" />
			<!-- contents -->
			<div id="contents">
				<h2>커뮤니티 통계</h2>
				<div class="statistics">
<!-- 						<strong style="float:left !important;"> -->
<%-- 							통계기간 : ${fn:substring(searchVo.startDate, 0, 4)}년 ${fn:substring(searchVo.startDate, 4, 6)}월 ${fn:substring(searchVo.startDate, 6, 8)}일 --%>
<%-- 							<c:if test="${searchVo.searchUnit ne 'DATE'}"> --%>
<%-- 								~ ${fn:substring(searchVo.endDate, 0, 4)}년 ${fn:substring(searchVo.endDate, 4, 6)}월 ${fn:substring(searchVo.endDate, 6, 8)}일 --%>
<%-- 							</c:if> --%>
<!-- 							</br> -->
<!-- 							</strong> -->
					<div class="btn">
						<span class="btn_light_gray02"><a href="#none" id ="date" class="daily"  onclick="setSearchUnit('DATE', '');">일간</a></span>
						<span class="btn_light_gray02"><a href="#none" id ="week"  onclick="setSearchUnit('WEEK', '');" >주간</a></span>
						<span class="btn_light_gray02"><a href="#none" id ="month"  onclick="setSearchUnit('MONTH', '');">월간</a></span>
					</div>
					<div class="select">
						<div class="calendar_input">
							<input type="text" class="input" id="startDate" name="startDate" value="${searchVo.startDate}" title="시작일자 입력" style="width:118px;" />
						</div>
						<span class="divide"> ~ </span>
						<div class="calendar_input">
							<input type="text" class="input" id="endDate" name="endDate" value="${searchVo.endDate}" title="종료일자 입력" style="width:118px;" readonly="readonly" />
						</div>
						<div class="btn_search"><div class="btn_navi_s"><a href="#none" onclick="jsSearch();" >Search</a></div></div>
					</div>
					</br>

					<div class="graph" style="width: 725px;">
						<div class="tbl_stats tline">
							<h5>사이트 통계</h5>
								<table border="1" summary="">
									<colgroup>
										<col />
										<col style="widht:16.6%" />
										<col style="widht:16.6%" />
										<col style="widht:16.6%" />
										<col style="widht:16.6%" />
										<col style="widht:16.6%" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2" colspan="2" style="text-align:center !important;">구분</th>
											<th scope="col" rowspan="2" style="text-align:center !important;">통계</th>
											<th scope="colgroup" colspan="3" style="text-align:center !important;">증가율</th>
										</tr>
										<tr>
											<th scope="col" style="text-align:center !important;">전일대비</th>
											<th scope="col" style="text-align:center !important;">전주대비</th>
											<th scope="col" style="text-align:center !important;">전월대비</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row"  rowspan="2" >방문현황</th>
											<td>방문자 수</td>
											<td><c:out value="${VisitCount.value1}"/></td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'DATE'}">
														<c:choose>
															<c:when test="${VisitCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty VisitCount.textValue and !fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _up">상승</span><c:out value="${VisitCount.textValue}"/>%
															</c:when>
															<c:when test="${not empty VisitCount.textValue and fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(VisitCount.textValue, 1, fn:length(VisitCount.textValue))}%
															</c:when>
															<c:when test="${empty VisitCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'WEEK'}">
														<c:choose>
															<c:when test="${VisitCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty VisitCount.textValue and !fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${VisitCount.textValue}%
															</c:when>
															<c:when test="${not empty VisitCount.textValue and fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(VisitCount.textValue, 1, fn:length(VisitCount.textValue))}%
															</c:when>
															<c:when test="${empty VisitCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'MONTH'}">
														<c:choose>
															<c:when test="${VisitCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty VisitCount.textValue and !fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${VisitCount.textValue}%
															</c:when>
															<c:when test="${not empty VisitCount.textValue and fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(VisitCount.textValue, 1, fn:length(VisitCount.textValue))}%
															</c:when>
															<c:when test="${empty VisitCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td>페이지 뷰</td>
											<td><c:out value="${PageViewCount.value1}"/></td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'DATE'}">
														<c:choose>
															<c:when test="${PageViewCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty PageViewCount.textValue and !fn:startsWith(PageViewCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${PageViewCount.textValue}%
															</c:when>
															<c:when test="${not empty PageViewCount.textValue and fn:startsWith(PageViewCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(PageViewCount.textValue, 1, fn:length(PageViewCount.textValue))}%
															</c:when>
															<c:when test="${empty PageViewCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'WEEK'}">
														<c:choose>
															<c:when test="${PageViewCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty PageViewCount.textValue and !fn:startsWith(PageViewCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${PageViewCount.textValue}%
															</c:when>
															<c:when test="${not empty PageViewCount.textValue and fn:startsWith(PageViewCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(PageViewCount.textValue, 1, fn:length(PageViewCount.textValue))}%
															</c:when>
															<c:when test="${empty PageViewCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'MONTH'}">
														<c:choose>
															<c:when test="${PageViewCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty PageViewCount.textValue and !fn:startsWith(PageViewCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${PageViewCount.textValue}%
															</c:when>
															<c:when test="${not empty PageViewCount.textValue and fn:startsWith(PageViewCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(PageViewCount.textValue, 1, fn:length(PageViewCount.textValue))}%
															</c:when>
															<c:when test="${empty PageViewCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<th scope="row" rowspan="2">게시글</th>
											<td>게시글 수</td>
											<td><c:out value="${BoardCount.value1}"/></td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'DATE'}">
														<c:choose>
															<c:when test="${BoardCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty BoardCount.textValue and !fn:startsWith(BoardCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${BoardCount.textValue}%
															</c:when>
															<c:when test="${not empty BoardCount.textValue and fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(BoardCount.textValue, 1, fn:length(BoardCount.textValue))}%
															</c:when>
															<c:when test="${empty BoardCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'WEEK'}">
														<c:choose>
															<c:when test="${BoardCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty BoardCount.textValue and !fn:startsWith(BoardCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${BoardCount.textValue}%
															</c:when>
															<c:when test="${not empty BoardCount.textValue and fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(BoardCount.textValue, 1, fn:length(BoardCount.textValue))}%
															</c:when>
															<c:when test="${empty BoardCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'MONTH'}">
														<c:choose>
															<c:when test="${BoardCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty BoardCount.textValue and !fn:startsWith(BoardCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${BoardCount.textValue}%
															</c:when>
															<c:when test="${not empty BoardCount.textValue and fn:startsWith(VisitCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(BoardCount.textValue, 1, fn:length(BoardCount.textValue))}%
															</c:when>
															<c:when test="${empty BoardCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td>댓글 수</td>
											<td><c:out value="${CmtCount.value1}"/></td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'DATE'}">
														<c:choose>
															<c:when test="${CmtCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty CmtCount.textValue and !fn:startsWith(CmtCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${CmtCount.textValue}%
															</c:when>
															<c:when test="${not empty CmtCount.textValue and fn:startsWith(CmtCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(CmtCount.textValue, 1, fn:length(CmtCount.textValue))}%
															</c:when>
															<c:when test="${empty CmtCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'WEEK'}">
														<c:choose>
															<c:when test="${CmtCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty CmtCount.textValue and !fn:startsWith(CmtCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${CmtCount.textValue}%
															</c:when>
															<c:when test="${not empty CmtCount.textValue and fn:startsWith(CmtCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(CmtCount.textValue, 1, fn:length(CmtCount.textValue))}%
															</c:when>
															<c:when test="${empty CmtCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${searchVo.searchUnit eq 'MONTH'}">
														<c:choose>
															<c:when test="${CmtCount.textValue eq '0'}">0%</c:when>
															<c:when test="${not empty CmtCount.textValue and !fn:startsWith(CmtCount.textValue, '-')}">
																<span class="contrast _up">상승</span>${CmtCount.textValue}%
															</c:when>
															<c:when test="${not empty CmtCount.textValue and fn:startsWith(CmtCount.textValue, '-')}">
																<span class="contrast _dw">하락</span>${fn:substring(CmtCount.textValue, 1, fn:length(CmtCount.textValue))}%
															</c:when>
															<c:when test="${empty CmtCount.textValue}"></c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</tbody>
								</table>
								<h5>방문활동 트렌드</h5>
								<div class="tab_style">
									<ul>
										<li id="visitCntChart" ><a href="#none" id="visitHref" onclick="setChartDisplay('visitor');" class="on">방문자 수</a></li>
										<li id="boardCntChart"><a href="#none"  id="boardHref" onclick="setChartDisplay('boardCnt');">게시글 수</a></li>
										<li id="pageViewCntChart"><a href="#none"  id="pageHref" onclick="setChartDisplay('pageView');">페이지 뷰</a></li>
									</ul>
								</div>
								</br>
								<div class="desc graph-bar">
									<div id="_chartMutildBar" class="mT10 mB10"></div>
								</div>
					</div>
				</div>
			</div>
			<!-- //contents -->

<!--  chart에서 사용할 리스트  -->
	<table class='visitorChartList' style="display:none;">
		<tr>
			<td>
				<c:choose>
					<c:when test="${searchVo.searchUnit eq 'DATE'}">
						일간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일)
					</c:when>
					<c:when test="${searchVo.searchUnit eq 'WEEK'}">
						주간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일
						~ ${fn:substring(searchVo.endDate, 0, 4)}년${fn:substring(searchVo.endDate, 4, 6)}월${fn:substring(searchVo.endDate, 6, 8)}일)
					</c:when>
					<c:when test="${searchVo.searchUnit eq 'MONTH'}">
						월간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일
						~ ${fn:substring(searchVo.endDate, 0, 4)}년${fn:substring(searchVo.endDate, 4, 6)}월${fn:substring(searchVo.endDate, 6, 8)}일)
					</c:when>
				</c:choose>
			</td>
			<td><c:out value="${VisitCount.value1}"/></td>
		</tr>
		<tr>
			<td>
				<c:choose>
					<c:when test="${searchVo.searchUnit eq 'DATE'}">
						전일 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일)
					</c:when>
					<c:when test="${searchVo.searchUnit eq 'WEEK'}">
						전주 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일
						~ ${fn:substring(searchVo.pastEndDate, 0, 4)}년${fn:substring(searchVo.pastEndDate, 4, 6)}월${fn:substring(searchVo.pastEndDate, 6, 8)}일)
					</c:when>
					<c:when test="${searchVo.searchUnit eq 'MONTH'}">
						전월 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일
						~ ${fn:substring(searchVo.pastEndDate, 0, 4)}년${fn:substring(searchVo.pastEndDate, 4, 6)}월${fn:substring(searchVo.pastEndDate, 6, 8)}일)
					</c:when>
				</c:choose>
			</td>
			<td><c:out value="${VisitCount.value2}"/></td>
		</tr>
	</table>
	<table class='boardCntChartList' style="display:none;">
	<tr>
		<td>
			<c:choose>
				<c:when test="${searchVo.searchUnit eq 'DATE'}">
					일간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'WEEK'}">
					주간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일
					~ ${fn:substring(searchVo.endDate, 0, 4)}년${fn:substring(searchVo.endDate, 4, 6)}월${fn:substring(searchVo.endDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'MONTH'}">
					월간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일
					~ ${fn:substring(searchVo.endDate, 0, 4)}년${fn:substring(searchVo.endDate, 4, 6)}월${fn:substring(searchVo.endDate, 6, 8)}일)
				</c:when>
			</c:choose>
		</td>
		<td><c:out value="${BoardCount.value1}"/></td>
	</tr>
	<tr>
		<td>
			<c:choose>
				<c:when test="${searchVo.searchUnit eq 'DATE'}">
					전일 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'WEEK'}">
					전주 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일
					~ ${fn:substring(searchVo.pastEndDate, 0, 4)}년${fn:substring(searchVo.pastEndDate, 4, 6)}월${fn:substring(searchVo.pastEndDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'MONTH'}">
					전월 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일
					~ ${fn:substring(searchVo.pastEndDate, 0, 4)}년${fn:substring(searchVo.pastEndDate, 4, 6)}월${fn:substring(searchVo.pastEndDate, 6, 8)}일)
				</c:when>
			</c:choose>
		</td>
		<td><c:out value="${BoardCount.value2}"/></td>
	</tr>
	
	<table class='pageViewChartList' style="display:none;">
	<tr>
		<td>
			<c:choose>
				<c:when test="${searchVo.searchUnit eq 'DATE'}">
					일간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'WEEK'}">
					주간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일
					~ ${fn:substring(searchVo.endDate, 0, 4)}년${fn:substring(searchVo.endDate, 4, 6)}월${fn:substring(searchVo.endDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'MONTH'}">
					월간 (${fn:substring(searchVo.startDate, 0, 4)}년${fn:substring(searchVo.startDate, 4, 6)}월${fn:substring(searchVo.startDate, 6, 8)}일
					~ ${fn:substring(searchVo.endDate, 0, 4)}년${fn:substring(searchVo.endDate, 4, 6)}월${fn:substring(searchVo.endDate, 6, 8)}일)
				</c:when>
			</c:choose>
		</td>
		<td><c:out value="${PageViewCount.value1}"/></td>
	</tr>
	<tr>
		<td>
			<c:choose>
				<c:when test="${searchVo.searchUnit eq 'DATE'}">
					전일 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'WEEK'}">
					전주 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일
					~ ${fn:substring(searchVo.pastEndDate, 0, 4)}년${fn:substring(searchVo.pastEndDate, 4, 6)}월${fn:substring(searchVo.pastEndDate, 6, 8)}일)
				</c:when>
				<c:when test="${searchVo.searchUnit eq 'MONTH'}">
					전월 (${fn:substring(searchVo.pastStartDate, 0, 4)}년${fn:substring(searchVo.pastStartDate, 4, 6)}월${fn:substring(searchVo.pastStartDate, 6, 8)}일
					~ ${fn:substring(searchVo.pastEndDate, 0, 4)}년${fn:substring(searchVo.pastEndDate, 4, 6)}월${fn:substring(searchVo.pastEndDate, 6, 8)}일)
				</c:when>
			</c:choose>
		</td>
		<td><c:out value="${PageViewCount.value2}"/></td>
	</tr>
</table>