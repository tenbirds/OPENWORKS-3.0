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
		OpenWorks.boardType			= '${boardConfVo.kndCd}';
		OpenWorks.boardNm			= '${boardConfVo.bbsNm}';
		OpenWorks.useCategory		= '${boardConfVo.ctgYn}';
		OpenWorks.fileYn			= '${boardConfVo.fileYn}';
		OpenWorks.filePermExtsn		= '${boardConfVo.filePermExtsn}';
		OpenWorks.captchaYn			= '${boardConfVo.captchaYn}';
		OpenWorks.rdcntIncrsLmttTime= '${boardConfVo.rdcntIncrsLmttTime}';
		OpenWorks.cmtYn			    = '${boardConfVo.cmtYn}';
		OpenWorks.bbsCd				= '${dataVo.bbsCd}';
		OpenWorks.domainCd			= '${dataVo.domainCd}';
		OpenWorks.bbscttSeq			= '${dataVo.bbscttSeq}';
		OpenWorks.searchVal			= '${param.q_searchVal}';
		OpenWorks.searchKey			= '${param.q_searchKey}';
		OpenWorks.sortName			= '${param.q_sortName}';
		OpenWorks.sortOrder			= '${param.q_sortOrder}';
		OpenWorks.tagYn				= "${boardConfVo.tagYn}";
		OpenWorks.listViewCd		= '${boardConfVo.listViewCd}';
		OpenWorks.showSummaryYn		= '${param.showSummaryYn}';

		onReadyEventFunctions();
	 });
	
	
	function jsSubmit() {
	    
	    if($("#replyCn").val().length == 0) {
            alert("답변을 입력해주세요 ");
            $("#replyCn").focus();
            return false;
            
        } else if($("#replyCn").val().length < 11) {
            alert("답변은 최소 10자이상 입력해주세요.");
            $("#replyCn").focus();
            return false;
        }else{
            // 답변은 모두 작성후 
		    if($('input:radio[name="estnColumn3"]:checked').val() == 'N'){ // 처리중으로 선택후 글등록
	            if(!confirm("처리중 상태로 답변을 등록하면 사용자에게 노출되지않습니다. 등록하시겠습니까?"))
	                return false;
		        
		    }else if($('input:radio[name="estnColumn3"]:checked').val() == 'Y'){// 처리완료료
	            if(!confirm("처리완료 상태로 답변을 등록하면 상태변경은 수정불가능합니다. 등록하시겠습니까? "))
	                return false;
		    }
            
        }

	    $("#estnColumn3").val($(':radio[name="estnColumn3"]:checked').val());
	    $("#replyForm").submit();
	}
	
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
										<input type="button" id="recomBtn" class="s_blue vm" value="추천 ${dataVo.recomendCnt}" onclick="jsClickRecommAction(this, ${dataVo.bbsCd}, '${dataVo.bbscttSeq}', ${boardConfVo.rdcntIncrsLmttTime});" />
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
										<input type="button" id="accuseBtn" class="s_blue vm" value="신고 ${dataVo.accuseCnt}" onclick="jsClickAccuseAction(this, ${dataVo.bbsCd}, '${dataVo.bbscttSeq}', ${boardConfVo.rdcntIncrsLmttTime});" />
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
<%-- 															<button type="button" class="gray_s mar_l10" onclick="jsShowFileHistory('${fileVo.fileSeq}', '${fileVo.fileId}');">이력보기</button> --%>
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

	<form name="replyForm" id="replyForm" action="ND_board.answer.do" method="post" enctype="multipart/form-data">
		<!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
		<op:pagerParam view="view" />

		<input type="hidden" name="domainCd" value='${dataVo.domainCd}' />
		<input type="hidden" name="bbsCd" value='${dataVo.bbsCd}' />
		<input type="hidden" name="bbscttSeq" value='${dataVo.bbscttSeq}' />

		<!-- 답변 달기 -->
		<fieldset class="mar_t20">
			<legend>답변 달기</legend>
			<table class="boardWrite" cellspacing="0" border="0" summary="${dataVo.bbscttSj} 답변달기 폼입니다.">
				<caption class="hidden">${dataVo.bbscttSj} 답변달기</caption>
				<colgroup>
					<col width="15%" />
					<col width="85%" />
				</colgroup>
				<tbody>
					<tr>
						<th><label for="mngrNm">작성자 <span class="tx_red tx_b">*</span></label></th>
						<td><input type="text" name="mngrNm" id="mngrNm" maxlength="10" value="${dataVo.mngrNm}" /></td>
					</tr>
					<%-- <tr>
						<th><label for="othbcAt">상태전환 <span class="tx_red tx_b">*</span></label></th>
						<td> 
							<input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt eq 'N'}"> checked='checked'</c:if> /><label for="othbcAtN">비공개</label>
							<input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${empty dataVo.othbcAt or dataVo.othbcAt eq 'Y'}"> checked='checked'</c:if> /><label for="othbcAtY">공개</label>
							<span class="tx_blue_s">- 내용에 따라 공개여부를 변경합니다.</span>
						</td>
					</tr> --%>
					<tr>
						<th><label for="estnColumn3">처리상태<span class="tx_red tx_b">*</span></label></th>
						<td>
							<input type="radio" name="estnColumn3" id="estnColumn3_N" value="N" ${dataVo.estnColumn3 eq 'N'? 'checked':'disabled'} /><label for="estnColumn3">처리중</label>
							<input type="radio" name="estnColumn3" id="estnColumn3_Y"  value="Y"<c:if test="${dataVo.estnColumn3 eq 'Y'}"> readonly="readonly" checked="checked"</c:if> /><label for="estnColumn3">처리완료</label>
							<span class="tx_blue_s">- 처리상태에 따라 사용자에게 노출여부와 처리상태수정이 제한됩니다.</span>
						</td>
					</tr>
					<tr>
						<th><label for="replyCn">답변 <span class="tx_red tx_b">*</span></label></th>
						<td><textarea name="replyCn" id="replyCn" rows="15" cols="30" class="w99_p">${dataVo.replyCn}</textarea></td>
					</tr>
				</tbody>
			</table>
		</fieldset>
	</form>

	<!-- 댓글 -->
	<c:if test="${boardConfVo.cmtYn eq 'Y'}">
		<br/><div id="attachedCommentsDiv" class="comment block"></div>
	</c:if>
	<!-- //댓글 -->

	<!-- 버튼 -->
	<div class="mar_t10">
		<div class="float_l mar_b10">
			<c:if test="${boardConfVo.listViewCd eq 1001}">
				<button type="button" class="w_blue mar_r5" onclick="jsView('${dataVo.prevVO.domainCd}', '${dataVo.prevVO.bbsCd}', '${dataVo.prevVO.bbscttSeq}', '${dataVo.prevVO.registPassword}', '${dataVo.prevVO.othbcAt}'); return false;">이전</button>
				<button type="button" class="w_blue mar_r5" onclick="jsView('${dataVo.nextVO.domainCd}', '${dataVo.nextVO.bbsCd}', '${dataVo.nextVO.bbscttSeq}', '${dataVo.nextVO.registPassword}', '${dataVo.nextVO.othbcAt}'); return false;">다음</button>
			</c:if>
		</div>
		<div class="float_r mar_b10">
			<c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'}">
				<button type="button" class="blue mar_l5" onclick="jsSubmit();">저장</button>
			</c:if>
			<button type="button" class="w_blue mar_r5" onclick="jsList('${param.q_currPage}'); return false;">목록</button>							
		</div>
	</div>
	<!-- //버튼 -->

	<!-- 목록 보여주기 시작 -->
	<form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
		<!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
		<op:pagerParam view="view" />

		<!-- 다음/이전을 목록으로 보기 -->
		<c:if test="${boardConfVo.listViewCd == 1003}">
			<!-- 목록 삽입 -->
			<p class="mar_t10">&nbsp;</p>
			<%@include file="INC_board.list.jsp" %>

			<!-- 페이징 영역 시작 -->
			<op:pager pager="${pager}" script="jsListReq" />
			<!-- 페이징 영역 끝 -->
		</c:if>
		<!-- 다음/이전을 목록으로 보기 -->

		<!-- 다음/이전을 다음/이전으로 보기 -->
		<c:if test="${boardConfVo.listViewCd == 1002}">
			<%@ include file="../common/INC_prev.next.list.jsp" %>
		</c:if>
		<!-- 다음/이전을 다음/이전으로 보기 끝 -->

		<input type="hidden" name="showSummaryYn" value="${param.showSummaryYn}" />
		<input type="hidden" name="listShowType" value="${param.listShowType}" />

		<input type="hidden" name="domainCd" value="${dataVo.domainCd}" />
		<input type="hidden" name="bbsCd" value="${dataVo.bbsCd}" />
		<input type="hidden" name="bbscttSeq" value="${dataVo.bbscttSeq}" />
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