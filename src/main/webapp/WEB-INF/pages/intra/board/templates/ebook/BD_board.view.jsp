<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>게시물 상세</title>

	<op:jsTag type="spi" items="form, highlight, ui, validate, cookie" />
	<op:jsTag type="openworks" items="ui" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/intra/board/board.js"></script>

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
		OpenWorks.fileCnt			= "${dataVo.fileCnt}";
		OpenWorks.captchaYn			= '${boardConfVo.captchaYn}';
		OpenWorks.readCookieHour	= '${boardConfVo.readCookieHour}';
		OpenWorks.cmtYn			= '${boardConfVo.cmtYn}';
		OpenWorks.bbsCd				= '${dataVo.bbsCd}';
		OpenWorks.seq				= '${dataVo.seq}';
		OpenWorks.searchVal			= '${param.q_searchVal}';
		OpenWorks.searchKey			= '${param.q_searchKey}';
		OpenWorks.sortName			= '${param.q_sortName}';
		OpenWorks.sortOrder			= '${param.q_sortOrder}';
		OpenWorks.tagYn				= "${boardConfVo.tagYn}";
		OpenWorks.listViewCd		= '${boardConfVo.listViewCd}';
		OpenWorks.showSummaryYn		= '${param.showSummaryYn}';

		onReadyEventFunctions();
	});
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>

	<div class="po_rel">
		<h4>${boardConfVo.bbsNm} 상세</h4>
	</div>

	<!-- 내용보기 -->
	<fieldset>
		<legend>내용보기</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="${dataVo.title} 게시글 정보입니다.">
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


						<c:when test="${arrange.columnId eq 'RECOMEND_CNT'}">
							<!-- 추천 -->
							<c:if test="${boardConfVo.recomendYn eq 'Y'}">
								<tr>
									<th><label for="${arrange.beanNm}">${arrange.columnNm}</label></th>
									<td>
										<input type="button" id="recomBtn" class="s_blue vm" value="추천 ${dataVo.recomendCnt}" onclick="jsClickRecommAction(this, ${dataVo.bbsCd}, '${dataVo.seq}', ${boardConfVo.readCookieHour});" />
										<script type="text/javascript">$("#recomBtn").val("추천 ${dataVo.recomendCnt}");</script>
									</td>
								</tr>
							</c:if>
						</c:when>

						<c:when test="${arrange.columnId eq 'ACCUSE_CNT'}">
							<!-- 신고 -->
							<c:if test="${boardConfVo.accuseYn eq 'Y'}">
								<tr>
									<th><label for="${arrange.beanNm}">${arrange.columnNm}</label></th>
									<td>
										<input type="button" id="accuseBtn" class="s_blue vm" value="신고 ${dataVo.accuseCnt}" onclick="jsClickAccuseAction(this, ${dataVo.bbsCd}, '${dataVo.seq}', ${boardConfVo.readCookieHour});" />
										<script type="text/javascript">$("#accuseBtn").val("신고 ${dataVo.accuseCnt}");</script>
									</td>
								</tr>
							</c:if>
						</c:when>
						<c:when test="${arrange.columnId eq 'FILE_SEQ'}">
							<!-- 첨부파일 -->
							<c:if test="${!empty dataVo.fileList}">
								<tr>
									<th><label for="${arrange.beanNm}">첨부파일</label></th>
									<td>
										<ul>
											<c:choose>
												<c:when test="${fn:length(dataVo.fileList) > 0}">
													<c:forEach items="${dataVo.fileList}" var="fileVo">
														<li>
															<img src="/resources/openworks/theme/default/images/icon/icon_file_jpg.gif" class="vm" alt="파일 첨부" />
															<a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a>
															<span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
															<button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${fileVo.fileSeq}', '${fileVo.fileId}');">이력보기</button>
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

						<c:when test="${arrange.columnId eq 'CONTENTS'}">
							<!-- 내용과 이미지 파일 보기 -->
							<tr>
								<td colspan="2" id="view-con">
									<c:if test="${fn:length(dataVo.fileList) gt 0}">
										<!-- 사진보기 -->
										<c:forEach items="${dataVo.fileList}" var="fileBean" varStatus="status">
											<c:if test="${fn:startsWith(fileBean.fileType, 'image')}">
												<div id="imgView" class="tx_c">
													<img src="<c:url value="${fileBean.fileUrl}" />" class="cont_gallery_Img" title="${fileBean.localNm}" style="width: 250px;height: 350px;"/>
												</div>
												<div class="mb10" style="clear:both;"></div>
											</c:if>
										</c:forEach>
									</c:if>
									<p class="mar_t10">${dataVo.contents}</p>
								</td>
							</tr>
						</c:when>

						<c:otherwise>
							<!-- 기타 항목 -->
							<tr>
								<th><label for="${arrange.beanNm}">${arrange.columnNm}</label></th>
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

	<!-- 댓글 -->
	<c:if test="${boardConfVo.cmtYn eq 'Y'}">
		<br/><div id="attachedCommentsDiv" class="comment block"></div>
	</c:if>
	<!-- //댓글 -->

	<!-- 버튼 -->
	<div class="mar_t10">
		<div class="float_l mar_b10">
			<button type="button" class="w_blue mar_r5" onclick="jsList('${param.q_currPage}');">목록</button>
			<c:if test="${boardConfVo.listViewCd eq 1001}">
				<button type="button" class="w_blue mar_r5" onclick="jsView('${dataVo.prevVO.bbsCd}', '${dataVo.prevVO.seq}', '${dataVo.prevVO.regPwd}', '${dataVo.prevVO.openYn}'); return false;">이전</button>
				<button type="button" class="w_blue mar_r5" onclick="jsView('${dataVo.nextVO.bbsCd}', '${dataVo.nextVO.seq}', '${dataVo.nextVO.regPwd}', '${dataVo.nextVO.openYn}'); return false;">다음</button>
			</c:if>
		</div>
		<div class="float_r mar_b10">
			<c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'}">
				<button type="button" class="blue mar_l5" onclick="jsInsertForm('INSERT');">등록</button>
			</c:if>
			<c:if test="${(MenuAssignType eq 'A' && dataVo.regId eq __msk.mgrId) or MenuAssignType eq 'G'}">
				<button type="button" class="blue mar_l5" onclick="jsUpdateForm('UPDATE');">수정</button>
				<button type="button" class="blue mar_l5" onclick="jsDelete();">완전삭제</button>
				<c:if test="${empty dataVo.mgrDelYn or dataVo.mgrDelYn eq 'N'}">
					<button type="button" class="blue mar_l5" onclick="jsFlagDelete();">플래그삭제</button>
				</c:if>
			</c:if>
			<c:if test="${MenuAssignType eq 'G'}">
				<button type="button" class="blue mar_l5" onclick="jsTransfer('${param.bbsCd}');">이동</button>
			</c:if>
		</div>
	</div>
	<!-- //버튼 -->

	<!-- 목록 보여주기 시작 -->
	<form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
		<!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
		<op:pagerParam view="view" />

		<!-- 다음/이전을 목록으로 보기 -->
		<c:if test="${boardConfVo.listViewCd eq 1003}">
			<!-- 목록 삽입 -->
			<p class="mar_t10">&nbsp;</p>
			<%@include file="INC_board.list.jsp" %>

			<!-- 페이징 영역 시작 -->
			<op:pager pager="${pager}" script="jsListReq" />
			<!-- 페이징 영역 끝 -->
		</c:if>
		<!-- 다음/이전을 목록으로 보기 -->

		<!-- 다음/이전을 다음/이전으로 보기 -->
		<c:if test="${boardConfVo.listViewCd eq 1002}">
			<%@ include file="../common/INC_prev.next.list.jsp" %>
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
		<input type="hidden" name="ctgCd" id="ctgCd" value="" />
		<input type="hidden" name="pageType" id="pageType" value="" />

		<!-- 이동옵션 -->
		<input type="hidden" name="toBbsCd" id="toBbsCd" value="" />
		<input type="hidden" name="newCtg" id="newCtg" value=-1 />
		<input type="hidden" name="delDesc" id="delDesc" value="" />
		<input type="hidden" name="isMove" id="isMove" value="" />
	</form>

</body>
</html>