<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<script type="text/javascript">
var jsServiceView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "/korean/pt/store/inc/BD_storeView.do";
        document.dataForm.submit();
};
</script>
<%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
<form id="dataForm" name="dataForm" method="post">
<input type="hidden" id="goodsCode" name="goodsCode" value=""/>
</form>
<op:pagerParam page="param/webListPagerParam.jsp" />
<div class="type-list">

<!-- 게시판 (서비스리뷰, 성공사례를 제외한 -->
<c:if test="${boardConfVo.bbsCd ne '1008' and boardConfVo.bbsCd  ne '1009' or boardConfVo.bbsCd eq '1011'}">
	<!-- 목록 시작 -->
	<table summary="기본게시판 목록으로 번호,분류,제목,작성자,작성일 등의 조회 정보를 제공합니다.">
		<caption>
			<strong>기본게시판 목록 </strong>
		</caption>
		<colgroup>
			<c:set var="thCnt" value="${thCnt + 1}" />
			<col width="10%" />
			<!-- 목록 배치에서 설정한 항목 배치 -->
			<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
				<c:set var="thCnt" value="${thCnt + 1}" />
				<c:choose>
					<c:when test="${arrange.columnId eq 'CTG_CD'}">
					<c:if test="${boardConfVo.bbsCd ne 1031}">
						<col style="width: 12%"/>
					</c:if>
					<c:if test="${boardConfVo.bbsCd eq 1031}">
						<c:if test="${param.q_ctgCd eq '' or param.q_ctgCd eq null }">
						<col style="width: 12%"/>
						</c:if>
					</c:if>
					</c:when>
					<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
						<col style="width: *%"/>
					</c:when>
					<c:when test="${arrange.columnId eq 'REGIST_ID'}">
						<col style="width: 12%"/>
					</c:when>
					<c:when test="${arrange.columnId eq 'REGIST_DT'}">
						<col style="width: 15%"/>
					</c:when>
					<c:when test="${arrange.columnId eq 'RDCNT'}">
						<col style="width: 10%"/>
					</c:when>
					<c:otherwise>
						<col style="width: *%"/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</colgroup>
		
		<thead>
			<tr>
				<!-- 번호(필수) -->
				<th id="th-ROWNUM" scope="col"><span class="sort cs_pointer" id="ROWNUM">번호</span></th>
				<!-- 목록 배치에서 설정한 항목 배치 -->
				<c:if test="${boardConfVo.bbsCd ne 1031 }">
				<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="status">
					<th id="th-${arrange.columnId}" scope="col">
						<span class="sort cs_pointer" id="${arrange.columnId}"> 
							<c:out value='${arrange.langColumnNm}' />
						</span>
					</th>
				</c:forEach>
				</c:if>
				<c:if test="${boardConfVo.bbsCd eq 1031 }">
				<c:if test="${param.q_ctgCd eq '' or param.q_ctgCd eq null }">
					<th id="th-CTG_CD" scope="col">구분</th>
				</c:if>
					<th id="th-BBSCTT_SJ" scope="col">사례명</th>
					<th id="th-GOODS_NM" scope="col">서비스명</th>
				</c:if>
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
									<a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>" rel="#titleNoticeSummary${status.count}" onclick="jsView('${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
										<c:out value='${noticeVo.bbscttSj}' /> 
										<c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
									</a> 
									<c:if test="${noticeVo.othbcAt != 'Y'}">
										<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
									</c:if> 
								<c:choose>
									<c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
										<a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">
											<img alt="첨부된 이미지" src="/resources/web/theme/default/images/common/ico/ico_image.gif" />
										</a>
									</c:when>
									<c:when test="${noticeVo.fileCnt > 0}">
										<span class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">
											<img alt="첨부된 이미지" src="/resources/web/theme/default/images/common/ico/ico_image.gif" />
										</span>
									</c:when>
								</c:choose> 
									<c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
										<span class="t_reply" title="의견글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span>
									</c:if> 
									<c:if test="${boardConfVo.newArticleNum > 0}">
										<c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}"></c:if>
									</c:if>
									</td>
								</c:when>
								<c:when test="${arrange.columnId eq 'CTG_CD'}">
									<!-- 분류 항목 : 공지 목록이므로 '공지'로 표시 -->
									<td>공지</td>
								</c:when>
								<c:when test="${arrange.columnId eq 'RDCNT'}">
									<!-- 조회수 항목 -->
									<td>
										<c:if test="${boardConfVo.emphasisNum <= noticeVo.rdcnt}">
											<span class="tx_blue"><c:out value='${noticeVo.rdcnt}' /></span>
										</c:if> 
										<c:if test="${boardConfVo.emphasisNum > noticeVo.rdcnt}">
											<span><c:out value='${noticeVo.rdcnt}' /></span>
										</c:if>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<op:bean-util field="${arrange.columnId}" obj="${noticeVo}" />
									</td>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</tr>
				</c:forEach>
			</c:if>

			<!-- 공지 제외 게시물 목록 -->
			<c:set var="index" value="${pager.indexNo}" />
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
						</c:choose></td>

						<!-- 목록 배치에서 설정한 항목 배치 -->
						<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
						<c:choose>
							<c:when test="${arrange.columnId eq 'CTG_CD'}">
								<!-- 분류 항목 -->
								<c:if test="${boardConfVo.bbsCd eq 1031 }">
								<c:if test="${param.q_ctgCd eq '' or param.q_ctgCd eq null }">
								<td class="classify"><c:out value='${baseVo.ctgNm}' /></td>
								</c:if>
								</c:if>
								<c:if test="${boardConfVo.bbsCd eq 1001 }">
								<td class="classify"><c:out value='${baseVo.ctgNm}' /></td>
								</c:if>
							</c:when>
							<c:when test="${arrange.columnId eq 'BBSCTT_SJ'}">
								<!-- 제목 항목 -->
								<td class="t_al" style="text-align:left">
									<a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">									
										<c:out value='${baseVo.bbscttSj}' /> 
										<c:if test="${baseVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
										<c:if test="${baseVo.fileCnt > 0}">
											<img alt="첨부된 이미지" class="ico" src="/resources/web/theme/default/images/common/ico/ico_image.gif" />
										</c:if>
									</a> 
									<c:if test="${baseVo.othbcAt != 'Y'}">
										<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
									</c:if> 
									<c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
										<span class="num" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">[${baseVo.commentCnt}]</span>
									</c:if> 
									<c:if test="${boardConfVo.newArticleNum > 0}">
										<c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
										<!--                                                        <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
										</c:if>
									</c:if> 
									<c:if test="${baseVo.othbcAt eq 'N'}">
										<div id="titleSummary${status.count}" class="tx_blue_s">* 비밀글 입니다. *</div>
									</c:if>
								</td>
							</c:when>

							<c:when test="${arrange.columnId eq 'REGIST_ID'}">
								<!-- 아이디 항목 -->
								<td class="date">${baseVo.maskRegistId}</td>
							</c:when>
							<c:when test="${arrange.columnId eq 'REGIST_DT'}">
							
							<!-- 작성일 정책동향,시장동향 작성일 yyyy.mm.dd-->
							<c:choose>
								<c:when test="${boardConfVo.bbsCd eq '1023' or boardConfVo.bbsCd eq '1024'}">
									<td class="date">${fn:substring(baseVo.registDt,0,10)}</td>
								</c:when>
								<c:otherwise>
									<td class="date">${baseVo.registDt}</td>
								</c:otherwise>
							</c:choose>

							</c:when>
							<c:when test="${arrange.columnId eq 'RDCNT'}">
								<!-- 조회수 항목 -->
								<td>
									<c:if test="${boardConfVo.emphasisNum <= baseVo.rdcnt}">
										<span class="tx_blue"><c:out value='${baseVo.rdcnt}' /></span>
									</c:if> 
									<c:if test="${boardConfVo.emphasisNum > baseVo.rdcnt}">
										<span><c:out value='${baseVo.rdcnt}' /></span>
									</c:if>
								</td>
							</c:when>
							<c:otherwise>
							<c:if test="${boardConfVo.bbsCd ne 1031 }">
								<td>
									<op:bean-util field="${arrange.columnId}" obj="${baseVo}" />
								</td>
							</c:if>
							<c:if test="${boardConfVo.bbsCd eq 1031 }">
								<td style="text-align: left">
									<c:set var="goodsNmArry" value="${fn:split(baseVo.goodsNm, '^') }"/>
									<c:set var="goodsCdArry" value="${fn:split(baseVo.goodsCd, ',') }"/>
										<c:forEach var="goodsCode" items="${goodsCdArry}"  varStatus="i">
										<c:forEach var="goodsName" items="${goodsNmArry}" varStatus="s">
										<c:if test="${goodsName ne null and goodsName ne ''}">
										<c:if test="${i.index eq s.index }">
											<li>
												<a href="javascript:jsServiceView('${goodsCode }');">${goodsName}</a>
											</li><c:if test="${fn:length(goodsCdArry) < i.index}"><br /></c:if>
										</c:if>
										</c:if>
										</c:forEach>
									</c:forEach>
								</td>
							</c:if>
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
		<tfoot style="display: block;">
			<tr><td colspan="5"></td></tr>
		</tfoot>
	</table>
	<!-- //목록 끝 -->
