<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!-- section -->
<div class="section mt20">
<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
<op:pagerParam page="param/webListPagerParam.jsp" />
	<!-- list -->
	<div class="thumb-list type-list">
		<ul>
			<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
				<li>
					<div class="thumb">
						<c:choose>
							<c:when test="${(baseVo.fileCnt > 0) && (baseVo.fileList[0].localNm != '')}">
								<%-- <a href="#" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;"> --%>
								<a href="BD_board.view.do?domainCd=${baseVo.domainCd}&bbsCd=${baseVo.bbsCd}&bbscttSeq=${baseVo.bbscttSeq}&monarea=00008" rel="#titleSummary${status.count}" class="contentTip" rel="#titleNoticeSummary${status.count}">
									<img src="<c:url value="${baseVo.fileList[0].fileUrl}" />" title="${baseVo.fileList[0].localNm}" alt="${baseVo.fileList[0].localNm}" width="239"/>
								</a>
							</c:when>
							<c:otherwise>
								<%-- <a href="#" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;"> --%>
								<a href="BD_board.view.do?domainCd=${baseVo.domainCd}&bbsCd=${baseVo.bbsCd}&bbscttSeq=${baseVo.bbscttSeq}&monarea=00008" rel="#titleSummary${status.count}" class="contentTip" rel="#titleNoticeSummary${status.count}">
									<img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지" />
								</a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="con">
						<p>
							<%-- <a href="#" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;"> --%>
							<a href="BD_board.view.do?domainCd=${baseVo.domainCd}&bbsCd=${baseVo.bbsCd}&bbscttSeq=${baseVo.bbscttSeq}&monarea=00008" rel="#titleSummary${status.count}" class="contentTip" rel="#titleNoticeSummary${status.count}">
								<strong> <c:out value='${fn:substring(baseVo.bbscttSj,0,45)}' /> 
									<c:if test="${baseVo.bbscttSjLength > 45}">...</c:if>
								</strong>
							</a>
						</p>
						<span class="date">
							&nbsp;&nbsp;<c:out value='${fn:substring(baseVo.registDt, 0, 10)}' />
						</span>
					</div>
				</li>
			</c:forEach>
			<!-- 데이터가 없을 때 알림 문구 -->
			<c:if test="${empty pager.list}">
				<li style="text-align: center;">데이터가 존재하지 않습니다.</li>
			</c:if>
		</ul>
	</div>
</div>


