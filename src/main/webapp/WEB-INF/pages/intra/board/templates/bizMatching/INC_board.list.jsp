<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<%-- 항목 표시 수 --%>
<c:set var="thCnt" value="0" />

<!-- 리스트 -->
<table class="boardList" cellspacing="0" border="0" summary="기본게시판 목록으로 순번,분류,제목,작성자,작성일 등의 조회 정보를 제공합니다.">
	<caption class="hidden">기본게시판 목록</caption>
	<colgroup>
		<!-- 삭제/이동 등을 위한 체크박스 (목록 필수) -->
		<c:if test="${pageType eq 'LIST'}">
			<c:set var="thCnt" value="${thCnt + 1}" />
			<col width="6%" />
		</c:if>

		<!-- 순번(필수) -->
		<c:set var="thCnt" value="${thCnt + 1}" />
		<col width="6%" />

        
		<!-- 목록 배치에서 설정한 항목 배치 -->
		<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
			<c:set var="thCnt" value="${thCnt + 1}" />
			<c:if test="${arrange.columnId eq 'BBSCTT_SJ'}"><col width="*" /></c:if>
			<c:if test="${arrange.columnId != 'BBSCTT_SJ'}"><col width="10%" /></c:if>
		</c:forEach>
		
		<!-- 상태여부 -->
		<c:set var="thCnt" value="${thCnt + 2}" />
		<col width="10%" />
		<col width="10%" />
		
	</colgroup>
	<thead>
		<tr>
			<!-- 삭제/이동 등을 위한 체크박스 (목록 필수) -->
			<c:if test="${pageType eq 'LIST'}">
				<th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th>
			</c:if>

			<!-- 순번(필수) -->
			<th id="th-ROWNUM"><span class="sort cs_pointer" id="ROWNUM">순번</span></th>
			
			<!-- 목록 배치에서 설정한 항목 배치 -->
			<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
				<th id="th-${arrange.columnId}"><span class="sort cs_pointer" id="${arrange.columnId}">${arrange.columnNm}</span></th><!-- <c:if test="${status.last}"> class="lr_none"</c:if> -->
			</c:forEach>
			
			<!-- 상태여부,매칭수 -->
			<th id="th-COMMENT_CNT"><span class="sort cs_pointer" id="COMMENT_CNT">매칭수</span></th>
            <th id="th-ESTN_COLUMN5"><span class="sort cs_pointer" id="ESTN_COLUMN5">선정여부</span></th>
            <th id="th-BIZ_PROGRESSION"><span class="sort cs_pointer" id="BIZ_PROGRESSION">상태</span></th>
			
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
					<!-- 삭제/이동 등을 위한 체크박스 (목록 필수) -->
					<c:if test="${pageType eq 'LIST'}">
						<td>
							<input type="checkbox" name="bbscttSeqs" value="${noticeVo.bbscttSeq}" class="checkbox" />
							<input type="hidden" id="noticeBbscttAt_${noticeVo.bbscttSeq}" name="chknoticeBbscttUseYn" value="${noticeVo.noticeBbscttAt}" />
						</td>
					</c:if>

					<!-- 순번(필수) -->
					<td>
						<c:choose>
							<c:when test="${(pageType eq 'VIEW') && (noticeVo.bbscttSeq eq dataVo.bbscttSeq)}">
								<img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_current.png' />" ></img>
							</c:when>
							<c:otherwise>
								<img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_notice2.gif' />" ></img>
							</c:otherwise>
						</c:choose>
					</td>
					
                    
					<!-- 목록 배치에서 설정한 항목 배치 -->	
					<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
						<c:choose>
							<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
								<td class="tx_l">
									<a href="#" rel="#titleNoticeSummary${status.count}" class="contentTip"
										onclick="bizViewPop(this,'${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.othbcAt}'); return false;">
										${noticeVo.bbscttSj}
										<c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
									</a>

									<c:if test="${noticeVo.mngrDeleteAt eq 'Y'}">
										<span class="tx_orange_u mar_l5">* 관리자 삭제글</span>
									</c:if>

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
											<img src="/resources/openworks/theme/default/images/icon/icon_new.gif" alt="새글"/>
										</c:if>
									</c:if>

									<div id="titleNoticeSummary${status.count}" class="tx_blue_s"><c:out value="${noticeVo.cnSumry}" escapeXml="true" /></div>
								</td>
							</c:when>
							<c:when test="${arrange.columnId eq 'CTG_CD'}">
								<td<c:if test="${arrStatus.last}"> class="lr_none"</c:if>><span class="label_notice">공지</span></td>
							</c:when>
	                        <c:when test="${arrange.columnId eq 'REGIST_ID'}">
	                            <td><a href="#" onclick="bizRegisterPop(this, '${noticeVo.registId}', '${noticeVo.langCode}')">${noticeVo.registerNm}<br />(<op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/>)</a></td>
	                        </c:when>
							<c:when test="${arrange.columnId eq 'RDCNT'}">
								<td<c:if test="${arrStatus.last}"> class="lr_none"</c:if>>
									<c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}"><span class="tx_blue">${noticeVo.rdcnt}</span></c:if>
									<c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}"><span>${noticeVo.rdcnt}</span></c:if>
								</td>
							</c:when>
							<c:when test="${arrange.columnId eq 'ESTN_COLUMN5'}">
	                            <!-- 매칭수 -->
	                            <td>${ noticeVo.commentCnt}</td>
	                            <td>
	                               <c:if test="${noticeVo.estnColumn5 eq 'Y'}"><span >선정</span></c:if>
	                               <c:if test="${noticeVo.estnColumn5 eq 'N'}"><span>미선정</span></c:if>
	                               <c:if test="${noticeVo.estnColumn5 eq 'S'}"><span>대기</span></c:if>
	                            </td>
	                            <!-- 상태여부 -->
	                            <td>${noticeVo.bizProgression}</td>
	                        </c:when>
							<c:otherwise>
								<td<c:if test="${arrStatus.last}"> class="lr_none"</c:if>><op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
				</tr>
			</c:forEach>
		</c:if>

		<!-- 공지 제외 게시물 목록 -->
		<c:set var="index" value="${pager.indexNo}"/>
		<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			<tr>
				<!-- 삭제/이동 등을 위한 체크박스 (목록 필수) -->
				<c:if test="${pageType eq 'LIST'}">
					<td><input type="checkbox" value="${baseVo.bbscttSeq}" name="bbscttSeqs" class="checkbox" /></td>
				</c:if>

				<!-- 순번(필수) -->
				<td>
					<c:choose>
						<c:when test="${(pageType eq 'VIEW') && (baseVo.bbscttSeq eq dataVo.bbscttSeq)}">
							<img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_current.png' />" ></img>
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
							<td class="tx_l">
								<a href="#" rel="#titleSummary${status.count}" class="contentTip"
									onclick="bizViewPop(this,'${baseVo.domainCd}','${baseVo.bbsCd}', '${baseVo.bbscttSeq}','${baseVo.othbcAt}'); return false;">
									${baseVo.bbscttSj}
									<c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
								</a>

								<c:if test="${baseVo.mngrDeleteAt eq 'Y'}">
									<span class="tx_orange_u mar_l5">* 관리자 삭제글</span>
								</c:if>

								<c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>

								<c:choose>
									<c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
										<a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
									</c:when>
									<c:when test="${baseVo.fileCnt > 0}">
										<span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span>
									</c:when>
								</c:choose>

								<%-- <c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
									<span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span>
								</c:if> --%>

								<c:if test="${boardConfVo.newArticleNum > 0}">
									<c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
								   		<img src="/resources/openworks/theme/default/images/icon/icon_new.gif" alt="새글"/>
								   	</c:if>
								</c:if>

								<c:if test="${baseVo.othbcAt eq 'Y'}">
									<div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div>
								</c:if>

								<c:if test="${baseVo.othbcAt eq 'N'}">
									<div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div>
								</c:if>
								<br/>
								<!-- 카테고리 -->
                                <c:if test="${not empty baseVo.ctgryList}">
                                    <span class="path">
                                        <c:forEach items="${baseVo.ctgryList}" var="ctgryVo">
                                            [${ctgryVo.ctgryClNm }] ${ctgryVo.ctgryPath }</br>
                                        </c:forEach>
                                    </span>
                                </c:if>
