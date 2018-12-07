<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
	
    <!-- 사용자 스크립트 시작 -->
    <script type="text/javascript">
    $().ready(function(){
        
    });
    </script>
    <!-- 사용자 스크립트 끝 -->


	<!-- contents -->
	<div class="contents">
		<!-- title-area -->
		<div class="title-area">
			<h2>
				<c:if test="${boardConfVo.bbsCd eq 1001}">공지사항</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1004}">지식나눔</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1007}">행사 및 이벤트</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1011}">입찰공고</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1009}">성공스토리</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1013}">지식맵</c:if>
			</h2>
		</div>
		<!-- //title-area -->
		
		<!-- section -->
		<div class="section">
			<!-- view -->
			<div class="type-view">
				<!-- 내용보기 -->
				<table>
					<!-- caption -->
					<%-- <caption>
            <strong>${dataVo.bbscttSj} 상세보기</strong>
	            <details>
	            	<summary>${dataVo.bbscttSj} 게시글 정보입니다.</summary>
	            </details>
                </caption> --%>
					<!-- //caption -->

				<!-- colgroup -->
				<colgroup>
					<c:if test="${boardConfVo.bbsCd ne '1001'}">
						<col style="width: *" />
						<col style="width: 35%" />
					</c:if>
					<!-- 공지사항인 경우[1001] -->
					<c:if test="${boardConfVo.bbsCd eq '1001'}">
						<col style="width:;" />
						<col style="width:;" />
					</c:if>
					<!-- 지식나눔인 경우[1004] -->
					<c:if test="${boardConfVo.bbsCd eq '1004'}">
						<col style="width:;" />
						<col style="width:;" />
					</c:if>
					<!-- 행사 및 이벤트인 경우[1007] -->
					<c:if test="${boardConfVo.bbsCd eq '1007'}">
						<col style="width:;" />
						<col style="width:;" />
					</c:if>
					<!-- 기타 입찰 정보인 경우[1007] -->
					<c:if test="${boardConfVo.bbsCd eq '1007'}">
						<col style="width:;" />
						<col style="width:;" />
					</c:if>
					<!-- 성공스토리인 경우[1009] -->
					<c:if test="${boardConfVo.bbsCd eq '1009'}">
						<col style="width:;" />
						<col style="width:;" />
					</c:if>
				</colgroup>
				<!-- colgroup -->

				<!-- tbody -->
			<tbody>
				<!-- 상세 배치에서 설정한 항목 배치 -->
				<c:set var="scoreRow" value="1" />
					<c:forEach items="${boardConfVo.viewArrange}" var="arrange"
						varStatus="arrStatus">
						<c:choose>
							<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
								<!-- c:when 제목부분을 따로 둬야지만 디자인이  먹힘-->
								<c:choose>
									<%-- 성공스토리[1009] / 지식나눔[1004] / 입찰공고[1011] / 행사 및 이벤트[1007] / 공지사항[1001] --%>
									<c:when
										test="${boardConfVo.bbsCd eq '1009' || boardConfVo.bbsCd eq '1004' || boardConfVo.bbsCd eq '1011' || boardConfVo.bbsCd eq '1007' || boardConfVo.bbsCd eq '1001'}">
										<thead>
											<tr>
												<th colspan="2"><c:out value='${dataVo.bbscttSj}' /></th>
											</tr>
										</thead>
									</c:when>
									<%-- 위 내역 이외의 게시판 제목 --%>
									<c:otherwise>
										<tr>
											<td class="tit" colspan="2">
												<c:if test="${boardConfVo.bbsCd eq '1008'}">
													<span class="field">[<c:out	value='${dataVo.goodsNm}' />]
													</span>
												</c:if> <%-- 클라우드스토어 씨앗 지식맵은 하단에 타이틀이 출력되므로 제목란을 출력하지 않음. --%>
												<c:if test="${boardConfVo.bbsCd ne '1013'}">
													<c:out value='${dataVo.bbscttSj}' />
												</c:if>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:when>


							<%-- 등록자 / 조회수 / 등록일자 영역 --%>
							<c:when
								test="${arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'RDCNT' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'CTG_CD'  }">
								<c:choose>
									<%--  성공스토리인 경우  --%>
									<c:when test="${boardConfVo.bbsCd eq '1009'}">
										<c:if test="${arrange.columnId eq 'REGIST_ID'}">
											<tr>
												<td><c:choose>
														<c:when
															test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
															<span class="name"><c:out
																	value='${dataVo.registId}' /></span>
														</c:when>
														<c:otherwise>
															<span class="name"><c:out
																	value='${dataVo.maskRegistId}' /></span>
															<span class="inquiry"> | 조회수 <c:out
																	value='${dataVo.rdcnt}' /></span>
														</c:otherwise>
													</c:choose></td>
										</c:if>
										<c:if test="${arrange.columnId eq 'REGIST_DT'}">
											<td class="ar">
												<div class="cont_r">
													<span class="date"><c:out value='${dataVo.registDt}' /></span>
												</div>
											</td>
											</tr>
										</c:if>
									</c:when>

									<%--  공지사항인 경우  --%>
									<c:when test="${boardConfVo.bbsCd eq '1001'}">
										<c:if test="${arrange.columnId eq 'REGIST_ID'}">
											<tr>
												<td class="al"><c:choose>
														<c:when
															test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
															<span class="name"><c:out
																	value='${dataVo.registId}' /></span>
														</c:when>
														<c:otherwise>
															<span class="name"><c:out
																	value='${dataVo.maskRegistId}' /></span>
														</c:otherwise>
													</c:choose>
										</c:if>
										<c:if test="${arrange.columnId eq 'RDCNT'}">
                                                | 조회수 <c:out
												value='${dataVo.rdcnt}' />
											</td>
										</c:if>

										<c:if test="${arrange.columnId eq 'REGIST_DT'}">
											<td class="ar">
												<div class="cont_r">
													<span class="date"><c:out value='${dataVo.registDt}' /></span>
													<ul class="function">
														<c:if
															test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002'}">
															<c:if
																test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
																<li><a href="#" onclick="jsUpdateForm('UPDATE');">수정</a></li>
																<li><a href="#" onclick="jsDelete();">삭제</a></li>
															</c:if>
														</c:if>
													</ul>
												</div>
											</td>
											</tr>
										</c:if>
									</c:when>

									<%-- 공지사항/성공스토리 이외의 게시판일 경우 --%>
									<c:otherwise>
										<c:if test="${arrange.columnId eq 'REGIST_ID'}">
											<tr>
												<td class="al"><c:choose>
														<c:when
															test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
															<span class="name"><c:out
																	value='${dataVo.registId}' /></span>
														</c:when>
														<c:otherwise>
															<span class="name"><c:out
																	value='${dataVo.maskRegistId}' /></span>
														</c:otherwise>
													</c:choose>
										</c:if>

										<c:if test="${arrange.columnId eq 'RDCNT'}">
                                                | 조회수 <c:out
												value='${dataVo.rdcnt}' />
											</td>
										</c:if>

										<c:if test="${arrange.columnId eq 'REGIST_DT'}">
											<td class="ar">
												<div class="cont_r">
													<span class="date"><c:out value='${dataVo.registDt}' /></span>
													<!-- 수정/삭제 기능은 화면 하단으로 이동
                                                   <ul class="function">
                                                       <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002'}">
                                                           <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
                                                               <a href="#" class="s-btn-type3" onclick="jsUpdateForm('UPDATE');"><strong><span>수정</span></strong></a>
                                                               <a href="#" class="s-btn-type3" onclick="jsDelete();"><strong><span>삭제</span></strong></a>
                                                           </c:if>
                                                       </c:if>
                                                   </ul>
