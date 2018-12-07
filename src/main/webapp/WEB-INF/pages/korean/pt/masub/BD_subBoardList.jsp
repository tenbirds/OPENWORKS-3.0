<%@page import="zes.core.lang.Validate"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript">
	$().ready(function(){

	});//ready end
	
	var jsSearch = function(){
		$('#q_currPage').val("1");
		$("#searchName").val($("#searchName").val().trim());
		$('#searchForm').submit();
    }
	
	var jsView = function(data){
	    if(data == "add"){
	        $("#userId").val();
	        $("#masubNum").val();
	    }else {
	        var dataArray = data.split(',');
	        $("#masubNum").val(dataArray[0]);
	        $("#userId").val(dataArray[1]);
	    }
	    $("#listForm").attr("action", "BD_subBoardForm.do").submit();
	}
	  
</script>
</head>

<body>
<div class="supAdm mstSub">
	<h3><i class="quot">마스터/서브간에 의견 공유를 위한 공간 입니다.</i></h3>
	<form id="searchForm" name="searchForm" method="post" action="BD_subBoardList.do">	
	<div class="schArea">
	    <span class="sel_box">
			<select name="searchCode" id="searchCode">
				<option value="title">제목/내용</option>
				<option value="user">작성자</option>
			</select><label for="searchCode"></label>
		</span>					
		<div>
			<label><input type="text" name="searchName" id="searchName" /></label>
		</div>
		<a href="#" onclick="jsSearch();" class="btns st5">검 색</a>
	</div>				
	</form>
	
	<form id="listForm" name="listForm" >
		<input type="hidden" id="masubNum" name="masubNum" value=""/>
		<input type="hidden" id="userId" name="userId" value=""/>
		<input type="hidden" id="status" name="status" value=""/>
		<div class="list_st1">
		<p class="head">
			<span class="totalcount">
	    	<op:pagerParam page="param/webListPagerParam.jsp" />
	 		</span>
		</p>
		
		<table class="tbl_st1" summary="의견공유 검색">
			<caption>의견공유</caption>
			<colgroup>
				<col width="5%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="row">번호</th>
					<th scope="row">제목</th>
					<th scope="row">작성자</th>
					<th scope="row">작성일</th>
					<th scope="row">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="index" value="${pager.indexNo}" />
	      			<c:forEach items="${pager.list}" var="data" varStatus="status">
						<tr>
							<td><c:out value="${data.seq}" /></td>
							<td class="tit">
								<a onclick='jsView("<c:out value='${data.masubNum}'/>,<c:out value='${data.userId}'/>");return false;' href="javascript:;"><c:out value='${data.masubTitle}'/></a>
							</td>
							<td>
								<c:out value="${data.userNm}" />
							</td>
							<td><c:out value="${data.masubEntrDate}" /></td>
							<td><c:out value="${data.masubSechCnt}" /></td>
						</tr>
				</c:forEach>
				<c:if test="${empty pager.list}">
					<tr>
						<td colspan="5">등록된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>								
	</div></form>	

	<!-- paging  -->
	<div class="paging">
		<span><op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" /></span>
	</div> 
	<!--// paging  -->

	<div class="btnArea lef">
		<a onclick='jsView("add");return false;' href="javascript:;" class="f_r btns st1 icn icnWrite">등록</a>
	</div>
</div>
</body>
</html>