</c:if>







<!-- 서비스리뷰-->
<c:if test="${boardConfVo.bbsCd eq '1008' or boardConfVo.bbsCd eq '1009'}">

	<!-- 리스트 -->
	<div class="product_list">
<!-- 	<div class="type-thumb type-list"> -->
		<ul>
			<!-- 공지목록 -->
			<c:forEach items="${noticeList}" var="noticeVo" varStatus="status">
				<li>
					<c:set var="index" value="${pager.indexNo}" /> 
					<c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
						<c:choose>
							<c:when test="${arrange.columnId eq 'FILE_SEQ'}">
								<!-- 썸네일 이미지 -->
								<div class="photo">
									<c:choose>
										<c:when test="${(noticeVo.fileCnt > 0) && (noticeVo.fileList[0].localNm != '')}">
											<p class="thumb fl mr20"><img src="<c:url value="${noticeVo.fileList[0].fileUrl}" />" title="${noticeVo.fileList[0].localNm}" alt="${noticeVo.fileList[0].localNm}" style="width: 156px; height: 177px;" /></p>
										</c:when>
										<c:otherwise>
											<p class="thumb fl mr20"><img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지" /></p>
										</c:otherwise>
									</c:choose>
								</div>
							</c:when>
							<c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">
								<div class="info">
									<!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
									<c:if test="${arrange.columnId eq 'BBSCTT_SJ'}">
										<!--제목 -->
										<c:choose>
											<c:when test="${noticeVo.mngrDeleteAt eq 'Y'}">
												<strong>[관리자에 의하여 삭제되었습니다.]</strong>
											</c:when>
											<c:otherwise>
												<a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('${noticeVo.domainCd}','${noticeVo.bbsCd}', '${noticeVo.bbscttSeq}', '${noticeVo.registPassword}', '${noticeVo.othbcAt}'); return false;">
													<c:if test="${boardConfVo.bbsCd eq '1008'}">
														<span class="field">[${noticeVo.goodsNm}]</span>
													</c:if> 
													<strong><c:out value='${noticeVo.bbscttSj}' /> </strong>
													<c:if test="${noticeVo.bbscttSjLength > (boardConfVo.cutTitleNum * 2)}">...</c:if>
												</a>

												<c:if test="${noticeVo.othbcAt != 'Y'}">
													<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
												</c:if>

												<c:choose>
													<c:when test="${(boardConfVo.dwldYn eq 'Y') && (noticeVo.fileCnt > 0) && (noticeVo.othbcAt eq 'Y')}">
														<%--                                                                    <a href="/component/file/zipdownload.do?fileSeq=${noticeVo.fileSeq}" class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</a> --%>
													</c:when>
													<c:when test="${noticeVo.fileCnt > 0}">
														<%--                                                                    <span class="t_file" title="첨부파일이 ${noticeVo.fileCnt}개 존재합니다.">(${noticeVo.fileCnt})</span> --%>
													</c:when>
												</c:choose>

												<c:if test="${boardConfVo.cmtYn eq 'Y' && noticeVo.commentCnt > 0}">
													<%--                                                                <span class="t_reply" title="댓글이 ${noticeVo.commentCnt}개 존재합니다.">(${noticeVo.commentCnt})</span> --%>
												</c:if>

												<c:if test="${boardConfVo.newArticleNum > 0}">
													<c:if test="${noticeVo.passDay <= boardConfVo.newArticleNum}">
														<!--                                                                    <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
													</c:if>
												</c:if>

												<c:if test="${noticeVo.othbcAt eq 'N'}">
													<%--                                                                <div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div> --%>
												</c:if>
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${arrange.columnId eq 'CN_SUMRY'}">
										<!--내용요약 -->
										<div class="txt">
											<c:out value='${noticeVo.cnSumry}' />
										</div>
									</c:if>
									<c:if test="${arrange.columnId eq 'REGIST_ID'}">
										<!--등록자명 -->
										<div class="desc">
											<span><c:out value='${noticeVo.maskRegistId}' /></span>
									</c:if>
									<c:if test="${arrange.columnId eq 'REGIST_DT'}">
										<!--등록일시 -->
										<span><c:out value='${noticeVo.registDt}' /></span>
									</c:if>
									<c:if test="${arrange.columnId eq 'RDCNT'}">
										<!--조회수 -->
										<span>조회수 <c:out value='${noticeVo.rdcnt}' /></span>
								</div>
							</c:if>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
		</li>
	</c:forEach>




	<!-- 성공스토리 -->
    <c:if test="${boardConfVo.bbsCd eq '1009'}">
	
	    <!-- 리스트 -->
	    <div class="type-thumb type-list">
	        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	
	            <ul>
		            <li class="cont">
		                <c:set var="index" value="${pager.indexNo}" /> 
		                <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
			            <c:choose>
				            <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
					            <!-- 썸네일 이미지 -->
					            <c:choose>
						            <c:when test="${(baseVo.fileCnt > 0) && (baseVo.fileList[0].localNm != '')}">
							            <p class="thumb fl mr20">
							                <img src="<c:url value="${baseVo.fileList[0].fileUrl}" />" alt="${baseVo.fileList[0].localNm}" />
							            </p>
						            </c:when>
						            <c:otherwise>
							            <p class="thumb fl mr20">
    							            <img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지" />
	    						        </p>
		    				        </c:otherwise>
			    		        </c:choose>					
				            </c:when>
				            
				            <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">		
				                <!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
					            <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}">
					                <!--제목 -->
						         		<div >						
							            <c:choose>
								            <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
									            <strong>[관리자에 의하여 삭제되었습니다.]</strong>
								            </c:when>
								            <c:otherwise>
									            <a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>"  rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;"><strong><font style="font-size:15px;"><c:out value='${fn:substring(baseVo.bbscttSj,0,45)}' /><c:if test="${baseVo.bbscttSjLength > 45}">...</c:if></font></strong>
												</a>
										</div><br/>
										<c:if test="${baseVo.othbcAt != 'Y'}">
											<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
										</c:if>
	
										<c:choose>
											<c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
												<%-- <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a> --%>
											</c:when>
											<c:when test="${baseVo.fileCnt > 0}">
												<%--    <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span> --%>
											</c:when>
										</c:choose>
	
										<c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
											<%--   <span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span> --%>
										</c:if>
	
										<c:if test="${boardConfVo.newArticleNum > 0}">
											<c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
												<!--   <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
											</c:if>
										</c:if>
	
										<c:if test="${baseVo.othbcAt eq 'Y'}">
											<%--  <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div> --%>
										</c:if>
	
										<c:if test="${baseVo.othbcAt eq 'N'}">
											<%-- <div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div> --%>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:if>															
									<c:if test="${arrange.columnId eq 'CN_SUMRY'}">
										<!--내용요약 -->
										<div class="txt">
											<c:out value='${baseVo.cnSumry}' />
										</div>
									</c:if>
									<p class="data-info">
										<c:if test="${arrange.columnId eq 'REGIST_ID'}">
											<!--등록자명 -->										
											<span>${baseVo.maskRegistId}</span><span>${baseVo.registDt}</span><span>조회수 <c:out value='${baseVo.rdcnt}' /></span>				
										</c:if>
								
									</p>	
								</dd>								
							</dl>

					</c:when>
				</c:choose>
		</c:forEach>
		</li>
		</ul>
	</c:forEach>
	</div>
