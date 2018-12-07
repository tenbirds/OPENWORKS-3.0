<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title></title>

	<op:jsTag type="spi" items="form, highlight, ui, validate, cookie" />
	<op:jsTag type="openworks" items="ui" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">
	var cmtTabz;

	$().ready(function(){
		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType			= '${pageType}';
		OpenWorks.boardType			= '${boardConfVo.kindCd}';
		OpenWorks.boardNm			= '${boardConfVo.bbsNm}';
		OpenWorks.useCategory		= '${boardConfVo.ctgYn}';
		OpenWorks.fileYn			= '${boardConfVo.fileYn}';
		OpenWorks.fileExts			= '${boardConfVo.fileExts}';
		OpenWorks.captchaYn			= '${boardConfVo.captchaYn}';
		OpenWorks.readCookieHour	= '${boardConfVo.readCookieHour}';
		OpenWorks.commentYn			= '${boardConfVo.commentYn}';
		OpenWorks.bbsCd				= '${dataVo.bbsCd}';
		OpenWorks.seq				= '${dataVo.seq}';
		OpenWorks.searchVal			= '${param.q_searchVal}';
		OpenWorks.searchKey			= '${param.q_searchKey}';
		OpenWorks.sortName			= '${param.q_sortName}';
		OpenWorks.sortOrder			= '${param.q_sortOrder}';
		OpenWorks.tagYn				= "${boardConfVo.tagYn}";
		OpenWorks.listViewCd		= '${boardConfVo.listViewCd}';
		OpenWorks.showSummaryYn		= '${param.showSummaryYn}';
		OpenWorks.isSession			= ${!empty __usk};

		onReadyEventFunctions();
	 });
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>
이건 test 스킨임당...
	<!-- 내용보기 -->
	<fieldset>
		<legend>내용보기</legend>
		<table class="gray_write" cellspacing="0" border="0" summary="${dataVo.title} 게시글 정보입니다.">
			<caption class="hidden">${dataVo.title} 상세보기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<!-- 상세 배치에서 설정한 항목 배치 -->
				<c:set var="scoreRow" value="1" />
				<c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
					<c:choose>
						<c:when test="${arrange.columnId eq 'CTG_CD'}">
							<!-- 분류 -->
							<c:if test="${boardConfVo.ctgYn eq 'Y'}">
								<tr>
									<th><label for="${arrange.beanNm}">${arrange.columnNm}</label></th>
									<td>${dataVo.ctgNm} [${dataVo.ctgCd}]</td>
								</tr>
							</c:if>
						</c:when>

						<c:when test="${arrange.columnId eq 'SCORE_CNT' || arrange.columnId eq 'SCORE_SUM'}">
							<!-- 만족도 -->
							<c:if test="${boardConfVo.stfyYn eq 'Y' && scoreRow == 1}">
								<tr>
									<th>${arrange.columnNm}</th>
									<td>
										<form name="scoreForm" id="scoreForm" method="post" action="ND_score.action.do">
											<input type="hidden" name="bbsCd" id="bbsCd" value="${dataVo.bbsCd}" />
											<input type="hidden" name="seq" id="seq" value="${dataVo.seq}" />
											<span class="tx_b vm">평균평점 : <span id="boardScoreAvgSapn" class="tx_orange">${dataVo.scoreAvg}</span></span>
											<select name="scoreSum" class="mar_l5 vm">
												<option value="0">선택</option>
												<option value="1">1점</option>
												<option value="2">2점</option>
												<option value="3">3점</option>
												<option value="4">4점</option>
												<option value="5">5점</option>
												<option value="6">6점</option>
												<option value="7">7점</option>
												<option value="8">8점</option>
												<option value="9">9점</option>
												<option value="10">10점</option>
											</select>
											<input type="submit" class="gray_s" value="평점주기"/>
										</form>
									</td>
								</tr>
								<c:set var="scoreRow" value="${scoreRow + 1}" />
							</c:if>
						</c:when>

						<c:when test="${arrange.columnId eq 'RECOM_CNT'}">
							<!-- 추천 -->
							<c:if test="${boardConfVo.recommYn eq 'Y'}">
								<tr>
									<th>${arrange.columnNm}</th>
									<td>
										<input type="button" id="recomBtn" class="gray_s" value="추천:${dataVo.recomCnt}" onclick="jsClickRecommAction(this, ${dataVo.bbsCd}, '${dataVo.seq}', ${boardConfVo.readCookieHour});" />
										<script type="text/javascript">$("#recomBtn").val("추천:${dataVo.recomCnt}");</script>
									</td>
								</tr>
							</c:if>
						</c:when>

						<c:when test="${arrange.columnId eq 'ACCUSE_CNT'}">
							<!-- 신고 -->
							<c:if test="${boardConfVo.sueYn eq 'Y'}">
								<tr>
									<th>${arrange.columnNm}</th>
									<td>
										<input type="button" id="accuseBtn" class="gray_s" value="신고:${dataVo.accuseCnt}" onclick="jsClickAccuseAction(this, ${dataVo.bbsCd}, '${dataVo.seq}', ${boardConfVo.readCookieHour});" />
										<script type="text/javascript">$("#accuseBtn").val("신고:${dataVo.accuseCnt}");</script>
									</td>
								</tr>
							</c:if>
						</c:when>
						<c:when test="${arrange.columnId eq 'FILE_SEQ'}">
							<!-- 첨부파일 -->
							<c:if test="${!empty dataVo.fileList}">
								<tr>
									<th>첨부파일</th>
									<td>
										<ul>
											<c:choose>
												<c:when test="${fn:length(dataVo.fileList) > 0}">
													<c:forEach items="${dataVo.fileList}" var="fileVo">
														<li>
															<img src="/resources/openworks/theme/default/images/icon/icon_file_jpg.gif" class="vm" alt="파일 첨부" />
															<a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a>
															<span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
														</li>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<li>첨부파일이 없습니다.</li>
												</c:otherwise>
											</c:choose>
										</ul>
									</td>
								</tr>
							</c:if>
						</c:when>

						<c:otherwise>
							<!-- 기타 항목 -->
							<tr>
								<th>${arrange.columnNm}</th>
								<td><op:bean-util field="${arrange.columnId}" obj="${dataVo}"/></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 태그 -->
				<c:if test="${boardConfVo.tagYn eq 'Y'}">
					<tr>
						<td colspan="2">
							<div class="tag">
								<img src="/resources/openworks/theme/default/images/icon/icon_tag.gif" alt="태그" class="vm" />
								<c:if test="${empty dataVo.bbsTags}">등록된 태그가 없습니다.</c:if>
								<c:if test="${!empty dataVo.bbsTags}">
									<c:forEach var="tag" items="${dataVo.bbsTags}" varStatus="status">
										<a href="#" onclick="jsShowBbsListByTag('${tag}')">${tag}</a> <c:if test="${not status.last}">|</c:if>
									</c:forEach>
								</c:if>
							</div>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</fieldset>

	<!-- 버튼 -->
	<div class="float_r mar_b40">
		<a href="#" onclick="jsList('${param.q_currPage}');"><img src="/resources/web/theme/default/images/btn/btn_list.gif" alt="목록" /></a>
		<a class="mar_l2" href="#" onclick="jsInsertForm('INSERT');"><img src="/resources/web/theme/default/images/btn/btn_regist.gif" alt="등록" /></a>
		<c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
			<a class="mar_l2" href="#" onclick="jsUpdateForm('UPDATE');"><img src="/resources/web/theme/default/images/btn/btn_edit.gif" alt="수정" /></a>
			<a class="mar_l2" href="#" onclick="jsDelete();"><img src="/resources/web/theme/default/images/btn/btn_del.gif" alt="삭제" /></a>
		</c:if>
	</div>
	<!-- //버튼 -->

	<!-- 댓글 -->
	<c:if test="${boardConfVo.commentYn eq 'Y'}">
		<br/><div id="attachedCommentsDiv"></div>
	</c:if>
	<!-- //댓글 -->

	<!-- 목록 보여주기 시작 -->
	<form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
		<!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
		<op:pagerParam view="view" />

		<!-- 다음/이전을 목록으로 보기 -->
		<c:if test="${boardConfVo.listViewCd == 1003}">
			<!-- 목록 삽입 -->
			<%@include file="INC_board.list.jsp" %>

			<!-- 페이징 영역 시작 -->
			<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
			<!-- 페이징 영역 끝 -->
		</c:if>
		<!-- 다음/이전을 목록으로 보기 -->

		<!-- 다음/이전을 다음/이전으로 보기 -->
		<c:if test="${boardConfVo.listViewCd == 1002}">
			<%@include file="../../templates/common/INC_prev.next.list.jsp" %>
		</c:if>
		<!-- 다음/이전을 다음/이전으로 보기 끝 -->

		<input type="hidden" name="showSummaryYn" value="${param.showSummaryYn}" />
		<input type="hidden" name="listShowType" value="${param.listShowType}" />

		<input type="hidden" name="bbsCd" value="${dataVo.bbsCd}" />
		<input type="hidden" name="seq" value="${dataVo.seq}" />
		<input type="hidden" name="refSeq" value="${dataVo.refSeq}" />
		<input type="hidden" name="regPwd" value="${dataVo.regPwd}" />

		<input type="hidden" name="iconKey" value="" />
		<input type="hidden" name="contents" value="" />
		<input type="hidden" name="ctgCd" id="ctgCd" value="${dataVo.ctgCd}" />
		<input type="hidden" name="pageType" id="pageType" value="" />

		<!-- 이동옵션 -->
		<input type="hidden" name="toBbsCd" id="toBbsCd" value="" />
		<input type="hidden" name="newCtg" id="newCtg" value="-1" />
		<input type="hidden" name="delDesc" id="delDesc" value="" />
		<input type="hidden" name="isMove" id="isMove" value="" />
	</form>

</body>
</html>