<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>게시물 상세</title>

	<op:jsTag type="spi" items="form, highlight, ui, validate, cookie, adgallery" />
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
		OpenWorks.boardType			= '${boardConfVo.kndCd}';
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

		if(OpenWorks.fileCnt > 0){
			var galleries = $('#imgView').adGallery({
				loader_image: '<c:url value="/resources/openworks/spi/jquery/ad-gallery/loader.gif" />',
				width: 600,						//Width of the image, set to false and it will read the CSS width
				height: 400,					//Height of the image, set to false and it will read the CSS height
				thumb_opacity: 0.5,				//Opacity that the thumbs fades to/from, (1 removes fade effect)
				//Note that this effect combined with other effects might be resource intensive
				//and make animations lag
				start_at_index: 0,		//Which image should be displayed at first? 0 is the first image
				animate_first_image: false,		//Should first image just be displayed, or animated in?
				animation_speed: 400,			//Which ever effect is used to switch images, how long should it take?
				display_next_and_prev: true,	//Can you navigate by clicking on the left/right on the image?
				display_back_and_forward: true,	//Are you allowed to scroll the thumb list?
				scroll_jump: 0,					//If 0, it jumps the width of the container
				slideshow: {
					enable: false,
					autostart: false,
					speed: 3000,
					start_label: '<img src="'+ CTX_PATH + '/resources/openworks/spi/jquery/ad-gallery/control_play.png"/>',
					stop_label: '<img src="'+ CTX_PATH + '/resources/openworks/spi/jquery/ad-gallery/control_stop.png"/>',
					stop_on_scroll: true,		//Should the slideshow stop if the user scrolls the thumb list?
					countdown_prefix: '(',		//Wrap around the countdown
					countdown_sufix: ')',
					onStart: function(){
						//Do something wild when the slideshow starts
					},
					onStop: function(){
						//Do something wild when the slideshow stops
					}
				},
				effect: 'fade',					//'slide-hori' or 'slide-vert', 'resize', 'fade', 'none' or false
				enable_keyboard_move: true,		//Move to next/previous image with keyboard arrows?
				cycle: false,					//If set to false, you can't go from the last image to the first, and vice versa
				//All callbacks has the AdGallery objects as 'this' reference
				callbacks: {
					//Executes right after the internal init, can be used to choose which images
					//you want to preload
					init: function(){
						//preloadAll uses recursion to preload each image right after one another
						this.preloadAll();
						//Or, just preload the first three
						//this.preloadImage(0);
						//this.preloadImage(1);
						//this.preloadImage(2);
					},
					//This gets fired right after the new_image is fully visible
					afterImageVisible: function(){
						//For example, preload the next image
						var context = this;
						//this.loading(true);
						this.preloadImage(this.current_index + 1,
							function(){
								//This function gets executed after the image has been loaded
								//context.loading(false);
							}
						);
					},
					//This gets fired right before old_image is about to go away, and new_image
					//is about to come in
					beforeImageVisible: function(new_image, old_image){
						//Do something wild!
					}
				}
			});
		}else{
			$('#imgView').html("");
		}
	});

	//이미지 미리보기 /resources/openworks/spi/jquery/ad-gallery/jquery.ad-gallery.js 내에서 콜
	var viewImage = function(src, width, height){
		$.fn.colorbox({
			width : 800,
			height : 600,
			href  : src,
			iframe: true
		});
	};
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
		<table class="boardWrite" cellspacing="0" border="0" summary="${dataVo.bbscttSj} 게시글 정보입니다.">
			<caption class="hidden">${dataVo.bbscttSj} 상세보기</caption>
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
									<div id="imgView" class="ad-gallery" style="margin:0 auto;">
										<div class="ad-image-wrapper"></div>
										<div class="ad-controls"></div>
										<div class="ad-nav">
											<div class="ad-thumbs">
												<ul class="ad-thumb-list">
													<c:forEach items="${dataVo.fileList}" var="fileBean" varStatus="status">
														<li>
															<a href="<c:url value="${fileBean.fileUrl}" />">
																<img src="<c:url value="${fileBean.fileUrl}" />" class="galleryImg" alt="${fileBean.localNm}" width='152px' height='100px' />
															</a>
														</li>
													</c:forEach>
												</ul>
											</div>
										</div>
									</div>
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
				<button type="button" class="w_blue mar_r5" onclick="jsView('${dataVo.prevVO.bbsCd}', '${dataVo.prevVO.seq}', '${dataVo.prevVO.registPassword}', '${dataVo.prevVO.othbcAt}'); return false;">이전</button>
				<button type="button" class="w_blue mar_r5" onclick="jsView('${dataVo.nextVO.bbsCd}', '${dataVo.nextVO.seq}', '${dataVo.nextVO.registPassword}', '${dataVo.nextVO.othbcAt}'); return false;">다음</button>
			</c:if>
		</div>
		<div class="float_r mar_b10">
			<c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'}">
				<button type="button" class="blue mar_l5" onclick="jsInsertForm('INSERT');">등록</button>
			</c:if>
			<c:if test="${(MenuAssignType eq 'A' && dataVo.regId eq __msk.mngrId) or MenuAssignType eq 'G'}">
				<button type="button" class="blue mar_l5" onclick="jsUpdateForm('UPDATE');">수정</button>
				<button type="button" class="blue mar_l5" onclick="jsDelete();">완전삭제</button>
				<c:if test="${empty dataVo.mngrDelYn or dataVo.mngrDelYn eq 'N'}">
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
		<input type="hidden" name="refrnSeq" value="${dataVo.refrnSeq}" />
		<input type="hidden" name="registPassword" value="${dataVo.registPassword}" />

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