</c:if>



<!-- 공지 제외목록 -->
<c:if test="${boardConfVo.bbsCd ne '1008' and boardConfVo.bbsCd ne '1009' and boardConfVo.bbsCd ne 1011}">
	<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		<li class="cont">
		    <c:set var="index" value="${pager.indexNo}" /> 
		    <c:forEach items="${boardConfVo.listArrange}" var="arrange" varStatus="arrStatus">
			    <c:choose>
				    <c:when test="${arrange.columnId eq 'FILE_SEQ'}">
					    <!-- 썸네일 이미지 -->
					    <div class="photo">
						    <c:choose>
							    <c:when test="${(baseVo.fileCnt > 0) && (baseVo.fileList[0].localNm != '')}">
								    <p class="thumb fl mr20"><img src="<c:url value="${baseVo.fileList[0].fileUrl}" />" title="${baseVo.fileList[0].localNm}" alt="${baseVo.fileList[0].localNm}" style="width: 156px; height: 117px;" /></p>
							    </c:when>
							    <c:otherwise>
								    <p class="thumb fl mr20"><img src="<c:url value="/resources/web/theme/default/images/community/no_img.gif" />" alt="손상된 이미지" /></p>
							    </c:otherwise>
						    </c:choose>
					    </div>
				    </c:when>
				    
				    <c:when test="${arrange.columnId eq 'BBSCTT_SJ' or arrange.columnId eq 'CN_SUMRY' or arrange.columnId eq 'REGIST_ID' or arrange.columnId eq 'REGIST_DT' or arrange.columnId eq 'RDCNT' }">		
				    <!-- 제목, 내용, 등록자명, 등록일시, 조회수 -->
					    <c:if test="${arrange.columnId eq 'BBSCTT_SJ'}">
					        <!--제목 -->
						    <dl>
						        <div class="info">
							    <c:choose>
								    <c:when test="${baseVo.mngrDeleteAt eq 'Y'}">
									    <strong>[관리자에 의하여 삭제되었습니다.]</strong>
								    </c:when>
								    
								    <c:otherwise>
									<dt><a href="/web/board/BD_board.view.do?domainCd=<c:out value='${baseVo.domainCd}'/>&bbsCd=<c:out value='${baseVo.bbsCd}'/>&bbscttSeq=<c:out value='${baseVo.bbscttSeq}'/>&registPassword=<c:out value='${baseVo.registPassword}'/>&othbcAt=<c:out value='${baseVo.othbcAt}'/>" rel="#titleSummary${status.count}" class="contentTip" onclick="jsView('<c:out value='${baseVo.domainCd}'/>','<c:out value='${baseVo.bbsCd}'/>', '<c:out value='${baseVo.bbscttSeq}'/>', '<c:out value='${baseVo.registPassword}'/>', '<c:out value='${baseVo.othbcAt}'/>'); return false;">
										<c:if test="${boardConfVo.bbsCd eq '1008'}">
											<span class="field">[<c:out value='${baseVo.goodsNm}' />]</span>
										</c:if> 
										<strong><c:out value='${fn:substring(baseVo.bbscttSj,0,45)}' /><c:if test="${baseVo.bbscttSjLength > 45}">...</c:if></strong>
									</a></dt>
										<c:if test="${baseVo.othbcAt != 'Y'}">
											<span class="t_lock" title="비공개 글입니다.">&nbsp;</span>
										</c:if>
	
										<c:choose>
											<c:when test="${(boardConfVo.dwldYn eq 'Y') && (baseVo.fileCnt > 0) && (baseVo.othbcAt eq 'Y')}">
												<%--                                                                    <a href="/component/file/zipdownload.do?fileSeq=${baseVo.fileSeq}" class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</a> --%>
											</c:when>
											<c:when test="${baseVo.fileCnt > 0}">
												<%--                                                                    <span class="t_file" title="첨부파일이 ${baseVo.fileCnt}개 존재합니다.">(${baseVo.fileCnt})</span> --%>
											</c:when>
										</c:choose>
	
										<c:if test="${boardConfVo.cmtYn eq 'Y' && baseVo.commentCnt > 0}">
											<%--                                                                <span class="t_reply" title="댓글이 ${baseVo.commentCnt}개 존재합니다.">(${baseVo.commentCnt})</span> --%>
										</c:if>
	
										<c:if test="${boardConfVo.newArticleNum > 0}">
											<c:if test="${baseVo.passDay <= boardConfVo.newArticleNum}">
												<!--                                                                    <img src="/resources/web/theme/default/images/icon/icon_new.gif" alt="새글"/> -->
											</c:if>
										</c:if>
	
										<c:if test="${baseVo.othbcAt eq 'Y'}">
											<%--                                                                <div id="titleSummary${status.count}" class="tx_blue_s"><c:out value="${baseVo.cnSumry}" escapeXml="true" /></div> --%>
										</c:if>
	
										<c:if test="${baseVo.othbcAt eq 'N'}">
											<%--                                                                <div id="titleSummary${status.count}" class="tx_blue_s" >* 비밀글 입니다. *</div> --%>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:if>
							<dd>
								<p class="data-info">
									<c:if test="${arrange.columnId eq 'CN_SUMRY'}">
									<!--내용요약 -->
										<div class="txt">
											<c:out value='${baseVo.cnSumry}' />
										</div>
									</c:if>
									<c:if test="${arrange.columnId eq 'REGIST_ID'}">
									<!--등록자명 -->
										<div class="desc">
										<span><c:out value='${baseVo.maskRegistId}' /> </span>
									</c:if>
									<c:if test="${arrange.columnId eq 'REGIST_DT'}">
										<!--등록일시 -->
<%-- 										<span>| <c:out value='${baseVo.registDt}' /> </span> --%>
									</c:if>
									<c:if test="${arrange.columnId eq 'RDCNT'}">
										<!--조회수 -->
										<span>| 조회수 <c:out value='${baseVo.rdcnt}' /></span>									
								</p>	
							</dd>	
							</div>
							</dl>
						</c:if>
					</c:when>
				</c:choose>				
		</c:forEach>
		</li>
	</c:forEach>
</c:if>
	<!-- 데이터가 없을 때 알림 문구 -->
	<c:if test="${empty pager.list}">
		<li style="text-align: center;">데이터가 존재하지 않습니다.</li>
	</c:if>
	</ul>
	</div>
</c:if>
</div>