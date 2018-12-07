
<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "notice_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "notice_cloud" );
		resultColCnt = search_col.w3GetResultCount("notice_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 공지사항 검색결과 -->
		<h3>공지사항 <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			<%
				for(int idx=0; idx < resultColCnt; idx++){
					String DOCID      = search_col.w3GetField("notice_cloud","DOCID",idx);
					String BBS_CD	  = search_col.w3GetField("notice_cloud","BBS_CD",idx);
					String URL 		  = "/web/board/BD_board.view.do?domainCd=2&bbsCd=" + BBS_CD + "&bbscttSeq=" +DOCID;
					String Data1 = search_col.w3GetField("notice_cloud", "REGIST_DT", idx);
					Data1 = Data1.substring(0, 10);
					//http://www.seart.kr/web/board/BD_board.list.do?domainCd=2&bbsCd=1001
			%>
			<tr>
				<td>
					<ul>
					
						<li>
							<dt><a href="<%=URL%>"><%=search_col.w3GetField("notice_cloud", "BBSCTT_SJ", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dt>
							<dd><a href="<%=URL%>"><%=search_col.w3GetField("notice_cloud", "BBSCTT_CN", idx)%><%=search_col.w3GetField("notice", "BBSCTT_CN", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dd>
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
		<!-- //공지사항 검색결과 -->
		
		
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('notice_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "notice_cloud".equals(collection)){ %>
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
		    <h3>공지사항 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "notice".equals(collection))
%>					