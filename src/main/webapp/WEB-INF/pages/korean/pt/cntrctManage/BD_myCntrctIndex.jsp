<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>게시물 목록</title>

	<op:jsTag type="spi" items="datepicker, cookie" />
<%-- 	<op:jsTag type="openworks" items="ui" /> --%>

	<!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>


	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">	
	$().ready(function(){
	    
	});
	
    var jsMovePage = function(page) {
        $("#dataForm input[name=q_currPage]").val(page);
        document.dataForm.action = "BD_myCntrctIndex.do";
        document.dataForm.submit();
    };
    

    var jsCntrWrite = function() {
        document.location.href = "BD_myCntrctForm.do";
    };

    var jsCntrctView = function(vl){
        $("#cntrctSn").val(vl);
        document.dataForm.action = "BD_myCntrctView.do";
        document.dataForm.submit();
    };
    
    var jsSearchReset = function() {
        $("#dataForm input[name=q_searchVal]").val("");
        $("#dataForm input[name=q_currPage]").val(1);
        document.dataForm.action = "BD_myCntrctIndex.do";
        document.dataForm.submit();
    };
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>

	<!-- 검색 폼 -->
	<form name="dataForm" id="dataForm" method="get" onsubmit="return false;">
		<!-- 기본 검색 사항 -->
		<input type="hidden" name="q_currPage" id="q_currPage" value="${searchMap.q_currPage}" />
		<input type="hidden" name="q_searchKey" id="q_searchKey" value="1002" />
		<input type="hidden" name="cntrctSn" id="cntrctSn" value="-1" />
		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
			<div class="title-area">
				<h2>계약관리</h2>
			</div>
			<!-- //title-area -->

			<!-- section -->
			<div class="section">
				<div class="tab-search">
					<table>
						<caption>검색</caption>
						<colgroup>
						<col style="width:130px;"/>
						<col style="width:;"/>
						</colgroup>
						<tbody>
							<tr>
								<th>서비스명</th>
								<td><input type="text" class="w650" id="q_searchVal" name="q_searchVal" title="검색어 입력" value="<c:out value='${searchMap.q_searchVal}'/>" /></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- //section -->
			
			<!-- btn-area -->
			<div class="btn-area mt10 ar">
				<a href="#" class="b-btn search type2" onclick="jsMovePage(1); return false;"><strong><span>검 색</span></strong></a>
				<a href="#" class="b-btn ml10 type1" onclick="jsSearchReset(); return false;"><strong><span>전체보기</span></strong></a>
				
			</div>
			<!-- //btn-area -->
			
			<!-- section -->
			<div class="section">
				<a href="#" class="b-btn mt20 fr type3" onclick="jsCntrWrite(); return false;"><strong><span>계약서 등록</span></strong></a>
				<h3 class="stitle"></h3>
				<p class="total-count">총 <strong><c:out value='${pager.totalNum}'/></strong>개</p>
				<!-- list -->
				<div class="type-list">
					<table>
						<caption>계약관리 내역</caption>
						<colgroup>
							<col style="width:60px;"/>
							<col style="width:*;"/>
							<col style="width:170px;"/>
							<col style="width:130px;"/>
							<col style="width:130px;"/>
							<col style="width:70px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>서비스명</th>
								<th>계약기간</th>
								<th>구매기관</th>
								<th>판매기관</th>
								<th>계약서</th>
							</tr>
						</thead>
						<tbody>
	                        <c:set var="index" value="${pager.indexNo}"/>
	                        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
							<tr>
	                        	<!-- 번호(필수) -->
	                            <td><c:out value="${index-status.index}"/></td>
	                            <!-- 서비스명 -->
	                            <td class="title">
                                    <a href="#" onclick="jsCntrctView('<c:out value='${baseVo.cntrctSn}'/>'); return false;">
	                                    <c:out value="${baseVo.svcNm}"/>
	                                </a>
	                            </td>
	                            <!-- 계약기간 -->
	                            <td>
	                            	<fmt:parseDate var="cntrctBeginDe" value="${baseVo.cntrctBeginDe}" pattern="yyyyMMdd" />
		                        	<fmt:parseDate var="cntrctEndDe" value="${baseVo.cntrctEndDe}" pattern="yyyyMMdd" />
		                        	<fmt:formatDate value="${cntrctBeginDe}" type="both" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${cntrctEndDe}" type="both" pattern="yyyy-MM-dd"/>
	                           	</td>
	                           	<!-- 구매기관 -->
	                           	<td><c:out value='${baseVo.purchsInsttNm}'/></td>
	                           	<!-- 판매기관 -->
	                           	<td><c:out value='${baseVo.sleInsttNm}'/></td>
	                           	<!-- 계약서 -->
	                           	<td style="align:center;">
		                        	<c:if test="${not empty baseVo.ctrtcFile[0]}">
			                        	<c:set var="fileVo" value="${baseVo.ctrtcFile[0]}" />
				                        <a href="/component/file/ND_fileDownload.do?id=<c:out value='${fileVo.fileId}'/>" title="<c:out value='${fileVo.localNm}'/>">
				                        	<img src="/new_cloud/images/icon-btn/Note.png" alt="계약서" style="width:15px;" />
				                    	</a>
			                    	</c:if>
		                        </td>
					       </tr>
				           </c:forEach>
				           <!-- 데이터가 없을 때 알림 문구 -->
					       <c:if test="${empty pager.list}">
						       <op:no-data obj="${pager}" colspan="6" />
					       </c:if>
						</tbody>
					</table>
				</div>
				<!-- //list -->

				<!-- paging -->
				<div class="paging">
					<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
				</div>
				<!-- //paging -->
			</div>
			<!-- //section -->

		</div>
		<!-- //contents -->
	</form>
</body>
</html>