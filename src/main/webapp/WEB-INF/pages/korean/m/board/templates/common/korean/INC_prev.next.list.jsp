<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- 이전/다음 목록 시작 -->
    <div class="type-view">
	<table>
		<caption>
		    <strong>이전글 다음글 목록입니다. </strong>
		    <details>
		        <summary>이전글,다음글의 제목, 등록일을 보여줍니다.</summary>
		    </details>
		</caption>
		<colgroup>
		<c:choose>
		  <c:when test="${boardConfVo.bbsCd eq '1003' }">
		      <col style="width:20%;">
              <col style="width:*;">
              <col style="width:12%;">
              <col style="width:12%;">
              <col style="width:20%;">
		  </c:when>
		  <c:otherwise>
			<col style="width:15%">
			<col style="width:*">
			<col style="width:15%">
			<col style="width:18%">
		  </c:otherwise>
		</c:choose>
		</colgroup>
		<tbody>
			<tr>
			    <td><span class="prev"> < 이전글</span></td>
				<!-- 이전글 -->
			    <c:if test="${empty dataVo.prevVO}"><td class="t_al" colspan="${boardConfVo.bbsCd eq '1003'? '4':'3'}">이전글이 없습니다.</td></c:if>
				<c:if test="${!empty dataVo.prevVO}">
					<c:choose>
						<c:when test="${dataVo.prevVO.mngrDeleteAt eq 'Y'}">
						  <td class="t_al">[관리자에 의하여 삭제되었습니다.]</td>
						</c:when>
						<c:otherwise>
							<td class="tl">
								<a href="#" onclick="jsView('${dataVo.prevVO.domainCd}','${dataVo.prevVO.bbsCd}', '${dataVo.prevVO.bbscttSeq}', '${dataVo.prevVO.registPassword}', '${dataVo.prevVO.othbcAt}'); return false;">
								<c:out value='${fn:substring(dataVo.prevVO.bbscttSj,0,45)}'/><c:if test="${dataVo.prevVO.bbscttSjLength > 45}">...</c:if>
								</a>
								<!-- 비공개 글 여부 -->
								<c:if test="${dataVo.prevVO.othbcAt eq 'N'}">
								  <span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
								</c:if>
								<!-- 첨부파일 갯수 -->
								<c:if test="${boardConfVo.fileYn eq 'Y' && dataVo.prevVO.fileCnt > 0}">
								  <span class="t_file" title="첨부파일이 ${dataVo.prevVO.fileCnt}개 존재합니다."><img alt="첨부된 이미지" src="/resources/web/theme/default/images/common/ico/ico_image.gif"></span>
								</c:if>
								<!-- 코멘트 갯수 -->
								<c:if test="${boardConfVo.cmtYn eq 'Y' && dataVo.prevVO.commentCnt > 0}">
								  <span class="num" title="의견글이 ${dataVo.prevVO.commentCnt}개 존재합니다.">[<c:out value='${dataVo.prevVO.commentCnt}'/>]</span>
								</c:if>
								<!-- 새글 여부 -->
								<c:if test="${boardConfVo.newArticleNum > 0}">
									<c:if test="${dataVo.prevVO.passDay <= boardConfVo.newArticleNum}">
