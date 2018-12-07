<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!-- 리스트 -->
        <table class="tbl_list type_A">
            <caption>
                <strong>FAQ게시판 게시판</strong>
                <details>
                    <summary>FAQ게시판 목록으로 번호,분류,제목,작성자,작성일 등의 조회 정보를 제공합니다.</summary>
                </details>
            </caption>
            <colgroup>
                <!-- 번호(필수) -->
                <c:set var="thCnt" value="${thCnt + 1}" />
                <col style="width:8%;">

                <!-- 목록 배치에서 설정한 항목 배치 -->
                <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                    <c:set var="thCnt" value="${thCnt + 1}" />
                    <c:choose>
                        <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                            <col style="*" />
                        </c:when>
                        <c:when test="${arrange.columnId eq 'CTG_CD'}">
                            <col style="width:15%;"/>
                        </c:when>
                        <c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
                            <col style="width:18%;"/>
                        </c:when>
                        <c:otherwise>
                            <col style="10%" />
                        </c:otherwise>                  
                    </c:choose>
                </c:forEach>
            </colgroup>
            <thead>
                <tr>
                    <!-- 번호(필수) -->
                    <th id="th-ROWNUM" scope="col">Number</th>

                    <!-- 목록 배치에서 설정한 항목 배치 -->
                    <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                        <c:choose>
                        <c:when test="${arrange.columnId eq 'CTG_CD'}">
                            <th id="th-CTG_CD"<c:if test="${status.last}"> class="lr_none"</c:if> scope="col">${arrange.langColumnNm}</th>
                        </c:when>
                        <c:otherwise>
                          <th id="th-${arrange.columnId}"<c:if test="${status.last}"> class="lr_none"</c:if> scope="col">${arrange.langColumnNm}</th>
                        </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </tr>
            </thead>
            <tbody >
                <!-- 공지 목록  -->
                <c:if test="${boardConfVo.noticeBbscttUseYn eq 'Y'}">

                    <c:forEach items="${noticeList}" var="noticeVo" varStatus="status">

                        <c:set var="trClass" value="bg_blue" />
                        <c:if test="${(pageType == 'VIEW') && (dataVo.bbscttSeq == noticeVo.bbscttSeq)}">
                            <c:set var="trClass" value="tr-sel" />
                        </c:if>

                        <tr class="item">
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
                                        <!-- 제목 항목 -->
                                        <td class="t_al">
                                            <a href="#" rel="#titleNoticeSummary${status.count}" class="contentTip"><c:out value='${noticeVo.bbscttSj}'/></a>

                                            <c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>

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
<!--                                                    <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
                                                </c:if>
                                            </c:if>
                                        </td>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                        <!-- 분류 항목 : 공지 목록이므로 '공지'로 표시 -->
                                        <td class="t_al"><span class="label_notice">공지</span></td>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'RDCNT'}">
                                        <!-- 조회수 항목 -->
                                        <td class="t_al">
                                            <c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}"><span class="tx_blue">  <c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                            <c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}"><span><c:out value='${noticeVo.rdcnt}'/></span></c:if>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="t_al"><op:bean-util field="${arrange.columnId}" obj="${noticeVo}"/></td>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </tr>
                        <!-- 내용 항목 -->
                        <tr id="noticd_${noticeVo.bbscttSeq}" style="display:none;" class="hide">
                            <td class="faq_left"></td>
                            <td colspan="${thCnt-1}" class="faq" >
                                ${noticeVo.bbscttCn}
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>

                <!-- 공지 제외 게시물 목록 -->
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr class="item">
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
                                    <td class="t_al">
                                        <c:choose>
                                            <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
                                                <p class="tx_blue_l">[Deleted by administrator.]</p>
                                            </c:when>
                                            <c:otherwise>
                                                        <a href="#" class="question">
                                                        <op:nrToBr content='${baseVo.bbscttSj}'/>
                                                        
                                                            <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
    
                                                            <c:choose>
                                                                <c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
                                                                    <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
                                                                </c:when>
                                                                <c:when test="${baseVo.fileCnt > 0}">
    <%--                                                                 <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span> --%>
                                                                </c:when>
                                                            </c:choose>
    
                                                            <c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
    <%--                                                             <span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span> --%>
                                                            </c:if>
    
                                                            <c:if test="${boardConfVo.newArticleNum > 0}">
                                                                <c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
    <!--                                                                <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
                                                                </c:if>
                                                            </c:if>
                                                        </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                    <!-- 분류 항목 -->
                                    <td><c:out value='${baseVo.ctgNm}'/></td>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
                                    <!-- 분류 항목 -->
                                    <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
                                       <c:forEach items="${ctgVo.aditCtgList}" var="aditCtgVo" varStatus="status">
                                           <c:if test="${ctgVo.ctgNm == baseVo.ctgNm and aditCtgVo.aditCtgCd eq baseVo.estnColumn1 }">
                                                <td>  <c:out value='${aditCtgVo.aditCtgNm}'/></td> 
                                           </c:if>
                                       </c:forEach>
                                    </c:forEach>
                                </c:when>
                                <%-- 
                                <c:when test="${arrange.columnId eq 'RDCNT'}">
                                    <!-- 조회수 항목 -->
                                    <td>
                                        <c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}"><span class="tx_blue">${baseVo.rdcnt}</span></c:if>
                                        <c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}"><span>${baseVo.rdcnt}</span></c:if>
                                    </td>
                                </c:when> --%>
                                <c:otherwise>
                                    <td><op:bean-util field="${arrange.columnId}" obj="${baseVo}"/></td>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tr>
                    <!-- 내용 항목 -->
                    <tr id="contents_${baseVo.bbscttSeq}" class="hide" >
                        <td class="faq_left"></td>
                        <td colspan="${thCnt-1}" class="faq" >
                            <table class="tbRl_list">
                                <colgroup>
                                    <col style="width:100%;">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td><op:nrToBr content='${baseVo.bbscttCn}'/></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </c:forEach>

                <!-- 데이터가 없을 때 알림 문구 -->
                <c:if test="${empty pager.list}">
					<tr>
					    <td class="no-data lr_none" colspan="${thCnt}">There is no data.</td>
					</tr>
				</c:if>

            </tbody>
        </table>
        <!-- //리스트 -->

        <!-- 페이징 -->
        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
        <!-- //페이징 -->
