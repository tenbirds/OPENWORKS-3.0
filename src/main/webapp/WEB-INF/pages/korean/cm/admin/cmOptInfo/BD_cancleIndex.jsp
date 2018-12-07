<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 폐쇄 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate, multifile, colorpicker" />
	<script type="text/javascript">
	
	var jsInsertSave = function(){
	       	 if ( confirm(Message.msg.chkCmCancle) ) {
	       	  var cmmntyId = $("#cmmntyId").val();
		 	        $("#dataForm").ajaxSubmit({
		   	            url      : "INC_closeCmOptInfoUpdate.do?applyClose=C",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	                if (response == "true") {
		   	                 	//alert("커뮤니티 폐쇄 처리가 취소 되었습니다.");
		   	                 	alert(Message.msg.chkCmCancleOk);
		   	                 	jrMove("BD_closeIndex.do?cmmntyId="+cmmntyId);
		   	                } else { 
		   	                 	alert("커뮤니티 폐쇄 처리 취소 중 오류가 발생했습니다.");
		   	                   	return;
		   	                }
		   	            }
		   	        });
	       	 }
  	};
  	
	  // 페이지 이동
	   var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	   };
  	</script>
	
	
	</head>
<body>
<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserView.cmmntyId}"/>" />
		<input type="hidden" id="userId" name="userId" value="<c:out value="${cmUserView.userId}"/>" />
		<input type="hidden" id="langCode" name="langCode" value="<c:out value="${cmUserView.langCode}"/>" />
		<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="2001"/> <!-- 커뮤티니 공지사항에 등록 -->
		<input type="hidden" id="mngrClsAt" name="mngrClsAt" value="N" /> <!--   Y:관리자가 신청, N:운영자가 신청 -->
		<!-- container -->
		<div id="container">
		<!-- side navigation bar -->
			<jsp:include page="/korean/cm/admin/cmOptAdminMenu/INC_cmOptAdminMenuLeft.do?menuCode=cmmntyclose&amp;cmmntyId=${cmUserView.cmmntyId}" flush="true"></jsp:include>
		<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2>커뮤니티 폐쇄</h2>
				<div class="postpone"> 
						<fmt:parseDate value='${cmUserView.cmmntyClsDt}' var='cmmntyClsDt' pattern="yyyy-MM-dd HH:mm" scope="page"/>
						<fmt:parseDate value='${cmUserView.cmmntyClsDt}' var='cmmntyClsDt2' pattern="yyyy-MM-dd HH:mm" scope="page"/>
						<fmt:parseDate value='${cmUserView.cmmntyClsReqstDt}' var='cmmntyClsReqstDt' pattern="yyyy-MM-dd HH:mm" scope="page"/>
					<div class="notice">현재 커뮤니티 <span class="day">폐쇄 보류기간</span>입니다.<br /><fmt:formatDate value="${cmmntyClsDt}" pattern="yyyy년 MM월 dd일"/>에 커뮤니티가 삭제 될 예정입니다.</div>
					<ul>
						<li><span>커뮤니티폐쇄 신청</span><fmt:formatDate value="${cmmntyClsReqstDt}" pattern="yyyy.MM.dd"/></li>
						<li><span>폐쇄 보류기간</span><fmt:formatDate value="${cmmntyClsReqstDt}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${cmmntyClsDt2}" pattern="yyyy.MM.dd" /></li>
						<li><span>커뮤니티 삭제일</span><span class="point"><fmt:formatDate value="${cmmntyClsDt}" pattern="yyyy.MM.dd"/></span></li>
					</ul>
					보류기간 중에는 커뮤니티 폐쇄 취소가 가능하나, 커뮤니티 삭제 후에는 복구가 불가능 합니다.<br />커뮤니티 폐쇄를 취소 하시려면, 커뮤니티 폐쇄 취소하기 버튼을 클릭해주세요.
				</div>
				<div class="btn_area">
					<div class="btn_org"><a href="#none" onclick="jsInsertSave();">커뮤니티 폐쇄 취소</a></div>
				</div>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
</form>

</body>
</html>