<!-- 									  <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
									</c:if>
								</c:if>
							</td>
							<c:choose>
							    <c:when test="${boardConfVo.othbcYn eq 'Y'}">
	                                <c:if test="${ dataVo.prevVO.othbcAt eq 'Y'}">
	                                   <td class="fc_brown">비공개</td>
	                                </c:if>
	                                <c:if test="${ dataVo.prevVO.othbcAt eq 'N'}">
    									<td>공개</td>
	                                </c:if>
							    </c:when>
							    <c:otherwise>
									<td><c:out value='${dataVo.prevVO.maskRegistId}'/></td>
							    </c:otherwise>
							</c:choose>
                            <c:if test="${boardConfVo.bbsCd eq '1003'}">
								<td class="${dataVo.prevVO.estnColumn3 eq 'N' ? 'fc_brown':'' }">
                                    <c:if test="${dataVo.prevVO.estnColumn3 eq 'Y'}">답변완료</c:if>
                                    <c:if test="${dataVo.prevVO.estnColumn3 eq 'N'}">답변미등록</c:if>
                                </td>
                            </c:if>
							<td class="date"><c:out value='${dataVo.prevVO.registDt}'/></td>
						</c:otherwise>
					</c:choose>
				</c:if>
			</tr>
			<tr>
				<td><span class="next"> > 다음글</span></td>
				<c:if test="${empty dataVo.nextVO}"> <td class="t_al" colspan="${boardConfVo.bbsCd eq '1003'? '4':'3'}">다음글이 없습니다.</c:if>
				<c:if test="${!empty dataVo.nextVO}">
					<c:choose>
						<c:when test="${dataVo.nextVO.mngrDeleteAt eq 'Y'}">
						   <td class="t_al">[관리자에 의하여 삭제되었습니다.]</td>
						</c:when>
						<c:otherwise>
							<td class="t_al">
								<a href="#" onclick="jsView('${dataVo.nextVO.domainCd}','${dataVo.nextVO.bbsCd}', '${dataVo.nextVO.bbscttSeq}', '${dataVo.nextVO.registPassword}', '${dataVo.nextVO.othbcAt}'); return false;">
								<c:out value='${fn:substring(dataVo.nextVO.bbscttSj,0,45)}'/><c:if test="${dataVo.nextVO.bbscttSjLength > 45}">...</c:if>
								</a>
								<!-- 비공개 글 여부 -->
								<c:if test="${dataVo.nextVO.othbcAt eq 'N'}">
								  <span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
								</c:if>
								<!-- 첨부파일 갯수 -->
								<c:if test="${boardConfVo.fileYn eq 'Y' && dataVo.nextVO.fileCnt > 0}">
								  <span class="t_file" title="첨부파일이 ${dataVo.nextVO.fileCnt}개 존재합니다."><img alt="첨부된 이미지" src="/resources/web/theme/default/images/common/ico/ico_image.gif"></span>
								</c:if>
								<!-- 코멘트 갯수 -->
								<c:if test="${boardConfVo.cmtYn eq 'Y' && dataVo.nextVO.commentCnt > 0}">
								  <span class="num" title="의견글이 ${dataVo.nextVO.commentCnt}개 존재합니다.">[${dataVo.nextVO.commentCnt}]</span>
								</c:if>
								<!-- 새글 여부 -->
								<c:if test="${boardConfVo.newArticleNum > 0}">
									<c:if test="${dataVo.nextVO.passDay <= boardConfVo.newArticleNum}">
<!-- 									  <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
									</c:if>
								</c:if>
							</td>
							<c:choose>
                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
                                    <c:if test="${ dataVo.nextVO.othbcAt eq 'Y'}">
                                       <td class="fc_brown">비공개</td>
                                    </c:if>
                                    <c:if test="${ dataVo.nextVO.othbcAt eq 'N'}">
                                        <td>공개</td>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <td><c:out value='${dataVo.nextVO.maskRegistId}'/></td>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${boardConfVo.bbsCd eq '1003'}">
                                <td class="${dataVo.nextVO.estnColumn3 eq 'N' ? 'fc_brown':'' }">
                                    <c:if test="${dataVo.nextVO.estnColumn3 eq 'Y'}">답변완료</c:if>
                                    <c:if test="${dataVo.nextVO.estnColumn3 eq 'N'}">답변미등록</c:if>
                                </td>
                            </c:if>
							<td class="date"><c:out value='${dataVo.nextVO.registDt}'/></td>
						</c:otherwise>
					</c:choose>
				</c:if>
			</tr>
		</tbody>
	</table>
	</div>
	<!-- //이전글, 다음글 -->

