<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
	<title>커뮤니티 폐쇄</title>
    <op:jsTag type="spi" items="form,validate,colorbox" />
	<op:jsTag type="openworks" items="form, validate, ui" />
	<script type="text/javascript">
		//<![CDATA[
           
           	$(document).ready(function(){	
           	    
           	 $("#browserType").val(getBrowserType());
           	 
			});
           
           	
           	// 브라우저 체크 
            var getBrowserType = function(){
             	  var agt = navigator.userAgent.toLowerCase();
             	  if (agt.indexOf("chrome") != -1) return 'Chrome'; 
             	  if (agt.indexOf("opera") != -1) return 'Opera'; 
             	  if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
             	  if (agt.indexOf("webtv") != -1) return 'WebTV'; 
             	  if (agt.indexOf("beonex") != -1) return 'Beonex'; 
             	  if (agt.indexOf("chimera") != -1) return 'Chimera'; 
             	  if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
             	  if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
             	  if (agt.indexOf("firefox") != -1) return 'Firefox'; 
             	  if (agt.indexOf("safari") != -1) return 'Safari'; 
             	  if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
             	  if (agt.indexOf("msie") != -1) return 'Internet Explorer';
             	  if (agt.indexOf("rv:11.0") != -1) return 'Internet Explorer';
             	  if (agt.indexOf("netscape") != -1) return 'Netscape'; 
             	  if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla'; 
            };
            
       	   var jsInsertSave = function(){
       	    	if(validation.dataForm() === false){
       	        	return;
       	   		}
       	    
	   	       	 if ( confirm("커뮤니티를 폐쇄 하시겠습니까?") ) {
	   		 	        $("#dataForm").ajaxSubmit({
	   		   	            url      : "INC_closeCmManageUpdate.do?applyClose=N",
	   		   	            type     : "POST",
	   		   	            dataType : "text",
	   		   	            success  : function(response) {
	   		   	                if (response == "true") {
	   		   	                    jsSuccessBox("커뮤니티를 폐쇄 처리 되었습니다.");
	   		   	              		jsCloseWin();
	   		   	              		parent.location.reload(); 
	   		   	                } else { 
	   		   	                    jsErrorBox("커뮤니티 폐쇄 처리 중 오류가 발생했습니다.");
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
         	//]]>
	</script>
</head>
<body>
<!-- 컨텐츠영역 -->
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${openCmManageView.cmmntyId}"/>" />
		<input type="hidden" id="userId" name="userId" value="<c:out value="${openCmManageView.userId}"/>" />
		<input type="hidden" id="langCode" name="langCode" value="<c:out value="${openCmManageView.langCode}"/>" />
		<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="2001"/> <!-- 커뮤티니 공지사항에 등록 -->
		<input type="hidden" id="mngrClsAt" name="mngrClsAt" value="Y" /> <!--   Y:관리자가 신청, N:운영자가 신청 -->
		<input type="hidden" id="browserType" name="browserType" value="" />
		<input type="hidden" id="type" name="type" value="pdt_nm"/>
	<div id="popup">
          <!-- 사유 -->
            
            <fieldset>
            <legend>폐쇄 사유</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
                <caption class="hidden"> 폐쇄 사유 </caption>
                <colgroup>
                    <col width="100%" />
<%--                     <col width="50%" /> --%>
                </colgroup>
                <tbody>
                <tr>
                    <td><p class="mar_t5 tx_13 tx_b">해당 커뮤니티를 폐쇄하시겠습니까?</p><br/>
                     <p class="mar_t5 tx_13 tx_c"><c:out value="${openCmManageView.cmmntyNm}"/></p>
                    </td>
                </tr>
                    <tr>
                        <td>
                        <h2 class="mar_t10">폐쇄 사유 <span class="float_r tx_red">( 커뮤니티 폐쇄 사유를 입력해주세요. )</span></h2>
                        <textarea id="cmmntyClsResn" name="cmmntyClsResn"  rows="8" class="w99_p" onkeyup="javascript:displayBytes(2000,'cmmntyClsResn');"  onblur="javascript:displayBytes(2000,'cmmntyClsResn');" ></textarea>
                        <p class="mar_t5"> ※ 입력하신 내용은 커뮤니티 게시판 공지로 등록됩니다. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span id="cmmntyClsResn_bytes">0</span>/2000 byte</p>
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