-->
												</div>
											</td>
											</tr>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:when>
							<%-- //등록자 / 조회수 / 등록일자 영역 --%>


							<%-- 게시글 내용 및 첨부파일 영역 --%>
							<c:when
								test="${arrange.columnId eq 'BBSCTT_CN' or arrange.columnId eq 'FILE_SEQ'}">
								<c:if test="${arrange.columnId eq 'BBSCTT_CN'}">
									<c:choose>
										<%-- 지식맵 게시판[1013] 형태인 경우 --%>
										<c:when test="${boardConfVo.bbsCd eq '1013'}">
											<c:set var="map_bbscttCn"
												value="${fn:replace(dataVo.bbscttCn, '<br>', '')}" />
											<c:set var="map_bbscttCn"
												value="${fn:replace(map_bbscttCn, '<br />', '')}" />
											<tr>
												<td colspan="2" class="last">
													<div class="cont_view" style="text-align: left;">
														<c:out value="${map_bbscttCn}" escapeXml="false" />
													</div>
												</td>
											</tr>
										</c:when>

										<%-- 지식맵 게시판 이외의 게시판일 경우 --%>
										<c:otherwise>
											<tr>
												<td colspan="2">
													<div class="txt-cont">
														<c:out value='${dataVo.bbscttCn}' escapeXml="false" />
														<%-- 첨부파일 영역 - 성공사례는 파일이 나오지않음  --%>
														<c:if
															test="${boardConfVo.bbsCd ne '1009' && fn:length(dataVo.fileList) > 0}">
															<div class="file_area">
																<c:choose>
																	<c:when test="${fn:length(dataVo.fileList) > 0}">|&nbsp;
                                                                            <c:forEach
																			items="${dataVo.fileList}" var="fileVo">
																			<span class="file"> <a
																				href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}"
																				title="${fileVo.fileDesc}">${fileVo.localNm}</a>
																				(${fileVo.fileSize})
																			</span>&nbsp;|&nbsp;
                                                                            </c:forEach>
																	</c:when>
																	<c:otherwise>
																		<!--                                                                 <span class="file">첨부파일이 없습니다.</span> -->
																	</c:otherwise>
																</c:choose>
															</div>
														</c:if>
														<%-- //첨부파일 영역 - 성공사례는 파일이 나오지않음  --%>
													</div>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:when>
							<%-- //게시글 내용 및 첨부파일 영역 --%>

							<c:otherwise>
								<!-- 기타 항목 -->
								<tr>
									<td colspan="${boardConfVo.bbsCd eq '1001'? '4':'2'}"
										class="txt_view"><op:bean-util
											field="${arrange.columnId}" obj="${dataVo}" /></td>
								</tr>
							</c:otherwise>

						</c:choose>
					</c:forEach>


					<!-- 태그 -->
					<c:if test="${boardConfVo.tagYn eq 'Y'}">
						<tr>
							<td colspan="2">
								<div class="tag">
									<c:if test="${!empty dataVo.bbsTags}">
										<img
											src="/resources/openworks/theme/default/images/icon/icon_tag.gif"
											alt="태그" class="vm" />
										<c:forEach var="tag" items="${dataVo.bbsTags}"
											varStatus="status">
											<a href="#"
												onclick="jsShowBbsListByTag('<c:out value='${tag}'/>')">${tag}</a>
											<c:if test="${not status.last}">|</c:if>
										</c:forEach>
									</c:if>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- //태그 -->
				</tbody>
				<!-- //tbody -->
			</table>
			<!-- //내용보기 -->

      <!-- 댓글영역 -->
			<c:if
				test="${boardConfVo.cmtYn eq 'Y' and boardConfVo.bbsCd ne '1007' and boardConfVo.bbsCd ne '1009' and boardConfVo.bbsCd ne '1013'}">
				<br />
				<div id="attachedCommentsDiv"></div>
			</c:if>
			<!-- 댓글영역 -->
                
     </div>
     <!-- //view -->


            <!-- 하단버튼 영역 -->
            <!-- {{BH, 2015.12.24 지식맵 하단의 목록버튼 제거로인한 소스추가-->
            <c:if test="${boardConfVo.bbsCd ne '1013'}">
            <!-- }} -->
            <div class="btn-area mt20">
					    <div class="btn_navi">
			    	    <p class="fl">
			            <a href="#" class="b-btn list type1" onclick="jsList('<c:out value='${param.q_currPage}'/>');"><strong><span class="list">목 록</span></strong></a>
			      	  </p>
