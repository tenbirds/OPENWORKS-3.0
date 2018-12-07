<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "naracntrct_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "naracntrct_cloud" );
		resultColCnt = search_col.w3GetResultCount("naracntrct_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 나라장터 계약정보 검색결과 -->
		<h3>나라장터 계약정보 <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			
			<%
				for(int idx=0; idx < resultColCnt; idx++){
	                String CNTRCT_UNION_NO = search_col.w3GetField("naracntrct_cloud","CNTRCT_UNION_NO",idx);
					String URL    = "http://www.g2b.go.kr:8067/contract/contDetail.jsp?Union_number="+CNTRCT_UNION_NO;
					String Data1 = search_col.w3GetField("naracntrct_cloud", "REGIST_DT", idx)+ " ";
					//Data1 = Data1.substring(0, 10);
					//http://www.g2b.go.kr:8067/contract/contDetail.jsp?Union_number=<c:out value="${baseVo.cntrctUnionNo}"
			%>
			<tr>
				<td>
					<ul>
						<li>
					<dt><a href="<%=URL%>" target="_blank"><%=search_col.w3GetField("naracntrct_cloud", "TITLE", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dt>
					<dd>
						<a href="#">
							<!-- 
							계약일자 : <% //parseDate(search_col.w3GetField("naracntrct_cloud", "REG_DATE", idx), "yyyyMMddHHmmss", "yyyy/MM/dd") %> ,
							 --> 
							계약일자 : <%=parseDate(search_col.w3GetField("naracntrct_cloud", "REG_DATE", idx), "yyyyMMddHHmmss", "yyyy/MM/dd") %> ,
							<!--  
							계약금액 : <%// numberFormat(Integer.parseInt(search_col.w3GetField("naracntrct_cloud", "CNTRCT_ITEM_AMT", idx))) %>
							 --> 
							 계약금액 : <%
							 		String CNTRCT_ITEM_AMT = search_col.w3GetField("naracntrct_cloud", "CNTRCT_ITEM_AMT", idx);
							 		//out.print(CNTRCT_ITEM_AMT+"<--");
							 		long CNTRCT_ITEM_AMT_LONG = Long.parseLong(CNTRCT_ITEM_AMT) ;
							 		out.println(numberFormat(CNTRCT_ITEM_AMT_LONG));
							 		%>
						<br />
							계약기관 : <%=search_col.w3GetField("naracntrct_cloud", "ORDER_ORGN_NM", idx) %>
						<br />
							수요기관 : <%=search_col.w3GetField("naracntrct_cloud", "REAL_ORGN_NM", idx) %>
						</a>
					</dd>
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
		<!-- //나라장터 계약정보 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('naracntrct_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "naracntrct_cloud".equals(collection)){ %>
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
		    <h3>나라장터 계약정보 <i>0</i>건</h3>
			<p>검색결과가 없습니다.</p></div>
			<br /><br />
<%
		}
	}//if("ALL".equals(collection) ||  "naracntrct".equals(collection))
%>					