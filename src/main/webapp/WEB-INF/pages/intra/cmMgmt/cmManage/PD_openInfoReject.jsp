<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>커뮤니티 거절</title>
    <op:jsTag type="spi" items="form,validate,colorbox" />
	<op:jsTag type="openworks" items="form, validate, ui" />
	<script type="text/javascript">
		//<![CDATA[
           
           	$(document).ready(function(){	

			});
            
       	   var jsInsertSave = function(){
       	    	if(validation.dataForm() === false){
       	        	return;
       	   		}
       	    
	   	       	 if ( confirm("커뮤니티 개설신청을 거절 하시겠습니까?") ) {
	   		 	        $("#dataForm").ajaxSubmit({
	   		   	            url      : "INC_openCmManageUpdate.do?confirm=N",
	   		   	            type     : "POST",
	   		   	            dataType : "text",
	   		   	            success  : function(response) {
	   		   	                if (response == "true") {
	   		   	                    jsSuccessBox("개설신청이 거절 되었습니다.");
	   		   	              		jsCloseWin();
	   		   	              		parent.location.reload(); 
	   		   	                } else { 
	   		   	                    jsErrorBox("거절 처리 중 오류가 발생했습니다.");
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
           		       if($("#confmRejectResn").val() == ""){
           		           		alert("거절 사유를 작성하세요!");
                              	$("confmRejectResn").focus();
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
         	//]]>
	</script>
</head>
<body>
<!-- 컨텐츠영역 -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${openCmManageView.cmmntyId}"/>" />
		<input type="hidden" id="userId" name="userId" value="<c:out value="${openCmManageView.userId}"/>" />
		<input type="hidden" id="langCode" name="langCode" value="<c:out value="${openCmManageView.langCode}"/>" />
		<input type="hidden" name="type" id="type" value="pdt_nm"/>
	<div id="popup">
          <!-- 사유 -->
            
            <fieldset>
            <legend> 거절 사유 등록하기</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 거절 사유 등록하기 </caption>
                <colgroup>
                    <col width="100%" />
                </colgroup>
                <tbody>
                    <tr>
                        <td>
                        <h2 class="mar_t10">거절 사유 <span class="float_r tx_red"> ( 거절 사유는 신청자에게 전달 됩니다. ) </span></h2>
                        <textarea id="confmRejectResn" name="confmRejectResn"  rows="8" class="w99_p" onkeyup="javascript:displayBytes(2000,'confmRejectResn');"  onblur="javascript:displayBytes(2000,'confmRejectResn');" ></textarea>
                        <p class="mar_t5" >- 필수 입력 항목 입니다. <span class="float_r"><span id="confmRejectResn_bytes">0</span>/2000 byte</span> </p>
                        <p class="mar_t5" >- 2000 byte 이상을 초과할 수 없습니다. </p>
                        
                        </td> 
                    </tr>
                </tbody>
            </table>
            </fieldset>
            <!-- //사유 -->
        <p class="tx_c mar_t20">
			<a href="#"><button type="button" onclick="jsInsertSave()" class="blue">확인</button></a>
			<a href="#"><button type="button" onclick="jsCloseWin();" class="blue">닫기</button></a>
		</p>
	</div>
	</form>
</body>
</html>