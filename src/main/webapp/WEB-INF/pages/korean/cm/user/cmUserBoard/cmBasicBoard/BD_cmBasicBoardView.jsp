]<%@ page language="java" contentType="text/html; charset=UTF-8"
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
		    $.ajax({
		        url : "INC_cmBasicBoardCMT.do",
		        dataType : "html",
		        type : "post",  // post 또는 get
		        data : { cmmntyId:"<c:out value="${cmUserMenuView.cmmntyId}"/>", langCode:"<c:out value="${cmUserMenuView.langCode}"/>", 
		            cmmntyMenuCode:"<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>", cmmntyBbsSeq:"<c:out value="${userBoardView.cmmntyBbsSeq}"/>"},   // 호출할 url 에 있는 페이지로 넘길 파라메터
		        //(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId){
		        success : function(result){
		            $("#replyDiv").html(result);
		        }
		    });
		});
		
		// 페이지 이동
	   	var jrMove = function(movepage){
		    
		   	// $("#cmmntyMenuCode").val();		
		   	// alert( $("#cmmntyMenuCode").val());
		   	//$("#cmmntyMenuCode").val("<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>");
		   	 $("#dataForm").attr("action",movepage).submit();
	  	}; 

	  	var jsUserBoardUptForm = function(cmmntyBbsSeq){
	  	    
	  	  	var movepage = "BD_cmBasicBoardForm.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	
	        $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
	  	
		var jsUserBoardMoveView = function(cmmntyBbsSeq){
	  	    
	  	  	var movepage = "BD_cmBasicBoardView.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>";
	  	  	
	        $("#cmmntyBbsSeq").val(cmmntyBbsSeq);
	        $("#dataForm").attr("action",movepage).submit();
	    };
	  	var jsUserBoardDelete = function(cmmntyBbsSeq, atchFileSeq){
	  	  if ( confirm(Message.msg.deleteConfirm) ) {
	  	  	$("#cmmntyBbsSeq").val(cmmntyBbsSeq);
		    $("#atchFileSeq").val(atchFileSeq);
		    $("#dataForm").ajaxSubmit({
		            url      : "INC_cmBasicBoardDelete.do",
		            type     : "POST",
		            dataType : "text",
		            async    : false,
		            success  : function(response){
		                if(response == "true"){
		                    alert(Message.msg.chkCmBoardDeleteOk);  
		                    jrMove("BD_cmBasicBoardList.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
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

	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq}"/>"/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value=""/>
	<input type="hidden" id="formSeq" name="formSeq" value=""/>
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
	</form>
			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<!-- view -->
				<table class="tbl_detail_view">
					<colgroup>
						<col style="width:*">
						<col style="width:35%">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit"><c:out value="${userBoardView.bbscttSj }"/> </td>
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
								<span class="name"><strong><c:out value='${userBoardView.wrterNcnm}'/></strong></span><span class="inquiry">조회수 <c:out value="${userBoardView.rdcnt }"/></span>
<%-- 								<c:if test="${cmInfo.userId == userBoardView.registId }"><strong>운영자</strong></c:if></span><span class="inquiry">조회수 <c:out value="${userBoardView.rdcnt }"/></span> --%>
							</td>
							<td>
								<div class="cont_r">
									<span class="file"><c:forEach items="${userBoardView.cmUserBoardFileCollection}" var="fileData" varStatus="status">
									<a href="/component/file/ND_fileDownload.do?id=<c:out value="${fileData.fileId}"/>" title="<c:out value='${fileData.fileDesc}'/>"><c:out value="${fileData.localNm }"/></a> (<c:out value="${fileData.fileSize }"/>)</span><span class="download">다운로드 <em><c:out value="${fileData.downCnt }"/></em><br/>
                           			 </c:forEach></span>
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
				<div id="replyDiv"></div>
				<!-- //댓글 -->

				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmBasicBoardList.do?cmmntyMenuCode=<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
					</div>
					<c:if test="${cmInfo.userId == sessionScope['__usk'].userId ||   userBoardView.registId == sessionScope['__usk'].userId }">
					<div class="btn_r">
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardUptForm('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');"><span class="modify">수정</span></a></div>
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardDelete('<c:out value="${userBoardView.cmmntyBbsSeq }"/>', '<c:out value="${userBoardView.atchFileSeq }"/>');"><span class="trash">삭제</span></a></div>
					</div>
					</c:if>
				</div>
				<!-- //버튼 -->

				<!-- 이전글, 다음글 -->
				<table class="tbl_prevNext">
					<colgroup>
						<col style="width:15%">
						<col style="width:*">
						<col style="width:15%">
						<col style="width:18%">
					</colgroup>
					<tbody>
						<tr>
							<td><span class="prev">이전글</span></td>
							<c:if test="${userBoardView.prevVO.othbcSetupCd == 1004 and sessionScope['__usk'].userId != userBoardView.prevVO.registId and cmInfo.userId != sessionScope['__usk'].userId  }"><td colspan="3" class="t_al">비밀글입니다.</td></c:if>
							<c:if test="${userBoardView.prevVO.othbcSetupCd != 1004 || (userBoardView.prevVO.othbcSetupCd == 1004 and (sessionScope['__usk'].userId == userBoardView.prevVO.registId || cmInfo.userId == sessionScope['__usk'].userId  ))}">
							<c:if test="${not empty userBoardView.prevVO }" >
							<td class="t_al"><a href="#none" onclick="jsUserBoardMoveView('<c:out value="${userBoardView.prevVO.cmmntyBbsSeq }"/>');"><c:if test="${userBoardView.prevVO.othbcSetupCd == 1004}"><strong>[비밀글] </strong></c:if><c:out value="${userBoardView.prevVO.bbscttSj }"/></a></td>
							<td><c:out value="${userBoardView.prevVO.wrterNcnm }"/></td>
							<td class="date"><c:out value="${userBoardView.prevVO.registDt }"/></td>
							</c:if>
							<c:if test="${ empty userBoardView.prevVO}" >
							<td class="t_al">이전글이 없습니다.</td>
							<td></td>
							<td class="date"></td>
							</c:if>
							</c:if>
						</tr>
						<tr>
							<td><span class="next">다음글</span></td>
							<c:if test="${userBoardView.prevVO.othbcSetupCd == 1004 and sessionScope['__usk'].userId != userBoardView.prevVO.registId and cmInfo.userId != sessionScope['__usk'].userId  }"><td colspan="3" class="t_al">비밀글입니다.</td></c:if>
							<c:if test="${userBoardView.prevVO.othbcSetupCd != 1004 || (userBoardView.prevVO.othbcSetupCd == 1004 and (sessionScope['__usk'].userId == userBoardView.prevVO.registId || cmInfo.userId == sessionScope['__usk'].userId  ))}">
							<c:if test="${not empty userBoardView.nextVO }" >
							<td class="t_al"><a href="#none" onclick="jsUserBoardMoveView('<c:out value="${userBoardView.nextVO.cmmntyBbsSeq }"/>');"><c:if test="${userBoardView.prevVO.othbcSetupCd == 1004}"><strong>[비밀글] </strong></c:if><c:out value="${userBoardView.nextVO.bbscttSj }"/></a></td>
							<td><c:out value="${userBoardView.nextVO.wrterNcnm }"/></td>
							<td class="date"><c:out value="${userBoardView.nextVO.registDt }"/></td>
							</c:if>
							<c:if test="${ empty userBoardView.nextVO}" >
							<td class="t_al">다음글이 없습니다.</td>
							<td></td>
							<td class="date"></td>
							</c:if>
							</c:if>
						</tr>
					</tbody>
				</table>
				<!-- //이전글, 다음글 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->

</body>
</html>
