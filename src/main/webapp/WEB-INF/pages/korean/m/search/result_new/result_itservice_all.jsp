<%@ page contentType="text/html;charset=UTF-8" %>

<%
if("ALL".equals(collection)){
    resultColTotalCnt = search_col.w3GetResultTotalCount( "consulting" );
	resultColCnt = search_col.w3GetResultCount("consulting");
	
	if(resultColTotalCnt > 0){
%>
	    <!-- IT서비스 검색결과 -->
		<p>IT서비스<strong><%=resultColTotalCnt %></strong>건</p>
		<!-- list -->
		<div class="type-thumb">
<%
        for(int idx=0; idx < resultColCnt; idx++){
			String DOCID = search_col.w3GetField("consulting","DOCID",idx);
			String URL   = "/korean/m/store/inc/BD_storeView.do?goodsCode=" +DOCID;
			String MARK_IMG = search_col.w3GetField("consulting","MARK_IMG",idx);
			String[] MARK_IMG_ARRAY = null;
			MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");
%>
		    <ul>
			    <li class="cont">
				    <dl>
					    <dt><a href="<%=URL%>">
					            <!-- 서비스명 -->
					            <%=search_col.w3GetField("consulting", "GOODSNM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %>
					            <!-- //서비스명 -->
					            <!-- 제조사 -->
					            <span><%=search_col.w3GetField("consulting", "LANGSTORENM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span>
					            <!-- //제조사 -->
					        </a>
					    </dt>
					    <!-- 서비스설명 -->
						<dd>
						    <a href="<%=URL%>">
						        <%=search_col.w3GetField("consulting", "GOODSSUMRY", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %>
						    </a>
						</dd>
						<!-- //서비스설명 -->
					</dl>
				</li>
				<!-- 마크 이미지 있을경우 -->
				<li class="add">
				    <span>
<%
                if (MARK_IMG.length() > 0 ) {
				    for (int i=0; i < MARK_IMG_ARRAY.length; i++) {
%>
						<img src="<%=MARK_IMG_ARRAY[i]%>" alt="markImg" />
<%
			        }
				}
%>
				    </span>
				</li>
				<!-- //마크 이미지 있을경우 -->
			</ul>
<%
		}//for
%>
			
		</div>
		<!-- //list -->

		<!-- //소프트웨어 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btn-area side mt10 ar">
			<a href="javascript:doCollection('consulting');"><strong><span>더보기</span></strong></a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "consulting".equals(collection)){ %>
		<!-- paging -->
		<div class="paging">
			<%=getPageLinks(startCount, resultColTotalCnt, 10,10) %>
		</div>
		<%} %>
		<!-- //paging -->
<%	
    }else{
%>
            <p>IT서비스<strong>0</strong>건</p>
            <div class="type-thumb">
		        <ul>
			        <li class="cont">
				        <dl>
					        <dt>검색결과가 없습니다.</dt>
					    </dl>
					</li>
			    </ul>
            </div>
<%
	}
}// end if
%>					