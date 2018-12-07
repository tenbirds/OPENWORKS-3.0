<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<%-- 항목 표시 수 --%>
<c:set var="thCnt" value="0" />

<!-- 리스트 -->
<table class="gray_list" cellspacing="0" border="0" summary="기본게시판 목록으로 번호,분류,제목,작성자,작성일 등의 조회 정보를 제공합니다.">
	<caption class="hidden">기본게시판 목록</caption>
	<colgroup>
		<!-- 번호(필수) -->
		<c:set var="thCnt" value="${thCnt + 1}" />
		<col width="6%" />

		<!-- 목록 배치에서 설정한 항목 배치 -->
		<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
			<c:set var="thCnt" value="${thCnt + 1}" />
			<c:if test="${arrange.columnId eq 'BBSCTT_SJ'}"><col width="*" /></c:if>
			<c:if test="${arrange.columnId != 'BBSCTT_SJ'}"><col width="10%" /></c:if>
		</c:forEach>
	</colgroup>
	<thead>
		<tr>
			<!-- 번호(필수) -->
			<th id="th-ROWNUM"><span class="sort cs_pointer" id="ROWNUM">번호</span></th>

			<!-- 목록 배치에서 설정한 항목 배치 -->
			<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
				<th id="th-${arrange.columnId}"<c:if test="${status.last}"> class="lr_none"</c:if>><span class="sort cs_pointer" id="${arrange.columnId}">${arrange.columnNm}</span></th>
			</c:forEach>
		</tr>
	</thead>
	<tbody id="odd-color">
		<!-- 공지 목록  -->
		<c:if test="${boardConfVo.noticeBbscttUseYn eq 'Y'}">

			<c:forEach items="${noticeList}" var="noticeVo" varStatus="status">

				<c:set var="trClass" value="bg_blue" />
				<c:if test="${(pageType == 'VIEW') && (dataVo.bbscttSeq == noticeVo.bbscttSeq)}">
					<c:set var="trClass" value="tr-sel" />
				</c:if>

				<tr class="${trClass}">
					<!-- 번호(필수) -->
					<td>
						<c:choose>
							<c:when test="${(pageType eq 'VIEW') && (noticeVo.bbscttSeq eq dataVo.bbscttSeq)}">
								<img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png' />" alt="현재글" />
							</c:when>
							<c:otherwise>
								<img src="<c:url value='/resources/web/theme/default/images/icon/icon_notice.gif' />" alt="공지글" />
							</c:otherwise>
						</c:choose>
					</td>

					<!-- 목록 배치에서 설정한 항목 배치 -->
					<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
						<c:choose>
							<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
								<td class="tx_l<c:if test="${arrStatus.last}"> lr_none</c:if>">
									<a href="#" rel="#titleNoticeSummary${status.count}" class="contentTip">${noticeVo.bbscttSj}</a>

									<c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>

									<c:choose>
										<c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
											<a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a>
										</c:when>
										<c:when test="${noticeVo.fileCnt > 0}">
											<span class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</span>
										</c:when>
									</c:choose>

									<c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
										<span class="t_reply" title="의견글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span>
									</c:if>

									<c:if test="${boardConfVo.newArticleNum > 0}">
										<c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
											<img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/>
										</c:if>
									</c:if>
								</td>
							</c:when>
							<c:when test="${arrange.columnId eq 'CTG_CD'}">
								<td><span class="label_notice">공지</span></td>
							</c:when>
							<c:when test="${arrange.columnId eq 'RDCNT'}">
								<td>
									<c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}"><span class="tx_blue">${noticeVo.rdcnt}</span></c:if>
									<c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}"><span>${noticeVo.rdcnt}</span></c:if>
								</td>
							</c:when>
							<c:otherwise>
								<td><op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tr>
				<tr id="noticd_${noticeVo.bbscttSeq}" style="display:none;">
					<td class="faq_left"></td>
					<td colspan="${thCnt - 1}" class="faq">
						${noticeVo.contents}
					</td>
				</tr>
			</c:forEach>
		</c:if>

		<!-- 공지 제외 게시물 목록 -->
		<c:set var="index" value="${pager.indexNo}"/>
		<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			<tr>
				<!-- 번호(필수) -->
				<td>
					<c:choose>
						<c:when test="${(pageType eq 'VIEW') && (baseVo.bbscttSeq eq dataVo.bbscttSeq)}">
							<img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png' />" alt="현재글" />
						</c:when>
						<c:otherwise>
							${index-status.index}
						</c:otherwise>
					</c:choose>
				</td>

				<!-- 목록 배치에서 설정한 항목 배치 -->
				<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
					<c:choose>
						<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
							<td class="tx_l<c:if test="${arrStatus.last}"> lr_none</c:if>">
								<c:choose>
									<c:when test="${baseVo.mngrDelAt eq 'Y'}">
										<p class="tx_blue_l">[관리자에 의하여 삭제되었습니다.]</p>
									</c:when>
									<c:otherwise>
												<a href="#" rel="#contents_${baseVo.bbscttSeq}" class="contentTip">${baseVo.bbscttSj}</a>

												<c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>

												<c:choose>
													<c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
														<a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
													</c:when>
													<c:when test="${baseVo.fileCnt > 0}">
														<span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span>
													</c:when>
												</c:choose>

												<c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
													<span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span>
												</c:if>

												<c:if test="${boardConfVo.newArticleNum > 0}">
													<c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
												   		<img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/>
												   	</c:if>
												</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</c:when>
						<c:when test="${arrange.columnId eq 'CTG_CD'}">
							<td>${baseVo.ctgNm}</td>
						</c:when>
						<c:when test="${arrange.columnId eq 'RDCNT'}">
							<td>
								<c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}"><span class="tx_blue">${baseVo.rdcnt}</span></c:if>
								<c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}"><span>${baseVo.rdcnt}</span></c:if>
							</td>
						</c:when>
						<c:otherwise>
							<td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
			<tr id="contents_${baseVo.bbscttSeq}" style="display:none;">
				<td class="faq_left"></td>
				<td colspan="${thCnt - 1}" class="faq">
					${baseVo.contents}
				</td>
			</tr>
		</c:forEach>

		<c:if test="${empty pager.list}">
			<op:no-data obj="${pager}" colspan="${thCnt}" />
		</c:if>

	</tbody>
</table>
<!-- //리스트 -->