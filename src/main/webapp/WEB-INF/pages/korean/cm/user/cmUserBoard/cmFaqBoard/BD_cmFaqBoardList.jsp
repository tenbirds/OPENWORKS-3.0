<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%
	request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	String nowURL = request.getRequestURI().toString();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title><c:out value="${cmUserMenuView.cmmntyMenuNm}"/> | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript">
		$(document).ready(function() {
		    
		});
		// 페이지 이동
	   	var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	  	}; 
		//통합검색바
	    var jsSearchAction = function() {
			if( $("#q_searchKeyWord").val() == ""){
			    alert(Message.msg.chkSearchVal);
			    return;
			}
	        $('#q_currPage').val("1");
	        $("#dataForm").attr("action","BD_cmFaqBoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>").submit();
	    };
	    
	    var jsUserBoardWrite = function(){
	        jrMove("BD_cmFaqBoardForm.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
	    };
	    
  		var jsUserBoardUptForm = function(cmmntyMenuCode, cmmntyBbsSeq, registId){
	  	  	var movepage = "BD_cmFaqBoardForm.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	
	        $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
	  	
	  	var jsUserBoardDelete = function(cmmntyMenuCode, cmmntyBbsSeq, registId){
	  	  if ( confirm(Message.msg.chkMsDelete) ) {
	  	      $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	  	      $("#atchFileSeq").val(-1);
	  	      $("#cmmntyMenuCode").val(cmmntyMenuCode);
		      $("#dataForm").ajaxSubmit({
		            url      : "INC_cmFaqBoardDelete.do",
		            type     : "POST",
		            dataType : "text",
		            async    : false,
		            success  : function(response){
		                if(response == "true"){
		                    alert(Message.msg.chkCmBoardDeleteOk);  
		                    jrMove("BD_cmFaqBoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
		                }else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
		            }
		        });
	  	  }
		};
	    var jsMovePage = function(page) {
	        var p = 1;
	        if (page == 'page') {
	            p = $('input[name=page]').val();
	        } else {
	            p = page;
	        }
	        $("#dataForm input[name=q_currPage]").val(p);
	        $("#dataForm").submit();
	    };   
	</script>

</head>
<body>
	<form name="dataForm" id="dataForm" method="post" action="BD_cmFaqBoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value=""/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value=""/>
	<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value="${searchMap.q_currPage}"/>" />
	
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<div class="cont_wrap">
					<div class="selected">
						<select id="q_keyWordSearch" name="q_keyWordSearch" title="검색하실 키워드 선택" style="width:150px;">
							<option value="2001" <c:if test="${param.q_keyWordSearch == '2001'}"> selected="selected" </c:if>>제목 + 내용</option>
							<option value="2004" <c:if test="${param.q_keyWordSearch == '2004'}"> selected="selected" </c:if>>작성자</option>
						</select>
					</div>
					<div class="search">
						<input type="text" class="input" id="q_searchKeyWord" name="q_searchKeyWord" title="카테고리내 검색 단어 입력" value="<c:out value="${param.q_searchKeyWord}"/>" />
						<input type="button" class="btn" id="sech" name="sech" title="검색" onclick="jsSearchAction();" />
					</div>
					<div class="btn_org" ><c:if test="${cmInfo.userId == sessionScope['__usk'].userId && not empty  sessionScope['__usk'].userId}"><a href="#none" onclick="jsUserBoardWrite();">작성하기</a></c:if></div>
				</div>
				<span class="totalcount">
					총 <em class="tx_orange"><c:out value="${pager.totalNum}"/></em>
				</span>
				<table class="tbl_list">
					<caption>
						<strong>FAQ 게시판</strong>
						<details>
							<summary>번호, 제목 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:8%">
						<col style="width:*">
						<col style="width:15%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
					<c:forEach items="${pager.list}" var="data" varStatus="status">
						<tr class="item">
							<td><c:out value='${pager.indexNo - status.index}'/></td>
							<td class="t_al"><a href="#none" class="question"><c:out value='${data.bbscttSj}'/></a></td>
							<td class="function">
								<ul>
								<c:if test="${cmInfo.userId == sessionScope['__usk'].userId}">
									<li><a href="#none" onclick="jsUserBoardUptForm('<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>');">수정</a></li>
									<li><a href="#none" onclick="jsUserBoardDelete( '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>');">삭제</a></li>
								</c:if>
								</ul>
							</td>
						</tr>
						<!-- 활성화 -->
						<tr class="hide">
							<td colspan="3">
								<table class="tbl_list">
									<colgroup>
										<col style="width:100%">
									</colgroup>
									<tbody>
										<tr>
											<td><op:nrToBr content="${data.bbscttCn}" /></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<!-- //활성화 -->
						</c:forEach>
						<op:no-data obj="${pager}" colspan="3" msg="<strong>작성된 게시물이 없습니다.</strong>" />
					</tbody>
				</table>
				<!-- paging -->
				<op:pager pager="${pager}" page="pager/cmPager.jsp" />
				<!-- //paging -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form>
</body>
</html>
