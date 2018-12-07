<%@ page contentType="text/html;charset=UTF-8" %>

<%
if("ALL".equals(collection) ||  "merge_software".equals(collection)){
	resultColTotalCnt = search_col.w3GetResultTotalCount( "merge_software" );
	resultColCnt = search_col.w3GetResultCount("merge_software");

	if(resultColTotalCnt > 0){
%>
	    <!-- 소프트웨어 검색결과 -->
		<p>소프트웨어<strong><%=resultColTotalCnt %></strong>건</p>
		<!-- list -->
		<div class="type-thumb">
<%
		String GOODS_ID = "";
		for(int idx=0; idx < resultColCnt; idx++){
			String DOCID = search_col.w3GetField("merge_software","DOCID",idx);
			String URL   = "/korean/m/store/inc/BD_storeView.do?goodsCode=" +DOCID;
			String MARK_IMG = search_col.w3GetField("merge_software","MARK_IMG",idx);
			String[] MARK_IMG_ARRAY = null;
			MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");
					
			if(GOODS_ID==""){
				GOODS_ID = DOCID;
			}else{
				GOODS_ID = GOODS_ID + "," + DOCID;	
			}
%>
		    <ul>
			    <li class="cont">
				    <dl>
					    <dt><a href="<%=URL%>">
					            <!-- 서비스명 -->
					            <%=search_col.w3GetField("merge_software", "GOODSNM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %>
					            <!-- //서비스명 -->
					            <!-- 제조사 -->
					            <span><%=search_col.w3GetField("merge_software", "LANGSTORENM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></span>
					            <!-- //제조사 -->
					        </a>
					    </dt>
					    <!-- 서비스설명 -->
						<dd>
						    <a href="<%=URL%>">
						        <%=search_col.w3GetField("merge_software", "GOODSSUMRY", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %>
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

		<!-- paging -->
		<div class="paging">
			<%=getPageLinks(startCount, resultColTotalCnt, 10,10) %>
		</div>
		<!-- //paging -->
<%	
		}else{
%>
            <p>소프트웨어<strong>0</strong>건</p>
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
	}//if("ALL".equals(collection) ||  "merge_software".equals(collection))
%>
