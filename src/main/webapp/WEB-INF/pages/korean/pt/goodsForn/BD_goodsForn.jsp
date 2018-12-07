<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<op:jsTag type="spi" items="datepicker" />
<op:jsTag type="openworks" items="ui" />
<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">

  //페이지 이동
  var jsMovePage = function(page){
      $("#q_currPage").val(page);
      document.dataForm.method = "get";
      document.dataForm.action = "BD_goodsForn.do";
      document.dataForm.submit();
  }
</script>

<form name="dataForm" id="dataForm">
	<!-- contents -->
	<div class="contents overTrend">
		
	<!-- section -->
	<section class="lay_lnb swList">
			<p>				
				<table>
				<tr>
				<td width="*%"><op:pagerParam page="param/webListPagerParam.jsp" /><!-- 게시물 수 --></td>
				<td width="45%"><c:if test="${not empty pager.list[0].updateDt}">Digital Marketplace ${pager.list[0].updateDt} 까지 최신동향 데이터 입니다</c:if></td>
				</tr>
				</table>
			</p>
			<!-- 리스트 -->
			<dl>
				<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			
				<dt>
					<a href='<c:out value="${baseVo.fornLinkUrl}" />' target="_blank">
						<c:out value="${baseVo.fornGoodsNm}" /><!-- 서비스명 -->
					</a>
				</dt>
				<dd>
					<ul>
						<li>
							<c:out value="${baseVo.fornCmpnyNm}" /><!-- 회사명 -->
						</li>
						<li>
							<c:out value="${baseVo.fornGoodsSumry}" /><!-- 설명 -->
						</li>
						<li>
							<c:out value="${baseVo.fornKndNm}" /><!-- 분류명 -->
							<i><c:out value="${baseVo.fornNote}" /></i><!-- 비고 -->
						</li>
					</ul>
				</dd>
			  	</c:forEach>
		     	<op:no-data obj="${pager}" colspan="2" />

			</dl>
						
			<!-- //list -->
			<!-- paging -->
		<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
		<!-- //paging -->
		</div>
	</section>
	<!-- //section -->
	<!--// content -->
		
</form>
