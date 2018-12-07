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
<c:if test="${userBoardView.othbcSetupCd == '1002' }">
	<c:if test="${cmMberInfo.cmmntyMberId != sessionScope['__usk'].userId}">
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
	<op:jsTag type="openworks" items="ckeditor" />
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
	    //삭제
	    var jsUserBoardDelete = function(cmmntyBbsSeq, atchFileSeq){
		  	  if ( confirm(Message.msg.deleteConfirm) ) {
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
			
			// 답변 등록
		    var jsUserBoardAnswerUpdate = function(){
			    if(validation.dataForm() === false){
		        	return;
		   		}
			    if ( confirm(Message.msg.chkCmBoardAnswerInsert) ) {
		 	        $("#dataForm").ajaxSubmit({
		   	            url      : "INC_cmQnABoardAnswerUpdate.do",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	                if (response == "true") {
		   	                 	alert(Message.msg.chkCmBoardAnswerInsertOk);  
			                    jrMove("BD_cmQnABoardView.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
			               } else { 
			                   alert(Message.msg.processFail);
			                   return;
			               }
		   	            }
		   	        });
		      	 }
			};
			
		   var validation = {     
	            /** ajax submit validation **/
	    		   dataForm : function() {
    		           if($("#answerCn").val()  == ""){
	    		           alert(Message.msg.chkCmBoardAnswerCn);
	                       $("#answerCn").focus();
	                       return false;
	                   }
	    		   }
		    };
			//글자수체크
		    var displayBytes  = function ( nm, id ){
		        var obj  = document.getElementById( id );
		            if (obj.value.bytes() > nm){
		                if (event.keyCode != '8'){
		                   // alert(nm+'바이트까지 입력이 가능합니다.'); 
		                    alert(nm+Message.msg.chkFormByteUntill );
		                }
		                obj.value = obj.value.substring(0, obj.value.length-10);
		            }
		            //eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
		    };
		    
		  //글자수체크 bytes 계산 속성 추가
		    String.prototype.bytes = function(){
		        var str = this;
		        var size = 0;
		        for (var i=0; i<str.length; i++){
		        	size += (str.charCodeAt(i) > 128) ? 2 : 1;
		        }
		        return size;
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
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
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
								<span class="name"><c:if test="${ cmInfo.userId != userBoardView.registId}"><strong><c:out value='${userBoardView.wrterNcnm}'/></strong></c:if>
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
							<td colspan="2" class="txt_view brb">
								<p><op:nrToBr content="${userBoardView.bbscttCn}" /></p>
							</td>
						</tr>
						<tr>
							<td colspan="2">
			                   	<textarea id="answerCn" name="answerCn" style="width:716px; height:173px;" onkeyup="javascript:displayBytes(1000,'answerCn');" ><c:out value="${userBoardView.answerCn }" escapeXml="false"/></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //view -->

				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmQnABoardList.do?cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
					</div>
					<div class="btn_r">
					<div class="btn_navi_g">
					<c:if test="${empty userBoardView.answerId }" >
					<a href="#none" onclick="jsUserBoardAnswerUpdate('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');" ><span class="answer">답변작성</span></a>
					</c:if>
					<c:if test="${not empty userBoardView.answerId }" >
					<c:if test="${ userBoardView.answerId  == sessionScope['__usk'].userId || userBoardView.registId == sessionScope['__usk'].userId }">
					<a href="#none" onclick="jsUserBoardAnswerUpdate('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');" ><span class="answer">답변수정</span></a>
					</c:if>
					</c:if>
					</div>
					<c:if test="${cmInfo.userId == sessionScope['__usk'].userId || userBoardView.registId == sessionScope['__usk'].userId }">
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardUptForm('<c:out value="${userBoardView.cmmntyBbsSeq }"/>');"><span class="modify">수정</span></a></div>
						<c:if test="${ cmInfo.userId == sessionScope['__usk'].userId  || userBoardView.registId == sessionScope['__usk'].userId }">
						<div class="btn_navi_g"><a href="#none" onclick="jsUserBoardDelete('<c:out value="${userBoardView.cmmntyBbsSeq }"/>', '<c:out value="${userBoardView.atchFileSeq }"/>');"><span class="trash">삭제</span></a></div>
						</c:if>
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
    