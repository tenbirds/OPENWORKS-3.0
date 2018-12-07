<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "narabid_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "narabid_cloud" );
		resultColCnt = search_col.w3GetResultCount("narabid_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 소프트웨어 검색결과 -->
		<h3>나라장터 입찰정보<i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			
			<%
				for(int idx=0; idx < resultColCnt; idx++){
	                String BIDNO      = search_col.w3GetField("narabid_cloud","BID_NOTIFY_NO",idx);
	                String BIDSEQ	  = search_col.w3GetField("narabid_cloud","BID_NOTIFY_SEQ_NO",idx);
					String URL        = "http://www.g2b.go.kr:8081/ep/invitation/publish/bidInfoDtl.do?bidno="+BIDNO+"&bidseq="+BIDSEQ;
					String Data1 = search_col.w3GetField("narabid_cloud", "REGIST_DT", idx);
					//Data1 = Data1.substring(0, 10);
			%>
			<tr>
				<td>
					<ul>
						<li>
							<dt><a href="<%=URL%>" target="_blank"><%=search_col.w3GetField("narabid_cloud", "TITLE", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dt>
							<dd><a href="#">
							게시일자(마감일자) : <%=search_col.w3GetField("narabid_cloud", "BID_STRT_DATE", idx) %>(<%=search_col.w3GetField("narabid_cloud", "BID_END_DATE", idx) %>)
							<br />
							공고기관 : <%=search_col.w3GetField("narabid_cloud", "ORDER_ORGN_NM", idx) %>
							<br />
							수요기관 : <%=search_col.w3GetField("narabid_cloud", "REAL_ORGN_NM", idx) %>
							</a>
						</li>
					</ul>
				</td>
				<td>
				<%=Data1%>
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
			<a href="javascript:doCollection('narabid_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "narabid_cloud".equals(collection)){ %>
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
		    <h3>나라장터 입찰정보 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "narabid".equals(collection))
%>					