<%@ page contentType="text/html;charset=UTF-8" %>
<%
	thisCollection = "premium";
	if (collection.equals("ALL") || collection.equals(thisCollection)) {
		int count = wnsearch.getResultCount(thisCollection);
		int thisTotalCount = wnsearch.getResultTotalCount(thisCollection);

		request.setAttribute("thisTotalCount", thisTotalCount);
		request.setAttribute("thisCollection", thisCollection);

		if ( thisTotalCount > 0 ) {
%>

<!-- 표준프레임워크호환 서비스 -->
						<div class="contArea">
							<div class="cont">
								<h3>표준프레임워크호환 서비스</h3>
								<div class="sech_result">검색결과<span class="num"><em>${thisTotalCount}</em></span>건</div>
									<c:if test="${collection == 'premium'}">
										<div class="select">
											<select id="select1" name="select1" onChange="doClick(this.value)" title="20개, 40개, 60개씩 보기 중 선택">
												<option value="20" <c:if test="${viewCount == 20}">selected="selected"</c:if>>20개씩 보기</option>
												<option value="40" <c:if test="${viewCount == 40}">selected="selected"</c:if>>40개씩 보기</option>
												<option value="60" <c:if test="${viewCount == 60}">selected="selected"</c:if>>60개씩 보기</option>
											</select>
										</div>
									</c:if>
								<div class="list_colum">
									<div class="list">
										<ul>
<%
			for(int idx = 0; idx < count; idx ++) {
				String DOCID								= wnsearch.getField(thisCollection,"DOCID",idx,false);
                String REGIST_DT							= wnsearch.getField(thisCollection,"REGIST_DT",idx,false);
                String CTGRY_CL_CD					= wnsearch.getField(thisCollection,"CTGRY_CL_CD",idx,false);
                String LANGCODE						= wnsearch.getField(thisCollection,"LANGCODE",idx,false);
                String GOODSNM						= wnsearch.getField(thisCollection,"GOODSNM",idx,false);
                String USERID								= wnsearch.getField(thisCollection,"USERID",idx,false);
                String GOODSIMAGEFILESEQ		= wnsearch.getField(thisCollection,"GOODSIMAGEFILESEQ",idx,false);
                String GOODSSUMRY					= wnsearch.getField(thisCollection,"GOODSSUMRY",idx,false);
                String GOODSRDCNT					= wnsearch.getField(thisCollection,"GOODSRDCNT",idx,false);
                String CNTC_INSTT_CD					= wnsearch.getField(thisCollection,"CNTC_INSTT_CD",idx,false);
                String EVLSCORE							= wnsearch.getField(thisCollection,"EVLSCORE",idx,false);
                String LANGSTORENM					= wnsearch.getField(thisCollection,"LANGSTORENM",idx,false);
                String CMMNTYID						= wnsearch.getField(thisCollection,"CMMNTYID",idx,false);
                String ATTACH_CON					= wnsearch.getField(thisCollection,"ATTACH_CON",idx,false);
                String METALICENCE					= wnsearch.getField(thisCollection,"METAlICENCE",idx,false);
                String CNTC_GOODS_IMAGE_SEQ	= wnsearch.getField(thisCollection,"CNTC_GOODS_IMAGE_SEQ",idx,false);
                String MARK_IMG						= wnsearch.getField(thisCollection,"MARK_IMG",idx,false);
                String META_NM							= wnsearch.getField(thisCollection,"META_NM",idx,false);
				GOODSNM									= wnsearch.getKeywordHl(GOODSNM,"<span class=\"fc_org\">","</span>");
				GOODSSUMRY							= wnsearch.getKeywordHl(GOODSSUMRY,"<span class=\"fc_org\">","</span>");
				LANGSTORENM							= wnsearch.getKeywordHl(LANGSTORENM,"<span class=\"fc_org\">","</span>");

				
				String URL = "/korean/pt/store/inc/BD_storeView.do?goodsCode=" +DOCID;
                String IMG_EVLSCORE = "";
                // 이전소스
                //String SubDomain = CmsUtil.getHostName(request.getServerName());
                //String communityUrl ="http://" +SubDomain+ ".ceart.kr/community/" + CMMNTYID;                
                //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
				//변경소스
				String communityUrl ="http://"+GlobalConfig.DOMAIN_SUBNM+"/community/" + CMMNTYID;
				//}}
                
				String[] MARK_IMG_ARRAY = null;

				MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");

               	if (EVLSCORE.length() > 0 ) {
                	IMG_EVLSCORE = EVLSCORE.substring(0,1);
                }  else {
                	EVLSCORE = "0.0";
                	IMG_EVLSCORE ="0";
                }
%>
											<li>
												<div class="info">
													<div class="photo"><a href="<%=URL%>"><img src="<%=GOODSIMAGEFILESEQ%>" alt="<%=GOODSNM%>"></a></div>
													<div class="subject"><a href="<%=URL%>"><%=GOODSNM%></a></div>
													<div class="txt"><a href="<%=URL%>"><%=GOODSSUMRY%></a></div>
													<div class="ico">
<%
													if (MARK_IMG.length() > 0 ) {
														for (int i=0; i < MARK_IMG_ARRAY.length; i++) {
%>
															<img src="<%=MARK_IMG_ARRAY[i]%>" alt="markImg">
<%
														}
													}
%>
													</div>
												</div>
												<div class="etc">
													<p><%=LANGSTORENM%></p>
<%
													if (CMMNTYID.length() > 0 ) {
%>
													<div class="desc"><a href="<%=communityUrl%>" target="_black"><img src="/resources/web/theme/default/images/common/ico/ico_community.gif" alt="커뮤니티"></a></div>
<%
													}
%>
<!-- 													<div class="grade"> -->
<%-- 														<img src="/resources/web/theme/default/images/common/ico/ico_star_<%=IMG_EVLSCORE%>.gif" alt="평점<%=IMG_EVLSCORE%>"> --%>
<%-- 														<span class="txt">평점 <%=EVLSCORE%></span> --%>
<!-- 													</div> -->

												</div>
											</li>
<%
			}
%>
										</ul>
									</div>
								</div>
								<c:if test="${collection == 'premium'}">
								<!-- paging -->
									<div class="paging">
										${search_paging}
									</div>
									<!-- //paging -->
								</c:if>
								<c:choose>
									<c:when test="${collection == 'ALL' && thisTotalCount > 3 }">
										<div class="btn">
											<a href="#" class="btn_more" onClick="javascript:doCollection('${thisCollection}');"><img src="/resources/web/theme/default/images/btn/btn_more.gif" alt="표준프레임워크호환 서비스 더보기"></a>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div>
						<!-- //표준프레임워크호환 서비스 -->
<%
		}
	}
%>