<%-- 2015.12.17 수정 - 수정/삭제 버튼 화면 하단으로 이동
                <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002' and boardConfVo.bbsCd ne '1004' and boardConfVo.bbsCd ne '1007'}">
	                <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
	                <p class="fr">
	                    <a href="#" class="b-btn list type1" onclick="jsUpdateForm('UPDATE');"><strong><span class="list">수정</span></strong></a>
                        <a href="#" class="b-btn list type1" onclick="jsDelete();"><strong><span class="list">삭제</span></strong></a>
	                </p>
	                </c:if>
                </c:if> 
--%>
                <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002'}">
	              <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">	                
	                <p class="fr">
	                  <a href="#" class="b-btn-type3" onclick="jsUpdateForm('UPDATE');"><strong><span class="list"> 수 정 </span></strong></a>
                    <a href="#" class="b-btn-type3" onclick="jsDelete();"><strong><span class="list"> 삭 제 </span></strong></a>
                    <!-- 2016.11.25 입찰하기 버튼 등록 -->
                    <c:if test="${sessionScope['MEM_TYPE'] eq '1001' || sessionScope['MEM_TYPE'] eq '2001' || sessionScope['MEM_TYPE'] eq '3001'}">
                    	
                    </c:if>
	                </p>
	              </c:if>
              </c:if> 
			    	</div>
<%-- 2015.12.17 수정
        <c:if test="${boardConfVo.bbsCd ne '1009'and boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1002' and boardConfVo.bbsCd ne '1004' and boardConfVo.bbsCd ne '1007'}">
        	<div class="btn_r">
	            <c:if test="${!empty __usk.userKey && __usk.userKey eq dataVo.userKey}">
	                <div class="btn_navi_g" onclick="jsUpdateForm('UPDATE');"><a href="#"><span class="modify">수정</span></a></div>
	                <div class="btn_navi_g" onclick="jsDelete();"><a href="#"><span class="trash">삭제</span></a></div>
	            </c:if>
            </div>
        </c:if>
--%>
         		</div>
         		<!-- {{BH, 2015.12.24 지식맵 하단의 목록버튼 제거로인한 소스추가-->
       			</c:if>
            <!-- }} -->
            <!-- //하단버튼 영역 -->

          <!-- 목록 보여주기 시작 -->
	        <form name="dataForm" id="dataForm" method="post" action="BD_board.list.do">
	            <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
	            <op:pagerParam view="view" />
	            <input type="hidden" name="domainCd"                value="<c:out value='${dataVo.domainCd}'/>" />
	            <input type="hidden" name="bbsCd"                   value="<c:out value='${dataVo.bbsCd}'/>" />
	            <input type="hidden" name="bbscttSeq"               value="<c:out value='${dataVo.bbscttSeq}'/>" />
	            <input type="hidden" name="ctgCd"     id="ctgCd"    value="<c:out value='${dataVo.ctgCd}' />" />
	            <input type="hidden" name="pageType"  id="pageType" value="<c:out value=''/>" />
	        </form>	
        </div>
	    <!-- //section -->
    </div>
	<!-- //contents -->