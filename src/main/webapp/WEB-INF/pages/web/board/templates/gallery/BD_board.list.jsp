<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title></title>

    <op:jsTag type="spi" items="cookie" />
<%--    <op:jsTag type="openworks" items="ui" /> --%>

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>

    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">

    //카테고리 저장용
    bbsCtgAry = new Array();

    $().ready(function(){

        //게시판 설정값들을 초기화 합니다.
        if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
        OpenWorks.pageType      = "LIST";
        OpenWorks.boardNm       = "${boardConfVo.bbsNm}";
        OpenWorks.boardType     = "${boardConfVo.kndCd}";
        OpenWorks.useCategory   = "${boardConfVo.ctgYn}";
        OpenWorks.fileYn        = "${boardConfVo.fileYn}";
        OpenWorks.filePermExtsn = "${boardConfVo.filePermExtsn}";
        OpenWorks.captchaYn     = "${boardConfVo.captchaYn}";
        OpenWorks.tagYn         = "${boardConfVo.tagYn}";
        OpenWorks.bbsNm         = "${boardConfVo.bbsNm}";
        OpenWorks.bbsCd         = "${boardConfVo.bbsCd}";
                OpenWorks.domainCd      = "<c:out value='${boardConfVo.domainCd}' />";
        OpenWorks.searchVal     = "${param.q_searchVal}";
        OpenWorks.searchKey     = "${param.q_searchKey}";
        OpenWorks.sortName      = "${param.q_sortName}";
        OpenWorks.sortOrder     = "${param.q_sortOrder}";
        OpenWorks.startDt       = "${param.q_startDt}";
        OpenWorks.endDt         = "${param.q_endDt}";
        OpenWorks.showSummaryYn = "${param.showSummaryYn}";
        OpenWorks.serverNm      = "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
        OpenWorks.isSession     = "${!empty __usk}";

        onReadyEventFunctions();

        //검색 날짜 입력
        $('#q_startDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
        $('#q_endDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});

    });

    </script>
    <!-- 사용자 스크립트 끝 -->
</head>

<body>

    <!-- 검색 폼 -->
    <form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();" action="jsSearch();">
        <!-- 기본 검색 사항 -->
        <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
        <input type="hidden" name="bbsCd" value="${param.bbsCd}" />
        <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}' />" />
        <input type="hidden" name="pageType" value="" />
        <input type="hidden" name="showSummaryYn" value="${param.showSummaryYn}" />
        <input type="hidden" name="delDesc" id="delDesc" value="" />

        <!-- 검색 삽입(공통) -->
        <%@include file="../common/INC_search.jsp" %>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam page="param/webListPagerParam.jsp" />


        <!-- 리스트 -->
        <div class="product_list">
		    <ul>     
		    <!-- 공지목록 --> 
                <c:forEach items="${noticeList}" var="noticeVo" varStatus="status">
		            <li>
				        <c:set var="index" value="${pager.indexNo}"/>
				        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                            <c:choose>
	                            <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
	                                <!-- 썸네일 이미지 -->
	                                <div class="photo">
	                                    <c:choose>
	                                        <c:when test="${(noticeVo.fileCnt > 0) && (noticeVo.fileList[0].localNm != '')}">
	                                            <img src="<c:url value="${noticeVo.fileList[0].fileUrl}" />"  title="${noticeVo.fileList[0].localNm}" alt="${noticeVo.fileList[0].localNm}" width="100px"/>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지"/>
	                                        </c:otherwise>
	                                    </c:choose>
	                                </div>
	                            </c:when>
	                            <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGISTER_NM' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">
	                            <!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
	                                <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}"> <!--제목 -->
	                                    <div class="info">
	                                        <c:choose>
	                                            <c:when test="${noticeVo.mngrDeleteAt eq 'Y'}">
	                                                <strong>[관리자에 의하여 삭제되었습니다.]</strong>
	                                            </c:when>
	                                            <c:otherwise>
	                                                        <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                                                            onclick="jsView('${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
	                                                            <strong>${noticeVo.bbscttSj}</strong>
	                                                            <c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
	                                                        </a>
	            
	                                                        <c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
	            
	                                                        <c:choose>
	                                                            <c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
	<%-- 	                                                                <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a> --%>
	                                                            </c:when>
	                                                            <c:when test="${noticeVo.fileCnt > 0}">
	<%-- 	                                                                <span class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</span> --%>
	                                                            </c:when>
	                                                        </c:choose>
	            
	                                                        <c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
	<%-- 	                                                            <span class="t_reply" title="댓글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span> --%>
	                                                        </c:if>
	            
	                                                        <c:if test="${boardConfVo.newArticleNum > 0}">
	                                                            <c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
	<!-- 	                                                                <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
	                                                            </c:if>
	                                                        </c:if>
	            
	                                                        <c:if test="${noticeVo.othbcAt eq 'Y'}">
	                                                            <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${noticeVo.cnSumry}" escapeXml="true" /></div>
	                                                        </c:if>
	            
	                                                        <c:if test="${noticeVo.othbcAt eq 'N'}">
	<%-- 	                                                            <div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div> --%>
	                                                        </c:if>
	                                            </c:otherwise>
	                                        </c:choose>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'CN_SUMRY'}"> <!--내용요약 -->
	                                    <div class="txt"><span>${noticeVo.cnSumry}</span></div>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'REGISTER_NM'}"> <!--등록자명 -->
	                                    <div class="desc">  
	                                        <span>${noticeVo.registerNm}</span>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'REGIST_DT'}"> <!--등록일시 -->
	                                        <span>${noticeVo.registDt}</span>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'RDCNT'}"> <!--조회수 -->
	                                        <span>조회수 ${noticeVo.rdcnt}</span>
	                                    </div>
	                                </div>
	                                </c:if>
	                            </c:when>
                            </c:choose>
	                    </c:forEach>
		            </li>
                </c:forEach>
                
                
                <!-- 공지 제외목록 -->
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">  
		            <li>
				        <c:set var="index" value="${pager.indexNo}"/>
				        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
                            <c:choose>
	                            <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
	                                <!-- 썸네일 이미지 -->
	                                <div class="photo">
	                                    <c:choose>
	                                        <c:when test="${(baseVo.fileCnt > 0) && (baseVo.fileList[0].localNm != '')}">
	                                            <img src="<c:url value="${baseVo.fileList[0].fileUrl}" />"  title="${baseVo.fileList[0].localNm}" alt="${baseVo.fileList[0].localNm}" width="100px"/>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지"/>
	                                        </c:otherwise>
	                                    </c:choose>
	                                </div>
	                            </c:when>
	                            <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGISTER_NM' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">
	                            <!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
	                                <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}"> <!--제목 -->
	                                    <div class="info">
	                                        <c:choose>
	                                            <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
	                                                <strong>[관리자에 의하여 삭제되었습니다.]</strong>
	                                            </c:when>
	                                            <c:otherwise>
	                                                        <a href="#" rel="#titleSummary${status.count}" class="contentTip"
	                                                            onclick="jsView('${baseVo.domainCd}','${baseVo.bbsCd}', '${baseVo.bbscttSeq}', '${baseVo.registPassword}', '${baseVo.othbcAt}'); return false;">
	                                                            <strong>${baseVo.bbscttSj}</strong>
	                                                            <c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
	                                                        </a>
	            
	                                                        <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
	            
	                                                        <c:choose>
	                                                            <c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
	<%-- 	                                                                <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a> --%>
	                                                            </c:when>
	                                                            <c:when test="${baseVo.fileCnt > 0}">
	<%-- 	                                                                <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span> --%>
	                                                            </c:when>
	                                                        </c:choose>
	            
	                                                        <c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
	<%-- 	                                                            <span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span> --%>
	                                                        </c:if>
	            
	                                                        <c:if test="${boardConfVo.newArticleNum > 0}">
	                                                            <c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
	<!-- 	                                                                <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
	                                                            </c:if>
	                                                        </c:if>
	            
	                                                        <c:if test="${baseVo.othbcAt eq 'Y'}">
	                                                            <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div>
	                                                        </c:if>
	            
	                                                        <c:if test="${baseVo.othbcAt eq 'N'}">
	<%-- 	                                                            <div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div> --%>
	                                                        </c:if>
	                                            </c:otherwise>
	                                        </c:choose>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'CN_SUMRY'}"> <!--내용요약 -->
	                                    <div class="txt"><span>${baseVo.cnSumry}</span></div>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'REGISTER_NM'}"> <!--등록자명 -->
	                                    <div class="desc">  
	                                        <span>${baseVo.registerNm}</span>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'REGIST_DT'}"> <!--등록일시 -->
	                                        <span>${baseVo.registDt}</span>
	                                </c:if>
	                                <c:if test="${arrange.columnId eq 'RDCNT'}"> <!--조회수 -->
	                                        <span>조회수 ${baseVo.rdcnt}</span>
	                                    </div>
	                                </div>
	                                </c:if>
	                            </c:when>
                            </c:choose>
	                    </c:forEach>
		            </li>
                </c:forEach>
		    </ul>
		</div>

        <!-- 페이징 -->
        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
        <!-- //페이징 -->

    </form>

</body>
</html>