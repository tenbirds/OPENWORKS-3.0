<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!-- container -->
<div id="container">
    <!-- contents -->
    <div id="contents">
        <div class="visual">
            <img src="/resources/web/theme/spanish/images/bizmatching/img_bizmatching_visual.jpg" alt="Encuentros comerciales¿No puede encontrar la solución que busca?Con el servicio de encuentros comerciales, puede encontrar más fácilmente las soluciones y los servicios que desea."/>
        </div>
        <!-- location -->
        <div class="location"><span class="home">Inicio</span><strong>Encuentro comercial</strong></div>
        <!-- //location -->

        <!-- 검색 폼 -->
        <form name="dataForm" id="dataForm" method="get">
            <!-- 기본 검색 사항 -->
            <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>"/>
            <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value=''/>"/>
            <input type="hidden" name="bbsCd" value="<c:out value='${param.bbsCd}'/>"/>
            <input type="hidden" name="pageType" value="<c:out value=''/>"/>
            <input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}'/>"/>
            <input type="hidden" name="delDesc" id="delDesc" value="<c:out value=''/>"/>

            <section class="content rela">
                <h3>Encuentro comercial</h3>
                <div class="sech_form">
                    <div class="cont_wrap">
                        <div class="search">
                            <input type="hidden" name="q_searchType" id="q_searchType" value="<c:out value='1002'/>" />
                            <input type="hidden" name="q_searchKeyType" id="q_searchKeyType" value="BBSCTT_SJ___1002" />
                            <%--<input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" title="비즈매칭 검색 단어 입력" maxlength='50'class="input"/>--%>
                            <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" title="" maxlength='50'class="input"/>
                            <%--<input type="button" class="btn" id="sech" name="sech" title="검색" onclick="jsSearch();"/>--%>
                            <input type="button" class="btn" id="sech" name="sech" title="" onclick="jsSearch();"/>
                        </div>
                        <div class="btn_org">
                            <a href="#" onclick="jsSearchReset(); return false;" >Ver todos</a>
                            <a href="#" onclick="jsInsertForm('INSERT'); return false; "><span class="request">Solicitud</span></a>
                        </div>
                    </div>
                </div>

                <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
                <op:pagerParam page="param/webEngListPagerParam.jsp"/>

                <%-- 항목 표시 수 --%>
                <c:set var="thCnt" value="0"/>

                <!-- 목록 시작 -->
                <table class="tbl_list type_A">
                    <caption>
                        <strong>Encuentro comercial Lista</strong>
                        <details>
                            <summary>번호, 문의제목, 상태, 종료일, 매칭수, 조회수, 등록자, 작성일 정보를 제공합니다.</summary>
                        </details>
                    </caption>
                    <colgroup>
                        <!-- 번호(필수) -->
                        <c:set var="thCnt" value="${thCnt + 1}"/>
                        <col width="6%"/>

                        <!-- 목록 배치에서 설정한 항목 배치 -->
                        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                            <c:set var="thCnt" value="${thCnt + 1}"/>
                            <c:choose>
                                <c:when test="${arrange.columnId eq 'ESTN_COLUMN10'}">
                                    <col style="width:8%"/>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                    <col style="width:*"/>
                                    <col style="width:8%"/><!-- 상태 -->
                                    <c:set var="thCnt" value="${thCnt + 1}" />
                                </c:when>
                                <c:when test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                                    <col style="width:12%"/>
                                    <col style="width:10%"/><!-- 매칭수 -->
                                    <c:set var="thCnt" value="${thCnt + 1}"/>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'RDCNT'}">
                                    <col style="width:10%"/>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'REGIST_ID'}">
                                    <col style="width:10%"/>
                                </c:when>
                                <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                                    <col style="width:12%"/>
                                </c:when>
                                <c:otherwise>
                                    <col style="*"/>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </colgroup>
                    <thead>
                        <tr>
                            <!-- 번호(필수) -->
                            <th id="th-ROWNUM" scope="col"><span id="ROWNUM">Número</span></th>

                            <!-- 목록 배치에서 설정한 항목 배치 -->
                            <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                                <c:choose>
                                    <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                        <th id="th-${arrange.columnId}" scope="col"><span id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                                        <th id="th-BIZ_PROGRESSION" scope="col"><span id="BIZ_PROGRESSION">Condicion</span></th>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                                        <th id="th-${arrange.columnId}" scope="col"><span id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                                        <th id="th-COMMENT_CNT" scope="col"><span id="COMMENT_CNT">Cantidad de encuentros</span></th>
                                    </c:when>
                                    <c:otherwise>
                                        <th id="th-${arrange.columnId}" scope="col"><span  id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                                        <%--<c:if test="${status.last}"> class="lr_none"</c:if>--%>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </tr>
                    </thead>
                    <tbody id="odd-color">
                        <!-- 공지 목록  -->
                        <c:if test="${boardConfVo.noticeBbscttUseYn eq 'Y'}">
                            <c:forEach items="${noticeList}" var="noticeVo" varStatus="status">
                                <c:set var="trClass" value="bg_blue"/>
                                <c:if test="${(pageType == 'VIEW') && (dataVo.bbscttSeq == noticeVo.bbscttSeq)}">
                                    <c:set var="trClass" value="tr-sel"/>
                                </c:if>

                                <tr class="${trClass}">
                                    <!-- 번호(필수) -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${(pageType eq 'VIEW') && (noticeVo.bbscttSeq eq dataVo.bbscttSeq)}">
                                                <%--<img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png'/>" alt="현재글"/>--%>
                                                <img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png'/>" alt=""/>
                                            </c:when>
                                            <c:otherwise>
                                                <%--<img src="<c:url value='/resources/web/theme/default/images/icon/icon_notice.gif'/>" alt="공지알림"/>--%>
                                                <img src="<c:url value='/resources/web/theme/default/images/icon/icon_notice.gif'/>" alt=""/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 목록 배치에서 설정한 항목 배치 -->
                                    <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                                        <c:choose>
                                            <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                                <!-- 제목 항목 -->
                                                <td class="tx_l">
                                                    <a href="#" rel="#titleNoticeSummary${status.count}" onclick="jsView('${noticeVo.domainCd}', ,'${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
                                                        <c:out value='${noticeVo.bbscttSj}'/>
                                                        <span class="path"><c:out value='${noticeVo.estnColumn10}'/></span>
                                                        <c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
                                                    </a>
                                                    <%--<c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>--%>
                                                    <c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="">&nbsp;</span></c:if>
                                                    <c:choose>
                                                        <c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
                                                            <%--<a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a>--%>
                                                            <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="">(${noticeVo.fileCnt})</a>
                                                        </c:when>
                                                        <c:when test="${noticeVo.fileCnt > 0}">
                                                            <%--<span style="display:inline" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</span>--%>
                                                            <span style="display:inline" class="t_file" title="">(${noticeVo.fileCnt})</span>
                                                        </c:when>
                                                    </c:choose>

                                                    <c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
                                                        <%--<span class="t_reply" title="의견글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span>--%>
                                                        <span class="t_reply" title="">(${noticeVo.commentCnt})</span>
                                                    </c:if>

                                                    <%--<c:if test="${boardConfVo.newArticleNum > 0}">
                                                        <c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
                                                            <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/>
                                                        </c:if>
                                                    </c:if>--%>

                                                    <div id="titleNoticeSummary${status.count}" class="tx_blue_s"><c:out value="${noticeVo.cnSumry}" escapeXml="true"/></div>
                                                </td>
                                            </c:when>
                                            <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                                <!-- 분류 항목 : 공지 목록이므로 '공지'로 표시 -->
                                                <td>공지</td>
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
                                            <%--<img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png'/>" alt="현재글"/>--%>
                                            <img src="<c:url value='/resources/web/theme/default/images/icon/icon_current.png'/>" alt=""/>
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
                                            <td class="p_name">
                                                <a href="#" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>','<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
                                                    <c:out value='${fn:substring(baseVo.bbscttSj,0,23)}'/><c:if test="${baseVo.bbscttSjLength > 23}">...</c:if>
                                                </a>
                                                <%--<c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>--%>
                                                <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="">&nbsp;</span></c:if>
                                                <c:choose>
                                                    <c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
                                                        <%--<a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>--%>
                                                        <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="">(${baseVo.fileCnt})</a>
                                                    </c:when>
                                                    <c:when test="${baseVo.fileCnt > 0}">
                                                        <%--<span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(<c:out value='${baseVo.fileCnt}'/>)</span>--%>
                                                        <span class="t_file" title="">(<c:out value='${baseVo.fileCnt}'/>)</span>
                                                    </c:when>
                                                </c:choose>
                                                <c:if test="${baseVo.othbcAt eq 'Y'}">
                                                    <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true"/></div>
                                                </c:if>

                                                <!-- 카테고리 -->
                                                <c:if test="${not empty baseVo.ctgryList}">
                                                    <span class="path">
                                                        <c:forEach items="${baseVo.ctgryList}" var="ctgryVo">
                                                            [<c:out value='${ctgryVo.ctgryClNm }'/>] <c:out value='${ctgryVo.ctgryPath }'/><br/>
                                                        </c:forEach>
                                                    </span>
                                                </c:if>
                                                <%--<c:if test="${empty baseVo.ctgryList}"><span class="path">등록하신 카테고리를 찾을수없습니다.</span></c:if>--%>
                                            </td>
                                            <!-- 상태 -->
                                            <td>
                                                <c:if test="${baseVo.bizProgression eq 'COM'}"><span class="condi_a">Completo</span></c:if>
                                                <c:if test="${baseVo.bizProgression eq 'INC'}"><span class="condi_b">Incompleto</span></c:if>
                                                <c:if test="${baseVo.bizProgression eq 'PRO'}"><span class="condi_d">En curso</span></c:if>
                                            </td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                                            <!-- 종료일 -->
                                            <%--<td class="end_date"><c:out value='${baseVo.estnColumn6}'/></td>--%>
                                            <c:choose>
                                                <c:when test="${baseVo.estnColumn6 eq '2030.12.31 00:00'}">
                                                    <td class="end_date"><c:out value='-'/></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td class="end_date"><c:out value='${baseVo.estnColumn6}'/></td>
                                                </c:otherwise>
                                            </c:choose>
                                            <!-- 매칭수 -->
                                            <td><c:out value='${baseVo.commentCnt}'/></td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'CTG_CD'}">
                                            <!-- 분류 항목 -->
                                            <td><c:out value='${baseVo.ctgNm}'/></td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'RDCNT'}">
                                            <!-- 조회수 항목 -->
                                            <td>
                                                <c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}"><span class="tx_blue"><c:out value='${baseVo.rdcnt}'/></span></c:if>
                                                <c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}"><span><c:out value='${baseVo.rdcnt}'/></span></c:if>
                                            </td>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'REGIST_ID'}">
                                            <!-- 등록아이디 -->
                                            <c:choose>
                                                <c:when test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                                                    <td class="date"><c:out value='${baseVo.registId}'/></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td class="date"><c:out value='${baseVo.maskRegistId}'/></td>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${arrange.columnId eq 'REGIST_DT'}">
                                            <!-- 등록일 -->
                                            <td class="date"><c:out value='${baseVo.registDt}'/></td>
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
                            <op:no-data obj="${pager}" colspan="${thCnt}" msg="<strong>No hay datos</strong>"/>
                        </c:if>

                    </tbody>
                </table>
            </section>
            <!-- //목록 끝 -->

            <!-- 페이징 -->
            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq"/>
            <!-- //페이징 -->

        </form>
    </div>
    <!-- //contents -->
</div>
<!-- //container -->