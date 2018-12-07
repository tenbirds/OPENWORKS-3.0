<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!-- section -->
<div class="section">
	<!-- list -->
	<div class="type-list">
		<table summary="게시판 목록">
		<caption>게시판 목록</caption>
			<colgroup>
			<!-- 번호(필수) -->
      	<c:set var="thCnt" value="${thCnt + 1}" />
        <col style="width:70px;"/>

        <!-- 목록 배치에서 설정한 항목 배치 -->
        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
            <c:set var="thCnt" value="${thCnt + 1}" />
            <c:choose>
                <c:when test="${arrange.columnId eq 'CTG_CD'}">
                    <col style="width:100px;"/>
                </c:when>
                <c:when test="${arrange.columnId eq 'ESTN_COLUMN3' }">
                    <col style="width:80px;"/>
                </c:when>
                <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                    <col style="width:*;"/>
                </c:when>
                <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                    <col style="width:130px;"/>
                </c:when>
            </c:choose>
        </c:forEach>
			</colgroup>
			<thead>
         <tr>
             <!-- 번호(필수) -->
             <th id="th-ROWNUM" scope="col">번호</th>
             <!-- 목록 배치에서 설정한 항목 배치 -->
             <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                 <th id="th-${arrange.columnId}" scope="col">${arrange.langColumnNm}</th>
             </c:forEach>
         </tr>
			</thead>
			<tbody>
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
                                        <img src="<c:url value='/resources/web/theme/default/images/icon/icon_notice.gif' />" alt="공지알림" />
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <!-- 목록 배치에서 설정한 항목 배치 -->
                            <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                                <c:choose>
                                    <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                        <!-- 제목 항목 -->
                                        <td>
                                            <a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>" rel="#titleNoticeSummary${status.count}" class="contentTip" onclick="jsView('${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
                                                <c:if test="${noticeVo.othbcAt != 'Y'}">
                                                    <img src="/resources/web/theme/default/images/common/ico/ico_close.gif" alt="비공개" class="va"/>
                                                </c:if>
                                                <c:out value='${noticeVo.bbscttSj}'/>
                                                <c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
                                            </a>

                                            <c:choose>
                                                <c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
                                                    <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a>
                                                </c:when>
                                                <c:when test="${noticeVo.fileCnt > 0}">
<%--                                                     <span class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</span> --%>
                                                </c:when>
                                            </c:choose>

                                            <c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
<%--                                                 <span class="t_reply" title="의견글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span> --%>
                                            </c:if>

                                            <c:if test="${boardConfVo.newArticleNum > 0}">
                                                <c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
<!--                                                     <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
                                                </c:if>
                                            </c:if>

                                            <div id="titleNoticeSummary${status.count}" class="tx_blue_s"><c:out value="${noticeVo.cnSumry}" escapeXml="true" /></div>
                                        </td>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                        <!-- 분류 항목 : 공지 목록이므로 '공지'로 표시 -->
                                        <td class="condi_b"><span class="label_notice">공지</span></td>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'RDCNT'}">
                                        <!-- 조회수 항목 -->
                                        <td>
                                            <c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}"><span class="tx_blue"><c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                            <c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}"><span><c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/></td>
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
                                    <!-- 제목 항목 -->
                                    <td class="title">
                                        <c:choose>
                                            <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
                                                <p class="tx_blue_l">[관리자에 의하여 삭제되었습니다.]</p>
                                            </c:when>
                                            <c:otherwise>
                                                        <a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('${baseVo.domainCd}','${baseVo.bbsCd}', '${baseVo.bbscttSeq}', '${baseVo.registPassword}', '${baseVo.othbcAt}'); return false;">
                                                            <c:if test="${baseVo.othbcAt != 'Y'}">
                                                                <img src="/resources/web/theme/default/images/common/ico/ico_close.gif" alt="비공개" class="va"/>
                                                            </c:if>
                                                            <c:out value='${baseVo.bbscttSj}'/>
                                                            <c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
                                                            <c:if test="${baseVo.fileCnt > 0}">
                                                                <img alt="첨부된 이미지" class="ico" src="/resources/web/theme/default/images/common/ico/ico_image.gif">
                                                            </c:if>
                                                        </a>

                                                        <c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
                                                            <span class="num" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">[${baseVo.commentCnt}]</span>
                                                        </c:if>
        
                                                        <c:if test="${boardConfVo.newArticleNum > 0}">
                                                            <c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
        <!--                                                        <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
                                                            </c:if>
                                                        </c:if>
        
                                                        <c:if test="${baseVo.othbcAt eq 'Y'}">
                                                            <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div>
                                                        </c:if>
        
                                                        <c:if test="${baseVo.othbcAt eq 'N'}">
                                                            <div id="titleSummary${status.count}" class="tx_blue_s">* 비밀글 입니다. *</div>
                                                        </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                                    <!-- 분류 항목 -->
                                    <td class="date"><c:out value='${baseVo.registDt}'/></td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                    <!-- 분류 항목 -->
                                    <td class="condi_b"><c:out value='${baseVo.ctgNm}'/></td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'RDCNT'}">
                                    <!-- 조회수 항목 -->
                                    <td>
                                        <c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}"><span class="tx_blue"><c:out value='${baseVo.rdcnt}'/></span></c:if>
                                        <c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}"><span><c:out value='${baseVo.rdcnt}'/></span></c:if>
                                    </td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'ESTN_COLUMN3'}">
                                    <!-- 상태  -->
                                    <td class="${baseVo.estnColumn3 eq 'Y' ? 'txt-point':'' }">
                                        <c:if test="${baseVo.estnColumn3 eq 'Y'}">답변완료</c:if>
                                        <c:if test="${baseVo.estnColumn3 eq 'N'}">답변미등록</c:if>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tr>
                </c:forEach>

                <!-- 데이터가 없을 때 알림 문구 -->
                <c:if test="${empty pager.list}">
                    <op:no-data obj="${pager}" colspan="${thCnt}" />
                </c:if>
			</tbody>
			
			
		</table>
	</div>
	<!-- //list -->
</div>
<!-- //section -->

