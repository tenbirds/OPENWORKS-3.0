<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "biddingnotice_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "biddingnotice_cloud" );
		resultColCnt = search_col.w3GetResultCount("biddingnotice_cloud");
		if(resultColTotalCnt > 0){
%>
		<!-- 입찰공고 검색결과 -->
		<h3>입찰공고 <i><%=resultColTotalCnt %></i>건</h3>
		<!-- list -->
		<div>
			<table class="list">
			
			<%
				for(int idx=0; idx < resultColCnt; idx++){
	                String NOTIFY_NUM = search_col.w3GetField("biddingnotice_cloud","NOTIFY_NUM",idx);
	                String NOTIFY_SEQ = search_col.w3GetField("biddingnotice_cloud","NOTIFY_SEQ",idx);
					String URL    = "http://www.ceart.kr/korean/pt/bidSttus/BD_bidSttusDetailView.do";
					       URL = URL + "?p_notifyNum="+NOTIFY_NUM;
					       URL = URL + "&p_notifySeq="+NOTIFY_SEQ;
					
					//Data1 = Data1.substring(0, 10);
					//http://www.g2b.go.kr:8067/contract/contDetail.jsp?Union_number=<c:out value="${baseVo.cntrctUnionNo}"
			%>
			<tr>
				<td>
					<ul>
						<li>
					<dt><a href="<%=URL%>" target="_blank"><%=search_col.w3GetField("biddingnotice_cloud", "BID_NOTIFY_NM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a></dt>
					<dd>
						<a href="#">
							공고번호 : <%=search_col.w3GetField("biddingnotice_cloud", "VIEW_NOTIFY", idx) %> 
							</br>
							접수일시 : <%=search_col.w3GetField("biddingnotice_cloud", "STRT_DT", idx) %>, 
							마감일시 : <%=search_col.w3GetField("biddingnotice_cloud", "CLSE_DT", idx) %>,
						</a>
					</dd>
						</li>
					</ul>
				</td>
				<td>
				
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
			<a href="javascript:doCollection('biddingnotice_cloud');"class="btns st1">더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "biddingnotice_cloud".equals(collection)){ %>
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