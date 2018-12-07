<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	//변경소스
	request.setAttribute("SubDomain", "korean");
	//}}

	String nowURL = request.getRequestURI().toString();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>

<c:if test="${empty sessionScope['__usk'].userId}">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		//}}
	</script> 
</c:if>
<c:if test="${cmInfo.userId != sessionScope['__usk'].userId}">
<c:if test="${userBoardView.othbcSetupCd == '1002' }">
	<c:if test="${cmMberInfo.cmmntyMberId != sessionScope['__usk'].userId }">
 	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//}}
	</script> 
	</c:if>
	<c:if test="${empty cmMberInfo.cmmntyMberId }">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";		
		//}}
		
	</script>
	</c:if>
	
</c:if>
</c:if>
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
	  	
		//문의 수정 페이지로 이동
		var jsUserBoardUptForm = function(cmmntyBbsSeq){
	  	    
	  	  	var movepage = "BD_cmQnABoardForm.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	
	        $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
	    //질문 삭제 (답변도 삭제됨)
	    var jsUserBoardDelete = function(cmmntyBbsSeq, atchFileSeq){
		  	  if ( confirm(Message.msg.chkCmBoardQDelete) ) {
		  	  	$("#cmmntyBbsSeq").val(cmmntyBbsSeq);
			    $("#atchFileSeq").val(atchFileSeq);
			    $("#dataForm").ajaxSubmit({
			            url      : "INC_cmQnABoardDelete.do",
			            type     : "POST",
			            dataType : "text",
			            async    : false,
			            success  : function(response){
			                if(response == "true"){
			                    alert(Message.msg.chkCmBoardDeleteOk);  
			                    jrMove("BD_cmQnABoardList.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
			                }else { 
			                   alert(Message.msg.processFail);
			                   return;
			               }
			            }
			        });
		  	  }
			};
			// 답변 삭제
		    var jsUserBoardAnswerUpdate = function(){

			    if ( confirm(Message.msg.chkCmBoardADelete) ) {
		 	        $("#dataForm").ajaxSubmit({
		   	            url      : "INC_cmQnABoardAnswerUpdate.do?delAnswer=N",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	                if (response == "true") {
		   	                 	alert(Message.msg.chkCmBoardADeleteOk);  
			                    jrMove("BD_cmQnABoardView.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
			               } else { 
			                   alert(Message.msg.processFail);
			                   return;
			               }
		   	            }
		   	        });
		      	 }
			};
		 var jsUserBoardAnswerView = function(cmmntyId, cmmntyMenuCode, cmmntyBbsSeq, registId){
		     	movepage ="BD_cmQnABoardAnsWerView.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
		     	$('#cmmntyBbsSeq').val(cmmntyBbsSeq);
		  		$("#dataForm").attr("action",movepage).submit();
		    }
	</script>

</head>
<body>

		<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/> 
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq}"/>"/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value=""/>
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2>Q&amp;A 게시판</h2>
				<!-- view -->
				<table class="tbl_detail_view">
					<colgroup>
						<col style="width:*">
						<col style="width:35%">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit"><c:out value="${userBoardView.bbscttSj }"/></td>
							<td>
								<div class="cont_r">
									<span class="date"><c:out value="${userBoardView.registDt }"/></span>
									<ul class="function">
										<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   userBoardView.registId == sessionScope['__usk'].userId }">
										<li><a href="#none" onclick="jsUserBoardUptForm('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');">수정</a></li>
										<li><a href="#none" onclick="jsUserBoardDelete('<c:out value="${userBoardView.cmmntyBbsSeq }"/>', '<c:out value="${userBoardView.atchFileSeq }"/>');">삭제</a></li>
										</c:if>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<span class="name"><c:if test="${ cmInfo.userId != userBoardView.registId}"><c:out value='${userBoardView.wrterNcnm}'/></c:if>
								<c:if test="${cmInfo.userId == userBoardView.registId }"><strong>운영자</strong></c:if></span><span class="inquiry">조회수 <c:out value="${userBoardView.rdcnt }"/></span>
							</td>
							<td>
								<div class="cont_r"><c:forEach items="${userBoardView.cmUserBoardFileCollection}" var="fileData" varStatus="status">
									<span class="file"><a href="/component/file/ND_fileDownload.do?id=${fileData.fileId}" title="${fileData.fileDesc}"><c:out value="${fileData.localNm }"/></a> (<c:out value="${fileData.fileSize }"/>)</span>
									<span class="download">다운로드 <em><c:out value="${fileData.downCnt }"/></em><br/></span></c:forEach>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="txt_view">
								<p><op:nrToBr content="${userBoardView.bbscttCn}" /></p>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //view -->

				<!-- 댓글 -->
				<div class="reply_box">
					<div class="comment_area">
						<!-- 댓글 리스트 -->
						<div class="comment_list" style="display: block;">
							<ul>
								<!-- 댓글 내용 -->
								<li>
									<div class="cont_l">
									<c:if test="${not empty userBoardView.answerId }" >
										<c:if test="${ cmInfo.userId != userBoardView.answerId}"><strong><c:out value='${userBoardView.answerNcnm}'/></strong></c:if><c:if test="${cmInfo.userId == userBoardView.answerId }"><strong>운영자</strong></c:if>
										<span class="date"><c:out value="${userBoardView.answerDt }"/></span>
									</c:if>
									</div>
									<div class="cont_r">
										<ul>
										<c:if test="${not empty userBoardView.answerId }" >
										<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   userBoardView.answerId == sessionScope['__usk'].userId }">
											<li><a href="#none" onclick="jsUserBoardAnswerView('<c:out value="${cmUserMenuView.cmmntyId}"/>','<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>','<c:out value='${userBoardView.cmmntyBbsSeq}'/>','<c:out value='${userBoardView.answerId}'/>');" >수정</a></li>
											<li><a href="#none" onclick="jsUserBoardAnswerUpdate('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');">삭제</a></li>
										</c:if>
										</c:if>
										</ul>
									</div>
								</li>
								<li class="comment">
								<c:if test="${empty userBoardView.answerId }" >
									답변이 등록되지 않았습니다.
								</c:if>
								<c:if test="${not empty userBoardView.answerId }" >
									<op:nrToBr content="${userBoardView.answerCn}" />
								</c:if>
								</li>
								<!-- //댓글 내용 -->
							</ul>
						</div>
						<!-- //댓글 리스트 -->
					</div>
				</div>
				<!-- //댓글 -->

				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmQnABoardList.do?cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')" ><span class="list">목록</span></a></div>
					</div>
					<div class="btn_r">
					<c:if test="${empty userBoardView.answerId }" >
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardAnswerView('<c:out value="${cmUserMenuView.cmmntyId}"/>','<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>','<c:out value='${userBoardView.cmmntyBbsSeq}'/>','<c:out value='${userBoardView.registId}'/>');"><span class="answer">답변작성</span></a></div>
					</c:if>
					<c:if test="${cmInfo.userId == sessionScope['__usk'].userId || userBoardView.registId == sessionScope['__usk'].userId }">
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardUptForm('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');"><span class="modify">수정</span></a></div>
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardDelete('<c:out value="${userBoardView.cmmntyBbsSeq }"/>', '<c:out value="${userBoardView.atchFileSeq }"/>');"><span class="trash">삭제</span></a></div>
					</c:if>
					</div>
					
				</div>
				<!-- //버튼 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form>

</body>
</html>