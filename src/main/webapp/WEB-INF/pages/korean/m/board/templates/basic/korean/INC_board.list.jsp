<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>


<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
<op:pagerParam page="param/webListPagerParam.jsp" />

<!-- 모바일 지식나눔 / 행사이벤트 -->
<c:if test="${boardConfVo.bbsCd eq '1004' or boardConfVo.bbsCd eq '1007' or boardConfVo.bbsCd eq '1023' or boardConfVo.bbsCd eq '1024' or boardConfVo.bbsCd eq '1026' or boardConfVo.bbsCd eq '1029'}">
	<!-- list -->
	<div class="type-list">
		<ul>
			<c:set var="index" value="${pager.indexNo}" />
		  <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		    <fmt:parseDate value='${baseVo.registDt}' var='registDt' pattern="yyyy.MM.dd HH:mm" scope="page"/>
		    
		    <li>
			    <strong>
<%-- 			<a href="BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&monarea=00008" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;"> --%>
			    <a href="BD_board.view.do?domainCd=${baseVo.domainCd}&bbsCd=${baseVo.bbsCd}&bbscttSeq=${baseVo.bbscttSeq}&monarea=00008" rel="#titleSummary${status.count}" class="contentTip" >
			    <c:out value='${baseVo.bbscttSj}' />
			    <c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
			        
				  <!-- 첨부파일이 존재할 경우 이미지 노출 -->
				  <c:if test="${baseVo.fileCnt > 0}">
						<img alt="첨부된 이미지" class="ico" src="/resources/web/theme/default/images/common/ico/ico_image.gif">
				  </c:if>
				  <!-- //첨부파일이 존재할 경우 이미지 노출 -->
				    
				  <!-- 비공개 글 확인 -->
					<c:if test="${baseVo.othbcAt != 'Y'}">
						<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
					</c:if> 
					<!-- //비공개 글 확인 -->
					
					<!-- 댓글 갯수 -->
<!-- 
					<c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
					    [${baseVo.commentCnt}]
					</c:if> 
-->
				
					<c:if test="${boardConfVo.newArticleNum > 0}">
						<c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}"></c:if>
					</c:if>
					 
					<c:if test="${baseVo.othbcAt eq 'N'}">
						<div id="titleSummary${status.count}" class="tx_blue_s">* 비밀글 입니다. *</div>
					</c:if>
			    </a>
			    </strong>

			    <span>
				    <em><fmt:formatDate value="${registDt}" pattern="yyyy-MM-dd"/></em>
			    </span>
		    </li>
		    </c:forEach>
		</ul>
	</div>
	<!-- //list -->
</c:if>


<!-- 성공스토리 -->
<c:if test="${boardConfVo.bbsCd eq '1009'}">
	<!-- list -->
	<div class="type-list">
		<ul>
		<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		<fmt:parseDate value='${baseVo.registDt}' var='registDt' pattern="yyyy.MM.dd HH:mm" scope="page"/>
		    <li>
			    <strong>
			        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
			            <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}">
			                <c:choose>
							    <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
							        <a href="">[관리자에 의하여 삭제되었습니다.]</a>
								</c:when>
								<c:otherwise>
								    <a href="#" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
								    <c:out value='${fn:substring(baseVo.bbscttSj,0,45)}' /><c:if test="${baseVo.bbscttSjLength > 45}">...</c:if>
								    </a>
									<c:if test="${baseVo.othbcAt != 'Y'}">
										<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
									</c:if>
								</c:otherwise>
			                </c:choose>
			            </c:if>
			        </c:forEach>
			    </strong>
			    <span>
				    <a href=""><c:out value='${baseVo.cnSumry}'/></a>
				    <em><fmt:formatDate value="${registDt}" pattern="yyyy-MM-dd"/></em>
			    </span>
		    </li>
		</c:forEach>

		</ul>
	</div>
	<!-- //list -->
</c:if>

<!-- 공지사항 -->
<c:if test="${boardConfVo.bbsCd eq '1001'}">
	<!-- list -->
	<div class="type-list">
		<ul>
		<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		<fmt:parseDate value='${baseVo.registDt}' var='registDt' pattern="yyyy.MM.dd HH:mm" scope="page"/>
		    <li>
			    <strong>
			        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
			            <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}">
			                <c:choose>
							    <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
							        <a href="">[관리자에 의하여 삭제되었습니다.]</a>
								</c:when>
								<c:otherwise>
								    <a href="#" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
								    <c:out value='${fn:substring(baseVo.bbscttSj,0,45)}' /><c:if test="${baseVo.bbscttSjLength > 45}">...</c:if>
								    </a>
									<c:if test="${baseVo.othbcAt != 'Y'}">
										<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
									</c:if>
								</c:otherwise>
			                </c:choose>
			            </c:if>
			        </c:forEach>
			    </strong>
			    <span>
			        <em><strong>${baseVo.ctgNm}</strong><fmt:formatDate value="${registDt}" pattern="yyyy-MM-dd"/></em>
			    </span>
		    </li>
		</c:forEach>

		</ul>
	</div>
	<!-- //list -->
</c:if>
