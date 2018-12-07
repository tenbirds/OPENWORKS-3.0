<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title></title>

	<op:jsTag type="spi" items="form, highlight, ui, validate, cookie" />
	<op:jsTag type="openworks" items="ui" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/intra/board/board.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/intra/board/boardcmt.js"></script>

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
        OpenWorks.domainCd          = '${dataVo.domainCd}';
		OpenWorks.bbsCd				= '${dataVo.bbsCd}';
		OpenWorks.bbscttSeq			= '${dataVo.bbscttSeq}';
		OpenWorks.searchVal			= '${param.q_searchVal}';
		OpenWorks.searchKey			= '${param.q_searchKey}';
		OpenWorks.sortName			= '${param.q_sortName}';
		OpenWorks.sortOrder			= '${param.q_sortOrder}';
		OpenWorks.tagYn				= "${boardConfVo.tagYn}";
		OpenWorks.listViewCd		= '${boardConfVo.listViewCd}';
		OpenWorks.showSummaryYn		= '${param.showSummaryYn}';
		OpenWorks.closeFileIcon		= "<c:url value='/resources/openworks/theme/default/images/btn/btn_r_close.gif' />";
		OpenWorks.maxFileCnt		= '${boardConfVo.maxFileCnt}';

		onReadyEventFunctions();
	 });
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>
			<div class="supAdm proCouDetail">
				<table class="tbl_st4">
					<!-- 상세 배치에서 설정한 항목 배치 -->
					<tr>
						<th>연결된 카테고리</th>
						<td colspan="7">
							<c:if test="${not empty dataVo.ctgryList}">
								<c:forEach items="${dataVo.ctgryList}" var="ctgryVo" varStatus="status">
                                   	[${ctgryVo.ctgryClNm }]${ctgryVo.ctgryPath }<c:if test="${!status.last}">, </c:if>
                                   </c:forEach>
                                  </c:if>
                                  <c:if test="${empty dataVo.ctgryList}">등록하신 카테고리를 찾을수없습니다.</c:if>
						</td>
					</tr>
					<c:set var="scoreRow" value="1" />
					<c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
						<c:choose>
							<c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
								<tr>
									<th>희망 답변자</th>
									<td colspan="7">${dataVo.estnColumn2}</td>
								</tr>
							</c:when>
							<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">	
								<tr>
									<th>${arrange.columnNm}</th>
									<td colspan="7">${dataVo.bbscttSj}</td>
								</tr>
							</c:when>
							<c:when test="${arrange.columnId eq 'REGISTER_NM' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'ESTN_COLUMN6'}">	
								<c:if test="${arrange.columnId eq 'REGISTER_NM'}">
								<tr>
									<th>${arrange.columnNm}</th>
									<td>${dataVo.registerNm}</td>
								</c:if>
								<c:if test="${arrange.columnId eq 'REGIST_DT'}">
									<th>${arrange.columnNm}</th>
									<td>${dataVo.registDt}</td>
								</c:if>
								<c:if test="${arrange.columnId eq 'ESTN_COLUMN6'}">
									<th>${arrange.columnNm}</th>
									<td>${dataVo.estnColumn6}</td>
									<th>상태</th>
									<td>
										<c:if test="${dataVo.bizProgression eq 'COM'}">완료</c:if>
										<c:if test="${dataVo.bizProgression eq 'INC'}">미완료</c:if>
										<c:if test="${dataVo.bizProgression eq 'PRO'}">진행중</c:if>
									</td>
								</tr>
								</c:if>
							</c:when>
							<c:when test="${arrange.columnId eq 'CTG_CD'}">
							<!-- 분류 -->
								<c:if test="${boardConfVo.ctgYn eq 'Y'}">
									<tr>
										<th>${arrange.columnNm}</th>
										<td colspan="7">${dataVo.ctgNm} [${dataVo.ctgCd}]</td>
									</tr>
								</c:if>
							</c:when>
							<c:when test="${arrange.columnId eq 'RECOMEND_CNT'}">
							<!-- 추천 -->
								<c:if test="${boardConfVo.recomendYn eq 'Y'}">
									<tr>
										<th>${arrange.columnNm}</th>
										<td colspan="7">
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
										<th>${arrange.columnNm}</th>
										<td colspan="7">
											<input type="button" id="accuseBtn" class="s_blue vm" value="신고 ${dataVo.accuseCnt}" onclick="jsClickAccuseAction(this, ${dataVo.bbsCd}, '${dataVo.bbscttSeq}', ${boardConfVo.rdcntIncrsLmttTime});" />
											<script type="text/javascript">$("#accuseBtn").val("신고 ${dataVo.accuseCnt}");</script>
										</td>
									</tr>
								</c:if>
							</c:when>
							<c:when test="${arrange.columnId eq 'BBSCTT_CN'}">
							<!-- 내용 -->
								<tr>
									<th>${arrange.columnNm}</th>
									<td colspan="7"><op:bean-util field="${arrange.columnId}" obj="${dataVo}"/></td>
								</tr>
							</c:when>
							<c:when test="${arrange.columnId eq 'FILE_SEQ'}">
							<!-- 첨부파일 -->
								<c:if test="${!empty dataVo.fileList}">
									<tr>
										<th>첨부파일</th>
										<td colspan="7" class="addFile">
											<c:choose>
												<c:when test="${fn:length(dataVo.fileList) > 0}">
													<c:forEach items="${dataVo.fileList}" var="fileVo">
														<a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">
														${fileVo.localNm} (${fileVo.fileSize})
														</a>
													</c:forEach>
												</c:when>
												<c:otherwise>
													첨부파일이 없습니다.
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:if>
							</c:when>
							<c:otherwise>
							<!-- 기타 항목 -->
								<tr>
									<th>${arrange.columnNm}</th>
									<td colspan="7"><op:bean-util field="${arrange.columnId}" obj="${dataVo}"/></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<!-- 태그 -->
					<c:if test="${boardConfVo.tagYn eq 'Y'}">
						<tr>
							<td colspan="8">
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
				</table>
				
				<div class="btnArea rig">
					<c:if test="${boardConfVo.listViewCd eq 1001}">
						<a href="javascript:;" onclick="jsView('${dataVo.prevVO.domainCd}','${dataVo.prevVO.bbsCd}', '${dataVo.prevVO.bbscttSeq}', '${dataVo.prevVO.registPassword}', '${dataVo.prevVO.othbcAt}'); return false;" class="btns st1 icn icnPre">이전</a>
						<a href="javascript:;" onclick="jsView('${dataVo.nextVO.domainCd}','${dataVo.nextVO.bbsCd}', '${dataVo.nextVO.bbscttSeq}', '${dataVo.nextVO.registPassword}', '${dataVo.nextVO.othbcAt}'); return false;" class="btns st1 icn_r icnNext">다음</a>
					 </c:if>
					<a href="javascript:;" onclick="jsList('${param.q_currPage}');" class="btns st1 icn icnList">목록보기</a>
					<%-- #이전에 있던 소스 : 디자인에 고려되어있지 않아 주석처리
					<c:if test="${MenuAssignType eq 'A' or MenuAssignType eq 'G'}">
						<!-- <button type="button" class="blue mar_l5" onclick="jsInsertForm('INSERT');">등록</button> -->
					</c:if>
					<c:if test="${(MenuAssignType eq 'A' && dataVo.registId eq __msk.mngrId) or MenuAssignType eq 'G'}">
					<a href="#" class="b-btn type2" onclick="jsUpdateForm('UPDATE');"><strong><span class="ml20 mr20" >수 정</span></strong></a>
					<a href="#" class="b-btn type3" onclick="jsDelete();"><strong><span class="ml20 mr20">삭 제</span></strong></a>
						<c:if test="${empty dataVo.mngrDeleteAt or dataVo.mngrDeleteAt eq 'N'}">
							<button type="button" class="blue mar_l5" onclick="jsFlagDelete();">삭제</button>
						</c:if>
					</c:if>
					 --%>
				</div>
				<!-- 댓글 -->
			    <c:if test="${boardConfVo.cmtYn eq 'Y'}">
			        <%-- <div id="tab_div" class="w_99p mar_t20">
			            <ul class="list">
			                <li class="tx_13"><a href="<c:url value="/intra/board/INC_cmt.list.do"/>?bbsCd=${dataVo.bbsCd}&bbscttSeq=${dataVo.bbscttSeq}" class="on"><span>댓글 : <span id="cmtCnt" class="tx_orange_u">${dataVo.commentCnt}</span>개</span></a></li>
			            </ul>
			        </div><br/> --%>
			        <%-- <c:if test="${dataVo2.userTyCd eq '2002'}"> --%>
			        	<div id="attachedCommentsDiv" class="comment_wrap block"></div>
			        <%-- </c:if> --%>
			    </c:if>
			    <!-- //댓글 -->
			</div>


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
				
		        <input type="hidden" name="domainCd" id="domainCd" value="${dataVo.domainCd}" />
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