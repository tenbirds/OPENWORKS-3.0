<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "introduction_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "introduction_cloud" );
		resultColCnt = search_col.w3GetResultCount("introduction_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 소개 검색결과 -->
		<h3>소개 <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			<%
				for(int idx=0; idx < resultColCnt; idx++){
					
					String URL = search_col.w3GetField("introduction_cloud","USER_MENU_URL",idx);
					String Data1 = search_col.w3GetField("introduction_cloud", "REGIST_DT", idx);
					Data1 = Data1.substring(0, 10);
			%>
			<tr>
				<td>
					<ul>
						<li>
							<dd><a href="<%=URL%>"><%=search_col.w3GetField("introduction_cloud", "BODY_CNTNTS", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dd>
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
		<!-- //소개 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('introduction_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "introduction_cloud".equals(collection)){ %>
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
		    <h3>소개 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "introduction".equals(collection))
%>					