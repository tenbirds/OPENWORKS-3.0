<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title></title>

	<op:jsTag type="spi" items=" datepicker, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">

	//카테고리 저장용
	bbsCtgAry = new Array();

	$().ready(function(){
		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		OpenWorks.pageType 			= "LIST";
		OpenWorks.boardNm				= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.boardType			= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.useCategory 	= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn 				= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.filePermExtsn = "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.captchaYn 		= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.tagYn 				= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.bbsNm		 			= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.bbsCd		 			= "<c:out value='${boardConfVo.bbsCd}'/>";
    OpenWorks.domainCd      = "<c:out value='${boardConfVo.domainCd}'/>";
		OpenWorks.searchVal			= "<c:out value='${param.q_searchVal}'/>";
		OpenWorks.searchKey			= "<c:out value='${param.q_searchKey}'/>";
		OpenWorks.sortName			= "<c:out value='${param.q_sortName}'/>";
		OpenWorks.sortOrder			= "<c:out value='${param.q_sortOrder}'/>";
		OpenWorks.startDt 			= "<c:out value='${param.q_startDt}'/>";
		OpenWorks.endDt   			= "<c:out value='${param.q_endDt}'/>";
		OpenWorks.showSummaryYn	= "<c:out value='${param.showSummaryYn}'/>";
		OpenWorks.serverNm 			= "http://" + "<%= request.getServerName() + ':' + request.getLocalPort() %>" + "<c:url value='/web/board/ND_convertAction.do' />";
		OpenWorks.isSession			= "<c:out value='${!empty __usk}'/>";

		onReadyEventFunctions();
		
		//검색 날짜 입력
		$('#q_startDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		$('#q_endDt').datepicker({ ctxRoot : CTX_PATH, buttonText: '달력'});
		
	});
	
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>

<body>

			<!-- contents -->
			<!-- 20161219  conWrap 추가-->
			<div class="contents conWrap">
			<!-- 검색 폼 -->			
			<form name="dataForm" id="dataForm" method="get" onsubmit="return jsSearch();" action="jsSearch();">
				<!-- 기본 검색 사항 -->
				<input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='' />" />
				<input type="hidden" name="bbsCd"  value="<c:out value='${param.bbsCd}' />" />
				<input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
				<input type="hidden" name="showSummaryYn" value="<c:out value='${param.showSummaryYn}' />" />
				<input type="hidden" name="pageType" value="<c:out value='' />" />
				<input type="hidden" name="delDesc" id="delDesc" value="<c:out value='' />" />
	      		<input type="hidden" name="q_ctgCd" id="q_ctgCd" value="<c:out value='${param.q_ctgCd}'/>" />
				<!-- title-area -->

				<div class="title-area">
					<c:if test="${boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1011 and boardConfVo.bbsCd ne 1031}">
						<!-- search -->	
						<c:choose>
							<c:when test="${domCd eq 1}">
				      			<%@include file="../common/INC_search.jsp" %>
				      		</c:when>
				      		<c:when test="${domCd eq 2}">
				      				<%@include file="../common/korean/INC_search.jsp" %>
				      		</c:when>
				    	</c:choose>
	        		</c:if>
					<!-- //search -->
				</div>
				<!-- //title-area -->
				
				<!-- section[1001:공지사항] -->
				<c:if test="${boardConfVo.bbsCd eq 1001 or boardConfVo.bbsCd eq 1011 or boardConfVo.bbsCd eq 1031}">
        			<c:if test="${boardConfVo.ctgYn eq 'Y'}">
				    	<div class="section notice">
					    	<!-- tab -->
					    	<div class="tab-area">
						    	<ul><!--  class="full" -->
						      	<li>
						      		<a href="#" onclick="jsCtgCdSelect('','');" class="${empty param.q_ctgCd ? 'on':'' }">전체</a></li><!-- 선택되었을때 클래스 on 적용 -->
 						        	<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
						          		<li><a href="#" onclick="jsCtgCdSelect('${ctgVo.ctgCd}','');" class="${param.q_ctgCd eq ctgVo.ctgCd ? 'on':'' }">${ctgVo.ctgNm}</a></li>
						        	</c:forEach>
<%-- 
									<li class="${empty param.q_ctgCd? 'on':''}">
										<a href="#" id="ctg0" onclick="jsCtgCdSelect('','');" class="${empty param.q_ctgCd? 'on':''}">전체</a>
									</li><!-- 선택되었을때 클래스 on 적용 -->
									<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
									<li class="${ctgVo.ctgCd eq param.q_ctgCd? 'on':''}">
										<a href="#" id="ctg${status.index+1}" onclick="jsCtgCdSelect('${ctgVo.ctgCd}','');" class="${ctgVo.ctgCd eq param.q_ctgCd? 'on':''}">${ctgVo.ctgNm}</a>
	                    			<ul id="depth${status.index+1}">
		                    		<c:forEach items="${ctgVo.aditCtgList}" var="aditCtgVo" varStatus="status">
			                    	<c:if test="${ctgVo.ctgCd == aditCtgVo.ctgCd}">
			                        <li><a href="#" id="aditctg_${aditCtgVo.aditCtgCd}_${aditCtgVo.ctgCd}" onclick="jsCtgCdSelect('${aditCtgVo.ctgCd}','${aditCtgVo.aditCtgCd}');" class="${(aditCtgVo.ctgCd eq param.q_ctgCd && aditCtgVo.aditCtgCd eq param.q_aditCtgCd)? 'on':''}">${aditCtgVo.aditCtgNm}</a></li>
			                    	</c:if>
		                    		</c:forEach>
	                    			</ul>
									</li>
									</c:forEach>
 --%>
									</li>
						    	</ul>
						    	<span>
						        	<c:if test="${not empty paggingTitle}">
							        	${paggingTitle},
						        	</c:if>
						        <%-- 총<strong>${pager.totalNum}</strong>개 --%>
						    	</span>											
					    </div>
					    <!-- //tab -->

						<!-- search -->	
						<c:choose>
							<c:when test="${domCd eq 1}">
			      				<%@include file="../common/INC_search.jsp" %>
			      			</c:when>
			      			<c:when test="${domCd eq 2}">
			      				<%@include file="../common/korean/INC_search.jsp" %>
			      			</c:when>
			    		</c:choose>
			        					    
					    <!-- list -->
					    <%@include file="korean/INC_board.list.jsp" %>
					    <!-- //list -->
					    
					    <!-- 페이징 -->
					    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
					    <!-- //페이징 -->
				    </div>
				    </c:if>
                </c:if>
			    <!-- //section[1001:공지사항] -->
					
			    <!-- section[1001:공지사항/1009:성공사례 아닌건] -->
			    <c:if test="${boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1009 and boardConfVo.bbsCd ne 1011 and boardConfVo.bbsCd ne 1031}">
				    <div class="section">
					    <!-- list -->
					    <%@include file="korean/INC_board.list.jsp" %>
					    <!-- //list -->
					    
					    <!-- 페이징 -->
	           		    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
	           		    <!-- //페이징 -->					
				    </div>
			    </c:if>
			    <!-- //section[1001:공지사항/1009:성공사례 아닌건] -->
					
			    <!-- section[1009:성공사례] -->
			    <c:if test="${boardConfVo.bbsCd eq 1009}">
				    <div class="section mt20">
					    <!-- list -->
					    <%@include file="korean/INC_board.list.jsp" %>
					    <!-- //list -->
					    
					    <!-- 페이징 -->
					    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq"/>
	           		    <!-- //페이징 -->					
				    </div>
			    </c:if>
			    <!-- //section[1009:성공사례] -->

			    <!-- 20161220 버튼위치 리스트하단으로 변경요청 -->
				<!-- INC_search.jsp 버튼영역 -->
					<!-- 작성하기버튼사용안함 bbsCd=1001, 1002, 1003,1004, 1007, 1009, 1011, 1012, 1019, 1023,1024 -->
			        <c:if test="${(boardConfVo.bbsCd ne 1001) and (boardConfVo.bbsCd ne 1002) and (boardConfVo.bbsCd ne 1003) 
			        and (boardConfVo.bbsCd ne 1004) and (boardConfVo.bbsCd ne 1007) and (boardConfVo.bbsCd ne 1009) 
			        and (boardConfVo.bbsCd ne 1011) and (boardConfVo.bbsCd ne 1012) and (boardConfVo.bbsCd ne 1019)
			        and (boardConfVo.bbsCd ne 1023) and (boardConfVo.bbsCd ne 1024) and (boardConfVo.bbsCd ne 1025) 
			        and (boardConfVo.bbsCd ne 1027) and (boardConfVo.bbsCd ne 1026) and (boardConfVo.bbsCd ne 1029)
			        and (boardConfVo.bbsCd ne 1030) and (boardConfVo.bbsCd ne 1031)
			       }">
			       <%-- <c:if test="${sessionScope['UserId'] eq 'niacloud'}"> --%>
			        <div class="btnArea rig"><%-- ${sessionScope['__usk']} --%>
			            <span class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');" style="cursor: pointer;">작성하기</span>
			            <!-- <a href="#" class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');">작성하기</a> -->
			        </div>
			        <%-- </c:if> --%>
				    </c:if>
				    
				    <c:if test="${boardConfVo.bbsCd eq 1003}">
				    <div class="btnArea rig">
				    	<span class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');" style="cursor: pointer;">질문하기</span>
			        	<!-- <a href="#" class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');">질문하기</a> -->
			        </div>
			        </c:if>      
			    <!-- // INC_search.jsp 버튼영역 -->

			    <!-- BD_board.list.jsp 버튼영역 -->		    
		        <c:if test="${boardConfVo.bbsCd eq '1004'}">
			        <div class="btnArea rig">
			        <%-- <c:if test="${boardConfVo.bbsCd eq 1030}"> --%>
			        	<span class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');" style="cursor: pointer;">작성하기</span>
			        	<!-- <a href="#" class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');">작성하기</a> -->
			        <%-- </c:if> --%>
				    </div>
			    </c:if>
			    <%-- 행사 및 이벤트 작성하기 삭제 
			    <c:if test="${boardConfVo.bbsCd eq '1007'}">
			        <div class="btnArea rig">					      
			        	<a href="#" class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');">작성하기</a>						    						    				        							    
				    </div>
			    </c:if> 
			    --%>
			    <c:if test="${boardConfVo.bbsCd eq '1011'}">
			    	<c:if test="${not empty sessionScope['__usk']}">
			    		<c:if test="${sessionScope['MEM_TYPE'] eq '1001' || sessionScope['MEM_TYPE'] eq '2001' || sessionScope['MEM_TYPE'] eq '3001'}">
							<div class="btnArea rig">
								<span class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');" style="cursor: pointer;">작성하기</span>
			        		<!-- <a href="#" class="btns st1 icn icnWrite" onclick="jsInsertForm('INSERT');">작성하기</a> -->	
				    		</div>
				    	</c:if>
				    </c:if>
			    </c:if>
			    <!-- // BD_board.list.jsp 버튼영역 -->	
			    		
			</form>
		</div>		
	<!-- //contents -->							
    <c:if test="${boardConfVo.bbsCd eq 1001 }">
	</div>
	<!-- //container -->
    </c:if>		
</body>
</html>