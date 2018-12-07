<%@page import="zes.openworks.web.store.StoreincVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="zes.core.utils.Converter"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>연관솔루션</title>
	<%-- <op:jsTag type="openworks" items="store-core" /> --%>
	
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>
	<script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>
	<script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
	<script type="text/javascript">
	
	 
	    var jsView = function(vl){
	        $("#goodsCode").val(vl);
	        document.dataForm.action = "BD_storeView.do";
	        document.dataForm.target = "_parent";
	        document.dataForm.submit();
	        jsClose();
	    };
	    
	
	    //페이지 이동
	    var jsMovePage = function(page) {
	        var p = 1;
	        if(page == 'page') {
	            p = $('input[name=page]').val();
	        } else {
	            p = page;
	        }
	        $("#dataForm #q_currPage").val(p);
	        $("#dataForm").submit();
	
	    };
	    
	    var jsSeller = function(userId) {
	        $("#userId").val(userId);
	        document.dataForm.action = "../BD_goodsOfSeller.do";
	        document.dataForm.elements["q_currPage"].value = "1";
	        document.dataForm.target = "_parent";
	        document.dataForm.submit();
	        jsClose();
	    };
	</script>
</head>

<body class="winPopup qna">
  			
	<form name="dataForm" id="dataForm" method="get" action="INC_relation.do"> 
		<input type="hidden" name="goodsCode" id="goodsCode" value="${searchMap.goodsCode}" />
		<input type="hidden" name="tab" id="tab"   value="<%=Converter.XSS(request.getParameter("tab"))%>" />
		<input type="hidden" name="pageUrlNm" id="pageUrlNm" value="${searchMap.pageUrlNm}" />
		<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='${searchMap.q_currPage}'/>"/>
		<input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value='${searchMap.q_sortName}'/>" />
		<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value='${searchMap.q_sortOrder}'/>"/>
		<input type="hidden" name="userId" 			id="userId"	 value="">	
	
		<c:if test="${not empty pager.list}">
		<c:forEach items="${pager.list}" var="_goodsList" varStatus="status">
			<c:set var="goodImage" value="${_goodsList.itemImgUrl}" />
			<a href="#" onclick="jsView('${_goodsList.goodsCode}');">
				<c:if test="${not empty dataVo.itemImgUrl}">
					 <c:set var="goodImage" value="${_goodsList.itemImgUrl}"/>
				</c:if> 
				<c:if test="${ empty _goodsList.itemImgUrl}">
					 <c:set var="goodImage" value="${_goodsList.imageFile[0].fileUrl}" />
				</c:if>
				<img src="${goodImage}" alt="${_goodsList.goodsNm}" width="150" >
			</a>
		</c:forEach>
		</c:if>
		<op:no-data obj="${pager}" colspan="4" />
		<!-- //list -->
		
		<%-- !-- paging -->
		<div class="paging">
			<op:pager pager="${pager}" page="pager/webPager.jsp"/>
		</div>
		<!-- //paging --> --%>
	</form>

</body>
</html>