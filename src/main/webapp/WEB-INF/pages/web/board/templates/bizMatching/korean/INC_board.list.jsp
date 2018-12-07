<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

		<!-- container -->
		<div id="container" class="join-wrap">

		<!-- contents -->
			
			<div class="knowHub list">			
			<h3>
				<i class="quot">
					찾고 계신 클라우드서비스가 없으시거나<br />
					<i>클라우드서비스에 대한 전문가의 조언</i>이 필요하신가요?
				</i>				
			</h3>				
			<p>비즈매칭 코너를 통해 찾고 계신 솔루션이나 서비스를 지원해 드립니다.</p>				
			
			
			<!-- 검색 폼 -->
       		<form name="dataForm" id="dataForm" method="get" >
           	<!-- 기본 검색 사항 -->
           	<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}' />" />
            <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value=''/>"/>
            <input type="hidden" name="bbsCd" value="<c:out value='${param.bbsCd}' />"/>
            <input type="hidden" name="pageType" value="<c:out value=''/>"/>
            <input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}'/>"/>
            <input type="hidden" name="delDesc" id="delDesc" value="<c:out value=''/>"/>
	
			<div class="title-area">
				<!-- sorting -->
				<div class="schArea noCate">
					<div>
						<input type="hidden" name="q_searchType" id="q_searchType" value="<c:out value='1002'/>" />
                        <input type="hidden" name="q_searchKeyType" id="q_searchKeyType" value="BBSCTT_SJ___1002" />
                        <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" title="비즈매칭 검색 단어 입력"  maxlength='50'/>
                    </div>
                        <a href="#" class="btns st5" id="sech" name="sech" title="검색" onclick="jsSearch();" >검 색</a>
				</div>
				<!-- //sorting -->			
			</div>
				
			<!-- section -->
			<div class="section">
				<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
	            <op:pagerParam page="param/webListPagerParam.jsp" />
	            <%-- 항목 표시 수 --%>
	            <c:set var="thCnt" value="0" />
				<!-- list -->
				<div class="type-list">
				<table>
					<caption>테이블</caption>
					<!-- 번호(필수) -->
                    <c:set var="thCnt" value="${thCnt + 1}" />
                    <!-- 목록 배치에서 설정한 항목 배치 -->
                    <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                        <c:set var="thCnt" value="${thCnt + 1}" />
                        <c:choose>
                           	<c:when test="${arrange.columnId eq 'ESTN_COLUMN10'}">
                            </c:when>
                           	<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                                <c:set var="thCnt" value="${thCnt + 1}" />
                           	</c:when>
                      		<c:when test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                                <c:set var="thCnt" value="${thCnt + 1}" /> 
                           	</c:when>
                           	<c:when test="${arrange.columnId eq 'RDCNT'}">
                           	</c:when>
                           	<c:when test="${arrange.columnId eq 'REGIST_ID'}">
                           	</c:when>
                           	<c:when test="${arrange.columnId eq 'REGIST_DT'}"> 
                           	</c:when>
                           	<c:otherwise>
                           	</c:otherwise>
                        </c:choose>
                    </c:forEach>
					<thead>
					<tr>
						<!-- 번호(필수) -->
                        <th id="th-ROWNUM" scope="col"><span id="ROWNUM">번호</span></th>
                        <!-- 목록 배치에서 설정한 항목 배치 -->
                        <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
                            <c:choose>
                            <c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
                               <th id="th-${arrange.columnId}" scope="col"><span id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                            </c:when>
                            <c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
                               <th id="th-${arrange.columnId}" scope="col"><span id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                               <th id="th-BIZ_PROGRESSION" scope="col"><span id="BIZ_PROGRESSION">상태</span></th>
                            </c:when>
                            <c:when test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                               <th id="th-${arrange.columnId}" scope="col"><span id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                               <th id="th-COMMENT_CNT" scope="col"><span id="COMMENT_CNT">매칭수</span></th>
                            </c:when>
                            <c:otherwise>
                               <th id="th-${arrange.columnId}" scope="col"><span  id="${arrange.columnId}">${arrange.langColumnNm}</span></th>
                               <!-- <c:if test="${status.last}"> class="lr_none"</c:if> -->
                            </c:otherwise>
                             </c:choose>
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
                                    <td class="tx_l">
                                        <a href="#" rel="#titleNoticeSummary${status.count}"
                                            onclick="jsView('${noticeVo.domainCd}', ,'${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
                                            <c:out value='${noticeVo.bbscttSj}'/>
                                            <span class="path"><c:out value='${noticeVo.estnColumn10}'/></span>
                                            <c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
                                        </a>
                                        <c:if test="${noticeVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
                                        <c:choose>
                                            <c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
                                                <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a>
                                            </c:when>
                                            <c:when test="${noticeVo.fileCnt > 0}">
                                                <span style="display:inline" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</span>
                                            </c:when>
                                        </c:choose>
                                        <c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
                                            <span class="t_reply" title="의견글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span>
                                        </c:if>
                                        <c:if test="${boardConfVo.newArticleNum > 0}">
                                            <c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
                                            </c:if>
                                        </c:if>
                                        <div id="titleNoticeSummary${status.count}" class="tx_blue_s"><c:out value="${noticeVo.cnSumry}" escapeXml="true" /></div>
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
                                        <td class="tit">
                                            <c:choose>
                                                <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
                                                    <p class="tx_blue_l">[관리자에 의하여 삭제되었습니다.]</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#" rel="#titleSummary${status.count}" class="contentTip"
                                                        onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>','<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
                                                        <c:out value='${baseVo.bbscttSj}' />
														<c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
                                                        <%-- <c:out value='${fn:substring(baseVo.bbscttSj,0,45)}'/><c:if test="${baseVo.bbscttSjLength > 45}">...</c:if> --%>
                                                    </a>
                                                    <%-- 
                                                    <c:if test="${baseVo.othbcAt != 'Y'}"><span class="t_lock" title="비공개 글입니다.">&nbsp;</span></c:if>
                                                    <c:choose>
                                                        <c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
                                                            <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a>
                                                        </c:when>
                                                        <c:when test="${baseVo.fileCnt > 0}">
                                                            <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(<c:out value='${baseVo.fileCnt}'/>)</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <c:if test="${boardConfVo.newArticleNum > 0}">
                                                        <c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
                                                        </c:if>
                                                    </c:if>
                                                    <c:if test="${baseVo.othbcAt eq 'Y'}">
                                                        <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div>
                                                    </c:if>
                                                    <c:if test="${baseVo.othbcAt eq 'N'}">
                                                        <div id="titleSummary${status.count}" class="tx_blue_s">* 비밀글 입니다. *</div>
                                                    </c:if>
                                                     --%>
                                                </c:otherwise>
                                            </c:choose>
                                            <!-- 카테고리 -->
                                            <c:if test="${not empty baseVo.ctgryList}">
	                                           <%--  <span class="path">
		                                            <c:forEach items="${baseVo.ctgryList}" var="ctgryVo">
		                                                [<c:out value='${ctgryVo.ctgryClNm }'/>] <c:out value='${ctgryVo.ctgryPath }'/><br/>
		                                            </c:forEach>
	                                            </span> --%>
                                            </c:if>
                                        </td>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'ESTN_COLUMN2'}">
                                    	<td>
                                    		<c:if test="${baseVo.estnColumn2 ne '' && baseVo.estnColumn2 ne null}">
	                                    		<c:choose>
	                                                <c:when test="${fn:indexOf(baseVo.estnColumn2,',') >= 0}">
														<a href="#" class="more"><c:out value="${fn:split(baseVo.estnColumn2,',')[0]}"/>(외<c:out value="${fn:length(fn:split(baseVo.estnColumn2,',')) - 1}"/>명)</a>
														<div>
															<img src="/cloud_ver2/new_cloud/images/bgIcn_arr_up.png" alt="" />
															<c:forEach var="item" items="${fn:split(baseVo.estnColumn2,',')}" varStatus="status">
																<c:if test="${!status.first}">
																<span><c:out value="${item}"/></span>
																</c:if>
															</c:forEach>
														</div>
													</c:when>
	                                                <c:otherwise>
	                                                	<c:out value="${baseVo.estnColumn2}"/>
	                                                </c:otherwise>
	                                            </c:choose>
											</c:if>
										</td>
                                        <!-- 상태 -->
                                        <td>
                                            <c:if test="${baseVo.bizProgression eq 'COM'}"><span class="condi_a">완료</span></c:if>
                                            <c:if test="${baseVo.bizProgression eq 'INC'}"><span class="condi_b">완료</span></c:if>
                                            <c:if test="${baseVo.bizProgression eq 'PRO'}"><span class="condi_d">진행중</span></c:if>
                                        </td>
                                    </c:when>
                                    <c:when test="${arrange.columnId eq 'ESTN_COLUMN6'}">
                                        <!-- 종료일 -->
                                        <!-- <td class="end_date"><c:out value='${baseVo.estnColumn6}'/></td> -->
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
                                        <!-- 등록일 20161221 출력형식변경 yyyy.mm.dd -->
                                        <td><c:set var="str" value="${baseVo.registDt}"/>${fn:substring(str,0,10)}</td>
                                        <%-- <td class="date"><c:out value='${baseVo.registDt}'/></td> --%>
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
					<!-- paging -->
					<!-- 페이징 -->
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
		            <!-- //페이징 -->
					<!-- //paging -->
				</div>				
				<!-- //section -->
				<!-- 20161219 버튼위치변경 : 리스트상단-> 리스트하단 -->
				<div class="btn-area ar">
					<!-- <a href="#" onclick="jsSearchReset(); return false;" class="b-btn type3"><strong><span class="ml10 mr10">목록보기</span></strong></a> -->
					<a href="#" onclick="jsInsertForm('INSERT'); return false; " class="b-btn request type3"><strong><span>요청</span></strong></a>
				</div>				
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->