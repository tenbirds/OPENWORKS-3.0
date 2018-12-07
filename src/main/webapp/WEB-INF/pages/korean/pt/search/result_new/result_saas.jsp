<%@ page contentType="text/html;charset=UTF-8" %>

<%
	if("ALL".equals(collection) ||  "saas_cloud".equals(collection)){
		resultColTotalCnt = search_col.w3GetResultTotalCount( "saas_cloud" );
		resultColCnt = search_col.w3GetResultCount("saas_cloud");
		if(resultColTotalCnt > 0){
%>
		<div class="section">
          	<dl class="search-result">	
              	<dt>
              		<!-- SaaS 검색결과 -->
              		<h3>SaaS <i><%=resultColTotalCnt %></i>건</h3>
<%-- 				 이전 소스 : 화면에서 제외된 소스		
						<c:if test="${not empty sessionScope['__usk']}">
							<c:if test="${sessionScope['MEM_CHK'] eq 'Y'}">
								<a href="#" class="b-btn cboxElement fr type6" onclick="jsWishPurch(this); return false;"><strong><span>구매희망목록에 담기</span></strong></a>
							</c:if>
							<c:if test="${sessionScope['MEM_CHK'] ne 'Y'}">
								<a href="javascript:;" class="b-btn fr disabled"><strong><span>구매희망목록에 담기</span></strong></a>
							</c:if>
						</c:if> 
					</p>--%>
					<input type="hidden" id="goodsTyCd" name="goodsTyCd" value="1002"/>
	              	<!-- 필터 적용 내용 출력 -->
     				<c:if test="${not empty selecItemNames}">
                     	<div>
                         	<p><strong>${fn:replace(fn:substring(selecItemNames,3,fn:length(selecItemNames)),'/','</strong>/<strong>')}</strong> 적용 결과 입니다.</p>
                     	</div>
                    </c:if>
     				<!-- //필터 적용 내용 출력 -->
              	</dt>
          	</dl>
      	</div>
      			        
		<!-- list -->
		<div>
			<table class="tbl_st7_schdtl">
				<thead>
					<tr>
						<th style="width:60px;"><input type="checkbox" id="all_check" /></th>
						<th style="width:184px;">서비스명</th>
						<th style="width:443px;">설명</th>
						<th style="width:106px;">등록일</th>
					</tr>
				</thead>
				<tbody>
			<%
				for(int idx=0; idx < resultColCnt; idx++){
					String DOCID = search_col.w3GetField("saas_cloud","DOCID",idx);
					String URL   = "/korean/pt/store/inc/BD_storeView.do?goodsCode=" +DOCID;
					String MARK_IMG = search_col.w3GetField("saas_cloud","MARK_IMG",idx);
					String[] MARK_IMG_ARRAY = null;
					MARK_IMG_ARRAY = MARK_IMG.split("\\|\\|");
					String REGISTDT = search_col.w3GetField("saas_cloud", "REGISTDT", idx);
					String USERID = search_col.w3GetField("saas_cloud", "USERID", idx);
					String GOODSMAINIMAGE = search_col.w3GetField("saas_cloud", "GOODSMAINIMAGE", idx);
			%>
				<c:set var="goosCode" value="<%=DOCID%>" />
				<c:set var="goosCodes" value="${goosCodes},${goosCode}" />
				<tr>
					<th rowspan="2"><input type="checkbox" name="goods_check" class="goods_check" value='<%=DOCID%>' /></th>
					<th rowspan="2" style="white-space:normal;">
						<a href="<%=URL%>" style="font-size:16px; color:#0186e1; word-break:keep-all;"><%=search_col.w3GetField("saas_cloud", "GOODSNM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						<img src="<%=GOODSMAINIMAGE%>" alt="서비스메인이미지" /></a>
					</th>
					<td style="white-space:normal;">
						<a href="#" onclick="jsSeller('<%=USERID%>');"><%=search_col.w3GetField("saas_cloud", "LANGSTORENM", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
						<a href="<%=URL%>"><%=search_col.w3GetField("saas_cloud", "GOODSSUMRY", idx).replaceAll("<!HS>","<em class=\"txt-word\">").replaceAll("<!HE>","</em>") %></a>
					</td>
					<td>
						<fmt:parseDate value='<%=REGISTDT%>' var='registDt' pattern="yyyyMMddHHmmss" scope="page"/>
						<i><fmt:formatDate value="${registDt}" pattern="yyyy-MM-dd"/></i>
					</td>
				</tr>
				<tr>
					<td>
						<!-- 마크 이미지 있을경우 -->
						<%
			                if (MARK_IMG.length() > 0 ) {
							    for (int i=0; i < MARK_IMG_ARRAY.length; i++) {
			            %>
						<img src="<%=MARK_IMG_ARRAY[i]%>" alt="markImg" />
			            <%
						        }
							}
			            %>
			            <!-- //마크 이미지 있을경우 -->
					</td>
					<td></td>
				</tr>
			<%
				}//for
			%>
				</tbody>
			</table>
			<input type="hidden" name="goodsCodeList" id="goodsCodeList" value="${goosCodes}" />
			<input type="hidden" name="selecItemNames" id="selecItemNames" value="${selecItemNames}"/>
		</div>
		<!-- //list -->
		<!-- //소프트웨어 검색결과 -->
		<%if(resultColTotalCnt > TOTALVIEWCOUNT && "ALL".equals(collection)){ %>
		<div class="btnArea rig">
			<a href="javascript:doCollection('saas_cloud');"class="btns st1">+ 더보기</a>
		</div>
		<%}else if(resultColTotalCnt > TOTALVIEWCOUNT && "saas_cloud".equals(collection)){ %>
		<!-- paging -->
		<div class="paging">
			<%=getPageLinks(startCount, resultColTotalCnt, 20,20) %>	
		</div>
		<%} %>
		<!-- //paging -->
<%	
		}else{
%>
		    <div class="contArea_wrap">
		    <h3>SaaS <i>0</i>건</h3>
		        <!-- 필터 적용 내용 출력 -->
		        <c:if test="${not empty selecItemNames}">
		            <div class="section">
			            <dl class="search-result">	
			                <dt>
		                        <div>
		                            <p><strong>${fn:replace(fn:substring(selecItemNames,3,fn:length(selecItemNames)),'/','</strong>/<strong>')}</strong> 적용 결과 입니다.</p>
		                        </div>
			                </dt>
			            </dl>
			        </div>
		        </c:if>
		        <!-- //필터 적용 내용 출력 -->
			<p>검색결과가 없습니다.</p></div>
<%
		}
	}//if("ALL".equals(collection) ||  "merge_software".equals(collection))
%>					