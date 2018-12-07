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
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript">
	   
	$(document).ready(function() {
		
		 $.datepicker.setDefaults({
           dateFormat:"yymmdd",
           showOn : 'button',
           buttonImageOnly : true,
           buttonImage : '<c:url value="/resources/web/theme/default/images/btn/btn_calendar.gif" />',
           buttonText: "날짜선택",
           yearRange: "2010:+1",
           showOptions: { direction: "up"}
       });
		 
       $('#beginDate').datepicker();
       $('#endDate').datepicker();
       
	 });
		// 페이지 이동
	   	var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	  	}; 
  	
		// 게시판 등록
	   var jsCmPlanInsert = function(){
		    if(validation.dataForm() === false){
	        	return;
	   		}
		    //alert($("#beginHm").val());
		    //alert($("#endHm").val());
		    if ( confirm(Message.msg.chkInsert) ) {
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmUserPlanInsert.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	                if (response == "true") {
	   	                 	alert(Message.msg.chkCmBoardInsertOk);  
		                    jrMove("BD_cmUserPlanList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
		               } else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
	   	            }
	   	        });
	      	 }
		 };
		
		// 게시판 수정
		var jsCmPlanUpdate = function(schdulSeq){
		    if(validation.dataForm() === false){
	        	return;
	   		}
		  
		    if ( confirm(Message.msg.chkModify) ) {
		        $("#schdulSeq").val(schdulSeq);
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmUserPlanUpdate.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	                if (response == "true") {
	   	                 	alert(Message.msg.chkCmBoardUpdateOk);  
		                    jrMove("BD_cmUserPlanView.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
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
	    		       
	    		       
	    		       if($("#schdulSj").val() == ""){
	    		           	//alert("제목을 입력 하시지 않았습니다.");
	    		           	alert(Message.msg.chkCmBoardbbscttSj);
	                       	$("#schdulSj").focus();
	    		            return false;
	    		       } 
						
	    		     //시작일
	                   if($("#beginDate").val() == "") {
	                       alert("시작일을 입력하십시요.");
	                       $("#beginDate").focus();
	                       return false;
	                       
	                   }
	                   //종료일
	                   if($("#endDate").val() == "") {
	                       alert("종료일을 입력하십시요.");
	                       $("#endDate").focus();
	                       return false;
	                       
	                   }
	    		       if($("#beginDate").val() > $("#endDate").val() || $("#beginDate").val().replace(/-/gi,"") > $("#endDate").val().replace(/-/gi,"")){
	                       alert("시작일이 종료일보다 뒤에 날짜로 올수 없습니다.");
	                       $("#beginDate").focus();
	                       return false;
	                   }

	    		     //시작시간 - 시간
	                   if($("#beginH").val() == "") {
	                       alert("00~12시까지의 시간을 입력하십시요.");
	                       $("#beginH").focus();
	                       return false;
	                       
	                   }
	                   //시작시간 - 시간
	                   if($("#beginH").val() != "") {
	                       if($("#beginH").val() > 12) {
	                           alert("00~12시까지의 시간을 입력하십시요.");
	                           $("#beginH").focus();
	                           return false;
	                       }

	                       if($("#beginH").val().length != 2) { 
	                           $("#beginH").val("0"+$("#beginH").val());
	                       }
	                   }
	                   
	                   //시작시간 - 분
	                   if($("#beginM").val() == "") {
	                       alert("00~59분까지의 시간을 입력하십시요.");
	                       $("#beginM").focus();
	                       return false;
	                       
	                   }
	                   //시작시간 - 분
	                   if($("#beginM").val() != "") {
	                       if($("#beginM").val() > 59 ) {
	                           alert("00~59분까지의 시간을 입력하십시요.");
	                           $("#beginM").focus();
	                           return false;
	                       } 

	                       if($("#beginM").val().length != 2) {
	                           $("#beginM").val("0"+$("#beginM").val());
	                       }
	                   }
	                   //종료시간 - 시간
	                   if($("#endH").val() == "") {
	                       alert("00~12시까지의 시간을 입력하십시요.");
	                       $("#endH").focus();
	                       return false;
	                       
	                   }
	                   //종료시간 - 시간
	                   if($("#endH").val() != "") {
	                       if($("#endH").val() > 12) { 
	                           alert("00~12시까지의 시간을 입력하십시요.");
	                           $("#endH").focus();
	                           return false;
	                       }

	                       if($("#endH").val().length != 2) {
	                           $("#endH").val("0"+$("#endH").val());
	                       }
	                   }
	                   //종료시간 - 분
	                   if($("#endM").val() == "") {
	                       alert("00~59분까지의 시간을 입력하십시요.");
	                       $("#endM").focus();
	                       return false;
	                       
	                   }
	                   //종료시간 - 분
	                   if($("#endM").val() != "") {
	                       if($("#endM").val() > 59 ) {
	                           alert("00~59분까지의 시간을 입력하십시요.");
	                           $("#endM").focus();
	                           return false;
	                       }

	                       if($("#endM").val().length != 2) {
	                           $("#endM").val("0"+$("#endM").val());
	                       }
	                   }
	                   
	                   if($("#schdulCn").val()  == ""){
	    		           alert(Message.msg.chkCmBoardbbscttCn);
	                       $("#schdulCn").focus();
	                       return false;
	                   }

	                   $("#beginHm").val($("#beginH").val() + $("#beginM").val());
	                   $("#endHm").val($("#endH").val() + $("#endM").val());
	    		   }
	    	};
		    
		//숫자만 입력 받게끔 하는 함수.
		var onlyNum = function(obj) {
		    if ((event.keyCode >= 48 && event.keyCode <= 57) ||   //숫자열 0 ~ 9 : 48 ~ 57
		        (event.keyCode >= 96 && event.keyCode <= 105) ||  //키패드 0 ~ 9 : 96 ~ 105
				 event.keyCode == 8  || event.keyCode == 46 ||    //BackSpace, Delete
				 event.keyCode == 37 || event.keyCode == 39 ||    //좌 화살표, 우 화살표
				 event.keyCode == 35 || event.keyCode == 36 ||    //End 키, Home 키
				 event.keyCode == 9  || event.keyCode == 45)    {    //Tab 키
		        return true;
			    }else{
			     $(obj).val("");
			     alert(Message.msg.numberOnly);
			     return false;   
			    // $("#"+id).val("");
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
	<form name="dataForm" id="dataForm" method="post" >
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
		<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
		<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/>
		<input type="hidden" id="beginHm" name="beginHm" value=""/>
        <input type="hidden" id="endHm"   name="endHm"   value=""/>
        <input type="hidden" id="schdulSeq" name="schdulSeq" value="<c:out value="${cmUserPlanView.schdulSeq}"/>" />
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<!-- view -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:20%">
						<col style="width:*">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit">제목</td>
							<td class="last"><input type="text" id="schdulSj" name="schdulSj" title="제목 입력" value="<c:out value='${cmUserPlanView.schdulSj }'/>" class="input" style="width:570px;"/></td>
						</tr>
						<tr>
							<td class="tit">시작일</td>
							<td class="last">
								<div class="calendar_input">
									<input type="text" class="input" id="beginDate" name="beginDate" title="검색 시작일 입력" onkeydown="return onlyNum(this);" readonly="readonly"<c:if test="${not empty cmUserPlanView.beginDate}">value="<c:out value='${cmUserPlanView.beginDate}'/>"</c:if><c:if test='${not empty param.beginDate }'>value="<c:out value='${param.beginDate}'/>"</c:if> style="width:205px;"/>
								</div>
								<select id="beginTimeSe" name="beginTimeSe" title="시작일 오전/오후 선택" class="calendar" style="width:88px;">
									<option value="A" <c:if test="${empty cmUserPlanView.beginTimeSe or cmUserPlanView.beginTimeSe eq 'A' or param.beginTimeSe eq 'A'}">checked="checked"</c:if>>오전</option>
									<option value="P" <c:if test="${empty cmUserPlanView.beginTimeSe or cmUserPlanView.beginTimeSe eq 'P' or param.beginTimeSe eq 'P'}">checked="checked"</c:if>>오후</option>
								</select>
								<input type="text" class="input" id="beginH" name="beginH" title="시작일 시 선택"  <c:if test="${not empty cmUserPlanView.beginHm }">value="${fn:substring(cmUserPlanView.beginHm,0,2)}"</c:if>class="calendar" style="width:80px;" maxlength="2" onkeydown="return onlyNum(this);"> 시
								<input type="text" class="input" id="beginM" name="beginM" title="시작일 분 선택"<c:if test="${not empty cmUserPlanView.beginHm }">value="${fn:substring(cmUserPlanView.beginHm,2,4)}"</c:if> class="calendar" style="width:80px;" maxlength="2" onkeydown="return onlyNum(this);"> 분
							</td>
						</tr>
						<tr>
							<td class="tit">종료일</td>
							<td class="last">
								<div class="calendar_input">
									<input type="text" class="input" id="endDate" name="endDate" title="검색 종료일 입력" onkeydown="return onlyNum(this);" readonly="readonly" <c:if test="${not empty cmUserPlanView.endDate}">value="<c:out value='${cmUserPlanView.endDate}'/>"</c:if><c:if test='${not empty param.endDate }'>value="<c:out value='${param.endDate}'/>"</c:if> style="width:205px;">
								</div>
								<select id="endTimeSe" name="endTimeSe" title="종료일 오전/오후 선택" class="calendar" style="width:88px;">
									<option value="A" <c:if test="${empty cmUserPlanView.endTimeSe or cmUserPlanView.endTimeSe eq 'A' or param.endTimeSe eq 'A'}">checked="checked"</c:if>>오전</option>
									<option value="P" <c:if test="${empty cmUserPlanView.endTimeSe or cmUserPlanView.endTimeSe eq 'P' or param.endTimeSe eq 'P'}">checked="checked"</c:if>>오후</option>
								</select>
								<input type="text" class="input" id="endH" name="endH" title="종료일 시 선택" class="calendar" <c:if test="${not empty cmUserPlanView.endHm }">value="${fn:substring(cmUserPlanView.endHm,0,2)}"</c:if> style="width:80px;" maxlength="2" onkeydown="return onlyNum(this);" /> 시
								<input type="text" class="input" id="endM" name="endM" title="종료일 분 선택" class="calendar" <c:if test="${not empty cmUserPlanView.endHm }">value="${fn:substring(cmUserPlanView.endHm,2,4)}"</c:if> style="width:80px;" maxlength="2" onkeydown="return onlyNum(this);" /> 분
							</td>
						</tr>
						<tr>
							<td colspan="2"><textarea id="schdulCn" name="schdulCn" style="width:725px; height:360px;" onkeyup="javascript:displayBytes(1000,'schdulCn');"  onblur="javascript:displayBytes(1000,'schdulCn');" ><c:out value="${cmUserPlanView.schdulCn }" escapeXml="false"/></textarea></td>
						</tr>
						
						<tr>
							<td class="tit">공개 설정</td>
							<td class="last">
								<input type="radio" id="othbcSetupCd1" name="othbcSetupCd" value="1001" <c:if test="${cmUserPlanView.othbcSetupCd == '1001' || cmUserPlanView.othbcSetupCd == null }"> checked="checked" </c:if>/><label for="all" class="space">전체 공개</label>
								<input type="radio" id="othbcSetupCd2" name="othbcSetupCd" value="1002" <c:if test="${cmUserPlanView.othbcSetupCd == '1002' }"> checked="checked" </c:if>/><label for="member">멤버 공개</label>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //view -->

				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmUserPlanList.do?cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
					</div>
					<div class="btn_r">
						<c:if test="${empty cmUserPlanView }" >
						<div class="btn_navi_g"><a href="#none" onclick="jsCmPlanInsert();"><span class="disk">저장</span></a></div>
						</c:if>
						<c:if test="${not empty cmUserPlanView }" >
						<div class="btn_navi_g"><a href="#none" onclick="jsCmPlanUpdate('<c:out value="${cmUserPlanView.schdulSeq}"/>');"><span class="disk">수정</span></a></div>
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
