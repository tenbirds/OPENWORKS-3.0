<%@ page contentType="text/html;charset=UTF-8" %>

<%
	thisCollection = "notice";
	if (collection.equals("ALL") || collection.equals(thisCollection)) {
		int count = wnsearch.getResultCount(thisCollection);
		int thisTotalCount = wnsearch.getResultTotalCount(thisCollection);
		
		request.setAttribute("thisTotalCount", thisTotalCount);
		request.setAttribute("thisCollection", thisCollection);
		
		if ( thisTotalCount > 0 ) {
%>

		<!-- 공지사항 -->
						<div class="contArea">
							<div class="cont">
								<div class="title_area">
									<h3>공지사항</h3>
									<div class="sech_result">검색결과<span class="num"><em>${thisTotalCount}</em></span>건</div>
									<c:if test="${collection == 'notice'}">
										<div class="select">
											<select id="select1" name="select1" onChange="doClick(this.value)" title="20개, 40개, 60개씩 보기 중 선택">
												<option value="20" <c:if test="${viewCount == 20}">selected="selected"</c:if>>20개씩 보기</option>
												<option value="40" <c:if test="${viewCount == 40}">selected="selected"</c:if>>40개씩 보기</option>
												<option value="60" <c:if test="${viewCount == 60}">selected="selected"</c:if>>60개씩 보기</option>
											</select>
										</div>
									</c:if>	
								</div>
								<ul class="cont_list">
<%
			for(int idx = 0; idx < count; idx ++) {
                String DOCID				= wnsearch.getField(thisCollection,"DOCID",idx,false);
                String REGIST_DT			= wnsearch.getField(thisCollection,"REGIST_DT",idx,false);
                String BBS_CD				= wnsearch.getField(thisCollection,"BBS_CD",idx,false);
                String BBSCTT_SJ			= wnsearch.getField(thisCollection,"BBSCTT_SJ",idx,false);
                String BBSCTT_CN		= wnsearch.getField(thisCollection,"BBSCTT_CN",idx,false);
                String CN_SUMRY		= wnsearch.getField(thisCollection,"CN_SUMRY",idx,false);
                String FILE_SEQ			= wnsearch.getField(thisCollection,"FILE_SEQ",idx,false);
                String ATTACH_CON	= wnsearch.getField(thisCollection,"ATTACH_CON",idx,false);
                String MENU_PATH		= wnsearch.getField(thisCollection,"MENU_PATH",idx,false);
				BBSCTT_SJ					= wnsearch.getKeywordHl(BBSCTT_SJ,"<span class=\"fc_org\">","</span>");
				CN_SUMRY					= wnsearch.getKeywordHl(CN_SUMRY,"<span class=\"fc_org\">","</span>");
				String URL 					= "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;

%>								
									<li>
										<dl>
											<dt><a href="<%=URL%>"><%=BBSCTT_SJ%></a></dt>
											<dd><a href="<%=URL%>"><%=CN_SUMRY%></a></dd>
										</dl>
										<div class="path"><%=MENU_PATH%></div>
									</li>
<%
			}
%>									
								</ul>
								<c:if test="${collection == 'notice'}">
									<!-- paging -->
									<div class="paging">
										${search_paging}
									</div>
									<!-- //paging -->
								</c:if>	
								<c:choose>
									<c:when test="${collection == 'ALL' && thisTotalCount > 3 }">
										<div class="btn">
											<a href="#" class="btn_more" onClick="javascript:doCollection('${thisCollection}');"><img src="/resources/web/theme/default/images/btn/btn_more.gif" alt="공지사항 서비스 더보기"></a>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div>
						<!-- //공지사항 -->
<%
		}
	}
%>
