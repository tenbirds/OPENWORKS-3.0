<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
	
	<script type="text/javascript" src="/resources/web/board/board.js"></script>
	
    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">
    </script>
    <!-- 사용자 스크립트 끝 -->
    
	<!-- 검색 폼 -->			
	<form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();" action="jsSearch();">
		<!-- 기본 검색 사항 -->
		<input type="hidden" name="domainCd"  id="domainCd"  />
		<input type="hidden" name="bbsCd"     id="bbsCd"  />
		<input type="hidden" name="bbscttSeq" id="bbscttSeq"  />
        <input type="hidden" name="sction"    id="sction"  />
    </form>
    
	<!-- contents -->
	<div class="contents">
			<c:if test="${boardConfVo.bbsCd eq 1001}">
				<div class="title-area">
	                <h2 id="menuNm">공지사항</h2>
				</div>
			</c:if>

		<!-- title-area --
		<div class="title-area">
			<h2>
				<c:if test="${boardConfVo.bbsCd eq 1001}">공지사항</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1004}">지식나눔</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1007}">행사 및 이벤트</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1009}">성공스토리</c:if>
			</h2>
		</div>
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section side">
			<!-- view -->
			<div class="type-view">
				<dl>
					<dt><c:out value='${dataVo.bbscttSj}'/></dt>
					<dd><strong><c:out value='${dataVo.registDt}'/></strong></dd>
					
					<dd class="cont">
						<div>
                        <%-- 게시글 내용 및 첨부파일 영역 --%>
                        <c:forEach items="${boardConfVo.viewArrange}" var="arrange" varStatus="arrStatus">
                            <c:choose>
                                <c:when test="${arrange.columnId eq 'BBSCTT_CN' or arrange.columnId eq 'FILE_SEQ'}">
                                    <c:if test="${arrange.columnId eq 'BBSCTT_CN'}">
                                        <%-- <c:out value='${dataVo.bbscttCn}' escapeXml="false" /> --%>
                                        <c:set var="map_bbscttCn" value="${fn:replace(dataVo.bbscttCn, '<br />', '')}" />
	                                      <c:set var="map_bbscttCn" value="${fn:replace(map_bbscttCn, '<br />', '')}" />
	                                      <c:out value="${map_bbscttCn}" escapeXml="false" />
                                    	<%-- 첨부파일 영역  --%>
                                        <c:if test="${fn:length(dataVo.fileList) > 0}">
                                            <div class="file_area">
                                                <c:choose>
                                                    <c:when test="${fn:length(dataVo.fileList) > 0}">|&nbsp;
                                                        <c:forEach items="${dataVo.fileList}" var="fileVo">
                                                            <span class="file">
                                                                <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">${fileVo.localNm}</a> (${fileVo.fileSize})
                                                            </span>&nbsp;|&nbsp;
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </c:if>
                                        <%-- //첨부파일 영역  --%>
                                        
                                    </c:if>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <%-- //게시글 내용 및 첨부파일 영역 --%>
						</div>
					</dd>
						
					<!-- 테그영역 -->
<!-- 
					<c:if test="${!empty dataVo.bbsTags}">
					<dd class="tag">
						<strong>태그</strong>
						<span>
                            <c:forEach var="tag" items="${dataVo.bbsTags}" varStatus="status">
                                <a href="#" onclick="jsShowBbsListByTag('<c:out value='${tag}'/>')">${tag}</a>
                            </c:forEach>
						</span>
					</dd>
					</c:if>
-->
					<!-- //테그영역 -->

					<!-- 이전글/다음글 영역 -->
					<dd class="prev-next">
						<div class="prev">
						<c:if test="${not empty prevVO.bbscttSj}">
						    <strong>이전글</strong><a href="javascript:;" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${prevVO.domainCd}'/>','<c:out value='${prevVO.bbsCd}'/>', '<c:out value='${prevVO.bbscttSeq}'/>', '<c:out value='${prevVO.registPassword}'/>', '<c:out value='${prevVO.othbcAt}'/>'); return false;">${prevVO.bbscttSj}</a>
						</c:if>
						<c:if test="${empty prevVO.bbscttSj}">
						<strong>이전글</strong><a href="javascript:;">이전글이 없습니다.</a>
						</c:if>
						</div>
						<div class="next">
						<c:if test="${not empty nextVO.bbscttSj}">
							<strong>다음글</strong><a href="javascript:;" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${nextVO.domainCd}'/>','<c:out value='${nextVO.bbsCd}'/>', '<c:out value='${nextVO.bbscttSeq}'/>', '<c:out value='${nextVO.registPassword}'/>', '<c:out value='${nextVO.othbcAt}'/>'); return false;">${nextVO.bbscttSj}</a>
						</c:if>
						<c:if test="${empty nextVO.bbscttSj}">
						<strong>다음글</strong><a href="javascript:;">다음글이 없습니다.</a>
						</c:if>
						</div>
					</dd>
					<!-- 이전글/다음글 영역 -->
				</dl>
            </div>
            <!-- //view -->

        </div>
	    <!-- //section -->
    </div>
	<!-- //contents -->