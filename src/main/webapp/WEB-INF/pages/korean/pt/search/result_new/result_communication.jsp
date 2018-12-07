<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "communication_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "communication_cloud" );
		resultColCnt = search_col.w3GetResultCount("communication_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 지식 검색결과 -->
				<h3>지식 <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			<%
				for(int idx=0; idx < resultColCnt; idx++){
	                String DOCID      = search_col.w3GetField("communication_cloud","DOCID",idx);
	                String BBS_CD	  = search_col.w3GetField("communication_cloud","BBS_CD",idx);
					String SOURCENAME = search_col.w3GetField("communication_cloud","SOURCENAME",idx);
					String CMMNTY_ID  = search_col.w3GetField("communication_cloud","CMMNTY_ID",idx);
					String CTGRY_NM	  = search_col.w3GetField("communication_cloud","CTGRY_NM",idx);
					
					String  CATE_NM   = "" ; 
					String URL		  = "";
	            	if ("community".equals(SOURCENAME)) {
	            		CATE_NM = "홈 &gt; 지식 &gt; 커뮤니티 &gt; " + CTGRY_NM;
	            		URL = "/community/" + CMMNTY_ID;
	            	} else if ("communication".equals(SOURCENAME)) {
	            		CATE_NM = "홈 &gt; 지식 &gt; " + CTGRY_NM;
	            		URL ="/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID; 
	            	}
			%>
			<tr>
				<td>
					<ul>
						<li><%=CATE_NM %></li>
						<li>
							<dt><a href="<%=URL%>"><%=search_col.w3GetField("communication_cloud", "BBSCTT_SJ", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dt>
							<dd><a href="<%=URL%>"><%=search_col.w3GetField("communication_cloud", "BBSCTT_CN", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dd>
						</li>
					</ul>
				</td>
				<td>
				<%=search_col.w3GetField("communication_cloud", "REGIST_DT", idx) %>
				</td>
			</tr>
			<%
				}//for
			%>
			</table>
		</div>
		<!-- //list -->
		<!-- //지식 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('communication_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "communication_cloud".equals(collection)){ %>
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
		    <h3>지식 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "communication".equals(collection))
%>					