<%--                                 <c:if test="${empty baseVo.ctgryList}"><span class="path">등록하신 카테고리를 찾을수없습니다.</span></c:if> --%>
							</td>
						</c:when>
						<c:when test="${arrange.columnId eq 'CTG_CD'}">
							<td>${baseVo.ctgNm}</td>
						</c:when>
						<c:when test="${arrange.columnId eq 'REGISTER_NM'}">
							<td><a href="#" onclick="bizRegisterPop(this,'${baseVo.registId}')">${baseVo.registerNm}</br>(${baseVo.registId})</a></td>
						</c:when>
                        <c:when test="${arrange.columnId eq 'REGIST_ID'}">
                            <td><a href="#" onclick="bizRegisterPop(this, '${baseVo.registId}', '${baseVo.langCode}')">${baseVo.registerNm}<br />(<op:bean-util field="${arrange.columnId}" obj="${baseVo}"/>)</a></td>
                        </c:when>
						<c:when test="${arrange.columnId eq 'RDCNT'}">
							<td>
								<c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}"><span class="tx_blue">${baseVo.rdcnt}</span></c:if>
								<c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}"><span>${baseVo.rdcnt}</span></c:if>
							</td>
						</c:when>
						<c:when test="${arrange.columnId eq 'REGIST_DT'}">
						<td>${baseVo.registDt}</td>
							<!-- 매칭수 -->
						    <td>${ baseVo.commentCnt}</td>
							<td>
								<c:if test="${baseVo.estnColumn5 eq 'Y'}"><span>선정</span></c:if>
								<c:if test="${baseVo.estnColumn5 eq 'N'}"><span>미선정</span></c:if>
								<c:if test="${baseVo.estnColumn5 eq 'S'}"><span>대기</span></c:if>
							</td>
							<!-- 상태여부 -->
                            <td>
	                            <c:if test="${baseVo.bizProgression eq 'COM'}">완료</c:if>
	                            <c:if test="${baseVo.bizProgression eq 'INC'}">미완료</c:if>
	                            <c:if test="${baseVo.bizProgression eq 'PRO'}">진행중</c:if>
                            </td>
						</c:when>
						<c:otherwise>
							<td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>

		<c:if test="${empty pager.list}">
			<op:no-data obj="${pager}" colspan="${thCnt+1}" />
		</c:if>

	</tbody>
</table>
<!-- //리스트 -->