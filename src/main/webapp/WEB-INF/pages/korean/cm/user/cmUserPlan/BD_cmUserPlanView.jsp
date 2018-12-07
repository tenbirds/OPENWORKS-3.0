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
<c:if test="${cmInfo.userId != sessionScope['__usk'].userId}">
<c:if test="${cmUserPlanView.othbcSetupCd == '1002' }">
	<c:if test="${cmMberInfo.cmmntyMberId != sessionScope['__usk'].userId}">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
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
</c:if>
</c:if>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title><c:out value="${cmUserMenuView.cmmntyMenuNm}"/> | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript" >
		$(document).ready(function() {
		});
		// 페이지 이동
	   	var jrMove = function(movepage){

		   	 $("#dataForm").attr("action",movepage).submit();
	  	}; 
	  	
		// 게시판 수정
		var jsUserPlanUptForm = function(schdulSeq){
	  	    
	  	  	var movepage = "BD_cmUserPlanForm.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	alert
	        $("#schdulSeq").val(schdulSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
		var jsUserPlanDelete = function(schdulSeq){
		  	  if ( confirm(Message.msg.chkMsDelete) ) {
		  	  	$("#schdulSeq").val(schdulSeq);
			    $("#dataForm").ajaxSubmit({
			            url      : "INC_cmUserPlanDelete.do",
			            type     : "POST",
			            dataType : "text",
			            async    : false,
			            success  : function(response){
			                if(response == "true"){
			                    alert(Message.msg.chkCmBoardDeleteOk);  
			                    jrMove("BD_cmUserPlanList.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
			                }else { 
			                   alert(Message.msg.processFail);
			                   return;
			               }
			            }
			        });
		  	  }
			};
	</script>
</head>
<body>
	<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/> 
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	<input type="hidden" id="schdulSeq" name="schdulSeq" value="<c:out value="${cmUserPlanView.schdulSeq}"/>"/>

		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<table class="tbl_view">
					<colgroup>
						<col style="width:20%">
						<col style="width:*">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit">제목</td>
							<td class="last"><c:out value="${cmUserPlanView.schdulSj }"/></td>
						</tr>
						<tr>
							<td class="tit">시작일</td>
							<td class="last"><c:out value='${cmUserPlanView.sY}'/>.<c:out value='${cmUserPlanView.sM}'/>.<c:out value='${cmUserPlanView.sD}'/><c:if test="${cmUserPlanView.beginTimeSe eq 'A' }"> 오전</c:if><c:if test="${ cmUserPlanView.beginTimeSe eq 'P'}"> 오후</c:if> <c:out value="${fn:substring(cmUserPlanView.beginHm,0,2)}"/>시  <c:out value="${fn:substring(cmUserPlanView.beginHm,2,4)}"/>분</td>
						</tr>
						<tr>
							<td class="tit">종료일</td>
							<td class="last"><c:out value='${cmUserPlanView.eY}'/>.<c:out value='${cmUserPlanView.eM}'/>.<c:out value='${cmUserPlanView.eD}'/> <c:if test="${cmUserPlanView.endTimeSe eq 'A' }"> 오전</c:if><c:if test="${ cmUserPlanView.endTimeSe eq 'P'}"> 오후</c:if> <c:out value="${fn:substring(cmUserPlanView.endHm,0,2)}"/>시  <c:out value="${fn:substring(cmUserPlanView.endHm,2,4)}"/>분</td>
						</tr>
						<tr>
							<td colspan="2" class="cont_view"><op:nrToBr content="${cmUserPlanView.schdulCn}" /></td>
						</tr>
					</tbody>
				</table>
				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmUserPlanList.do?cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
					</div>
					<div class="btn_r">
					<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||  cmUserPlanView.registId == sessionScope['__usk'].userId }">
						<div class="btn_navi_g"><a href="#none" onclick="jsUserPlanUptForm('<c:out value="${cmUserPlanView.schdulSeq }"/>');"><span class="modify">수정</span></a></div>
						<div class="btn_navi_g"><a href="#none" onclick="jsUserPlanDelete('<c:out value="${cmUserPlanView.schdulSeq }"/>');" ><span class="trash">삭제</span></a></div>
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
