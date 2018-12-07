<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
	<title>상세 계약내용리스트</title>
	
	
	<link rel="stylesheet" type="text/css" href="/cloud_ver2/new_cloud/css/v3_pop.css" />
	
	<op:jsTag type="spi" items="form,validate" />
	<op:jsTag type="openworks" />

<script type='text/javascript'>
	$(document).ready(function(){

	});
	
	var jsClose = function(){
        parent.$.fn.colorbox.close();
     };     
	
    var jsMovePage = function(page){
      	var p = 1;
      	if(page == 'page'){
          	p = $('input[name=page]').val();
      	}else{
          	p = page;
      	}
      	$("#dataForm input[name=q_currPage]").val(p);
      	$("#dataForm").submit();
    };
</script>
</head>

<body>
	<h2>상세 계약내용리스트 <button class="gray vm" onclick="jsClose();">닫기</button></h2>
<!-- 컨텐츠영역 -->
	<div id="contents">
		<form name="dataForm" id="dataForm" method="get" action="PD_contractList.do">
			<input type="hidden" id="svcNm"     name="svcNm"     value="${param.svcNm}"/>
			<input type="hidden" id="goodsCode" name="goodsCode" value="${param.goodsCode}"/>
			<input type="hidden" id="userId"    name="userId"    value="${param.userId}"/>
			<input type="hidden" id="goodsMakr" name="goodsMakr" value="${param.goodsMakr}"/>
		
       		<op:pagerParam title="상세 계약내용(${purchsInsttNm})리스트" />
       		
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
         <!-- 리스트 -->
	        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
	            <caption class="hidden"> 상세 계약내용리스트 </caption>
	            <colgroup>
	                <col width="4%"/>
	                <col width="10%"/>
	                <col width="*"/>
	                <col width="8%"/>
	                <col width="*"/>
	                <col width="10%"/>
	                <!-- col width="6%"/ -->
	                <col width="*"/>
	                <col width="10%"/>
	                <col width="5%"/>
	            </colgroup>
	            <thead>
	            	<tr>
		                <th>번호</th>	                
		                <th>사업명</th>
		                <th>판매서비스</th>
		                <th>계약체결일</th>
		                <th>계약기간</th>
		                <th>계약금액</th>
						<!-- th>판매수량</th -->
		                <th>구매기관</th>
		                <th>판매기관</th>
		                <th>계약서(PDF)</th>
	                </tr>
	            </thead>
	            <tbody id="odd-color">
	                <c:set var="index" value="${pager.indexNo}"/>
	                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	                    <tr>
	                        <td><c:out value="${index-status.index}"/></td>
	                        <td class="tx_l">${baseVo.svcNm}</td>
	                        <td class="tx_l">${baseVo.goodsNm}</td>
	                        <td>${baseVo.cntrDt}</td>
	                        <td><fmt:parseDate var="cntrctBeginDe" value="${baseVo.cntrctBeginDe}" pattern="yyyyMMdd" />
	                        	<fmt:parseDate var="cntrctEndDe" value="${baseVo.cntrctEndDe}" pattern="yyyyMMdd" />
	                        	<fmt:formatDate value="${cntrctBeginDe}" type="both" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${cntrctEndDe}" type="both" pattern="yyyy-MM-dd"/>
	                        </td>
	                        <td class="tx_r"><fmt:formatNumber value="${baseVo.cntrctamount}" groupingUsed="true"/></td>
	                        <%-- td class="tx_r"><fmt:formatNumber value="${baseVo.cntrCount}" groupingUsed="true"/></td --%>
	                        <td class="tx_l">${baseVo.purchsInsttNm}</td>
	                        <td class="tx_l">${baseVo.sleInsttNm}</td>
	                        <td>
	                        	<c:if test="${not empty baseVo.ctrtcFile[0]}">
		                        	<c:set var="fileVo" value="${baseVo.ctrtcFile[0]}" />
			                        <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">
			                        	<img src="/new_cloud/images/icon-btn/Note.png" width="20px"/>
			                    	</a>
		                    	</c:if>
	                        </td>
	                    </tr> 
	                </c:forEach>
	                <op:no-data obj="${pager}" colspan="9" />
	            </tbody>
	        </table>
        <!-- 페이징 -->
        	<op:pager pager="${pager}" />
		</form>
    </div>
    <!-- //컨텐츠영역 -->
</body>
</html>