<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "customer_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "customer_cloud" );
		resultColCnt = search_col.w3GetResultCount("customer_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 고객센터 검색결과 -->
		<h3>고객센터 <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			<%
				for(int idx=0; idx < resultColCnt; idx++){
					
					String PROGRESS_YN = search_col.w3GetField("customer_cloud","PROGRESS_YN",idx);
	                String DOCID	   = search_col.w3GetField("customer_cloud","DOCID",idx);
	                String BBS_CD	   = search_col.w3GetField("customer_cloud","BBS_CD",idx);
					String URL		   = "";
	        	    if (PROGRESS_YN.length() > 0) {
	        	    	// 이벤트 항목은 항상 상세조회 할 수 있도록 수정[2016.01.29]
	        	    	PROGRESS_YN = "Y";
	        	    	URL = "/korean/pt/webevent/BD_eventView.do?eventSn=" + DOCID + "&flag=" + PROGRESS_YN;
	        	    } else {
	        	    	URL = "/web/board/BD_board.list.do?domainCd=2&bbsCd=" + BBS_CD;
	        	    }
			%>
			<tr>
				<td>
					<ul>
						<li><%=search_col.w3GetField("customer_cloud", "CTGRY_NM", idx) %></li>
							<a href="<%=URL%>"><%=search_col.w3GetField("customer_cloud", "BBSCTT_SJ", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %>
							<%=search_col.w3GetField("customer_cloud", "BBSCTT_CN", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						</li>
					</ul>
				</td>
				<td>
				<!-- 날짜 추가 시간까지 출력됨' -->
				<%=search_col.w3GetField("customer_cloud", "REGIST_DT", idx)%>
				</td>
			</tr>
			<%
				}//for
			%>
			</table>
		</div>
		<!-- //list -->
		<!-- //고객센터 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('customer_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "customer_cloud".equals(collection)){ %>
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
		    <h3>고객센터 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "customer".equals(collection))
%>					