<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 폐쇄 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate, multifile, colorpicker" />
	<script type="text/javascript">
// 	 var cmmntyId = '<c:out value="${cmUserView.cmmntyId}"/>';
// 	 var cmmntySttusCd =  '<c:out value="${cmUserView.cmmntySttusCd}"/>';
	 $(document).ready(function() {

// 	     if(cmmntySttusCd == "1005"){
// 	         jrMove("BD_cancleIndex.do?cmmntyId="+cmmntyId);
// 	     }
	     
	 });
	var jsInsertSave = function(){
	    	if(validation.dataForm() === false){
	        	return;
	   		}
	    
	       	 if ( confirm(Message.msg.chkCmClose) ) {
	       	  
		 	        $("#dataForm").ajaxSubmit({
		   	            url      : "INC_closeCmOptInfoUpdate.do?applyClose=N",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	                if (response == "true") {
		   	                    alert(Message.msg.chkCmCloseOk);
		   	                 	jrMove("BD_cancleIndex.do?cmmntyId="+cmmntyId);
		   	                } else { 
		   	                 	alert("커뮤니티 폐쇄 처리 중 오류가 발생했습니다.");
		   	                   	return;
		   	                }
		   	            }
		   	        });
	       	 }
  	};
	
	var validation = {     
           /** ajax submit validation **/
   		   dataForm : function() {
   		       /** 지역변수 **/
   		       if($("#cmmntyClsResn").val() == ""){
   		           		alert("폐쇄 사유를 작성하세요!");
                      	$("cmmntyClsResn").focus();
   		           return false;
   		       }	
   		   }
	};
   	//글자수체크
    var displayBytes  = function ( nm, id ){
        var obj  = document.getElementById( id );
        if($("#type").val() == "pdt_nm") {
            if (obj.value.bytes() > nm){
                if (event.keyCode != '8'){
                    alert(nm+'바이트까지 입력이 가능합니다.');
                }
                obj.value = obj.value.substring(0, obj.value.length-10);
            } 
            
            eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
            
        }else{
        	eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
        }
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
		<input type="hidden" id="browserType" name="browserType" value="" />
		<input type="hidden" id="type" name="type" value="pdt_nm"/>
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
			<jsp:include page="/korean/cm/admin/cmOptAdminMenu/INC_cmOptAdminMenuLeft.do?menuCode=cmmntyclose&amp;cmmntyId=${cmUserView.cmmntyId}" flush="true"></jsp:include>
		<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2>커뮤니티 폐쇄</h2>
				<div class="postpone">
					커뮤니티를 폐쇄하시면 <span class="point">7일간의 보류 기간</span>을 거치며, 그 이후에는 커뮤니티의 모든 정보가 삭제 됩니다.<br />보류 기간중에는 커뮤니티 폐쇄를 취소하실 수 있으며, 커뮤니티 활동은 게시물 보기만 가능합니다.
					<div class="reason">
						커뮤니티 폐쇄 이유를 입력해주세요
						<textarea id="cmmntyClsResn" name="cmmntyClsResn"   onkeyup="javascript:displayBytes(2000,'cmmntyClsResn');"  onblur="javascript:displayBytes(2000,'cmmntyClsResn');"  style="width:723px; height:114px;"></textarea>
						<span class="byte"><em><span id="cmmntyClsResn_bytes">0</span></em>/1000byte</span>
					</div>
					입력하신 내용은 커뮤니티 게시판 공지로 등록됩니다.
				</div>
				<div class="btn_area">
					<div class="btn_org"><a href="#none" onclick="jsInsertSave();">커뮤니티 폐쇄</a></div>
				</div>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
		</form>
</body>
</html>
