<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "bizmatc_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "bizmatc_cloud" );
		resultColCnt = search_col.w3GetResultCount("bizmatc_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 비즈매칭  검색결과 -->
				<h3>비즈매칭 <i><%=resultColTotalCnt %></i>건</h3></p>
		<!-- list -->
		<div>
			<table class="list">
			
			<%
				for(int idx=0; idx < resultColCnt; idx++){
					
	                String DOCID      = search_col.w3GetField("bizmatc_cloud","DOCID",idx);
	                String BBS_CD	  = search_col.w3GetField("bizmatc_cloud","BBS_CD",idx);
					String URL        = "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
			%>
			<tr>
				<td>
					<ul>
						<li>
							<dt><a href="<%=URL%>"><%=search_col.w3GetField("bizmatc_cloud", "BBSCTT_SJ", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dt>
							<dd><a href="<%=URL%>"><%=search_col.w3GetField("bizmatc_cloud", "BBSCTT_CN", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dd>
						</li>
					</ul>
				</td>
				<td>
				<%=search_col.w3GetField("customer_cloud", "REGIST_DT", idx) %>
				</td>
			</tr>
			<%
				}//for
			%>
			</table>
		</div>
		<!-- //list -->
		<!-- //소프트웨어 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('bizmatc_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "bizmatc_cloud".equals(collection)){ %>
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
		    <h3>비즈매칭 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "bizmatch".equals(collection))
%>					