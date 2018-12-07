<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "paas_cloud" );
		resultColCnt = search_col.w3GetResultCount("paas_cloud");
		if(resultColTotalCnt > 0){
%>
	
		<!-- PaaS 검색결과 -->
		<h3>PaaS <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="tbl_st7">
				<thead>
					<tr>
						<th style="width:184px; text-align: center;">서비스명</th>
						<th style="width:505px; text-align: center;">설명</th>
						<th style="width:106px; text-align: center;">등록일</th>
					</tr>
				</thead>
				<tbody>
			
			<%
				for(int idx=0; idx < resultColCnt; idx++){
					String DOCID = search_col.w3GetField("paas_cloud","DOCID",idx);
					String URL   = "/korean/pt/store/inc/BD_storeView.do?goodsCode=" +DOCID;
					String MARK_IMG = search_col.w3GetField("paas_cloud","MARK_IMG",idx);
					String[] MARK_IMG_ARRAY = null;
					MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");
					String REGISTDT = search_col.w3GetField("paas_cloud", "REGISTDT", idx);
					String USERID = search_col.w3GetField("paas_cloud", "USERID", idx);
					String GOODSMAINIMAGE = search_col.w3GetField("paas_cloud", "GOODSMAINIMAGE", idx);
					
			%>
				<tr>
					<th rowspan="2" style="white-space:normal;">
						<a href="<%=URL%>" style="font-size:16px; color:#0186e1; word-break:keep-all;"><%=search_col.w3GetField("paas_cloud", "GOODSNM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %>
							<img src="<%=GOODSMAINIMAGE%>" alt="서비스메인이미지" />
						</a>
					</th>
					<td>
						<a href="#" onclick="jsSeller('<%=USERID%>');"><%=search_col.w3GetField("paas_cloud", "LANGSTORENM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						<a href="<%=URL%>"><%=search_col.w3GetField("paas_cloud", "GOODSSUMRY", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</td>
					<td>
						<fmt:parseDate value='<%=REGISTDT%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
						<i><fmt:formatDate value="${registDt}" pattern="yyyy-MM-dd"/></i>
					</td>
				</tr>
				<tr>
					<td>
						<!-- 마크 이미지 있을경우 -->
						<%
			                if (MARK_IMG.length() > 0 ) {
							    for (int i=0; i < MARK_IMG_ARRAY.length; i++) {
			            %>
						<img src="<%=MARK_IMG_ARRAY[i]%>" alt="markImg" />
			            <%
						        }
							}
			            %>
			            <!-- //마크 이미지 있을경우 -->
					</td>
					<td></td>
				</tr>
			<%
				}//for
			%>
				</tbody>
			</table>
		</div>
		<!-- //list -->
		<!-- //소프트웨어 검색결과 -->
		<%//if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<%if("ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('paas_cloud');"class="btns st1">더보기</a>
		</div>
		<%//}else if(resultColTotalCnt > TOTALVIEWCOUNT && "paas_cloud".equals(collection)){ %>
		<%}else if( "paas_cloud".equals(collection)){ %>
		<!-- paging -->
		<div class="paging">
			<%=getPageLinks(startCount, resultColTotalCnt, 10,10) %>
			
		</div>
		<%} %>
		<!-- //paging -->
<%	
		}else{
%>
		    <div class="contArea_wrap"> 
		    <h3>PaaS <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "merge_software".equals(collection))
%>					