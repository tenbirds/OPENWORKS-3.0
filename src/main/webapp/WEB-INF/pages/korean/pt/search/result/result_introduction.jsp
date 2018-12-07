<%@ page contentType="text/html;charset=UTF-8" %>
<%
	thisCollection = "introduction";
	if (collection.equals("ALL") || collection.equals(thisCollection)) {
		int count = wnsearch.getResultCount(thisCollection);
		int thisTotalCount = wnsearch.getResultTotalCount(thisCollection);
		
		request.setAttribute("thisTotalCount", thisTotalCount);
		request.setAttribute("thisCollection", thisCollection);
		
		if ( thisTotalCount > 0 ) {		
%>

<!-- 소개 -->
						<div class="contArea">
							<div class="cont">
								<div class="title_area">
									<h3>소개</h3>
									<div class="sech_result">검색결과<span class="num"><em>${thisTotalCount}</em></span>건</div>
										<c:if test="${collection == 'introduction'}">
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
				String DOCID							= wnsearch.getField(thisCollection,"DOCID",idx,false);
                String REGIST_DT						= wnsearch.getField(thisCollection,"REGIST_DT",idx,false);
                String HEAD_CNTNTS				= wnsearch.getField(thisCollection,"HEAD_CNTNTS",idx,false);
                String BODY_CNTNTS				= wnsearch.getField(thisCollection,"BODY_CNTNTS",idx,false);
                String CONFM_STTUS				= wnsearch.getField(thisCollection,"CONFM_STTUS",idx,false);
                String USER_MENU_URL			= wnsearch.getField(thisCollection,"USER_MENU_URL",idx,false);
                String MENU_PATH					= wnsearch.getField(thisCollection,"MENU_PATH",idx,false);
				HEAD_CNTNTS						= wnsearch.getKeywordHl(HEAD_CNTNTS,"<span class=\"fc_org\">","</span>");
				BODY_CNTNTS						= wnsearch.getKeywordHl(BODY_CNTNTS,"<span class=\"fc_org\">","</span>");
            	String URL = USER_MENU_URL;
            	REGIST_DT = REGIST_DT.replaceAll("-", ".");

%>								
									<li>
										<dl>
											<dt><a href="<%=URL%>"><%=HEAD_CNTNTS%></a></dt>
											<dd><a href="<%=URL%>"><%=BODY_CNTNTS%></a></dd>
										</dl>
										<div class="path"><%=MENU_PATH%></div>
									</li>
<%
			}
%>											
								</ul>
							<c:if test="${collection == 'introduction'}">	
								<!-- paging -->
								<div class="paging">
									${search_paging}
								</div>
								<!-- //paging -->
							</c:if>
							<c:choose>
								<c:when test="${collection == 'ALL' && thisTotalCount > 3 }">	
									<div class="btn">
										<a href="#" class="btn_more" onClick="javascript:doCollection('${thisCollection}');"><img src="/resources/web/theme/default/images/btn/btn_more.gif" alt="소개 서비스 더보기"></a>
									</div>
								</c:when>
							</c:choose>
							</div>
						</div>
						<!-- //소개 -->
						
<%
		}
	}
%>						