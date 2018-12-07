<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title></title>

	<op:jsTag type="spi" items="form,  ui, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">
	var cmtTabz;

	$().ready(function(){
		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType			= "<c:out value='${pageType}'/>";
		OpenWorks.boardType			= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.boardNm			= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.useCategory		= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn			= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.filePermExtsn		= "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.captchaYn			= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.rdcntIncrsLmttTime= "<c:out value='${boardConfVo.rdcntIncrsLmttTime}'/>";
		OpenWorks.cmtYn			    = "<c:out value='${boardConfVo.cmtYn}'/>";
		OpenWorks.bbsCd				= "<c:out value='${dataVo.bbsCd}'/>";
		OpenWorks.domainCd			= "<c:out value='${dataVo.domainCd}'/>";
		OpenWorks.bbscttSeq			= "<c:out value='${dataVo.bbscttSeq}'/>";
		OpenWorks.searchVal			= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey			= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName			= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder			= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.tagYn				= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.listViewCd		= "<c:out value='${boardConfVo.listViewCd}'/>";
		OpenWorks.showSummaryYn		= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.isSession			= "<c:out value='${!empty __usk}'/>";
		OpenWorks.section        	= "<c:out value='${section}'/>";

		onReadyEventFunctions();
	 });
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>

	<div class="contents">
				<!-- title-area -->
				<div class="title-area">
					<h2>묻고 답하기</h2>					
				</div>
				<!-- //title-area -->
				
					<!-- section -->
					<div class="section">
					<div class="type-view">
					<!-- 답변 달기 -->
				
			        <c:if test="${not empty dataVo.replyDt and not empty dataVo.replyCn }">
			            <table>
			                <caption>
				                <strong>${dataVo.bbscttSj} 답변달기</strong>
				                <details>
				                    <summary>${dataVo.bbscttSj} 답변달기 폼입니다.</summary>
				                </details>
				            </caption>
			                <colgroup>
			                    <col style="width:130px;"/>
								<col style="width:;"/>
			                </colgroup>
			                <tbody>
			                    <tr>
			                        <td>작성일</td>
			                        <td><c:out value='${dataVo.replyDt}'/></td>
			                    </tr>
			                    <tr>
			                        <td colspan="2"><c:out value='${dataVo.replyCn}' escapeXml="false"/></td>
			                    </tr>
			                </tbody>
			            </table>
	       			 </c:if>
	       			 <c:if test="${empty dataVo.replyDt and empty dataVo.replyCn }">
	       			  <table>
	       			  <tr>
	       			 <th><span class="caption">답글이 존재하지 않습니다.</span></th>
	       			 </tr>
	       			 </table>
	       			 </c:if> 
					</div>	
				
					<div class="type-view02">
						<table>
							<caption>답변</caption>
							<colgroup>
							<col style="width:130px;" />
							<col style="width:;" />
							<col style="width:130px;" />
							<col style="width:;" />
							</colgroup>
							<tbody>
								<c:set var="scoreRow" value="1" />
				                <c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
				                    <c:choose>
				                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
				                            <!-- 제목 -->
				                                <tr>
				                                    <td class="tit">제목</td>
				                                    <td class="last" colspan="3"> <c:out value='${dataVo.bbscttSj}'/></td>
				                                </tr>
				                        </c:when>
				                        <c:when test="${arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'OTHBC_AT'}">
				                            <c:if test="${arrange.columnId eq 'REGIST_ID'}"><!-- 등록자명 -->
				                                <tr>
				                                    <td class="tit">작성자ID</td>
				                                    <c:choose>
				                                        <c:when test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
						                                    <td><c:out value='${dataVo.registId}'/></td>
				                                        </c:when>
				                                        <c:otherwise>
						                                    <td><c:out value='${dataVo.maskRegistId}'/></td>
				                                        </c:otherwise>
				                                    </c:choose>
				                            </c:if>
				                            <c:if test="${arrange.columnId eq 'OTHBC_AT'}"><!-- 공개여부 -->
				                                    <td class="tit">공개여부</td>
				                                    <td class="last">
				                                        <c:if test="${dataVo.othbcAt eq 'N'}"> 비공개</c:if>
				                                        <c:if test="${dataVo.othbcAt eq 'Y'}"> 공개</c:if>
				                                    </td>
				                                </tr>
				                            </c:if>
				                        </c:when>
				                        <c:when test="${arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'ESTN_COLUMN3'}">
				                            <c:if test="${arrange.columnId eq 'REGIST_DT'}"><!-- 등록일 -->
				                                <tr>
				                                    <td class="tit">작성일</td>
				                                    <td><c:out value='${dataVo.registDt}'/></td>
				                            </c:if>
				                            <c:if test="${arrange.columnId eq 'ESTN_COLUMN3'}"><!-- 상태 -->
				                                    <td class="tit">상태</td>
				                                    <td class="last">
				                                        <c:if test="${dataVo.estnColumn3 eq 'N'}">답변미완료</c:if>
				                                        <c:if test="${dataVo.estnColumn3 eq 'Y'}">답변완료</c:if>
				                                    </td>
				                                </tr>
				                            </c:if>
				                        </c:when>
				                        
				                        <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
				                            <!-- 첨부파일 -->
				                            <c:if test="${!empty dataVo.fileList}">
				                                <tr>
				                                    <td class="tit"><label for="${arrange.beanNm}">첨부파일</label></td>
				                                    <td class="last" colspan="3">
				                                        <c:if test="${fn:length(dataVo.fileList) > 0}">
				                                           <div class="add_file">
				                                             <c:forEach items="${dataVo.fileList}" var="fileVo">
				                                                 <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})
				                                             </c:forEach>
				                                            </div>
				                                        </c:if>
				                                    </td>
				                                </tr>
				                            </c:if>
				                        </c:when>
				                        
				                        <c:when test="${arrange.columnId eq 'BBSCTT_CN'}"><!-- 내용 -->
				                        <tr>
				                            <td class="cont_view" colspan="4"><c:out value='${dataVo.bbscttCn}' escapeXml="false" /></td>
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
				                                <c:if test="${!empty dataVo.bbsTags}">
				                                    <img src="/resources/openworks/theme/default/images/icon/icon_tag.gif" alt="태그" class="vm" />
				                                    <c:forEach var="tag" items="${dataVo.bbsTags}" varStatus="status">
				                                        <a href="#" onclick="jsShowBbsListByTag('<c:out value='${tag}'/>')">${tag}</a> <c:if test="${not status.last}">|</c:if>
				                                    </c:forEach>
				                                </c:if>
				                            </div>
				                        </td>
				                    </tr>
				                </c:if>
							</tbody>
						</table>
						<!-- //답변 -->
					</div>
					<!-- btn area -->
					<div class="btn-area ar mt20 btn_l ${empty dataVo.replyDt and empty dataVo.replyCn? 'btn_l':'btn_r' }">
						<p class="fl">
						<a href="#" onclick="jsList('1');" class="b-btn fl list type1"><strong><span>목 록</span></strong></a>
						</p>
						<!-- 수정 삭제 버튼 -->
						<c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
							<c:if test="${empty dataVo.replyDt and empty dataVo.replyCn }"> <!-- 답변이 없는경우에만 가능  -->
							<p class="fr">
								<a class="b-btn edit type1" onclick="jsUpdateForm('UPDATE');" href="#"><strong><span class="ml10 mr10">수 정</span></strong></a>
								<a class="b-btn update type1" onclick="jsDelete();" href="#"><strong><span class="ml10 mr10">삭 제</span></strong></a>
							</p>
							</c:if>
						</c:if>
						<!-- /수정 삭제 버튼 -->
					</div>
					<!-- //btn area -->
				</div>
				<!-- //section -->

				<!-- 이전/다음글 -->
				<div class="section mt30">
					<!-- 목록 보여주기 시작 -->
				    <!-- 목록 보여주기 시작 -->
				    <form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
				
				        <!-- 다음/이전을 다음/이전으로 보기 -->
				        <%@include file="/WEB-INF/pages/web/board/templates/common/korean/INC_prev.next.list.jsp" %>
				        <!-- 다음/이전을 다음/이전으로 보기 끝 -->
				
				        <input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}' />" />
				        <input type="hidden" name="listShowType" value="<c:out value='${param.listShowType}' />" />
				
				        <input type="hidden" name="section" value="<c:out value='myboardQ'/>" />
				        <input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}'/>" />
				        <input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>" />
				        <input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}'/>" />
				        <input type="hidden" name="refrnSeq" value="<c:out value='${dataVo.refrnSeq}'/>" />
				        <input type="hidden" name="registPassword" value="<c:out value='${dataVo.registPassword}' />" />
				
				        <input type="hidden" name="iconKey" value="<c:out value=''/>" />
				        <input type="hidden" name="contents" value="<c:out value=''/>" />
				        <input type="hidden" name="ctgCd" id="ctgCd" value="<c:out value='${dataVo.ctgCd}' />" />
				        <input type="hidden" name="pageType" id="pageType" value="<c:out value=''/>" />
				
				        <!-- 이동옵션 -->
				        <input type="hidden" name="toBbsCd" id="toBbsCd" value="<c:out value=''/>" />
				        <input type="hidden" name="newCtg" id="newCtg" value="<c:out value='-1'/>" />
				        <input type="hidden" name="delDesc" id="delDesc" value="<c:out value=''/>" />
				        <input type="hidden" name="isMove" id="isMove" value="<c:out value=''/>" />
				    </form>
				</div>
				<!-- //이전/다음글 -->

			</div>
	
</body>
</html>